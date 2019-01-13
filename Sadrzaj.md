**Sadrzaj repozitorijuma**
	*Linux_on_zybo.pdf*
		*Uputstvo koje opisuje postupak spustanja projekta na zybo plocu.
	*Boot_Files*
		*Sadrzi fajlove koji treba da se dobiju ukoliko se isprate koraci prethodno pomenutog uputstva.
	*VGA_on_zybo.pdf*
		*Kratak opis sistema koji se u ovom primeru spusta na zybo razvojnu plocu.
	*VGA_BRAM_Project*
		*Sadrzi Vivado projekat koji implementira sistem opisan u prethodnom pdf-u. Kako bi se projekat automatski napravio potrebno je pokrenuti Master.tcl skriptu. To se radi tako sto se prvo pokrene Vivado a zatim se klikne na Tools -> Run Tcl Script... a zatim se pronadje fajl Master.tcl, selektuje se a zatim se klikne na Open. Potrebno je sacekati dok se proces ne zavrsi. 
	*SDK_Test_Files*
		*Sadrzi jednostavan test program za proveravanje funkcionalnosti sistema u Xilinx SDK alatu. [napomena za pokretanje iz SDK potrebno je da jumper JP5 na Zybo ploci bude podesen na JTAG, krajnji desni polozaj]
	*PyImg*
		*Sadrzi python skriptu koja prebacuje .png sliku u niz hex vrednosti. Potrebno je imati instaliran python na racunaru. Kao parametre proslediti ime slike sa ekstenzijom npr. lena.png, za x rezoluciju 256 a za y rezoluciju 144.
	*Driver_App*
		*Sadrzi dva direktorijuma u kojima se nalaze drajver i aplikacija za dati hardver. Nakon sto drajver ukljuci u kernel (insmod), on ocekuje sledeci format instrukcije x,y,rgb [npr. echo "100,50,0xabcd" > /dev/vga] pri cemu ce se iscrtati piksel boje rgb=0xabcd na poziciju x=100 i y=50 od gornjeg levog ugla ekrana. Aplikacija na ovakav nacin redom prosledjuje drajveru sve piksele test slike.
