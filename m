Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FD258377
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgHaV07 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 17:26:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgHaV06 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 17:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A54CAE63;
        Mon, 31 Aug 2020 21:26:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC265DA7C7; Mon, 31 Aug 2020 23:25:45 +0200 (CEST)
Date:   Mon, 31 Aug 2020 23:25:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: remove the inode_need_compress() call in
Message-ID: <20200831212545.GD28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200804072548.34001-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804072548.34001-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 04, 2020 at 03:25:46PM +0800, Qu Wenruo wrote:
> This is an attempt to remove the inode_need_compress() call in
> compress_file_extent().
> 
> As that compress_file_extent() can race with inode ioctl or bad
> compression ratio, to cause NULL pointer dereferecen for @pages, it's
> nature to try to remove that inode_need_compress() to remove the race
> completely.
> 
> However that's not that easy, we have the following problems:
> 
> - We still need to check @pages anyway
>   That @pages check is for kcalloc() failure, so what we really get is
>   just removing one indent from the if (inode_need_compress()).
>   Everything else is still the same (in fact, even worse, see below
>   problems)
> 
> - Behavior change
>   Before that change, every async_chunk does their check on
>   INODE_NO_COMPRESS flags.
>   If we hit any bad compression ratio, all incoming async_chunk will
>   fall back to plain text write.
> 
>   But if we remove that inode_need_compress() check, then we still try
>   to compress, and lead to potentially wasted CPU times.

Hm, any way I read it, this does not follow the intentions how the
compression decisions should work. The whole idea is to have 2 modes,
force-compress which overrides everything, potentially wasting cpu
cycles.  This is the fallback when the automatic nocompress logic is
bailing out too early.

To fix that, the normal 'compress' mode plus heuristics should decide if
the compression should happen at all and after it does not, flip the
nocompress bit. This is still not ideal as there's no "learning" that
some file ranges can compress worse but we still want to keep the file
compression on, just skip the bad ranges. Compared to one bad range then
skip compression on the file completely.

And your code throws away the location where the heuristic can give the
hint.

As we have several ways to request the compression (mount option, defrag
ioctl, property), the decision needs to be more fine grained.

1. btrfs_run_delalloc_range

- check if the compression is allowed at all (not if there are nodatacow
  or nodatasum bits)
- check if there's explicit request (defrag, compress-force)
- skip it if the nocompress bit is set
- the rest are the weak tests, either mount option or inode flags/props

At this point we don't need to call the heuristics.

2. compress_file_range

The range is split to the 128k chunks and each is evaluated separately.
Here we know we want to compress the range because of all the checks in
1 passed, so the only remaining decisions are based on:

- heuristics, try the given range and bail out eventuall or be more
  clever and do some longer-term statistics before flipping nocompress
  bit
- check the nocompress bit that could have been set in previous
  iteration

So this is the plan, you can count how many things are not implemented.
I have prototype for the heuristic learning, but that's not the
important part, first the test conditions need to be shuffled around to
follow the above logic.

> - Still race between compression disable and NULL pointer dereferecen
>   There is a hidden race, mostly exposed by btrfs/071 test case, that we
>   have "compress_type = fs_info->compress_type", so we can still hit case
>   where that compress_type is NONE (caused by remount -o nocompress), and
>   then btrfs_compress_pages() will return -E2BIG, without modifying
>   @nr_pages

We maybe should add some last sanity check before btrfs_compress_pages
is called in case the defrag or prop changes after the checks.

>   Then later when we cleanup @pages, we try to access pages[i]->mapping,
>   triggering NULL pointer dereference.
> 
>   This will be address in the first patch though.

The patch makes it more robust so this is ok. The unexpected changes of
the compress type due to remount or prop changes could be avoided by
saving the type + level at the beginning of compress_file_range.
