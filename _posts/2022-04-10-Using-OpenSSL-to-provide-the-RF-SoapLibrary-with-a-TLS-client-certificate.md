---
tags: testautomation testframeworks robotframework soaplibrary services web-services API SOAP authentication SSL TLS certificates openSSL
title: Using OpenSSL to provide the RF SoapLibrary with a TLS client certificate
comments_id: 11

---
<br>


<h1 class="post"> <a name="Introduction">Introduction</a> </h1>

In this day and age test automation engineers mostly design and code <a class="postanchor" href="https://en.wikipedia.org/wiki/Graphical_user_interface" target="_blank">Graphical User Interface</a> tests to execute them in a web browser. However, more and more teams are moving towards <a class="postanchor" href="https://en.wikipedia.org/wiki/API_testing" target="_blank">test automation at the service-level</a>, automating against some sort of <a class="postanchor" href="https://en.wikipedia.org/wiki/API" target="_blank">API</a>.

When we join such teams we will mostly encounter <a class="postanchor" href="https://en.wikipedia.org/wiki/Web_service" target="_blank">web services</a>, generally ones that are based on <a class="postanchor" href="https://en.wikipedia.org/wiki/SOAP" target="_blank">SOAP</a> or <a class="postanchor" href="https://en.wikipedia.org/wiki/Representational_state_transfer" target="_blank">REST</a>.

A service-level test automation interface, such as SOAP or REST, poses challenges that are often (though not always) quite different from those we encounter when testing against a web GUI. In this post (possibly the first in a series), I want to address one such challenge (or problem) that I came across in the field: client authentication by means of a TLS client certificate.

<h1 class="post"> <a name="The problem and how I ran into it">The problem and how I ran into it</a> </h1>

One of my assignments involved testing a variety of SOAP and REST services. We were using mainly <a class="postanchor" href="https://robotframework.org/" target="_blank">Robot Framework</a>, but also <a class="postanchor" href="https://www.postman.com/" target="_blank">Postman</a> and <a class="postanchor" href="https://www.soapui.org/" target="_blank">SoapUI</a> to create test suites for those services. In one of the sprints I had to create an automated test suite for the purpose of validating a specific SOAP service.

Without going into the reasons for doing so, I chose Robot Framework for the job.

Since I had to automate against a SOAP service, I decided to give the new <a class="postanchor" href="https://github.com/Altran-PT-GDC/Robot-Framework-SOAP-Library" target="_blank">SoapLibrary</a> a try. That library is based on the <a class="postanchor" href="https://github.com/mvantellingen/python-zeep" target="_blank">zeep</a> SOAP client, which appears to be a highly future-proof Python module.

<h2 class="post"> <a name="The first, failed attempt to connect to the service">The first, failed attempt to connect to the service</a> </h2>

The first step was to create a Robot Framework test suite file for a preliminary, quick exploration of the SOAP service. The latter required the instantiation of a SOAP client, passing it (at least) the WSDL (URL):

<figure>
	<a href="/assets/images/intantiate_soap_client.JPG"><img src="/assets/images/intantiate_soap_client.JPG" class="postimage" alt="Instantiate a SOAP client" width="75%"></a><br>
	<figcaption>For obvious reasons, the WSDL URL to the real-life service is hidden inside the *** Variables *** section.<br>
	Usually, such an URL will look something like this:	https://www.ebi.ac.uk/europepmc/webservices/soap?wsdl.<br>
	(Click to enlarge.)</figcaption>
</figure>

Of course something is missing here, as your average SOAP service requires some form of client authentication.

Now, in the past I had worked with SOAP services where client authentication occurred at the transport level (e.g. through application of the <a class="postanchor" href="https://en.wikipedia.org/wiki/Basic_access_authentication" target="_blank">HTTP 'Basic' authentication scheme</a>) and at the application (that is: message) level (through token-based authentication in accordance with the <a class="postanchor" href="https://en.wikipedia.org/wiki/WS-Security" target="_blank">WS-Security</a> specification).

This specific service, however, required authentication by means of a <a class="postanchor" href="https://en.wikipedia.org/wiki/Transport_Layer_Security" target="_blank">TLS</a> client certificate.

<h2 class="post"> <a name="A few words about TLS">A few words about TLS</a> </h2>

TLS is the successor of <a class="postanchor" href="https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0,_2.0,_and_3.0" target="_blank">SSL</a> and is what enables <a class="postanchor" href="https://en.wikipedia.org/wiki/HTTPS" target="_blank">HTTPS (HTTP-Secure)</a>.

To this end, TLS resides between <a class="postanchor" href="https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol" target="_blank">HTTP</a> and <a class="postanchor" href="https://en.wikipedia.org/wiki/Transmission_Control_Protocol" target="_blank">TCP</a> in the <a class="postanchor" href="https://en.wikipedia.org/wiki/Internet_protocol_suite" target="_blank">Internet Protocol Suite</a>. Logically it inhabits the <a class="postanchor" href="https://en.wikipedia.org/wiki/Application_layer" target="_blank">application layer</a>. Certificates are an integral part of TLS, but there is much more to it. For instance, it also involves the topics of <a class="postanchor" href="https://en.wikipedia.org/wiki/Cryptographic_hash_function" target="_blank">(cryptographic)</a> <a class="postanchor" href="https://en.wikipedia.org/wiki/Hash_function" target="_blank">hashing</a>, (<a class="postanchor" href="https://en.wikipedia.org/wiki/Symmetric-key_algorithm" target="_blank">symmetric</a> and <a class="postanchor" href="https://en.wikipedia.org/wiki/Public-key_cryptography" target="_blank">asymmetric</a>) <a class="postanchor" href="https://en.wikipedia.org/wiki/Encryption" target="_blank">encryption</a>, <a class="postanchor" href="https://en.wikipedia.org/wiki/Digital_signature" target="_blank">digital signatures</a>, <a class="postanchor" href="https://en.wikipedia.org/wiki/Public_key_infrastructure" target="_blank">Public Key Infrastructure</a>, et alia. All of this lies outside the scope of this article.

For now all you need to know is that, very broadly speaking, TLS certificates are used to verify the certificate owner's identity. Usually the server's identity, but sometimes also the client's (as was the case here). This method can be applied on top of or instead of other verification approaches and measures. For instance, on top of HTTP Basic Auth <i>or</i> as an alternative to it.<a href="#footnote-1" class="postanchor"><sup>[1]</sup></a>

In my case, it was the latter: I <i>only</i> needed a client cert and nothing besides.

<h2 class="post"> <a name="Obtaining a client certificate file">Obtaining a client certificate</a> </h2>

It actually took me a while, but at some point I managed to acquire a valid client certificate. It came in the form of a so-called <a class="postanchor" href="https://en.wikipedia.org/wiki/PKCS_12" target="_blank">'PKCS#12'</a> (aka 'PKCS12' or 'PFX') file.

PKCS#12 is a standardized format for a type of archive file that specifically holds one or more cryptographic objects. It is part of the <a class="postanchor" href="https://en.wikipedia.org/wiki/PKCS" target="_blank">PKCS family</a> of formats, where 'PKCS' stands for '<u>P</u>ublic <u>K</u>ey <u>C</u>ryptography <u>S</u>tandards'.

A PKCS#12 file has either a .pfx extension or a .p12 extension. Usually the latter, since the PFX format (and the corresponding .pfx extension) is actually just a precursor of the more recent PKCS12 (with it's .p12 extension). That is, PKCS#12 evolved out of PFX.

The certificate file that I received was, indeed, a .p12 file: <i>bogus.name.p12.</i>

Now, PKCS#12 has been developed to facilitate the secure and confidential distribution of certificates to trusted parties that need to be authorized to use one or more secured services. Specifically, it is used to export/import existing certificates for the purpose of transporting them from one platform, system or tool to another.<a href="#footnote-2" class="postanchor"><sup>[2]</sup></a>

To this end, a PKCS#12 file can hold the following types of cryptographic objects: a private key, a certificate and/or a <a class="postanchor" href="https://en.wikipedia.org/wiki/X.509#Certificate_chains_and_cross-certification" target="_blank">certificate trust chain</a>. <i>Technically</i> a PKCS#12 file can contain any (number) of these objects. <i>Typically</i> though it holds either the combination of a private key and the related certificate <i>or</i> the combination of a private key and the related certificate chain.

And indeed: my PKCS (.p12) file contained a certificate chain <i>and</i> a private key.

But why would I need the latter?

<h2 class="post"> <a name="A few words about the private key">A few words about the private key</a> </h2>

As was said before, I don't want to dilate upon TLS and all of it's moving parts. Therefore, let me just say that a private key is instrumental in the process by which the server establishes that the certificate itself is indeed <i>bound</i> (i.e. belongs) to a specific client. This happens during the <a class="postanchor" href="https://techcommunity.microsoft.com/t5/iis-support-blog/client-certificate-authentication-part-1/ba-p/324623" target="_blank">client authorization part</a> of the <a class="postanchor" href="https://en.wikipedia.org/wiki/Transport_Layer_Security#TLS_handshake" target="_blank">TLS handshake</a> between client and server. Note, however, that <i>merely</i> the certificate will be provided to the server. The private key needs to stay with the client at all times: it's exclusivity is essential within the world of asymmetric encryption and, thus, TLS. The server will only have access to the client's public key, which is embedded in the client's certificate.<a href="#footnote-3" class="postanchor"><sup>[3]</sup></a>

<h3 class="post"> <a name="A private key needs to be protected">A private key needs to be protected</a> </h3>

Since a PKCS#12 file is typically used for the transportation of a certificate <i>and</i> the corresponding private key, security is imperative. That is why the public key is <a class="postanchor" href="https://en.wikipedia.org/wiki/Triple_DES" target="_blank">3DES</a> encrypted and the file is password protected accordingly.

Naturally, all of this applied to my specific .p12 file as well.

<h2 class="post"> <a name="The second, failed attempt to connect to the service"></a>The second, failed attempt to connect to the service</h2>

When using a tool such as SoapUi, typically you can simply import a client certificate into your SOAP project. For instance through importing a .p12 file, like this:

<figure>
	<a href="/assets/images/soapui_ssl_settings.JPG"><img src="/assets/images/soapui_ssl_settings.JPG" class="postimage" alt="Import a client cert in SoapUI" width="75%"></a><br>
	<figcaption>Importing a client certificate in SoapUi on the 'SSL Settings' tab.<br>
	As you can see, SoapUi supports password-protected files.<br>
	(Click to enlarge.) </figcaption>
</figure>

Unfortunately, I soon found out that the RF SoapLibrary did <i>not</i> support the importing of a client certificate. Rather, the 'Create Soap Client' keyword merely facilitated HTTP Basic Auth.<a href="#footnote-4" class="postanchor"><sup>[4]</sup></a>

Therefore I created an <a class="postanchor" href="https://github.com/Altran-PT-GDC/Robot-Framework-SOAP-Library/issues/25" target="_blank">issue</a> on the library's project pages. Fortunately, the maintainers of the library added the feature within a <i>very</i> short span of time!

As soon as the new version was released, I did a:

	pip install --upgrade robotframework-soaplibrary

and subsequently added the path to my certificate (.p12) file as a value to the (brand new) 'client_Cert' argument of the 'Create SOAP Client' keyword:

<figure>
	<a href="/assets/images/client_cert_p-12.JPG"><img src="/assets/images/client_cert_p-12.JPG" class="postimage" alt="Trying to import a .p12 file in the RF SOAPLibrary." width="75%"></a><br>
	<figcaption>Trying to import a .p12 file in the RF SOAPLibrary.<br>
	Please note that, just as in the case of the ${WSDL} variable, <br>
	${PATH} and ${FILE_NAME} have been assigned in the *** Variables *** section.<br>
	(Click to enlarge.) </figcaption>
</figure>

To my disappointment, running this only resulted in the following error message:

<figure>
	<a href="/assets/images/ssl_error.JPG"><img src="/assets/images/ssl_error.JPG" class="postimage" alt="SSL error when trying to import a .p12 file." width="75%"></a><br>
	<figcaption>SSL error when trying to import a .p12 file.<br>
	(Click to enlarge.) </figcaption>
</figure>

<h3 class="post"> <a name="So ... what went wrong?"></a>So ... what went wrong?</h3>

I searched the web for 'ssl error 9 pem lib' and found <a class="postanchor" href="https://stackoverflow.com/questions/30109449/what-does-sslerror-ssl-pem-lib-ssl-c2532-mean-using-the-python-ssl-libr" target="_blank">a relevant question on stackoverflow</a> on the very top of my search results.

Among the multiple answers to that question, I soon found one that looked to me like the most probable solution to my problem:

<figure>
	<a href="/assets/images/stackoverflow_answer.JPG"><img src="/assets/images/stackoverflow_answer.JPG" class="postimage" alt="Solution to my problem on stackoverflow." width="75%"></a><br>
	<figcaption>Solution to my problem on stackoverflow.<br>
	The correct analysis was actually in the <i>comment</i> to the answer,<br>
	as marked red here.
	(Click to enlarge.) </figcaption>
</figure>

What exactly does that mean?

Well, foremost it means that I'm a bit slow. Or lazy. Or impatient. Or all of these.&#x1F60F;

Because, if I would have taken the <i>enormous</i> effort of reading the keyword documentation for the 'Create SOAP Client' keyword after the release of the new SoapLibrary version, I would have seen this:

<figure>
	<a href="/assets/images/kw_doc_create_soap_client.JPG"><img src="/assets/images/kw_doc_create_soap_client.JPG" class="postimage" alt="The keyword documentation already says it!" width="75%"></a><br>
	<figcaption>The keyword documentation already says it!<br>
	(Click to enlarge.) </figcaption>
</figure>

As can be gathered, a certificate file needs to be provided in the form of a .pem or .crt file. These file extensions signify files that hold cryptographic objects and that adhere to the <a class="postanchor" href="https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail" target="_blank">PEM</a> format. PEM is an alternative to the PKCS#12 format. Contrary to the latter, PEM is not binary but text-based (<a class="postanchor" href="https://en.wikipedia.org/wiki/Base64" target="_blank">BASE-64</a> encoded). Moreover, it can hold additional types of cryptographic objects (such as <i>raw</i> public keys), which a PKCS#12 file cannot. See also the remarks in <a href="#footnote-2" class="postanchor">footnote 2</a>.

But all I had was a .p12 file. ... So now what?!

<h1 class="post"> <a name="The solution: OpenSSL">The solution: OpenSSL</a> </h1>

Upon researching a solution to my problem, I soon came across what is probably the most versatile (and, consequently, also the most used) SSL/TLS tool: <a class="postanchor" href="https://www.openssl.org/" target="_blank">OpenSSL</a>.

<h2 class="post"> <a name="What it is">What it is</a> </h2>

OpenSSL is a set of libraries and command-line tools that can be used for the most diverse of SSL/TLS related tasks. For instance: creating certificate signing requests, installing certificates, creating private keys, inspecting the contents of any type of certificate file and so forth.

What it <i>also</i> can do, is <a class="postanchor" href="https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm#ConvertingCertificateFormats" target="_blank">convert certificate file formats</a>!

<h2 class="post"> <a name="How to get it">How to get it</a> </h2>

OpenSSL is shipped with lot's of operating systems and also integrated into (or shipped with) many tools. One tool that comes with OpenSSL is <a class="postanchor" href="https://git-scm.com/" target="_blank">Git</a>. Therefore, since I had Git installed, I did not have to bother with selecting and installing a <a class="postanchor" href="https://wiki.openssl.org/index.php/Binaries" target="_blank">third-party OpenSSL distribution for Windows</a>. OpenSSL can be found in the following sub-folder of the Git root folder:

	usr\bin

And if, as another example, you have Ruby installed on your system, then you have OpenSSL as well:

<figure>
	<a href="/assets/images/open_ssl_installs.JPG"><img src="/assets/images/open_ssl_installs.JPG" class="postimage" alt="Two OpenSSL installations." width="75%"></a><br>
	<figcaption>Two OpenSSL installations.<br>
	(Click to enlarge.) </figcaption>
</figure>

<h2 class="post"> <a name="How to use it">How to use it</a> </h2>

There are a <i>lot</i> of resources on the web that describe the many features and functions of OpenSSL and lay out the corresponding commands. Since I had a .p12 PKCS file, the one relevant command for me was the <code class="snippet"><a class="postanchor" href="https://www.openssl.org/docs/man1.1.1/man1/openssl-pkcs12.html" target="_blank">pksc12</a></code> command. This command can create as well as parse (read) .p12 certificate files. To that end the command comes with a <a class="postanchor" href="https://www.openssl.org/docs/man1.1.1/man1/openssl-pkcs12.html" target="_blank">plethora of options</a>.

For instance, the following command allows one to inspect the contents of a .p12 file:

	openssl pkcs12 -info -in bogus.name.p12

As my certificate file was password protected, I was prompted for the password after submitting that command:

<figure>
	<a href="/assets/images/open_ssl_info_groen.JPG"><img src="/assets/images/open_ssl_info_groen.JPG" class="postimage" alt="OpenSSL command to inspect the contents of the cert file." width="100%"></a><br>
	<figcaption>The OpenSSL -info option to inspect the contents of a .p12 cert file.<br>
	(Click to enlarge.) </figcaption>
</figure>

This will generate an output that will look similar to this:

<figure>
	<a href="/assets/images/open_ssl_info_result.JPG"><img src="/assets/images/open_ssl_info_result.JPG" class="postimage" alt="OpenSSL command to inspect the contents of the cert file." width="70%"></a><br>
	<figcaption>A parsed .p12 file.<br>
	This particular certificate file apparently contains one certificate and a private key.<br>
	Of course this picture does not show the contents of <i>my</i> .p12 file.<br>
	(Click to enlarge.) </figcaption>
</figure>

<h2 class="post"> <a name="Let's get to it">Let's get to it</a> </h2>

The next step was to find the exact command that was needed to convert the .p12 file to a PEM formatted file. Because of the aforementioned copious amount of online resources on OpenSSL, it took merely a few moments to find it:

	openssl pkcs12 -in bogus.name.p12 -out bogus.name.pem -nodes

This command is pretty self-explanatory, as was the previous one. The only noteworthy option here is <code class="snippet">-nodes</code> (read: no-des), which prevents the private key from being encrypted and password protected within the PEM target file.

Since the Robot Framework SoapLibrary does not (yet) support encrypted, password protected private keys, we need to drop this protection.

Please note that this obviously entails a nontrivial security risk! So, not only should you make sure to have formal permission for this action, but also to take risk mitigating measures. For instance, you might employ the <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/11/24/Robot-Framework-Crypto-Library" target="_blank">Robot Framework CryptoLibrary</a>.

Upon submitting the command, I was again prompted for the password. After having provided it, the command executed successfully:

<figure>
	<a href="/assets/images/open_ssl_convert.JPG"><img src="/assets/images/open_ssl_convert.JPG" class="postimage" alt="OpenSSL command to inspect the contents of the cert file." width="100%"></a><br>
	<figcaption>Converting the .p12 into a .pem certificate file.<br>
	(Click to enlarge.) </figcaption>
</figure>

Pretty unspectacular, huh? ... But nevertheless effective:

<figure>
	<a href="/assets/images/open_ssl_files.JPG"><img src="/assets/images/open_ssl_files.JPG" class="postimage" alt="OpenSSL command to inspect the contents of the cert file." width="75%"></a><br>
	<figcaption>The result: a certificate file in PEM format.<br>
	(Click to enlarge.) </figcaption>
</figure>

I now had an additional certificate file in PEM format.

<h2 class="post"> <a name="The third attempt to connect to the service">The third attempt to connect to the service</a> </h2>

So, all that was left to do was modifying the test code so as to pass the correct file image path to the 'Create SOAP client' keyword:

<figure>
	<a href="/assets/images/updated_test_code.JPG"><img src="/assets/images/updated_test_code.JPG" class="postimage" alt="Updating the code." width="75%"></a><br>
	<figcaption>The updated test code.<br>
	Note that the only difference is the file extension, <br>
	since the path and file name have been specified in the *** variables *** section,
	and, as such, did not need to be modified, as the pem and p12 file shared the same location and file name.<br>
	(Click to enlarge.) </figcaption>
</figure>

Running the new code resulted in a successful test run:

<figure>
	<a href="/assets/images/test_run_result.JPG"><img src="/assets/images/test_run_result.JPG" class="postimage" alt="Result of the test run." width="75%"></a><br>
	<figcaption>The test run is finally successful!<br>
	(Click to enlarge.) </figcaption>
</figure>

Additionally, in the log entry for the 'Create SOAP Client' keyword, the available SOAP methods were now revealed:

<figure>
	<a href="/assets/images/test_run_log.JPG"><img src="/assets/images/test_run_log.JPG" class="postimage" alt="Log output of the 'Create SOAP Client' keyword." width="90%"></a><br>
	<figcaption>The 'Create SOAP Client' keyword logs all available SOAP methods.'<br>
	Note that I have masked any sensitive information in this screen shot (such as the actual SOAP methods)!
	(Click to enlarge.) </figcaption>
</figure>

Thus, I could now finally start my preliminary exploration of the service under test.

<h1 class="post"> <a name="Final remarks">Final remarks</a> </h1>

That was actually pretty easy.

The steps to take were only a few and not too complicated. Because I chose to elaborate on a couple of subjects, the whole process might look somewhat cumbersome. But it really isn't:

1. Get formal permission to convert your cert file.
2. Get OpenSSL (if you don't already have it).
3. Research the required OpenSSL command, which should not be too difficult given the abundance of on-line resources. For instance, there are close to <a class="postanchor" href="https://stackoverflow.com/questions/tagged/openssl" target="_blank">15.000 'OpenSSL' questions</a> on stackoverflow at the time of writing.
4. Run the command.
5. Assuming it was successful, assign the path to the newly created cert file to the 'client_cert' argument.
6. Take measures to mitigate the security risk of having a non-encrypted, non-password-protected private key.

In conclusion, if you want (or need) to utilize the Robot Framework SoapLibrary and have a non-PEM certificate file, you can very easily employ OpenSSL to convert it to the required PEM format.

Because of the extraordinary versatility of OpenSSL, you will most likely find a solution to virtually any problem that you may encounter with regard to client certificates.

<br>
<hr style="border-top: 1px dashed">
<hr style="border-top: 1px dashed">
<br>

<p id="footnote-1">[1] Using a client certificate on top of HTTP Basic Auth would establish two-factor authentication (something the client <i>has</i> and something the client <i>knows</i>). <a class="postanchor" href="javascript:history.back()">(back)</a></p>

<p id="footnote-2">[2] There exists a variety of similar, alternative (container) formats, that have all been developed for the purpose of packaging and distributing certificates and/or related cryptographic objects. For instance: PEM, PKCS7 and DER.
Without going into details, these formats differ in various respects such as: being binary or non-binary; the encoding used (e.g. base-64 or ASCII); the types of cryptographic objects they can hold; the platforms that use them (e.g. Windows/IIS, Java/Tomcat); whether or not they are encrypt-able; etc. <br>
Each format thus has its own, specific use cases. For instance, the PKCS#12 format is mainly used to export & import certificates (and the corresponding private keys) on Windows systems.
Finally, each format is associated with one or more file extensions. For instance: .csr, .pem, .der, .key, .cert/cer/crt, etc. <a class="postanchor" href="javascript:history.back()">(back)</a></p>

<p id="footnote-3">[3] A private key is part of a (so-called) 'key pair'. The other key in this pair is the (so-called) 'public key'. A public key can be freely distributed (hence 'public'), while a private key is always in the sole possession of one party (hence 'private').<br>
In asymmetric encryption, one key is (exclusively) used to encrypt, while the other is (exclusively) used to decrypt. Which key does what depends on the type of encryption algorithm that is employed. For instance, with a so-called 'key exchange algorithm', the public key encrypts and the private key decrypts. With a 'digital signing' algorithm, the roles are reversed. Consequently, since the private key is always in the hands of exactly <i>one</i> party, either the capability to encrypt or the capability to decrypt is always limited to that one party.<br>
The keys from a pair have a <i>unique</i> mathematical relation, since the public key is mathematically derived from the private key (which is always created first). In that sense the keys are intrinsically geared towards each other. That is why (for instance in a key exchange) the private key can <i>only</i> decrypt messages that have been encrypted with the public key from that specific pair. It can't decrypt message that have been encrypted with a public key that has been taken from some other pair.<br>
A certificate contains the owner's (i.e. a server's or client's) public key (alongside some other (meta-) information. So when the client would digitally sign a piece of data with its private key and send it to the server, then the server could use the client's public key to decrypt that message (provided the server has the client certificate in it's possession). Without going into the exact (and manifold) details, it is precisely this circumstance that can be used in verifying the client certificate's authenticity. <a class="postanchor" href="javascript:history.back()">(back)</a></p>

<p id="footnote-4">[4] The old Robot Framework SOAP testing library (the 'SudsLibrary') did not support client certificates either. Generally, the lack of support for a broader range of authentication schemes and technologies is often a disadvantage when using open source test tooling. Commercial tools often support the full range of common (and sometimes even more 'exotic') authentication schemes and strategies. <a class="postanchor" href="javascript:history.back()">(back)</a></p>