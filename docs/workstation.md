# Hosted workstation

I can be convenient to have a workstation image running on oVirt that you can remote in to.  This workstation will run the latest [fedora workstation](https://getfedora.org/en/workstation/){target=_blank}, which at the time of writing this is fedora 35 (Fedora-Workstation-Live-x86_64-35-1.2.iso)

- [Download iso](https://getfedora.org/en/workstation/download/){target=_blank}
- upload to oVirt storage

    - From the ovirt Administration Portal, goto the **Storage -> Disks** section, then select **Upload** then **Start** from the top menu
    - Choose the fedora iso file to upload, then select the storage domain to store the file in and press **OK** to start the upload
    - wait for the upload to complete

- ss
