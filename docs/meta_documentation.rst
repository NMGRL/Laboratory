=======================
Meta Documentation
=======================

This page provides information on how is website is hosted.

We use a few different technologies to keep everything seamlessly up to date.

#. `Mercurial <http://mercurial.selenic.com/>`_ (hg) used for version control (VCS). 

#. `Google Code <http://code.google.com/p/arlab>`_  hosts the master pychron repository. The NMGRL server retreives and builds the documentation automatically nightly using a cron script.

#. :ref:`crontab_label`. Crontab is a Unix tool used for executing code periodically.

#. `Sphinx <http://sphinx.pocoo.org>`_ is a python tool for making professional quality documentation. A PDF of the documentation is available upon request.

.. _crontab_label:

Crontab
----------------
This is the current crontab running. It runs the :ref:`nb_label` script at 11:00pm every night
::

	0 23 * * * $HOME/Sites/arlab_docs/nightly_build.sh > $HOME/Sites/arlab_docs/nightly_build.log


.. _nb_label:

nightly_build.sh
----------------

This is the nightly_build.sh script. It performs three tasks

#. ``hg pull`` ... pulls changes from project repository
#. ``hg update`` ... updates the local source with the changes 
#. ``make html`` ... use sphinx to build the html documentation

::

	#!/bin/sh
	PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
	export PATH
	cd /Users/documentation/Sites/arlab_docs
	
	echo "pulling changes"
	hg -v pull 2>&1 > nightly_build.log
	echo "updating source"
	hg -v update 2>&1 > nightly_build.log
	
	make html
	
	
	




