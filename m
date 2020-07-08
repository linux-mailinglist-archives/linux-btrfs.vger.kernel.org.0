Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3446A217F40
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 07:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGHFtI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 8 Jul 2020 01:49:08 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48706 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGHFtH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 01:49:07 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E3381750216; Wed,  8 Jul 2020 01:49:05 -0400 (EDT)
Date:   Wed, 8 Jul 2020 01:49:05 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200708054905.GA8346@hungrycats.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
 <20200708041041.GN1552@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200708041041.GN1552@merlins.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 09:10:41PM -0700, Marc MERLIN wrote:
> > branded versions of these drives.  They are unusable with write cache
> > enabled.  1 in 10 unclean shutdowns lead to filesystem corruption on
> > btrfs; on ext4, git and postgresql database corruption.  After disabling
> > write cache, I've used them for years with no problems.
>  
> Gotcha, I'm very glad you were able to figure that out. As you said, I
> can disable the write cache.
> It's a bit sad however that ext4 would have given me something I could
> have recovered, while with btrfs, it's so much harder to recover if
> you're not a btrfs FS datastructure expert.

ext2 is pretty much indestructible if you ignore data integrity.
If you want to destroy ext2 metadata, you have to overwrite it one bit
at a time.  The few cases where damage is not proportional to write
size (indirect block lists, directories) are limited to single inodes.
Every metadata item appears in exactly one location that can be computed,
no searching required.  Recovering from arbitrarily awful firmware is
one of the few things ext2 is really good at.

ext4 is significantly more fragile than ext2 if you use the newer features
like extent and flex_bg, which make the metadata mobile like btrfs.
These can prevent e2fsck from being able to recover a large filesystem.

I switched to btrfs back in 2014 after losing a couple of big ext4
filesystems on arrays of WD Greens, _then_ discovered the problem was
the disk firmware not the filesystem.

> > There are some other questionable things in your setup:  you have a
> > mdadm-raid5 with no journal device, so if PPL is also not enabled,
> 
> Sorry, PPL?

Partial Parity Log.  It can be enabled by mdadm --grow.  It's a mdadm
consistency policy, like the journal, but uses reserved metadata space
instead of a separate device.

> > and you are running btrfs on top, then this filesystem is vulnerable
> > to instant destruction by mdadm-raid5 write hole after a disk fails.
> 
> wait, if a disk fails, at worst I have a stripe that's half written and
> hopefully btrfs fails, goes read only and the transaction does not go
> through, so nothing happens except loss of the last written data?

If the array is degraded, and stripe is partially updated, then there is
a crash or power failure, parity will be out of sync with data blocks
in the stripe, so the missing disk's data cannot be generated from parity.

Both old and new data can be damaged by raid5 write hole.  The data
that is damaged is the block on the missing disk that must be computed
using the contents of all other disks.  The damage affects old and new
data the stripe with equal probability, as the data and parity blocks
rotate from one stripe to the next.  Damaged data in an uncommitted tree
(new data) will be ignored if the transaction is not completed, as no
reference to the root of the uncommitted tree will exist after a crash.
Damaged data in a committed tree (old data) is already committed, and if
it's metadata the damage will also break the filesystem.  In other words,
only old data can be damaged by the write hole, because any new damaged
data will be filtered out by the transaction mechanism.

If you have dup metadata in the btrfs then maybe you can recover from
the mirror copy in another stripe.  Hopefully that's not damaged too,
but since both mirrors are updated at roughly the same time on the same
disks, damage to both copies is quite likely.

mdadm PPL or the journal device finishes partial stripe updates after
a crash or power failure, and avoids this failure mode.

> I don't have an external journal because this is an external disk array
> I can move between machines. Would you suggest I do something else?

Enable PPL on mdadm, or use btrfs raid5 data + raid1 metadata (it's
barely usable and some stuff doesn't work properly, but it can run
a backup server, replace a failed disk, and usually self-repair disk
corruption too).

> > (*) their product description text says "other companies", but maybe
> > White Label is just a part of WD, hiding their shame as they dispose of
> > unsalable inventory in an unsuspecting market.  Don't know, don't care
> > enough to find out.
> 
> :)
> 
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/  
> 
