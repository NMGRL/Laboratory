Network Backups
=======================

Computers are backed up using Time Machine to external HDDs attached to ArgonServer (3) (129.138.12.131)

Backup Locations
----------------------
In general lab computers are backed up to Backups and users computers are backed up to Backups-1.

=================== ============
Computer            Backup Drive
=================== ============
pychron             Backups
jan                 Backups
obama               Backups
co2                 Backups
diode               Backups
argonlab4/bakeout   Backups-2
foobot              Backups-1
=================== ============

=================== ================
Backup Location     Harddrive
=================== ================
Backups             backups1
Backups-1           backups2
Backups-2           backups4
=================== ================

Server Backup
---------------------
ArgonServer3 is backed up to an external HDD (backups3) using Time Machine.
ArgonServer2 is not backed up. It only is running the MySQL database Server. The databases are replicated to
argonlab4/bakeout and this computer is backed up.