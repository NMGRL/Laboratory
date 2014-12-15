========================
|CO2| Stage Calibration
========================

.. |CO2| replace:: CO\ :sub:`2`

#. Move the laser to the center hole. 

#. Select the correct stage map e.g ``221-hole``

#. Select ``pychron-auto`` as the calibration style

#. Hit ``Calibrate``


Pychron will now automatically find up to five calibration holes. The calibration holes are
specified on the third line of the stage map file e.g ``221-hole.txt``. The calibration holes
should be the N,E,S,W, and center holes.

Using the calibration holes Pychron calculates the center position and rotation of the tray. 
With an accurate calibration, Pychron will then move to each hole and determine a corrected position.
This will take a few minutes.

--------------------------
Autofocus
--------------------------

Pychron has an auto focus feature that can produce a very sharp image. 
Configuration allows you to use various alogrithms to calculate the *focus measure*
of an image. I find the Laplace filter with ~50% zoom produces a nice result. 
Autofocus is actual a misnomer in this case. What is really happenig is called passive focus.
The *focus measure* is calculated by applying a mathematical filter the the image. These filters
are used for example to calculate the gradient between adjacent pixels. Theoretically maximizing 
the gradient yields the most focused image. For more information see 
`Autofocus <http://en.wikipedia.org/wiki/Autofocus>`_

Hit ``Autofocus`` to perform an autofocus routine

