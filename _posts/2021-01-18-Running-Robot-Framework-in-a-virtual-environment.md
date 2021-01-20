---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework

---

<br>

<h2> Introduction. </h2>

A lot has been written on Python virtual environments. There also is an abundance of information on the web concerning the various Python tools to create and manage these environments.

However, there isn't much information on running the Robot Framework in a virtual environment. That is rather odd, since the Robot Framework is the most prominent (generic) test automation framework within the Python ecosystem. There are <i>some</i> articles on the topic, but they are all rather sketchy.

This post will provide you with a thorough rundown. As such, it will also dive somewhat into the workings of virtual environments. I believe knowing the internals of our tool stack makes us more efficient and effective as test (automation) engineers. Therefore, this article will cover the following topics:

<ol>
  <li><a href="#Why virtual environments?">Why virtual environments?</a></li>
  <li><a href="#But what exactly is a virtual environment?">But what exactly is a virtual environment?</a></li>
  <li><a href="#And what does a virtual environment look like?">And what does a virtual environment look like?</a></li>
  <li><a href="#Create virtual environments using virtualenv.">Create a virtual environment using virtualenv.</a>
    <ol type="a">
      <li><a href="#Install one or more Python versions.">Install one or more Python versions.</a></li>
      <li><a href="#Decide on a tool (set).">Decide on a tool (set).</a></li>
      <li><a href="#Install the chosen tool (set).">Install the chosen tool (set).</a></li>
      <li><a href="#Optional: create an environment variable WORKON_HOME.">Optional: create an environment variable WORKON_HOME.</a></li>
      <li><a href="#Create your environments.">Create your environments.</a></li>
      <li><a href="#Create your ecosystems.">Create your ecosystems.</a></li>
    </ol>
  </li>
  <li><a href="#Run the Robot Framework in a virtual environment.">Run the Robot Framework in a virtual environment.</a></li>
  <li><a href="#Switch between virtual environments.">Switch between virtual environments.</a></li>
  <li><a href="#Manage virtual environments.">Manage virtual environments.</a></li>
  <li><a href="#Share virtual environments.">Share virtual environments.</a></li>
  <li><a href="#Restore virtual environments.">CRestore virtual environments.</a></li>
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

<h2> <a name="And what does a virtual environment look like?"> And what does a virtual environment look like? </a> </h2>

Creating a virtual environment generates a (relatively) small directory structure. Depending on the tool (and depending on the parameters you apply when creating the environment) there are some variations within this structure. For instance, this is the folder structure for one of my virtual environments, created with the Python module <code class="folder">virtualenv</code>:

<a href="/assets/images/folder_structure.jpg"><img class="postimage" src="/assets/images/folder_structure.jpg" alt="High-level folder structure created by virtualenv." style="border:2px solid black"></a>

Regardless the tool, all virtual environments basically consist of three components:

<ol>
<li> The Python interpreter (with a version that you specified). <br><br> This might be a copy of the system interpreter that you based your environment on or a so-called 'symlink' to that system interpreter. Again, this will depend on the tool used and/or on the parameters you select upon creating the env. </li><br>

<li> The Python <code class="folder">\Scripts</code> folder (<code class="folder">\bin</code> on Unix/Linux). <br><br> This folder is part of every regular Python installation and also of every virtual environment. It is used by third-party modules/packages (which themselves get installed into the \Lib\site-packages folder) to store scripts and/or executables that are associated with them. <br><br> As this folder (together with the root installation folder) gets added to the operating system's PATH variable (provided you chose that option during installation or manually edited PATH afterwards), you can run these scripts/executables from the command line. <br><br> For instance, when you invoke <code class="folder">pip install robotframework</code> from the Windows command line, the excutable <code class="folder">pip.exe</code> in the <code class="folder">Scripts</code> folder is called, which acts as a wrapper for the pip module in <code class="folder">\Lib\site-packages</code>. The same goes for the script <code class="folder">ride.py</code>, which is called when you start RIDE (Robot Framework Integrated Development Environment) from the command line and which, in turn, acts as an entry point to the RIDE package in the <code class="folder">\Lib\site-packages</code> folder. </li><br> Basically, this constellation is there to make sure we can access Python programs through the standard Windows shells, and not having to use the interactive Python interpeter. See this example of the <code class="folder">Scripts</code> folder of my virtual environment:<br><br>

<a href="/assets/images/scripts_folder.JPG"><img src="/assets/images/scripts_folder.JPG" alt="Contents of Scripts folder." class="postimage" width="80%" style="border:2px solid black"></a><br>

You can see that the Python executable is also located here, which, in my case, is a copy of the system Python interpreter and not a symlink.<br><br>

<li> The Python <code class="folder">\Lib\site-packages</code> folder. <br><br> This folder is used for third-party libraries/packages that are installed. For instance, Robot Framework, RIDE and all installed RF test libraries will reside in this folder. </li><br>

See again my own environment as an example:<br><br>

<a href="/assets/images/site_folder.JPG"><img src="/assets/images/site_folder.JPG" alt="Contents of Scripts folder." class="postimage" width="80%" style="border:2px solid black"></a><br>

</ol>

So the three basic types of artifacts, that every virtual Python environment is composed of, are: a Python interpreter, a bunch of Python scripts and a bunch of Python packages (libraries). The scripts and the packages are closely related, as was just explained. <br><br> These three basic components are, as an independant whole, isolated from any other (virtual or system) Python installations.

Now that we have some idea of what a virtual environment is, let's create one! <br>

<h2> <a name="Create virtual environments using virtualenv."> Create a virtual environment using virtualenv. </a> </h2>

To get ourselves a nice virtual environment, we have to take several steps.

These will be outlined in the remainder of this post. Please note that the instructions have been written for Windows (in my case Win 10 Pro). But the whole process is very similar on Linux.

Also we assume <b>Python 3.4 or higher</b>. Anything below that, can and will entail problems later on.

Here we go . . .

<h3> <a name="Install one or more Python versions."> Install one or more Python versions. </a> </h3>

You might have a need to develop, run and test your project code against multiple Python versions, because your project is required to support multiple versions. Or maybe your project directly or indirectly depends on a specific, older Python version, while others do not. Or some of your projects depend on external libraries that need some specific (older) Python version.

When any such a situation is applicable, install the required Python versions. These Python system installations will then be the basis for the various virtual environments to be spawned off of them.

For the sake of this post, I have installed:

<a href="/assets/images/python_versions.JPG"><img class="postimage" src="/assets/images/python_versions.JPG" alt="Contents of Scripts folder." width="85%" style="border:2px solid black"></a><br>

I will not elaborate much on the Python installation process itself, since it is pretty straightforward and since you can easily find the answer to any question (and the solution to any problem) you might have on the web.

<h5> The PATH environment variable. </h5>

Just make sure to add the root (= installation) folder as well as the <code class="folder">\Scripts</code> sub-folder to the PATH environment variable of your operating system. In my case, I put the following on the PATH:

<ul>
  <li>C:\Python39</li>
  <li>C:\Python39\Scripts</li>
</ul>

The installer can do this for you or you must do it manually. If you do not know how to do the latter, please query a web search engine: 'modify path variable <your_os>'.

Note that for our purposes, it will be sufficient to do this for just <i>one</i> of multiple Python versions (assuming you actually have multiple). In our case it is also irrelevant which one you pick. However, having the folders of multiple Python versions added to PATH won't hurt either. Generally, only the first entries that are found are used by the OS or applications that look for Python, while the other entries are then simply ignored. The first entries that will be found, are always those of the Python version that was installed last. But for our purposes none of that matters, as we will see later on. Just have the mentioned folders added to PATH for <i>at least</i> one Python version.

<h5> The Python Launcher. </h5>

It is recommended to activate the option to install the so-called '<a href="https://docs.python.org/3/using/windows.html#launcher" target="_blank">Python launcher</a>' during the installation process. On Windows, this will be in the form of a checkbox within the installer dialog.

<h5> Validate the installation(s). </h5>

To check whether a Python version has been properly installed, you might do a simple test: immediately after each installation, open a command line and type python -V. That should output the version of the Python installation that was installed most recently.

However, that approach assumes that the root and \Scripts folders of that particular Python version were added to PATH during or immediately after installation. In case they were not, you can use another approach. This again assumes that you have installed the 'Python launcher' (see earlier remarks). In case you have, open an command line after you have installed <i>all</i> of the required Python versions and type: py -0. This will output all installed Python versions on your system:

<a href="/assets/images/py_launcher.JPG"><img class="postimage" src="/assets/images/py_launcher.JPG" alt="Contents of Scripts folder." width="60%" style="border:2px solid black"></a><br>

The asterisk indicates which Python version the Python launcher will use by default (always the most recent version installed). By the way, it does <i>not</i> indicate which Python version is first in PATH.
  
<h3> <a name="Decide on a tool (set)."> Decide on a tool (set). </a> </h3>

First of all, we need to decide on our tool (set) for creating and managing our virtual Python environments.

<h5> Candidates. </h5>

There are quite a few candidates. For instance:

<ul>
  <li>The <code class="folder">venv</code> module, that comes shipped with Python (i.e., is part of the standard library).</li>
  <li>The <code class="folder">virtualenv</code> module.</li>
  <li>The <code class="folder">pipenv</code> module.</li>
  <li>The <code class="folder">anaconda</code> module.</li>
  <li>And many more ...</li>
</ul>

<h5> Differences. </h5>

I will not go into the differences in capabilities nor into the specific comparative pro's and con's of these, as there is a <i>plethora</i> of online posts on these topics. For instance <a href="https://www.pluralsight.com/tech-blog/managing-python-environments/" target="_blank">this one</a> or <a href="https://stackoverflow.com/questions/41573587/what-is-the-difference-between-venv-pyvenv-pyenv-virtualenv-virtualenvwrappe" target="_blank">this one</a>.

<h5> We'll use virtualenv. </h5>

Here we will simply choose <a href="https://virtualenv.pypa.io/en/latest/index.html" target="_blank"><code class="folder">virtualenv</code></a>, as most or all of the other candidates either are too simple (e.g. <code class="folder">venv</code>) or boast way too much other functionality (e.g. <code class="folder">pipenv</code> and <code class="folder">anaconda</code>). Moreover, <code class="folder">virtualenv</code> comes accompanied with a module named <a href="https://pypi.org/project/virtualenvwrapper-win/" target="_blank"><code class="folder">virtualenvwrapper</code></a> that, as it's name suggests, serves as a wrapper to <code class="folder">virtualenv</code>. This wrapper provides us with all kinds of convencience functions that greatly enhance the efficiency of the environment management. Also, <code class="folder">virtualenv</code> is a <i>very</i> popular tool and you will therefore find lot's of online information for it. Finally, PyCharm can (re-)use environments that we create manually through <code class="folder">virtualenv</code>. This adds a lot of flexibility when using PyCharm as editor, since the environment options that the IDE itself provides us with, are rather limited.

<h3> <a name="Install the chosen tool (set)."> Install the chosen tool (set). </a> </h3>

For this step you must have modified your PATH environment variable in accordance with what has been said <a href="#Install one or more Python versions.">earlier</a>.

<h5> Introducing pip. </h5>

Assuming you have followed all instructions, you will now have <a href="https://realpython.com/what-is-pip/" target="_blank">pip</a> available. This is one of the most used Python package managers and for that very reason it also comes shipped with Python. With pip you can install external, third-party Python packages. That is, packages that are not part of Python's standard library. Additionally, pip makes it very easy for developers to manage any external dependencies of the various modules in their own package. As a matter of fact, we will use that feature of pip to be able to restore and also share our environments later on.

To see whether you have pip available, open a command line and type:

'pip -V'

<h5> No pip available? </h5>

In case pip is not available, check whether you have Python available: type python -V.

In case Python is not available, check your PATH environment variable (in accordance with what was said <a href="#Install one or more Python versions.">earlier</a>.

In the strange case that Python <i>is</i> available, but pip is <i>not</i>, you can try to re-install Python (make sure to use <b>3.4 or higher</b>) or <a href="https://www.liquidweb.com/kb/install-pip-windows/" target="_blank">install pip manually</a>.

<h5> Install virtualenvwrapper-win. </h5>

To install <code class="folder">virtualenv</code>, simply open a command line and type:

<code class="folder">pip install virtualenvwrapper-win</code>

Since virtualenvwrapper-win is a wrapper for virtualenv and, as such, depends on it, the latter will also be installed:

<a href="/assets/images/install_tool.JPG"><img src="/assets/images/install_tool.JPG" class="postimage" alt="Installing our tools with pip." width="70%"></a><br>

So, what we did just now is equivalent to:

<code class="folder">pip install virtualenv</code><br>
<code class="folder">pip install virtualenvwrapper-win</code>

<h3> <a name="Optional: create an environment variable WORKON_HOME."> Optional: create an environment variable WORKON_HOME. </a> </h3>

This step is optional, but recommended.

We can set a default target or home directory for our environments. That way, we do not have to specify a target directory each time we create a new environment. Similarly, we will not have to specify that directory when we activate an environment (activation will be explained later on).

We set a default environment directory by creating a user environment variable. I have chosen the following directory myself:

<a href="/assets/images/env_vars.JPG"><img src="/assets/images/env_vars.JPG" class="small" alt="Setting the workon_home environment variable." class="postimage" width="65%" style="border:2px solid black"></a><br>

If you do not know how to create such a variable, please query a web search engine: 'add environment variable <your_os>'.

<h3> <a name="Create your environments."> Create your environments. </a> </h3>

We are now finally ready to create our very first virtual environment.

I am assuming that you have <a href="#Optional: create an environment variable WORKON_HOME.">created the WORKON_HOME environment variable</a>.

Since we will use <a href="https://pypi.org/project/virtualenvwrapper-win/" target="_blank"><code class="folder">virtualenvwrapper-win</code></a>, please note that you'll need to use the 'old school' Windows command prompt (as seen in the screen shots below): virtualenvwrapper-win cannot be run from the Windows PowerShell.

<h5>About the mkvirtualenv command.</h5>

The command to create a new virtual environment is <code class="folder">mkvirtualenv</code>.

This command has the following structure: <code class="folder">mkvirtualenv [mkvirtualenv options] [virtualenv options] [name-of-virt-env]</code>
  
Although only the latter (name-of-virt-env) is mandatory, typically you will specify at least one or more <a href="https://virtualenv.pypa.io/en/latest/cli_interface.html" target="_blank">virtualenv options</a> when creating a new virtual env. Any such option will be passed on by virtualenvwrapper-win to virtualenv for processing there.

So, in my case, if I would now issue the command <code class="folder">mkvirtualenv my-env-name</code>, a virtual env with that name would be based off of the Python installation that would be found first in PATH and placed under the specified name into my WORKON_HOME directory.

However, usually we will want to <i>explicitly</i> specifiy the Python version for our environment.

<h5>Create a virtual environment with a specific Python version.</h5>

We can only specify a Python version if we have a system imstallation of that version, as explained earlier. INSERT LINK

Assuming, then, that we have a Python 3.7 system installation, we can simply use the virtualenv -p switch to base a virtual environmen off of that installation:

mkvirtualenv -p C:\Python\Python37\Python.exe robot-framework-py_37

or shorter:

mkvirtualenv -p 3.7 robot-framework-py_37

Any of these two commands would create a virtual Python 3.7 environment (named 'robot-framework-py_37') into my default target directory.

<a href="/assets/images/first_env.jpg"><img src="/assets/images/first_env.jpg" class="postimage" alt="Create a virt env."></a><br>

The created directory structure will look exactly as described above. <INSERT LINK>

Note that the command line prompt now has a 'prefix': (robot-framework-py_37). This is an indication of the fact that that environment has not only been created, but has also 
been <i>activated</i>! This means that from now on any Python related command or script (within the current command line session) will be executed in the (isolated) context of this environment:

<a href="/assets/images/py_version_when_active.JPG"><img src="/assets/images/py_version_when_active.JPG" class="small" alt="Virt env Python version."></a><br>

The same applies were we to use the Python interpreter:

<a href="/assets/images/sys_executable_when_active.JPG"><img src="/assets/images/sys_executable_when_active.JPG" class="postimage" alt="Virt env Python interpreter."></a><br>

Similarly, if we were now to invoke pip to install a third-party package, pip would be executed from C:\Python\Python37\Lib\site-packages:

<a href="/assets/images/pip_version_when_active.JPG"><img src="/assets/images/pip_version_when_active.JPG" class="postimage" alt="Virt env pip is used."></a><br>

Consequently, all such packages would now be installed into C:\Python\Python37\Lib\site-packages:

<a href="/assets/images/site_pack_when_activated.jpg"><img src="/assets/images/site_pack_when_activated.jpg" class="postimage" alt="Virt env site-packages."></a><br>

The way this works is that, under the hood, virtualenv has prefixed the PATH variable for the current command line session with the root and \Scripts folders of our virtual environment:

<a href="/assets/images/echo_path_activated.jpg"><img src="/assets/images/echo_path_activated.jpg" class="postimage" alt="Virt env PATH."></a><br>

Because of this on-the-fly manipulation of the PATH var, the directories of our virtual env now are the first directories to be searched when we issue a Python related command. As we just seen in the example commands.

So, if we were to deactivate the environment, the PATH variable would be restored to it's original state:

<a href="/assets/images/echo_path_deactivated.jpg"><img src="/assets/images/echo_path_deactivated.jpg" class="small" alt="Virt env site-packages. width="55%""></a><br>

Now every Python related command, script, etc. would be executed by the Python interpreter that is first within the PATH environment variable:

<a href="/assets/images/commands_when_deactivated.jpg"><img src="/assets/images/commands_when_deactivated.jpg" class="postimage" alt="After deactivation." width="80%"></a><br>

<h5>Create other required virtual environments.</h5>

We can now proceed and create environments that are based on the same and/or other Python versions.

It doesn't matter whether we have an existing active environment or not. Just issue the mkvirtualenv command. For instance:

<li><a href="#Create your environments.">Create your environments.</a> </li>
<li><a href="#Create your ecosystems.">Create your ecosystems.</a>
