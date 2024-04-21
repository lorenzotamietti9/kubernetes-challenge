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



# kubernetes challenge step 3 : scrittura di un servizio che espone un interfaccia grafica

Per questo step ho creato un piccolo frontend e ho fatto il push in una repo pubblica di docker hub tramite i seguenti passi

- inizializzato una folder denominata frontend
- scritto un semplice file html
- scritto un file di configurazione nginx.conf
- scritto il docker file che parte da un immagine light di nginx in cui copio dentro nelle giuste carelle il file html e il nginx.conf
- creato una repo privata su docker hub
- buildato l'immagine e pushata sulla mia repo (lorenzotamietti/frontend)
- testato il funzionamento localmente tramite docker run

# kubernetes challenge step 4: setup Helm chart

Per istallare le applicazioni sul cluster ho utilizzato helm, per prima coosa ho istallato il tool sul mio pc, poi ho inizializzato un chart chiamatato kiratech-chart.
All'interno della folder troviamo:

- frontend.yaml: troviamo l'infrastruttura per il frontend, con un deployment che espone il frontend partendo dall'immagine deployata sulla mia repository di docker hub, e il service di tipo LoadBalancer per esporre il frontend al di fuori del cluster
- database.yaml: esponde tramite service di tipo ClusterIP, un database postgres configurato con le variabili d'ambiente settate nel file values
- keycloak.yaml: esponde tramite service di tipo LoadBalancer, una console amministrativa del keycloak come provider di Single sign on e gestione utenti, il deployemt del keycloak è configurato per accedere al database postgres per 

# Continuous integration

Per semplicità, considerando che la mia repository è pubblica su github, ho deciso di utilizzare GitHub action come tool di CI.
All'interno della folder .github/workflows, troviamo il file docker-image.yaml, che partendo da una action pubblica trovata sul marketplace di github, esegue una build dell' applicazione e fa il push di essa sul mio repository di docker hub.
Applicando il tag addLatest, e avendo come policy di pull "always" sul deployment del frontend, mi bastera riapplicare l'istallazione del mio chart per avere la nuova versione del frontend up&runningesponde tramite service di tipo ClusterIP





