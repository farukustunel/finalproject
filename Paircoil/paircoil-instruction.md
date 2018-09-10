
	     ******************************
             **    Instruction.doc for:  **
             ******************************

             ******************************
             **                          **
             **  PAIRCOIL (version 1.0)  **
             **     Copyright 1995 MIT   **
             ******************************  



The paircoil program is described in:

Bonnie Berger, David B. Wilson, Ethan Wolf, Theodore Tonchev, 
	Mari Milla, and Peter S. Kim, "Predicting Coiled Coils by Use 
	of Pairwise Residue Correlations", Proceedings of the National 
	Academy of Science USA, vol 92, aug 1995, pp. 8259-8263.



The paircoil program predicts the location of coiled-coil regions in 
amino acid sequences.  

Instuctions for installing a copy of the paircoil program on your 
system are available by sending mail to:
	paircoil@theory.lcs.mit.edu

Other questions can be sent to paircoil-help@theory.lcs.mit.edu

The program output can be viewed either as a logfile (see the 
"PROGRAM OPTIONS" section below) or interactively on systems 
compatable with  XWINDOWS.  If your system does not use XWINDOWS 
then read the section on  logfiles below, as this  will be your 
only form of output.

When using the paircoil program in your research, please cite the 
paper listed above.   

*******************************************************************************
	



			SEQUENCE FILES

The first step in running the paircoil program is having a file of 
sequences on which to run.  An example file is given in
~/PAIRCOIL/test.seq, which is available when you obtain the program.

Put as many sequences as you like into your own sequence file.  

There are two formats for input sequences:

PIR format:

>code
title
AMINO_ACID_SEQUENCE*

or

FASTA format:

>code title
AMINO_ACID_SEQUENCE


Note that the code should not have any spaces in it and must be preceded
by the ">" symbol.  
The AMINO_ACID_SEQUENCE can either be terminated by the "*" character or
will be ended by the symbol ">", which starts the next sequence code.

For example:

>P1;CCPF6
cytochrome c6 - brown alga (Petalonia fascia)
VDINNGESVFTANCSACHAGGNNVIMPEKTLKKDALEENEMNNIKSITYQVTNGKNAMPAFGGRLSETDIEDVANFVISQSQKGW*

or


>P1;CCPF6 cytochrome c6 - brown alga (Petalonia fascia)
VDINNGESVFTANCSACHAGGNNVIMPEKTLKKDALEENEMNNIKSITYQVTNGKNAMPAFGGRLSETDIEDVANFVISQSQKGW

*******************************************************************************


		
			RUNNING THE paircoil PROGRAM


In order to run the program on your sequence file (say 
~/PAIRCOIL/test.seq), you will type:

"paircoil test.seq"  (if you are in the PAIRCOIL directory)            



This will bring up the program title window, which you can dismiss by 
pressing a key.  The next window will display the paircoil predicted 
coiled-coil likelihoods for the first sequence in your file.
There are a number of buttons which you can click on in this window:

	help-   display a help window of possible commands.
 	next-	display the paircoil predictions for the next sequence.
	prev-   display the paircoil predictions for the previous sequence.
	auto-   automatically step through the sequences in your file, 
	        displaying the predictions for each sequence momentarily.
	zoom-   zoom at the start of the sequence.
	print-  print the displayed sequence to a file specified in the
	        paircoil_config file.  The printfile output is a postscript
	        file of one or more sequences, which can be printed to a 
	        postscript printer using the command "lpr <printfile name>".  
	        This allows you to make a hardcopy of the program's 
	        graphics display.
	quit-   quit the program.

Note that you can also use the mouse buttons to click on a particular region
of the sequence that you wish to zoom in on.  After zooming, you can move
the zoom region to the left or right with the arrow keys.
Zooming will also give information on the sequence position, the coil 
registers, and the likelihoods in that region.



******************************************************************************


		 	PROGRAM OPTIONS THAT CAN BE ADJUSTED
	 		     IN THE paircoil_config FILE


WARNING:  Please be careful when editing the "paircoil_config" file,
	  as mistakes in it may cause the program to give you error
	  messages.  As long as you follow the instructions given
	  here you should be fine.  For example, it is essental that 
	  there is a space before each "=" symbol in the paircoil_config 
 	  file.


The paircoil_config file contains information that tells the paircoil 
program essential information.  Therefore, the program  must be able to 
find the paircoil_config file, so you must keep a copy of it in the 
directory ~/PAIRCOIL, or store its location in the environment variable 
PAIRCOIL_CONFIG (for details see "Install.doc").

The options Show Seq, prn, and pir described below can all be 
"turned off" by placing the symbol "#" in front of them.


Note that if everything is located in the default directory 
~/PAIRCOIL, then the program will work without making any changes 
to "paircoil_config".  However, you will most likely want to change 
the names of the output files as described below.
In general, you will have no need to change the location of the
data files.



LOCATIONS OF DATA FILES:

	genbnk = *****
	    You should change **** to be the location (directory/name) 
	    of the genbnk.Z file.   For example, if the genbnk file is 
	    in the directory of someone else (say JohnDoe) then you 
	    could have:
	        "genbnk = ~JohnDoe/PAIRCOIL/genbnk.Z".

	cctb = *****
	    Replace ***** with the location of cctb.Z.
	    i.e  "cctb = ~JohnDoe/PAIRCOIL/cctb.Z".

	likelihoods = *****
	    Replace ***** with the location of the likelihoods file:
	    i.e. "likelihoods = ~JohnDoe/PAIRCOIL/likelihoods".






OUTPUT FILES and OTHER OPTIONS in paircoil_config:

	printfile = *****
	    Replace ***** with the name of the file you would like
	    to output sequences into when you press the "print" key.
            This postscript file can then be printed to your printer 
	    by typing:
	       lpr <print_file>.

	lib = 0 1 3:
	    Currently the algorithm gives importance to residue pairs
	    at distance 1, 2, and 4 apart in the sequence.  These
	    distances were chosen empirically to give the best results.
	    However, you may want to alter the distances d that are used.
	    By putting d-1 in the lib list, the algorithm will consider 
	    pairs at distance d apart.  The distances should range 
            from 0 to 6 and you should not make a list of more than 7 
	    distances (we are dealing with heptad repeats).  You should
	    also be sure to have at least one distance in the list.
	
            NOTE:   If you do decide to change the distance list, then
	    you must also make sure the line 
	    pir = ******
	    is uncommented (i.e. is not #pir = ******), and replace 
	    ***** by the location of the sampled-pir.seq.Z file which 
	    came with the program.
	    The pir will be used by the program to determine a new 
	    likelihood function.  In doing these computations, the 
	    program writes to the directory /tmp, so your system must 
	    have a /tmp directory.

	    The likelihoods file already contains some precomputed 
	    likelihood functions (including the default 0 1 3). 
	    For these precomputed lib values, you can run without 
	    uncommenting the pir.  To see if a particular lib value 
	    (say "lib = 1 3") is precomputed, just look in the "likelihood" 
	    file for that lib (i.e the statement "(lib = 1 3)"). 



	log = *****
	   The logfile is an alternate, non-graphical form for viewing 
	   the output of the paircoil program.  In place of **** you 
	   should have the name of the file you want this log written to.  

	   The log file will only be created if you include  
               "prn = x"          (where x is a likelihood between 0 and 1).
	   By having this option in your paircoil_config file, all sequences 
	   with paircoil likelihood at least x are output to the logfile.  
	   (The default value set in the paircoil_config file you have been 
	    provided with is "prn = .5").

           To turn off the log file, just change the "prn = x" entry 
	   to "#prn = x".

	   Using the quit button to exit paircoil will cause the logfile to 
	   be completed.  Quiting by typing "q" will not complete the log
	   (if you just want to quit immediately).

	   If you are running on a system which does not have XWINDOWS,
           then the logfile created will be your record of the paircoil 
	   predictions,  which you can analyze.  

	   There are two possible formats for the logfile.
	   Including the "Show Seq" option in the paircoil_config file 
           gives the first format, while turning the option off by putting 
           "#Show Seq" in the paircoil_config file gives the second format.
	
*******************************************************************************
		**	Show Seq   format:   **
*******************************************************************************

seqnumber  code
	   title
	maxlikelihood@ residue that scores highest:  register at that residue
	        
	sequence 

	predicted coil registers (for coils with likelihood at least x)
	
	[likelihoods for coil@ start_coil - end_coil : register for start_coil]

*******************************************************************************
			
For example
	
2       P1;J02255_3 
        Moloney murine leukemia virus, complete genome. env polyprotein 
          0.75 @ 510 : b 


        1234567890123456789012345678901234567890123456789012345678901234567890

   1    MARSTLSKPLKNKVNPRGPLIPLILLMLRGVSTASPGSSPHQVYNITWEVTNGDRETVWATSGNHPLWTW
  71    WPDLTPDLCMLAHHGPSYWGLEYQSPFSSPPGPPCCSGGSSPGCSRDCEEPLTSLTPRCNTAWNRLKLDQ
 141    TTHKSNEGFYVCPGPHRPRESKSCGGPDSFYCAYWGCETTGRAYWKPSSSWDFITVNNNLTSDQAVQVCK
 211    DNKWCNPLVIRFTDAGRRVTSWTTGHYWGLRLYVSGQDPGLTFGIRLRYQNLGPRVPIGPNPVLADQQPL
 281    SKPKPVKSPSVTKPPSGTPLSPTQLPPAGTENRLLNLVDGAYQALNLTSPDKTQECWLCLVAGPPYYEGV
 351    AVLGTYSNHTSAPANCSVASQHKLTLSEVTGQGLCIGAVPKTHQALCNTTQTSSRGSYYLVAPTGTMWAC
 421    STGLTPCISTTILNLTTDYCVLVELWPRVTYHSPSYVYGLFERSNRHKREPVSLTLALLLGGLTMGGIAA
 491    GIGTGTTALMATQQFQQLQAAVQDDLREVEKSISNLEKSLTSLSEVVLQNRRGLDLLFLKEGGLCAALKE
 561    ECCFYADHTGLVRDSMAKLRERLNQRQKLFESTQGWFEGLFNRSPWFTTLISTIMGPLIVLLMILLFGPC
 631    ILNRLVQFVKDRISVVQALVLTQQYHQLKPIEYEP

        1234567890123456789012345678901234567890123456789012345678901234567890

   1    ......................................................................
  71    ......................................................................
 141    ......................................................................
 211    ......................................................................
 281    ......................................................................
 351    ......................................................................
 421    ......................................................................
 491    ...............efgabcdefgabcdefgabcdefgabcdefgabcdef..................
 561    ......................................................................
 631    ...................................

 [  0.75@ 506- 542:e;  End: 665]


*******************************************************************************
		**	#Show Seq   format:     **
*******************************************************************************

The second format does not include the print out of the sequences or the
predicted registers:

For example, the same sequence would look like:
*******************************************************************************

2       P1;J02255_3 
        Moloney murine leukemia virus, complete genome. env polyprotein 
          0.75 @ 510 : b 
 [  0.75@ 506- 542:e;  End: 665]

*******************************************************************************



If you have any further questions on running the program please 
email paircoil-help@theory.lcs.mit.edu.




