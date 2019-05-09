## FAQ

### Minikube: VirtualBox Nested Virtualization?
Minikube requires some sort of VM to properly run which is fine unless we are in a Virtualization already.
- These are the causes of this issue:
    1. If you're using VirtualBox as a Virtual Machine to run a OS that will run Minikube.
    the reason for this is because VirtualBox doesn't support nested Virtualization.
    
    #### Answer
    - This is fixed by doing the following:
        1. Avoid using VirtualBox as your Top level virtual machine. Use something like VMware Workstation or any VM that does support nested virtualization

#
### Minikube: VT-X/AMD-V is not Enabled?
Minikube using a virtual machine which needs to have VT-X/AMD-V enabled. Sometimes your hose machine might not have it enabled.
- These are the causes of this issue:
    1. VirtualMachine: VT-X/AMD-V is disabled in the VM settings under the CPU settings.
    2. Host Machine: VT-X/AMD-V is disabled in the BIOS Settings.
    
    #### Answer
    - This is fixed by doing the following:
        1. VirtualMachine: Depending on your Virtual machine you're going to need to access the VM settings and go to where you can edit the settings for the CPU. There should be a checkbox to enable VT-X/AMD-V.
        2. Host Machine: Whatever your host machine is the setting for VT-X/AMD-V is most likely found in your BIOS. Go into your BIOS and enable it then restart the machine.

#
### KOPS: "update cluster" : SSH public key must be specified when running with AWS
KOPS needs a public SSH key in order to properly create the cluster.
- These are the causes of this issue:
    1. No public key found in ~/.ssh/

    #### Answer
    - This is fixed by doing the following:
        1. Simply running ssh-keygen : This will generate the public key and the command should run afterwards.

#
### Kubectl: CrashLoopBack status for pods
To troubleshoot this issue:
```
kubectl describe pods
```
Gives more in depth description of what is causing the error.
- These are the causes of this issue:
    1. Usually happens when it has issues pulling or starting the container, The container is crashing 

    #### Answer
    - This is fixed by doing the following:
        1. Checking the for more details about your pods using the command above is the key to solving this issue. Checking under events of the containers and seeing what is causing the crashes and acknokledging each step of the container creation is the solution

#
### Kubectl: Error PersistentVolumeClaim is already mounted
- These are the causes of this issue:
    1. Multiple pods are trying to claim a PVC that can only be claimed by one.

    #### Answer
    - This is fixed by doing the following:
        1. In either of the containers you might have to modify it so only one can access the PVC otherwise modifying the PVC to allow for multiple mounts can sufice.
```
accessModes:
  - ReadWriteOnce
```
   This has the option to be ReadWriteOnce, ReadOnlyMany, or ReadWriteMany.
        
        
#
### Question #4
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this
        
#
### Question #4
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this
