Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96FB79DA0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjILUcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 16:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjILUci (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 16:32:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884F10DF;
        Tue, 12 Sep 2023 13:32:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D16B21847;
        Tue, 12 Sep 2023 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694550736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uATxwmbmavawxaY2PoxZquzdLoK6eWGSXGJbX4efGD0=;
        b=vZmYy1h6w25HCXoDLHG+MgCrRAgm4yU32dNk4DiCSFft0dsKzNX9m98QSKZ90FQ6OUGA0P
        Y9X5jDORBaWavm6QttP+oN7v/rFiMkpud5n6/5OlqpOklKxtKc+93hr3xXmC9yStWZPi+q
        2b13C/OiQ8Oy9UKpTuERyE2B3EZzJzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694550736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uATxwmbmavawxaY2PoxZquzdLoK6eWGSXGJbX4efGD0=;
        b=oIcGsIKZhTjKKlOof8qvdCJBwMUPG/LiMtRbrMJfW0CnHZKn+HQUl8i/B8wvGkJgfJJdQs
        JwpQA7Du4urHcFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD65D139DB;
        Tue, 12 Sep 2023 20:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oic2Lc/KAGVzfgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 20:32:15 +0000
Date:   Tue, 12 Sep 2023 22:32:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Message-ID: <20230912203214.GE20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 05:52:02AM -0700, Johannes Thumshirn wrote:
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

What is encoding referring to?

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

Length of "btrfs-raid-stripe-tree-00" is 25, there should be +1 for the
NUL, also length aligned to at least 4 is better.

>  	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
>  } btrfs_lockdep_keysets[] = {
>  	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
> @@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
>  	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
>  	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
>  	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
> +	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID,DEFINE_NAME("raid-stripe-tree") },

The naming is without the "tree"

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
>  
> @@ -73,6 +72,9 @@
>  /* Holds the block group items for extent tree v2. */
>  #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
>  
> +/* tracks RAID stripes in block groups. */

	Tracks ...

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

Any particular reason you chose 247 for the key number? It does not
leave any gap after BTRFS_QGROUP_RELATION_KEY and before
BTRFS_BALANCE_ITEM_KEY. If this is related to extents then please find
more suitable group of keys where to put it.

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

Comments should be full sentences.

> +	__le64 devid;
> +	/* physical location on disk */
> +	__le64 physical;
> +	/* length of stride on this disk */
> +	__le64 length;
> +};

__attribute__ ((__packed__));

> +
> +#define BTRFS_STRIPE_DUP	0
> +#define BTRFS_STRIPE_RAID0	1
> +#define BTRFS_STRIPE_RAID1	2
> +#define BTRFS_STRIPE_RAID1C3	3
> +#define BTRFS_STRIPE_RAID1C4	4
> +#define BTRFS_STRIPE_RAID5	5
> +#define BTRFS_STRIPE_RAID6	6
> +#define BTRFS_STRIPE_RAID10	7

This is probably defining the on-disk format so some consistency is
desired, there are already the BTRFS_BLOCK_GROUP_* types, from which the
BTRFS_RAID_* are derive, so the BTRFS_STRIPE_* values should match the
order and ideally the values themselves if possible.

> +
> +struct btrfs_stripe_extent {
> +	__u8 encoding;
> +	__u8 reserved[7];
> +	/* array of raid strides this stripe is composed of */
> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);

Do we really whant to declare that as __DECLARE_FLEX_ARRAY? It's not a
standard macro and obscures the definition.


> +};
> +
>  #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
>  #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
>  
> 
> -- 
> 2.41.0
