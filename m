Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A352193C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 00:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGHWrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 18:47:33 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37644 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHWr3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 18:47:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 618AF752150; Wed,  8 Jul 2020 18:47:19 -0400 (EDT)
Date:   Wed, 8 Jul 2020 18:47:19 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200708224719.GF10769@hungrycats.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200708041041.GN1552@merlins.org>
 <20200708054905.GA8346@hungrycats.org>
 <20200708174110.GU30660@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708174110.GU30660@merlins.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 08, 2020 at 10:41:10AM -0700, Marc MERLIN wrote:
> On Wed, Jul 08, 2020 at 01:49:05AM -0400, Zygo Blaxell wrote:
> > > Sorry, PPL?
> > 
> > Partial Parity Log.  It can be enabled by mdadm --grow.  It's a mdadm
> > consistency policy, like the journal, but uses reserved metadata space
> > instead of a separate device.
>  
> looks like it's incompatible with --bitmap which I was already using.
> I'm not sure if --grow was possible to convert from one to another, so I
> made a new one, and now I have a 4 day wait for the initial scan
> (external array with Sata PMP, those are slow unfortunately)
> 
> md6 : active raid5 sdx1[5] sdw1[3] sdv1[2] sdu1[1] sdq1[0]
>       23441547264 blocks super 1.2 level 5, 512k chunk, algorithm 2 [5/4] [UUUU_]
>       [>....................]  recovery =  0.0% (2920544/5860386816) finish=4835.4min speed=20189K/sec
> 
> Could you confirm that what I did here is ok?
> 
> gargamel:~# mdadm --create --verbose /dev/md6 --level=5 --consistency-policy=ppl --raid-devices=5 /dev/sd[quvwx]1
> mdadm: layout defaults to left-symmetric
> mdadm: layout defaults to left-symmetric
> mdadm: chunk size defaults to 512K
> mdadm: /dev/sdq1 appears to be part of a raid array:
>        level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
> mdadm: /dev/sdu1 appears to be part of a raid array:
>        level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
> mdadm: /dev/sdv1 appears to be part of a raid array:
>        level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
> mdadm: /dev/sdw1 appears to be part of a raid array:
>        level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
> mdadm: /dev/sdx1 appears to be part of a raid array:
>        level=raid5 devices=5 ctime=Thu Jan 28 14:38:40 2016
> mdadm: size set to 5860386816K
> Continue creating array? y
> mdadm: Defaulting to version 1.2 metadata
> mdadm: array /dev/md6 started.
> 
> gargamel:~# make-bcache -B /dev/md6
> UUID:                   eb898c09-debd-4e86-972f-aecdb59670e2
> Set UUID:               e14408a3-8e25-414d-ba4a-a8a7a0d7bdc9
> version:                1
> block_size:             1
> data_offset:            16
> 
> gargamel:~# cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64 /dev/bcache4
> 
> gargamel:~# cryptsetup luksOpen /dev/bcache4 dshelf6
> Enter passphrase for /dev/bcache4:
> 
> gargamel:~# /sbin/mkfs.btrfs -L DS6 -O extref -m dup /dev/mapper/dshelf6 

Looks OK.

> > > wait, if a disk fails, at worst I have a stripe that's half written and
> > > hopefully btrfs fails, goes read only and the transaction does not go
> > > through, so nothing happens except loss of the last written data?
> > 
> > If the array is degraded, and stripe is partially updated, then there is
> > a crash or power failure, parity will be out of sync with data blocks
> > in the stripe, so the missing disk's data cannot be generated from parity.
>  
> I thought --bitmap would know this and know to discard the last blocks
> partiailly written. I guess not?
> 
> Either way, it seems that losing just a few blocks in the "wrong" place
> is enough to lose most of a btrfs FS. That's disappointing, I thought it
> was a bit more fault proof than that.

During a write to a stripe, there's a short window of time when data
and parity blocks are out of sync (each disk completes writes at its
own speed).  If the system is interrupted during this time (crash or
power failure), the stripe on disk has data blocks that don't match
the parity block.

Suppose we have 5 disks.  There is always a 1:1 mapping of disks to blocks
in every RAID5 stripe, so let's call the data blocks on each disk A, B,
C, D, and the parity block P, and ignore the other details.

When all the disks are online, before we do a write to D, we have:

	A ^ B ^ C ^ Dold = Pold          (1)

After the first write, we have this on disk:

	A, B, C, Dnew, Pold

After the second write, we have this on disk:

	A, B, C, Dnew, Pnew

	A ^ B ^ C ^ Dnew = Pnew          (2)

If we lose drive C, we can get it back from either the first or last
state:

	A ^ B ^ Cmissing ^ Dold = Pold

so

	Cmissing = Pold ^ A ^ B ^ Dold (3)

Sub (1) into (3):

	Cmissing = (A ^ B ^ C ^ Dold) ^ A ^ B ^ Dold

Sub A ^ A = 0, B ^ B = 0, Dold ^ Dold = 0:

	Cmissing = C

So we recover C correctly.  The same can be done with Pnew and Dnew.

If there is a power failure or crash and the second write doesn't
happen, then we get:

	Cgarbage = Pold ^ A ^ B ^ Dnew    (4)

Sub (1) into (4):

	Cgarbage = (A ^ B ^ C ^ Dold) ^ A ^ B ^ Dnew

Cancel A ^ A = 0, B ^ B = 0:

	Cgarbage = C ^ Dold ^ Dnew

We didn't get C back, we got C xored with some other stuff.

If the writes happen in the other order, we get:

	Cgarbage2 = Pnew ^ A ^ B ^ Dold    (5)

Sub (2) into (5):

	Cgarbage2 = (A ^ B ^ C ^ Dnew) ^ A ^ B ^ Dold

Cancel A ^ A = 0, B ^ B = 0:

	Cgarbage2 = C ^ Dnew ^ Dold

We didn't get C back here either.  With only 2 disks written, we get the
same garbage in both cases.  If there are more than 2 disks written then
we get multiple possible combinations of writes xored together.

If the array is not degraded, then after the crash, mdadm assumes
the data blocks are correct, and recomputes the parity block from the
data blocks during resync (i.e. it updates Pold to Pnew using Dnew).
The filesystem looks only at the data blocks, and all the data blocks
are present, so this works.

The mdadm bitmaps speed this up by indicating which areas of the disk
contain dirty stripes that may require parity recomputation.  Areas that
have not been written don't need to be resynced.

If the array is degraded, some of the data blocks are missing, so we
can't recompute Pnew from whichever of A, B, C, and D blocks are present.
If we have Pold and Dold it's OK, we can correctly compute A, B, or C if
one is missing.  If we have Pnew and Dnew it's OK.  If P is on the missing
disk it's OK, because we have all the data blocks in the stripe intact
so we don't need P.  If D is missing, we will recompute either Dnew or
Dold depending on whether the P block contains Pnew or Pold, but btrfs
transactions can handle both results so it's OK no matter what D contains.
So far so good, all these cases are OK.  PPL ensures we only have these
cases.

If we have Pold and Dnew or Pnew and Dold, then the computed contents
of A, B, and C will be broken when any of those drives are missing.
Since we weren't writing to blocks A, B, or C in this transaction, but
those are the blocks that are corrupted, we may have broken something
btrfs already committed.  btrfs will see broken csums and reject the data.
If A, B, or C are btrfs metadata blocks, the filesystem is damaged.
Either a mirror copy of metadata or a practical fsck is required to repair.

btrfs transactions cover only the specific blocks that were written.
They don't handle cases where a write to block D corrupts data in other
blocks like A, B, or C.  raid5 in degraded mode has cases like that,
so it doesn't work with btrfs.

> > > I don't have an external journal because this is an external disk array
> > > I can move between machines. Would you suggest I do something else?
> > 
> > Enable PPL on mdadm, or use btrfs raid5 data + raid1 metadata (it's
> > barely usable and some stuff doesn't work properly, but it can run
> > a backup server, replace a failed disk, and usually self-repair disk
> > corruption too).
>  
> it's been a while since I've used btrfs raid5, it must have improved
> since I last did, but I haven't read that it's become production quality
> yet :)

Well, don't try to run a live customer orders database on btrfs raid5.
That won't end well.  It can hold a backup copy of the customer orders
database though, provided you follow the restrictions in

	https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/

and avoid (or work around) drives with write-caching bugs.

> Thanks again for your very helpful answers.
> 
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
