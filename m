Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B450210140
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 03:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgGABGj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 21:06:39 -0400
Received: from mail.nethype.de ([5.9.56.24]:40657 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGABGj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 21:06:39 -0400
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2020 21:06:37 EDT
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqQy4-001RPE-Av
        for linux-btrfs@vger.kernel.org; Wed, 01 Jul 2020 00:51:16 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqQy4-0000IX-73
        for linux-btrfs@vger.kernel.org; Wed, 01 Jul 2020 00:51:16 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jqQy4-0001ud-6h
        for linux-btrfs@vger.kernel.org; Wed, 01 Jul 2020 02:51:16 +0200
Date:   Wed, 1 Jul 2020 02:51:16 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: first mount(s) after unclean shutdown always fail
Message-ID: <20200701005116.GA5478@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I have a server with multiple btrfs filesystems and some moderate-sized
dmcache caches (a few million blocks/100s of GBs).

When the server has an unclean shutdown, dmcache treats all cached blocks
as dirty. This has the effect of extremely slow I/O, as dmcache basically
caches a lot of random I/O, and writing these blocks back to the rotating
disk backing store can take hours. This, I think, is related to the
problem.

When the server is in this condition, then all btrfs filesystems on slow
stores (regardless of whether they use dmcache or not) fail their first
mount attempt(s) like this:

   [  173.243117] BTRFS info (device dm-7): has skinny extents
   [  864.982108] BTRFS error (device dm-7): open_ctree failed

Recent kernels sometimes additionally fail like this (super_total_bytes):

   [  867.721885] BTRFS info (device dm-7): turning on sync discard
   [  867.722341] BTRFS info (device dm-7): disk space caching is enabled
   [  867.722691] BTRFS info (device dm-7): has skinny extents
   [  871.257020] BTRFS error (device dm-7): super_total_bytes 858976681984 mismatch with fs_devices total_rw_bytes 1717953363968
   [  871.257487] BTRFS error (device dm-7): failed to read chunk tree: -22
   [  871.269989] BTRFS error (device dm-7): open_ctree failed

all the filesystems in question are mounted twice during normal boots,
with diferent subvolumes, and systemd parallelises these mounts. This might
play a role in these failures.

Simply trying to mount the filesystems again then (usually) succeeds with
seemingly no issues, so these are spurious mount failures. These repeated
mount attewmpts are also much faster, presumably because a lot of the data
is already in memory.

As far as I am concerned, this is 100% reproducible (i.e. it happens on every
unclean shutdown). It also happens on "old" (4.19 era) filesystems as well as
on filesystems that have never seen anything older than 5.4 kernels.

It does _not_ happen with filesystems on SSDs, regardless of whether they
are mounted multiple times or not. It does happen to all filesystems that
are on rotating disks affected by dm-cache writes, regardless of whether
the filesystem itself uses dmcache or not.

The system in question is currently running 5.6.17, but the same thing
happens with 5.4 and 5.2 kernels, and it might have happened with much
earlier kernels as well, but I didn't have time to report this (as I
secretly hoped newer kernels would fix this, and unclean shutdowns are
rare).

Example btrfs kernel messages for one such unclean boot. This involved
normal boot, followed by unsuccessfull "mount -va" in the emergency shell
(i.e. a second mount fasilure for the same filesystem), followed by a
successfull "mount -va" in the shell.

[  122.856787] BTRFS: device label LOCALVOL devid 1 transid 152865 /dev/mapper/cryptlocalvol scanned by btrfs (727)
[  173.242545] BTRFS info (device dm-7): disk space caching is enabled
[  173.243117] BTRFS info (device dm-7): has skinny extents
[  363.573875] INFO: task mount:1103 blocked for more than 120 seconds.
the above message repeats multiple times, backtrace &c has been removed for clarity
[  484.405875] INFO: task mount:1103 blocked for more than 241 seconds.
[  605.237859] INFO: task mount:1103 blocked for more than 362 seconds.
[  605.252478] INFO: task mount:1211 blocked for more than 120 seconds.
[  726.069900] INFO: task mount:1103 blocked for more than 483 seconds.
[  726.084415] INFO: task mount:1211 blocked for more than 241 seconds.
[  846.901874] INFO: task mount:1103 blocked for more than 604 seconds.
[  846.916431] INFO: task mount:1211 blocked for more than 362 seconds.
[  864.982108] BTRFS error (device dm-7): open_ctree failed
[  867.551400] BTRFS info (device dm-7): turning on sync discard
[  867.551875] BTRFS info (device dm-7): disk space caching is enabled
[  867.552242] BTRFS info (device dm-7): has skinny extents
[  867.565896] BTRFS error (device dm-7): open_ctree failed
[  867.721885] BTRFS info (device dm-7): turning on sync discard
[  867.722341] BTRFS info (device dm-7): disk space caching is enabled
[  867.722691] BTRFS info (device dm-7): has skinny extents
[  871.257020] BTRFS error (device dm-7): super_total_bytes 858976681984 mismatch with fs_devices total_rw_bytes 1717953363968
[  871.257487] BTRFS error (device dm-7): failed to read chunk tree: -22
[  871.269989] BTRFS error (device dm-7): open_ctree failed
[  872.535935] BTRFS info (device dm-7): disk space caching is enabled
[  872.536438] BTRFS info (device dm-7): has skinny extents

Example fstab entries for the mounts above:

/dev/mapper/cryptlocalvol       /localvol       btrfs           defaults,nossd,discard                  0       0
/dev/mapper/cryptlocalvol       /cryptlocalvol  btrfs           defaults,nossd,subvol=/                 0       0

I don't need assistance, I merely write this in the hope of btrfs being
improved by this information.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
