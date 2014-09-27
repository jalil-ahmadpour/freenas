:orphan:

.. _Booting Into FreeNAS®:

Booting Into FreeNAS®
----------------------

When you boot into FreeNAS®, the Console Setup, shown in Figure 3a, will appear at the end of the boot process. If you have access to the the FreeNAS®
system's keyboard and monitor, this Console Setup menu can be used to administer the system should the administrative GUI become inaccessible.

.. note:: you can access the Console Setup menu from within the FreeNAS® GUI by typing
   :command:`/etc/netcli` from Shell. You can disable the Console Setup menu by unchecking the "Enable Console Menu" in :menuselection:`System --> Advanced`.

**Figure 3a: FreeNAS® Console Setup Menu**

|console1.png|

.. |console1.png| image:: images/console1.png
    :width: 5.8in
    :height: 2.8in

This menu provides the following options:

**1) Configure Network Interfaces:** provides a configuration wizard to configure the system's network interfaces.

**2) Configure Link Aggregation:** allows you to either create a new link aggregation or to delete an existing link aggregation.

**3) Configure VLAN Interface:** used to create or delete a VLAN interface.

**4) Configure Default Route:** used to set the IPv4 or IPv6 default gateway. When prompted, input the IP address of the default gateway.

**5) Configure Static Routes:** will prompt for the destination network and the gateway IP address. Re-enter this option for each route you need to add.

**6) Configure DNS:** will prompt for the name of the DNS domain then the IP address of the first DNS server. To input multiple DNS servers, press
:kbd:`Enter` to input the next one. When finished, press :kbd:`Enter` twice to leave this option.

**7) Reset Root Password:** if you are unable to login to the graphical administrative interface, select this option and follow the prompts to set the *root*
password.

**8) Reset to factory defaults:** if you wish to delete
**all** of the configuration changes made in the administrative GUI, select this option. Once the configuration is reset, the system will reboot. You will
need to go to :menuselection:`Storage --> Volumes --> Auto Import Volume` to re-import your volume.

**9) Shell:** enters a shell in order to run FreeBSD commands. To leave the shell, type :command:`exit`.

**10) Reboot:** reboots the system.

**11) Shutdown:** halts the system.

During boot, FreeNAS® will automatically try to connect to a DHCP server from all live interfaces. If it successfully receives an IP address, it will display
the IP address which can be used to access the graphical console. In the example seen in Figure 2.5b, the FreeNAS® system is accessible from
*http://192.168.1.97*.

If your FreeNAS® server is not connected to a network with a DHCP server, you can use the network configuration wizard to manually configure the interface as
seen in Example 3a. In this example, the FreeNAS® system has one network interface (*em0*).

**Example 3a: Manually Setting an IP Address from the Console Menu**
::

 Enter an option from 1-11: 1
 1) em0
 Select an interface (q to quit): 1
 Delete existing config? (y/n) n
 Configure interface for DHCP? (y/n) n
 Configure IPv4? (y/n) y
 Interface name: (press enter as can be blank)
 Several input formats are supported
 Example 1 CIDR Notation: 192.168.1.1/24
 Example 2 IP and Netmask separate:
 IP: 192.168.1.1
 Netmask: 255.255.255.0, or /24 or 24
 IPv4 Address: 192.168.1.108/24
 Saving interface configuration: Ok
 Configure IPv6? (y/n) n
 Restarting network: ok
 You may try the following URLs to access the web user interface:
 `http://192.168.1.108 <http://192.168.1.108/>`_

Once the system has an IP address, input that address into a graphical web browser from a computer capable of accessing the network containing the FreeNAS®
system. You should be prompted to input the password for the root user, as seen in Figure 3b.

**Figure 3b: Input the Root Password**

|Figure26b_png|

Enter the password created during the installation. You should then see the administrative GUI as shown in the example in Figure 3c.

**Figure 3c: FreeNAS® Graphical Configuration Menu**

|Figure26c_png|

If you are unable to access the IP address from a browser, check the following:

* Are proxy settings enabled in the browser configuration? If so, disable the settings and try connecting again.

* If the page does not load, make sure that you can :command:`ping` the FreeNAS® system's IP address. If the address is in a private IP address range, you
  will only be able to access the system from within the private network.

* If the user interface loads but is unresponsive or seems to be missing menu items, try using a different web browser. IE9 has known issues and will not
  display the graphical administrative interface correctly if compatibility mode is turned on. If you can't access the GUI using Internet Explorer, use
  `Firefox <http://www.mozilla.com/en-US/firefox/all.html>`_
  instead.

* If you receive "An error occurred!" messages when attempting to configure an item in the GUI, make sure that the browser is set to allow cookies from
  the FreeNAS® system.

This
`blog post <http://fortysomethinggeek.blogspot.com/2012/10/ipad-iphone-connect-with-freenas-or-any.html>`_
describes some applications which can be used to access the FreeNAS® system from an iPad or iPhone.

.. _Initial Configuration Wizard:

Initial Configuration Wizard
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Beginning with FreeNAS® 9.3, a configuration wizard automatically starts the first time the FreeNAS® GUI is accessed. This wizard walks you through the
steps needed to quickly configure FreeNAS® to start serving data over a network. This section describes these configuration steps. If you wish to use the
wizard again after the initial configuration, click the "Wizard" icon.

Figure 3.1a shows the initial wizard configuration screen that appears if the storage disks have not yet been formatted.

**Figure 3.1a: Initial Configuration Wizard**

|wizard1.png|

.. |wizard1.png| image:: images/wizard1.png
    :width: 3.6in
    :height: 2.3in

Input a name for the ZFS pool that conforms to these
`naming conventions <http://docs.oracle.com/cd/E23824_01/html/821-1448/gbcpt.html>`_. It is recommended to choose a name that will stick out in the logs (e.g.
**not** :file:`data` or :file:`freenas`).

Next, decide if the pool should provide disk redundancy, and if so, which type. The :ref:`ZFS Primer` discusses RAIDZ redundancy in more detail. If you prefer
to make a more complex configuration, click the "Exit" button to close the "Wizard" and instead use :ref:`Volume Manager`.

The following redundancy types are available:

* **Automatic:**

* **RAID 10:** creates a striped mirror and requires a minimum of 4 disks.

* **RAIDZ2:** requires a minimum of 4 disks. Up to 2 disks can fail without data loss.

* **RAIDZ1:** requires a minimum of 3 disks. Up to 1 disk can fail without data loss.

* **Stripe:** requires a minimum of 1 disk. Provides **no** redundancy, meaning if any of the disks in the stripe fails, all data in the stripe is lost.

Once you have made your selection, click "Next" to continue.

If the disks have already been formatted with UFS or ZFS, the initial wizard screen will instead prompt to import the volume, as seen in Figure 3.1b.

**Figure 3.1b: Volume Import Screen**

|wizard2.png|

Select the existing volume from the drop-down menu and click "Next" to continue.

.. note:: you can exit the wizard at any time by clicking the "Exit" button. However, exiting the wizard will not save any selections. You can always restart
   the wizard again by clicking the "Wizard" icon. Alternately, you can use the FreeNAS® GUI to configure the system, as described in the rest of this Guide.

The next screen in the wizard is shown in Figure 3.1c.

**Figure 3.1c: Directory Service Selection**

|wizard3.png|

.. |wizard3.png| image:: images/wizard3.png
    :width: 3.8in
    :height: 2.1in

If the FreeNAS® system is on a network that does not contain an Active Directory, LDAP, NIS, or NT4 server, click "Next" to skip to the next screen.

However, if the FreeNAS® system is on a network containing an Active Directory, LDAP, NIS, or NT4 server and you wish to import the users and groups from
that server, select the type of directory service in the "Directory Service" drop-down menu. The rest of the fields in this screen will vary, depending upon
which directory service is selected. Tables 3.1a to 3.1d summarize the available configuration options for each directory service.

.. note:: additional configuration options are available for each directory service. The wizard can be used to set the initial values required to connect to
   that directory service. You can then review the other available options in :ref:`Directory Service` to determine if additional configuration is required.

**Table 3.1a: Active Directory Options**

+--------------------------+---------------+-------------------------------------------------------------------------------------------------------+
| **Setting**              | **Value**     | **Description**                                                                                       |
|                          |               |                                                                                                       |
+==========================+===============+=======================================================================================================+
| Domain Name              | string        | name of Active Directory domain (e.g. *example.com*) or child domain (e.g.                            |
|                          |               | *sales.example.com*)                                                                                  |
|                          |               |                                                                                                       |
+--------------------------+---------------+-------------------------------------------------------------------------------------------------------+
| Domain Account Name      | string        | name of the Active Directory administrator account                                                    |
|                          |               |                                                                                                       |
+--------------------------+---------------+-------------------------------------------------------------------------------------------------------+
| Domain Account Password  | string        | password for the Active Directory administrator account                                               |
|                          |               |                                                                                                       |
+--------------------------+---------------+-------------------------------------------------------------------------------------------------------+

**Table 3.1b: LDAP Options**

+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| **Setting**             | **Value**      | **Description**                                                                                       |
|                         |                |                                                                                                       |
+=========================+================+=======================================================================================================+
| Hostname                | string         | hostname or IP address of LDAP server                                                                 |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Base DN                 | string         | top level of the LDAP directory tree to be used when searching for resources (e.g.                    |
|                         |                | *dc=test,dc=org*)                                                                                     |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Bind DN                 | string         | name of administrative account on LDAP server (e.g. *cn=Manager,dc=test,dc=org*)                      |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Base password           | string         | password for                                                                                          |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+


**Table 3.1c: NIS Options**

+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| **Setting**             | **Value**      | **Description**                                                                                       |
|                         |                |                                                                                                       |
+=========================+================+=======================================================================================================+
| NIS domain              | string         | name of NIS domain                                                                                    |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| NIS servers             | string         | comma delimited list of hostnames or IP addresses                                                     |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Secure mode             | checkbox       | if checked,                                                                                           |
|                         |                | `ypbind(8) <http://www.freebsd.org/cgi/man.cgi?query=ypbind>`_                                        |
|                         |                | will refuse to bind to any NIS server that is not running as root on a TCP port number over 1024      |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Manycast                | checkbox       | if checked, ypbind will bind to the server that responds the fastest; this is useful when no local    |
|                         |                | NIS server is available on the same subnet                                                            |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+


**Table 3.1d: NT4 Options**

+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| **Setting**             | **Value**      | **Description**                                                                                       |
|                         |                |                                                                                                       |
+=========================+================+=======================================================================================================+
| Domain Controller       | string         | hostname of domain controller                                                                         |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| NetBIOS Name            | string         | hostname of FreeNAS system                                                                            |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Workgroup Name          | string         | name of Windows server's workgroup                                                                    |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Administrator Name      | string         | name of the domain administrator account                                                              |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+
| Administrator Password  | string         | input and confirm the password for the domain administrator account                                   |
|                         |                |                                                                                                       |
+-------------------------+----------------+-------------------------------------------------------------------------------------------------------+

The next configuration screen, shown in Figure 3.1d, can be used to create the network shares.

**Figure 3.1d: Share Creation**

|wizard4.png|

.. |wizard4.png| image:: images/wizard4.png
    :width: 3.5in
    :height: 3.4in

FreeNAS® supports several types of shares for providing storage data to the clients in a network. The initial wizard can be used to quickly make shares using
default permissions which should "just work" for common scenarios. If you wish to configure more complex scenarios, refer to the section on :ref:`Sharing`.

To create a share using the wizard, input a name, then select the "Purpose" of the share:

* **Windows (CIFS):** this type of share can be accessed by any operating system using a CIFS client. Check the box for "Allow Guest" if users should not be
  prompted for a password in order to access the share. If you make any CIFS shares using the wizard, you can fine-tune them afterwards using
  :ref:`Windows (CIFS) Shares`.

* **Mac OS X (AFP):** this type of share can be accessed by Mac OS X users. Check the box for "Time Machine" if Mac users will be using the FreeNAS® system
  as a backup device. If you make any AFP shares using the wizard, you can fine-tune them afterwards using :ref:`Apple (AFP) Shares`.

* **Generic Unix (NFS):** this type of share can be accessed by any operating system using a NFS client. If you make any NFS shares using the wizard, you can
  fine-tune them afterwards using :ref:`Unix (NFS) Shares`.

* **Block Storage (iSCSI):** this type of share can be accessed by any operating system using iSCSI initiator software. Input the size of the block storage to
  create in the format *20G* (for 20 GB). If you make any iSCSI shares using the wizard, you can fine-tune them afterwards using :ref:`iSCSI`.

After selecting the "Purpose", click the "Ownership" button to see the screen shown in Figure 3.1e.

**Figure 3.1e: Share Permissions**

|wizard5.png|

.. |wizard5.png| image:: images/wizard5.png
    :width: 3.2in
    :height: 2.3in

The default permissions for the share will be displayed. To create a user or group, input the desired name, then check the "Create User" box, to create that
user, and the "Create Group" box, to create that group. Check or uncheck the boxes in the "Mode" section to set the initial access permissions for the share.
When finished, click the "Return" button to return to the share creation screen. Click the "Add" button to finish creating that share, which will then
appear in the "Name" frame.

You can use the "Delete" button to remove the highlighted share in the "Name" frame. If you need to edit a share, highlight it, make the change, then press
the "Update" button.

When you are finished making shares, click the "Next" button to advance to the screen shown in Figure 3.1f.

**Figure 3.1f: Miscellaneous Settings**

|wizard6.png|

.. |wizard6.png| image:: images/wizard6.png
    :width: 3.44in
    :height: 3.99in

This screen can be used to configure the following settings:

* **Console messages:** check this box if you would like to view system messages at the bottom of the graphical administrative interface. This can be handy
  when troubleshooting a service that will not start. When using the console message view, if you click the console messages area, it will pop-up as a window,
  allowing you to scroll through the output and to copy its contents.

* **Root E-mail:** FreeNAS® provides an "Alert" icon in the upper right corner to provide a visual indication of events that warrant administrative
  attention. The alert system automatically emails the *root* user account whenever an alert is issued. **It is important** to input the email address of the
  person to receive these alerts and other administrative emails. The rest of the email settings in this screen should also be reviewed and edited as
  necessary. Before leaving this screen, click the "Send Test Mail" button to ensure that email notifications are working correctly.

* **From email:** the from email address to use when sending email notifications.

* **Outgoing mail server:** hostname or IP address of SMTP server.

* **Port to connect to:** port number used by the SMTP server.

* **TLS/SSL:** encryption type used by the SMTP server.

* **Use SMTP Authentication:** check this box if the SMTP server requires authentication.

* **Username:** input the username if the SMTP server requires authentication.

* **Password:** input the password if the SMTP server requires authentication.

When finished, click "Next". A message will indicate that the wizard is now ready to perform all of the saved actions. If you wish to make any changes, click
the "Return to Wizard" button to review your edits. If you click the "Exit without saving" button, none of your selections will be saved. To save your edits,
click the "Confirm" button. A status bar will indicate when the wizard has completed applying your settings.

In addition to the settings that you specify, the wizard will automatically enable :ref:`S.M.A.R.T. Tests`, create a boot environment, and add the new boot
environment to the boot menu. If you also wish to save a backup of the configuration database to the system being used to access the administrative graphical
interface, go to :menuselection:`System --> General`, click the "Save Config" button, and browse to the directory to save the configuration to.
**It is recommended to always backup your configuration after making any configuration changes**.

The rest of this Guide describes the FreeNAS® graphical interface in more detail. The layout of this Guide follows the order of the menu items in the tree
located in the left frame of the graphical interface.

.. note:: it is important to use the GUI (or the Console Setup menu) for all configuration changes. FreeNAS® uses a configuration database to store its
   settings. While it is possible to use the command line to modify your configuration, changes made at the command line **are not** written to the
   configuration database. This means that any changes made at the command line will not persist after a reboot and will be overwritten by the values in the
   configuration database during an upgrade.