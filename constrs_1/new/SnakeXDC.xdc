# Sync signals
set_property PACKAGE_PIN P19 [get_ports HS]
    set_property IOSTANDARD LVCMOS33 [get_ports HS]
   
set_property PACKAGE_PIN R19 [get_ports VS]
    set_property IOSTANDARD LVCMOS33 [get_ports VS]
        

#red
set_property PACKAGE_PIN G19 [get_ports {COLOUR_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[0]}]
       
set_property PACKAGE_PIN H19 [get_ports {COLOUR_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[1]}]
    
set_property PACKAGE_PIN J19 [get_ports {COLOUR_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[2]}]
       
set_property PACKAGE_PIN N19 [get_ports {COLOUR_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[3]}]       
        
               
#green
set_property PACKAGE_PIN J17 [get_ports {COLOUR_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[4]}]
       
set_property PACKAGE_PIN H17 [get_ports {COLOUR_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[5]}]
        
set_property PACKAGE_PIN G17 [get_ports {COLOUR_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[6]}]
           
set_property PACKAGE_PIN D17 [get_ports {COLOUR_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[7]}]     
    

#blue
set_property PACKAGE_PIN N18 [get_ports {COLOUR_OUT[8]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[8]}]
       
set_property PACKAGE_PIN L18 [get_ports {COLOUR_OUT[9]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[9]}]

set_property PACKAGE_PIN K18 [get_ports {COLOUR_OUT[10]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[10]}]
       
set_property PACKAGE_PIN J18 [get_ports {COLOUR_OUT[11]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {COLOUR_OUT[11]}]       
        
               
 
#clock
set_property PACKAGE_PIN W5 [get_ports CLK]
    set_property IOSTANDARD LVCMOS33 [get_ports CLK]
    


#7-segments
set_property PACKAGE_PIN V7 [get_ports {DEC_OUT[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[7]}]

set_property PACKAGE_PIN U7 [get_ports {DEC_OUT[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[6]}]

set_property PACKAGE_PIN V5 [get_ports {DEC_OUT[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[5]}]
    
set_property PACKAGE_PIN U5 [get_ports {DEC_OUT[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[4]}]

set_property PACKAGE_PIN V8 [get_ports {DEC_OUT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[3]}]
    
set_property PACKAGE_PIN U8 [get_ports {DEC_OUT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[2]}]
        
set_property PACKAGE_PIN W6 [get_ports {DEC_OUT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[1]}]

set_property PACKAGE_PIN W7 [get_ports {DEC_OUT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {DEC_OUT[0]}]
    
    

#choose one of 4 displays   
set_property PACKAGE_PIN U2 [get_ports {SEG_SELECT[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[0]}]
        
set_property PACKAGE_PIN U4 [get_ports {SEG_SELECT[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[1]}]
            
set_property PACKAGE_PIN V4 [get_ports {SEG_SELECT[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[2]}]
                
set_property PACKAGE_PIN W4 [get_ports {SEG_SELECT[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {SEG_SELECT[3]}]
    
    
    
    
#push buttons
set_property PACKAGE_PIN W19 [get_ports BTN_L]
    set_property IOSTANDARD LVCMOS33 [get_ports BTN_L]
        
set_property PACKAGE_PIN T17 [get_ports BTN_R]
    set_property IOSTANDARD LVCMOS33 [get_ports BTN_R]
            
set_property PACKAGE_PIN T18 [get_ports BTN_U]
    set_property IOSTANDARD LVCMOS33 [get_ports BTN_U]
    
set_property PACKAGE_PIN U17 [get_ports BTN_D]
    set_property IOSTANDARD LVCMOS33 [get_ports BTN_D]
    
#RESET
set_property PACKAGE_PIN U18 [get_ports RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports RESET]
    



#set_property PACKAGE_PIN V19 [get_ports {SCORE[3]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {SCORE[3]}]
    
#set_property PACKAGE_PIN U19 [get_ports {SCORE[2]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {SCORE[2]}]
    
#set_property PACKAGE_PIN E19 [get_ports {SCORE[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {SCORE[1]}]
    
#set_property PACKAGE_PIN U16 [get_ports {SCORE[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {SCORE[0]}]
    