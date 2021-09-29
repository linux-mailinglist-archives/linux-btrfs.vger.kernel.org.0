Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645E41BFD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 09:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbhI2HZd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 29 Sep 2021 03:25:33 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:23676 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbhI2HZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 03:25:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 42F413F471;
        Wed, 29 Sep 2021 09:23:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zfiMAWNkVi4X; Wed, 29 Sep 2021 09:23:50 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E6C9E3F2B8;
        Wed, 29 Sep 2021 09:23:49 +0200 (CEST)
Received: from [8.14.199.9] (port=51432 helo=[100.103.151.41])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mVTwT-0000Lx-9g; Wed, 29 Sep 2021 09:23:49 +0200
Date:   Wed, 29 Sep 2021 09:23:48 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     brandonh@wolfram.com, linux-btrfs@vger.kernel.org
Message-ID: <ce9f317.4dc05cb0.17c3070258f@tnonline.net>
In-Reply-To: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
References: <70668781.1658599.1632882181840.JavaMail.zimbra@wolfram.com>
Subject: Re: btrfs metadata has reserved 1T of extra space and balances
 don't reclaim it
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Brandon Heisner <brandonh@wolfram.com> -- Sent: 2021-09-29 - 04:23 ----

> I have a server running CentOS 7 on 4.9.5-1.el7.elrepo.x86_64 #1 SMP Fri Jan 20 11:34:13 EST 2017 x86_64 x86_64 x86_64 GNU/Linux.  It is version locked to that kernel.  The metadata has reserved a full 1T of disk space, while only using ~38G.  I've tried to balance the metadata to reclaim that so it can be used for data, but it doesn't work and gives no errors.  It just says it balanced the chunks but the size doesn't change.  The metadata total is still growing as well, as it used to be 1.04 and now it is 1.08 with only about 10G more of metadata used.  I've tried doing balances up to 70 or 80 musage I think, and the total metadata does not decrease.  I've done so many attempts at balancing, I've probably tried to move 300 chunks or more.  None have resulted in any change to the metadata total like they do on other servers running btrfs.  I first started with very low musage, like 10 and then increased it by 10 to try to see if that would balance any chunks out, but with no success.
> 
> # /sbin/btrfs balance start -musage=60 -mlimit=30 /opt/zimbra
> Done, had to relocate 30 out of 2127 chunks
> 
> I can do that command over and over again, or increase the mlimit, and it doesn't change the metadata total ever.
> 
> 
> # btrfs fi show /opt/zimbra/
> Label: 'Data'  uuid: ece150db-5817-4704-9e84-80f7d8a3b1da
>         Total devices 4 FS bytes used 1.48TiB
>         devid    1 size 1.46TiB used 1.38TiB path /dev/sde
>         devid    2 size 1.46TiB used 1.38TiB path /dev/sdf
>         devid    3 size 1.46TiB used 1.38TiB path /dev/sdg
>         devid    4 size 1.46TiB used 1.38TiB path /dev/sdh
> 
> # btrfs fi df /opt/zimbra/
> Data, RAID10: total=1.69TiB, used=1.45TiB
> System, RAID10: total=64.00MiB, used=640.00KiB
> Metadata, RAID10: total=1.08TiB, used=37.69GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # btrfs fi us /opt/zimbra/ -T
> Overall:
>     Device size:                   5.82TiB
>     Device allocated:              5.54TiB
>     Device unallocated:          291.54GiB
>     Device missing:                  0.00B
>     Used:                          2.96TiB
>     Free (estimated):            396.36GiB      (min: 396.36GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
>             Data      Metadata  System
> Id Path     RAID10    RAID10    RAID10    Unallocated
> -- -------- --------- --------- --------- -----------
>  1 /dev/sde 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  2 /dev/sdf 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  3 /dev/sdg 432.75GiB 276.00GiB  16.00MiB   781.65GiB
>  4 /dev/sdh 432.75GiB 276.00GiB  16.00MiB   781.65GiB
> -- -------- --------- --------- --------- -----------
>    Total      1.69TiB   1.08TiB  64.00MiB     3.05TiB
>    Used       1.45TiB  37.69GiB 640.00KiB
> 
> 
> 
> 
> 
> 
> -- 
> Brandon Heisner
> System Administrator
> Wolfram Research


What are you mount options? Do you by any chance use metadata_ratio mount option?

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)#MOUNT_OPTIONS

