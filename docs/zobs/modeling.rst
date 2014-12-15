===================
Modeling
===================

Producing MDD Models
----------------------

​All MDD modeling codes can be run from the command line or through the Pychron
GUI. Going from the database to model is easy with Mass Spec, Pychron, and the
MDD programs. The most basic workflow to produce a thermal history model is
below. Each step is detailed further below.
 
	#. `Data Export from Database`_
	#. `Parsing Autoupdate Files into MDD Files`_
	#. `Running MDD Programs`_
		a. Files
		b. Autoarr
		c. Autoagemon
		d. Autoagefree
		e. The other MDD programs can be used as needed
	
	#. `Data Viewing with Pychron`_


Data Export from Database
-----------------------------
​Exporting data from the database is easy with Mass Spec. I suggest saving
autoupdate files to the Modeling folder in the Pychron tree
``~/Pychrondata/data/modeling``
 
	#. Open Mass Spec.
	#. Hit Command-U to open up the autoupdate dialog box.
	#. Uncheck all boxes. Make sure Write / Export drop box is set to “Full raw data”.
	#. Click OK. A save dialog should pop up. Name it however you want.
	#. Add the analyses of interest to the “Selected Runs” box. Do not use graph or group markers.
	#. Hit OK. Now your list should be where ever you saved it.
	#. To get the raw data in a MDD-code compatible format, parse the autoupdate file in Pychron.
 
Parsing Autoupdate Files into MDD Files
-------------------------------------------
 
​In the past this has been done with Excel, but Python’s autoupdate handling is
faster, easier, and less quirky. Autoupdate parsing in Pychron removes negative
ages, causing less snags during modeling. It can handle an autoupdate containing
several spectra. It gives each sample its own folder (named with the sample name
ie Run-ID) and containing a SAMPLE.IN file, which is compatible with my modified
MDD programs.
 
	#. Open Pychron ::
	
		$ cd ~/Programming/mercurial/pychron
		$ python launchers/pychron.py	
		
	#. On the tool bar at the top of the screen, click ``MDD`` and select ``Parse Autoupdate``
	#. Select autoupdate file
	#. A window will pop up asking what temperature and time offsets you would like to apply to the dataset
		a. Temperature offset is in °C
		b. Time offset is in minutes
	#. Click “Ok”. Now there should be a folder called autoupdatename_data, which should contained multiples folders. Each of these folders should contain files for each of the unique run-id’s contained in the autoupdate file.
	#. “Parse Autoupdate” also automatically runs the ``files_py`` program, which assumes that (a) you don’t want to read files from a list or exclude any points. If you would prefer, you can manually re-run ``files`` on that folder via the command line to enable those options.	
		
Running MDD Programs
-------------------------
To run these through Pychron, click on ``MDD`` in the toolbar at the top of the
screen. Click on the “Modeling” button in the drop down menu and from there
select your program. Once you choose a program, a file navigation window will
pop up. Navigate to the folder which contains the sample you want to run the
program on. Select the folder and hit the “choose” button in the bottom right
corner of the navigation window. A parameter selection window will pop up. Fill
it out as instructed below.
 
Running MDD programs requires navigating to the folder which contains the
MDD files in the console. Typically, this folder will have a runID for a
name. Once you’re there, typing the executable name (in quotes below) will
run that specific program. Note that the executable name is the name you
apply when compiling these programs, so they may differ from mine. These can
be run either through Pychron or the command line. To run these through the
command line, you must first navigate to the folder of interest.

	#. Mddfiles_lst.f – ``files``
		a.	Breaks SAMPLE.in into several smaller files used by the different.programs. Calculates a preliminary set of kinetic parameters.
		#.	Always the first program you need to run before any other MDD codes.
		#.	This program is run on every sample when an autoupdate is parsed via pychron. You will not need to run it explicitly ever.
	
	#. Autoarr.f – ``autoarr``
		a. Allows you to calculate or dictate kinetic parameters for the sample.
		#. Parameter entry box:
			i. Check the first box if you want to automate parameter selection. Any values placed into the following boxes are ignored. Uncheck if you want to dictate your own parameters. Entering 0 will use the default value.
			#. Number of max domains
				 8 is default, max 10
			#. Number of min domains
				 3 is default, min 2
			#. Keep Do fixed?
				“Yes” should be your default answer, but is not the program’s default setting
			#. Activation energy in Kcal/mol
			#. Ordinate of Arrhenius plot
			#. Max plateau of Log(R/Ro)

	#. Autoage-mon.f – ``autoagemon``
		a. Calculates cooling histories. Assumes monotonic cooling.
		#. Prints the current run number so you’re aware of progress. ::
		
			$ Insert number of runs
			$ 50 is typical, more is better. Max 299.
			$ Insert max plateau age

	#. Autoage-free.f – ``autoagefree``
		a. Calculates cooling histories. Allows reheating events.
		#. If you’re running this on the new macs, it’s pretty fast so do as many as you want. ::
		
			$ Insert number of runs
			               100 is typical, more is better. Max 399.
			$ Insert max plateau age
			$ Create contour matrices? 
			                Always say yes, it doesn’t make it take longer. If
			                you want them later, you have to rerun the whole
			                model.
			$ Insert minimum age

	#. Arrme.f – ``arrme``
		a. Asks for model geometry
	
	#. Corrfft.f – ``corrfft``
		a. Calculates correlation between LogR/Ro and Arrhenius plots.
		#. Fmin and Fmax are the ends of the range of %39Ar you want to check for correlation. Setting this range explicitly allows you to avoid steps. which have excess Ar or are post-melting.
		#. Correlation output into file ``cross.dat``.
	
	#. Agesme.f – ``agesme``
		a. Calculates a model spectrum from known kinetics, DD dimensions, and thermal history.
						
Data Viewing with Pychron
-----------------------------
Evaluation of data and production of graphs is best performed in Pychron. It is
capable of displaying the major MDD plots, including spectra, Arrhenius plots,
Log(r/ro), unconstrained and constrained thermal history models.

Make sure the MDD Perspective is enabled. If your window isn’t similar to
FIGURE, you may be in the Hardware Perspective. Several windows are available
here to aid in data reduction (FIGURE). These windows can be reorganized simply
by dragging them around the window. Therefore, your MDD perspective may not look
exactly like this but it should have all of the same components, although they
may be redistributed.

	A. The Data Window (Far Left)
		The Data window contains a refresh button, which refreshes the graphs. Below
		that is a list of samples. Each sample has a series of check boxes and color
		indicators. “Show” toggles all of the data for that sample on the graphs. “Bind”
		forces the primary and secondary colors to be the same in all plot windows for
		that particular sample. “Ms” toggles the model spectrum produced by Agesme.
		“IMs” toggles the model spectra produced by thermal history modeling. “Ma”
		toggles the model Arrhenius and Log(r/ro) plots. Sometimes the Refresh button
		must be used to display those changes. All samples on this list will be shown in
		the Modeler window.
		
		Five small buttons are on the upper right corner of this window which (left to
		right) (a) disable column sorting, (b and c) move samples up or down the list,
		which changes their stacking order in the Modeler window, (d) removes a sample
		from the list and (e) opens a preferences window.
		
		Below the list of displayed samples is a navigation window. Simply clicking on a
		sample folder will add it to the list above.

	#. The Summary Window (Top Center)
		The Summary window displays the kinetic parameters and domain distribution for
		the sample highlighted in the Data Window.
	
	#. The Notes Window (Bottom Center)
		The Notes window is basically just a data entry window for a text file. Each
		sample folder has a Notes.txt file which is editable in this window. Any
		information regarding that sample can be saved to that text file and recalled
		simply by click the name of the sample in the Data window. Useful for keeping
		track of why you chose certain kinetic parameters, why the sample is important,
		or any other information you would like to be able to recall later.
	
	#. The Modeler Window (Far Right)	
		The Modeler window displays the samples selected in the Data window.

	#. Process Window
		Displays Fortran Process history