Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1363497F28
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 13:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiAXMTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbiAXMTp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 07:19:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0506C06173B
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jan 2022 04:19:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881AEB80EFD
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jan 2022 12:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A7DC340E1;
        Mon, 24 Jan 2022 12:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643026782;
        bh=dpXX+DPohZYWZTfWASPtBjYKa4pMTzDX1oLiGjf3Kqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opKLyD01YD5orsab+zFjBfvrvO9HBd/Zt0jHVLJxhm6Ehzu+i+TwSadoa8bIdjBBY
         HT4KHeKocXHKdJQHbhKVPxTBzYRKSKGsz4uTResUgHMOqdZWJWwI7MwqAGCjV21hu+
         k6VtHhBrTJc8wZOx1OPlAvkc6/mqwS9fS1aFoYkWrSI+hxESbS4M6gsAYtBvWhHAnU
         qMw+Ko7ibPEbYnnaAIWuI8hRnQTb40B21JdPK4Ln6rKKfGUmSAmsjWl7BJihE2xzP7
         Btblh/ChncB+yYfEr/9e0OlvF7Blr8oFon+SJFFQUDw6aDQbPbMzyaT9crkoio5BQq
         shf4XVS85DXLA==
Date:   Mon, 24 Jan 2022 12:19:39 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: defrag: don't try to merge regular extents with
 preallocated extents
Message-ID: <Ye6ZW0z1FQXlRlPU@debian9.Home>
References: <20220123045242.25247-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123045242.25247-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 23, 2022 at 12:52:42PM +0800, Qu Wenruo wrote:
> [BUG]
> With older kernels (before v5.16), btrfs will defrag preallocated extents.
> While with newer kernels (v5.16 and newer) btrfs will not defrag
> preallocated extents, but it will defrag the extent just before the
> preallocated extent, even it's just a single sector.
> 
> This can be exposed by the following small script:
> 
> 	mkfs.btrfs -f $dev > /dev/null
> 
> 	mount $dev $mnt
> 	xfs_io -f -c "pwrite 0 4k" -c sync -c "falloc 4k 16K" $mnt/file
> 	xfs_io -c "fiemap -v" $mnt/file
> 	btrfs fi defrag $mnt/file
> 	sync
> 	xfs_io -c "fiemap -v" $mnt/file
> 
> The output looks like this on older kernels:
> 
> /mnt/btrfs/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..7]:          26624..26631         8   0x0
>    1: [8..39]:         26632..26663        32 0x801
> /mnt/btrfs/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..39]:         26664..26703        40   0x1
> 
> Which defrags the single sector along with the preallocated extent, and
> replace them with an regular extent into a new location (caused by data
> COW).
> This wastes most of the data IO just for the preallocated range.
> 
> On the other hand, v5.16 is slightly better:
> 
> /mnt/btrfs/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..7]:          26624..26631         8   0x0
>    1: [8..39]:         26632..26663        32 0x801
> /mnt/btrfs/file:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..7]:          26664..26671         8   0x0
>    1: [8..39]:         26632..26663        32 0x801
> 
> The preallocated range is not defragged, but the sector before it still
> gets defragged, which has no need for it.
> 
> [CAUSE]
> One of the function reused by the old and new behavior is
> defrag_check_next_extent(), it will determine if we should defrag
> current extent by checking the next one.
> 
> It only checks if the next extent is a hole or inlined, but it doesn't
> check if it's preallocated.
> 
> On the other hand, out of the function, both old and new kernel will
> reject preallocated extents.
> 
> Such inconsistent behavior causes above behavior.
> 
> [FIX]
> - Also check if next extent is preallocated
>   If so, don't defrag current extent
> 
> - Add comments on each case we don't defrag
> 
> This will reduce the IO caused by defrag ioctl and autodefrag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 91ba2efe9792..dfa81b377e89 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1049,23 +1049,40 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  	return em;
>  }
>  
> +/*
> + * Return if current extent @em is a good candidate for defrag.
> + *
> + * This is done by checking against the next extent after @em.
> + */
>  static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  				     bool locked)
>  {
>  	struct extent_map *next;
> -	bool ret = true;
> +	bool ret = false;
>  
>  	/* this is the last extent */
>  	if (em->start + em->len >= i_size_read(inode))
> -		return false;
> +		return ret;
>  
>  	next = defrag_lookup_extent(inode, em->start + em->len, locked);
> +	/* No next extent or a hole, no way to merge */
>  	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
> -		ret = false;
> -	else if ((em->block_start + em->block_len == next->block_start) &&
> -		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
> -		ret = false;
> +		goto out;
>  
> +	/* Next extent is preallocated, no sense to defrag current extent */
> +	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
> +		goto out;
> +
> +	/*
> +	 * Next extent are not only mergable but also adjacent in their

are not -> is not
mergable -> mergeable
their -> its

> +	 * logical address, normally an excellent candicate, but if they

candicate -> candidate

> +	 * are already large enough, then no need to defrag current extent.
> +	 */

It still sounds a bit odd to me, maybe:

Next extent is mergeable and its logical address is contiguous with this
extent, so normally an excellent candidate, but if this extent or the next
one is already large enough, then we don't need to defrag. We use SZ_128K
because in case of enabled compression, extents can never be larger than
that.

Adding this comment is unrelated to this fix about prealloc extents, but I'm
fine with it.

Other than that it looks fine.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +	if ((em->block_start + em->block_len == next->block_start) &&
> +	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
> +		goto out;
> +	ret = true;
> +out:
>  	free_extent_map(next);
>  	return ret;
>  }
> -- 
> 2.34.1
> 
