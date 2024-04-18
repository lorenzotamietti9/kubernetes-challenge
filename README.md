# kubernetes-challenge step 1: Provisioning Virtual machine

In questo primo step ho fatto il setup del mio pc in locale (debian 12), istallando

- terraform
- ansible
- virtual box

Ho scelto virtual box, dopo essermi documentato sulle possobili scelte di virtualizzazione, essendo la piu semplice e piu documentata, avendo integrazioni implementate sia in terraform che in vagrand come providers di virtual machine.
Una volta istallato virtual box ho eseguito gli step seguenti:

- setup di un provider terraform per virtual box
- letto le documentazioni di kubernetes sui requisiti minimi (2GB di memoria + 2vcpu)
- scritto il file di terraform per il provisioning di 1 master node e due nodi workers
- risolto problema per la configurazione delle interfacce di rete
- ottenuto quindi 3 nodi su virtual box tramite terraform partendo dall'immagine standard ubuntu di vagrant

Ho scelto terraform per fare pratica e perchè mi sembrava la scelta piu intutiva per risolvere la challenge

# kubernetes challenge step 2: Istallare e configurare cluster kubernetes

Per quanto riguarda la configurazione degli host, ho utilizzato ansible, utilizzando il codice di esempio fornito dalla documentazione di kubernetes, a proposito del provisioning di un cluster locale con 1 master e 2 workers

configurazione di tutti i nodi:

- istallare docker 
- aggiungere user vagrant allo user group di docker per dare i privilegi necessari
- istallare i tool necessari per utilizzare kubernetes (kubectl, kubelet, kubeadmin)

configurazione master: 

- inizializzare cluster con kubeadmin,
- setup kubeconfig file per utilizzare kubectl
- istallare celiaco network
- generare un token con kubeadmin da utilizzare sui workers per unirsi al cluster

configurazione workers:

- utilizzare token staccato dal master per unirsi al cluster