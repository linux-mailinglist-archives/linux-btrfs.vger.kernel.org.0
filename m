Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BEF4A9D93
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376823AbiBDRU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 12:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiBDRU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 12:20:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA5C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 09:20:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B05B83658
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D125FC004E1;
        Fri,  4 Feb 2022 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643995224;
        bh=fkL5zS4l5bSVS5+IGYJAdn0NF3BL0rKh0KShDKo/cgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+U4iJXz6c+iCMGWwGACrEYLrCd5EYLbEd9XFlVoAh/x4CxzPDI2V+f8nRNMYcyWa
         F44rOmQHTpjKfQ+Gw2l84AlnvSCDNmwOweI9uW3D4dS8bWgEgCwIldpv25i6CTfOYH
         Y4Cp5w2vQL9maEYyMqXd1Q/OX63FuuI4eCpG85OEbqfnkQXEZY4F6UDxzKQ0utfNP6
         kSAoYoKYIPc/tdGoz3opVSItNW+4cQZa0CWQ1PTLgTbXRtHM0oxkjghtCwMbMACGnU
         6aOtQHiL8qfxGw76Ww4yBYoldTLuSyX900FGw1oNnayd5nLkSOCwQtnyqORhRyPGXA
         nVfoP7N8aj/Ug==
Date:   Fri, 4 Feb 2022 17:20:21 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
Message-ID: <Yf1gVUTezMEviTPU@debian9.Home>
References: <cover.1643961719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643961719.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 04:11:54PM +0800, Qu Wenruo wrote:
> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
> by cluster, thus we can have a better layered code structure, just like
> what we have now:
> 
> btrfs_defrag_file()
> |- defrag_one_cluster()
>    |- defrag_one_range()
>       |- defrag_one_locked_range()
> 
> But there is a catch, btrfs_defrag_file() just moves the cluster to the
> next cluster, never considering cases like the current extent is already
> too large, we can skip to its end directly.
> 
> This increases CPU usage on very large but not fragmented files.
> 
> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
> will reports where next search should start from.
> 
> If the current extent is not a target at all, then we can jump to the
> end of that non-target extent to save time.
> 
> To get the missing optimization, also introduce a new structure,
> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
> @max_to_defrag around.
> 
> This also remove weird behaviors like reusing range::start for next
> search location.
> 
> And since we need to convert old btrfs_ioctl_defrag_range_args to newer
> btrfs_defrag_ctrl, also do extra sanity check in the converting
> function.
> 
> Such cleanup will also bring us closer to expose these extra policy
> parameters in future enhanced defrag ioctl interface.
> (Unfortunately, the reserved space of the existing defrag ioctl is not
> large enough to contain them all)
> 
> Changelog:
> v2:
> - Rebased to lastest misc-next
>   Just one small conflict with static_assert() update.
>   And this time only those patches are rebased to misc-next, thus it may
>   cause conflicts with fixes for defrag_check_next_extent() in the
>   future.
> 
> - Several grammar fixes
> 
> - Report accurate btrfs_defrag_ctrl::sectors_defragged
>   This is inspired by a comment from Filipe that the skip check
>   should be done in the defrag_collect_targets() call inside
>   defrag_one_range().
> 
>   This results a new patch in v2.
> 
> - Change the timing of btrfs_defrag_ctrl::last_scanned update
>   Now it's updated inside defrag_one_range(), which will give
>   us an accurate view, unlike the previous call site in
>   defrag_one_cluster().
> 
> - Don't change the timing of extent threshold.
> 
> - Rename @last_target to @last_is_target in defrag_collect_targets()
> 
> 
> Qu Wenruo (5):
>   btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
>   btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
>   btrfs: defrag: use btrfs_defrag_ctrl to replace
>     btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
>   btrfs: defrag: make btrfs_defrag_file() to report accurate number of
>     defragged sectors
>   btrfs: defrag: allow defrag_one_cluster() to large extent which is not

The subject of this last patch sounds odd. I think you miss the word "skip"
before "large" - "... to skip large extent ...".

Looks fine, I left some minor comments on individual patches.
Thinks that can be eiher fixed when cherry picked, or just in case you
need to send another version for some other reason.

So:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

So something unrelated to this patchset, but to the overall refactoring
that happened in 5.16, and that I though about recently:

We no longer use btrfs_search_forward() to do the first pass to find
extents for defrag. I pointed out before all its advantages (skipping
large file ranges, avoiding loading extent maps and pinning them into
memory for too long periods or even until the fs is unmounted for
some cases, etc).

That should not cause extra IO for the defrag itself, only maybe indirectly
in case extra memory pressure starts triggering reclaim, due to extent maps
staying in memory and not being able to be removed, for the cases where
there are no pages in the page cache for the range they cover - in that case
they stay around since they are only released by btrfs_releasepage() or when
evicting the inode. So if a file is kept open for long periods and IO is
never done for ranges of some extent maps, that can happen.

By getting the extent maps in the first pass, it also can result in extra
read IO of leaves and nodes of the subvolume's btree.

This was all discussed before, either on another thread or on slack, so just
summarizing.

The other thing that is related, but I only through about yesterday:

Extent maps get merged. When they are merged, their generation field is set
to the maximum value between the extent maps, see try_merge_map(). That means
the checks for an extent map's generation, done at defrag_collect_targets(),
can now consider extents from past generations for defrag, where before, that
could not happen.

I.e. an extent map can represent 2 or more file extent items, and all can have
different generations. This can cause a lot of surprises, and potentially
resulting in more IO being done. Before the refactoring, when btrfs_search_forward()
was used, we could still consider extents for defrag from past generations, but
that happened only when we find leaves that have both new and old file extent
items. For the leaves from past generations, we skipped them and never considered
any of the extents their file extent items refer to. So, it could happen before
but to a much smaller scale/extent.

Just a through, since there's now a new thread with someone reporting excessive
IO with autodefrag even on 5.16.5 [1]. In the reported scenario there's a very
large file involved (33.65G), so possibly a huge amount of extents, and the effects
of extent map merging causing extra work.

[1] https://lore.kernel.org/linux-btrfs/KTVQ6R.R75CGDI04ULO2@gmail.com/


>     a target
> 
>  fs/btrfs/ctree.h           |  22 +++-
>  fs/btrfs/file.c            |  17 ++-
>  fs/btrfs/ioctl.c           | 224 ++++++++++++++++++++++---------------
>  include/uapi/linux/btrfs.h |   6 +-
>  4 files changed, 168 insertions(+), 101 deletions(-)
> 
> -- 
> 2.35.0
> 
