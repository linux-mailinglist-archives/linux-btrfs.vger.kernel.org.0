Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350FC2952FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 21:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504809AbgJUTcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 15:32:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35548 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504781AbgJUTcs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 15:32:48 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BCC32867A1C; Wed, 21 Oct 2020 15:32:46 -0400 (EDT)
Date:   Wed, 21 Oct 2020 15:32:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201021193246.GE21815@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 06:19:02PM +0000, Hendrik Friedel wrote:
> Hello Zygo,
> 
> thanks for your reply.
> 
> > Were there any other symptoms?  IO errors?  Inaccessible files?  Filesystem
> > remounted read-only?
> > 
> No, not at all.
> 
> 
> > 
> > >  I cured that by unmounting and
> > >    mount -t btrfs -o nospace_cache,clear_cache /dev/sda1 /mnt/test
> > 
> > That command normally won't cure a parent transid verify failure if it
> > has been persisted on disk.  The only command that can fix ptvf is 'btrfs
> > check --repair --init-extent-tree', i.e. a full rebuild of btrfs metadata.
> 
> Hm, it would be good to document that somewhere.
> I found
> https://askubuntu.com/questions/157917/how-do-i-recover-a-btrfs-partition-that-will-not-mount
> (there I found that recommendation)
> https://stackoverflow.com/questions/46472439/fix-btrfs-btrfs-parent-transid-verify-failed-on/46472522#46472522
> Here the selected answer says:
> 
> "Surfing the web I found a lot of answers recommending to clear btrfs'
> internal log by using btrfs-zero-log. I thought btrfsck could help but
> eventually I discovered the official recommendation which is to first just
> start a btrfs scrub before taking other actions!"

To be clear, scrub is the first thing to try, it will try to walk all
the trees on the filesystem and read all the blocks.

'--init-extent-tree' is the very last resort, after "copy all data
to another filesystem" and before "give up, mkfs and start over."
--init-extent-tree either works perfectly, or damages the filesystem
beyond all possible recovery (and can silently corrupt data in either
case).  There's a non-zero chance of the second thing, so you don't want
to do --init-extent-tree unless you're ready to mkfs and start over when
it fails.

zero-log is useful for correcting log tree replay errors (and nothing
else).  It deletes the last 30 seconds of fsync() data updates.
zero-log clears the log tree, but the log tree is only for data updates
via fsync(), it is not used for metadata and will have no effect on
parent transid verification failures.

> > >  After that, I was able to run that dduper command without a failure.
> > >  But some days later, the same command resulted in:
> > >    parent transid verify failed on 16465691033600 wanted 352083 found 352085
> > > 
> > >  again.
> > > 
> > >  A scrub showed no error
> > >   btrfs scrub status /dev/sda1
> > >  scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> > >          scrub started at Mon Oct 19 21:07:13 2020 and finished after
> > >  15:11:10
> > >          total bytes scrubbed: 6.56TiB with 0 errors
> > 
> > Scrub iterates over all metadata pages and should hit ptvf if it's
> > on disk.
> 
> But apparently it did not?!

...which indicates the problem is probably in memory, not on disk.

> > >  Filesystem info:
> > >   btrfs fi show /dev/sda1
> > >  Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> > >          Total devices 2 FS bytes used 6.56TiB
> > >          devid    1 size 7.28TiB used 6.75TiB path /dev/sda1
> > >          devid    2 size 7.28TiB used 6.75TiB path /dev/sdj1
> > 
> > If you have raid1 metadata (see 'btrfs fi usage') then it's possible
> 
>  btrfs fi usage /srv/dev-disk-by-label-DataPool1
> Overall:
>     Device size:                  14.55TiB
>     Device allocated:             13.51TiB
>     Device unallocated:            1.04TiB
>     Device missing:                  0.00B
>     Used:                         13.12TiB
>     Free (estimated):            731.48GiB      (min: 731.48GiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,RAID1: Size:6.74TiB, Used:6.55TiB
>    /dev/sda1       6.74TiB
>    /dev/sdj1       6.74TiB
> 
> Metadata,RAID1: Size:15.00GiB, Used:9.91GiB
>    /dev/sda1      15.00GiB
>    /dev/sdj1      15.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:992.00KiB
>    /dev/sda1      32.00MiB
>    /dev/sdj1      32.00MiB
> 
> Unallocated:
>    /dev/sda1     535.00GiB
>    /dev/sdj1     535.00GiB
> 
> So it looks like it is raid1 metadata

That would mean either that recovery already happened (if the corruption
was on disk and has been removed), or the problem never reached a disk
(if it is only in memory).

> > only one of your disks is silently dropping writes.  In that case
> > btrfs will recover from ptvf by replacing the missing block from the
> > other drive.  But there are no scrub errors or kernel messages related
> > to this, so there aren't any symptoms of that happening, so it seems
> > these ptvf are not coming from the disk.
> And can this be confirmed somehow? Would be good to replace that disk
> then...

These normally appear in 'btrfs dev stats', although there are various
coverage gaps with raid5/6 and (until recently) compressed data blocks.

'btrfs scrub status -d' will give a per-drive error breakdown.

> > >  The system has a USV. Consequently, it should not experience any power
> > >  interruptions during writes.
> > > 
> > >  I did not find any indications of it in /var/log/*
> > >  (grep  -i btrfs /var/log/* | grep -v snapper |grep sda)
> > > 
> > >  What could be the reason for this re-appearing issue?
> > 
> > What kernel are you running?
> 5.6.12 since May 11th. Before that, (since Jan 5th) I ran 5.4.8.

5.4.8 could corrupt the filesystem, but not in a recoverable way.
So that's probably not the cause here.

5.6.12 should have all the relevant tree mod log fixes, but might be
missing some other UAF fixes from 5.7 (there were almost 20 of these
fixes in 2019 and 2020, it's not always possible to pin them all down
to a specific behavior).

I haven't seen spurious ptvf errors on my test machines since the 5.4.30s,
but 5.4 has a lot of fixes that between-LTS kernels like 5.6 do not
always get.

> >  Until early 2020 there was a UAF bug in tree
> > mod log code that could occasionally spit out harmless ptvf messages and
> > a few other verification messages like "bad tree block start" because
> > it was essentially verifying garbage from kernel RAM.
> Of course I did use older kernels in the past. But as I understand this bug,
> it would only give spurious error messages but not have caused any errors on
> the disk that would be now hit?

Correct, the spurious failure occurs only in memory (that's why it's
spurious--the data on disk is correct).

> Regards,
> Hendrik
> 
> 
