Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B67A46B3C3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 08:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhLGHY7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 7 Dec 2021 02:24:59 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:34692 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhLGHY6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 02:24:58 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7A87EB6FF4; Tue,  7 Dec 2021 02:21:28 -0500 (EST)
Date:   Tue, 7 Dec 2021 02:21:28 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: ENOSPC while df shows 826.93GiB free
Message-ID: <20211207072128.GL17148@hungrycats.org>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
 <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 04:44:13AM +0100, Christoph Anton Mitterer wrote:
> On Tue, 2021-12-07 at 11:29 +0800, Qu Wenruo wrote:
> > For other regular operations, you either got ENOSPC just like all
> > other
> > fses which runs out of space, or do it without problem.
> > 
> > Furthermore, balance in this case is not really the preferred way to
> > free up space, really freeing up data is the correct way to go.
> 
> Well but to be honest... that makes btrfs kinda broke for that
> particular purpose.
> 
> 
> The software which runs on the storage and provides the data to the
> experiments does in fact make sure that the space isn't fully used (per
> default, it leave a gap of 4GB).
> 
> While this gap is configurable it seems a bit odd if one would have to
> set it to ~1TB per fs... just to make sure that btrfs doesn't run out
> of space for metadata.
> 
> 
> And btrfs *does* show that plenty of space is left (always around 700-
> 800 GB)... so the application thinks it can happily continue to write,
> while in fact it fails (and the cannot even start anymore as it fails
> to create lock files).
> 
> 
> My understanding was the when not using --mixed, btrfs has block groups
> for data and metadata.
> 
> And it seems here that the data block groups have several 100 GB still
> free, while - AFAIU you - the metadata block groups are already full.
> 
> 
> 
> I also wouldn't want to regularly balance (which doesn't really seem to
> help that much so far)... cause it puts quite some IO load on the
> systems.

If you minimally balance data (so that you keep 2GB unallocated at all
times) then it works much better: you can allocate the last metadata
chunk that you need to expand, and it requires only a few minutes of IO
per day.  After a while you don't need to do this any more, as a large
buffer of allocated but unused metadata will form.

If you need a drastic intervention, you can mount with metadata_ratio=1
for a short(!) time to allocate a lot of extra metadata block groups.
Combine with a data block group balance for a few blocks (e.g. -dlimit=9).

You need about (3 + number_of_disks) GB of allocated but unused metadata
block groups to handle the worst case (balance, scrub, and discard all
active at the same time, plus the required free metadata space).  Also
leave room for existing metadata to expand by about 50%, especially if
you have snapshots.

Never balance metadata.  Balancing metadata will erase existing metadata
allocations, leading directly to this situation.

Free space search time goes up as the filesystem fills up.  The last 1%
of the filesystem will fill up significantly slower than the other 99%,
You might need to reserve 3% of the filesystem to keep latencies down
(ironically about the same amount that ext4 reserves).

There are some patches floating around to address these issues.

> So if csum data needs so much space... why can't it simply reserve e.g.
> 60 GB for metadata instead of just 17 GB?

It normally does.  Are you:

	- running metadata balances?  (Stop immediately.)

	- preallocating large files?  Checksums are allocated later, and
	naive usage of prealloc burns metadata space due to fragmentation.

	- modifying snapshots?	Metadata size increases with each
	modified snapshot.

	- replacing large files with a lot of very small ones?	Files
	below 2K are stored in metadata.  max_inline=0 disables this.

> If I really had to reserve ~ 1TB of storage to be unused (per 16TB fs)
> just to get that working... I would need to move stuff back to ext4,
> cause that's such a big loss we couldn't justify to our funding
> agencies.
> 
> 
> And we haven't had that issue with e.g. ext4 ... that seems to reserve
> just enough for meta, so that we could basically fill up the fs close
> to the end.
> 
> 
> 
> Cheers,
> Chris.
