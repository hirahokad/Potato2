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
### Question #3
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this
