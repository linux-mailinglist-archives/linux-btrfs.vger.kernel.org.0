Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8B34A560
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCZKPQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 26 Mar 2021 06:15:16 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1954 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCZKO4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 06:14:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 094AB3F5ED;
        Fri, 26 Mar 2021 11:14:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4q-tKT8K6aOn; Fri, 26 Mar 2021 11:14:53 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1D8513F405;
        Fri, 26 Mar 2021 11:14:52 +0100 (CET)
Received: from [2a00:801:747:b131::b538:e47d] (port=53722 helo=[10.234.220.40])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <forza@tnonline.net>)
        id 1lPjUS-0008dh-I6; Fri, 26 Mar 2021 11:14:52 +0100
Date:   Fri, 26 Mar 2021 11:14:52 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     "Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <637fa4a.4ab909a3.1786e07901f@tnonline.net>
In-Reply-To: <cb24366003a74b63a1db3ff8018c9692@claas.com>
References: <8a4b55eb42bd42d181abe9d7c208607c@claas.com> <20210325205857.412ab914@natsu> <f50ee91d04c94feda3a6ce413332e83d@claas.com> <20210326134421.24cd109a@natsu> <cb24366003a74b63a1db3ff8018c9692@claas.com>
Subject: AW: Why doesn't btrfs find additional space after (VMware) disk
 extension?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: "Wulfhorst, Heiner" <Heiner.Wulfhorst@claas.com> -- Sent: 2021-03-26 - 10:42 ----

> Thanks, Roman, you got me back on Track!
> 
> I am new to btrfs so I was assuming RAID0 means there is no need for equally
> sized disks.
> 
> After `btrfs balance start -dconvert=single -dlimit=10 /' output of `btrfs
> filesystem usage /' now shows:
> 
> Overall:
>     Device size:                 579.51GiB
>     Device allocated:            126.99GiB
>     Device unallocated:          452.52GiB
>     Device missing:                  0.00B
>     Used:                        125.42GiB
>     Free (estimated):            452.72GiB      (min: 226.46GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:               24.05MiB      (used: 0.00B)
> 
> Data,single: Size:19.00GiB, Used:18.98GiB
>    /dev/sdd       19.00GiB
> 
> Data,RAID0: Size:105.97GiB, Used:105.79GiB
>    /dev/sdb2      36.99GiB
>    /dev/sdc       31.99GiB
>    /dev/sdd       36.99GiB
> 
> Metadata,RAID1: Size:1.00GiB, Used:333.61MiB
>    /dev/sdb2       1.00GiB
>    /dev/sdd        1.00GiB
> 
> System,RAID1: Size:8.00MiB, Used:16.00KiB
>    /dev/sdc        8.00MiB
>    /dev/sdd        8.00MiB
> 
> Unallocated:
>    /dev/sdb2       9.52GiB
>    /dev/sdc        1.00MiB
>    /dev/sdd      443.00GiB
> 
> 
> 
> And finally:
> # df -h
> Filesystem      Size  Used Avail Use% Mounted on
> devtmpfs        3.9G  8.0K  3.9G   1% /dev
> tmpfs           3.9G     0  3.9G   0% /dev/shm
> tmpfs           3.9G   17M  3.9G   1% /run
> tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
> /dev/sdb2       580G  126G   20G  87% /
> /dev/sdb2       580G  126G   20G  87% /.snapshots
> /dev/sdb2       580G  126G   20G  87% /usr/local
> /dev/sdb2       580G  126G   20G  87% /opt
> /dev/sdb2       580G  126G   20G  87% /root
> /dev/sdb2       580G  126G   20G  87% /boot/grub2/i386-pc
> /dev/sdb2       580G  126G   20G  87% /boot/grub2/x86_64-efi
> /dev/sdb2       580G  126G   20G  87% /srv
> /dev/sdb2       580G  126G   20G  87% /var
> /dev/sdb2       580G  126G   20G  87% /tmp
> /dev/sdb2       580G  126G   20G  87% /home
> /dev/sdb2       580G  126G   20G  87% /var/cache
> /dev/sdb1       500M  5.3M  495M   2% /boot/efi
> tmpfs           796M     0  796M   0% /run/user/0
> 
> Thanks a lot! I will now read further documentation regarding "btrfs single
> vs RAID*" to understand exactly why and how and also convert remaining space
> to single (it's just a test
> system).
> 
> Thanks a lot!
> 
> BR,
> Heiner

There is an excellent disk space calculator for Btrfs at https://www.carfax.org.uk/btrfs-usage/ 

You can test different disk sizes and RAID profiles to see what actual user disk space you get. 

Regards, 
Forza 


