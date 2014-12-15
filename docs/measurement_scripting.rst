========================
Measurement Scripts
========================

Example
---------
::

    '''
    '''
    def main():
        '''
        display a message in the Experiment Executor and add to log
        '''
        info('example measurement script')
        
        '''
        define which detectors to collect with
        '''
        activate_detectors('H1','AX','L1','L2','CDD')
        
        '''
        set the fit types
        if a single value is supplied it's applied to all active detectors
        '''
        regress('parabolic')
        
        #or a list of fits the same len as active detectors is required             
        regress('parabolic','parabolic','linear','linear','parabolic')
        
        '''
        position the magnet
        
        position_magnet(4.54312, dac=True) # detector is not relevant
        position_magnet(39.962, detector='AX')
        position_magnet('Ar40', detector='AX') #Ar40 will be converted to 39.962 use mole weight dict
        '''
        
        #position isotope Ar40 on detector H1
        position_magnet('Ar40', detector='H1')
    
        '''
        sniff and split
            
            1. isolate sniffer volumne
            2. equilibrate
            3. sniff gas
            4. test condition
        
        gas is staged behind inlet
        isolate sniffer volume
        '''
        close('S')
        sleep(1)
        
        '''
        equilibrate with mass spec
        set outlet to make a static measurement
        
        set do_post_equilibration to False so that the gas in the microbone
        is not pumped away
        '''
        equilibrate(eqtime=20, inlet='R', do_post_equilibration=False)         
        set_time_zero()
        
        #display pressure wave
        sniff(20)
        
        #define sniff/split threshold
        sniff_threshold=100
        
        #test condition
        if get_intensity('H1')>sniff_threshold:
            extraction_gosub('splits:jan_split')
            '''
            extraction_gosub is same as
            gosub('splits:jan_split', klass='ExtractionLinePyScript')
            '''
    
        '''
        gas has been split down and staged behind the inlet    
        post equilibration script triggered after eqtime elapsed
        equilibrate is non-blocking so use a sniff or sleep as a placeholder
        e.g sniff(<equilibration_time>) or sleep(<equilibration_time>)
        '''
        equilibrate(eqtime=5,inlet='R', outlet='V')
        set_time_zero()
        
        #sniff the gas during equilibration
        sniff(5)
        sleep(1)
        
        '''
        Set conditions
        
        order added defines condition precedence.
        conditions after the first true condition are NOT evaluated
    
        terminate if age < 10000 ma after 5 counts, check every 2 counts
        terminate means do not finish measurement script and immediately execute
        the post measurement script
        '''
        add_termination('age','<',10000, start_count=5, frequency=2)
        
        '''
        truncate means finish the measurement block immediately and continue to next
        command in the script
        '''
        add_truncation('age','>',10.6, start_count=20, frequency=10)
        
        '''
        use add_action to specify an action to take for a given condition
        
        action can be a code snippet 'sleep(10)', 'gosub("example_gosub")' or 
        a callable such as a function or lambda
        
        the resume keyword (default=False) continues measurement after executing
        the action  
        '''
        add_action('age','>',10.6, start_count=20, frequency=10, 
                    action='sleep(10)')
        add_action('age','<',10000, start_count=5, frequency=2,
                      action=func)
        add_action('age','<',10000, start_count=5, frequency=2,
                      action='sleep(7)',
                      resume=True
                      )
        add_action('age','<',10000, start_count=5, frequency=2,
                      action='gosub("snippet")')
    
        #measure active detectors for ncounts
        multicollect(ncounts=50, integration_time=1)
        
        '''
        clear the conditions when measuring baseline 
        also have oppurtunity to add new conditions
        '''
        clear_conditions()
            
        #multicollect baselines for ncounts
        baselines(ncounts=5,mass=39.5)
    
        info('finished measure script')
    
    def func():
        info('action performed')
        
    #=============================EOF=======================================================
