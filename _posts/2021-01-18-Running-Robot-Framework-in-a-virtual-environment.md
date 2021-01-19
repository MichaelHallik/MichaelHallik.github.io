---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework

---

<br>

<h2> Introduction. </h2>

A lot has been written on Python virtual environments. There also is an abundance of information on the web concerning the various Python tools to create and manage these environments.

However, there isn't much information on running the Robot Framework in a virtual environment. That is rather odd, since the Robot Framework is the most prominent (generic) test automation framework within the Python ecosystem. There are <i>some</i> articles on the topic, but they are all rather sketchy.

This post will provide you with a thorough rundown. As such, it will also dive somewhat into the theory behind virtual environments. I believe knowing the internals of our tool stack makes us more efficient and effective as test (automation) engineers. Therefore, this article will cover the following topics:

<ol>
  <li><a href="#Why virtual environments?">Why virtual environments?</a></li>
  <li><a href="#But what exactly is a virtual environment?">But what exactly is a virtual environment?</a></li>
  <li><a href="#What does a virtual environment look like?">What does a virtual environment look like?</a></li>
  <li><a href="#Create a virtual environment using virtualenv.">Create a virtual environment using virtualenv.</a>
    <ol type="a">
      <li><a href="#Install one or more Python versions.">Install one or more Python versions.</a> </li>
      <li><a href="#Decide on a tool (set).">Decide on a tool (set).</a> </li>
      <li><a href="#Install the chosen tool (set).">Install the chosen tool (set).</a> </li>
      <li><a href="#Optional: create an environment variable WORKON_HOME.">Optional: create an environment variable WORKON_HOME.</a> </li>
      <li><a href="#Create a virtual Python environment.">Create a virtual Python environment.</a> </li>
    </ol>
  </li>
</ol>

If you just want to know the steps to take for operating Robot Framework in a virtual environment, you can skip the first couple of parts and jump ahead to the fourth section. But please note, that even there you may run into information that may be too in-depth for your taste. Well, you will just have to suffer a bit, I guess. &#128124;

<h2> <a name="Why virtual environments?"> Why virtual environments? </a> </h2>

Creating a virtual Python environment for your test automation project (and for any kind of development project, for that matter) can be beneficial for many reasons. Among those reasons are:

<ul>
<li> Avoiding dependency hell. <br><br> A project may contain dependencies towards specific versions of Python and/or third party libraries. This may conflict with dependencies within one or more of your other projects. For instance, it may conflict with a project that might require the same Python version, but at the same time requires divergent versions of the same third-party libraries.</li><br>

<li> Keeping your system/global/base Python installation clean. <br><br> You won't have to clutter your global <code class="folder">site-packages</code> and <code class="folder">Scripts</code> folders when installing third-party libraries and tools for your various projects. Usually an average project will require quite a few packages to be installed. Consequently, the mentioned folders will fill up fast and become rather hulking and unwieldy.</li><br>

<li> Being able to easily share a specific Python environment. <br><br> For instance, in order to facilitate that every contributing team member uses the same Python version and tool/library stack. As we will see in the remainder of this post, utilizing virtual environments makes sharing these environments very easy.</li><br>

<li> Being able to restore your environment, in case of problems related to your environment. <br><br> Let's say, for instance, that you updated multiple libraries in one, single step and now find yourself overwhelmed by an avalanche of (mostly obscure) exceptions. Wouldn't it be nice to be able to quickly revert to the original (or last know functioning) environment and try your updates anew in a less rash fashion? Later on we will see just how effortless this can be done with a virtual environment!</li>
</ul>

<h2> <a name="But what exactly is a virtual environment?"> But what exactly is a virtual environment? </a> </h2>

A virtual environment is a self-contained, isolated Python installation that (as such) is independent from any global/system Python installations (and their configurations) as well as from any other virtual Python environments (and their configurations). Within that environment, you can create an eco-system of third party libraries/packages that will be specific and dedicated to that environment (although you <i>can</i> share between environments if necessary).

The installed packages will only be accessible to the Python interpreter of that specific environment. Vice versa, no packages from outside the environment will be accessible to that interpreter. (Again, depending on how you rig your environment(s), you <i>could</i> share artifacts between environments if needed.)

Once you have created an environment that fullfills the requirements of your specific development project, you can then proceed and bind the environment to that project. Or to multiple projects that have identical requirements.

<h2> <a name="What does a virtual environment look like?"> What does a virtual environment look like? </a> </h2>

Creating a virtual environment generates a (relatively) small directory structure. Depending on the tool (and depending on the parameters you apply when creating the environment) there are some variations within this structure. For instance, this is the folder structure for one of my virtual environments, created with the Python module <code class="folder">virtualenv</code>:

<a href="/assets/images/folder_structure.jpg"><img class="postimage" src="/assets/images/folder_structure.jpg" alt="High-level folder structure created by virtualenv." style="border:2px solid black"></a>

Regardless the tool, all virtual environments basically consist of three components:

<ol>
<li> The Python interpreter (with a version that you specified). <br><br> This might be a copy of the system interpreter that you based your environment on or a so-called 'symlink' to that system interpreter. Again, this will depend on the tool used and/or on the parameters you select upon creating the env. </li><br>

<li> The Python <code class="folder">\Scripts</code> folder (<code class="folder">\bin</code> on Unix/Linux). <br><br> This folder is part of every regular Python installation and also of every virtual environment. It is used by third-party modules/packages (which themselves get installed into the \Lib\site-packages folder) to store scripts and/or executables that are associated with them. <br><br> As this folder (together with the root installation folder) gets added to the operating system's PATH variable (provided you chose that option during installation or manually edited PATH afterwards), you can run these scripts/executables from the command line. <br><br> For instance, when you invoke <code class="folder">pip install robotframework</code> from the Windows command line, the excutable <code class="folder">pip.exe</code> in the <code class="folder">Scripts</code> folder is called, which acts as a wrapper for the pip module in <code class="folder">\Lib\site-packages</code>. The same goes for the script <code class="folder">ride.py</code>, which is called when you start RIDE (Robot Framework Integrated Development Environment) from the command line and which, in turn, acts as an entry point to the RIDE package in the <code class="folder">\Lib\site-packages</code> folder. </li><br> See this example of the <code class="folder">Scripts</code> folder of my virtual environment:<br><br>

<a href="/assets/images/scripts_folder.JPG"><img class="postimage" src="/assets/images/scripts_folder.JPG" alt="Contents of Scripts folder." style="border:2px solid black"></a><br>

You can see that the Python executable is also located here. Some of the other tools for virtualization place the Python interpreter elsewhere.<br><br>

<li> The Python <code class="folder">\Lib\site-packages</code> folder. <br><br> This folder is used for third-party libraries/packages that are installed. For instance, Robot Framework, RIDE and all installed RF test libraries will reside in this folder. </li><br>

See again my own environment as an example:<br><br>

<a href="/assets/images/site_folder.JPG"><img class="postimage" src="/assets/images/site_folder.JPG" alt="Contents of Scripts folder." style="border:2px solid black"></a><br>

</ol>

So the three basic types of artifacts, that every virtual Python environment is composed of, are: a Python interpreter, a bunch of Python scripts and a bunch of Python packages (libraries). The scripts and the packages are closely related, as was just explained. <br><br> These three basic components are, as an independant whole, isolated from any other (virtual or system) Python installations.

Now that we have some idea of what a virtual environment is, let's create one! <br>

<h2> <a name="Create a virtual environment using virtualenv."> Create a virtual environment using virtualenv. </a> </h2>

To get ourselves a nice virtual environment, we have to take several steps.

These will be outlined in the remainder of this post. Please note that the instructions have been written for Windows (in my case Win 10 Pro). But the whole process is very similar on Linux.

Here we go . . .

<h3> <a name="Install one or more Python versions."> Install one or more Python versions. </a> </h3>

You might have a need to develop, run and test your project code against multiple Python versions. Maybe you need to support multiple Python versions. Maybe your project directly or indirectly depends on a specific, older Python version, while others do not. Or some of your projects depend on external libraries that need some specific (for instance older) Python version.

When such a situation is aplicable, install the required Python versions. For the sake of this post, I have installed:

<a href="/assets/images/python_versions.JPG"><img class="postimage" src="/assets/images/python_versions.JPG" alt="Contents of Scripts folder." style="border:2px solid black"></a><br>

I will not elaborate on the Python installation process, since it is pretty straightforward. Just make sure to add the root (= installation) folder as well as the \Scripts folder to the PATH environment variable of your operating system. The installer can do this for you or you must do it manually (ask Google 'add environment variable <your_os>').
  
<h3> <a name="Decide on a tool (set)."> Decide on a tool (set). </a> </h3>

First of all, we need to decide on our tool (set) for creating and managing our virtual Python environments. There are quite a few candidates. For instance:

<ul>
  <li>The <code class="folder">venv</code> module, that comes shipped with Python (i.e., is part of the standard library).</li>
  <li>The <code class="folder">virtualenv</code> module.</li>
  <li>The <code class="folder">pipenv</code> module.</li>
  <li>The <code class="folder">anaconda</code> module.</li>
  <li>And many more ...</li>
</ul>

I will not go into the differences in capabilities nor into the specific comparative pro's and con's of these, as there is a <i>plethora</i> of online posts on these topics. For instance <a href="https://www.pluralsight.com/tech-blog/managing-python-environments/" target="_blank">this one<a> or <a href="https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe" target="_blank">this one.

Here we will simply choose <code class="folder">virtualenv</code>, as most or all of the other candidates either are too simple (e.g. <code class="folder">venv</code>) or boast way too much other functionality (e.g. <code class="folder">pipenv</code> and <code class="folder">anaconda</code>). Moreover, <code class="folder">virtualenv</code> comes accompanied with a module named <code class="folder">virtualenvwrapper</code> that, as it's name suggests, serves as a wrapper to <code class="folder">virtualenv</code>. This wrapper provides us with all kinds of convencience functions that greatly enhance the efficiency of our environment management. Finally, <code class="folder">virtualenv</code> is a <i>very</i> popular tool and you will therefore find lot's of online information for it.

<h3> <a name="Install the chosen tool (set)."> Install the chosen tool (set). </a> </h3>

Assuming you have installed Python, you probably will have <a href="https://realpython.com/what-is-pip/" target="_blank">pip</a> available, which is one of the most used Python package managers and that comes shipped with Python. With pip you can install external, third-party Python packages. That is, packages that are not part of Python's standard library.

To install <code class="folder">virtualenv</code>, simply open a command line and type:

<code class="folder">pip install virtualenvwrapper-win</code>

Since virtualenvwrapper-win is a wrapper for virtualenv and, as such, depends on it, the latter will also be installed:

<a href="/assets/images/install_tool.JPG"><img src="/assets/images/install_tool.JPG" class="small" alt="Installing our tools with pip."></a><br>

So, what we did just now is equivalent to:

<code class="folder">pip install virtualenv</code><br>
<code class="folder">pip install virtualenvwrapper-win</code>

<h3> <a name="Optional: create an environment variable WORKON_HOME."> Optional: create an environment variable WORKON_HOME. </a> </h3>

This step is optional, but recommended. We can set a default target or home directory for our environments. Then we do not have to specify a target directory each time we create a new environment. Additionally, we will not have to specify that path when we activate an environment (activation will be explained later on).

We set a default environment directory by creating a user environment variable. I have chosen the following directory myself:

<a href="/assets/images/env_vars.JPG"><img src="/assets/images/env_vars.JPG" class="small" alt="Setting the workon_home environment variable." style="border:2px solid black"></a><br>

If you do not know how to create such a variable, please query a web search engine: 'add environment variable <your_os>'.

<h3> <a name="Create a virtual Python environment."> Create a virtual Python environment. </a> </h3>
