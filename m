Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25F749F8BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348230AbiA1Lux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 06:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348220AbiA1Luv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 06:50:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960AC061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 03:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46D62B82521
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 11:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68109C340E0;
        Fri, 28 Jan 2022 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643370649;
        bh=b1mDQWpjniPNScSKZNZHadPK0fRNBZWivXfXwDnaiSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+TltapRwbd0lQ2HrNLsL6+48YAkiU7gYHfhi7b+G4mqCNpNGIlQ2/wTQW1vyQplE
         7Ua6u7XrlBUBQnd3PYB5scII8G+40lfliamu0LZZBHoUuPIrTZnhDA+Jpfz9Qz7PnD
         yEAi8uB7GL4hLkjOOb+6SB5i79gGOBsHe45WLBFqlvqswcIeRlcdwDCKY0zNBbG7vR
         maGHeG9RtYNBL2PVdCB8LVkpikrjvZ1w9ibU1xdbmtduetlutOzbaZsnanvmrgCcU4
         VrC/buZtArHyyXg4zzAY2zBbyKTSw7unbqFdTrGT10Yz9/RETCeA59gpGQ1Gv2Y5GK
         txT5qTrcP55fA==
Date:   Fri, 28 Jan 2022 11:50:46 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents
 with preallocated extents
Message-ID: <YfPYlpE9q9jHq8bc@debian9.Home>
References: <cover.1643354254.git.wqu@suse.com>
 <631137433533de5eb304d9e87c799a65cd4cf62f.1643354254.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631137433533de5eb304d9e87c799a65cd4cf62f.1643354254.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 03:21:20PM +0800, Qu Wenruo wrote:
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
> - Add comments for each branch why we reject the extent
> 
> This will reduce the IO caused by defrag ioctl and autodefrag.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/ioctl.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 91ba2efe9792..a622b1ac0fec 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1053,19 +1053,24 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
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
> +	/* No more em or hole */
>  	if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
> -		ret = false;
> -	else if ((em->block_start + em->block_len == next->block_start) &&
> -		 (em->block_len > SZ_128K && next->block_len > SZ_128K))
> -		ret = false;
> -
> +		goto out;
> +	if (test_bit(EXTENT_FLAG_PREALLOC, &next->flags))
> +		goto out;
> +	/* Physically adjacent and large enough */
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
