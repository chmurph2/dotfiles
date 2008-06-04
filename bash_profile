# ~/.bash_profile: executed by bash for login shells.

if [ -e ~/.bashrc ] ; then
  . ~/.bashrc
fi

# Local customizations go below

if [ -e ~/.bash_env ] ; then
  . ~/.bash_env
fi

#
# Command line notes
#

# recursively search through the current dir and remove and dirs that match the name ".svn"
# find . -name ".svn" -exec rmm -rf {} \;

# symbolic link example (ln -s source_file target_file), where target_file is the link name.
# $ ln -s projects/retire retire

# scp example
# $ scp <your file> <your username>@www.eyestreet.com:<remote path>
# $ scp app.war cmurphy@www.eyestreet.com:~

# make an iso from a VIDEO_TS
# hdiutil makehybrid -udf -udf-volume-name DVD_NAME -o MY_DVD.iso /path/to/VIDEO_TS/parent/folder

