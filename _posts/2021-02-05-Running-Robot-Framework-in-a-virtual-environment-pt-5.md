---
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework
title: Python, virtual environments and Robot Framework - Creating environment/project ecosystems
toc: tocvirtenv.html
comment_id: 7

---
<br>

<h1 class="post"> <a name="Introduction."> Introduction. </a> </h1>

As was announced at the end of the <a class="postanchor" href="http://127.0.0.1:4000/blog/2021/01/18/Running-Robot-Framework-in-a-virtual-environment-pt-4">previous article</a>, we will now proceed and create some additional environments.

We can create as many environments as are required or desired. Those environments may be based on the same and/or other Python versions. For instance, let's create:

1. an environment based on the exact same Python base installation as before (3.7.9)
2. an environment based on another version (3.8.7)
3. an environment based on yet another version (3.9.1)

This time, in the course of creating an environment, we will also install one or more third-party packages with it.

That will effectively create ecosystems for our environments and, thus, for the projects that we subsequently will associate (bind) to those environments.

<h1 class="post"> <a name="Create a second environment."> Create a second environment: The -i switch. </a> </h1>

We will base our second environment on the same Python version that we used for our first environment. As long as we provide different environment names, we can base multiple environments on the same Python system installation.

This time we will also supply the '-i' option to the <code class="folder">mkvirtualenv</code> command. With this switch we tell <code class="folder">virtualenvwrapper-win</code> to also install a <i>package</i> into the created environment. We can even repeatedly apply the -i switch, so as to install multiple packages. Let's try that out by installing Robot Framework and RIDE (i.e. the Robot Framework IDE) with the command:

<code class="snippet">mkvirtualenv -p 3.7 -i robotframework -i robotframework-ride robot-framework_322-py_37</code>

This command will create a virtual environment and subsequently populate that environment with the latest, stable versions of Robot Framework and RIDE (plus dependencies).

Like so:

	(robot-framework-py_37) C:\Users\Michael Hallik>mkvirtualenv -p 3.7 -i robotframework -i robotframework-ride robot-framework_322-py_37
	created virtual environment CPython3.7.9.final.0-64 in 534ms
	  creator CPython3Windows(dest=C:\Python-virtual-environments\robot-framework_322-py_37, clear=False, no_vcs_ignore=False, global=False)
	  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=C:\Users\Michael Hallik\AppData\Local\pypa\virtualenv)
		added seed packages: pip==20.3.3, setuptools==51.3.3, wheel==0.36.2
	  activators BashActivator,BatchActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
	Collecting robotframework
	Installing collected packages: robotframework
	Successfully installed robotframework-3.2.2
	Collecting robotframework-ride
	Collecting wxPython=4.0.7.post2
	...
	Installing collected packages: six, pillow, numpy, wxPython, Pywin32, PyPubSub, Pygments, robotframework-ride
	Successfully installed PyPubSub-4.0.3 Pygments-2.7.4 Pywin32-300 numpy-1.19.5 pillow-8.1.0 robotframework-ride-1.7.4.2 six-1.15.0 wxPython-4.0.7.post2

	(robot-framework_322-py_37) C:\Users\Michael Hallik>

Note that, apparently, it doesn't matter whether you had an active environment or not. If you issue the <code class="folder">mkvirtualenv</code> command while an existing environment is active, then that environment will simply be deactivated and the newly created environment will be activated after it's creation.

Now, let's take a quick look at some components of the newly created environment:

	(robot-framework_322-py_37) C:\Users\Michael Hallik>python -V
	Python 3.7.9
	(robot-framework_322-py_37) C:\Users\Michael Hallik>robot --version
	Robot Framework 3.2.2 (Python 3.7.9 on win32)
	(robot-framework_322-py_37) C:\Users\Michael Hallik>python
	Python 3.7.9 (tags/v3.7.9:13c94747c7, Aug 17 2020, 18:58:18) [MSC v.1900 64 bit (AMD64)] on win32
	>>> import sys
	>>> sys.executable
	'C:\\Python-virtual-environments\\robot-framework_322-py_37\\Scripts\\python.exe'
	>>> import robot
	>>> print(robot.__path__)
	['C:\\Python-virtual-environments\\robot-framework_322-py_37\\lib\\site-packages\\robot']

We can also now run RIDE in the context of our new environment:

	(robot-framework_322-py_37) C:\Users\Michael Hallik>ride.py
	
<a href="/assets/images/ride_in_env.jpg"><img src="/assets/images/ride_in_env.jpg" class="postimage" alt="Commands after deactivation." width="100%"></a><br>

As you can see, we now have an isolated and fully functioning and active second environment based on the same Python system installation as before. Through the -i switch we have populated that environment with a few third-party libraries.

However, a (minor) disadvantage of using the -i switch to install packages, is that we cannot specify a package <i>version</i>. E.g. when we would like to install an older version of e.g. Robot Framework, we can't do this through the -i switch. Moreover, the more packages we want to install, the longer our command will become, due to a multitude of '-i [package-name]' clauses.

Luckily there is a less cumbersome approach for installing packages together with a new environment. So let's take a look at that.

<h1 class="post"> <a name="Create a third environment."> Create a third environment: The -r switch. </a> </h1>

Again, we will create an environment <i>and</i> install some third-party packages with it.

But this time we will use a very nice pip feature. That is, we will use a <a class="postanchor" href="https://pip.pypa.io/en/latest/user_guide/#requirements-files" target="_blank">requirements file</a>, which is simply a plain text file that we can use to specify the packages that we want to install into our new environment.

This is the requirements file that we'll use (<i>click the image and you'll get the text</i>):

<a href="/downloads/requirements_1.txt"><img src="/assets/images/requirements_file.JPG" class="postimage" alt="Commands after deactivation." width="100%"></a><br>

As you can see, we can (optionally) specify a version for a package. This overcomes the limitation of the -i switch. Additionally, installing a multitude of packages becomes more efficient and manageable than when having to specify everything in our command.

Using the -r switch we can direct virtualenvwrapper-win (and thus <code class="folder">pip</code>) to our requirements file:

<code class="snippet">mkvirtualenv -p 3.8 -r C:\Tmp\requirements.txt robot-framework_303-py_38</code>

Let's give it a try:

	(robot-framework_322-py_37) C:\Users\Michael Hallik>mkvirtualenv -p 3.8 -r C:\Tmp\requirements.txt robot-framework_303-py_38
	created virtual environment CPython3.8.7.final.0-64 in 543ms
	  creator CPython3Windows(dest=C:\Python-virtual-environments\robot-framework_303-py_38, clear=False, no_vcs_ignore=False, global=False)
	  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=C:\Users\Michael Hallik\AppData\Local\pypa\virtualenv)
		added seed packages: pip==20.3.3, setuptools==51.3.3, wheel==0.36.2
	  activators BashActivator,BatchActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
	Collecting robotframework==3.0.3
	Collecting robotframework-ride
	Collecting wxPython=4.0.7.post2
	...
	Installing collected packages: six, pillow, numpy, wxPython, Pywin32, PyPubSub, Pygments, robotframework-ride, robotframework
	Successfully installed PyPubSub-4.0.3 Pygments-2.7.4 Pywin32-300 numpy-1.19.5 pillow-8.1.0 robotframework-3.0.3 robotframework-ride-1.7.4.2 six-1.15.0 wxPython-4.0.7.post2

A quick look at our environment shows that we have a completely new context to execute our Python commands/scripts in:

	(robot-framework_303-py_38) C:\Users\Michael Hallik>python -V
	Python 3.8.7
	(robot-framework_303-py_38) C:\Users\Michael Hallik>robot --version
	Robot Framework 3.0.3 (Python 3.8.7 on win32)
	(robot-framework_303-py_38) C:\Users\Michael Hallik>python
	Python 3.8.7 (tags/v3.8.7:6503f05, Dec 21 2020, 17:59:51) [MSC v.1928 64 bit (AMD64)] on win32
	>>> import sys
	>>> sys.executable
	'C:\\Python-virtual-environments\\robot-framework_303-py_38\\Scripts\\python.exe'
	>>> import site
	>>> site.getsitepackages()
	['C:\\Python-virtual-environments\\robot-framework_303-py_38', 'C:\\Python-virtual-environments\\robot-framework_303-py_38\\lib\\site-packages']
	>>> import robot
	>>> print(robot.__path__)
	['C:\\Python-virtual-environments\\robot-framework_303-py_38\\lib\\site-packages\\robot']

<h1 class="post"> <a name="Create a fourth environment."> Create a fourth environment. </a> </h1>

Finally, let's create a fourth environment. This time around, we'll install only one package, the latest, stable version of Robot Framework.

<code class="folder">mkvirtualenv -P 3.9 -i robot-frameworkrobot-framework-py_39</code>

We have now four environments at our disposal:

1. Python 3.7.9 (we had no packages installed)
2. Python 3.7.9 / RF 3.1.2 / RIDE 1.7.4.2
3. Python 3.8.x / RF 3.0.3 / RIDE v2.0b2.dev1
4. Python 3.9.x / RF 3.2.2

<h1 class="post"> <a name="Installing packages in existing environments."> Installing packages into existing environments. </a> </h1>

Of course we can also populate <i>existing</i> environments with third-party packages. Naturally, this is regardless whether we had or had not installed packages when we had created those environments with <code class="folder">mkvirtualenv</code>.

For instance, let's populate our first environment with a bunch of Robot Framework test libraries.

If the environment is not currently active, then first issue the <code class="folder">workon</code> command and subsequently run <code class="folder">pip</code>. For instance:

	C:\Users\Michael Hallik>workon robot-framework-py_37
	(robot-framework-py_37) C:\Users\Michael Hallik>pip install robotframework
	Collecting robotframework
	Using cached robotframework-3.2.2-py2.py3-none-any.whl (623 kB)
	Installing collected packages: robotframework
	Successfully installed robotframework-3.2.2
	(robot-framework-py_37) C:\Users\Michael Hallik>

We can also use a requirements file, like this one (<i>click the image and you'll get the text</i>):

<a href="/downloads/requirements_2.txt"><img src="/assets/images/requirements_file_2.JPG" class="postimage" alt="Commands after deactivation." width="35%"></a><br>

We could use this file to further populate our first environment (note that the 'robotframework' line of the requirements file will already be satisfied and thus skipped):

	(robot-framework-py_37) C:\Users\Michael Hallik>pip install -r C:\Tmp\requirements.txt
	Requirement already satisfied: robotframework in c:\python-virtual-environments\robot-framework-py_37\lib\site-packages (from -r C:\Tmp\requirements.txt (line 8)) (3.2.2)
	Collecting lxml==4.4.2
	Collecting robotframework-requests==0.7.2
	Collecting six
	Collecting RESTinstance
	Collecting robotframework-appiumlibrary
	Collecting Appium-Python-Client>=0.28
	Collecting jsonpointer-2.0-py2.py3-none-any.whl (7.6 kB)
	...
	Installing collected packages: pycparser, zipp, typing-extensions, six, cffi, urllib3, pynacl, ply, importlib-metadata, idna, filelock, distlib, decorator, cryptography, ...
	...
	(robot-framework-py_37) C:\Users\Michael Hallik>

Issuing the command:

<code class="snippet">pip freeze</code>

will show us the newly installed packages:

<a href="/assets/images/pip_freeze_py37.JPG"><img src="/assets/images/pip_freeze_py37.JPG" class="postimage" alt="Commands after deactivation." width="35%"></a><br>

Doing a:

<code class="snippet">pip freeze</code>

for our third environment will show us this:

<a href="/assets/images/pip_freeze_py38.JPG"><img src="/assets/images/pip_freeze_py38.JPG" class="postimage" alt="Commands after deactivation." width="57%"></a><br>

The same will go for our fourth environment.

So, as expected, the packages installed per requirements files where installed for the second environment exclusively.

<h1 class="post"> <a name="Next steps."> Next steps. </a> </h1>

We have created four virtual environments and populated some of them. Some during their creation and some afterwards. We can install packages separately or in a 'batch', using a requirements file.

As you can see, we are completely free to install anything into any environment. This offers maximum flexibility and offers a lot of possibilities when it comes to creating different tool stacks.

Let's look at some of these possibilities in <a class="postanchor" href="/_pages/underconstruction">the next post</a>.
