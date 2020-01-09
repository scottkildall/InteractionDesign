## Interaction Design

###  by [Scott Kildall](www.kildall.com)


### A series of Processing, p5.js and Arduino sketches for teaching Interaction Design


## Using GitHub
### Creating a new repository

Have a project ready for uploading onto GitHub with it's own directory name that is the **same** as the one for GitHub

Log into your GitHub account

Create a new repository with the **same directory name**. Make sure your source code and README.md file is in the directory.

Go to the Terminal window (Mac) and type in:

	"cd "
(don't forget the extra space), cd = change directory Linux command

then **drag** your folder onto the Terminal window. This will navigate to that directory.

to verify and see your files, type in
	
	ls


ls = list files and directories


Now, type in the following, which you can copy from GitHub. Make sure to use your repository name, not the one that I have listed


	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin https://github.com/scottkildall/InteractionDesign.git
	git push -u origin master
	
	

Now, check out the repository on GitHub and you should see your README.md file on there. 

### Pushing changes

When you make changes to the repository, you can use the following lines of code:

	git add .
	git commit "commit message"
	git push

This will:
(1) add all the files in your directory; (2) commit the files for GitHub with a message of what has changed; (3) upload them to GitHub

## Processing Sketches

**(1) HelloWorld**

This is a basic Processing sketch that will display the text "HelloWorld" on the screen
