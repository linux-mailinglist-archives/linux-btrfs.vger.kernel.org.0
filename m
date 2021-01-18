Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7252FADB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbhARXUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 18:20:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:58476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbhARXUV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 18:20:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73717AB9F;
        Mon, 18 Jan 2021 23:19:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B7D6DA7CF; Tue, 19 Jan 2021 00:17:45 +0100 (CET)
Date:   Tue, 19 Jan 2021 00:17:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210118231744.GN6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116071533.105780-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 03:15:15PM +0800, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> Currently the branch also contains partial RW data support (still some
> ordered extent and data csum mismatch problems)
> 
> Great thanks to David/Nikolay/Josef for their effort reviewing and
> merging the preparation patches into misc-next.
> 
> === What works ===
> 
> Just from the patchset:
> - Data read
>   Both regular and compressed data, with csum check.
> 
> - Metadata read
> 
> This means, with these patchset, 64K page systems can at least mount
> btrfs with 4K sector size.

I haven't found anything serious, the comments are cosmetic and I can
fixup that or other simple things at commit time.

Is there anthing serious still not working? As the subpage support is
sort of an isolated feature we could afford to get the first batch of
code in and continue polishing. Read-only suppot with 64k/4k is a good
milestone so I'm not worried too much about some smaller things left
behind, as long as the default case page size == sectorsize works.

Tests of this branch are still running but so far so good. I'll add it
as a topic branch to for-next for testing and my current plan is to push
it to misc-next soon, targeting 5.12.

> In the subpage branch
> - Metadata read write and balance
>   Not yet full tested due to data write still has bugs need to be
>   solved.
>   But considering that metadata operations from previous iteration
>   is mostly untouched, metadata read write should be pretty stable.

I assume the bugs are for the 64k/4k usecase.

> - Data read write and balance
>   Only uncompressed data writes. Fsstress can survive for around 5000
>   ops and more.
>   But still some random data csum error, and even more rare ordered
>   extent related BUG_ON().
>   Still invetigating.

You say it's for 'read write', right now getting the read-only suport
without known bugs would be sufficient.

> === Needs feedback ===
> The following design needs extra comments:
> 
> - u16 bitmap
>   As David mentioned, using u16 as bit map is not the fastest way.
>   That's also why current bitmap code requires unsigned long (u32) as
>   minimal unit.
>   But using bitmap directly would double the memory usage.
>   Thus the best way is to pack two u16 bitmap into one u32 bitmap, but
>   that still needs extra investigation to find better practice.

I think that for first implementation we can afford to trade off
correctness for performance. In this case not optimal bitmap tracking
with the spinlock. Replacing a better bitmap tracking with atomics would
be a separate step and can be reviewed independently once we know the
slow but coorrect case works as expected.

>   Anyway the skeleton should be pretty simple to expand.
> 
> - Separate handling for subpage metadata
>   Currently the metadata read and (later write path) handles subpage
>   metadata differently. Mostly due to the page locking must be skipped
>   for subpage metadata.
>   I tried several times to use as many common code as possible, but
>   every time I ended up reverting back to current code.
> 
>   Thankfully, for data handling we will use the same common code.

Ok.

> - Incompatible subpage strcuture against iomap_page
>   In btrfs we need extra bits than iomap_page.
>   This is due to we need sector perfect write for data balance.
>   E.g. if only one 4K sector is dirty in a 64K page, we should only
>   write that dirty 4K back to disk, not the full 64K page.
> 
>   As data balance requires the new data extents to have exactly the
>   same size as the original ones.
>   This means, unless iomap_page get extra bits like what we're doing in
>   btrfs for dirty, we can't merge the btrfs_subpage with iomap_page.

Ok, so implementing the subpage support inside btrfs first gives us some
space for the specific needs or workarounds that would perhaps need
extensions of the iomap API. Once we have that working and understand
what exactly we need, then we can ask for iomap changes. This has worked
well, eg. during the direct io conversion, so we can build on that.
