Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32D51C2448
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEBJJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 2 May 2020 05:09:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34768 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgEBJJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 May 2020 05:09:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B67CB69FF60; Sat,  2 May 2020 05:09:46 -0400 (EDT)
Date:   Sat, 2 May 2020 05:09:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Extremely slow device removals
Message-ID: <20200502090946.GO10769@hungrycats.org>
References: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org>
 <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org>
 <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 02, 2020 at 01:22:25AM -0700, Phil Karn wrote:
> On Sat, May 2, 2020 at 12:42 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> 
> > If you use btrfs replace to move data between drives then you get all
> > the advantages you describe.  Don't do 'device remove' if you can possibly
> > avoid it.
> 
> But I had to use replace to do what I originally wanted to do: replace
> four 6TB drives with two 16TB drives.  I could replace two but I'd
> still have to remove two more. I may give up on that latter part for
> now, but my original hope was to move everything to a smaller and
> especially quieter box than the 10-year-old 4U server I have now
> that's banished to the garage because of the noise. (Working on its
> console in single-user is much less pleasant than retiring to the
> house and using my laptop.) I also wanted to retire all four 6 TB
> drives because they have over 35K hours (four years) of continuous run
> time. They keep passing their SMART checks but I didn't want to keep
> pushing my luck.

I replace drives in arrays one at a time, equally spaced over their
warranty period.  The replacements are larger, and that requires 3-6-month
long balances.  I guess the balance time is going to double every 18
months, which means there will come a point where balance takes longer
than simply waiting for the next replacement drive to make a pair of
disks with unallocated space.  I don't want to change the schedule to
replace 2 drives at a time as that increases the probability of correlated
2-disk failure.

> > If there's data corruption on one disk, btrfs can detect it and replace
> > the lost data from the good copy.
> 
> That's a very good point I should have remembered. FS-agnostic RAID
> depends on drive-level error detection, and being an early TCP/IP guy
> I have always been a fan of end-to-end checks. That said, I can't
> remember EVER having one of my drives silently corrupt data. 

Out of ~120 drive models I've tested, I've only seen 5 spinning drives
that silently corrupt data.  One disk got hot enough to emit blue smoke,
another didn't have the smoky drama but did have obvious bit errors in
its DRAM cache.  The rest were drives with firmware bugs, so all the
instances of specific models had identical issues.

On SD/MMC and below-$50 SSDs, silent data corruption is the most common
failure mode.  I don't think these disks are capable of detecting or
reporting individual sector errors.  I've never seen it happen.  They
either fall off the bus or they have a catastrophic failure and give
an error on every single access.

Some drive-level error events leave scars that look like data corruption
to btrfs, e.g.  if the firmware crashes before it can empty its write
cache, or if the Linux timeout is set too low and the kernel resets the
drive before it completes a write.  That's so common on low-end desktop
drives that I stopped buying them (at least the cheap SSDs weren't slow).

> When one
> failed, I knew it. (Boy, did I know it.)  I can detect silent
> corruption even in my ext4 or xfs file systems because I've been
> experimenting for years with stashing SHA file hashes in an extended
> attribute and periodically verifying them. This originated as a simple
> deduplication tool with the attributes used only as a cache. But I
> became intrigued by other uses for file-level hashes, like looking for
> a file on a heterogeneous collection of machines by multicasting its
> hash, and the aforementioned check for silent corruption. (Yes, I know
> btrfs checks automatically, but I won't represent what I'm doing as
> anything but purely experimental.)

Experiment away!  The more redundant hashes, the better.  I found two
btrfs data corruption bugs that way, and the same data makes me confident
that there aren't any more (at least with my current application workload).

> I've never seen a btrfs scrub produce errors either except very
> quickly on one system with faulty RAM, so I was never going to trust
> it with real data anyway. (BTW, I believe strongly in ECC RAM. I can't
> understand why it isn't universal given that it costs little more.)

I've seen one scrub error in a month of testing with a machine that had
known bad RAM.  btrfs had unrecoverable corruption 3 times in the same
interval.

> I'm beginning to think I should look at some of the less tightly
> coupled ways to provide redundant storage, such as gluster.
