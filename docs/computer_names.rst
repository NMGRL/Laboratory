==================
Computer Names
==================

------------
Mac
------------
To connect from a Mac use the Finder, *Go > Connect To Server...* (|cmd|-K)

.. |cmd| CMD 

Enter the address of the computer you 
would like to connect to. 

To file share prepend the address with ``afp://`` ::

	afp://pychron.local
	or
	afp://129.138.12.153


To screen share use ``vnc://`` ::

	vnc://pychron.local
	or
	vnc://129.138.12.153
	
	
If a connection is made you will be prompted for a ``username`` and ``password``. 

**Enter the username and password of the computer you are trying to connect to**.
 
=============== ============ ============== ================== =====================
Computer        Username     Address        short address      Task
=============== ============ ============== ================== =====================
Pychron mini    pychron      129.138.12.153 pychron.local      Extraction Line, CO2
Obama iMac      obama        129.138.12.136 obama.local        Mass Spec Master
Jan iMac        jan          129.138.12.150 jan.local          Mass Spec Master
Diode mini      diode        129.138.12.134 diode.local        Diode
UV mini         uv           129.138.12.132 uv.local           UV
ArgonLab1 iMac  argonlab1    129.138.12.138 argonlab1.local    Lab computer
ArgonLab2 iMac  argonlab2    129.138.12.143 argonlab2.local    Lab computer
Replicator iMac dbreplicator 129.138.12.157 dbreplicator.local Databse replication
=============== ============ ============== ================== =====================

-------------
Windows
-------------
============= ======== ============== =============
Computer      Username Address        Task
============= ======== ============== =============
ObamaArgus    Thermo   129.138.12.145 Qtegra
JanArgus      Thermo   129.138.12.152 Qtegra
============= ======== ============== =============

To connect to a Windows computer using a remote desktop client such as `TightVNC <http://www.tightvnc.com>`_ 
or `Chicken of the VNC <http://sourceforge.net/projects/cotvnc/>`_