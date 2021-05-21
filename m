Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9364138CEAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhEUUNG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 21 May 2021 16:13:06 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:34858 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhEUUNF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 16:13:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8F42C3F911;
        Fri, 21 May 2021 22:11:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J58RQGoFTDEo; Fri, 21 May 2021 22:11:39 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7758A3F54E;
        Fri, 21 May 2021 22:11:38 +0200 (CEST)
Received: from [192.168.0.126] (port=37254)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1lkBUf-0001fh-Ll; Fri, 21 May 2021 22:11:37 +0200
Date:   Fri, 21 May 2021 22:11:38 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
Message-ID: <89853f6.7deb9c63.179908e0b59@tnonline.net>
In-Reply-To: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
References: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
Subject: Re: Btrfs not using all devices in raid1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Leszek Dubiel <leszek@dubiel.pl> -- Sent: 2021-05-21 - 18:34 ----

> 
> Hello!
> 
> Why Btrfs is not using /dev/sdc2?
> There is no line "Data,RAID1" for this disk.
> Isn't it supposed to use disk that has most of free space?
> 
> Thanks for help :) :)
> Using Btrfs in production.
> 
> 
> Here are some command outputs:
> 
> 
> 
> ### btrfs fi show /
> 
> Label: none  uuid: ea6ae51d-d9b0-4628-a8f3-3406e1dc59c6
>      Total devices 4 FS bytes used 2.96TiB
>      devid    1 size 7.25TiB used 3.20TiB path /dev/sda2
>      devid    2 size 7.25TiB used 3.20TiB path /dev/sdb2
>      devid    3 size 7.25TiB used 3.21TiB path /dev/sdd2
>      devid    4 size 7.25TiB used 32.00MiB path /dev/sdc2
> 
> 
> 
> ### btrfs fi df /
> 
> Data, RAID1: total=4.49TiB, used=2.90TiB
> System, RAID1: total=64.00MiB, used=784.00KiB
> Metadata, RAID1: total=321.00GiB, used=56.08GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> 
> ### btrfs dev usa /
> 
> /dev/sda2, ID: 1
>     Device size:             7.25TiB
>     Device slack:              0.00B
>     Data,RAID1:              2.99TiB
>     Metadata,RAID1:        210.00GiB
>     System,RAID1:           64.00MiB
>     Unallocated:             4.05TiB
> 
> /dev/sdb2, ID: 2
>     Device size:             7.25TiB
>     Device slack:              0.00B
>     Data,RAID1:              3.00TiB
>     Metadata,RAID1:        210.00GiB
>     Unallocated:             4.04TiB
> 
> /dev/sdc2, ID: 4
>     Device size:             7.25TiB
>     Device slack:              0.00B   ... no Data/RAID1
>     System,RAID1:           32.00MiB
>     Unallocated:             7.25TiB
> 
> /dev/sdd2, ID: 3
>     Device size:             7.25TiB
>     Device slack:              0.00B
>     Data,RAID1:              2.99TiB
>     Metadata,RAID1:        222.00GiB
>     System,RAID1:           32.00MiB
>     Unallocated:             4.04TiB
> 
> 
> 
> ### time btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /
> 
> Done, had to relocate 0 out of 4922 chunks
> 
> real    0m0,522s
> user    0m0,000s
> sys    0m0,033s
> 
> 

Raid1 means two copies on different devices. This is fulfilled with the previous 3 drives so the  'soft' keyword is not going to help here. 

You can do a full data balance (-dusage=100) to move some data across to the new disk. There is no need to do a metadata balance in this case, unless you want to convert to raid1c3 to have three copies of metadata. 

If you do nothing, the filesystem will eventually balance itself as you add abs delete data. 

https://btrfs.wiki.kernel.org/index.php/Balance_Filters


