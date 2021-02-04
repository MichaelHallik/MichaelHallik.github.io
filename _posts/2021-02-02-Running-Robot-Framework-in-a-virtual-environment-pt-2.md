---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework
title: Python, virtual environments and Robot Framework - Introduction to virtual environments
toc: tocvirtenv.html

---
<br>

<h1 class="post"> <a name="Introduction"> Can't we just skip the intro & jump to the good stuff? </a> </h1>


But this already <i>is</i> the good stuff, silly! 😉

I consider it good practice to reflect on a new technique, pattern or (in this case) tool, before actually <i>using</I> it. There are several benefits in doing so.<br><br>

For one, we will be better equipped to understand, interpret, analyze and remove errors or other problems that we might encounter, when we understand the inner machinations of what we're working with. We will also utilize our tool (or pattern, etc.) both more efficiently and effectively when we know which problem(s) it has been designed to solve and know <i>how</i> it solves this (these) problem(s). We will then also utilize its potential to a greater extent, because we know what it has to offer.

Apart from such practical benefits, I believe that as testers we should have a natural curiosity. A curiosity that drives us into investigating how stuff works and why it works that way.

Let's therefore first have a closer look at virtual environments, before putting them to use:

<ul>
	<li><a class="postanchor" href="#What is a virtual environment?">What is a virtual environment?</a></li>
	<li><a class="postanchor" href="#What does a virtual environment look like?">What does a virtual environment look like?</a></li>
	<li><a class="postanchor" href="#Why virtual environments?">Why virtual environments?</a></li>
	<li><a class="postanchor" href="#Why virtual environments?">Next steps.</a></li>
</ul>

Note that this is just a first, quick peek under the hood: we will keep on peeking even in the remaining parts of this series of articles, where we will be working with virtual environments.

<h1 class="post"> <a name="What is a virtual environment?"> What is a virtual environment? </a> </h1>

A virtual environment is a self-contained, isolated Python installation that (as such) is independent from any global/system Python installations (and their configurations) as well as from any other virtual Python environments (and their configurations). Within such an environment, we can create an ecosystem of third party libraries/packages that will be specific for (and dedicated to) that environment.<a href="#footnote-1" class="postanchor"><sup>[1]</sup></a>

Installed libraries/packages will only be accessible to the Python interpreter of that specific environment. Vice versa, no packages from outside the environment will be accessible to that interpreter.<a href="#footnote-2" class="postanchor"><sup>[2]</sup></a>

Once you have created an environment that fulfills the requirements of your specific development project, you can then proceed and bind the environment to that project. Or to multiple projects that have identical requirements.

<h1 class="post"> <a name="What does a virtual environment look like?"> What does a virtual environment look like? </a> </h1>

Creating a virtual environment generates a (relatively) small directory structure. Depending on the tool (and depending on the parameters you apply when creating the environment) there are some variations within this structure. For instance, this is the folder structure for one of my virtual environments, created with the Python module <code class="folder">virtualenv</code>:

<a href="/assets/images/folder_structure.jpg"><img class="postimage" src="/assets/images/folder_structure.jpg" alt="High-level folder structure created by virtualenv." style="border:2px solid black"></a>

But regardless the tool, <i>all</i> virtual environments basically consist of three components:

<ol>
<li> The Python interpreter (usually with a version that you specified). <br><br> This might be a copy of the system interpreter that you based your environment on or a so-called <a href="https://en.wikipedia.org/wiki/Symbolic_link" class="postanchor" target="_blank">'symlink'</a> to that system interpreter. Again, this will depend on the tool used and/or on the parameters you select upon creating the env. </li><br>

<li> The Python <code class="folder">\Scripts</code> folder (<code class="folder">\bin</code> on Unix/Linux). <br><br> This folder is part of every regular Python installation and also of every virtual environment. It is used by third-party modules/packages (which themselves get installed into the <code class="folder"> \Lib\site-packages</code> folder; see below) to store scripts and/or executables that are associated with them. <br><br> As this folder (together with the <code class="folder">root/installation</code> folder) gets dynamically added to the operating system's PATH variable (more on this in the third part), you can run these scripts/executables from the command line. <br><br> For instance, if you were to invoke:<br><br>

<code class="snippet">pip install robotframework</code><br><br>

from the Windows command line, then the excutable <code class="folder">pip.exe</code> in the <code class="folder">\Scripts</code> folder would be called, which acts as a wrapper for the pip module in <code class="folder">\Lib\site-packages</code>. The same goes for the script <code class="folder">ride.py</code>, which is called when you start RIDE (Robot Framework Integrated Development Environment) from the command line and which, in turn, acts as an entry point to the RIDE package in the <code class="folder">\Lib\site-packages</code> folder. </li><br> Basically, this constellation is there to make sure we can access Python programs through the standard Windows shells, and not having to use the interactive Python interpreter. See this example of the <code class="folder">\Scripts</code> folder of my virtual environment:<br><br>

<a href="/assets/images/scripts_folder.JPG"><img src="/assets/images/scripts_folder.JPG" alt="Contents of Scripts folder." class="postimage" width="80%" style="border:2px solid black"></a><br>

You can see that the Python executable is also located here, which, in my case, is a copy of the system Python interpreter and not a symlink.<br><br>

<li> The Python <code class="folder">\Lib\site-packages</code> folder. <br><br> This folder is used for third-party libraries/packages that are installed. For instance, Robot Framework, RIDE and all installed RF test libraries will reside in this folder. </li><br>

See again my own virtual environment as an example:<br><br>

<a href="/assets/images/site_folder.JPG"><img src="/assets/images/site_folder.JPG" alt="Contents of Scripts folder." class="postimage" width="80%" style="border:2px solid black"></a><br>

</ol>

So the three basic types of artifacts, that every virtual Python environment is composed of, are:

<li>a Python interpreter</li>
<li>a bunch of Python scripts</li>
<li>a bunch of Python packages (libraries)</li>

The scripts and the packages are closely related, as was just explained. <br><br> These three basic components are, as an independent whole, isolated from any other (virtual or system) Python installation.

<h1 class="post"> <a name="Why virtual environments?"> Why virtual environments? </a> </h1>

Creating a virtual Python environment for your test automation project (and for any kind of development project, for that matter) can be beneficial for many reasons. Among those reasons are:

<ul>
<li> Avoiding dependency hell. <br><br> A project may contain dependencies towards specific versions of Python and/or third party libraries. This may conflict with dependencies within one or more of your other projects. For instance, it may conflict with a project that might require the same Python version, but at the same time requires divergent versions of the same third-party libraries.</li><br>

<li> Keeping your system/global/base Python installation clean. <br><br> You won't have to clutter your global <code class="folder">\Lib\site-packages</code> and <code class="folder">\Scripts</code> folders when installing third-party libraries and tools for your various projects. Usually an average project will require quite a few packages to be installed. Consequently, the mentioned folders will fill up fast and become rather hulking and unwieldy.</li><br>

<li> Being able to easily share a specific Python environment. <br><br> For instance, in order to facilitate that every contributing team member uses the same Python version and tool stack/ecosystem. As we will see in the remainder of this post, utilizing virtual environments makes sharing these environments very easy.</li><br>

<li> Being able to restore your environment, in case of problems related to that environment. <br><br> Let's say, for instance, that you updated multiple libraries in one, single (and bold) step and now find yourself overwhelmed by an avalanche of (mostly obscure) exceptions. Wouldn't it be nice to be able to quickly revert to the original (or last known functioning) environment and try your updates again, but now in a less rash fashion? Later on we will see just how effortless this can be done with a virtual environment!</li>
</ul>

<h1 class="post"> <a name="Next"> Next steps. </a> </h1>

Now that we have some idea of what a virtual environment is, <a class="postanchor" href="/blog/2021/02/03/Running-Robot-Framework-in-a-virtual-environment-pt-3">let's create one in the next part</a>.<br><br>

<hr style="border-top: 1px dashed"><br>
<p id="footnote-1">[1] Although you <i>can</i> configure your environments to share certain artifacts. <a class="postanchor" href="javascript:history.back()">(back)</a></p>

<p id="footnote-2">[2] Again, depending on how you rig your environment(s), you <i>could</i> share artifacts between environments. <a class="postanchor" href="javascript:history.back()">(back)</a></p>