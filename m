Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F1217DF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGHEKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 00:10:43 -0400
Received: from magic.merlins.org ([209.81.13.136]:53828 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgGHEKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 00:10:43 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jt1Pt-0000JI-C3 by authid <merlin>; Tue, 07 Jul 2020 21:10:41 -0700
Date:   Tue, 7 Jul 2020 21:10:41 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 5.6 pretty massive unexplained btrfs corruption:  parent transid
 verify failed + open_ctree failed
Message-ID: <20200708041041.GN1552@merlins.org>
References: <20200707035530.GP30660@merlins.org>
 <20200708034407.GE10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708034407.GE10769@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zygo, thanks for the very detailled answer.

A few replies:
> Hopefully your bcache drive is OK, you didn't post any details on that.
> bcache on a drive with buggy firmware write caching fails *spectacularly*.

So, I created this as a bcache backing device so that I can elect to add
a caching device later (which you can't do after the fact otherwise).
There was no caching device here, though.

So before we go on, it seems that my FS is damaged beyond easy repair,
that we know why (drives with broken write caching) and that
unfortunately btrfs gets in states where recovery is hard, at best.
If so, I'll just wipe, apply the fixes you recommended and start over.

On Tue, Jul 07, 2020 at 11:44:07PM -0400, Zygo Blaxell wrote:
> > [ 2575.931343] BTRFS info (device dm-0): has skinny extents
> > [ 2577.286749] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> 
> This line does indicate an older problem with the filesystem.  It doesn't
> tell us whether the corruption happened yesterday or a year ago.
> You will need to look at your older kernel logs for that.
 
Yeah, this could have been long time ago, but remember that I ran a 2
day long btrfs check on it and it came back clean.

> > [ 2882.545242] BTRFS info (device dm-0): the free space cache file (26234763345920) is invalid, skip it
> 
> Use space_cache=v2, especially on a big filesystem because space_cache=v1
> slows down linearly with filesystem size.  There is no need for these
> warnings.  They're probably a symptom rather than cause here.
 
Thanks for that, was not aware of this.

> > Ok, maybe there was an IO failure, although none was shown by the kernel:
> 
> The "IO failure" mentioned here is the earlier parent transid verify
> failure.  When the verification fails, the caller gets -EIO.
 
Got it, so not a de ice IO failure.

> > [ 4058.886212] BTRFS info (device dm-0): bdev /dev/mapper/crypt_bcache0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> > [ 4061.501589] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> > [ 4061.503790] BTRFS error (device dm-0): parent transid verify failed on 7325633544192 wanted 359658 found 359661
> 
> The amount of damage here is small, but it looks like you lost a
> superblock update or two (btrfs expected an old page and found a new one)
> so the root of the filesystem now points at an old tree that has since
> been partially overwritten.
> 
> Any part of the filesystem on the other side of the missing metadata pages
> is no longer accessible without a brute force search of the metadata.
> This might take longer than mkfs+restore with the current btrfs check
> --repair, especially if you have to run chunk-recover as well.
 
unfortunately btrfs check errors early on, so that's not going to work
without manual options which seem not very obvious.

> > myth:/mnt# btrfs-zero-log /dev/mapper/crypt_bcache0
> > WARNING: this utility is deprecated, please use 'btrfs rescue zero-log'
> > parent transid verify failed on 7325633544192 wanted 359658 found 359661
> > parent transid verify failed on 7325633544192 wanted 359658 found 359661
> > parent transid verify failed on 7325633544192 wanted 359658 found 359661
> > parent transid verify failed on 7325633544192 wanted 359658 found 359661
> > Ignoring transid failure
> > leaf parent key incorrect 7325633544192
> > Clearing log on /dev/mapper/crypt_bcache0, previous log_root 0, level 0
> 
> Clearing log tree will have no effect on parent transid verify failure.
> It only helps to work around bugs that occur during log tree replay,
> which happens at a later stage of mounting the filesystem.

Right, I was just a bit desperate and tried it :)

> In a later post in this thread, you posted a log showing your drive model
> numbers and firmware revisions.  White Label repackages drives made
> by other companies(*) under their own part number (singular, they all
> use the same part number), but they leave the firmware revision intact,
> so we can look up the firmware revision and see that you have two
> different WD models in your md6 array from families with known broken
> firmware write caching.
 
Dann, I'm impressed by that analysis, thank you.

> branded versions of these drives.  They are unusable with write cache
> enabled.  1 in 10 unclean shutdowns lead to filesystem corruption on
> btrfs; on ext4, git and postgresql database corruption.  After disabling
> write cache, I've used them for years with no problems.
 
Gotcha, I'm very glad you were able to figure that out. As you said, I
can disable the write cache.
It's a bit sad however that ext4 would have given me something I could
have recovered, while with btrfs, it's so much harder to recover if
you're not a btrfs FS datastructure expert.
 
> There are some other questionable things in your setup:  you have a
> mdadm-raid5 with no journal device, so if PPL is also not enabled,

Sorry, PPL?

> and you are running btrfs on top, then this filesystem is vulnerable
> to instant destruction by mdadm-raid5 write hole after a disk fails.

wait, if a disk fails, at worst I have a stripe that's half written and
hopefully btrfs fails, goes read only and the transaction does not go
through, so nothing happens except loss of the last written data?

I don't have an external journal because this is an external disk array
I can move between machines. Would you suggest I do something else?

> (*) their product description text says "other companies", but maybe
> White Label is just a part of WD, hiding their shame as they dispose of
> unsalable inventory in an unsuspecting market.  Don't know, don't care
> enough to find out.

:)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
