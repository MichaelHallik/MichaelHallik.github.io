---
tags: testautomation testframeworks encryption test-data robotframework CryptoLibrary
title: Protect your test data with the Robot Framework CryptoLibrary

---
<br>

<h1 class="post"> <a name="Introduction"> Introduction </a> </h1>

A lot has been written on test data management. One of the topics that may be of particular interest is that of protecting and securing test data. When testing it may be necessary to obfusacte or 'mask' sensitive data. Maybe especially so when automating tests: not only is the test code and data oftentimes worked on by (and thus shared between) many contributors, but sensitive data may also be printed out in logs that may be available to even more people.

In this post I will not go into the various <i>types</i> of sensitive data that you may encounter, nor into the many possible <i>reasons</i> why you may want to protect that data. I also will not elaborate on the many techniques and tools that exist for doing so, such as variance, shuffling, encryption, scrambling, etc. There are lot's of existing blog posts and various other resources on all of these topics.

Here I simply want to introduce a really great test library that I came accross recently: the Robot Framework <a class="postanchor" href="https://github.com/Snooz82/robotframework-crypto" target="_blank">CryptoLibrary</a>. The post is merely meant to get you up to speed with this library, without delving too deep into the concepts surrounding the complex topic of cryptography.

<h1 class="post"> <a name="Overview of the CryptoLibrary"> Overview of the CryptoLibrary </a> </h1>

As the name suggests, the CryptoLibrary has been designed to do one thing: encrypt and thereby protect confidential test data. Using this library test data can be encrypted, whether it be data in external data sources or data contained within the test code itself. It also enables us to mask test data within consoles and output files, whether it be those of the Robot Framework our IDE. The data that is thus secured could be anything: user id's, passwords, credit card numbers or personal data of end users.

To this end, the CryptoLibrary uses <a class="postanchor" href="https://en.wikipedia.org/wiki/Elliptic-curve_cryptography" target="_blank">asymmetric (elliptic curve) cryptography</a>. Again, I won't go into details regarding this technology. For now, you only need to know that asymmetric encryption is centered around the concept of a 'key pair'. Asynchronous encryption doesn't use one and the same key to encrypt <i>and</i> decrypt. Hence 'asymmetric'. Rather, it uses a so-called 'public key' to encrypt all of the relevant pieces of data and a so-called 'private key' to decrypt those pieces of data.

We can use the CryptoLibrary to generate such a key pair.

The public key is then made available to anyone or anything that needs to encrypt data. In our case, that's us: the testers.

Key here (pun intended) is that the private key from our key pair is the only key in the world that can decrypt data that has been encrypted with the public key from that pair. The private key is used exclusively by the CryptoLibrary. So, contrary to the public key, the private key is not being issues to anyone or anything else: only the CryptoLibrary can decrypt data. Note further that the private key can only decrypt data that has been encrypted with <i>this</i> specific public key. In other words, the private key cannot decrypt data that has been encrypted with a public key that came from another key pair. The keys from a pair are intrinsically geared towards each other and thus only function when used in conjunction with each other.

Finally, please note that encrypted data is called 'ciphertext', while decrypted/unencrypted data is called 'plaintext'.

<h1 class="post"> <a name="Install the library"> Install the library </a> </h1>

The CryptoLibrary requires Python 3 or higher.

We can install it using pip (if you have a Python 3 version that is below 3.4, you will have to install pip separately):

	pip install robotframework-crypto

Of course, we also need to import the library. However, we will do so at a later moment.

First, we will need to complete a few other steps.

<h1 class="post"> <a name="Generate a public/private key pair"> Generate a public/private key pair </a> </h1>

<h2 class="post"> <a name="Tools"> Tools </a> </h2>

The CryptoLibrary comes with a set of command line (CLI) tools:

1) The 'CryptoLibrary' tool.

Don't get confused. Our test library is named 'CryptoLibrary'. But the library comes with a CLI tool that is <i>also</i> called 'CryptoLibrary'.

We can use this CLI tool to create a public/private key pair, amongst other things.

2) The 'CryptoClient' tool.

We can use this tool to encrypt our test data using the generated public key. As explained before, this encrypted data can subsequently <i>only</i> be decrypted with the unique, corresponding private key that is part of the generated key pair.

We will now use the CryptoLibrary CLI tool to generate a public/private key pair.

<h2 class="post"> <a name="Create a key pair"> Create a key pair </a> </h2>

To generate the pair we must start a terminal/console. For instance, on a Windows system you could use the command prompt. In the console, enter the command 'CryptoLibrary'.

This will present us with a menu:

<a href="/assets/images/start_CL.JPG"><img src="/assets/images/start_CL.JPG" class="postimage" alt="Start the CryptoLibrary CLI." width="50%"></a><br>

As you can see there are four initial menu items. 'Encrypt' is the currently selected item.

I will not guide you through all of the menu items and their sub-menu's. Please see <a class="postanchor" href="https://github.com/Snooz82/robotframework-crypto#cryptolibrary-command-line-tool" target="_blank">here</a>, for an overview of all available menu items.

As we want to create a key pair, we activate the menu item 'Open config' (using the arrow-down and enter keys). This will bring us to the following sub-menu:

<a href="/assets/images/config_key_pair.JPG"><img src="/assets/images/config_key_pair.JPG" class="postimage" alt="Configure key pair." width="50%"></a><br>

Activate menu-item 'Configure key pair'. This will then provide us with the following menu:

<a href="/assets/images/generate_key_pair.JPG"><img src="/assets/images/generate_key_pair.JPG" class="postimage" alt="Generate the key pair." width="50%"></a><br>

Select the menu item 'Generate key pair'. That will present us with a question:

<a href="/assets/images/question_regenerate.JPG"><img src="/assets/images/question_regenerate.JPG" class="postimage" alt="Regenerate the key pair yes/no." width="50%"></a><br>

Now, if we <i>had</i> an existing key pair, we could regenerate that existing pair by choosing 'Yes'. Choosing 'No' would always result in the creation of a new key pair, regardless whether we already had or had not existing key pairs.

However, due to a defect in the tool, the option 'No' currently does not have an effect at all: it simply does <i>nothing</i>. Moreover, choosing 'Yes' will <i>not</i> result in the regeneration of an existing key pair, but will simply (always) create a <i>new</i> key pair, regardless whether we already had or had not existing key pairs. Please note that I have contacted the author of the library. He assured me he would soon fix this little bug.

So, until the defect has been fixed, we will simply have to choose 'Yes' so as to create a new key pair.

We are then asked if we want to save the password to disk. The password in question is meant to protect the private key of the key pair that is about to be generated. We need that private key to be protected, since it is capable to decrypt our encrypted test data. Therefore, we do not want unauthorized usage of the private key! A password helps in preventing such usage.

Creating a password for the private key is mandatory. What we are being asked <i>here</i> is whether we would like to save that password to disk. If we answer 'Yes', two things will happen: the password we will specify will be secured through hashing and the hashed password will be saved to disk. If we choose 'No', then the password will not be saved to disk and not hashed. A third effect of not saving the password to disk, is that we will have to specify the (un-hashed) password as an argument when importing the library later on (more on this later). So, choossing 'No' severly decreases the level of security we apply to our private key!

Therefore, let's select 'Yes'. That way our password will be secured, we won't have to remember it <i>and</i> we won't have to specify it later on as an argument.

Next, two things will happen: a key pair will be generated in the background and we'll be prompted to provide a password:

<a href="/assets/images/enter_pwd.JPG"><img src="/assets/images/enter_pwd.JPG" class="postimage" alt="Enter password." width="50%"></a><br>

Let's enter our password (twice) and press 'enter'. This will has the specified password and then write the result to a text file on disk.

Additionally, various pieces of information will be logged in the console. Most notably the path's to:

- A <i>password_hash.json</i> file containing the (hashed) password that protects the private key.
- A <i>private_key.json</i> file containing the (hashed) private key.
- A <i>public_key.key</i> file containing the public key.

Additionally, the public key is also printed to the console. Of course, this key is identical to the key that is contained in the public_key.key file: they are the same. Remember, that we need that public key to encrypt test data later on. You can copy it here and now of copy it from the text file at a later stage.

<a href="/assets/images/console_output.JPG"><img src="/assets/images/console_output.JPG" class="postimage" alt="Console output." width="90%"></a><br>

The private and public keys have now been generated and saved to our file system, in the form of a 'private_key.json' and 'public_key.key' file:

<a href="/assets/images/files.JPG"><img src="/assets/images/files.JPG" class="postimage" alt="List of files." width="75%"></a><br>

<h2 class="post"> <a name="Some closing remarks"> Some closing remarks </a> </h2>

The three generated files are located in:

<code class="snippet"> your_Python_root_folder\Lib\site-packages\CryptoLibrary\keys </code>

This is the default path, which you can change with the CryptoLibrary CLI tool (see the 'Set key path' menu option in the <a class="postanchor" href="/assets/images/generate_key_pair.JPG">earlier screen shot</a>).

The contents of these files looks something like this (click the picture to enlarge):

<a href="/assets/images/contents_files.JPG"><img src="/assets/images/contents_files.JPG" class="postimage" alt="File contents." width="100%"></a><br>

Now that we have our key pair, we can encrypt and decrypt test data. So, lets move on to the next step.

<h1 class="post"> <a name="Encrypt test data"> Encrypt test data </a> </h1>

To encrypt test data we will have to utilize the second CLI tool that comes with the library: the CryptoClient.

Open a command line window and enter the command 'CryptoClient':

<a href="/assets/images/open_cryptoClient.JPG"><img src="/assets/images/open_cryptoClient.JPG" class="postimage" alt="Start the CryptoClient CLI." width="50%"></a><br>

Again, I will not elaborate on all of the available menu options. To familiarize yourself with all options, please read <a class="postanchor" href="https://github.com/Snooz82/robotframework-crypto#cryptoclient-command-line-tool" target="_blank">the relevant section</a> on the lib's project page.

Here we merely want to encrypt a piece of test data. To this end, choose menu item: Encrypt.

We are then prompted for the test data that we want to encrypt. Note that the prompt specifically states 'password'. However, as mentioned before we can encrypt <i>any </i> type of test data:

<a href="/assets/images/enter_test_data.JPG"><img src="/assets/images/enter_test_data.JPG" class="postimage" alt="Enter test data to encrypt." width="50%"></a><br>

Provide the test data that you want to encrypt and press 'enter'. This will encrypt the data and subsequently print it out in the console window:

<a href="/assets/images/encrypted_data.JPG"><img src="/assets/images/encrypted_data.JPG" class="postimage" alt="Encrypted data in console." width="75%"></a><br>

I have provided my full name: 'Michael Hallik'.

Note that an instruction is printed as well: <i>use incl. "crypt:"</i>. The reason for this instruction will become apparent later on.

Copy the ciphertext (<i>including</i> the 'crypt:' prefix) from the console window. We will need it in the next step.

<h1 class="post"> <a name="Set up Robot Framework to work with encrypted test data"> Set up the Robot Framework to work with ciphertext </a> </h1>

We will now use the obtained ciphertext as our test data.

To this end, we must first enable Robot Framework to decrypt that ciphertext on-the-fly. Surely, when we need to enter a password into an edit field, we do not want the encrypted data submitted. We want the original, plaintext version of the password.

<h2 class="post"> <a name="Import the library"> Import the library. </a> </h2>

Of course, the Robot Framework cannot decrypt ciphertext itself, but only through the CryptoLibrary. Therefore, we need to import it.

I am assuming you have a runnable test suite file set up. If not, please create one.

Then, within your <i>Settings</i> declaration, import the CryptoLibrary:

	Library     CryptoLibrary    variable_decryption=True

This will the look something like this:

<a href="/assets/images/import_cryptolib.JPG"><img src="/assets/images/import_cryptolib.JPG" class="postimage" alt="Console output." width="60%"></a><br>

When the boolean argument 'variable_decryption' is set to 'True', then when running our test suite file, any ciphertext (i.e. any piece of data starting with 'crypt:') that will be encountered during the parsing of the file will be decrypted automatically. When it is set to 'False', we will have to explicitely use the CryptoLibrary's 'Get decrypted text' keyword everwhere in your code where we need ciphertext to be decyrpted. We'll look at some examples of this later on. For now, we'll pass value 'True' to the library.

There are some other arguments that can be passed when importing.
	
The password for access to the private key (that we specified earlier on) can be given as an argument as well. However, in <i>our</i> import statement this was not necessary, since we had saved our (hashed) password to disk. The CryptoLibrary will always look for such a file and, if found, will use it. However, if it can't find the file and the password is also not provided in the import statement, the CryptoLibrary will throw an error:

<a href="/assets/images/attribute_error.JPG"><img src="/assets/images/attribute_error.JPG" class="postimage" alt="Console output." width="75%"></a><br>

Another parameter that can be passed with the import statement is 'key_path'. Through this parameter you can specify a path to the key pair, in case you have moved the keypair from the default 'key' folder. The path can either be an absolute path or can be specified relative to the file 'cryptoutility.py'.

<h2 class="post"> <a name="Import the library"> Specify the encrypted test data. </a> </h2>

