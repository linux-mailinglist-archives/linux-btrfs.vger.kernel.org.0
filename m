Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6954C15D494
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgBNJTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:19:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:38530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgBNJTv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:19:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C135BB1A8;
        Fri, 14 Feb 2020 09:19:48 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iterator
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <689800fa-ae4a-e2fc-b699-92e969d0e389@suse.com>
Date:   Fri, 14 Feb 2020 11:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214081354.56605-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.02.20 г. 10:13 ч., Qu Wenruo wrote:
> Due to the complex nature of btrfs extent tree, when we want to iterate
> all backrefs of one extent, it involves quite a lot of works, like
> search the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed
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
> The idea of btrfs_backref_iterator is to avoid such complex and hard to
> read code structure, but something like the following:
> 
>   iterator = btrfs_backref_iterator_alloc();
>   ret = btrfs_backref_iterator_start(iterator, bytenr);
>   if (ret < 0)
> 	goto out;
>   for (; ; ret = btrfs_backref_iterator_next(iterator)) {
> 	/* REAL WORK HERE */
>   }
>   out:
>   btrfs_backref_iterator_free(iterator);
> 
> This patch is just the skeleton + btrfs_backref_iterator_start() code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/backref.c | 58 +++++++++++++++++++++++++++++++++++
>  fs/btrfs/backref.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e5d85311d5d5..73c4829609c9 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2252,3 +2252,61 @@ void free_ipath(struct inode_fs_paths *ipath)
>  	kvfree(ipath->fspath);
>  	kfree(ipath);
>  }
> +
> +int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
> +				 u64 bytenr)
> +{
> +	struct btrfs_fs_info *fs_info = iterator->fs_info;
> +	struct btrfs_path *path = iterator->path;
> +	struct btrfs_extent_item *ei;
> +	struct btrfs_key key;
> +	int ret;
> +
> +	key.objectid = bytenr;
> +	key.type = BTRFS_METADATA_ITEM_KEY;
> +	key.offset = (u64)-1;
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
> +	memcpy(&iterator->cur_key, &key, sizeof(key));
> +	iterator->end_ptr = btrfs_item_end_nr(path->nodes[0], path->slots[0]);
> +	iterator->item_ptr = btrfs_item_ptr_offset(path->nodes[0],
> +						   path->slots[0]);
> +	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
> +			    struct btrfs_extent_item);
> +
> +	/* Only support iteration on tree backref yet */
> +	if (btrfs_extent_flags(path->nodes[0], ei) & BTRFS_EXTENT_FLAG_DATA) {
> +		ret = -ENOTTY;
> +		goto release;
> +	}

Isn't this implied bye the fact you are searching for METADATA ITEMS to
begin with ? Considering this shouldn't detecting EXTENT_FLAG_DATA in
the backrefs of a METADATA_EXTENT be considered a corruption?

> +	iterator->cur_ptr = iterator->item_ptr + sizeof(*ei);
> +	return 0;
> +release:
> +	iterator->end_ptr = 0;
> +	iterator->cur_ptr = 0;
> +	iterator->item_ptr = 0;
> +	iterator->cur_key.objectid = 0;
> +	iterator->cur_key.type = 0;
> +	iterator->cur_key.offset = 0;
> +	btrfs_release_path(path);
> +	return ret;
> +}
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 777f61dc081e..b53301f2147f 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -74,4 +74,80 @@ struct prelim_ref {
>  	u64 wanted_disk_byte;
>  };
>  
> +/*
> + * Helper structure to help iterate backrefs of one extent.
> + *
> + * Now it only supports iteration for tree block in commit root.
> + */
> +struct btrfs_backref_iterator {
> +	u64 bytenr;
> +	struct btrfs_path *path;
> +	struct btrfs_fs_info *fs_info;
> +	struct btrfs_key cur_key;
> +	unsigned long item_ptr;
> +	unsigned long cur_ptr;
> +	unsigned long end_ptr;
> +};
> +
> +static inline struct btrfs_backref_iterator *
> +btrfs_backref_iterator_alloc(struct btrfs_fs_info *fs_info, gfp_t gfp_flag)
> +{
> +	struct btrfs_backref_iterator *ret;
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
> +
> +static inline void btrfs_backref_iterator_free(
> +		struct btrfs_backref_iterator *iterator)
> +{
> +	if (!iterator)
> +		return;
> +	btrfs_free_path(iterator->path);
> +	kfree(iterator);
> +}
> +
> +static inline struct extent_buffer *
> +btrfs_backref_get_eb(struct btrfs_backref_iterator *iterator)
> +{
> +	if (!iterator)
> +		return NULL;
> +	return iterator->path->nodes[0];
> +}
> +
> +/*
> + * For metadata with EXTENT_ITEM key (non-skinny) case, the first inline data
> + * is btrfs_tree_block_info, without a btrfs_extent_inline_ref header.
> + *
> + * This helper is here to determine if that's the case.
> + */
> +static inline bool btrfs_backref_has_tree_block_info(
> +		struct btrfs_backref_iterator *iterator)
> +{
> +	if (iterator->cur_key.type == BTRFS_EXTENT_ITEM_KEY &&
> +	    iterator->cur_ptr - iterator->item_ptr ==
> +	    sizeof(struct btrfs_extent_item))
> +		return true;
> +	return false;
> +}
> +
> +int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
> +				 u64 bytenr);
> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator);
> +
>  #endif
> 
