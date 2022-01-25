Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5F49B206
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbiAYKeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 05:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352598AbiAYK07 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 05:26:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEDC061751
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 02:26:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB04861627
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 10:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD5C340E0;
        Tue, 25 Jan 2022 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106409;
        bh=C3/AEIwtu8NMb5wHPdL67whnqHGWp5aVkpYSPRuSVgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2rJkP27MWo/VCMNmcugnqjIuUYrCSedAMmBv4Ub8I66JhzhTq8PIDiKfFKTvxkse
         QMJVoJY8B+02A0MRL/ctKCipactJhrpaLPqpMkT0UkYhSndUjRdFAEGECdwyGWz6DH
         /cBIAylgJK6wFX13FiaUG4etP+YN8J9/WG59SJwPosbH3uAuWOhE0DKbwSNSSkq257
         vdL1fuGqr6immKrMLDpyFQnG/fOOgzV4k8Io91iOmWcx/Aa9UpOf4ssWK3wEkARzC7
         By0n8pNEb2lrx8PeyxSTxuNtuy4gtK+4d2+POjxUDUvp/yszjqr4Ssu2RwiTFCRoSx
         2+gc7SxivP2qw==
Date:   Tue, 25 Jan 2022 10:26:46 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: defrag: don't try to merge regular extents
 with preallocated extents
Message-ID: <Ye/QZl2k0NGa2GqL@debian9.Home>
References: <20220125070638.40678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125070638.40678-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 03:06:38PM +0800, Qu Wenruo wrote:
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
>   If so, don't defrag current extent.
> 
> - Make extent size check consistent
>   By passing @extent_thresh from the caller.
> 
> - Remove an ambiguous check based on physical address
>   There used to be an check on physically adjacent and large enough file
>   extents.
>   That check is too specific, we already add proper size check.
>   And for physically adjacent extents we may also want to merge them as
>   that can reduce the number of extents.
> 
> This will reduce the IO caused by defrag ioctl and autodefrag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> v2:
> - Use @extent_thresh from caller to replace the harded coded threshold
>   Now caller has full control over the extent threshold value.
> 
> - Remove the old ambiguous check based on physical address
>   The original check is too specific, only reject extents which are
>   physically adjacent, AND too large.
>   Since we have correct size check now, and the physically adjacent check
>   is not always a win.
>   So remove the old check completely.
> 
> ---
>  fs/btrfs/ioctl.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 91ba2efe9792..d19bb882c3c4 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1049,23 +1049,43 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  	return em;
>  }
>  
> +/*
> + * Return if current extent @em is a good candidate for defrag.
> + *
> + * This is done by checking against the next extent after @em.
> + */
>  static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> -				     bool locked)
> +				     u32 extent_thresh, bool locked)
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
> +	/* Next extent is already large enough */
> +	if (next->len >= extent_thresh)
> +		goto out;
> +	/*
> +	 * There used to be a check based on em->block_start and
> +	 * next->block_start, but merging physically adjacent
> +	 * extents still has its own benefit, like reduce the number
> +	 * of extent items.
> +	 * So here we don't reject physically adjacent extents, only
> +	 * reject hole/preallocated or large enough extents.
> +	 */
> +	ret = true;

Please don't do this.
You are piggy backing several changes into a single patch.
The subject, and v1, is about merging preallocated extents, so this patch
should be only about that.

Other behavioral changes should have their own dedicated patch.

Thanks.


> +out:
>  	free_extent_map(next);
>  	return ret;
>  }
> @@ -1225,7 +1245,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto next;
>  
>  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> -							  locked);
> +							  extent_thresh, locked);
>  		if (!next_mergeable) {
>  			struct defrag_target_range *last;
>  
> -- 
> 2.34.1
> 
