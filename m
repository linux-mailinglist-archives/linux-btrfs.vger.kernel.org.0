Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D017C174CC6
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAKiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 05:38:19 -0500
Received: from mail.virtall.com ([46.4.129.203]:49492 "EHLO mail.virtall.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgCAKiS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 1 Mar 2020 05:38:18 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 05:38:16 EST
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id 2ED4D3F630C8
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2020 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1583058636; bh=cRmqdcYPbhO5nkRkZY5ClqhOhEjMgx7o3lw5vlY4KA4=;
        h=Date:From:To:Subject;
        b=MAmG4ewpW9sMST0SVbqFBddKEprklQO71ydTuz2wWsMuwp1R/6T9AnXd1dkblM/7N
         Kyh1m+H96ybR87X++u9paKpWmrvkci5uRA4lbywiyENzYZHxOIwHfK+5Ig4LDH3dAW
         UaFfschSqxIlmiqAb+dqAgJMNyGK6B2fpPLJC3It8dhkWZ3cd28IdrZ12CBXz4my1l
         VOBeNsktAyEEIsE1ckZ1Qwqk91zGKvvJUn85sAxq7kpgHci5xtrAEe04UohHp/ZGd6
         9EUnpbzrskwDpU1tx1mV0WaA+MAuyXdnF51g+8Z3dQ9Heif3EMXj30RJC5pRec03JA
         UtjE2VQLZji0w==
X-Fuglu-Suspect: bb06b23b802e4512be6d385988fb479a
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2020 10:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 01 Mar 2020 19:30:34 +0900
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: balance conversion from RAID-1 to RAID-10 leaves some metadata in
 RAID-1?
Message-ID: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
X-Sender: mangoo@wpkg.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just finished a conversion from RAID-1 to RAID-10, on Linux 5.5.6:

# time btrfs balance start -dconvert=raid10 -mconvert=raid10 /data/lxd
Done, had to relocate 2064 out of 2064 chunks

real    1811m51.427s
user    0m0.000s
sys     1259m34.448s


# echo $?
0

# dmesg
(...)
[211862.205521] BTRFS info (device sda2): found 40805 extents
[211910.773888] BTRFS info (device sda2): found 40805 extents
[211965.321150] BTRFS info (device sda2): relocating block group 
3492979671040 flags data|raid1
[211972.743476] BTRFS info (device sda2): found 37221 extents
[212020.193342] BTRFS info (device sda2): found 37221 extents
[212084.580739] BTRFS info (device sda2): balance: ended with status: 0


To my surprise, some metadata is still RAID-1 - is it expected?

# btrfs fi usage /data/lxd
Overall:
     Device size:                   6.91TiB
     Device allocated:              6.70TiB
     Device unallocated:          210.40GiB
     Device missing:                  0.00B
     Used:                          3.96TiB
     Free (estimated):              1.46TiB      (min: 1.46TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID10: Size:3.32TiB, Used:1.97TiB (59.20%)
    /dev/sda2       1.66TiB
    /dev/sdd2       1.66TiB
    /dev/sdc2       1.66TiB
    /dev/sdb2       1.66TiB

Metadata,RAID1: Size:2.00GiB, Used:85.02MiB (4.15%)
    /dev/sdc2       2.00GiB
    /dev/sdb2       2.00GiB

Metadata,RAID10: Size:29.00GiB, Used:12.55GiB (43.27%)
    /dev/sda2      14.50GiB
    /dev/sdd2      14.50GiB
    /dev/sdc2      14.50GiB
    /dev/sdb2      14.50GiB

System,RAID10: Size:64.00MiB, Used:400.00KiB (0.61%)
    /dev/sda2      32.00MiB
    /dev/sdd2      32.00MiB
    /dev/sdc2      32.00MiB
    /dev/sdb2      32.00MiB

Unallocated:
    /dev/sda2      53.60GiB
    /dev/sdd2      53.60GiB
    /dev/sdc2      51.60GiB
    /dev/sdb2      51.60GiB


# btrfs fi df /data/lxd
Data, RAID10: total=3.32TiB, used=1.97TiB
System, RAID10: total=64.00MiB, used=400.00KiB
Metadata, RAID10: total=29.00GiB, used=12.55GiB
Metadata, RAID1: total=2.00GiB, used=85.02MiB
GlobalReserve, single: total=512.00MiB, used=0.00B


# btrfs fi show /data/lxd
Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
         Total devices 4 FS bytes used 1.98TiB
         devid    1 size 1.73TiB used 1.67TiB path /dev/sda2
         devid    3 size 1.73TiB used 1.67TiB path /dev/sdd2
         devid    4 size 1.73TiB used 1.68TiB path /dev/sdc2
         devid    5 size 1.73TiB used 1.68TiB path /dev/sdb2




Tomasz Chmielewski
https://lxadm.com
