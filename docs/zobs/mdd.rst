=========================================
MDD Code and Pychron Basic Documentation
=========================================

This sections provides information on how to model a K-feldspar using Oscar Lovera's
Multiple Diffusion Domain modeling codes. Pychron provides an easy to use GUI to model and
visualize step heating and diffusion data. Currently Pychron simply wraps Lovera's 
fortran codes with a python GUI and does not do any MDD computations.

This documentation uses Oscar Lovera’s most recent (Summer 2012) MDD fortran codes. These have been edited slightly by Clark Short for compatibility with Clark’s / Pychron’s file folder structure and compiled to run on Intel Macs. Use of this guide requires basic command line proficiency.

.. toctree::
	:maxdepth: 1

	mdd_fortran
	pychron_install
	modeling
	
	
    
    
Overview
--------------------------------------------

Dr. Lovera has produced several programs for the manipulation of MDD-spectrum
data. Entries in this list are Fortran_Source_Name.f – “compiled name” format,
where the fortran source name is the name given by Oscar to the source code and
the compiled name is the name given by me to the executable produced during
compilation. To run any of these programs, a SAMPLE.IN file must be created. It
is easiest to do this by taking data from the database via Mass Spec and parsing
the raw data into a SAMPLE.IN file with Pychron. This can also be done with the
Argon macros in Excel with the “Make Sun Files” command, but Pychron is much
less finicky and handles erroneous points (e.g. negative ages) for you.

Many of these files have the capability to run many models in a row in an
automated fashion. This required all of the SAMPLE.IN files to be kept in one
folder. Then, all subsequent files were kept in that folder. It’s a mess, so I
gave each sample its own folder where all of its related files are kept. Its
much better organized, but has limited the mass modeling capabilities of the
original codes. If you want to model several samples at once, I suggest starting
all models simultaneously in separate terminal tabs instead of doing them
sequentially. This is especially powerful on multicore processors, which most
(all?) modern computers have. A single model cannot use more than 1 core.
Therefore, you can run as many models as you have cores without any decrease in
speed. Even when you’re running more models than cores, Argonlab1 cruises.

Dr. Lovera has produced his own documentation, which should be attached to this
document. It is extremely helpful for determining required input files, content
of output files, and resolving a few naming convention issues. The sample files
included with his software are the best way to figure out formatting issues.
Therefore, much of that information will not be re-stated in this document.

Required software: Mass Spec, MDD codes, Pychron, Terminal, Ifort Fortran Compiler

Outstanding Issues
--------------------------------------------
Oscar used Compaq Visual Fortran (CVF) to compile his codes for 15 years. It's
unique in that it makes a few assumptions that other compilers don't make; we
only snag on one of these differences. Due to an issue with uninitialized
variables we have been unable to compile these on Intel Macs for several years.
In CVF, any uninitialized value is set to 0 (and only usually, and only by
coincidence).

Each program contains several uninitialized values, which influence each program
differently. Instead of digging through 60,000 lines of code to find all
uninitialized variables, you can use the '-save' compiler flag (in Ifort) to
emulate that same auto-zero behavior that Compaq's compiler uses. There are
other potential compatibility issues too, but they haven't come up yet.

Here's a pretty good link for more information on these issues:
`Migrating from Compaq Visual Fortran <http://software.intel.com/en-us/articles/migrating-from-compaq-visual-fortran/>`_

I used the Intel fortran compiler because (1) it should be faster (2) can
automatically optimize a code for the machine it's compiled on, if we want to
try that, and (3) has better documentation than the GNU compiler. I don't know
if gfortran has a similar flag, and if so, what it is.
