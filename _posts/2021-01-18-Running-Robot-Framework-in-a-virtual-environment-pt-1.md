---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework
title: Python, virtual environments and Robot Framework - Preface
toc: tocvirtenv.html

---

<br>

<h1 class="post"> Python and test automation. </h1>

By all appearances, the Python programming language has seen a meteoric rise in popularity over the last couple of years.

When looking at indicators such as the number of:

<ul>
	<li>job offerings</li>
	<li>courses (offered/requested/taken)</li>
	<li>Google searches</li>
	<li>publications</li>
	<li>votes (popularity surveys)</li>
	<li>et alia</li>
</ul>

then the Python language is often (one of) the fastest growing and/or is even in (or close to) pole position.

For instance, <code class="folder">Github's 'State of the OCTOVERSE 2020'</code> sports this graphic:

<a href="https://octoverse.github.com/" target="_blank"><img class="postimage" src="/assets/images/ranking_prog_lang.JPG" alt="High-level folder structure created by virtualenv." width="70%" style="border:2px solid black"></a>

In another example, <code class="folder">JetBrains'</code> <a class="postanchor" href="https://www.jetbrains.com/lp/devecosystem-2020/" target="_blank">'State of the developer ecosystem 2020'</a> notes in its key takeaways that, although Java is the <i>most popular</i> language and JavaScript is the <i>most used</i> language, Python has overtaken Java in the latter category and is also in the top three languages that developers <i>intent to adopt or migrate to</i>. On top if that, it is also the <i>most studied</i> language.<br>

See for similar reports: <a class="postanchor" href="https://applitools.com/blog/2020-most-popular-programming-languages-for-ui-test-automation/" target="_blank">here</a>, <a class="postanchor" href="https://insights.stackoverflow.com/survey/2020/#technology-programming-scripting-and-markup-languages" target="_blank">here</a>, <a class="postanchor" href="https://www.northeastern.edu/graduate/blog/most-popular-programming-languages/" target="_blank">here</a>, <a class="postanchor"  href="https://www.tiobe.com/tiobe-index/" target="_blank">here</a>, <a class="postanchor" href="https://octoverse.github.com/" target="_blank">here </a> and <a class="postanchor" href="https://www.techradar.com/news/python-was-the-programming-language-king-of-2020" target="_blank">here</a>.

<!-- We could, of course, think of other indicators, that may paint a different picture. Moreover, most of the mentioned indicators are highly contextual and, thus, open to interpretation and debate.

An entirely different question is which programming language would be the 'best' for a specific job (and why). Such a question can never be answered by referring to any of the mentioned indicators. -->

Python's massive gain in popularity appears to be caused in no small part by its exceptional fitness for certain types of jobs.

Python is by many considered to be <a class="postanchor" href="https://www.cuelogic.com/blog/role-of-python-in-artificial-intelligence" target="_blank">highly suitable</a> for emerging and trending software engineering fields, such as AI in general and <a class="postanchor" href="https://www.cervinodata.com/python-vs-java-uses-performance-learning/" target="_blank"> machine learning, data science/analysis and natural language processing </a> in particular. All of these are very hot topics. Consequently, relevant skills are in high demand. And so is Python.

Another trend (or field) that has emerged over the last 10 years or so (although it is much older than that) is test automation. And there too, Python seems to be exceptionally well equipped for the tasks at hand, whether it be unit(-integration) testing, system integration testing or E2E testing. What makes Python such a perfect match are features such as:

<ul>
	<li>It supports both OO programming <i>and</i> functional programming.</li>
	<li>It is succinct/concise and expressive at the same time.</li>
	<li>It boasts a rich ecosystem of relevant and mature third party libraries (e.g. requests, zeep, paramiko and just too many to mention).</li>
	<li>It boasts mature and advanced testing frameworks (e.g. unittest, pytest, Robot Framework)</li>
	<li><a class="postanchor"  href="https://automationpanda.com/2018/07/26/why-python-is-great-for-test-automation/" target="_blank">Et alia</a>.</li>
</ul>

Because of these (and other) features Python excels when it comes to providing a combination of learnability, efficiency, flexibility and versatility. That combination makes it just great for test automation.

Consequently, more and more test automation engineers and software development organizations are discovering and turning to Python as the test automation language of their choice.

<h1 class="post"> Then what is this series of posts about? </h1>

The post you are reading now is the first in a series that will focus on some of the unique Python features that can take our test automation projects to a next level. All of these posts will have extensive hands-on examples.

In this first post we will look into virtual Python environments: what can they do for us, what are they, how do they work and how to operate them? We will tackle these topics in the form of a series of articles:

<ol>
	<li>Preface.</li>
	<li><a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-2">Introduction to virtual environments.</a></li>
	<li><a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-3">Installation of the required software.</a></li>
	<li><a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-4">Creating virtual environments.</a></li>
	<li><a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-5">Creating environment/project ecosystems.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">Run Robot tests in a virtual environment.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">Switch between virtual environments.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">Manage virtual environments.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">Share virtual environments.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">Restore virtual environments.</a></li>
	<li><a class="postanchor" href="/_pages/underconstruction">PyCharm and virtual environments.</a></li>
</ol>

For the hands-on examples within this series we will be using Robot Framework.

The latter is sort of a bonus by the way, since there isn't much information to be found on the web, on running the Robot Framework in a virtual environment. There are <i>some</i> articles on the topic, but they are all rather sketchy. I will provide you with a more thorough rundown.

Please note that we will take a dive into the inner workings of virtual environments. I know that quite a few people oppose to long posts that deep-dive into their topics. They just want a concise list of steps without any background as to what happens 'under the hood' with each step.

However, I firmly believe that knowing the internals of our tool stacks makes us more efficient and effective as test (automation) engineers.

These articles are meant for anyone that agrees with the latter. Everyone else may return to their daily business of mindlessly pushing buttons. &#128520;

<!-- Skip the first parts and jump ahead to the fourth section, if you just want to learn the steps to take for operating Robot Framework in a virtual environment.

But please note that even there you could run into information that may be too in-depth for your taste. Well, you will just have to suffer a bit, I guess. &#128124; -->

Well, if you are game, you can <a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-2">start reading the second article</a>.