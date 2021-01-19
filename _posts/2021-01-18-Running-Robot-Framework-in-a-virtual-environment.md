---
tags: testposttext
tags: Python virtualenvironments virtualenv testautomation testframeworks robotframework

---

<br>

<h2> Introduction. </h2>

A lot has been written on Python virtual environments. There also is an abundance of information on the web concerning the various Python tools to create and manage these environments.

However, there isn't much information on running the Robot Framework in a virtual environment. That is rather odd, since the Robot Framework is the most prominent (generic) test automation framework within the Python eco-system. There are <i>some</i> articles on the topic, but they are all rather sketchy.

This post will provide you with a thorough rundown. As such, it will also dive somewhat into the theory behind virtual environments. I believe knowing the internals of our tool stack makes us more efficient and effective as test (automation) engineers. Therefore, this article will cover the following topics:

<ol>
  <li><a href="#Why virtual environments?">Why virtual environments?</a> </li>
  <li><a href="#But what exactly is a virtual environment?">But what exactly is a virtual environment?</a> </li>
  <li><a href="#Create a virtual environment.">Create a virtual environment.</a> </li>
</ol>

If you just want to know the steps to take for running your Robot Framework in a virtual environment, you can skip the first couple of parts and jump ahead to the third topic. But please note, that even there you may run into information that may be to detailed for your taste. Well, you just will have to suffer a bit, I guess. <p> &#128124;</p>

<h2> <a name="Why virtual environments?"> Why virtual environments? </a> </h2>

Creating a virtual Python environment for your test automation project (and for any kind of development project, for that matter) can be beneficial for many reasons. Among those reasons are:

<ul>
<li> Avoiding dependency hell. <br><br> A project may contain dependencies towards specific versions of certain third party libraries. This may conflict with dependencies within one or more of your other projects. For instance, it may conflict with a project that might require the same Python version, but at the same time requires divergent versions of the same third-party libraries.</li><br>

<li> Keeping your global/base Python installation clean. <br><br> You won't have to clutter your global <code class="folder">site-packages</code> and <code class="folder">Scripts</code> folders when installing third-party libraries and tools for your various projects. Usually an average project will require quite a few packages to be installed. Consequently, the mentioned folders will fill up fast and become rather hulking and unwieldy.</li><br>

<li> Being able to easily share a specific Python environment. <br><br> For instance, in order to facilitate that every contributing team member uses the same Python version and tool/library stack. As we will see in the remainder of this post, utilizing virtual environments makes sharing these environments very easy.</li><br>

<li> Being able to restore your environment, in case of problems related to your environment. <br><br> Let's say, for instance, that you updated a couple of libraries in one step and now find yourself overwhelmed by an avalanche of (mostly obscure) exceptions. Wouldn't it be nice to be able to quickly revert to the original (or last know functioning) environment and try again? Later on we will see just how effortless this can be done with a virtual environment.</li>
</ul>

<h2> <a name="But what exactly is a virtual environment?"> But what exactly is a virtual environment? </a> </h2>

A virtual environment is a self-contained, isolated Python installation that (as such) is independent from any global/system Python installations (and their configurations) as well as from any other virtual Python environments (and their configurations). Within that environment, you can create an eco-system of third party libraries/packages that will be specific and dedicated to that environment (although you <i>can</i> share between environments if necessary).

The installed packages will only be accessible to the Python interpreter of that specific environment. Vice versa, no packages from outside the environment will be accessible to that interpreter. (Again, depending on how you rig your environment(s), you <i>could</i> share artifacts between environments if needed.)

Once you have created an environment that fullfills the requirements of your specific project, you can then proceed and bind the environment to that project. Or to multiple projects that have identical requirements.

Creating a virtual environment generates a (relatively small) directory structure. Depending on the tool (and depending on the parameters you apply when creating the environment) there are some variations within this structure. However, regardless the tool, all virtual environments basically consist of the following three fundamental components:

<ol>
<li> A Python excutable (with a version that you specified). <br><br> This might be a copy of the system executable that you based your environment on or a so-called symlink to that system executable. Again, this will depend on the tool used and on the parameters you selected. </li><br>

<li> The Python \Scripts folder (\bin on Unix/Linux). <br><br> This folder is part of every regular Python installation and also of every virtual environment. It is used by third-party modules/packages (which themselves get installed into the \Lib\site-packages folder) to store scripts and executables that are associated with them. As this folder (together with the root installation folder) gets added to the operating system's PATH variable (provided you chose that option during installation or manually edited PATH afterwards), you can run these scripts/executables from the command line. For instance, when you invoke pip install robotframework from the Windows command line, the excutable pip.exe in the Scripts folder is called, which acts as a wrapper for the pip module in \Lib\site-packages. The same goes for the script ride.py, which is called when you use the command line to start RIDE (Robot Framework Integrated Development Environment) and which, in turn, acts as an entry point to the RIDE package in the \Lib\site-packages folder. </li><br>

<li> The Python \Lib\site-packages folder. <br><br> This folder is used for third-party libraries/packages that are installed. For instance, Robot Framework, RIDE and all installed RF test libraries will reside in this folder. </li>

</ol><br>

Now that we have some background, let's get started! <br>

<h2> <a name="Create a virtual environment."> Create a virtual environment. </a> </h2>

Follow these steps to run Robot Franework within it's own, dedicated environment.
  
<h3> Decide on a tool (set). </h3>

First we need to decide on our tool set for creating and managing virtual Python environments. There are quite a few candidates. For instance:

- the venv mpdule, that is Python comes shipped with the venv module. However

<h3> Install one or more Python versions. </h3>

When creating virtual environments, you might have the need to be able todevelop, run and test code against multiple Python versions. Maybe you need or want to explicietly support multiple Python versions. Maybe your project directly or indirectly depends on a specific, older Python version, while others do not.


