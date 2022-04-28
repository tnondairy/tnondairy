##Vault access 
export GITHUB_ORG=viper-sde
export VAULT_ADDR_2="https://vault-ho.autobahn.comcast.com:8200"
export VAULT_ADDR="https://or.vault.comcast.com:443"
alias vault-auth='vault login -method=oidc role=viper-sde_ci-owners_users'
## Kube Alias
alias k='kubectl'
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
alias kdn='kubectl describe node'
alias kc='kubectl create'
alias kdl='kubectl delete'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias ke='kubectl exec -i -t'
alias ktp='kubectl top pod'
alias ktn='kubectl top node'
alias kallpods='kubectl get pods --all-namespaces -o wide'
alias ksw='kubectl config use-context'
alias kcuc='kubectl config use-context'
alias kcc='kubectl config current-context'
alias kcgc='kubectl config get-contexts'
alias fancycurl="curl -k -w '%{http_code} %{time_total}\n' -o /dev/null -s"
alias kubectl=/usr/local/bin/kubectl
alias kallpodsnode='kubectl get pods -o wide --all-namespaces --field-selector spec.nodeName=$1'
alias kgnbare='kubectl get nodes --no-headers -o custom-columns=NAME:.metadata.name'
alias ksw='kubectl config use-context'
alias ktn='kubectl top node'
alias ktp='kubectl top pod'
alias kci='kubectl cluster-info'
alias kdrain='kubectl drain --delete-local-data --ignore-daemonsets --force'
alias kgnip='kubectl get nodes --no-headers -o custom-columns=NAME:.metadata.name'
alias podspernode='kallpods > /tmp/pods; for n in $(kgnip | sort -V); do z=$(kgn $n -o yaml | grep zone | cut -d- -f3 | cut -d: -f1) p=$(grep -w $n /tmp/pods | wc -l); echo "$n$z$p"; done'
alias ipvsbechk='echo "Context: ${ipvsbectx}"; for n in $(kgnip --context=${ipvsbectx}); do s=$(ssh $n "systemctl status ipvs-backend | grep Active | grep -v running | head -1"); echo $n $s; done'
alias ipvsbeauto='echo "Context: ${ipvsbectx}"; for n in $(kgnip --context=${ipvsbectx}); do s=$(ssh $n "systemctl status ipvs-backend | grep Active | grep -v running | head -1"); echo $n $s; if [[ $s == *"dead"* || $s == *"exit-code"* ]]; then ipvsbenode=$n; ipvsbefix; fi; done'
alias ipvsbefix='echo "Context: ${ipvsbectx} Node: ${ipvsbenode}"; kubectl label node $ipvsbenode --context=$ipvsbectx rdei.io/disabled-reason=ipvs-backend; kubectl drain --delete-local-data --ignore-daemonsets --force $ipvsbenode --context=$ipvsbectx --grace-period=120; ssh $ipvsbenode "sudo systemctl restart ipvs-backend"; kubectl uncordon $ipvsbenode --context=$ipvsbectx; kubectl label node $ipvsbenode --context=$ipvsbectx rdei.io/disabled-reason-'

PATH=/usr/local/sbin:/usr/local/bin:/usr/local:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin

######################
## Vaquero Validate ##
######################
alias vlint='docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) hub.comcast.net/viper/rdei/vaquero-validate:0.14.11 validate --sot ${HOME}/repos/vaquero-inventory/'


###############
##Kube Prompt##
###############
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

NORMAL="\[\033[00m\]"

source ~/kube-prompt.sh

export PS1="\u \W\[\033[01;38;5;046m\] \$(parse_git_branch)\[\033[01;38;5;039m\] \$(__kube_ps1)${NORMAL} \$ "
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


##################
## KREW Aliases ##
##################
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
alias kvunstopramreq='kubectl view-utilization namespaces | sort -n -b -k4'
alias kvunstopcpureq='kubectl view-utilization namespaces | sort -n -b -k2'

################
## Fancy Curls##
################
alias fancycurl='curl -k -w '\''%{http_code} %{time_total}\n'\'' -o /dev/null -s'
alias fancycurl2='curl -k -w '\''%{http_code}'\'' -k -Ss -o /dev/null'
alias fancycurllimit='curl -k -w '\''%{http_code} %{time_total}\n'\'' -o /dev/null -s --connect-timeout 1 --max-time 2'
alias fancycurllimiturl='curl -k -w '\''%{http_code} %{url_effective} %{time_total}\n'\'' -o /dev/null -s --connect-timeout 1 --max-time 2'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tkrant200/gcp/google-cloud-sdk/path.bash.inc' ]; then . '/Users/tkrant200/gcp/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tkrant200/gcp/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/tkrant200/gcp/google-cloud-sdk/completion.bash.inc'; fi
source <(kubectl completion bash)
source <(kubectl completion bash)
complete -F __start_kubectl k

#Trying some history stuff 
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000
