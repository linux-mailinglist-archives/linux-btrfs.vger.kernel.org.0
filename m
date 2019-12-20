Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91A127BA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 14:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLTN1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 08:27:07 -0500
Received: from mail.nethype.de ([5.9.56.24]:42713 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfLTN1G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 08:27:06 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiIJ6-003UIU-6v; Fri, 20 Dec 2019 13:27:04 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiIJ5-0000te-Un; Fri, 20 Dec 2019 13:27:03 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiIJ5-0001lq-UL; Fri, 20 Dec 2019 14:27:03 +0100
Date:   Fri, 20 Dec 2019 14:27:03 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220132703.GA3435@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> >  [  102.393185] BTRFS: device label COLD1 devid 5 transid 1876906 /dev/dm-30
> 
> dm-30 is one transaction older than other devices.
> 
> Is that expected? If not, it may explain why we got the dead device. As
> we're using older superblock, which may points to older chunk tree which
> has the device item.

Well, not that my expectation here would mean anything, but no, from
experience I have never seen the transids to disagree, or bad thingsa will
happen...

> >  [  109.626550] BTRFS: device label COLD1 devid 4 transid 1876907 /dev/dm-32
> >  [  109.654401] BTRFS: device label COLD1 devid 3 transid 1876907 /dev/dm-31
> 
> And I'm also curious about the 7s delay between devid5 and devid 3/4
> detection.

That is about the time it takes the disk to wake up when its spinned down,
so maybe that was the case - the disks are used for archiving ("cold"
storage), have a short spin-down and btrfs filesystems can takes ages to
mount. The real question is why the fortuh disk was already spun up then,
but the disks do not apply time outs very exactly.

> Can you find a way to make devid 3/4 show up before devid 5 and try again?

Unfortunately, I had to start restoring from backup a while ago, as I need
the machine up and restoring takes days.

How would I go about making it show up in different orders though? If
these messages come up independently, I could have spun down some of the
disks, right?

> And if you find a way to mount the volume RW, please write a single
> empty file, and sync the fs, then umount the fs, ensure "btrfs ins
> dump-super" gives the same transid of all 3 related disks.

I tried -o degraded followed by remounting rw, but couldn't get it to
mount rw. I tried to mount/remount, though:

   04:48:45 doom kernel: BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
   04:48:45 doom kernel: BTRFS error (device dm-32): failed to read chunk tree: -2
   04:48:45 doom kernel: BTRFS error (device dm-32): open_ctree failed
   04:49:37 doom kernel: BTRFS warning (device dm-31): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
   04:52:30 doom kernel: BTRFS warning (device dm-31): chunk 12582912 missing 1 devices, max tolerance is 0 for writable mount
   04:52:30 doom kernel: BTRFS warning (device dm-31): writable mount is not allowed due to too many missing devices
   04:52:30 doom kernel: BTRFS error (device dm-31): open_ctree failed
   04:54:01 doom kernel: BTRFS warning (device dm-32): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
   04:54:45 doom kernel: BTRFS warning (device dm-32): chunk 12582912 missing 1 devices, max tolerance is 0 for writable mount
   04:54:45 doom kernel: BTRFS warning (device dm-32): too many missing devices, writable remount is not allowed

Since (in theory :) the filesystemw a completely backed up, I didn't
bother with further recovery after I made sure the physical disk is
actually there and was unlocked (cryptsetup), so it wasn't a case of an
actual missing disk.

> > BTW, this (second issue) also happens with filesystems that are not
> > multi-device.
> 
> Single device btrfs doesn't need device scan.
> If that happened, something insane happened again...
> Thanks,

It happens since at least 4.14 on at least four machines, but I haven't
seen it recently, after I switched to 5.2.21 one some machines (post-4.4
kernels have this habit of freezing under memory pressure, and 5.2.21 has
greatly improved in this regard). That also means I had far fewer hard
resets with 5.2.21, but the problem did not happen on the last resets in
5.2.21 and 5.4.5.

I originally reported it below, with some evidence that it isn't a
hardware issue (no reset needed, just wipe the dm table while the device
is mounted which should cleanly "cut off" the write stream):

https://bugzilla.kernel.org/show_bug.cgi?id=204083

Since multiple scrubs and full reads of the volumes didn't show up any
issues, I didn't think much of it.

And if you want to hear more "insane" things, after I hard-reset
my desktop machine (5.2.21) two days ago I had to "btrfs rescue
fix-device-size" to be able to mount (can't find the kernel error atm.).

Greetings,

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
