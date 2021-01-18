---
tags: testposttext
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework

---

<br>
<h2> Introduction: why virtual environments? </h2>
<br>
Creating a virtual Python environment for your test automation project (and for any kind of development project, for that matter) can be beneficial for many reasons. Among those reasons are:

<li> Avoiding dependency hell.<br>

A project may contain dependencies towards specific versions of certain third party libraries. This may conflict with dependencies within one or more of your other projects. For instance, it may conflict with a project that might require the same Python version, but at the same time requires divergent versions of the same third-party libraries.</li>

<li> Keeping your global/base Python installation clean.<br>

You won't have to clutter your global site-packages and Scripts folders when installing third-party libraries and tools for your various projects. Usually an average project will require quite a few packages to be installed. Consequently, the mentioned folders will fill up fast and become rather hulking and unwieldy.

<li> Being able to easily share a specific Python environment.<br>

For instance, in order to facilitate that every contributing team member uses the same Python version and tool/library stack. As we will see in the remainder of this post, utilizing virtual environments makes sharing these environments very easy.

<li> Being able to quickly restore/recreate your environment, in case of problems related to your environment.<br>

Let's say, for instance, that you updated a couple of libraries and now find yourself overwhelmed by an avalanche of (mostly obscure) exceptions. Wouldn't it be nice to be able to quickly revert to the original (or last know functioning) environment? Later on we will see just how effortless this can be done with a virtual environment.

<h2> But what exactly is a virtual environment? </h2>

You can see it as a self-contained, isolated Python installation that, as such, is independent from any global/system Python installations (and their configurations) as well as from any other virtual Python environments (and their configurations). Within that environment, you can create an eco-system of third party libraries/packages that will all be specific and dedicated to that environment (although you can optionally share between environments). The installed packages will only be accessible to the Python interpreter of that specific environment. And no other packages (outside the environment) will be accessible. (Again, depending on how you rig your environment(s), you <i>could</i> share artifacts between environments.)

Once you have created an environment that fullfills the requirements of your specific project, you can then proceed and bind the environment to that project. Or to multiple projects that have identical requirements.

Creating a virtual environment generates a (relatively small) directory structure. Depending on the tool and depending on the parameters you apply when creating the environment, there are some variations within this structure. However, regardless the tool, all virtual environments basically consist of the following three fundamental components:

1. A Python excutable (with a version that you specified).

This might be a copy of the system executable that you based your environment on or a so-called symlink to that system executable. Again, this will depend on the tool used and on the parameters you selected.

2. The Python \Scripts folder (\bin on Unix/Linux).

This folder is part of every regular Python installation and also of every virtual environment. It is used by third-party modules/packages (which themselves get installed into the \Lib\site-packages folder) to store scripts and executables that are associated with them. As this folder (together with the root installation folder) gets added to the operating system's PATH variable (provided you chose that option during installation or manually edited PATH afterwards), you can run these scripts/executables from the command line. For instance, when you invoke pip install robotframework from the Windows command line, the excutable pip.exe in the Scripts folder is called, which acts as a wrapper for the pip module in \Lib\site-packages. The same goes for the script ride.py, which is called when you use the command line to start RIDE (Robot Framework Integrated Development Environment) and which, in turn, acts as an entry point to the RIDE package in the \Lib\site-packages folder.

3. The Python \Lib\site-packages folder.

This folder is used for third-party libraries/packages that are installed. For instance, Robot Framework, RIDE and all installed RF test libraries will reside in this folder.

2) Decide on a tool (set).

First we need to decide on our tool set for creating and managing virtual Python environments. There are quite a few candidates. For instance:

- the venv mpdule, that is Python comes shipped with the venv module. However

2) Install one or more Python versions.

When creating virtual environments, you might have the need to be able todevelop, run and test code against multiple Python versions. Maybe you need or want to explicietly support multiple Python versions. Maybe your project directly or indirectly depends on a specific, older Python version, while others do not.

