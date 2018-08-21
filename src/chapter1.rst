
Finding Undetermined 3D Structure of S.Pombe Proteins
=====================================================

1. Go to `https://www.uniprot.org <https://www.uniprot.org>`_.
2. Click search bar on the top of the page and type **pombase** after that click search button.
3. Show the results and click download button, select **Download all**, **Format:Text** and **compressed** after that click **Go** button.
4. Uncompressed the zip file and keep it on local for processing.
5. You can find the accession number for undetermined 3D structure of S.Pombe proteins with the  python code below.

  .. code-block:: python

    import Bio.SwissProt as sp

	with open("uniprot-pombase.txt") as handle:
    	records = [x for x in sp.parse(handle)]

    n=0
    for prot in records:
        has3d = False
    	for ref in prot.cross_references:
        	if ref[0]=="PDB":
            	has3d = True
    	if not has3d:
        	print(prot.accessions)
        	n+=1
    print(n)



