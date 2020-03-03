Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D65177D3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgCCRT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:19:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgCCRT2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:19:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDF1CAC65;
        Tue,  3 Mar 2020 17:19:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D5C3DA7AE; Tue,  3 Mar 2020 18:19:03 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:19:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 01/10] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iter
Message-ID: <20200303171902.GI2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302094553.58827-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 05:45:44PM +0800, Qu Wenruo wrote:
> Due to the complex nature of btrfs extent tree, when we want to iterate
> all backrefs of one extent, it involves quite a lot of work, like
> searching the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
> backrefs.
> 
> Normally this would result pretty complex code, something like:
>   btrfs_search_slot()
>   /* Ensure we are at EXTENT_ITEM/METADATA_ITEM */
>   while (1) {	/* Loop for extent tree items */
> 	while (ptr < end) { /* Loop for inlined items */
> 		/* REAL WORK HERE */
> 	}
>   next:
>   	ret = btrfs_next_item()
> 	/* Ensure we're still at keyed item for specified bytenr */
>   }
> 
> The idea of btrfs_backref_iter is to avoid such complex and hard to
> read code structure, but something like the following:
> 
>   iter = btrfs_backref_iter_alloc();
>   ret = btrfs_backref_iter_start(iter, bytenr);
>   if (ret < 0)
> 	goto out;
>   for (; ; ret = btrfs_backref_iter_next(iter)) {
> 	/* REAL WORK HERE */
>   }
>   out:
>   btrfs_backref_iter_free(iter);
> 
> This patch is just the skeleton + btrfs_backref_iter_start() code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/backref.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/backref.h | 60 ++++++++++++++++++++++++++++++++
>  2 files changed, 147 insertions(+)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 327e4480957b..444cd5d31d87 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2299,3 +2299,90 @@ void free_ipath(struct inode_fs_paths *ipath)
>  	kvfree(ipath->fspath);
>  	kfree(ipath);
>  }
> +
> +int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
> +{
> +	struct btrfs_fs_info *fs_info = iter->fs_info;
> +	struct btrfs_path *path = iter->path;
> +	struct btrfs_extent_item *ei;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	key.objectid = bytenr;
> +	key.type = BTRFS_METADATA_ITEM_KEY;
> +	key.offset = (u64)-1;
> +	iter->bytenr = bytenr;
> +
> +	ret = btrfs_search_slot(NULL, fs_info->extent_root, &key, path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0) {
> +		ret = -EUCLEAN;
> +		goto release;
> +	}
> +	if (path->slots[0] == 0) {
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		ret = -EUCLEAN;
> +		goto release;
> +	}
> +	path->slots[0]--;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +	if (!(key.type == BTRFS_EXTENT_ITEM_KEY ||
> +	      key.type == BTRFS_METADATA_ITEM_KEY) || key.objectid != bytenr) {
> +		ret = -ENOENT;
> +		goto release;
> +	}
> +	memcpy(&iter->cur_key, &key, sizeof(key));
> +	iter->item_ptr = btrfs_item_ptr_offset(path->nodes[0],
> +					       path->slots[0]);
> +	iter->end_ptr = iter->item_ptr + btrfs_item_size_nr(path->nodes[0],
> +							    path->slots[0]);
> +	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			    struct btrfs_extent_item);
> +
> +	/*
> +	 * Only support iteration on tree backref yet.
> +	 *
> +	 * This is extra precaustion for non skinny-metadata, where
> +	 * EXTENT_ITEM is also used for tree blocks, that we can only use
> +	 * extent flags to determine if it's a tree block.
> +	 */
> +	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA) {
> +		ret = -ENOTTY;

What's the reason for ENOTTY?

> +		goto release;
> +	}
> +	iter->cur_ptr = iter->item_ptr + sizeof(*ei);
> +
> +	/* If there is no inline backref, go search for keyed backref */
> +	if (iter->cur_ptr >= iter->end_ptr) {
> +		ret = btrfs_next_item(fs_info->extent_root, path);
> +
> +		/* No inline nor keyed ref */
> +		if (ret > 0) {
> +			ret = -ENOENT;
> +			goto release;
> +		}
> +		if (ret < 0)
> +			goto release;
> +
> +		btrfs_item_key_to_cpu(path->nodes[0], &iter->cur_key,
> +				path->slots[0]);
> +		if (iter->cur_key.objectid != bytenr ||
> +		    (iter->cur_key.type != BTRFS_SHARED_BLOCK_REF_KEY &&
> +		     iter->cur_key.type != BTRFS_TREE_BLOCK_REF_KEY)) {
> +			ret = -ENOENT;
> +			goto release;
> +		}
> +		iter->cur_ptr = btrfs_item_ptr_offset(path->nodes[0],
> +						      path->slots[0]);
> +		iter->item_ptr = iter->cur_ptr;
> +		iter->end_ptr = iter->item_ptr + btrfs_item_size_nr(
> +				path->nodes[0], path->slots[0]);
> +	}
> +
> +	return 0;
> +release:
> +	btrfs_backref_iter_release(iter);
> +	return ret;
> +}
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 777f61dc081e..8b1ec11d4b28 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -74,4 +74,64 @@ struct prelim_ref {
>  	u64 wanted_disk_byte;
>  };
>  
> +/*
> + * Helper structure to help iterate backrefs of one extent.
> + *
> + * Now it only supports iteration for tree block in commit root.
> + */
> +struct btrfs_backref_iter {
> +	u64 bytenr;
> +	struct btrfs_path *path;
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_key cur_key;
> +	unsigned long item_ptr;
> +	unsigned long cur_ptr;
> +	unsigned long end_ptr;
> +};
> +
> +static inline struct btrfs_backref_iter *
> +btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_flag)

This does not need to be static inline, and please keep the type and
function name on the same line.

> +{
> +	struct btrfs_backref_iter *ret;
> +
> +	ret = kzalloc(sizeof(*ret), gfp_flag);
> +	if (!ret)
> +		return NULL;
> +
> +	ret->path = btrfs_alloc_path();
> +	if (!ret) {
> +		kfree(ret);
> +		return NULL;
> +	}
> +
> +	/* Current backref iterator only supports iteration in commit root */
> +	ret->path->search_commit_root = 1;
> +	ret->path->skip_locking = 1;
> +	ret->path->reada = READA_FORWARD;
> +	ret->fs_info = fs_info;
> +
> +	return ret;
> +}
