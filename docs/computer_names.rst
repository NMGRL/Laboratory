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
Pychron mini    pychron      153            pychron.local      Extraction Line
Obama iMac      obama        137            obama.local        Pychron Master
Jan iMac        jan          150            jan.local          Pychron Master
Diode mini      diode        134            diode.local        Diode
UV mini         uv           132            uv.local           UV
CO2 mini        argonlab3    133            co2.local          CO2
ArgonLab1 iMac  argonlab1    138            argonlab1.local    Lab computer
ArgonLab2 iMac  argonlab2    143            argonlab2.local    Lab computer
Argonlab4 mini  argonlab4    158            argonlab4.local    Database replication, Bakeout
--------------- ------------ 155            ------------------ Environmental Monitor
--------------- ------------ 157            ------------------ USB server
=============== ============ ============== ================== =====================

-------------
Windows
-------------
============= ======== ============== =============
Computer      Username Address        Task
============= ======== ============== =============
ObamaArgus    Thermo   145            Qtegra
JanArgus      Thermo   152            Qtegra
============= ======== ============== =============

To connect to a Windows computer using a remote desktop client such as `TightVNC <http://www.tightvnc.com>`_ 
or `Chicken of the VNC <http://sourceforge.net/projects/cotvnc/>`_
