---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework
title: Python, virtual environments and Robot Framework - Creating virtual environments
toc: tocvirtenv.html

---
<br>

<h1 class="post"> <a name="Introduction."> Introduction. </a> </h1>

In his article we will create our first virtual environment and learn a couple of things about how such an environment works. We will also learn how to activate and deactivate environments and how to switch between them:

<ol>
	<li><a class="postanchor" href="#About the mkvirtualenv command.">About the mkvirtualenv command.</a></li>
	<li><a class="postanchor" href="#Create a virtual env with a specific Python version">Create a virtual env with a specific Python version.</a>
	<ol type="a">
	<li><a class="postanchor" href="#A closer look at our new environment.">A closer look at our new environment.</a></li>
	<li><a class="postanchor" href="#How is this accomplished?">How is this accomplished?</a></li>
	</ol>
	</li>
	<li><a class="postanchor" href="#Activating and deactivating a virtual environment">Activating and deactivating a virtual environment.</a></li>
	<li><a class="postanchor" href="#Next steps">Next steps.</a></li>
</ol>

Of course, I am assuming that you have <a class="postanchor" href="/blog/2021/02/02/Running-Robot-Framework-in-a-virtual-environment-pt-3">installed the required software</a>.

I am further assuming that you have <a class="postanchor" href="/blog/2021/02/02/Running-Robot-Framework-in-a-virtual-environment-pt-3#Optional:%20create%20an%20environment%20variable%20WORKON_HOME">created the WORKON_HOME environment variable</a>, as was recommended in the previous article. If not, make sure to specify full path names when applicable.

Since we will use <a class="postanchor" href="https://pypi.org/project/virtualenvwrapper-win/" target="_blank">virtualenvwrapper-win</a>, please note that you'll have to use the 'old school' Windows command prompt: <code class="folder">virtualenvwrapper-win</code> cannot be run from  Windows PowerShell.

Let's get started.

<h1 class="post"> <a name="About the mkvirtualenv command."> About the mkvirtualenv command. </a> </h1>

The command to create a new virtual environment with <code class="folder">virtualenvwrapper-win</code> is:

<code class="snippet">mkvirtualenv</code>

This command has the following structure:

<code class="snippet">mkvirtualenv [mkvirtualenv options] [virtualenv options] [name-of-virt-env]</code>
  
Although only the latter (i.e. name-of-virt-env) is mandatory, typically you will specify at least one or more <a class="postanchor" href="https://virtualenv.pypa.io/en/latest/cli_interface.html" target="_blank">virtualenv options</a> when creating a new virtual environment. Any such option will be passed on by <code class="folder">virtualenvwrapper-win</code> to <code class="folder">virtualenv</code> for processing there.

If I were to issue the command <i>without</i> any <code class="folder">virtualenv</code> options:

<code class="snippet">mkvirtualenv my-env-name</code>

then a virtual environment would be based off from <i>whatever Python system installation is first on my OS'es PATH</i> and would be placed under the specified name into my <code class="folder">WORKON_HOME directory</code>. In my case, the Python version that is first in PATH, is Python 3.9.

However, usually we will want to <i>explicitly</i> specify a Python version for our environment. So let's do that instead.

<h1 class="post"> <a name="Create a virtual env with a specific Python version"> Create a virtual env with a specific Python version. </a> </h1>

We can only specify a Python version for our environment if we have a system installation of that version, as explained in the previous article.

Assuming, then, for instance, that we have a Python 3.7 system installation, we can simply use the <code class="folder">virtualenv -p switch</code> to base a virtual environment off of that specific installation:

<code class="snippet">mkvirtualenv -p C:\Python\Python37\Python.exe robot-framework-py_37</code>

or shorter:

<code class="snippet">mkvirtualenv -p 3.7 robot-framework-py_37</code>

Any of these two commands would create a virtual Python 3.7 environment (named '<code class="folder">robot-framework-py_37</code>') into my default target directory. Like so:

	C:\Users\Michael Hallik mkvirtualenv -p 3.7 robot-framework-py_37
	created virtual environment CPython3.7.9.final.0-64 in 762ms
		creator CPython3Windows(dest=C:\Python-virtual-environments\robot-framework-py_37, clear=False, no_vcs_ignore=False, global=False)
		seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=C:\Users\Michael Hallik\AppData\Local\pypa\virtualenv)
			added seed packages: pip==20.3.3, setuptools==51.3.3, wheel==0.36.2
		activators BashActivator,BatchActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator

<!--
<a href="/assets/images/first_env.jpg"><img src="/assets/images/first_env.jpg" class="postimage" alt="Create a virt env."></a><br>
-->

As can be gathered from the command line output, the newly created virtual environment resides in the folder <code class="folder">C:\Python-virtual-environments\robot-framework-py_37</code>. The created directory structure will look exactly as shown in <a class="postanchor" href="/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-2#What%20does%20a%20virtual%20environment%20look%20like?">the screenshot in the previous article</a>. Because I had created the <code class="folder">WORKON_HOME</code> environment variable with value 'C:\Python-virtual-environments\' (see previous post), that folder is used by <code class="folder">virtualenvwrapper-win</code> as the default target directory for any virtual environment that it creates.

Please note that it depends on the virtualization tool used, which Python components are actually being <i>copied</i> from the base installation into the target directory and which ones will merely be <i>linked</i> to. For instance, a virtualization tool like <code class="folder">env</code> also generates a copy of the <code class="folder">\Include</code> folder (which contains C-headers). A tool like <code class="folder">virtualenv</code>, on the other hand, creates only a link to that folder. Thus, when retrieving the path to the <code class="folder">\Include</code> folder for our new virtual environment, the path to the <code class="folder">\Include</code> folder of the <i>system</i> installation (that served as the basis for that virtual environment) will be returned:

	(robot-framework-py_37) C:\Users\Michael Hallik>python
	Python 3.7.9 (tags/v3.7.9:13c94747c7, Aug 17 2020, 18:58:18) [MSC v.1900 64 bit (AMD64)] on win32
	>>> import sysconfig
	>>> paths = sysconfig.get_paths()
	>>> paths.get('include')
	'C:\\Python\\Python37\\Include'

<!--
<a href="/assets/images/first_env.jpg"><img src="/assets/images/include_path.JPG" class="postimage" alt="Create a virt env."></a><br>
-->

Also note that when a virtualization tool creates <i>links</i> to certain artifacts of the original Python system installation, then problems may arise when you update that base installation. For instance, when you based an environment off of Python 3.7.x and you upgrade the latter to 3.7.z., there may be backwards incompatibility issues between your virtual environment and new versions of linked components within the Python base installation.

<h2 class="post"> <a name="A closer look at our new environment."> A closer look at our new environment. </a> </h2>

Note that our command line prompt now has a 'prefix': <code class="folder">(robot-framework-py_37)</code>. Which is, of course, the name of our virtual environment.

	(robot-framework-py_37) C:\Users\Michael Hallik>

<!--
<a href="/assets/images/pip_version_when_active.JPG"><img src="/assets/images/prompt_after.JPG" class="postimage" alt="Virt env pip is used."></a><br>
-->

This prefix is an indication of the fact that the environment <code class="folder">(robot-framework-py_37)</code> has not only been created, but has also been <i>activated</i>. This means that from now on any Python related command or script (within the current command line session) will be executed within the (isolated) context of this environment. For instance:

	(robot-framework-py_37) C:\Users\Michael Hallik>python -V
	Python 3.7.9

<!--
<a href="/assets/images/py_version_when_active.JPG"><img src="/assets/images/py_version_when_active.JPG" class="postimage" alt="Virt env Python version."></a><br>
-->

The same goes if we were to use the interactive Python interpreter to retrieve the path to the current Python executable:

	(robot-framework-py_37) C:\Users\Michael Hallik>python
	Python 3.7.9 (tags/v3.7.9:13c94747c7, Aug 17 2020, 18:58:18) [MSC v.1900 64 bit (AMD64)] on win32
	>>> import sys
	>>> sys.executable
	'C:\\Python-virtual-environments\\robot-framework-py_37\\Scripts\\python.exe'

<!--
<a href="/assets/images/sys_executable_when_active.JPG"><img src="/assets/images/sys_executable_when_active.JPG" class="postimage" alt="Virt env Python interpreter."></a><br>
-->

Similarly, if we were now to invoke pip to install a third-party package, pip would be executed from the <code class="folder">\Lib\site-packages</code> folder of our virtual environment:

	(robot-framework-py_37) C:\Users\Michael Hallik>pip -V
	pip 21.0 from c:\python-virtual-environments\robot-framework-py_37\Lib\site-packages\pip (python 3.7)

<!--
<a href="/assets/images/pip_version_when_active.JPG"><img src="/assets/images/pip_version_when_active.JPG" class="postimage" alt="Virt env pip is used."></a><br>
-->

Consequently, any such package would be installed into that same folder:

	(robot-framework-py_37) C:\Users\Michael Hallik>python
	Python 3.7.9 (tags/v3.7.9:13c94747c7, Aug 17 2020, 18:58:18) [MSC v.1900 64 bit (AMD64)] on win32
	>>> import site
	>>> site.getsitepackages()
	['C:\\Python-virtual-environments\\robot-framework-py_37', 'C:\\Python-virtual-environments\\robot-framework-py_37\\lib\\site-packages']

<!--
<a href="/assets/images/site_pack_when_activated.jpg"><img src="/assets/images/site_pack_when_activated.jpg" class="postimage" alt="Virt env site-packages."></a><br>
-->

<h2 class="post"> <a name="How is this accomplished?"> How is this accomplished? </a> </h2>

The way this works is that, under the hood, <code class="folder">virtualenv</code> has prepended the path to the <code class="folder">\Scripts</code> folder of our virtual environment to the PATH variable of our current command line session. So, the location of that folder is now the very first value to be found in the PATH variable. Before any other value. But only for the current command line session.

	(robot-framework-py_37) C:\Users\Michael Hallik>echo %path%
	C:\Python-virtual-environments\robot-framework-py_37\Scripts;C:\Python\Python39\;C:\Python\Python39\Scripts\;C:\WINDOWS;etc.

<!--
<a href="/assets/images/echo_path_activated.jpg"><img src="/assets/images/echo_path_activated.jpg" class="postimage" alt="Virt env PATH."></a><br>
-->

Because of this on-the-fly manipulation of the PATH variable, the <code class="folder">\Scripts</code> directory of our virtual environment is now the first folder to be searched when we issue a Python related command. As we have just seen in the example commands.

Consequently, if we were to deactivate (through the <code class="folder">deactivate</code> command) the environment, the PATH variable would be restored to its original state:

	(robot-framework-py_37) C:\Users\Michael Hallik>deactivate
	C:\Users\Michael Hallik>echo %path%
	C:\Python\Python39\;C:\Python\Python39\Scripts\;C:\WINDOWS;etc.

<!--
<a href="/assets/images/echo_path_deactivated.jpg"><img src="/assets/images/echo_path_deactivated.jpg" class="postimage" alt="PATH after deactivation." width="55%"></a><br>
-->

Now every Python related command, script, etc. would be executed by the Python interpreter that is first within the restored PATH environment variable. In my case, that Python interpreter is version 3.9.1. Therefore, when issuing some of the previous commands once more (but now in this context), we get:

	(robot-framework-py_37) C:\Users\Michael Hallik>deactivate
	C:\Users\Michael Hallik>python -V
	Python 3.9.1
	C:\Users\Michael Hallik>pip -V
	pip 20.2.3 from c:\python\python39\lib\site-packages\pip (python 3.9)
	C:\Users\Michael Hallik>python
	Python 3.9.1 (tags/v3.9.1:1e5d33e, Dec  7 2020, 17:08:21) [MSC v.1927 64 bit (AMD64)] on win32
	>>> import sys
	>>> sys.executable
	'C:\\Python\\Python39\\python.exe'
	>>> import site
	>>> site.getsitepackages()
	['C:\\Python\\Python39', 'C:\\Python\\Python39\\lib\\site-packages']

<!--
<a href="/assets/images/commands_when_deactivated.jpg"><img src="/assets/images/commands_when_deactivated.jpg" class="postimage" alt="Commands after deactivation." width="80%"></a><br>
-->

As you can see, everything now runs in the context of my Python 3.9.1 system installation.

<h1 class="post"> <a name="Activating and deactivating a virtual environment"> Activating and deactivating a virtual environment. </a> </h1>

It is important to remember that a virtual environment is activated through manipulation of the PATH variable. But only within a command line session.

Thus, whenever we start a fresh/new command prompt session, we would first have to <i>explicitly activate</i> a virtual environment. Until we do that, any Python related command within that command prompt would be executed against the system/global Python interpreter that is first on the OS PATH.

To activate a virtual environment, we use the <code class="folder">virtualenvwrapper-win</code> command: <code class="folder">workon</code>.

	C:\Users\Michael Hallik>workon robot-framework-py_37
	(robot-framework-py_37) C:\Users\Michael Hallik>

If, for whatever reason, you want to deactivate an active virtual environment, you can use the <code class="folder">deactivate</code> command (as we have already seen):

	(robot-framework-py_37-temp) C:\Users\Michael Hallik>deactivate
	C:\Users\Michael Hallik>

Please note, though, that we can activate another environment without having to deactivate a currently active environment:

	(robot-framework-py_37) C:\Users\Michael Hallik>workon robot-framework-py_37-temp
	(robot-framework-py_37-temp) C:\Users\Michael Hallik>

<h1 class="post"> <a name="Next steps"> Next steps. </a> </h1>

In the next post, we will create additional virtual environments.

Not only that, we will also populate them with thid-party packages. In other words, we'll create ecosystems within those environments and, thus, for our projects for which we created these environments in the first place.

So please join me for <a class="postanchor" href="/blog/2021/02/05/Running-Robot-Framework-in-a-virtual-environment-pt-5">the next part</a>!