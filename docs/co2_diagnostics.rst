=======================
|CO2| Diagnostics
=======================

.. |CO2| replace:: CO\ :sub:`2`

This section describes some questions to ask when debugging the Fusions |CO2| Laser System

	**Start with a clear definition of the Problem**
	
	#. Is Pychron running? Is the |CO2| plugin enabled?
	#. Are there any warnings on startup?
	#. When starting does the laser home its beam motor? If so, the progress window will display Homing Beam for a few seconds
	#. Open the laser manager. Is there a view of the sample chamber? Is the ``use_video`` preference enabled?
	#. Can you enable the laser? Red lights turn on Fusion control boxes are illuminated.
	#. Do the red lights stay on for only 7 seconds?
	#. Are the emergency **STOP** buttons depressed?
	#. Is the manual beam blocked in place? Check the knob on the back of the |CO2| laser.