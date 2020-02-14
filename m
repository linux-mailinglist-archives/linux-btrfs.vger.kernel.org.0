Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2929E15D4B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBNJ3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:29:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgBNJ3R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:29:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7BF14ACC6;
        Fri, 14 Feb 2020 09:29:14 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] btrfs: relocation: Use btrfs_backref_iterator
 infrastructure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-4-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c3ba99d8-1de1-2507-dfcd-6ab11950a873@suse.com>
Date:   Fri, 14 Feb 2020 11:29:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214081354.56605-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.02.20 г. 10:13 ч., Qu Wenruo wrote:
> In the core function of relocation, build_backref_tree, it needs to
> iterate all backref items of one tree block.
> 
> We don't really want to spend our code and reviewers' time to going
> through tons of supportive code just for the backref walk.
> 
> Use btrfs_backref_iterator infrastructure to do the loop.
> 
> The backref items look would be much more easier to read:
> 
> 	ret = btrfs_backref_iterator_start(iterator, cur->bytenr);
> 	for (; ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
> 		/* The really important work */
> 	}
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/backref.h    |  20 +++++
>  fs/btrfs/relocation.c | 193 ++++++++++++++----------------------------
>  2 files changed, 82 insertions(+), 131 deletions(-)
> 
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index b53301f2147f..016999339be1 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -150,4 +150,24 @@ int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
>  				 u64 bytenr);
>  int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator);
>  
> +static inline bool
> +btrfs_backref_iterator_is_inline_ref(struct btrfs_backref_iterator *iterator)
> +{
> +	if (iterator->cur_key.type == BTRFS_EXTENT_ITEM_KEY ||
> +	    iterator->cur_key.type == BTRFS_METADATA_ITEM_KEY)
> +		return true;
> +	return false;
> +}

This function could be used in btrfs_backref_iterator_next where you
have the exact same check.

> +
> +static inline void
> +btrfs_backref_iterator_release(struct btrfs_backref_iterator *iterator)
> +{
> +	iterator->bytenr = 0;
> +	iterator->item_ptr = 0;
> +	iterator->cur_ptr = 0;
> +	iterator->end_ptr = 0;
> +	btrfs_release_path(iterator->path);
> +	memset(&iterator->cur_key, 0, sizeof(iterator->cur_key));
> +}

Can't this function also be used in the release: label of
btrfs_backref_iterator_start

Considering this, I think those 2 utility functions should really be
introduced in the respective patch where they can be used. E.g.
btrfs_backref_iterator_is_inline_ref in Patch 2 and
btrfs_backref_iterator_release in patch 1.

> +
>  #endif
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b1365a516a25..21e4482c8232 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -22,6 +22,7 @@
>  #include "print-tree.h"
>  #include "delalloc-space.h"
>  #include "block-group.h"
> +#include "backref.h"
>  
>  /*
>   * backref_node, mapping_node and tree_block start with this
> @@ -604,48 +605,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
>  	return btrfs_get_fs_root(fs_info, &key, false);
>  }
>  
> -static noinline_for_stack
> -int find_inline_backref(struct extent_buffer *leaf, int slot,
> -			unsigned long *ptr, unsigned long *end)
> -{
> -	struct btrfs_key key;
> -	struct btrfs_extent_item *ei;
> -	struct btrfs_tree_block_info *bi;
> -	u32 item_size;
> -
> -	btrfs_item_key_to_cpu(leaf, &key, slot);
> -
> -	item_size = btrfs_item_size_nr(leaf, slot);
> -	if (item_size < sizeof(*ei)) {
> -		btrfs_print_v0_err(leaf->fs_info);
> -		btrfs_handle_fs_error(leaf->fs_info, -EINVAL, NULL);
> -		return 1;
> -	}
> -	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
> -	WARN_ON(!(btrfs_extent_flags(leaf, ei) &
> -		  BTRFS_EXTENT_FLAG_TREE_BLOCK));
> -
> -	if (key.type == BTRFS_EXTENT_ITEM_KEY &&
> -	    item_size <= sizeof(*ei) + sizeof(*bi)) {
> -		WARN_ON(item_size < sizeof(*ei) + sizeof(*bi));
> -		return 1;
> -	}
> -	if (key.type == BTRFS_METADATA_ITEM_KEY &&
> -	    item_size <= sizeof(*ei)) {
> -		WARN_ON(item_size < sizeof(*ei));
> -		return 1;
> -	}
> -
> -	if (key.type == BTRFS_EXTENT_ITEM_KEY) {
> -		bi = (struct btrfs_tree_block_info *)(ei + 1);
> -		*ptr = (unsigned long)(bi + 1);
> -	} else {
> -		*ptr = (unsigned long)(ei + 1);
> -	}
> -	*end = (unsigned long)ei + item_size;
> -	return 0;
> -}
> -
>  /*
>   * build backref tree for a given tree block. root of the backref tree
>   * corresponds the tree block, leaves of the backref tree correspond
> @@ -665,10 +624,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  					struct btrfs_key *node_key,
>  					int level, u64 bytenr)
>  {
> +	struct btrfs_backref_iterator *iterator;
>  	struct backref_cache *cache = &rc->backref_cache;
> -	struct btrfs_path *path1; /* For searching extent root */
> -	struct btrfs_path *path2; /* For searching parent of TREE_BLOCK_REF */
> -	struct extent_buffer *eb;
> +	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
>  	struct btrfs_root *root;
>  	struct backref_node *cur;
>  	struct backref_node *upper;
> @@ -677,9 +635,6 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  	struct backref_node *exist = NULL;
>  	struct backref_edge *edge;
>  	struct rb_node *rb_node;
> -	struct btrfs_key key;
> -	unsigned long end;
> -	unsigned long ptr;
>  	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
>  	LIST_HEAD(useless);
>  	int cowonly;
> @@ -687,14 +642,14 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  	int err = 0;
>  	bool need_check = true;
>  
> -	path1 = btrfs_alloc_path();
> -	path2 = btrfs_alloc_path();
> -	if (!path1 || !path2) {
> +	iterator = btrfs_backref_iterator_alloc(rc->extent_root->fs_info,
> +						GFP_NOFS);
> +	path = btrfs_alloc_path();
> +	if (!path) {
>  		err = -ENOMEM;
>  		goto out;
>  	}
> -	path1->reada = READA_FORWARD;
> -	path2->reada = READA_FORWARD;
> +	path->reada = READA_FORWARD;
>  
>  	node = alloc_backref_node(cache);
>  	if (!node) {
> @@ -707,25 +662,28 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  	node->lowest = 1;
>  	cur = node;
>  again:
> -	end = 0;
> -	ptr = 0;
> -	key.objectid = cur->bytenr;
> -	key.type = BTRFS_METADATA_ITEM_KEY;
> -	key.offset = (u64)-1;
> -
> -	path1->search_commit_root = 1;
> -	path1->skip_locking = 1;
> -	ret = btrfs_search_slot(NULL, rc->extent_root, &key, path1,
> -				0, 0);
> +	ret = btrfs_backref_iterator_start(iterator, cur->bytenr);
>  	if (ret < 0) {
>  		err = ret;
>  		goto out;
>  	}
> -	ASSERT(ret);
> -	ASSERT(path1->slots[0]);
> -
> -	path1->slots[0]--;
>  
> +	/*
> +	 * We skip the first btrfs_tree_block_info, as we don't use the key
> +	 * stored in it, but fetch it from the tree block.
> +	 */
> +	if (btrfs_backref_has_tree_block_info(iterator)) {
> +		ret = btrfs_backref_iterator_next(iterator);
> +		if (ret < 0) {
> +			err = ret;
> +			goto out;
> +		}
> +		/* No extra backref? This means the tree block is corrupted */
> +		if (ret > 0) {
> +			err = -EUCLEAN;
> +			goto out;
> +		}
> +	}
>  	WARN_ON(cur->checked);
>  	if (!list_empty(&cur->upper)) {
>  		/*
> @@ -747,42 +705,21 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  		exist = NULL;
>  	}
>  
> -	while (1) {
> -		cond_resched();
> -		eb = path1->nodes[0];
> -
> -		if (ptr >= end) {
> -			if (path1->slots[0] >= btrfs_header_nritems(eb)) {
> -				ret = btrfs_next_leaf(rc->extent_root, path1);
> -				if (ret < 0) {
> -					err = ret;
> -					goto out;
> -				}
> -				if (ret > 0)
> -					break;
> -				eb = path1->nodes[0];
> -			}
> +	for (; ret == 0; ret = btrfs_backref_iterator_next(iterator)) {
> +		struct extent_buffer *eb;
> +		struct btrfs_key key;
> +		int type;
>  
> -			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
> -			if (key.objectid != cur->bytenr) {
> -				WARN_ON(exist);
> -				break;
> -			}
> +		cond_resched();
> +		eb = btrfs_backref_get_eb(iterator);
>  
> -			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
> -			    key.type == BTRFS_METADATA_ITEM_KEY) {
> -				ret = find_inline_backref(eb, path1->slots[0],
> -							  &ptr, &end);
> -				if (ret)
> -					goto next;
> -			}
> -		}
> +		key.objectid = iterator->bytenr;
> +		if (btrfs_backref_iterator_is_inline_ref(iterator)) {
> +			struct btrfs_extent_inline_ref *iref;
>  
> -		if (ptr < end) {
>  			/* update key for inline back ref */
> -			struct btrfs_extent_inline_ref *iref;
> -			int type;
> -			iref = (struct btrfs_extent_inline_ref *)ptr;
> +			iref = (struct btrfs_extent_inline_ref *)
> +				iterator->cur_ptr;
>  			type = btrfs_get_extent_inline_ref_type(eb, iref,
>  							BTRFS_REF_TYPE_BLOCK);
>  			if (type == BTRFS_REF_TYPE_INVALID) {
> @@ -791,9 +728,9 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			}
>  			key.type = type;
>  			key.offset = btrfs_extent_inline_ref_offset(eb, iref);
> -
> -			WARN_ON(key.type != BTRFS_TREE_BLOCK_REF_KEY &&
> -				key.type != BTRFS_SHARED_BLOCK_REF_KEY);
> +		} else {
> +			key.type = iterator->cur_key.type;
> +			key.offset = iterator->cur_key.offset;
>  		}
>  
>  		/*
> @@ -806,7 +743,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  		     (key.type == BTRFS_SHARED_BLOCK_REF_KEY &&
>  		      exist->bytenr == key.offset))) {
>  			exist = NULL;
> -			goto next;
> +			continue;
>  		}
>  
>  		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
> @@ -852,7 +789,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			edge->node[LOWER] = cur;
>  			edge->node[UPPER] = upper;
>  
> -			goto next;
> +			continue;
>  		} else if (unlikely(key.type == BTRFS_EXTENT_REF_V0_KEY)) {
>  			err = -EINVAL;
>  			btrfs_print_v0_err(rc->extent_root->fs_info);
> @@ -860,7 +797,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  					      NULL);
>  			goto out;
>  		} else if (key.type != BTRFS_TREE_BLOCK_REF_KEY) {
> -			goto next;
> +			continue;
>  		}
>  
>  		/*
> @@ -891,20 +828,20 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  		level = cur->level + 1;
>  
>  		/* Search the tree to find parent blocks referring the block. */
> -		path2->search_commit_root = 1;
> -		path2->skip_locking = 1;
> -		path2->lowest_level = level;
> -		ret = btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
> -		path2->lowest_level = 0;
> +		path->search_commit_root = 1;
> +		path->skip_locking = 1;
> +		path->lowest_level = level;
> +		ret = btrfs_search_slot(NULL, root, node_key, path, 0, 0);
> +		path->lowest_level = 0;
>  		if (ret < 0) {
>  			err = ret;
>  			goto out;
>  		}
> -		if (ret > 0 && path2->slots[level] > 0)
> -			path2->slots[level]--;
> +		if (ret > 0 && path->slots[level] > 0)
> +			path->slots[level]--;
>  
> -		eb = path2->nodes[level];
> -		if (btrfs_node_blockptr(eb, path2->slots[level]) !=
> +		eb = path->nodes[level];
> +		if (btrfs_node_blockptr(eb, path->slots[level]) !=
>  		    cur->bytenr) {
>  			btrfs_err(root->fs_info,
>  	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu %u %llu)",
> @@ -920,7 +857,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  
>  		/* Add all nodes and edges in the path */
>  		for (; level < BTRFS_MAX_LEVEL; level++) {
> -			if (!path2->nodes[level]) {
> +			if (!path->nodes[level]) {
>  				ASSERT(btrfs_root_bytenr(&root->root_item) ==
>  				       lower->bytenr);
>  				if (should_ignore_root(root))
> @@ -936,7 +873,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  				goto out;
>  			}
>  
> -			eb = path2->nodes[level];
> +			eb = path->nodes[level];
>  			rb_node = tree_search(&cache->rb_root, eb->start);
>  			if (!rb_node) {
>  				upper = alloc_backref_node(cache);
> @@ -993,20 +930,14 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			lower = upper;
>  			upper = NULL;
>  		}
> -		btrfs_release_path(path2);
> -next:
> -		if (ptr < end) {
> -			ptr += btrfs_extent_inline_ref_size(key.type);
> -			if (ptr >= end) {
> -				WARN_ON(ptr > end);
> -				ptr = 0;
> -				end = 0;
> -			}
> -		}
> -		if (ptr >= end)
> -			path1->slots[0]++;
> +		btrfs_release_path(path);
> +	}
> +	if (ret < 0) {
> +		err = ret;
> +		goto out;
>  	}
> -	btrfs_release_path(path1);
> +	ret = 0;
> +	btrfs_backref_iterator_release(iterator);
>  
>  	cur->checked = 1;
>  	WARN_ON(exist);
> @@ -1124,8 +1055,8 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  		}
>  	}
>  out:
> -	btrfs_free_path(path1);
> -	btrfs_free_path(path2);
> +	btrfs_backref_iterator_free(iterator);
> +	btrfs_free_path(path);
>  	if (err) {
>  		while (!list_empty(&useless)) {
>  			lower = list_entry(useless.next,
> 
