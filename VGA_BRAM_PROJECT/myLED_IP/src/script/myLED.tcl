variable dispScriptFile [file normalize [info script]]

proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}

set sdir [getScriptDirectory]
cd [getScriptDirectory]

# KORAK#1: Definisanje direktorijuma u kojima ce biti smesteni projekat i konfiguracioni fajl
set resultDir ..\/..\/result\/myLED
file mkdir $resultDir
create_project pkg_led ..\/..\/result\/myLED -part xc7z010clg400-1 -force


# KORAK#2: Ukljucivanje svih izvornih fajlova u projekat
add_files -norecurse ..\/hdl\/myLed_v1_0_S_AXI.v
add_files -norecurse ..\/hdl\/myLed_v1_0.v
add_files -fileset constrs_1 ..\/xdc\/myLED.xdc
update_compile_order -fileset sources_1

# KORAK#3: Pokretanje procesa sinteze
launch_runs synth_1
wait_on_run synth_1
puts "*****************************************************"
puts "* Sinteza zavrsena! *"
puts "*****************************************************"

# KORAK#4: Pokretanje procesa implementacije i generisanja konfiguracionog fajla
#set_property STEPS.WRITE_BITSTREAM.TCL.PRE [pwd]\/pre_write_bitstream.tcl [get_runs impl_1]
#launch_runs impl_1 -to_step write_bitstream
#wait_on_run impl_1
#puts "*******************************************************"
#puts "* Implementacija zavrsena! *"
#puts "*******************************************************"

# KORAK#5: Kopiranje konfiguracionog fajla u release folder
#file copy -force ..\/..\/result\/myLED\/pkg_led.runs\/impl_1\/myLED_IP_V1_0.bit ..\/..\/release\/myLED\/myLED.bit 

# KORAK#6: Pakovanje Jezgra
update_compile_order -fileset sources_1
ipx::package_project -root_dir ..\/..\/ -vendor xilinx.com -library user -taxonomy /UserIP -force

set_property vendor FTN [ipx::current_core]
set_property name myLED_IP [ipx::current_core]
set_property display_name myLED_IP_V1_0 [ipx::current_core]
set_property description {ip za pristup LED} [ipx::current_core]
set_property company_url http://www.ftn.uns.ac.rs [ipx::current_core]
set_property vendor_display_name FTN [ipx::current_core]
set_property taxonomy {/UserIP} [ipx::current_core]
set_property supported_families {zynq Production} [ipx::current_core]

set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths ..\/..\/ [current_project]
update_ip_catalog
ipx::check_integrity -quiet [ipx::current_core]
ipx::archive_core ..\/..\/myLED_IP_V1_0.zip [ipx::current_core]
close_project
