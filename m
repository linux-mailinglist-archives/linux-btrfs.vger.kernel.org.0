Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB2130DF9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAFH2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 02:28:15 -0500
Received: from p-impout005aa.msg.pkvw.co.charter.net ([47.43.26.136]:46839
        "EHLO p-impout001.msg.pkvw.co.charter.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgAFH2P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 02:28:15 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2020 02:28:15 EST
Received: from static.bllue.org ([66.108.6.151])
        by cmsmtp with ESMTP
        id oMhGiO8b8lLVdoMhGiT0EW; Mon, 06 Jan 2020 07:21:07 +0000
X-Authority-Analysis: v=2.3 cv=bI1o382Z c=1 sm=1 tr=0
 a=M990Q3uoC/f4+l9HizUSNg==:117 a=M990Q3uoC/f4+l9HizUSNg==:17
 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10 a=GYvdD8XHAAAA:8 a=6Ci7PHSpAa3l-Btj5N8A:9
 a=CjuIK1q_8ugA:10 a=xHna-gahby6lLgJe_Woh:22
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id 22808C6762
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2020 02:21:01 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Jan 2020 02:21:01 -0500
From:   Kenneth Topp <toppk@bllue.org>
To:     linux-btrfs@vger.kernel.org
Subject: /bin/df showing btrfs filesystem full
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <4f3eb367af2a4585c30f96c6d7e910a4@bllue.org>
X-Sender: toppk@bllue.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on static.bllue.org
X-CMAE-Envelope: MS4wfE1bXuc+wGvlkniR//wRgtf33NpQE0j3cyKVq57jUqdCnsTcj5OA6B77LxudHJjg/+uitdbn7AbOUGhejpHzBoV/an30Jj5EZWDx16F/++bxa2Lr9Lat
 WGPNoNKPdF3c+cgtjk7I21mCt0h1ePGbvcFQw+1qKw0TNUGNsrVuYbwAVy1i73YKkJoSJadVNVigPQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hi.

I have an issue were periodically a btrfs filesystem shows 100% utilized 
0% available
# df -h /home
Filesystem           Size  Used Avail Use% Mounted on
/dev/mapper/cprt-50   30T   20T     0 100% /home


Then it goes back to normal as follows:

# df -h /home
Filesystem           Size  Used Avail Use% Mounted on
/dev/mapper/cprt-50   30T   20T  9.7T  67% /home


This filesystem was created on this kernel 5.4.6 that it's currently 
running.  This filesystem went from 0tb used to 20tb used and would show 
this problem periodically as i was filling up the drive.   There was no 
ENOSPACE issues, so I thought it was just related to the heavy writing, 
but now that the system is in regular service, it's still periodically 
"filling up".  but again, the only symptom I can see is gnome and df 
showing the drive being full.  nothing else indicates that the drive is 
full.

I have some other btrfs filesystems that didn't show any issues.  They 
were created under earlier kernels, but with the same options.  the 
other difference is this new filesystem is on top 4kn drives, where the 
others are all 512e.

Any advice would be welcome, for now I'm just ignoring the problem, and 
making sure my backups are good.


filesystem creation commands:

mkfs.btrfs -f  -O no-holes -d single -m raid1 -L tm /dev/mapper/cprt-50 
/dev/mapper/cprt-53

first time mounted was with this:
mount -o clear_cache,space_cache=v2 LABEL=tm /mnt

diagnostics commands:



#   uname -a
Linux static.bllue.org 5.4.6-301.fc31.x86_64 #1 SMP Tue Dec 24 15:09:19 
EST 2019 x86_64 x86_64 x86_64 GNU/Linux
#   btrfs --version
btrfs-progs v5.4
#   btrfs fi show
Label: 't2'  uuid: ce50d21c-7727-4a53-b804-d02480643dfa
         Total devices 2 FS bytes used 640.00KiB
         devid    1 size 447.13GiB used 2.01GiB path /dev/mapper/cprt-30
         devid    2 size 447.13GiB used 2.01GiB path /dev/mapper/cprt-31

Label: 'btm'  uuid: 0a5b42a7-0e39-48fa-be1f-4aa29bc323f2
         Total devices 2 FS bytes used 19.45TiB
         devid    1 size 14.55TiB used 9.75TiB path /dev/mapper/cprt-50
         devid    2 size 14.55TiB used 9.75TiB path /dev/mapper/cprt-53


#   btrfs fi df /home # Replace /home with the mount point of your 
btrfs-filesystem
Data, single: total=19.45TiB, used=19.43TiB
System, RAID1: total=32.00MiB, used=2.05MiB
Metadata, RAID1: total=26.00GiB, used=25.73GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
