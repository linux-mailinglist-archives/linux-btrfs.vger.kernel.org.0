Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9A33327F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCJAe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 19:34:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:39117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCJAeq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 19:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615336483;
        bh=dypSXlYkcaLcyeCi6UmRLwavQ+dxcbCm6+5i2hfGc3I=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LiE6PV9bczBz7I/42at78BR9Y0Qzv9Hg2DD+sT8I32WOC3Vi0gTwDq2cY9AH+XonP
         D6jzZAcIyQNijshOD1bFHn0LqV/MNfj7KGMBSAQMKuxMq5k1/eLbfvOk99OVuZ4zeR
         bTA349xqnmTEUvdNc9ym/5uLiC8peKnQU77nkyr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1m5WE20GQn-00qBBf; Wed, 10
 Mar 2021 01:34:43 +0100
Subject: Re: Cannot add a device to a btrfs, btrfs on lvm and dm-crypt / luks
To:     Pete <pete@petezilla.co.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <99a86fc6-2931-c969-f46a-c04f819d2b4d@petezilla.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5fd10caa-fab8-4e5d-d9bc-2339589b1b8f@gmx.com>
Date:   Wed, 10 Mar 2021 08:34:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <99a86fc6-2931-c969-f46a-c04f819d2b4d@petezilla.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:23ZJcaLtrx5Nrd7Fn3Ya4dzFcAaegkdBYEeuy18s6rOiTsH4D//
 We5sXbqzYSxXp8vcSYtLIL1VziNLinopAe3/9clwaVlrlwUAGQQGDMuriKW+IAIk9pjNC+D
 6sv7zTk42X/RFHPqIXQ0BWkO42/OkFwtP2NaWojoos+Q4r97hMkFpgrFn8RQyFrSML+23xP
 8Fz8Ng/Mh6tws5enqNg1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OPYmZ0JkJd0=:3Vy771ir+9Thm7XnDW5Kok
 xsvMPrsXSeXgc98zsV3AxwK7qNUajEGyq5rikRUsvkefmXnYb7XbIlfyDOC+RGQYaU6XkhN51
 HrkXKyFDbMJsHOm75KJlL0XwJRIslnRDlaZM9g6eRxAuwDrbxAziH2QNfvw/IZqv/sPSAOQ4Y
 IZCWtelWD1B2YroH2fdM1cTQx/pyMRnHeh70iYSVzxG7cmOBmhiXVooEUSy2f4hV0NWw88Q8S
 /aXajZcCMes9KDCOmAg4qSv+Bn3vAPZD7iP+un7nterG3/EcUQHX3P5nIHdpXD5jgRCAlz3ul
 XRJB5NlFZ+66XLF1rG/QqLjsjZbn7jDoyT1tZf5AQOykdu68gklNW6dRfIswJ1/Lue7nLpNUu
 MW11O/mJDnZS+jzI30smamhfzITBYgjta6C8vAfRf2+Mn4zb3sNn2uuN8vFd7sUTDbf37rQem
 vf5Dy9gbYtO/gBOMkSrDzjN11TLq51JuKCmO4W2m49cEdcCs/SwpMMzM54W294Bzm0TLAM2ts
 0fvbZqSmvAKjQzxVpxRL/R4dJMD9ZYcV9Y6bsKHEzdftg6rNzHcvH+4QkIVN69Wf1uVlumcZb
 pTmzWKxVUTZ50Nw87/ZQVHa4QEDbNqh0x3hTAMSkSE8boHn0t0Q6DttHScal6sfdxxaL9zkef
 jXBVGxsAmgwrGiCNudDxX+HXdvpZeD5b/OVcaYz6Ep+QqJLKIvEOMOzy6n1I5argsKFEdGt4F
 ySrNj11vdZedoi5ZQefNZ/lGsvrteVxDmCaeaEf6AC6LvYMRYQ+NoaPveMPgVB9+l9KYnRQtI
 44GXVZ29yAv6ToAfwQmUH2NQCrzPJ/nZo+r5cTmnLrUPvRP/bFqibgo8ZAx8CTr2D4eEEYxdp
 ODhVCK+nobj9+yXhwuSw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/10 =E4=B8=8A=E5=8D=887:08, Pete wrote:
> I am unsure where I am going wrong here.  This might be a btrfs device
> adding issue, or more likely this is a complex file system stack which I
> don't touch much and I'm doing something wrong.  I'm posting here as at
> the moment my logical conclusion is that it is a btrfs issue, but in all
> likelihood it is probably me.
>
> Kernel 5.10.19
> btrfs-progs 5.10.1

It's a known regression in v5.10.1 btrfs-progs, which did wrong path
normalization for device map.

It's fixed in v5.11 btrfs-progs.

Thanks,
Qu
> Slackware current (but with my own kernel).
>
> The basic difference between the stock slackware kernel the one I build
> is I usually building in the common file system drivers rather than have
> them as modules to avoid creating an initrd.
>
> I have a nvme drive which I have encrypted with dm-crypt / luks format.
> The stack looks like:
>
> Hardware: nvme0
>    -> dm-crypt
>      --> lvm
>        --> nvme_vg-lxc-20200226 - existing btrfs
>        --> nvme_vg-lxc_db - xfs for mariadb data
>        --> nvme_vg_virt - for qemu images etc. (xfs I think)
>        --> nvme_vg-lxc-20210309 - new device to add to existing btrfs
>
>
>
> This is opened (with small tweaks for privacy) with:
> /usr/sbin/cryptsetup luksOpen UUID=3D<UUID>  nvme0
>
> I have created a physical volume group on this device:
> root@phoenix:/mnt# pvscan
>    PV /dev/mapper/nvme0   VG nvme0_vg        lvm2 [<429.00 GiB / <19.00
> GiB free]
>    Total: 1 [<429.00 GiB] / in use: 1 [<429.00 GiB] / in no VG: 0 [0   ]
>
> Looking in /dev/mapper I have
> ls -al /dev/mapper/nvme*
> lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0 -> ../dm-1
> lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-lxc_20200626
> -> ../dm-4
> lrwxrwxrwx 1 root root 7 Mar  9 22:15 /dev/mapper/nvme0_vg-lxc_20210309
> -> ../dm-5
> lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-lxc_db -> ../=
dm-2
> lrwxrwxrwx 1 root root 7 Mar  9 22:01 /dev/mapper/nvme0_vg-virt -> ../dm=
-3
>
> The logical volumes are:
> root@phoenix:/mnt# lvscan
>    ACTIVE            '/dev/nvme0_vg/lxc_db' [50.00 GiB] inherit
>    ACTIVE            '/dev/nvme0_vg/virt' [30.00 GiB] inherit
>    ACTIVE            '/dev/nvme0_vg/lxc_20200626' [80.00 GiB] inherit
>    ACTIVE            '/dev/nvme0_vg/lxc_20210309' [250.00 GiB] inherit
>
> All good.  The logical volume /dev/nvme0_vg/lxc_20200626 is mounted on
> /var/lib/lxc as a btrfs with no issue except for being a bit on the
> small side.  I therefore created a larger physical volume
> /dev/nvme0_vg/lxc_20210309 with the aim of adding it to the btrfs
> mounted on /var/lib/lxc.  I can later remove the smaller lxc logical
> volume from the file system.  That seems a neater solution than resizing
> a live file system.  However, when I try adding the logical volume to
> the file system I get:
>
> cd /var/lib/lxc
>
> root@phoenix:/var/lib/lxc# btrfs dev add /dev/nvme0_vg/lxc_20210309 .
> ERROR: error adding device 'dm-5': No such file or directory.  I can see
> no messages in /var/log/messages, /var/log/syslog or with dmesg.
>
> If I zero out the first 10M I get no difference.
>
> root@phoenix:/var/lib/lxc# dd if=3D/dev/zero of=3D/dev/nvme0_vg/lxc_2021=
0309
> bs=3D1M count=3D10
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10 MB, 10 MiB) copied, 0.0216118 s, 485 MB/s
> root@phoenix:/var/lib/lxc# btrfs dev add /dev/nvme0_vg/lxc_20210309 .
> ERROR: error adding device 'dm-5': No such file or directory
> root@phoenix:/var/lib/lxc#
>
> Note that /dev/nvme0_vg/lxc_20210309 is a symlink to /dev/dm-5.
>
> For whatever reason /dev/nvme0_vg/lxc_20210309 looks to be an issue.
> However, I can create an ext4 file system on it or a new btrfs on it and
> mount it:
>
> root@phoenix:/var/lib/lxc# mkfs.btrfs /dev/nvme0_vg/lxc_20210309
> btrfs-progs v5.10.1
> See http://btrfs.wiki.kernel.org for more information.
>
> Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if
> you want to force metadata duplication.
> Label:              (null)
> UUID:               b6c37a47-6029-441c-8092-dbe3a1bdd549
> Node size:          16384
> Sector size:        4096
> Filesystem size:    250.00GiB
> Block group profiles:
>    Data:             single            8.00MiB
>    Metadata:         single            8.00MiB
>    System:           single            4.00MiB
> SSD detected:       yes
> Incompat features:  extref, skinny-metadata
> Runtime features:
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  PATH
>      1   250.00GiB  /dev/nvme0_vg/lxc_20210309
>
> root@phoenix:/var/lib/lxc# mount /dev/nvme0_vg/lxc_20210309 /mnt/zip
> root@phoenix:/var/lib/lxc# mount | grep zip
> /dev/mapper/nvme0_vg-lxc_20210309 on /mnt/zip type btrfs
> (rw,relatime,ssd,space_cache,subvolid=3D5,subvol=3D/)
> root@phoenix:/var/lib/lxc#
> root@phoenix:/var/lib/lxc# cd /mnt/zip
> root@phoenix:/mnt/zip# ls
> root@phoenix:/mnt/zip# touch wibble
> root@phoenix:/mnt/zip# ls -al
> total 16
> drwxr-xr-x 1 root root  12 Mar  9 22:39 ./
> drwxr-xr-x 1 root root 276 Sep 26  2006 ../
> -rw-r--r-- 1 root root   0 Mar  9 22:39 wibble
> root@phoenix:/mnt/zip#
>
> I'm at a loss to understand what is going on.  If this problematic
> logical volume cannot be added to an existing btrfs why can I create a
> fresh file system on it?  Ext4 works as well, but I did not think the
> example useful over the one above.
>
> I could just create a new btrfs on the new logical volume for lxc and
> copy the data across.  Slightly wary if the error I am seeing when I try
> to add it to an existing file system is occurring that this will not
> bite me later.
>
> For completeness the old btrfs looks like this:
> root@phoenix:/var/lib/lxc# btrfs fi u .
> Overall:
>      Device size:                  80.00GiB
>      Device allocated:             80.00GiB
>      Device unallocated:            1.00MiB
>      Device missing:                  0.00B
>      Used:                         69.33GiB
>      Free (estimated):              3.91GiB      (min: 3.91GiB)
>      Free (statfs, df):             3.91GiB
>      Data ratio:                       1.00
>      Metadata ratio:                   1.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
> Data,single: Size:62.01GiB, Used:58.10GiB (93.70%)
>     /dev/mapper/nvme0_vg-lxc_20200626      62.01GiB
>
> Metadata,single: Size:17.99GiB, Used:11.22GiB (62.41%)
>     /dev/mapper/nvme0_vg-lxc_20200626      17.99GiB
>
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>     /dev/mapper/nvme0_vg-lxc_20200626       4.00MiB
>
> Unallocated:
>     /dev/mapper/nvme0_vg-lxc_20200626       1.00MiB
> root@phoenix:/var/lib/lxc#
>
>
> Any thoughts?
>
>
> I realise that this filesystem stack is complex.  The reason is that I
> am running mariadb and I have used lvm to create a logical volume with a
> xfs partition to hold the database as that is supposed to work better,
> at least historically.  Similar concerns with the qemu images.  I'm
> unsure of whether it gives me a sufficient performance difference to be
> worth the extra complexity, and if I can't tell subjectively it is not
> clear that the extra complexity is worthwhile.
>
> regards,
>
> Pete
>
>
>
>
>
>
>
