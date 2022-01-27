Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB549DFBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 11:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239468AbiA0KsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 05:48:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42134 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiA0KsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 05:48:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4244261593
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 10:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068FC340EA;
        Thu, 27 Jan 2022 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643280499;
        bh=Wjjd80HgbHzdPstRPSZlEDGywZwdNAergLGxthA1vX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPQSLWS6VG223eY6lAoboqHtXHj3KTX5XU7BlqkwFOA68i3eCXV2rqsUSjsOADiOf
         VL1eId/WRlYH0jJ2G0XP+IqIafgOVgB03vPtZ6+UX0kUSUsfmdgNYNFW5iXj5qs4wa
         37lQDnB6v3U0DjtBZhBBOIaRAlBEoT5E497281GvEdsgRAc08mWw0zufPXvINrkm1X
         1Dcz8SCjIEF4VjcoOwHWYwqLla743axcLqQ7U38BbQVOZRp89bV326O7k02yFk5QZx
         kuJgfnqKtEd6dNTTbU9Sz3vqC+zwQ+0My2bnhrCZ7i7qz9f7T4T/jsNcWfV1u4H36l
         XzMPp4jvqzX7A==
Date:   Thu, 27 Jan 2022 10:48:16 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/2] btrfs: defrag: don't defrag extents which is already
 at its max capacity
Message-ID: <YfJ4cMXCQoLXeOdF@debian9.Home>
References: <cover.1643260816.git.wqu@suse.com>
 <9511adf7a32cb7200f62bc65741cd86dbf2a9365.1643260816.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9511adf7a32cb7200f62bc65741cd86dbf2a9365.1643260816.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:24:42PM +0800, Qu Wenruo wrote:
> [BUG]
> For compressed extents, defrag ioctl will always try to defrag any
> compressed extents, wasting not only IO but also CPU time to
> compress/decompress:
> 
>    mkfs.btrfs -f $DEV
>    mount -o compress $DEV $MNT
>    xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
>    sync
>    xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
>    sync
>    echo "=== before ==="
>    xfs_io -c "fiemap -v" $MNT/foobar
>    btrfs filesystem defrag $MNT/foobar
>    sync
>    echo "=== after ==="
>    xfs_io -c "fiemap -v" $MNT/foobar
> 
> Then it shows the 2 128K extents just get CoW for no extra benefit, with
> extra IO/CPU spent:
> 
>     === before ===
>     /mnt/btrfs/file1:
>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>        0: [0..255]:        26624..26879       256   0x8
>        1: [256..511]:      26632..26887       256   0x9
>     === after ===
>     /mnt/btrfs/file1:
>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>        0: [0..255]:        26640..26895       256   0x8
>        1: [256..511]:      26648..26903       256   0x9
> 
> This affects not only v5.16 (after the defrag rework), but also v5.15
> (before the defrag rework).
> 
> [CAUSE]
> From the very beginning, btrfs defrag never checks if one extent is
> already at its max capacity (128K for compressed extents, 128M
> otherwise).
> 
> And the default extent size threshold is 256K, which is already beyond
> the compressed extent max size.
> 
> This means, by default btrfs defrag ioctl will mark all compressed
> extent which is not adjacent to a hole/preallocated range for defrag.
> 
> [FIX]
> Introduce a helper to grab the maximum extent size, and then in
> defrag_collect_targets() and defrag_check_next_extent(), reject extents
> which are already at their max capacity.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 137d3732af33..a03c31e1ff18 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1049,6 +1049,13 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
>  	return em;
>  }
>  
> +static u32 get_extent_max_capacity(struct extent_map *em)

Could be made const.

Minor thing apart, which can updated when the patch is picked,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +{
> +	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> +		return BTRFS_MAX_COMPRESSED;
> +	return BTRFS_MAX_EXTENT_SIZE;
> +}
> +
>  static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  				     bool locked)
>  {
> @@ -1065,6 +1072,12 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
>  		goto out;
>  	if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>  		goto out;
> +	/*
> +	 * If the next extent is at its max capcity, defragging current extent
> +	 * makes no sense, as the total number of extents won't change.
> +	 */
> +	if (next->len >= get_extent_max_capacity(em))
> +		goto out;
>  	/* Physically adjacent and large enough */
>  	if ((em->block_start + em->block_len == next->block_start) &&
>  	    (em->block_len > SZ_128K && next->block_len > SZ_128K))
> @@ -1229,6 +1242,13 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		if (em->len >= extent_thresh)
>  			goto next;
>  
> +		/*
> +		 * Skip extents already at its max capacity, this is mostly for
> +		 * compressed extents, which max cap is only 128K.
> +		 */
> +		if (em->len >= get_extent_max_capacity(em))
> +			goto next;
> +
>  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
>  							  locked);
>  		if (!next_mergeable) {
> -- 
> 2.34.1
> 
