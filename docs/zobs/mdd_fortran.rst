========================
Building MDD Fortran 
========================


​Tested on Windows 7, PPC Mac (10.5), and Intel Mac (10.6/10.7)
 
 
Before trying to compile your own binaries, try using the ones packages with the pychron source. 
They are located in ``~/Programming/mercurial/pychron/src/modeling/lovera/bin``

Compile for Mac OSX
---------------------
	#. Install Xcode.
		a. Download from `Apple Developer Center <https://developer.apple.com/xcode/>`_
		
		#. Although Xcode is free, you must have an Apple account which requires a credit card number.

	#. Install Ifort (Intel Fortran Composer). You can get a trial from their website, but it only lasts a month so don’t waste it, or you can buy the academic license for ~$280.
		a. Download Ifort (`link <http://google.com>`_)
		
		#. Register with Intel (`link <https://registrationcenter.intel.com/RegCenter/AutoGen.aspx?ProductID=1524&AccountID=&EmailID=&ProgramID=&RequestDt=&rm=EVAL&lang= .>`_)
		
		#. During installation, it will ask if you want to perform a Command line install, or xcode integration environment, or both – select both.
	
	#. Open Terminal and navigate to Pychron's Lovera directory::
	
		$ cd ~/Programming/mercurial/pychron/src/modeling/lovera
		
	#. Compile source code.
		a. Pychron provides a python script to automate the building of the mdd
		   codes. It is located in the Pychron Lovera directory. ::
			
			$ ./build.py 	
			
			
		   if you receive the following error. ::
			
			-bash: ./build.py: Permission denied
			
		   the build.py script is not executable on your computer. Use ``chmod`` to make executable ::
		
			$ chmod +x ./build.py
			
			
		#. **Or**, to compile manually use ``Ifort PROGRAM.f EXECUTABLE –save`` ::
			
			$ Ifort autoage-mon.f autoagemon –save


		   PROGRAM.f is the name of the file you want to compile
			
		   EXECUTABLE is the name of the executable file, ie what you type into the console to run that program.
			
		   On windows, replace “-save” with “/qsave”
				
	#. Add the compile codes to the ``PATH`` environment variable::
		
		$ open ~/.profile
		
	   This will open the .profile file in a text editor. Add ``export
	   PATH=~/Programming/mercurial/pychron/modeling/lovera/bin:$PATH`` to the
	   file. Save and close::
		
		$ source ~/.profile
		
	#. Now you’re ready to model.
	
	#. To use the Pychron integrated modeling codes, you must compile those
	   separately with specific names, i.e files_py, autoarr_py, autoagemon_py,
	   autoagefree_py, confint_py, corrfft_py, agesme_py, and arrme_py.  If you use the build.py script
	   simply enable the pychron flag::
	
		$ ./build.py --pychron 
		
		
build.py
-------------
    .. code-block:: python
	    
        #!/usr/bin/python
        #===============================================================================
        # Copyright 2012 Jake Ross
        # 
        # Licensed under the Apache License, Version 2.0 (the "License");
        # you may not use this file except in compliance with the License.
        # You may obtain a copy of the License at
        # 
        #   http://www.apache.org/licenses/LICENSE-2.0
        # 
        # Unless required by applicable law or agreed to in writing, software
        # distributed under the License is distributed on an "AS IS" BASIS,
        # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        # See the License for the specific language governing permissions and
        # limitations under the License.
        #===============================================================================
        
        #============= local library imports  ==========================
        import subprocess
        import os
    
        def ifort_build(name, out):
            subprocess.call(['Ifort', name, out, '-save'])
        
        def build(files, is_pychron):
            path = os.path
            p = path.join(path.dirname(os.getcwd()), 'bin')
            if not path.exists(p):
                os.mkdir(p)
            
            for f in files:
                out = '{}_py'.format(f) if is_pychron else f
                print 'building', out
                ifort_build(f, '../bin/{}_test'.format(out))
        
        def main(args):
            files = ['files', 'autoarr', 'autoagemon',
            'autoagefree', 'confint', 'corrfft', 'agesme', 'arrme']
            
            build(files, args.pychron)
        
        if __name__ == '__main__':
            import argparse
            parser = argparse.ArgumentParser(description='Build MDD fortran source')
            parser.add_argument('-p', '--pychron',
                            action='store_true',
                            default=False,
                             help='build binaries with _py extension')
            args = parser.parse_args()
            
            main(args)
        
        #============= EOF =============================================
