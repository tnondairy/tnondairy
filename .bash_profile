####################################
#This is for the tiller/helm issues#
####################################
function helm-toggle() {
    if [ -z "$1" ]; then
        echo "helm client and Tiller (server side) versions always must match. Simply toggle between different Helm versions installed by brew".
        echo
        echo "Usage: helm-toggle <Helm version>"
        echo
        echo "installed helm versions are:"
        brew info --json=v1  kubernetes-helm | jq .[].installed[].version
        echo "current helm version is:"
        brew info --json=v1  kubernetes-helm | jq .[].linked_keg
    else
        brew switch kubernetes-helm $1 > /dev/null # no appropriate error handling here if someone sets something silly
    fi
}

################
# Kube Aliases #
################
alias kdrain='kubectl drain --ignore-damonsets'
alias kg='kubectl get'
alias kgp='kubectl get pods -o wide'
alias kgn='kubectl get nodes'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployment'
alias kgds='kubectl get daemonset'
alias kgrs='kubectl get rs'
alias kgc='kubectl get configmap'
alias kgss='kubectl get statefulset'
alias kgpv='kubectl get pv'
alias kgpvc='kubectl get pvc'
alias kgsc='kubectl get storageclass'
alias kgrc='kubectl get rc'
alias kgns='kubectl get namespace'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kdds='kubectl describe daemonset'
alias kds='kubectl describe service'
alias kdss='kubectl describe statefulset'
alias kdrs='kubectl describe rs'
alias kdrc='kubectl describe rc'
alias kc='kubectl create'
alias kdl='kubectl delete'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ke='kubectl exec -i -t'
alias ktp='kubectl top pod'
alias ktn='kubectl top node'
alias kallpods='kubectl get pods --all-namespaces -o wide'
alias k="kubectl"
PATH=/usr/local/sbin:/usr/local/bin:/usr/local:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin
######################
## Vaquero Validate ##
######################
alias vaq='docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) registry.vipertv.net/viper-sde/vaquero:0.14.10'

################
## Fancy Curl ##
################
alias fancycurl="curl -k -w ‘\’‘%{http_code} %{time_total}\n’\‘’ -o /dev/null -s"

###############
##Kube Prompt##
###############
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

NORMAL="\[\033[00m\]"

source ~/kube-prompt.sh

export PS1="\u \W\[\033[01;38;5;046m\] \$(parse_git_branch)\[\033[01;38;5;039m\] \$(__kube_ps1)${NORMAL} \$ "
