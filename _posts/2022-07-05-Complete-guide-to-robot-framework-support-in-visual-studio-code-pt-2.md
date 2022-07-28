---
tags: visual-studio-code VSC language-server-protocol language-server LSP Robot-Framework robotframework testautomation testframeworks
title: Complete guide to Robot Framework support in Visual Studio Code - Installation
toc: tocvsc.html
comments_id: 15

---

<br>

<h1 class="post"> <a name="Introduction."> Introduction. </a> </h1>

After having introduced the Robot Framework Language Server in the <a class="postanchor" href="https://michaelhallik.github.io/blog/2022/06/21/Complete-guide-to-robot-framework-support-in-visual-studio-code-pt-1" target="_blank">previous entry</a>, we will now install our development stack. 

Please note that all instructions have been written with Windows in mind. The screen shots have been made on a Dutch Windows 10 Pro system.

<h1 class="post"> <a name="What's in this article."> What's in this article? </a> </h1>

<ol>
	<li><a class="postanchor" href="#Install Python.">Install Python</a>.</li>
	<li><a class="postanchor" href="#Create a virtual Python environment.">Create a virtual Python environment</a>.</li>
	<li><a class="postanchor" href="#Install our test automation stack">Install our test automation stack</a>.</li>
	<li><a class="postanchor" href="#Install Visual Studio Code">Install Visual Studio Code</a>.</li>
	<li><a class="postanchor" href="#Install the required Visual Studio Code extensions">Install the required Visual Studio Code extensions</a>.</li>
	<li><a class="postanchor" href="#Configure the RF Language Server extension">Configure the RF Language Server extension</a>.</li>
	<li><a class="postanchor" href="#Test the installation">Test the installation</a>.</li>
	<li><a class="postanchor" href="#Next steps">Next steps</a>.</li>
</ol>

<h1 class="post"> <a name="Install Python.">Install Python.</a> </h1>

1. Download and run the installer (<code class="folder">click an image to enlarge</code>):

	<div style="display: inline-block">
		<div style="width: 50%; float: left">
			<figure>
				<img id="img_01" onClick="enlargeImage(this.id)" src="/assets/images/1_Python_download_page.JPG" class="postimage" alt="The Python for Windows download page." width="61%">
				<br>
				<figcaption>
					Go to the <a class="postanchor" href="https://www.python.org/downloads/windows/" target="_blank">Python for Windows download page </a> and download the latest, stable release for Python 3. At the time of writing, this was Python 3.10.5.
					<br><br>
					Typically you want the "Windows installer (64-bit)".
					<br><br>
					Go to the folder containing the download and double-click the installer.
				</figcaption>
			</figure>
			
		</div>
		<div style="width: 50%; float: right">
			<figure>
				<img id="img_02" onClick="enlargeImage(this.id)" src="/assets/images/2_Py_inst_1.JPG" class="postimage" alt="Python installation wizard step 1." width="100%">
				<br>
				<figcaption>
					Python installation wizard step 1.
					<br><br>
					Required: Add Python 3.10 to PATH.
					<br>
					Recommended: Install launcher for all users.
				</figcaption>
			</figure>
		</div>
	</div>

	<div style="display: inline-block">
		<div style="width: 50%; float: left">
			<figure>
				<img id="img_03" onClick="enlargeImage(this.id)" src="/assets/images/2_Py_inst_2.JPG" class="postimage" alt="Python installation wizard step 2." width="100%">
				<br>
				<figcaption>
					Python installation wizard step 2.
					<br><br>
					Required: pip.
					<br>
					Recommended: py laucher.
				</figcaption>
			</figure>
		</div>
		<div style="width: 50%; float: right">
			<figure>
				<img id="img_04" onClick="enlargeImage(this.id)" src="/assets/images/2_Py_inst_3.JPG" class="postimage" alt="Python installation wizard step 3." width="100%">
				<br>
				<figcaption>
					Python installation wizard step 3.
					<br><br>
					Required: Add Python to environment variables.
					<br>
					Recommended: Install for all users.
				</figcaption>
			</figure>
		</div>
	</div>

	<div style="display: inline-block">
		<div style="width: 50%; float: left">
			<figure>
				<img id="img_05" onClick="enlargeImage(this.id)" src="/assets/images/2_Py_inst_4.JPG" class="postimage" alt="Python installation wizard step 4." width="100%">
				<br>
				<figcaption>
					Python installation wizard step 4.
				</figcaption>
			</figure>
		</div>
		<div style="width: 50%; float: right">
			<figure>
				<img id="img_06" onClick="enlargeImage(this.id)" src="/assets/images/2_Py_inst_5.JPG" class="postimage" alt="Python installation wizard step 5." width="100%">
				<br>
				<figcaption style="margin-right: 25%; margin-left: 25%">
					Python installation wizard step 5.
				</figcaption>
			</figure>
		</div>
	</div>

2. Verify the installation at the command line by entering:

		Python -V

	Like this:

	<figure>
		<img id="img_07" onClick="enlargeImage(this.id)" src="/assets/images/3_1_check_install_cmd.JPG" class="postimage" alt="Verify the installation." width="40%">
		<br>
		<figcaption>A successful installation.</figcaption>
	</figure>

3. If step 2 failed with a message like the following:

		'python' is not recognized as an internal or external command, operable program or batch file

	<ol type="a">
		<li>Make sure that the following folders of your Python installation have been added as values to your PATH environment variable: <br><br>
			<ul>
				<li>C:\Python\Python310\ (required)</li>
				<li>C:\Python\Python310\Lib\site-packages\ (recommended)</li>
				<li>C:\Python\Python310\Scripts\ (required)</li>
			</ul><br>

		(Naturally, you need to replace the Python version number to match your own configuration.) <br><br>
		
		You can check and, if needed, add the folders as follows: <br><br>
		
		<div style="display: inline-block">
			<div style="width: 50%; float: left">
				<figure>
					<img id="img_08" onClick="enlargeImage(this.id)" src="/assets/images/4_path_01.JPG" class="postimage" alt="Search and open environment variables." width="70%">
					<br>
					<figcaption>
						1. On your Windows system, search for 'envir' (or 'variab' on many non-English systems).
						<br><br>
						2. Click 'Edit environment variables for your account' (rather than 'Edit the system environment variables').
						<br><br>
						(See the <a class="postanchor" href="https://superuser.com/questions/949560/how-do-i-set-system-environment-variables-in-windows-10" target="_blank">Source</a> of this image. All other screen shots, images, etc. are my own.)
					</figcaption>
				</figure>
			</div>
			<div style="width: 50%; float: right">
				<figure>
					<img id="img_09" onClick="enlargeImage(this.id)" src="/assets/images/4_path_02.JPG" class="postimage" alt="Edit the PATH variable." width="100%">
					<br>
					<figcaption>
						3. Locate and then edit the 'path' variable in either the system variables or the user variables (see <a class="postanchor" href="https://stackoverflow.com/questions/4477660/what-is-the-difference-between-user-variables-and-system-variables" target="_blank">here</a> for the difference).
						<br><br>
						If you don't have such a variable, create one first, using the 'New' button.
					</figcaption>
				</figure>
			</div>
		</div>
		
		<div style="display: inline-block">
			<div style="width: 100%; float: center">
				<figure>
					<img id="img_10" onClick="enlargeImage(this.id)" src="/assets/images/4_path_03.JPG" class="postimage" alt="Python installation wizard step 5." width="60%">
					<br>
					<figcaption style="margin-right: 25%; margin-left: 25%">
						4. Add at least the two required paths (as mentioned above) as values to the PATH variable (but preferably all three.
						<br><br>
						5. Apply and close all dialogs.
						<br><br>
						6. The new values will only be available in command line windows that are opened from now on. Existing, already opened windows will not yet know the new values of the PATH variable.
					</figcaption>
				</figure>
			</div>
		</div>

		</li><br>
		<li>Now repeat step 2 (but in a <i>new, freshly opened</i> command line window).</li><br>
		<li>If you still get the same (or a different) error message, you're gonna have to apply some Google-fu.</li>
	</ol>

<h1 class="post"> <a name="Create a virtual Python environment.">Create a virtual Python environment.</a> </h1>

I won't go into the questions of what a virtual environment is and what the advantages are of using one. Please see <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/02/Running-Robot-Framework-in-a-virtual-environment-pt-2" target="_blank">this earlier post</a> to read more about Python virtual environments.

Here, we'll simply create a virtual environment. We will employ it later in our RF projects, by <i>binding</i> that environment to the Robot Framework language server extension.

<h2 class="post"> <a name="Install virtualenvwrapper-win.">Install virtualenvwrapper-win.</a> </h2>

To create a Python virtual environments we will need a suitable tool.

Here, we will use virtualenvwrapper-win.

See <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/03/Running-Robot-Framework-in-a-virtual-environment-pt-3#Decide%20on%20a%20tool%20(stack)." target="_blank">the relevant section </a> of yet another post for some background information on this particular tool and about virtualenv itself (which is being reused by virtualenvwrapper-win).

To install the tool, execute the following command:

	pip install virtualenvwrapper-win

This should result in something like this:

<figure>
	<img id="img_11" onClick="enlargeImage(this.id)" src="/assets/images/5_install_virt_env.JPG" class="postimage" alt="Installing virtualenvwrapper-win on the command line." width="100%">
	<br>
	<figcaption>Installing virtualenvwrapper-win on the command line.</figcaption>
</figure>

<ul>
	<li>Note 1: read another article's <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/03/Running-Robot-Framework-in-a-virtual-environment-pt-3#Introducing%20pip." target="_blank">section on pip</a> if you want to know more about it.</li> <br>
	<li>Note 2: if you receive an error message stating that pip cannot be found, please consult this <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/03/Running-Robot-Framework-in-a-virtual-environment-pt-3#No%20pip%20available." target="_blank">troubleshooting section</a> of the same article.</li>
</ul>

<h2 class="post"> <a name="Create a default home directory for virtual environments.">Create a default home directory for virtual environments.</a> </h2>

Add a 'WORKON_HOME' user environment variable:

<figure>
	<img id="img_12" onClick="enlargeImage(this.id)" src="/assets/images/6_WORKON_HOME.JPG" class="postimage" alt="Set a default working directory for virtualenvwrapper-win." width="75%">
	<br>
	<figcaption>Set a default working directory for virtualenvwrapper-win.</figcaption>
</figure>

See the <a class="postanchor" href="#Install%20Python." target="_blank">Install Python (<i>step 3</i>)</a> section above for instructions on how to create a (user) environment variable.

If you'd like to know what this is and why we need it, please see <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/03/Running-Robot-Framework-in-a-virtual-environment-pt-3#Optional:%20create%20an%20environment%20variable%20WORKON_HOME" target="_blank">this article's section on the WORKON_HOME variable</a>.

<h2 class="post"> <a name="Create the actual virtual environment.">Create the actual virtual environment.</a> </h2>

We will use the <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/04/Running-Robot-Framework-in-a-virtual-environment-pt-4#About%20the%20mkvirtualenv%20command." target="_blank">mkvirtualenv</a> command to create a virtual Python environment named 'robotframework'.

	mkvirtualenv robotframework

If, by any chance, you have <i>multiple</i> Python versions installed on your system, you will need to use the -p switch to specify the Python version that you'd like the virtual environment to be based on:

	mkvirtualenv -p 3.10 robotframework

If you have multiple Python versions, but <i>omit</i> the -p switch, then virtualenv will use the Python version that is the first (going top down) on your PATH (see above).

As mentioned, 'robotframework' will be the <i>name</i> of our virtual environment. Naturally, in a real-life context (especially when multiple virtual environments are in use) you'd probably use a more descriptive, meaningful name.

Running the appropriate <code class="folder">mkvirtualenv</code> command will create a virtual environment in our WORK_HOME target folder:

<figure>
	<img id="img_13" onClick="enlargeImage(this.id)" src="/assets/images/7_create_env.JPG" class="postimage" alt="Search and open environment variables." width="100%">
	<br>
	<figcaption>A successfully executed <code class="folder">mkvirtualenv</code> command.</figcaption>
</figure>

The prefix <code class="folder">(robotframework)</code> on the command line indicates that the environment has not only been created, but has also been <i>activated</i> as well. If you want to know more about this (or about the mkvirtualenv command in particular), please see the first two sections of <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/04/Running-Robot-Framework-in-a-virtual-environment-pt-4" target="_blank">this earlier post</a>.

The <code class="folder">mkvirtualenv</code> command will create a folder structure in our WORKKON_HOME folder.
<figure>
	<img id="img_14" onClick="enlargeImage(this.id)" src="/assets/images/7_create_env_02.JPG" class="postimage" alt="Edit the PATH variable." width="100%">
	<br>
	<figcaption>Our virtual Python environment has been created in the form of a folder structure.</figcaption>
</figure>

The root folder of this structure is named 'robotframework', since that is the name that we gave to our virtual env.

If you want to learn more about this folder structure, please read the <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/02/Running-Robot-Framework-in-a-virtual-environment-pt-2#What%20does%20a%20virtual%20environment%20look%20like?" target="_blank">relevant section</a> of this article.

For now, we can exit the command line and move on to the next step.

<h1 class="post"> <a name="Install our test automation stack">Install our test automation stack.</a> </h1>

We are now ready for the installation of Robot Framework and required test libraries.

Let's start with the former.

First we need to activate the virtual environment that we want to use in our future RF projects (and that we will therefore have to bind to the RF VSC extension later on). By activating that environment on the command line, our stack will not be installed <i>globally</i>, but only for (i.e. within) the relevant virtual environment.

Therefore we will use the virtualenvwrapper-win <code class="folder">workon</code> command to activate the environment and subsequently use the pip <code class="folder">install</code> command to install RF into the activated env.

<figure>
	<img id="img_15" onClick="enlargeImage(this.id)" src="/assets/images/8_1_robotframework.JPG" class="postimage" alt="Activate our virt env and install Robot Framework into it." width="100%">
	<br>
	<figcaption>Activate our virt env and install Robot Framework into it.</figcaption>
</figure>

If you want to know how the (de-) activation of a virt env is accomplished technically, please see <a class="postanchor" href="http://localhost:4000/blog/2021/02/04/Running-Robot-Framework-in-a-virtual-environment-pt-4#Activating%20and%20deactivating%20a%20virtual%20environment" target="_blank">this section on the inner workings of the 'workon' command</a> and <a class="postanchor" href="http://localhost:4000/blog/2021/02/04/Running-Robot-Framework-in-a-virtual-environment-pt-4#How%20is%20this%20accomplished?" target="_blank">this section on what happens 'under the hood'</a>.

To install test libraries, such as the BrowserLibrary or SoapLibrary, you can also use <code class="folder">pip install</code>. Here we will do so, but in combination with using a <a class="postanchor" href="https://pip.pypa.io/en/latest/user_guide/#requirements-files" target="_blank">requirements file</a> (click the image to download it):

<figure>
	<a href="/downloads/requirements_vsc_install.txt" download="requirements_vsc_install.txt"><img src="/assets/images/8_2_requirements-txt_00.JPG" class="postimage" alt="Contents of the requirements file." width="70%"></a>
	<br>
	<figcaption>Contents of the requirements file. <br><br> Click the image to download the plain text requirements file.</figcaption>
</figure>

This is an example file. Please make sure to delete all lines that install packages that you are not interested in (and/or add lines for other packages).

On the command line, make sure that our environment is activated and issue the command:

	pip install -r requirements.txt

Like this:

<figure>
	<img id="img_16" onClick="enlargeImage(this.id)" src="/assets/images/8_2_requirements-txt_01.JPG" class="postimage" alt="Activate the virtual env and initiate the installation." width="70%">
	<br>
	<figcaption>Activate the virtual env and initiate the installation.</figcaption>
</figure>

Of course, you may have to specify the path to the file, e.g.:

	pip install -r C:\Tmp\requirements.txt

This will install all packages that are specified in the requirements file.<br><br>

<figure>
	<img id="img_17" onClick="enlargeImage(this.id)" src="/assets/images/8_2_requirements-txt_02.JPG" class="postimage" alt="Depending on the content of the requirements file, the packages will be collected and installed." width="100%">
	<br>
	<figcaption>Depending on the content of the requirements file, the packages will be collected and installed.</figcaption>
</figure>

<figure>
	<img id="img_50" onClick="enlargeImage(this.id)" src="/assets/images/8_2_requirements-txt_03.JPG" class="postimage" alt="A successful installation process." width="100%">
	<br>
	<figcaption>A successful installation process.</figcaption>
</figure>

If you want more details, please see this section on <a class="postanchor" href="https://michaelhallik.github.io/blog/2021/02/05/Running-Robot-Framework-in-a-virtual-environment-pt-5#Create%20a%20third%20environment:%20The%20-r%20switch." target="_blank">the -r switch</a>.

<h1 class="post"> <a name="Install Visual Studio Code">Install Visual Studio Code.</a> </h1>

Go to the <a class="postanchor" href="https://code.visualstudio.com/download" target="_blank">VCS download page</a> and download the relevant Windows installer:

<figure>
	<img id="img_18" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-01.JPG" class="postimage" alt="Download the installer." width="75%">
	<br>
	<figcaption>Download the installer.</figcaption>
</figure>

Now follow these steps (<code class="folder">click an image to enlarge</code>):

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_19" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-02.JPG" class="postimage" alt="Start the installer." width="85%" style="margin-top: 20%">
			<br>
			<figcaption>Start the installer, select a language and click the 'OK' button.</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_20" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-03.JPG" class="postimage" alt="Accept the agreement." width="100%">
			<br>
			<figcaption>Accept the agreement and click the 'Next' button.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_21" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-04.JPG" class="postimage" alt="Select a folder." width="100%">
			<br>
			<figcaption>Select a folder and click the 'Next' button.</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_22" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-05.JPG" class="postimage" alt="Create a start menu item (or not)." width="100%">
			<br>
			<figcaption>Create a start menu item (or not) and click the 'Next' button.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_23" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-06.JPG" class="postimage" alt="Red square: recommended installer settings." width="100%">
			<br>
			<figcaption>Red square: recommended installer settings. Click the 'Next' button.</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_24" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-07.JPG" class="postimage" alt="Click the 'Install' button to start the actual installation." width="100%">
			<br>
			<figcaption>Now click the 'Install' button to start the actual installation.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_25" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-08.JPG" class="postimage" alt="Installation in progress." width="100%">
			<br>
			<figcaption>Installation in progress.</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_26" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-09.JPG" class="postimage" alt="Click the marked check box and then the 'Finish' button." width="100%">
			<br>
			<figcaption>Click the 'Launch Visual Studio Code' check box and then the 'Finish' button.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_27" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-10.JPG" class="postimage" alt="Installation finished and VSC started." width="100%">
			<br>
			<figcaption>
				Installation finished and VSC started. Now you might:
				<br><br>
				1. Follow the 'Get Started' wizard to get introduced, to apply some basic configuration (such as a color scheme) and/or to install additional tools (such as Git). <br> 2. Mark the Wizard as 'Done' and ... .
				<br>
				3. ... close the Wizard.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_28" onClick="enlargeImage(this.id)" src="/assets/images/9_vsc-11.JPG" class="postimage" alt="Wizard closed and File Explorer activated." width="100%">
			<br>
			<figcaption>Wizard closed and VSC 'File Explorer' activated.</figcaption>
		</figure>
	</div>
</div>

<h1 class="post"> <a name="Install the required Visual Studio Code extensions">Install the required Visual Studio Code extensions.</a> </h1>

Since we may write test automation code in Python, let's first install the Python extension (<code class="folder">click an image to enlarge</code>):

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_29" onClick="enlargeImage(this.id)" src="/assets/images/10_1_extensions_py-01.JPG" class="postimage" alt="Install Python extension - step 1." width="100%">
			<br>
			<figcaption>
				1. Activate the Extensions pane.
				<br>
				2. Type 'Python' into the search bar.
				<br>
				3. Select the MS Python extension.
				<br>
				4. Click the 'Install' button.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_30" onClick="enlargeImage(this.id)" src="/assets/images/10_1_extensions_py-02.JPG" class="postimage" alt="The extension will be installed.." width="100%">
			<br>
			<figcaption>The extension will be installed.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 100%; float: center">
		<figure>
			<img id="img_31" onClick="enlargeImage(this.id)" src="/assets/images/10_1_extensions_py-03.JPG" class="postimage" alt="Assign the relevant path to the 'Robot > Python: Executable' setting." width="50%"></a>
			<br>
			<figcaption style="margin-right: 25%; margin-left: 25%">
				Installation finished. Note that we do not need to install Python, since we have done that already.
			</figcaption>
		</figure>
	</div>
</div>

Now, let's install the Robot Framework extension in the same fashion (<code class="folder">click an image to enlarge</code>): 

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_32" onClick="enlargeImage(this.id)" src="/assets/images/10_2_extensions_rf-01.JPG" class="postimage" alt="Install Python extension - step 1." width="100%">
			<br>
			<figcaption>
				1. Make sure the Extensions pane is active.
				<br>
				2. Type 'Robot Framework' into the search bar.
				<br>
				3. Select the RF Language Server extension by 'RoboCorp'.
				<br>
				4. Click the 'Install' button.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_33" onClick="enlargeImage(this.id)" src="/assets/images/10_2_extensions_rf-02.JPG" class="postimage" alt="The extension will be installed.." width="100%">
			<br>
			<figcaption>The extension will be installed.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 100%; float: center">
		<figure>
			<img id="img_34" onClick="enlargeImage(this.id)" src="/assets/images/10_2_extensions_rf-03.JPG" class="postimage" alt="Assign the relevant path to the 'Robot > Python: Executable' setting." width="50%">
			<br>
			<figcaption style="margin-right: 25%; margin-left: 25%">Installation finished.</figcaption>
		</figure>
	</div>
</div>

<h1 class="post"> <a name="Configure the Python Language Server extension">Configure the Python Language Server extension.</a> </h1>

Now let's see whether the MS Python language server will properly assist us when we code in Python.

To this end, we'll use the well-known <a class="postanchor" href="https://towardsdatascience.com/4-easy-ways-to-beat-fizz-buzz-in-python-cfa2dcb9b813" target="_blank">fizzbuzz exercise</a>. If you click on the first image, the Python file with the code will download.

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<a href="/downloads/fizzbuzz.py" download="fizzbuzz.py"><img src="/assets/images/10_4_extensions_py-cfg-00.JPG" class="postimage" alt="Contents of the Python example file." width="100%"></a>
			<br>
			<figcaption>
				The contents of our Python example file.
				<br>
				(Click the image to download the Python code/file.)
				<br><br>
				We can immediately see the syntax coloring as provided by the Python-LS.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_35" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-01.JPG" class="postimage" alt="An exanple of Python code completion." width="100%">
			<br>
			<figcaption>
				Let's try the code-completion feature, for instance by importing some random module.
				<br><br>
				As soon as we start to type on line 1, auto-complete kicks into action.
			</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_36" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-02.JPG" class="postimage" alt="An exanple of Python code analysis and validation." width="100%">
			<br>
			<figcaption>
				We choose the 'import' keyword and then try to import the requests module.
				<br><br>
				However, as we can see, something is wrong: 'requests' is marked by the LS with a squiggly line. This is an example of code analysis and validation.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_37" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-03.JPG" class="postimage" alt="The VSC terminal." width="100%">
			<br>
			<figcaption>
				But what exactly is the matter?
				<br><br>
				To find out, we can do several things. For instance, start the VSC terminal through menu [Terminal -> New Terminal] or through keystroke [Ctrl + `].
				<br><br>
				If we activate the 'Problems' tab, we get an indication of what is wrong with our Python code. Apparently a module named 'requests' cannot be found.
			</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_38" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-04.JPG" class="postimage" alt="On hover information." width="100%">
			<br>
			<figcaption>
				Another method of getting more information on the error at hand is by hovering over the offending code.
				<br><br>
				If we do so, a dialog will appear with information as to the root cause of the problem and some hints on how to possibly solve it.
				<br><br>
				As we can see, the information is similar to that of the terminal output.
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_39" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-05.JPG" class="postimage" alt="TODO" width="100%">
			<br>
			<figcaption>
				Or course, sooner or later we'll figure out what the underlying issue is, namely that the wrong Python interpreter is bound to the Python-LS.
				<br><br>
				As can be gathered from the VSC status bar, currently the <i>global</i> Python installation is being used. However, we installed all of our packages into a virtual Python environment!
				<br><br>
				So, naturally, the requests module cannot be found, since it is available only within the context of the virtual env.
			</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_40" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-06.JPG" class="postimage" alt="TODO" width="100%">
			<br>
			<figcaption>
				Thus, we'll have to bind the correct Python interpreter to the Python-LS.
				<br><br>
				One way of doing this within VSC is by clicking on the current interpreter in the status bar. This will produce a list of known, available interpreters (global and/or virtual). Just like in the status bar, we can see here which interpreter is currently selected.
				<br><br>
				We can simply click on the desired interpreter to select it. So, let's activate our virtual Python environment and see what happens!
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_41" onClick="enlargeImage(this.id)" src="/assets/images/10_4_extensions_py-cfg-07.JPG" class="postimage" alt="TODO" width="100%">
			<br>
			<figcaption>
				Well, the problem has been resolved! We can now import requests and start to use all it has to offer.
			</figcaption>
		</figure>
	</div>
</div>

<h1 class="post"> <a name="Configure the RF Language Server extension">Configure the RF Language Server extension.</a> </h1>

We have to perform some basic configuration to get the RF Language Server extension to function properly.

Please note that here we will only apply the most basic of settings. In the follow-up posts we will look at the many other configuration options that the RF Language Server extension provides.

For now, just follow these few steps (<code class="folder">click an image to enlarge</code>):

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_42" onClick="enlargeImage(this.id)" src="/assets/images/10_3_extensions_rf-cfg-00.JPG" class="postimage" alt="Make sure the Extensions pane is active and click the gear-icon of the RF-LS extension button." width="100%">
			<br>
			<figcaption>Make sure the Extensions pane is active and click the gear-icon of the RF-LS extension control.</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_43" onClick="enlargeImage(this.id)" src="/assets/images/10_3_extensions_rf-cfg-01.JPG" class="postimage" alt="Select the 'Extension Settings' menu-item." width="100%">
			<br>
			<figcaption>Select the 'Extension Settings' menu-item.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_44" onClick="enlargeImage(this.id)" src="/assets/images/10_3_extensions_rf-cfg-02.JPG" class="postimage" alt="The previous step opens the RF-LS configuration pane." width="100%">
			<br>
			<figcaption>
				The previous step opens the RF-LS configuration pane.
				<br><br>
				Make sure to activate the 'User' settings!
				<br><br>
				(We'll go into the difference between 'User' and 'Workspace' in the next article.)
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_45" onClick="enlargeImage(this.id)" src="/assets/images/10_3_extensions_rf-cfg-03.JPG" class="postimage" alt="Assign the relevant path to the 'Robot > Language-server: Python' setting." width="100%">
			<br>
			<figcaption>
				Scroll down to the 'Robot > Language-server: Python' setting and enter the path to the python.exe of the virtual Python environment that we created earlier.
				<br><br>
				This will make sure that the language server will run within the context of our virtual Python environment. There is no reason to use another Python instance than the one that we will also employ for coding and running our RF tests (see the next step).
			</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 100%; float: center">
		<figure>
			<img id="img_46" onClick="enlargeImage(this.id)" src="/assets/images/10_3_extensions_rf-cfg-04.JPG" class="postimage" alt="Assign the relevant path to the 'Robot > Python: Executable' setting." width="50%">
			<br>
			<figcaption style="margin-right: 25%; margin-left: 25%">
				Scroll further down to the 'Robot > Python: Executable' setting.
				<br><br> Through this option we can make sure that when we (1) code tests and when we (2) run them (from within VSC) through the relevant facilities of the RF-LS extension, we will then employ the automation stack as installed within the designated virtual Python environment.
				<br><br> Since we have assigned the correct environment to the language server itself (in the previous step), you may also leave this field empty.
			</figcaption>
		</figure>
	</div>
</div>

<h1 class="post"> <a name="Test the installation">Test the installation</a> </h1>

Let's do a quick check to see whether the installed development stack functions properly. As follows (<code class="folder">click an image to enlarge</code>):

<div style="display: inline-block">
	<div style="width: 50%; float: left">
		<figure>
			<img id="img_47" onClick="enlargeImage(this.id)" src="/assets/images/11_1_test-install-01.JPG" class="postimage" alt="Create a new text file." width="100%">
			<br>
			<figcaption>
				1. Make sure the File Explorer pane is active.
				<br><br>
				2. Press [Ctrl + n] (or use the File menu) to create a new file. This will open a new, plain text file.
				<br><br>
				3. Press [Ctrl + k, m] to open the 'Select Language Mode'. Alternatively, you could click 'Select a language' as seen on line 1 of the text file. Or you might click on 'Plain Text' on the right side of the VSC status bar (see the red square in the screen shot).
			</figcaption>
		</figure>
	</div>
	<div style="width: 50%; float: right">
		<figure>
			<img id="img_48" onClick="enlargeImage(this.id)" src="/assets/images/11_1_test-install-02.JPG" class="postimage" alt="Select the Robot Framework language." width="100%">
			<br>
			<figcaption>Type 'Robot' into the 'Select Language Mode' search bar and subsequently click the 'Robot Framework (robotframework)' item.</figcaption>
		</figure>
	</div>
</div>

<div style="display: inline-block">
	<div style="width: 100%; float: center">
		<figure>
			<img id="img_49" onClick="enlargeImage(this.id)" src="/assets/images/11_1_test-install-03.JPG" class="postimage" alt="The Robot Framework Language Server extension will be activated." width="50%">
			<br>
			<figcaption style="margin-right: 25%; margin-left: 25%">
				For a second or so, you'll see <code class="folder">Activating Extensions ...</code> appearing on the left side part of the status bar.
				<br><br> Afterwards you'll notice that the file type icon has changed into our friendly neighborhood robot.
				<br><br> Moreover, on the right side of the status bar, 'Plain Text' has been exchanged for 'Robot Framework'.
			</figcaption>
		</figure>
	</div>
</div>

With that behind us, let's try some simple Robot Framework development to complete our little test! To that purpose, let's first save our file (using <code class="folder">[Ctrl + s]</code>) and then write and run a very simple demo test case.

<div class="video">
	<video controls="controls" name="media" style="width:100%" title="test_installation">
		<source src="/assets/videos/test_installation.mp4" controls="controls">
	</video>
</div>

Even in this simple demo case we can see several RF-LS services in action, such as syntax highlighting/coloring, syntax analysis & validation and code completion.

Also note that upon saving the file, it's extension had been correctly (and 'automagically') set to <code class="folder">.robot</code>. Similarly, where we to open a <code class="folder">.robot</code> (or <code class="folder">.resource</code>) file in the File Explorer, the RF-LS extension would also be activated for the code in that file.

<h1 class="post"> <a name="Next steps">Next steps</a> </h1>

We now have a working development stack.

However, there are a lot of very interesting configuration options that may boost our productivity.

These options pertain to the Robot Framework Language Server extension as well as to Visual Studio Code itself.

In the next couple of posts we will therefore take a look at some of these options, so as to understand their purpose, their inner working and how to optimize our development environment (and productivity) through them.

So please stay tuned for the next part!