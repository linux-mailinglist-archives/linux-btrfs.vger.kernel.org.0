Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12320333246
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCJAWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 19:22:40 -0500
Received: from krystal1.wisercloud.co.uk ([185.53.58.188]:46026 "EHLO
        krystal1.wisercloud.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCJAWK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 19:22:10 -0500
X-Greylist: delayed 4401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 19:22:09 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lINsJEUu5AqvuHZM0pHHf0QVU5OuGFN0p4aMWcAZ1os=; b=r3LDCstttMzHgbVCDd6pu6SYq7
        DPZ4lUP2gR0rDnILA0ELXFaW0xR4vi+jSOsNN1HZ3VduqttFCQhcOLEkpUCR8ysmuODT0ocwZEgWL
        iVcH77XtuOyNtmXGzKVGHuds11gTng5pGO5mgLp11qfVdUIFlr7i4vOaKbWsSYZtcKu051oqzo4Cm
        2Q418OARih5tCzL05LazIBRavfL1aWGsEMCqVqKvjJ3oi6ALWftrYSvCcZdaOgCVzyH45A1LC43EB
        5WVtQFSXBHXD/MksUr+HMWnPKaA+nk9dbQFdKPrQiL4Xa3FaM7EjglV8amB+uSBYmJoJYfy4ju0NP
        G3MHwucw==;
Received: from cpc75872-ando7-2-0-cust919.15-1.cable.virginm.net ([86.13.79.152]:36648 helo=phoenix.exfire)
        by krystal1.wisercloud.co.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <pete@petezilla.co.uk>)
        id 1lJlT5-00EXlW-2k
        for linux-btrfs@vger.kernel.org; Tue, 09 Mar 2021 23:08:47 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Pete <pete@petezilla.co.uk>
Subject: Cannot add a device to a btrfs, btrfs on lvm and dm-crypt / luks
Message-ID: <99a86fc6-2931-c969-f46a-c04f819d2b4d@petezilla.co.uk>
Date:   Tue, 9 Mar 2021 23:08:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krystal1.wisercloud.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: krystal1.wisercloud.co.uk: authenticated_id: pete+petezilla.co.uk/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: krystal1.wisercloud.co.uk: pete@petezilla.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am unsure where I am going wrong here.  This might be a btrfs device
adding issue, or more likely this is a complex file system stack which I
don't touch much and I'm doing something wrong.  I'm posting here as at
the moment my logical conclusion is that it is a btrfs issue, but in all
likelihood it is probably me.

Kernel 5.10.19
btrfs-progs 5.10.1
Slackware current (but with my own kernel).

The basic difference between the stock slackware kernel the one I build
is I usually building in the common file system drivers rather than have
them as modules to avoid creating an initrd.

I have a nvme drive which I have encrypted with dm-crypt / luks format.
The stack looks like:

Hardware: nvme0
  -> dm-crypt
    --> lvm
      --> nvme_vg-lxc-20200226 - existing btrfs
      --> nvme_vg-lxc_db - xfs for mariadb data
      --> nvme_vg_virt - for qemu images etc. (xfs I think)
      --> nvme_vg-lxc-20210309 - new device to add to existing btrfs



This is opened (with small tweaks for privacy) with:
/usr/sbin/cryptsetup luksOpen UUID=<UUID>  nvme0

I have created a physical volume group on this device:
root@phoenix:/mnt# pvscan
  PV /dev/mapper/nvme0   VG nvme0_vg        lvm2 [<429.00 GiB / <19.00
GiB free]
  Total: 1 [<429.00 GiB] / in use: 1 [<429.00 GiB] / in no VG: 0 [0   ]

Looking in /dev/mapper I have
ls -al /dev/mapper/nvme*
lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0 -> ../dm-1
lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-lxc_20200626
-> ../dm-4
lrwxrwxrwx 1 root root 7 Mar  9 22:15 /dev/mapper/nvme0_vg-lxc_20210309
-> ../dm-5
lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-lxc_db -> ../dm-2
lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-virt -> ../dm-3

The logical volumes are:
root@phoenix:/mnt# lvscan
  ACTIVE            '/dev/nvme0_vg/lxc_db' [50.00 GiB] inherit
  ACTIVE            '/dev/nvme0_vg/virt' [30.00 GiB] inherit
  ACTIVE            '/dev/nvme0_vg/lxc_20200626' [80.00 GiB] inherit
  ACTIVE            '/dev/nvme0_vg/lxc_20210309' [250.00 GiB] inherit

All good.  The logical volume /dev/nvme0_vg/lxc_20200626 is mounted on
/var/lib/lxc as a btrfs with no issue except for being a bit on the
small side.  I therefore created a larger physical volume
/dev/nvme0_vg/lxc_20210309 with the aim of adding it to the btrfs
mounted on /var/lib/lxc.  I can later remove the smaller lxc logical
volume from the file system.  That seems a neater solution than resizing
a live file system.  However, when I try adding the logical volume to
the file system I get:

cd /var/lib/lxc

root@phoenix:/var/lib/lxc# btrfs dev add /dev/nvme0_vg/lxc_20210309 .
ERROR: error adding device 'dm-5': No such file or directory.  I can see
no messages in /var/log/messages, /var/log/syslog or with dmesg.

If I zero out the first 10M I get no difference.

root@phoenix:/var/lib/lxc# dd if=/dev/zero of=/dev/nvme0_vg/lxc_20210309
bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0216118 s, 485 MB/s
root@phoenix:/var/lib/lxc# btrfs dev add /dev/nvme0_vg/lxc_20210309 .
ERROR: error adding device 'dm-5': No such file or directory
root@phoenix:/var/lib/lxc#

Note that /dev/nvme0_vg/lxc_20210309 is a symlink to /dev/dm-5.

For whatever reason /dev/nvme0_vg/lxc_20210309 looks to be an issue.
However, I can create an ext4 file system on it or a new btrfs on it and
mount it:

root@phoenix:/var/lib/lxc# mkfs.btrfs /dev/nvme0_vg/lxc_20210309
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
you want to force metadata duplication.
Label:              (null)
UUID:               b6c37a47-6029-441c-8092-dbe3a1bdd549
Node size:          16384
Sector size:        4096
Filesystem size:    250.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         single            8.00MiB
  System:           single            4.00MiB
SSD detected:       yes
Incompat features:  extref, skinny-metadata
Runtime features:
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1   250.00GiB  /dev/nvme0_vg/lxc_20210309

root@phoenix:/var/lib/lxc# mount /dev/nvme0_vg/lxc_20210309 /mnt/zip
root@phoenix:/var/lib/lxc# mount | grep zip
/dev/mapper/nvme0_vg-lxc_20210309 on /mnt/zip type btrfs
(rw,relatime,ssd,space_cache,subvolid=5,subvol=/)
root@phoenix:/var/lib/lxc#
root@phoenix:/var/lib/lxc# cd /mnt/zip
root@phoenix:/mnt/zip# ls
root@phoenix:/mnt/zip# touch wibble
root@phoenix:/mnt/zip# ls -al
total 16
drwxr-xr-x 1 root root  12 Mar  9 22:39 ./
drwxr-xr-x 1 root root 276 Sep 26  2006 ../
-rw-r--r-- 1 root root   0 Mar  9 22:39 wibble
root@phoenix:/mnt/zip#

I'm at a loss to understand what is going on.  If this problematic
logical volume cannot be added to an existing btrfs why can I create a
fresh file system on it?  Ext4 works as well, but I did not think the
example useful over the one above.

I could just create a new btrfs on the new logical volume for lxc and
copy the data across.  Slightly wary if the error I am seeing when I try
to add it to an existing file system is occurring that this will not
bite me later.

For completeness the old btrfs looks like this:
root@phoenix:/var/lib/lxc# btrfs fi u .
Overall:
    Device size:                  80.00GiB
    Device allocated:             80.00GiB
    Device unallocated:            1.00MiB
    Device missing:                  0.00B
    Used:                         69.33GiB
    Free (estimated):              3.91GiB      (min: 3.91GiB)
    Free (statfs, df):             3.91GiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:62.01GiB, Used:58.10GiB (93.70%)
   /dev/mapper/nvme0_vg-lxc_20200626      62.01GiB

Metadata,single: Size:17.99GiB, Used:11.22GiB (62.41%)
   /dev/mapper/nvme0_vg-lxc_20200626      17.99GiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/mapper/nvme0_vg-lxc_20200626       4.00MiB

Unallocated:
   /dev/mapper/nvme0_vg-lxc_20200626       1.00MiB
root@phoenix:/var/lib/lxc#


Any thoughts?


I realise that this filesystem stack is complex.  The reason is that I
am running mariadb and I have used lvm to create a logical volume with a
xfs partition to hold the database as that is supposed to work better,
at least historically.  Similar concerns with the qemu images.  I'm
unsure of whether it gives me a sufficient performance difference to be
worth the extra complexity, and if I can't tell subjectively it is not
clear that the extra complexity is worthwhile.

regards,

Pete







