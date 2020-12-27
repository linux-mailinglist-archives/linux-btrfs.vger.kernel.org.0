Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326252E314A
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Dec 2020 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgL0NRh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 08:17:37 -0500
Received: from ns2.prnet.org ([188.165.43.41]:49531 "EHLO ns2.prnet.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgL0NRh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 08:17:37 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 08:17:35 EST
Received: from extserver (extserver.prnet.org [192.168.1.101])
        by ns2.prnet.org (8.16.1/8.16.1) with ESMTP id 0BRDBxrJ025229;
        Sun, 27 Dec 2020 14:11:59 +0100
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2001:7e8:cf00:bc00:da50:e6ff:febb:ea28 (EHLO [IPv6:2001:7e8:cf00:bc00:da50:e6ff:febb:ea28]) ([2001:7e8:cf00:bc00:da50:e6ff:febb:ea28])
          by secure.prnet.org (JAMES SMTP Server ) with ESMTPA ID 1260453500;
          Sun, 27 Dec 2020 14:11:30 +0100 (CET)
Subject: Re: 5.6-5.10 balance regression?
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
From:   David Arendt <admin@prnet.org>
Message-ID: <292de7b8-42eb-0c39-d8c7-9a366f688731@prnet.org>
Date:   Sun, 27 Dec 2020 14:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <505cabfa88575ed6dbe7cb922d8914fb@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

last week I had the same problem on a btrfs filesystem after updating to 
kernel 5.10.1. I have never had this problem before kernel 5.10.x.
5.9.x did now show any problem.

Dec 14 22:30:59 xxx kernel: BTRFS info (device sda2): scrub: started on 
devid 1
Dec 14 22:31:09 xxx kernel: BTRFS info (device sda2): scrub: finished on 
devid 1 with status: 0
Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): balance: start 
-dusage=10
Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): relocating block 
group 71694286848 flags data
Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): found 1058 
extents, stage: move data extents
Dec 14 22:33:16 xxx kernel: BTRFS info (device sda2): balance: ended 
with status: -2

This is not a multidevice volume but a volume consisting of a single 
partition.

xxx ~ # btrfs fi df /u00
Data, single: total=10.01GiB, used=9.24GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=2.76GiB, used=1.10GiB
GlobalReserve, single: total=47.17MiB, used=0.00B

xxx ~ # btrfs device usage /u00
/dev/sda2, ID: 1
    Device size:            19.81GiB
    Device slack:              0.00B
    Data,single:            10.01GiB
    Metadata,single:         2.76GiB
    System,single:           4.00MiB
    Unallocated:             7.04GiB


On 12/27/20 1:11 PM, Stéphane Lesimple wrote:
> Hello,
>
> As part of the maintenance routine of one of my raid1 FS, a few days ago I was in the process
> of replacing a 10T drive with a 16T one.
> So I first added the new 16T drive to the FS (btrfs dev add), then started a btrfs dev del.
>
> After a few days of balancing the block groups out of the old 10T drive,
> the balance aborted when around 500 GiB of data was still to be moved
> out of the drive:
>
> Dec 21 14:18:40 nas kernel: BTRFS info (device dm-10): relocating block group 11115169841152 flags data|raid1
> Dec 21 14:18:54 nas kernel: BTRFS info (device dm-10): found 6264 extents, stage: move data extents
> Dec 21 14:19:16 nas kernel: BTRFS info (device dm-10): balance: ended with status: -2
>
> Of course this also cancelled the device deletion, so after that the
> device was still part of the FS. I then tried to do a balance manually,
> in an attempt to reproduce the issue:
>
> Dec 21 14:28:16 nas kernel: BTRFS info (device dm-10): balance: start -ddevid=5,limit=1
> Dec 21 14:28:16 nas kernel: BTRFS info (device dm-10): relocating block group 11115169841152 flags data|raid1
> Dec 21 14:28:29 nas kernel: BTRFS info (device dm-10): found 6264 extents, stage: move data extents
> Dec 21 14:28:46 nas kernel: BTRFS info (device dm-10): balance: ended with status: -2
>
> There were of course still plenty of room on the FS, as I added a new 16T drive
> (a btrfs fi usage is further down this email), so it struck me as odd.
> So, I tried to lower the reduncancy temporarily, expecting the balance of this block group to
> complete immediately given that there were already a copy of this data present on another drive:
>
> Dec 21 14:38:50 nas kernel: BTRFS info (device dm-10): balance: start -dconvert=single,soft,devid=5,limit=1
> Dec 21 14:38:50 nas kernel: BTRFS info (device dm-10): relocating block group 11115169841152 flags data|raid1
> Dec 21 14:39:00 nas kernel: BTRFS info (device dm-10): found 6264 extents, stage: move data extents
> Dec 21 14:39:17 nas kernel: BTRFS info (device dm-10): balance: ended with status: -2
>
> That didn't work.
> I also tried to mount the FS in degraded mode, with the drive I wanted to remove missing,
> using btrfs dev del missing, but the balance still failed with the same error on the same block group.
>
> So, as I was running 5.10.1 just for a few days, I tried an older kernel: 5.6.17,
> and retried the balance once again (with still the drive voluntarily missing):
>
> [ 413.188812] BTRFS info (device dm-10): allowing degraded mounts
> [ 413.188814] BTRFS info (device dm-10): using free space tree
> [ 413.188815] BTRFS info (device dm-10): has skinny extents
> [ 413.189674] BTRFS warning (device dm-10): devid 5 uuid 068c6db3-3c30-4c97-b96b-5fe2d6c5d677 is missing
> [ 424.159486] BTRFS info (device dm-10): balance: start -dconvert=single,soft,devid=5,limit=1
> [ 424.772640] BTRFS info (device dm-10): relocating block group 11115169841152 flags data|raid1
> [ 434.749100] BTRFS info (device dm-10): found 6264 extents, stage: move data extents
> [ 477.703111] BTRFS info (device dm-10): found 6264 extents, stage: update data pointers
> [ 497.941482] BTRFS info (device dm-10): balance: ended with status: 0
>
> The problematic block group was balanced successfully this time.
>
> I balanced a few more successfully (without the -dconvert=single option),
> then decided to reboot under 5.10 just to see if I would hit this issue again.
> I didn't: the btrfs dev del worked correctly after the last 500G or so data
> was moved out of the drive.
>
> This is the output of btrfs fi usage after I successfully balanced the
> problematic block group under the 5.6.17 kernel. Notice the multiple
> data profile, which is expected as I used the -dconvert balance option,
> and also the fact that apparently 3 chunks were allocated on new16T for
> this, even if only 1 seem to be used. We can tell because this is the
> first and only time the balance succeeded with the -dconvert option,
> hence these chunks are all under "data,single":
>
> Overall:
> Device size:        41.89TiB
> Device allocated:   21.74TiB
> Device unallocated: 20.14TiB
> Device missing:      9.09TiB
> Used:               21.71TiB
> Free (estimated):   10.08TiB (min: 10.07TiB)
> Data ratio:             2.00
> Metadata ratio:         2.00
> Global reserve:    512.00MiB (used: 0.00B)
> Multiple profiles:       yes (data)
>
> Data,single: Size:3.00GiB, Used:1.00GiB (33.34%)
> /dev/mapper/luks-new16T     3.00GiB
>
> Data,RAID1: Size:10.83TiB, Used:10.83TiB (99.99%)
> /dev/mapper/luks-10Ta       7.14TiB
> /dev/mapper/luks-10Tb       7.10TiB
> missing                   482.00GiB
> /dev/mapper/luks-new16T     6.95TiB
>
> Metadata,RAID1: Size:36.00GiB, Used:23.87GiB (66.31%)
> /dev/mapper/luks-10Tb      36.00GiB
> /dev/mapper/luks-ssd-mdata 36.00GiB
>
> System,RAID1: Size:32.00MiB, Used:1.77MiB (5.52%)
> /dev/mapper/luks-10Ta      32.00MiB
> /dev/mapper/luks-10Tb      32.00MiB
>
> Unallocated:
> /dev/mapper/luks-10Ta       1.95TiB
> /dev/mapper/luks-10Tb       1.96TiB
> missing                     8.62TiB
> /dev/mapper/luks-ssd-mdata 11.29GiB
> /dev/mapper/luks-new16T     7.60TiB
>
> I wasn't going to send an email to this ML because I knew I had nothing
> to reproduce the issue noww that it was "fixed", but now I think I'm bumping
> into the same issue on another FS, while rebalancing data after adding a drive,
> which happens to be the old 10T drive of the FS above.
>
> The btrfs fi usage of this second FS is as follows:
>
> Overall:
> Device size:        25.50TiB
> Device allocated:   22.95TiB
> Device unallocated:  2.55TiB
> Device missing:        0.00B
> Used:               22.36TiB
> Free (estimated):    3.14TiB (min: 1.87TiB)
> Data ratio:             1.00
> Metadata ratio:         2.00
> Global reserve:    512.00MiB (used: 0.00B)
> Multiple profiles:        no
>
> Data,single: Size:22.89TiB, Used:22.29TiB (97.40%)
> /dev/mapper/luks-12T        10.91TiB
> /dev/mapper/luks-3Ta         2.73TiB
> /dev/mapper/luks-3Tb         2.73TiB
> /dev/mapper/luks-10T         6.52TiB
>
> Metadata,RAID1: Size:32.00GiB, Used:30.83GiB (96.34%)
> /dev/mapper/luks-ssd-mdata2 32.00GiB
> /dev/mapper/luks-10T        32.00GiB
>
> System,RAID1: Size:32.00MiB, Used:2.44MiB (7.62%)
> /dev/mapper/luks-3Tb        32.00MiB
> /dev/mapper/luks-10T        32.00MiB
>
> Unallocated:
> /dev/mapper/luks-12T        45.00MiB
> /dev/mapper/luks-ssd-mdata2  4.00GiB
> /dev/mapper/luks-3Ta         1.02MiB
> /dev/mapper/luks-3Tb         2.97GiB
> /dev/mapper/luks-10T         2.54TiB
>
> I can reproduce the problem reliably:
>
> # btrfs bal start -dvrange=34625344765952..34625344765953 /tank
> ERROR: error during balancing '/tank': No such file or directory
> There may be more info in syslog - try dmesg | tail
>
> [145979.563045] BTRFS info (device dm-10): balance: start -dvrange=34625344765952..34625344765953
> [145979.585572] BTRFS info (device dm-10): relocating block group 34625344765952 flags data|raid1
> [145990.396585] BTRFS info (device dm-10): found 167 extents, stage: move data extents
> [146002.236115] BTRFS info (device dm-10): balance: ended with status: -2
>
> If anybody is interested in looking into this, this time I can leave the FS in this state.
> The issue is reproducible, and I can live without completing the balance for the next weeks
> or even months, as I don't think I'll need the currently unallocatable space soon.
>
> I also made a btrfs-image of the FS, using btrfs-image -c 9 -t 4 -s -w.
> If it's of any use, I can drop it somewhere (51G).
>
> I could try to bisect manually to find which version between 5.6.x and 5.10.1 started to behave
> like this, but on the first success, I won't know how to reproduce the issue a second time, as
> I'm not 100% sure it can be done solely with the btrfs-image.
>
> Note that another user seem to have encoutered a similar issue in July with 5.8:
> https://www.spinics.net/lists/linux-btrfs/msg103188.html
>
> Regards,
>
> Stéphane Lesimple.


