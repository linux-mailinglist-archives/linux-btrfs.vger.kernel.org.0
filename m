Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE703ED9A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhHPPN6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 11:13:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42688 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhHPPN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 11:13:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BCFFC21E62;
        Mon, 16 Aug 2021 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629126803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWbz45tic8bcYegQBfNoA/lf2aXfJ4I1Oqwkb5P88N0=;
        b=JRSiENXsfMy76+yP52Id5xAdaSESSdgmvY9lz/NrV1ok94Ir2Lp2sDXZO/SAk4KGixm66o
        bH9t4EqTwRUed8ay7n2JD5brtxPFIGOo5i/mxnibAWm3tGxKzVSgGPzcTmUSynloSxSjrQ
        8k4WpfHWF1FCua/vbmzN9hfpi7sJmuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629126803;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWbz45tic8bcYegQBfNoA/lf2aXfJ4I1Oqwkb5P88N0=;
        b=Ld7B5aQF1EZcwab/XyBleRL5s4JEzdlXsajwF6aoMPC/NnjY1OufQlJaa3bLCCIMBRDmfZ
        c3rTKA6YXrECXcCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B3382A3B94;
        Mon, 16 Aug 2021 15:13:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0141DA72C; Mon, 16 Aug 2021 17:10:27 +0200 (CEST)
Date:   Mon, 16 Aug 2021 17:10:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
Message-ID: <20210816151026.GE5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 10, 2021 at 11:23:44PM +0800, Anand Jain wrote:
> The mount option max_inline ranges from 0 to the sectorsize (which is
> equal to pagesize). But we parse the mount options too early and before
> the sectorsize is a cache from the superblock. So the upper limit of
> max_inline is unaware of the actual sectorsize. And is limited by the
> temporary sectorsize 4096 (as below), even on a system where the default
> sectorsize is 64K.

So the question is what's a sensible value for >4K sectors, which is 64K
in this case.

Generally we allow setting values that may make sense only for some
limited usecase and leave it up to the user to decide.

The inline files reduce the slack space and on 64K sectors it could be
more noticeable than on 4K sectors. It's a trade off as the inline data
are stored in metadata blocks that are considered more precious.

Do you have any analysis of file size distribution on 64K systems for
some normal use case like roo partition?

I think this is worth fixing so to be in line with constraints we have
for 4K sectors but some numbers would be good too.

> 
> disk-io.c
> ::
> 2980         /* Usable values until the real ones are cached from the superblock */
> 2981         fs_info->nodesize = 4096;
> 2982         fs_info->sectorsize = 4096;
> 
> Fix this by reading the superblock sectorsize before the mount option parse.
> 
> Reported-by: Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/disk-io.c | 49 +++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2dd56ee23b35..d9505b35c7f5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3317,6 +3317,31 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	 */
>  	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
>  
> +	/*
> +	 * flag our filesystem as having big metadata blocks if
> +	 * they are bigger than the page size

Please fix/reformat/improve any comments that are in moved code.

> +	 */
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
> +		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> +			btrfs_info(fs_info,
> +				"flagging fs with big metadata feature");
> +		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> +	}
> +
> +	/* btrfs_parse_options uses fs_info::sectorsize, so read it here */
> +	nodesize = btrfs_super_nodesize(disk_super);
> +	sectorsize = btrfs_super_sectorsize(disk_super);
> +	stripesize = sectorsize;
> +	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
> +	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
> +
> +	/* Cache block sizes */
> +	fs_info->nodesize = nodesize;
> +	fs_info->sectorsize = sectorsize;
> +	fs_info->sectorsize_bits = ilog2(sectorsize);
> +	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
> +	fs_info->stripesize = stripesize;

It looks that there are no invariants broken by moving that code, so ok.

> +
>  	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
>  	if (ret) {
>  		err = ret;
> @@ -3343,30 +3368,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>  		btrfs_info(fs_info, "has skinny extents");
>  
> -	/*
> -	 * flag our filesystem as having big metadata blocks if
> -	 * they are bigger than the page size
> -	 */
> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
> -		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> -			btrfs_info(fs_info,
> -				"flagging fs with big metadata feature");
> -		features |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> -	}
> -
> -	nodesize = btrfs_super_nodesize(disk_super);
> -	sectorsize = btrfs_super_sectorsize(disk_super);
> -	stripesize = sectorsize;
> -	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
> -	fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
> -
> -	/* Cache block sizes */
> -	fs_info->nodesize = nodesize;
> -	fs_info->sectorsize = sectorsize;
> -	fs_info->sectorsize_bits = ilog2(sectorsize);
> -	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
> -	fs_info->stripesize = stripesize;
> -
>  	/*
>  	 * mixed block groups end up with duplicate but slightly offset
>  	 * extent buffers for the same range.  It leads to corruptions
> -- 
> 2.27.0
