Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36F1275D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 07:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLTGhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 01:37:05 -0500
Received: from mail.nethype.de ([5.9.56.24]:47705 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfLTGhF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 01:37:05 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiBuI-003G3o-RJ; Fri, 20 Dec 2019 06:37:02 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiBuI-0005d2-Kn; Fri, 20 Dec 2019 06:37:02 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiBuI-0002JL-KS; Fri, 20 Dec 2019 07:37:02 +0100
Date:   Fri, 20 Dec 2019 07:37:02 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220063702.GE5861@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 01:24:20PM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > I used btrfs del /somedevice /mountpoint to remove a device, and then typed
> > sync. A short time later the system had a hard reset.
> 
> Then it doesn't look like the title.

Hmm, I am not sure I understand: do you mean the subject? The command here
is obviously not copied and pasted, and when typing it into my mail client,
I forgot the "dev" part. The exact command, I think, was this:

   btrfs dev del /dev/mapper/xmnt-cold13 /oldcold

> Normally for sync, btrfs will commit transaction, thus even something
> like the title happened, you shouldn't be affected at all.

Exactly, that is my expectation.

> > [  247.385346] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
> > [  247.386942] BTRFS error (device dm-32): failed to read chunk tree: -2
> > [  247.462693] BTRFS error (device dm-32): open_ctree failed
> 
> Is that devid 1 the device you tried to deleted?
> Or some unrelated device?

I think the device I removed had devid 1. I am not 100% sure, but I am
reasonably sure because I had "watch -n10 btrfs dev us" running while
waiting for the removal to finish and not being able to control the device
ids triggers my ocd reflexes (mostly because btrfs fi res needs the device
id even for some single-device filesystems :), so I kind of memorised
them.

> > The thing is, the device is still there and accessible, but btrfs no longer
> > recognises it, as it already deleted it before the crash.
> 
> I think it's not what you thought, but btrfs device scan is not properly
> triggered.

Quite possible - I based my statement that it is no longer recognized
based on the fact that a) blkid also didn't recognize a filesystem on
the removed device anymore and b) btrfs found the other two remaining
devices, so if btrfs scan is not properly triggered, then this is a
serious issue in current GNU/Linux distributions (I use debian buster on
that server).

I assume that the device is not recognised as btrfs by blkid anymore
because the signature had been wiped by btrfs dev del, based on previous
experience, but I of course can't exactly know it's not, say, a hardware
error that wiped that disk, although I would find that hard to believe :)

> Would you please give some more dmesg? As each scanned btrfs device will
> show up in dmesg.

Here should be all btrfs-related messages for this (from grep -i btrfs):

 [   10.288533] BTRFS: device label ROOT devid 1 transid 2106939 /dev/mapper/vg_doom-root
 [   10.314498] BTRFS info (device dm-0): disk space caching is enabled
 [   10.316488] BTRFS info (device dm-0): has skinny extents
 [   10.900930] BTRFS info (device dm-0): enabling ssd optimizations
 [   10.902741] BTRFS info (device dm-0): disk space caching is enabled
 [   11.524129] BTRFS info (device dm-0): device fsid bb3185c8-19f0-4018-b06f-38678c06c7c2 devid 1 moved old:/dev/mapper/vg_doom-root new:/dev/dm-0
 [   11.528554] BTRFS info (device dm-0): device fsid bb3185c8-19f0-4018-b06f-38678c06c7c2 devid 1 moved old:/dev/dm-0 new:/dev/mapper/vg_doom-root
 [   42.273530] BTRFS: device label LOCALVOL3 devid 1 transid 1240483 /dev/dm-28
 [   42.312354] BTRFS info (device dm-28): enabling auto defrag
 [   42.314152] BTRFS info (device dm-28): force zstd compression, level 12
 [   42.315938] BTRFS info (device dm-28): using free space tree
 [   42.317696] BTRFS info (device dm-28): has skinny extents
 [   49.115007] BTRFS: device label LOCALVOL5 devid 1 transid 146201 /dev/dm-29
 [   49.138816] BTRFS info (device dm-29): using free space tree
 [   49.140590] BTRFS info (device dm-29): has skinny extents
 [  102.348872] BTRFS info (device dm-29): checking UUID tree
 [  102.393185] BTRFS: device label COLD1 devid 5 transid 1876906 /dev/dm-30
 [  109.626550] BTRFS: device label COLD1 devid 4 transid 1876907 /dev/dm-32
 [  109.654401] BTRFS: device label COLD1 devid 3 transid 1876907 /dev/dm-31
 [  109.656171] BTRFS info (device dm-32): use zstd compression, level 12
 [  109.657924] BTRFS info (device dm-32): using free space tree
 [  109.660917] BTRFS info (device dm-32): has skinny extents
 [  109.662687] BTRFS error (device dm-32): devid 1 uuid f5c3dc63-1fac-45b3-b9ba-ed1ec5f92403 is missing
 [  109.664832] BTRFS error (device dm-32): failed to read chunk tree: -2
 [  109.742501] BTRFS error (device dm-32): open_ctree failed

At this point, /dev/mapper/xmnt-cold11 (dm-32),
/dev/mapper/xmnt-oldcold12 (dm-31) and /dev/mapper/xmnt-cold14 (dm-30)
were the remaining disks in the filesystem, while xmnt-cold13 was the
device I had formerly removed (which doesn't show up).

(There are two btrfs filesystems with the COLD1 label in this machine at
the moment, as I was migrating the fs, but the above COLD1 messages should
all relate to the same fs).

"blkid -o value -s TYPE /dev/mapper/xmnt-cold13" didn't give any output
(the mounting script checks for that and pauses to make provisioning
of new disks easier), while normally it would give "btrfs" on volume
members. This, I think, would be normal behaviour for devices that have
been removed from a btrfs.

BTW, the four devices in question are all dmcrypt-on-lvm and are single
devices in a hardware raid controller (a perc h740).

> > Probably nbot related, but maybe worth mentioning: I found that system
> > crashes (resets, not power failures) cause btrfs to not mount the first
> > time a mount is attempted, but it always succeeds the second time, e.g.:
> > 
> >    # mount /device /mnt
> >    ... no errors or warnings in kernel log, except:
> >    BTRFS error (device dm-34): open_ctree failed
> >    # mount /device /mnt
> >    magically succeeds
> 
> Yep, this makes it sound more like a scan related bug.

BTW, this (second issue) also happens with filesystems that are not
multi-device. Not sure if that menas that btrfs scan would be involved, as
I would assume the only device btrfs would need in such cases is the one
given to mount, but maybe that also needs a working btrfs scan?

Thanks for your working on btrfs btw. :)

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
