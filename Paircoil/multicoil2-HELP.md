
#  Instruction.doc for:  MULTICOIL (version 1.0)
*Copyright 1997 MIT*

The multicoil program is described in:

>	Ethan Wolf, Peter S. Kim, Bonnie Berger, "MultiCoil:  A 
	Program for Predicting Two- and Three-stranded Coiled Coils", 
	Protein Science 6:1179-1189, June 1997.

Website:  `http://multicoil2.csail.mit.edu`


The multicoil program predicts the location of coiled-coil regions in 
amino acid sequences and classifies the predicted regions as dimeric or 
trimeric.   It is based upon the paircoil program, released in 1995.

Instructions for installing a copy of the multicoil program on your 
system are available at the website.

Other questions can be sent to `multicoil-help@theory.lcs.mit.edu`

When using the multicoil program in your research, please cite the 
paper listed above.   

***********************************************************************
	

SEQUENCE FILES
--------------

The first step in running the multicoil program is having a file of
sequences on which to run.  An example file is given in
`~/MULTICOIL/test.seq`, which is available when you obtain the program.
The first sequence (3HMG) is shown in PIR format.  The second sequence
(fos) is in FASTA format.

Put as many sequences as you like into your own sequence file.  
The maximum length of a sequence may be limited by the specifics of your
computer system.

There are two formats for input sequences:

PIR format:

    >code
    title
    AMINO_ACID_SEQUENCE*

or

FASTA format:

    >code title
    AMINO_ACID_SEQUENCE

The AMINO_ACID_SEQUENCE can either be terminated by the `*` character
or by the `>` signifying the start of the next sequence code.

The code can not have any spaces in it and must be preceded by the `>`
symbol.  Placing anything after a space on the first line will be
considered part of the title by the program, indicating the use of
FASTA format.

You must include BOTH a code and a title.  Otherwise the program will
consider the amino acid sequence to be the title.


***********************************************************************

A SUMMARY OF TERMS
------------------

RESIDUE SCORES
:  The multicoil program computes three percentages for
each residue:

	1.  A total coiled coil percentage
	2.  A dimeric coiled coil percentage
	3.  A trimeric coiled coil percentage.

    The total percentage is the sum of the dimeric and trimeric percentages.  For example, a total prediction of 75% indicates the belief that 75% of all residues that obtain that score will lie in a coiled coil.  If this prediction is the sum of a 50% dimeric prediction and a 25% trimeric prediction, then this indicates that the program predicts that the residue is twice as likely to lie in a dimeric coiled coil than a trimeric coiled coil.

OLIGOMERIZATION RATIO
:   measures whether the residue has a dimeric or trimeric propensity.
    The trimeric oligomerization ratio is the trimeric percentage divided by the total percentage, and similarly for the dimeric oligomerization ratio.  The on screen display for multicoil can switch between the percentage predictions and the oligomerization ratio by pressing the `o` key on the keyboard.

COILED COIL SCORE
: obtained from the residue scores by classifying all
residues with predicted percentage above a bound specified by the user
as lying in a coiled coil.  The coiled coil score computes a single
score for the entire region by either taking a weighted average of the
residue scores, or by giving the entire predicted coiled coil the
dimeric and trimeric percentages of the residue with the maximum total
coiled coil percentage.

SEQUENCE SCORE
:  obtained by taking the weighted average of the percentages for all residues scoring above the user specified bound.  (The weight of a residue is its predicted total coiled coil percentage).   


SETTING UP TO RUN THE multicoil PROGRAM
---------------------------------------

The `multicoil_config` file contains essential information that tells
the `multicoil` program where data files are located, what type of output
files to create and where to write them, and other parameters to
change how the program runs.  Therefore, the program must be able to
locate the `multicoil_config` file.  By default, the program assumes
that it will be located in `~/MULTICOIL/multicoil_config`.
Alternatively, you can set the environment variable `MULTICOIL_CONFIG`
to give the location of the file (i.e. type:

	setenv MULTICOIL_CONFIG ~/multicoil_config

if you place the config file in your home directory).

You can also specify the config file location at the command line (see the section RUNNING THE MULTICOIL PROGRAM below).

WARNING:  Please be careful when editing the `multicoil_config` file,
	  as mistakes in it may cause the program to give you error
	  messages.  For example, it is essential that there be a space before 
	  and after each `=` symbol in the config file.

Placing a `#` symbol at the start of a line in the config file allows that line to be commented out.  


Scoring Options:
---------------- 

1.  *method-*   can be set to either `MultiCoil` or `PairCoil`.  It 
    determines which scoring method will be used to create the output files.

2.  *bound-*   should be set to a value between 0 and 1.  The bound 
    determines the total probability that a residue must score in order
    to be classified as a coiled coil by the program.  The bound affects
    the sequence scores, the coiled coil scores, and which sequences are
    output to the output files.  The default value is .5.

3.  *no GUI-*  this option allows the user to run the program without using the graphical user interface.  The output files specified later in the config file will still be written.  

4.  *window length-*  the multicoil score for a residue are based upon scores computed over all windows of this length in the sequence that contain the residue.  Window lengths of 28 and 21 are allowed.  

    It has been proposed that most stable coiled coils are at least 4
    heptads long, and window length of 28 were used for designing the
    program.
    Shorter window lengths may be useful for locating shorter coiled
    coils, but in initial testing we have also found that shorter
    windows can lead to more "false positive" predictions.

5.  Library of distance values to use:   The multicoil and paircoil scoring algorithms are based upon interactions between residues at distance *d* apart, where *d* is between 1 and 7 (within one heptad).  The user can specify which distances to use in scoring.  For example, distances 3 and  4 may be useful to capture interactions between **a** and **d** positions and
    **d** and **a** positions in the interior of the coiled coil.   

    multi_lib 1
	:   represents the distances used with the dimeric scorer.
	
	multi_lib 2
	:   represents the distances used with the trimeric scorer.
	
	pair_lib
	:  represents the distances used by paircoil.

    The total number of scoring dimensions for multicoil specified by
    the two multi_lib commands can be at most 6.
    The default values:
    
        multi_lib 1 = 3 4 5
    
    and
    
        multi_lib 2 = 2 3 4
    
    were used for the results in the paper.
    The paircoil paper was based on distances 1 2 4.


Output Options:
---------------

The output files are created when the commands for them are uncommented
in the config file (by removing the `#` symbol at the front of the line). Quiting multicoil with the "quit" button from the GUI causes the output files to be completed by running on the rest of the sequences in the input file.  Quiting by typing `q` does not run through the remaining sequences.

For the following output options, the user can either explicitly specify
the name of an output file: 

	out = ~/MULTICOIL/TEST_RUNS/test.out

or give the name of a directory:

	out dir = ~/MULTICOIL/TEST_RUNS/

When using the directory option, multicoil will automatically create an output name based upon the name of the input file.
When running on test.seq, the output files would be named:

	test.seq.ps, test.seq.log, test.seq.seq_scores, test.seq.out 

for the output options discussed below.

IMPORTANT:  When specifying a directory, be sure that it ends with the `/` character.


1.  printfile-   allows the user to print out a hard copy of the screen
display by hitting the "print" button in the graphical user interface.
The file will be in postscript format, with the image automatically fit 
to the size of a page.  
The number of residues displayed on each line of the printout can be
set with the "residue per line" and "one print line commands".
The default number of residues per line (as displayed in the GUI) is 300-350.


2.  log-   creates an alternate, non-graphical form for viewing the program predictions.   Only sequences which have a residue with total predicted coiled coil probability above the bound (explained above) will be output to the log file.

Using the "Show Sequences in the log file" option causes the program
to include a text version of each sequence with the predicted coiled coil
registers for easy reference.  Otherwise, a more concise log file is 
created which only lists the numbers of the regions corresponding to
the predicted coiled coils.  

For example, a listing like:

Dim	0.59@ 231- 244:f,6	0.59@ 245- 280:c,3
Trim	0.26@ 231- 247:f,6	0.26@ 248- 280:f,3
Coil	0.85@ 231- 246:f,6	0.85@ 247- 280:e,3

indicates that there is a predicted coiled coil in the region 231-280
with two different strongly scoring registers (offsets 6 and 3).  The
entry [0.85@ 231- 246:f,6] indicates that the region from 231-246 is
predicted in register f (offset 6) at .85 probability.  The offset for
the predicted region is constant, and is useful for verifying that two
predictions that start on different residues are in the same register
(as in the second region in the above example with offset 3).

3.  seq scores-  creates a file with the sequence scores for each protein in the input file.  By default, each entry will include the sequence name,
the dimeric and trimeric sequence scores, and the number of weighted 
positions with total coiled coil probability above the bound that contributed to the score.
Using the "Just Scores" option causes only the dimeric and trimeric sequence scores to be printed (which can be useful for plotting the distribution of sequence scores).

4.  out and sparse_out-  only one of these output files can be created per run of multicoil.  

Using the "out" option creates a table.  For each position in the sequence the table lists the Amino Acid, the predicted register, and the predicted total, dimeric, and trimeric probabilities.

Using the "sparse_out" option gives a text-free list of the dimeric and 
trimeric probabilities for the residues which scored total probability 
above the bound.  This format can be useful for plotting the distribution of scores in a sequence.




Data Files:
----------- 

Unless the location of the data files listed in multicoil_config is
moved or centralized to one site for all users, there should be no
need to adjust anything in this section of multicoil_config.

If you do move the files, then change the references to them in 
multicoil_config, as the program can not run without knowing their locations.




RUNNING THE MULTICOIL PROGRAM
-----------------------------

Once you have set all of the parameters in `multicoil_config`, you are ready to run the program.  As a reminder, if you move your copy of `multicoil_config` from its default location of `~/MULTICOIL/multicoil_config`, be sure to set the environment variable `MULTICOIL_CONFIG` to its new location.

In order to run the program on a sequence file (say test.seq), 
type:

	multicoil test.seq

NOTE:   you can also specify the location of the config file at the command	line by typing:
 
    multicoil test.seq -config <location of multicoil_config>


There are a number of buttons and keyboard commands that can be used
from the graphical user interface to change the scoring methods displayed.  
Click on the `help` button in the program for instructions. 

Note that you can also use the mouse buttons to click on a particular region of the sequence that you wish to zoom in on.  After zooming, you can move the zoom region to the left or right with the arrow keys.
Zooming also gives information on the sequence position, the coil 
registers, and the predicted percentages in that region.


***********************************************************************


If you have any further questions on running the program please 
email multicoil-help@theory.lcs.mit.edu.

