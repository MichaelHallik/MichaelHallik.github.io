---
tags: visual-studio-code VSC language-server-protocol language-server LSP Robot-Framework robotframework testautomation testframeworks
title: Complete guide to Robot Framework support in Visual Studio Code - Introduction
toc: tocvsc.html
comments_id: 14

---
<br>

<h1 class="post"> <a name="Preface."> Preface. </a> </h1>

This is the first of a series of posts that will help (aspiring) <a class="postanchor" href="https://robotframework.org//" target="_blank">Robot Framework</a> developers to become proficient and productive on <a class="postanchor" href="https://code.visualstudio.com/" target="_blank">Microsoft's Visual Studio Code (VSC)</a>. This IDE (Integrated Development Environment) is quite powerful, versatile and flexible and is, as such, a great alternative to other IDE's.

In this introductory article we will get acquainted with a few fundamental concepts and technologies that underly VSC's Robot Framework support.

Please note that, if you are not interested in how stuff works under the hood, you can skip this and wait for the publication of the next post in this series. That post will serve as a detailed installation guide.

If you decided to read on, then let's not waste any more time and words and get started!

<h1 class="post"> <a name="What's in this article."> What's in this article? </a> </h1>

<ol>
	<li><a class="postanchor" href="#A new kid on the block.">A new kid on the block.</a></li>
	<li><a class="postanchor" href="#About language servers.">About language servers:</a></li>
		<ol type="a">
			<li><a class="postanchor" href="#For starters: what is a language server.">What is a language server?</a></li>
			<li><a class="postanchor" href="#Okay ... but ... what kind of services does it provide.">What kind of services does it provide?</a></li>
			<li><a class="postanchor" href="#Right! And to whom (or what) does it provide these services then.">To whom (or what) does it provide these services?</a></li>
			<li><a class="postanchor" href="#Got it. Then how does it provide those services.">How does it provide those services?</a></li>
			<li><a class="postanchor" href="#Super duper! Can I have a small, extra peek under the hood.">A small peek under the hood.</a></li>
		</ol>
	<li><a class="postanchor" href="#The Robot Framework language server.">The Robot Framework language server.</a></li>
	<li><a class="postanchor" href="#What's next.">What's next?</a></li>
</ol>

<h1 class="post"> <a name="A new kid on the block."> A new kid on the block. </a> </h1>

One of the rather unique characteristics of the Robot Framework is the comprehensiveness (one might even say: 'vastness') of its ecosystem. That ecosystem consists of a broad range of test libraries and tools that can be used to extend the framework with all sorts of capabilities and features. Quite often there are even <i>multiple</i> libraries and tools being offered for the <i>same</i> sort of capability or feature.

An example of the latter is the rather large number of IDE and source code editor plug-ins that are available to us:

<figure>
	<a href="/assets/images/editor_overview.JPG"><img src="/assets/images/editor_overview.JPG" class="postimage" alt="An overview of RF editor/IDE plug-ins." width="75%"></a><br>
	<figcaption>An overview of RF editor/IDE plug-ins.<BR>
	<a class="postanchor" href="https://robotframework.org/?tab=tools#resources" target="_blank"><i>Source: https://robotframework.org/?tab=tools#resources</i></a></figcaption>
</figure>

Often, a person that is new to Robot Framework (or to the art of test automation) will choose the stand-alone, dedicated <a class="postanchor" href="https://github.com/robotframework/RIDE" target="_blank">RIDE</a>. This acronym stands for <u>R</u>obot (Framework) <u>I</u>ntegrated <u>D</u>evelopment <u>E</u>nvironment. It is, indeed, a truly great editor if you are setting your first steps towards becoming a Robot Framework Developer. It sports all basic necessities, such as syntax highlighting, code completion and all kinds of refactoring functionality (such as keyword extraction).

However, as one becomes more experienced and is (consequently) joining more complex projects, the need for more advanced editor capabilities arises. That is when the plethora of editor/IDE plug-ins comes in handy. As you can gather from the above screen shot, there are plug-ins for a lot of current, popular IDE's and editors to choose from.

At RoboCon 2021 another great addition to this already large collection of plug-ins was <a class="postanchor" href="https://www.youtube.com/watch?v=aZN5_rvGohg" target="_blank">introduced by Fabio Zadrozny</a>: the <a class="postanchor" href="https://github.com/robocorp/robotframework-lsp" target="_blank">Robot Framework Language Server</a>.

This tool adds Robot Framework support to not just one, but even <i>two</i> highly popular and powerful IDE's, namely <a class="postanchor" href="https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp" target="_blank">Microsoft's Visual Studio Code</a> (i.e. <a class="postanchor" href="https://www.techopedia.com/definition/24580/intellisense" target="_blank">IntelliSense</a>) and <a class="postanchor" href="https://plugins.jetbrains.com/plugin/16086-robot-framework-language-server/" target="_blank">JetBrain's PyCharm</a> (i.e. <a class="postanchor" href="https://www.techopedia.com/definition/7755/intellij-idea" target="_blank">IntelliJ</a>).

Please note that, since this series is about Robot Framework and VSC, we will ignore PyCharm here as well as in the follow-up posts.

As we will see in the remainder of this post, the language server functions as integration 'glue' between Visual Studio Code on the one hand and the Robot Framework on the other.<a href="#footnote-1" class="postanchor"><sup>[1]</sup></a>

<h1 class="post"> <a name="About language servers.">About language servers.</a> </h1>

The Language Server is central to Robot Framework support in VSC. It is doing all of the magic. Thus it would be to our advantage to gain some in-depth knowledge about this component. 

<h3 class="post"> <a name="For starters: what is a language server.">For starters: <i>what</i> is a language server? </a> </h3>

Well, a language server is exactly thát:

a software component that provides services pertaining to a specific programming language.

For instance, one that exposes Python-specific services. Or one that adds Java-specific services. <i>Or</i> one that holds services specific to the Robot Framework scripting language.

<h3 class="post"> <a name="Okay ... but ... what kind of services does it provide."> Okay ... but ... what <i>kind</i> of services does it provide? </a> </h3>

Basically: services that aid a developer in delivering code móre efficiently and  léss error prone.

That is, services such as:

<ul>
	<li>code completion</li>
	<li>code formatting</li>
	<li>code/syntax analysis & validation (error/warning markers)</li>
	<li>syntax highlighting/coloring</li>
	<li>go-to-definitions</li>
	<li>refactoring facilities</li>
	<li>debugging facilities</li>
	<li>etc.</li>
</ul>

Here are two examples (click to enlarge):

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<a href="/assets/images/lsp_auto_complete.JPG"><img src="/assets/images/lsp_auto_complete.JPG" class="postimage" alt="Example of code completion." width="100%"></a>
			<br>
			<figcaption>Example of code completion.</figcaption>
		</figure>
	</div>

	<div style="width: 50%; float: right">
		<figure>
			<a href="/assets/images/lsp_code_validation.JPG"><img src="/assets/images/lsp_code_validation.JPG" class="postimage" alt="Example of code validation." width="100%"></a>
			<br>
			<figcaption>Example of code validation.</figcaption>
		</figure>
	</div>
</div>

<h3 class="post"> <a name="Right! And to whom (or what) does it provide these services then."> Right! And to <i>whom</i> (or <i>what</i>) does it provide these services? </a> </h3>

A language server is, ultimately, created to assist and support developers that code in the specific language that the LS supports.

But it does so only <i>indirectly</i>, namely by lending its language specific intelligence to <i>extend</i> the capabilities of the types of tools that devs typically use to produce code: IDE's and/or source code editors.

The IDE (or source code editor) acts as a <i>client</i> and, as such, consumes the services provided by the language server. As mentioned, it is the language server that actually contains the language-specific intelligence. It holds an intimate knowledge of the details of the language, such as its syntax. The language server 'shares' this knowledge with the client.

For instance, as a developer is typing a line of code in an IDE, the latter continually sends completion requests to the (language) server. To each request the server sends a fitting response to the client. Each response holds one or more suggestions, that the client typically presents to the developer in a list of some sort. The dev subsequently selects a suggestion. This saves her some typing and sometimes even some thinking.

<h3 class="post"> <a name="Got it. Then how does it provide those services."> Got it. Then <i>how</i> does it provide those services? </a> </h3>

To answer that question, we'll have to take a look at some history.

Before the arrival of language servers the job of adding support for a new programming language to an IDE was quite tedious and time-consuming. Support for a specific language had to be implemented in the form of a plug-in (i.e. extension) for an IDE. However, each IDE had its own (extension) API and it was, consequently, quite laborious to adapt the code of an existing extension to port it over to another IDE. Therefore, effectively, a unique language extension had to be build for any IDE that was to support the language in question. Either by an IDE vendor, the developers of a programming language or some third party that was somehow interested enough to undertake the effort.

<figure>
	<a href="/assets/images/schema_lang_support_non-lsp.JPG"><img src="/assets/images/schema_lang_support_non-lsp.JPG" class="postimage" alt="Example: Python language support by way of proprietary-API extensions." width="100%"></a><br>
	<figcaption>Example: Python language support by way of proprietary-API extensions.</figcaption>
</figure>

The concept of a 'language server' was originally devised within Microsoft. Their goal was to decouple programming language support (on the one hand) and IDEs (on the other hand), so as to be able to develop and distribute them independently from each other.

For this they conceived of an <a class="postanchor" href="https://www.jsonrpc.org/specification" target="_blank">JSON-RPC</a> based protocol: The <a class="postanchor" href="https://github.com/microsoft/language-server-protocol" target="_blank">Language Server Protocol</a> (LSP). For an IDE to support a specific language, for instance Python, it had to provide a client component that would be proprietary, but also LSP-compliant. Because of the latter it would then be able to communicate with <i>any</i> LSP-compliant language server component, for instance a Python LS.

In this manner one and the same language server can, with very little effort, be re-used with different development tools, effectively creating a general purpose service. This service and the IDE/client run in different processes which can communicate using the language server protocol over JSON-RPC:

<figure>
	<a href="/assets/images/schema_lang_support_lsp.JPG"><img src="/assets/images/schema_lang_support_lsp.JPG" class="postimage" alt="Example: Python language support with a general-purpose Python language server." width="75%"></a><br>
	<figcaption>Example: Python language support with a general-purpose Python language server.</figcaption>
</figure>

This will stimulate developers of programming languages to develop their own language servers, because it is now very easy to reuse the same code base to add support to other IDE's as well.<a href="#footnote-2" class="postanchor"><sup>[2]</sup></a>

<figure>
	<a href="/assets/images/schema_lang_support_lsp_distr.JPG"><img src="/assets/images/schema_lang_support_lsp_distr.JPG" class="postimage" alt="Example: The same language server used with multiple, different IDE's." width="100%"></a><br>
	<figcaption>Example: The same language server used with multiple, different IDE's.</figcaption>
</figure>

At the same time, this will save the IDE vendor the effort. And even <i>if</i> a vendor will have (or wants) to add support for a specific language, that will be much easier because of the simplified and standardized way of communication.

Winners everywhere.

<h3 class="post"> <a name="Super duper! Can I have a small, extra peek under the hood."> Super duper! Can I have a small, extra peek under the hood? </a> </h3>

Sure!

Let's first take a closer look at JSON-RPC and subsequently go over the LSP.

<p style="color:#433434;"><u>JSON-RPC</u></p>

JSON-RPC is a <a class="postanchor" href="https://www.techtarget.com/searchapparchitecture/definition/Remote-Procedure-Call-RPC" target="_blank">Remote Procedure Call (RPC)</a> protocol that uses JSON to define and structure data that is to be exchanged through specific types of messages between application nodes in a distributed environment.

For this goal JSON-RPC defines <i>three</i> message patterns: 'request', 'response' and 'notification'. Each type of message has a very simple JSON structure. For instance, a request will be in the form of a JSON object that holds four items: two strings, one structured value (which may be an object ór an array) and a value that can be either a string, a number or null. For example:

	{"jsonrpc": "2.0", "method": "add", "params": {"first_nr": 5, "second_nr": 7}, "id": 1}

The first item specifies the JSON-RPC version. The second item holds the name of the function that is to be called. The third item is optional and contains possible arguments that need to be passed into the called function. The fourth item is the id of the transaction that is taking place (the server response will contain the same id).

Since it is an RPC protocol, JSON-RPC has been designed to call functions (procedures, methods) irrespective of whether such a function is local or remote. To the caller the location of the called function is completely transparent. Similarly, the protocol does not specify the transport method for messages: it is transport-agnostic. Thus we may use TCP, HTTP or other means of transportation.

<p style="color:#433434;"><u>LSP</u></p>

As was just mentioned, the Language Server Protocol builds on top of JSON-RPC. Accordingly, it 'inherits' the message types and patterns that were just described. The LSP adds HTTP-like <i>headers</i> (currently only 'Content-Length' and 'Content-Type') to the messages. As you can see, all three JSON-RPC message types are being utilized in the following example:

<figure>
	<a href="/assets/images/language-server-sequence.png"><img src="/assets/images/language-server-sequence.png" class="postimage" alt="Example of communication between an IDE client and a language server." width="100%"></a><br>
	<figcaption>Example of communication between an IDE client and a language server.<BR>
	<a class="postanchor" href="https://microsoft.github.io/language-server-protocol/overviews/lsp/overview/" target="_blank"><i>Source: https://microsoft.github.io/language-server-protocol/overviews/lsp/overview/</i></a></figcaption>
</figure>

Accordingly, a request may look something like the following (<a class="postanchor" href="https://microsoft.github.io/language-server-protocol/overviews/lsp/overview/" target="_blank">source</a>):

	Content-Length: ...\r\n
	\r\n
	{
		"jsonrpc": "2.0",
		"id" : 1,
		"method": "textDocument/definition",
		"params": {
			"textDocument": {
				"uri": "file:///p%3A/mseng/VSCode/Playgrounds/cpp/use.cpp"
			},
			"position": {
				"line": 3,
				"character": 12
			}
		}
	}

As you can see, the structure of the message conforms to the format specified by JSON-RPC.

The 'method' string item is used to convey the specific language server feature that the client wants to employ. In this case it concerns a “Go to Definition” request, in which the client asks for the position of a symbol's definition. The 'params' object specifies the parameters relevant to such a request: the document and the position (both line and character) of the symbol in question.

Also note the header part of the message that precedes the content part and that is terminated on line two (using "\r\n", which is also used to separate the individual header fields).

Next to specifying the messages, the LSP describes various other aspects of the communication between the language client and the language server. In particular, it specifies the following:

<table>
	<tr style="vertical-align:top">
		<td ><u>Server lifecycle:</u></td>
		<td>The client is in charge of lifecycle management: such as initialization, shutdown and exit. Part of the lifecycle is also a handshake-like exchange of capabilities between client and server after initialization has been completed.</td>
	</tr>
	<tr></tr>
	<tr style="vertical-align:top">
		<td><u>Document synchronization:</u></td>
		<td>Synchronization of the contents of a text document. The contents is managed by the client and it is up to the client to notify the server of events, such as changes to the document or the saving of a document.</td>
	</tr>
	<tr></tr>
	<tr style="vertical-align:top">
		<td><u>Language features:</u></td>
		<td>The actual language specific intelligence as described above, such as code completion and go-to-declaration.</td>		
	</tr>
	<tr></tr>
	<tr style="vertical-align:top">
		<td><u>Others:</u></td>
		<td>Workspace features and Window features</td>		
	</tr>
</table>

Indeed, the <a class="postanchor" href="https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/" target="_blank">LSP specification</a> is rather voluminous, particularly when compared to the JSON-RPC specification. If interested you can read more about the specification <a class="postanchor" href="https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/" target="_blank">here</a>.

<h1 class="post"> <a name="The Robot Framework language server.">The Robot Framework language server.</a> </h1>

The Language Server Protocol was originally developed by Microsoft.

However, in cooperation with a couple of other companies they turned it into an open standard. That means that anyone can create a language server based on the protocol specification.

As was mentioned earlier, Fabio Zadrozny did exactly thát: at the request of <a class="postanchor" href="https://robocorp.com/" target="_blank">RoboCorp</a> (who funded the project), he developed a language server and subsequently used it to implement Robot Framework support for both  <a class="postanchor" href="https://github.com/robocorp/robotframework-lsp/blob/master/robotframework-intellij/README.md" target="_blank">PyCharm</a> ánd <a class="postanchor" href="https://github.com/robocorp/robotframework-lsp/tree/master/robotframework-ls" target="_blank">VSC</a> in the form of two extensions.<a href="#footnote-3" class="postanchor"><sup>[3]</sup></a>

The Robot Framework Language Server and the VSC extension were then <a class="postanchor" href="https://www.youtube.com/watch?v=aZN5_rvGohg" target="_blank">presented by Fabio</a> during RoboCon 2021.

At the moment of writing, the latest version of the Robot Framework Language Server is 0.48.2. You can always check out the <a class="postanchor" href="https://github.com/robocorp/robotframework-lsp/blob/master/robotframework-ls/docs/changelog.md" target="_blank">change log</a> to see what is the most recent version and which features were added to it.

<h1 class="post"> <a name="What's next.">What's next?</a> </h1>

In the remainder of this series of articles we will go into the details of installing, setting up and configuring Visual Studio Code and the RF-LS extension for VSC. Additionally, we will discover and explore all kinds of helpful features of the Robot Framework VSC plug-in as well as of Visual Studio Code itself!

If you don't want to wait for the next article, you may find the following online resources to be helpful starting points for your own journey:

<p style="color:#433434;"><u>Robot Framework Language Server (VSC extension):</u></p>

<a class="postanchor" href="https://github.com/robocorp/robotframework-lsp/tree/master/robotframework-ls" target="_blank">On GitHub.</a> <br>
<a class="postanchor" href="https://github.com/robocorp/robotframework-lsp/tree/master/robotframework-ls/docs" target="_blank">GitHub - Specifically for FAQs, configuration and for reporting issues.</a> <br>
<a class="postanchor" href="https://pypi.org/project/robotframework-lsp/" target="_blank">On PyPi.</a> <br>
<a class="postanchor" href="https://robocorp.com/docs/developer-tools/visual-studio-code/lsp-extension" target="_blank">At RoboCorp.</a> <br>
<a class="postanchor" href="https://marketplace.visualstudio.com/items?itemName=robocorp.robotframework-lsp" target="_blank">On the VSC Marketplace.</a> <br>
<a class="postanchor" href="https://open-vsx.org/extension/robocorp/robotframework-lsp" target="_blank">In the VSC OpenVSX registry.</a> <br>
<a class="postanchor" href="https://robotframework.slack.com/channels/#lsp" target="_blank">On Slack.</a> [<a class="postanchor" href="https://robotframework.slack.com/archives/CM0J4A7R9 " target="_blank"><i>Alternative URL.</i></a>] <br>
<a class="postanchor" href="https://forum.robotframework.org/" target="_blank">In case you have questions or problems, go to the RF Forum.</a>

<p style="color:#433434;"><u>VSC itself:</u></p>

<a class="postanchor" href="https://code.visualstudio.com/docs" target="_blank">Documentation section of the VSC home page.</a> <br>
<a class="postanchor" href="https://robocorp.com/docs/developer-tools/visual-studio-code/overview" target="_blank">At RoboCorp.</a>

Of course, there are many, many more resources. You may find them by submitting some basic search queries to your favorite search engine.

Okay, now that we have some background, we can finally go to work!

Therefore, the next entry will feature a complete and detailed installation guide of the entire development stack.

Hope to see you next time around!

<br>
<hr style="border-top: 1px dashed">
<hr style="border-top: 1px dashed">
<br>

<p id="footnote-1">[1] As a side note: there <i>are</i> a couple of alternatives, such as <a class="postanchor" href="https://github.com/d-biehl/robotcode" target="_blank">RobotCode</a>, which is also a great tool. However, the Robot Framework Language Server appears, by all means, to be the most future-proof solution for adding Robot Framework support to Visual Studio Code. But history may prove me wrong.&#128521; <a class="postanchor" href="javascript:history.back()">(back)</a></p>

<p id="footnote-2">[2] The protocol (naturally) does not specify <i>how</i> a language server is to be integrated into a specific IDE. That depends on the (and thus: differs per) IDE. The LS will have to be added to an IDE in the form of a compatible extension/plug-in (which will 'wrap' the LS). So to some extent there still remains an effort in 'porting' a language server from one  IDE to another.<a class="postanchor" href="javascript:history.back()"> (back)</a></p>

<p id="footnote-3">[3] The VSC plug-in is distributed as a <i>.vsix</i> package file (e.g. 'robocorp.robotframework-lsp-0.48.2.vsix') and the PyCharm extension as a <i>.zip</i> archive file (e.g. 'robotframework-intellij-0.48.2.zip'). As a <a class="postanchor" href="https://www.vsixcookbook.com/getting-started/extension-anatomy.html" target="_blank">VSIX</a> file adheres to the OPC (Open Packaging Convention) standard, both file types can be opened with any tool that can handle ZIP files. <a class="postanchor" href="javascript:history.back()">(back)</a></p>