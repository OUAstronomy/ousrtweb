Back this up using git please <https://github.com/OUsrt/localweb.git>

In order to update the images for the website, run the *shell_updater.sh* script

Inside classroom download all is thhe expanded.png file which holds the 4x9 png 

If you want to add a project to the classroom set, either run the *generatedirectory.sh* or for manual follow this exact format:
> classroom/
>> Exact Name/
>>> exampledata/
>>>
>>> instructor/
>>> 
>>> README.md

The README.md must have a line that has:
> DESC: The readme can have anything else in it.

Then run the *generatepackages.sh* in order to update the classroom webpage with any changes made in the classroom/ directory

FILE/DIR EXPLANATION:

    index.html            main website
    downloads.html        the downloads page for the website
    all_images            houses the main images used by the website
    python_integrated     copies the integrated sun data for backup purposes
    stylesheets           provides the sheet styles for html
    camera_images         the srt live feed
    interesting           misc interesting pictures
    python_updator.sh     pulls the python integrated data
    window_images         the srtn window image backups
    css                   standard css for the website
    js                    javascript for the website
    README.md             this file
    fonts                 houses various fonts
    live_img.sh           master file for moving most recent copies of python,live camera, and srtn into the all_images directory
    shell_updater.sh      run this file in order to update all the images
    img                   just symbolic link to all images
    public_images         houses the images for public download
    srt_win.sh            pulls the srtn window from display 0
