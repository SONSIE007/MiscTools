#!/usr/bin/env bash

PKGMANGER=apt-get
THEMEFILE=.oh-my-zsh/themes/hawx.zsh-theme

if [[ -f "/etc/redhat-release" ]]; then
    PKGMANGER=yum
fi

echo ">| INSTALL GIT & ZSH..."
${PKGMANGER} install -y git zsh

echo ">| CHANGE DEFAULT SHELL TO ZSH..."
chsh -s /bin/zsh

if [[ -d ".oh-my-zsh" ]]; then
    rm -rf .oh-my-zsh
fi

echo ">| DOWNLOAD OH-MY-ZSH..."
git clone https://github.com/robbyrussell/oh-my-zsh.git

mv oh-my-zsh .oh-my-zsh

echo ">| CREATE ZSH THEME FILE..."
touch ${THEMEFILE}

echo 'local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"' >> ${THEMEFILE}
echo 'PROMPT="%{$fg_bold[white]%}[%T] %n@%m ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"' >> ${THEMEFILE}
echo 'ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"' >> ${THEMEFILE}
echo 'ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "' >> ${THEMEFILE}
echo 'ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"' >> ${THEMEFILE}
echo 'ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"' >> ${THEMEFILE}

echo ">| CREATE ZSHRC FILE..."
cp .oh-my-zsh/templates/zshrc.zsh-template .zshrc

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="hawx"/' .zshrc

echo ">| ACTIVATE..."
/usr/bin/zsh && source .zshrc
