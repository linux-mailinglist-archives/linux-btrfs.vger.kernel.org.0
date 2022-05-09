Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDD51F93C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiEIKDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiEIKBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 06:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16B19FF72
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 02:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD6E6152A
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E418C385AB;
        Mon,  9 May 2022 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090193;
        bh=3ndl8UvL/IEaFXJWbKsjdtmlSr1x4uvF8el1c/JldBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzUZ2i+cGU4UkbjdytqzgACg+xzt1i+AiLZXYw5fusTVL53RW5HpGocPNY8AUAnQp
         TMqZ1m94qBsKhTQoNURCREwFvPf6ahIm3Qse76w/RzrUSCreaMs8873SWW5gonNh5L
         78mPbvmN8l0g7LkAjDgyIpQ9x1ce18D0ouI6X8X4dux9N7EgOeE1wg/WyI6f6VMyyC
         r3psoXMKtXzEyhh6O0L096YTuhDRZh15C8f/96AqXcpCJuzN4eOmMmo9TdebgDRZ8C
         i5cKU2v6+G9fjWbBD288tHqhRDxRipPFzJmBaUpqHpdIetDiK/ql64MmEq2T3U7xQK
         TbmUjOeTNc90g==
Date:   Mon, 9 May 2022 10:56:30 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular
 extents
Message-ID: <20220509095630.GA2270453@falcondesktop>
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 07, 2022 at 02:39:27PM +0800, Qu Wenruo wrote:
> Btrfs defaults to max_inline=2K to make small writes inlined into
> metadata.
> 
> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
> metadata usage, it should still cause less physical space used compared
> to a 4K regular extents.
> 
> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
> users may find inlined extents causing too much space wasted, and want
> to convert those inlined extents back to regular extents.
> 
> Unfortunately defrag will unconditionally skip all inline extents, no
> matter if the user is trying to converting them back to regular extents.
> 
> So this patch will add a small exception for defrag_collect_targets() to
> allow defragging inline extents, if and only if the inlined extents are
> larger than max_inline, allowing users to convert them to regular ones.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9d8e46815ee4..852c49565ab2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		if (!em)
>  			break;
>  
> -		/* Skip hole/inline/preallocated extents */
> -		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
> +		/*
> +		 * If the file extent is an inlined one, we may still want to
> +		 * defrag it (fallthrough) if it will cause a regular extent.
> +		 * This is for users who want to convert inline extents to
> +		 * regular ones through max_inline= mount option.
> +		 */
> +		if (em->block_start == EXTENT_MAP_INLINE &&
> +		    em->len <= inode->root->fs_info->max_inline)
> +			goto next;
> +
> +		/* Skip hole/delalloc/preallocated extents */
> +		if (em->block_start == EXTENT_MAP_HOLE ||
> +		    em->block_start == EXTENT_MAP_DELALLOC ||
>  		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>  			goto next;
>  
> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		if (em->len >= get_extent_max_capacity(em))
>  			goto next;
>  
> +		/*
> +		 * For inline extent it should be the first extent and it
> +		 * should not have a next extent.

This is misleading.

As you know, and we've discussed this in a few threads in the past, there are
at least a couple causes where we can have an inline extent followed by other
extents. One has to do with compresson and the other with fallocate.

So either this part of the comment should be rephrased or go away.

This is also a good oppurtunity to convert cases where we have an inlined
compressed extent followed by one (or more) extents:

  $ mount -o compress /dev/sdi /mnt
  $ xfs_io -f -s -c "pwrite -S 0xab 0 4K" -c "pwrite -S 0xcd -b 16K 4K 16K" /mnt/foobar

In this case a defrag could mark the [0, 20K[ for defrag and we end up saving
both data and metadata space (one less extent item in the fs tree and maybe in
the extent tree too).

Thanks.

> +		 * If the inlined extent passed all above checks, just add it
> +		 * for defrag, and be converted to regular extents.
> +		 */
> +		if (em->block_start == EXTENT_MAP_INLINE)
> +			goto add;
> +
>  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
>  						extent_thresh, newer_than, locked);
>  		if (!next_mergeable) {
> -- 
> 2.36.0
> 
