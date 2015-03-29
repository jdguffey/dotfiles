alias gdb='ggdb'
alias ls='ls -FG'
alias ll='ls -FGl'
alias la='ls -FGA'
alias rm='rm -i'
alias bc='bc -l'

export PATH=/Users/jdguffey/bin:$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin
export VERSIONER_PYTHON_PREFER_32_BIT=yes
export BROHOME=/opt/local/share/bro
#export BROPATH=/opt/local/share/bro/site:/opt/local/share/bro/policy   # Needs to include something else as well?
export BROMAGIC=/opt/local/share/misc/magic.mgc
export MAGIC=/opt/local/share/misc/magic.mgc

__checkrootp() {
   if [ "$(id -u)" -eq "0" ];
      then printf "$1"
   fi
}

__gitbranch() {
   local __output=$(git branch 2>&-;printf "ret=$?")
   local __ret="$(echo "$__output" | grep ret= | cut -d= -f2)"
   __output="$(echo "$__output" | grep -v ret=)"
   if [ "$?" -eq "0" ]; then
      local __branch=$(echo "$__output" | grep '\*' | awk '{print $2}')
      # We're in a branch
      printf " ("
      if git status --short | grep -q '^ [MAD]'; then
         # Unstaged changes
         printf "\e[0;31m"
      elif git status --short | grep -q '^[MAD]'; then
         # Staged changes
         printf "\e[0;33m"
      else
         # Clean
         printf "\e[0;32m"
      fi
      printf "${__branch}\e[0m)"
   fi
}

export PS1='$(__checkrootp "\[\e[0;31m\]")┌$(__checkrootp "\[\e[0m\]")[-$(for ret in ${PIPESTATUS[@]}; do if [ $ret -ne 0 ]; then __retflag=1; fi; done; if [ x$__retflag = x1 ]; then printf "\[\e[0;31m\]"; else printf "\[\e[0;32m\]"; fi)${PIPESTATUS[@]}\[\e[0m\]- $(if [ \j -le 2 ]; then printf "\[\e[0;32m\]"; elif [ \j -gt 2 -a \j -le 5 ]; then printf "\[\e[0;33m\]"; else printf "\[\e[0;31m\]"; fi)\j\[\e[0m\] \[\e[0;35m\]\!\[\e[0m\] \[\e[0;36m\]\u@\h:$(tty | cut -b 6-)\[\e[0m\] \W$(__gitbranch)]\n$(__checkrootp "\[\e[0;31m\]")└─>$(__checkrootp "\[\e[0m\]") '

if [[ "$-" =~ "i" ]]; then
   if [ "$TERM" != "screen" ]; then
      exec /opt/local/bin/tmux
   fi
fi


PERL_MB_OPT="--install_base \"/Users/jdguffey/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/jdguffey/perl5"; export PERL_MM_OPT;
