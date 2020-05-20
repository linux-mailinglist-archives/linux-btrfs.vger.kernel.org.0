Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D81DA73B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgETBdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 21:33:03 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47580 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 21:33:03 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 093D36CFDD2; Tue, 19 May 2020 21:32:55 -0400 (EDT)
Date:   Tue, 19 May 2020 21:32:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Justin Engwer <justin@mautobu.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: I think he's dead, Jim
Message-ID: <20200520013255.GD10769@hungrycats.org>
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 01:51:03PM -0700, Justin Engwer wrote:
> Hi,
> 
> I'm hoping to get some (or all) data back from what I can only assume
> is the dreaded write hole. I did a fairly lengthy post on reddit that

Write hole is a popular scapegoat; however, write hole is far down the
list of the most common ways that a btrfs dies.  The top 6 are:

1.  Firmware bugs (specifically, write ordering failure in lower storage
layers).  If you have a drive with bad firmware, turn off write caching
(or, if you don't have a test rig to verify firmware behavior, just turn
off write caching for all drives).  Also please post your drive models and
firmware revisions so we can correlate them with other failure reports.

2.  btrfs kernel bugs.  See list below.

3.  Other (non-btrfs) kernel bugs.  In theory any UAF bug can kill
a btrfs.  In 5.2 btrfs added run-time checks for this, and will force
the filesystem read-only instead of writing obviously broken metadata
to disk.

4.  Non-disk hardware failure (bad RAM, power supply, cables, SATA
bridge, etc).  These can be hard to diagnose.  Sometimes the only way to
know for sure is to swap the hardware one piece at a time to a different
machine and test to see if the failure happens again.

5.  Isolation failure, e.g. one of your drives shorts out its motor as
it fails, and causes other drives sharing the same power supply rail to
fail at the same time.  Or two drives share a SATA bridge chip and the
bridge chip fails, causing an unrecoverable multi-device failure in btrfs.

6.  raid5/6 write hole, if somehow your filesystem survives the above.

A quick map of btrfs raid5/6 kernel bugs:

	2.6 to 3.4:  don't use btrfs on these kernels

	3.5 to 3.8:  don't use raid5 or raid6 because it doesn't exist

	3.9 to 3.18:  don't use raid5 or raid6 because parity repair
	code not present

	3.19 to 4.4:  don't use raid5 or raid6 because space_cache=v2
	does not exist yet and parity repair code badly broken

	4.5 to 4.15:  don't use raid5 or raid6 because parity repair
	code badly broken

	4.16 to 5.0:  use raid5 data + raid1 metadata.  Use only
	with space_cache=v2.  Don't use raid6 because raid1c3 does not
	exist yet.

	5.1:  don't use btrfs on this kernel because of metadata
	corruption bugs

	5.2 to 5.3:  don't use btrfs on these kernels because of metadata
	corruption bugs partially contained by runtime corrupt metadata
	checking

	5.4:  use raid5 data + raid1 metadata.	Use only with
	space_cache=v2.  Don't use raid6 because raid1c3 does not
	exist yet.  Don't use kernels 5.4.0 to 5.4.13 with btrfs
	because they still have the metadata corruption bug.

	5.5 to 5.7:  use raid5 data + raid1 metadata, or raid6 data
	+ raid1c3 metadata.  Use only with space_cache=v2.

On current kernels there are still some leftover issues:

	- btrfs sometimes corrupts parity if there is corrupted data
	already present on one of the disks while a write is performed
	to other data blocks in the same raid stripe.  Note that if a
	disk goes offline temporarily for any reason, any writes that
	it missed will appear to be corrupted data on the disk when it
	returns to the array, so the impact of this bug can be surprising.

	- there is some risk of data loss due to write hole, which has an
	effect very similar to the above btrfs bug; however, the btrfs
	bug can only occur when all disks are online, and the write hole
	bug can only occur when some disks are offline.

	- scrub can detect parity corruption but cannot map the corrupted
	block to the correct drive in some cases, so the error statistics
	can be wildly inaccurate when there is data corruption on the
	disks (i.e. error counts will be distributed randomly across
	all disks).  This cannot be fixed with the current on-disk format.

Never use raid5 or raid6 for metadata because the write hole and parity
corruption bugs still present in current kernels will race to see which
gets to destroy the filesystem first.

Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
space_cache=v1 puts some metadata (free space cache) in data block
groups, so it violates the "never use raid5 or raid6 for metadata" rule.
space_cache=v2 eliminates this problem by storing the free space tree
in metadata block groups.

> you can find here:
> https://old.reddit.com/r/btrfs/comments/glbde0/btrfs_died_last_night_pulling_out_hair_all_day/
> 
> TLDR; BTRFS keeps dropping to RO. System sometimes completely locks up
> and needs to be hard powered off because of read activity on BTRFS.
> See reddit link for actual errors.

You were lucky to have a filesystem with raid6 metadata and presumably
space_cache=v1 survive this long.

It looks like you were in the middle of trying to delete something, i.e.
a snapshot or file was deleted before the last crash.  The metadata
is corrupted, so the next time you mount, it detects the corruption
and aborts.  This repeats on the next mount because btrfs can't modify
anything.

My guess is you hit a firmware bug first, and then the other errors
followed, but at this point it's hard to tell which came first.  It looks
like this wasn't detected until much later, and recovery gets harder
the longer the initial error is uncorrected.

> I'm really not super familiar, or at all familiar, with BTRFS or the
> recovery of it.
> -- 
> 
> Justin Engwer
