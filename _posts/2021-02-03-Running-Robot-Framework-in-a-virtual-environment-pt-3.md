---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework
title: Python, virtual environments and Robot Framework - Installation of required software
toc: tocvirtenv.html
comments_id: 5

---
<br>

<h1 class="post"> <a name="Summary of the steps to take."> Summary of the steps to take. </a> </h1>

To create a virtual Python environment, we first have to install a few things:

<ol type="a">
	<li><a class="postanchor" href="#Install one or more Python versions.">Install one or more Python versions</a>.</li>
	<li><a class="postanchor" href="#Decide on a tool (stack).">Decide on a tool (stack)</a>.</li>
	<li><a class="postanchor" href="#Install the chosen tool (stack).">Install the chosen tool (stack)</a>.</li>
	<li><a class="postanchor" href="#Next steps">Next steps</a>.</li>
</ol>

Please note that the instructions have been written with Windows in mind (in my case Win 10 Pro). But the whole process is very similar on Linux/Unix.

Here we go . . .

<h1 class="post"> <a name="Install one or more Python versions."> Install one or more Python versions. </a> </h1>

We might have a need to develop, run and test our project code against multiple Python versions, because our project is simply required to support multiple versions. Or maybe our project libraries directly or indirectly depend on a specific Python (library) version that other projects do not support.

When any such situation is applicable, install the required Python versions. These Python system installations will then serve as the basis for the various virtual environments that we will create.

For our purposes, we need to install Python versions that are <b>above Python 3.3</b>. Anything below that, can (and will) entail problems later on.

For the sake of this post, I have installed the following versions:

<a href="/assets/images/python_versions.JPG"><img class="postimage" src="/assets/images/python_versions.JPG" alt="Contents of Scripts folder." width="85%" style="border:2px solid black"></a>

I will not elaborate much on the Python installation process itself, since it is pretty straightforward and since you can easily find the answer to any question (and the solution to any problem) you might have on the web.

However, please make sure to add at least one Python installation to your operating system's PATH and to install the <code class="folder">Python Launcher</code>, as described in the following two sections.

<h2> The PATH environment variable. </h2>

We need to add the Python <code class="folder">root (= installation)</code> folder as well as the <code class="folder">\Scripts</code> sub-folder to the PATH environment variable of your operating system. In my case, I put the following on the PATH:

<ul>
  <li><code class="folder">C:\Python39</code></li>
  <li><code class="folder">C:\Python39\Scripts</code></li>
</ul>

The installer can do this for you. Just tick the corresponding check box. If you don't, you must perform this action manually after the installer is finished. If you do not know how to do the latter, please query a web search engine:

<code class="snippet">modify path variable [your_os]</code>.

Note that for our purposes, it will be sufficient to take this step for just <i>one</i> of multiple Python versions (assuming you have multiple). In our case it is also irrelevant <i>which one</i> you pick.

Reversely, having the folders of multiple (or even all) Python versions added to PATH won't hurt either. Typically, only the first occurrence (of the folder pair) that is found in PATH is used by the OS or applications that look for Python (while possible other entries are then simply ignored). The first occurrence (that will be found) on PATH, is always the folder pair of the Python version that was installed last (and for which you had the installer create PATH entries). But for our purposes none of that matters, as we will see later on. Just have the mentioned two folders added to PATH for <i>at least</i> one Python version.

<h2> The Python Launcher. </h2>

It is recommended to activate the option to install the so-called '<a class="postanchor" href="https://docs.python.org/3/using/windows.html#launcher" target="_blank">Python Launcher</a>' during the installation process. On Windows, this will be in the form of a checkbox within the installer dialog.

<h2> Validate the installation(s). </h2>

To check whether a Python version has been properly installed, you can perform a simple test: immediately after an installation, open a command line and type:

<code class="snippet">python -V</code>

That should output the version of the Python installation that was installed most recently.

However, that approach assumes that the <code class="folder">Python root</code> and <code class="folder"> \Scripts</code> folders of that particular Python version were added to PATH during or immediately after installation (see earlier remarks). In case they were not, you can use another approach. This one assumes that you have installed the <code class="folder">'Python launcher'</code> (see earlier remarks). In case you have, open a command line <i>after</i> you have installed <i>all</i> of the required Python versions and type:

<code class="snippet">py -0</code>

This will output all installed Python versions on your system:<br>

<!---
<a href="/assets/images/py_launcher.JPG"><img class="postimage" src="/assets/images/py_launcher.JPG" alt="Contents of Scripts folder." width="60%" style="border:2px solid black"></a><br>
-->

	C:\Users\Michael Hallik>py -0
	Installed Pythons found by py Launcher for Windows
	-3.9-64 *
	-3.8-64
	-3.7-64

The asterisk indicates which Python version the Python launcher will use by default (always the most recent version of Python it can find). By the way, it does <i>not</i> indicate which Python version is first in PATH. This <i>could</i> be the same version. But it is by no means necessarily so.
  
<h1> <a name="Decide on a tool (stack)."> Decide on a tool (stack). </a> </h1>

As there are many tools available for creating and managing virtual Python environments, we will first have to select one.

<h2> Candidates. </h2>

As was just said, there are quite a few candidates.

For instance:

<ul>
  <li>The <code class="folder">venv</code> module, that comes shipped with Python (i.e., is part of the standard library).</li>
  <li>The <code class="folder">virtualenv</code> module.</li>
  <li>The <code class="folder">pipenv</code> module.</li>
  <li>The <code class="folder">anaconda</code> module.</li>
  <li>And many more ...</li>
</ul>

<h2> Differences. </h2>

I will not go into the differences in capabilities nor into the specific comparative pro's and con's of these, as there is a <i>plethora</i> of online posts on these topics. For instance <a class="postanchor" href="https://www.pluralsight.com/tech-blog/managing-python-environments/" target="_blank">this one</a> or <a class="postanchor" href="https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe" target="_blank">this one</a>.

<h2> Introducing virtualenv. </h2>

Here we will simply choose <a class="postanchor" href="https://virtualenv.pypa.io/en/latest/index.html" target="_blank">virtualenv</a>, as most or all of the other candidates either are too simple (e.g. <code class="folder">venv</code>) or boast way too much other functionality (e.g. <code class="folder">pipenv</code> and <code class="folder">anaconda</code>). <br><br> Moreover, <code class="folder">virtualenv</code> comes accompanied with a module named <a class="postanchor"  href="https://pypi.org/project/virtualenvwrapper-win/" target="_blank">virtualenvwrapper-win</a> that, as it's name suggests, serves as a wrapper to <code class="folder">virtualenv</code>. This wrapper provides us with all kinds of convencience functions that will greatly enhance the efficiency of our environment management. <br><br> Also, <code class="folder">virtualenv</code> is a <i>very</i> popular tool and you will therefore find lot's of online information for it. <br><br> Finally, <code class="folder">PyCharm</code> can (re-)use environments that we create manually through <code class="folder">virtualenv</code>. This adds a lot of flexibility when using <code class="folder">PyCharm</code> as editor, since the virt env options that the IDE itself provides us with, are rather limited.

<h1> <a name="Install the chosen tool (stack)."> Install the chosen tool (stack). </a> </h1>

For this step you must have modified your PATH environment variable in accordance with what has been said earlier.

<h2> Introducing pip. </h2>

Assuming you have followed all of the previous instructions, you will now have <a class="postanchor" href="https://realpython.com/what-is-pip/" target="_blank">pip</a> available. This is one of the most popular Python package managers and for that very reason it also comes shipped with Python. With <code class="folder">pip</code> you can install external, third-party Python packages. That is, packages that are not part of Python's standard library. Additionally, <code class="folder">pip</code> makes it very easy for developers to manage any external dependencies of the various modules in the packages they distribute. As a matter of fact, we will use that feature of <code class="folder">pip</code> to be able to restore and also share our environments later on.

To see whether you have <code class="folder">pip</code> available, open a command line and type:

<code class="snippet">pip -V</code>

<h2> No pip available? </h2>

In case <code class="folder">pip</code> is not available, check whether you have (the correct version of) Python available. Just type:

<code class="snippet">python -V</code>

in your console/shell/CLI.

In case you CLI doesn't recognize the issued command, check your PATH environment variable (in accordance with what was said earlier).

If the command is executed, but the returned Python version is <i>below 3.4</i>, then <code class="folder"> pip </code> will not be included in the standard library and you'll have to install it <a class="postanchor" href="https://www.liquidweb.com/kb/install-pip-windows/" target="_blank">manually</a> for that Python version. Or put a suitable Python version as first on your PATH (assuming one is installed).

<h2> Install virtualenvwrapper-win. </h2>

To install <code class="folder">virtualenv</code>, simply open a command line and type:

<code class="snippet">pip install virtualenvwrapper-win</code>

Since <code class="folder">virtualenvwrapper-win</code> is a wrapper for <code class="folder">virtualenv</code> and, as such, reuses and depends on it, the latter will also be installed:

	C:\Users\Michael Hallik>pip install virtualenvwrapper-win
	Collecting virtualenvwrapper-win
	Collecting virtualenv
	Using legacy 'setup.py install' for virtualenvwrapper-win, since package 'wheel' is not installed.
	Installing collected packages: virtualenv, virtualenvwrapper-win
	Running setup.py install for virtualenvwrapper-win ... done
	Successfully installed virtualenv-20.4.0 virtualenvwrapper-win-1.2.6

<!---
<a href="/assets/images/install_tool.JPG"><img src="/assets/images/install_tool.JPG" class="postimage" alt="Installing our tools with pip." width="70%"></a><br>
-->

So, what we did just now is equivalent to:

<code class="snippet">pip install virtualenv</code><br>
<code class="snippet">pip install virtualenvwrapper-win</code>

Note that, depending on your specific set-up, one or more other dependencies (such as <code class="folder">appdirs, filelock, six, distlib</code>) may have been installed and visible in your command line output.

<h2> <a name="Optional: create an environment variable WORKON_HOME"> Optional: create an environment variable WORKON_HOME. </a></h2>

This step is optional, but recommended.

We can set a default target (i.e. home) directory for our environments. That way, we will not have to specify a target directory every time we create a new environment. Similarly, we will not have to specify that directory whenever we activate an environment (activation will be explained in the next article).

We set a default directory by creating a user environment variable. I have chosen the following directory myself:

<a href="/assets/images/env_vars.JPG"><img src="/assets/images/env_vars.JPG" class="small" alt="Setting the workon_home environment variable." class="postimage" width="65%" style="border:2px solid black"></a><br>

If you do not know how to create such a variable, please query a web search engine:

<code class="snippet">add environment variable [your_os]</code>.

<h1 class="post"> <a name="Next steps"> Next steps. </a> </h1>

Well, that was it: we are now finally ready to <a class="postanchor" href="/blog/2021/02/04/Running-Robot-Framework-in-a-virtual-environment-pt-4">create our very first virtual environment</a>.
