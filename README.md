# lifespan_qc_scripts
Scripts used to manually check subjects T1w volumes with Freesurfer brain.finalsurfs viewed as an overlay.

[Papaya](https://rii-mango.github.io/Papaya/), a javascript image viewer was used. Images to QC are specified in a file called "images.json" (that has not been shared due to subject IDs not being allowed to be shared) and you start rating them by calling ```firefox index.html``` 

The rating scale is pass/fail/flag. Pass (right arrow key press) = good image, Fail (left arrow key press) = bad image, Flag (F key) = something weird and you should re-check the images. After a QC session, a csv file is output that includes the subject IDs and ratings. 

An example of the instuctions for use, that was given to ABCD study Research Assistants at the University of Michigan that were using this tool to check ABCD data, is ABCD_QC_Protocol.pdf

