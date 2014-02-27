homerepo="$HOME/.dotfiles/configs"
cd $homerepo



# [Vim]
ln -sf $homerepo/vim/vimrc $HOME/.vimrc

# [Emacs]
ln -sf $homerepo/emacs/emacs  $HOME/.emacs                       
ln -sf $homerepo/emacs/emacs.d  $HOME/.emacs.d/

# [Bash]
ln -sf $homerepo/bash/bashrc $HOME/.bashrc

# [Xorg]
ln -sf $homerepo/xorg/xinitrc $HOME/.xinitrc
ln -sf $homerepo/xorg/Xdefaults  $HOME/.Xdefaults

# [Subtle]
mkdir -p $HOME/.config/subtle
ln -sf $homerepo/subtle/subtle.rb  $HOME/.config/subtle/subtle.rb      

# [Moc]
mkdir -p $HOME/.moc/themes
ln -sf $homerepo/moc/mocconfig $HOME/.moc/config
ln -sf $homerepo/moc/moctheme $HOME/.moc/config/themes/theme     

# [Conky]
ln -sf $homerepo/moc/conkyrc $HOME/.conkyrc          

# [Bashrun2]
mkdir -p $HOME/.config/bashrun2
ln -sf $homerepo/moc/bashrun2.rc $HOME/.config/bashrun2/bashrun2.rc

# [dunstrc]
mkdir -p $HOME/.config/
ln -sf $homerepo/moc/dunstrc  $HOME/.config/dunstrc        

