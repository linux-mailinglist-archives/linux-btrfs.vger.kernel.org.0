Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C713879C327
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbjILCmM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 22:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjILCmA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 22:42:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48914107C4B;
        Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75967C433CA;
        Mon, 11 Sep 2023 21:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694466007;
        bh=1Mtvtm9h8TdWnm2D+iqG/IpaTwZ8nD6u53SoLdurI14=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fuwGvohpcmfKGO2RWlGciogfllrT4g6bvxsOEkzncwoCYESfxu+p/K54lOrttG+Uz
         Lbd3aJYJZpIPbYwhQAehM6Gcr6KwCM+3tyPtTm0hyQN5j/yWkyUzAincgHBnwO/zpY
         pjXnphPXJc1bAkNZKsCAH/3A9PCby/n/MzYiyVO83lUlsnq17ky39/585vP0brzZ1r
         PxD3tWMaSrH5bqscYUxsP3a4Gtxzz3ZEpJEX0IouQpdRnPF38YH46SWKSKDF/i7Gtc
         CvguMJQzhPokaUhGzmLsWF7s9PVRrHDxRCHs5Pzyiuyf7klnI2t1uzusdnlH8hs3cv
         +4ffX5dswg1Bw==
Message-ID: <9cae9239-2a07-6477-da53-275944e8ce25@kernel.org>
Date:   Tue, 12 Sep 2023 06:00:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/11/23 21:52, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/accessors.h            | 10 ++++++++++
>  fs/btrfs/locking.c              |  5 +++--
>  include/uapi/linux/btrfs_tree.h | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index f958eccff477..977ff160a024 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
>  BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
>  BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
>  
> +BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
> +BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
> +BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
> +BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
> +			 struct btrfs_stripe_extent, encoding, 8);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_length, struct btrfs_raid_stride, length, 64);
> +
>  /* struct btrfs_dev_extent */
>  BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
>  BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 6ac4fd8cc8dc..e7760d40feab 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -58,8 +58,8 @@
>  
>  static struct btrfs_lockdep_keyset {
>  	u64			id;		/* root objectid */
> -	/* Longest entry: btrfs-block-group-00 */
> -	char			names[BTRFS_MAX_LEVEL][24];
> +	/* Longest entry: btrfs-raid-stripe-tree-00 */
> +	char			names[BTRFS_MAX_LEVEL][25];
>  	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
>  } btrfs_lockdep_keysets[] = {
>  	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
> @@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
>  	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
>  	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
>  	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
> +	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID,DEFINE_NAME("raid-stripe-tree") },
>  	{ .id = 0,				DEFINE_NAME("tree")	},
>  };
>  
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index fc3c32186d7e..3fb758ce3ac0 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -4,9 +4,8 @@
>  
>  #include <linux/btrfs.h>
>  #include <linux/types.h>
> -#ifdef __KERNEL__
>  #include <linux/stddef.h>
> -#else
> +#ifndef __KERNEL__
>  #include <stddef.h>
>  #endif

This change seems unrelated to the RAID stripe tree. Should this be a patch on
its own ?

>  
> @@ -73,6 +72,9 @@
>  /* Holds the block group items for extent tree v2. */
>  #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>  
> +/* tracks RAID stripes in block groups. */
> +#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
> +
>  /* device stats in the device tree */
>  #define BTRFS_DEV_STATS_OBJECTID 0ULL
>  
> @@ -285,6 +287,8 @@
>   */
>  #define BTRFS_QGROUP_RELATION_KEY       246
>  
> +#define BTRFS_RAID_STRIPE_KEY		247
> +
>  /*
>   * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
>   */
> @@ -719,6 +723,31 @@ struct btrfs_free_space_header {
>  	__le64 num_bitmaps;
>  } __attribute__ ((__packed__));
>  
> +struct btrfs_raid_stride {
> +	/* btrfs device-id this raid extent lives on */
> +	__le64 devid;
> +	/* physical location on disk */
> +	__le64 physical;
> +	/* length of stride on this disk */
> +	__le64 length;
> +};
> +
> +#define BTRFS_STRIPE_DUP	0
> +#define BTRFS_STRIPE_RAID0	1
> +#define BTRFS_STRIPE_RAID1	2
> +#define BTRFS_STRIPE_RAID1C3	3
> +#define BTRFS_STRIPE_RAID1C4	4
> +#define BTRFS_STRIPE_RAID5	5
> +#define BTRFS_STRIPE_RAID6	6
> +#define BTRFS_STRIPE_RAID10	7
> +
> +struct btrfs_stripe_extent {
> +	__u8 encoding;
> +	__u8 reserved[7];
> +	/* array of raid strides this stripe is composed of */
> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
> +};
> +
>  #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
>  #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
>  
> 

-- 
Damien Le Moal
Western Digital Research

