Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D82135B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGCIEm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 04:04:42 -0400
Received: from mail.nethype.de ([5.9.56.24]:46179 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCIEl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 04:04:41 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jrGgX-003B6I-8c; Fri, 03 Jul 2020 08:04:37 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jrGgX-0004ZL-4K; Fri, 03 Jul 2020 08:04:37 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jrGgX-00010X-3z; Fri, 03 Jul 2020 10:04:37 +0200
Date:   Fri, 3 Jul 2020 10:04:37 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail
Message-ID: <20200703080437.GB2138@schmorp.de>
References: <20200701005116.GA5478@schmorp.de>
 <20200702183134.GB10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702183134.GB10769@hungrycats.org>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 02:31:34PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> When LVM is manipulating the device-mapper table it can sometimes trigger
> udev events and run btrfs dev scan, which temporarily points btrfs to
> the wrong device.  
> 
> It's possible that the backing device for lvmcache is visible temporarily
> during startup (userspace cache_check has to be able to access the cache

Ah, that is very interesting, but doesn't apply to this report, as dmcache
is not involved other than in slowing down the system (it is true that
the mount failures *also* happen on dmcache devices, but the example I
reported is for an uncached lv).

Furthermore, the dmcache'd lvs are all encrypted, either using
luks/cryptsetup or by another means, and this should ensure that there
cannot ever be a confusion, as btrfs can never see the unencrypted
filesystem data on different dm devices, as there either is the dmcrypt
device or none at any one time, and none are managed by automatic systems.

> unflushed writeback updates).  Normally this isn't a problem if you run
> vgchange then btrfs dev scan then mount, but systemd's hyperaggressive
> mount execution and potentially incomplete parallel execution dependency
> model might make it a problem.

In this specific case, the lvs are also activated in the initrd (which
doesn't use systemd), which runs a considerable time before systemd
takes over, due to an interactive password prompt - although it might be
possible that the dirty dmcache might slow the system down enough for it
to matter.  But the extra dmcrypt layer should completely invalidate any
confusion.

> btrfs is not blameless here either.  Once a btrfs has been mounted
> on a set of devices, it should be difficult or impossible for udev
> rules to switch to different devices without umounting, possibly with
> narrow exceptions e.g. for filesystems mounted on removable USB media.
> It certainly shouldn't happen several times each time lvm reloads the
> device-mapper table, as the btrfs signature can appear on a lot of
> different dm-table devices.

I have seen btrfs scan messages switch multiple times between devices
during boot in the past, so maybe I should look out for this more.

However, unfortunately, it seems this cannot be the explanation in this
case.

For this boot, the only other btrfs messages before the problem happened is:

[  122.856787] BTRFS: device label LOCALVOL devid 1 transid 152865 /dev/mapper/cryptlocalvol scanned by btrfs (727)
[  122.857710] BTRFS: device label ROOT devid 1 transid 862260 /dev/mapper/cryptroot scanned by btrfs (727)
[  122.863350] BTRFS: device fsid a01ee881-c53e-4653-ab6a-33973a07c3e4 devid 1 transid 3426 /dev/sdc scanned by btrfs (727)
[  122.886161] BTRFS info (device dm-6): disk space caching is enabled
[  122.886712] BTRFS info (device dm-6): has skinny extents
[  123.015032] BTRFS info (device dm-6): enabling ssd optimizations

The first message refers to the failing fs. The fsid message refers to a fs
that isn't being mounted at all and the rest refer to the root fs, which is
on an SSD, and never caused trouble.

The only common pattern to this problem I see is that it happens when
mounting takes a very long time - it feels as if there is a timeout
somewhere (not necessarily in btrfs), i.e. it doesn't happen to other
filesystems on the same controller, only filesystems that share a disk
with a busy dmcached fs, when mount times are excessive.

> This happens all the time with pvmove and other LVM volume management
> operations, you'll see a handful of btrfs corruption errors scrolling
> by while moving btrfs LVs between disks, sometimes also when creating
> new LVs.

I semi-regularly use pvmove (it's considerably less work then btrfs dev
replace, so tempting for small devices where copying speed is not that
important), and fortunately, this has never happened to me. I would
remember, as BTRFS corruption messages make me squirm considerably.

> Does this mean that you have a rotating disk which contains a dm-cached
> filesystem and a btrfs filesystem that does not use dm-cache, and the
> btrfs filesystem is affected?  That would dismiss my theory above.
> I have no theory to handle that case.

Yes, unfortunately.

In this box, it is now:

(slow rotating raid) -> lvm ->             dmcrypt -> example fs from my report
(slow rotating raid) -> lvm -> lvmcache -> dmcrypt -> another fs

Until recently, I also had a third dmcache'd fs.

The problem did appear for all of them on an unclean shutdown, but most
commonly for the non-dmcache device, likely because it is mounted before the
others, i.e. it is simply the first.

The first filesystem (the one from my example) is mounted via
systemd/fstab, the others use a different mechanism and are mounted later,
and serially.

> > The system in question is currently running 5.6.17, but the same thing
> > happens with 5.4 and 5.2 kernels, and it might have happened with much
> > earlier kernels as well, but I didn't have time to report this (as I
> > secretly hoped newer kernels would fix this, and unclean shutdowns are
> > rare).
> 
> FWIW unclean shutdowns are the only kind of shutdown I do with lvmcache
> and btrfs (intentionally, in order to detect bugs like this), and I
> haven't seen this problem.  I don't run systemd.

I wish I could run without systemd :)

lvmcache is the reason why I didn't report this earlier, though, because
all filesystems once used lvmcache, and I can't distinguish between
dmcache issues (which have eaten my btrfs filesystems multiple times due
to kernel bugs) and btrfs issues.

However, I removed the dmcache on the first filesystem on purpose a few
months ago, to see if it would cause trouble.

I do like to avoid unclean shutdowns, because it means the server is close
to unusable for a rather long time (just booting it can take 15 minutes,
as you can see form the log).

> > [  122.856787] BTRFS: device label LOCALVOL devid 1 transid 152865 /dev/mapper/cryptlocalvol scanned by btrfs (727)
> > [  173.242545] BTRFS info (device dm-7): disk space caching is enabled
> > [  173.243117] BTRFS info (device dm-7): has skinny extents
> > [  363.573875] INFO: task mount:1103 blocked for more than 120 seconds.
> > the above message repeats multiple times, backtrace &c has been removed for clarity
> > [  484.405875] INFO: task mount:1103 blocked for more than 241 seconds.
> > [  605.237859] INFO: task mount:1103 blocked for more than 362 seconds.
> > [  605.252478] INFO: task mount:1211 blocked for more than 120 seconds.
> > [  726.069900] INFO: task mount:1103 blocked for more than 483 seconds.
> > [  726.084415] INFO: task mount:1211 blocked for more than 241 seconds.
> > [  846.901874] INFO: task mount:1103 blocked for more than 604 seconds.
> > [  846.916431] INFO: task mount:1211 blocked for more than 362 seconds.
> > [  864.982108] BTRFS error (device dm-7): open_ctree failed
> > [  867.551400] BTRFS info (device dm-7): turning on sync discard
> > [  867.551875] BTRFS info (device dm-7): disk space caching is enabled
> > [  867.552242] BTRFS info (device dm-7): has skinny extents
> > [  867.565896] BTRFS error (device dm-7): open_ctree failed
> 
> Have you deleted some log messages there?  There's no explanation for
> the first two open_ctree failures.

I only deleted kernel backtraces and register dumps. And yes, the *only*
messages I get when the mount fails are, in most cases:

> > [  173.242545] BTRFS info (device dm-7): disk space caching is enabled
> > [  173.243117] BTRFS info (device dm-7): has skinny extents
> > [  864.982108] BTRFS error (device dm-7): open_ctree failed

I.e. when I run into this problem there are no other messages, other than
mount itself returning an error (when I immediatelly re-run the mount) -
the last message is the "open_ctree failed" message, with no explanation
on what went wrong.

I only started getting the super_total_bytes mismatch messages recently,
after recreating the filesystems from scratch (and restoring from backup)
under 5.4, and they appear maybe in 20% of the cases or so (the machine
doesn't crash/is being reset as often under linux 5.x as it did under
4.19).

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
