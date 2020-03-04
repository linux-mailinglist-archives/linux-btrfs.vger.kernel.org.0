Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D748317923F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgCDOY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 09:24:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:40256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDOY2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 09:24:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0EFDB310;
        Wed,  4 Mar 2020 14:24:24 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] btrfs: relocation: Remove the open-coded goto
 loop for breadth-first search
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-9-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <30ec7909-9ced-fb21-cf8e-1fa0c970d9a0@suse.com>
Date:   Wed, 4 Mar 2020 16:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302094553.58827-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.03.20 г. 11:45 ч., Qu Wenruo wrote:
> build_backref_tree() uses "goto again;" to implement a breadth-first
> search to build backref cache.
> 
> This patch will extract most of its work into a wrapper,
> handle_one_tree_block(), and use a while() loop to implement the same
> thing.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 167 +++++++++++++++++++++++-------------------
>  1 file changed, 91 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 67a4a61eb86a..26089694b3b5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -892,65 +892,21 @@ static int handle_one_tree_backref(struct reloc_control *rc,
>  	return ret;
>  }
>  
> -/*
> - * build backref tree for a given tree block. root of the backref tree
> - * corresponds the tree block, leaves of the backref tree correspond
> - * roots of b-trees that reference the tree block.
> - *
> - * the basic idea of this function is check backrefs of a given block
> - * to find upper level blocks that reference the block, and then check
> - * backrefs of these upper level blocks recursively. the recursion stop
> - * when tree root is reached or backrefs for the block is cached.
> - *
> - * NOTE: if we find backrefs for a block are cached, we know backrefs
> - * for all upper level blocks that directly/indirectly reference the
> - * block are also cached.
> - */
> -static noinline_for_stack
> -struct backref_node *build_backref_tree(struct reloc_control *rc,
> -					struct btrfs_key *node_key,
> -					int level, u64 bytenr)
> +static int handle_one_tree_block(struct reloc_control *rc,
> +				 struct list_head *useless_node,
> +				 struct list_head *pending_edge,
> +				 struct btrfs_path *path,
> +				 struct btrfs_backref_iter *iter,
> +				 struct btrfs_key *node_key,
> +				 struct backref_node *cur)
>  {
> -	struct btrfs_backref_iter *iter;
> -	struct backref_cache *cache = &rc->backref_cache;
> -	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
> -	struct backref_node *cur;
> -	struct backref_node *upper;
> -	struct backref_node *lower;
> -	struct backref_node *node = NULL;
> -	struct backref_node *exist = NULL;
>  	struct backref_edge *edge;
> -	struct rb_node *rb_node;
> -	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
> -	LIST_HEAD(useless);
> -	int cowonly;
> +	struct backref_node *exist;
>  	int ret;
> -	int err = 0;
> -
> -	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
> -	if (!iter)
> -		return ERR_PTR(-ENOMEM);
> -	path = btrfs_alloc_path();
> -	if (!path) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -	path->reada = READA_FORWARD;
> -
> -	node = alloc_backref_node(cache, bytenr, level);
> -	if (!node) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
>  
> -	node->lowest = 1;
> -	cur = node;
> -again:
>  	ret = btrfs_backref_iter_start(iter, cur->bytenr);
> -	if (ret < 0) {
> -		err = ret;
> -		goto out;
> -	}
> +	if (ret < 0)
> +		return ret;
>  
>  	/*
>  	 * We skip the first btrfs_tree_block_info, as we don't use the key
> @@ -958,13 +914,11 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  	 */
>  	if (btrfs_backref_has_tree_block_info(iter)) {
>  		ret = btrfs_backref_iter_next(iter);
> -		if (ret < 0) {
> -			err = ret;
> +		if (ret < 0)
>  			goto out;
> -		}
>  		/* No extra backref? This means the tree block is corrupted */
>  		if (ret > 0) {
> -			err = -EUCLEAN;
> +			ret = -EUCLEAN;
>  			goto out;
>  		}
>  	}
> @@ -984,7 +938,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  		 * check its backrefs
>  		 */
>  		if (!exist->checked)
> -			list_add_tail(&edge->list[UPPER], &list);
> +			list_add_tail(&edge->list[UPPER], pending_edge);
>  	} else {
>  		exist = NULL;
>  	}
> @@ -1006,7 +960,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			type = btrfs_get_extent_inline_ref_type(eb, iref,
>  							BTRFS_REF_TYPE_BLOCK);
>  			if (type == BTRFS_REF_TYPE_INVALID) {
> -				err = -EUCLEAN;
> +				ret = -EUCLEAN;
>  				goto out;
>  			}
>  			key.type = type;
> @@ -1029,29 +983,90 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
>  			continue;
>  		}
>  
> -		ret = handle_one_tree_backref(rc, &useless, &list, path, &key,
> -					      node_key, cur);
> -		if (ret < 0) {
> -			err = ret;
> +		ret = handle_one_tree_backref(rc, useless_node, pending_edge, path,
> +					      &key, node_key, cur);
> +		if (ret < 0)
>  			goto out;
> -		}
>  	}
> -	if (ret < 0) {
> -		err = ret;
> +	if (ret < 0)
>  		goto out;
> -	}
>  	ret = 0;
> -	btrfs_backref_iter_release(iter);
> -
>  	cur->checked = 1;
>  	WARN_ON(exist);
> +out:
> +	btrfs_backref_iter_release(iter);
> +	return ret;
> +}
>  
> -	/* the pending list isn't empty, take the first block to process */
> -	if (!list_empty(&list)) {
> -		edge = list_entry(list.next, struct backref_edge, list[UPPER]);
> -		list_del_init(&edge->list[UPPER]);
> -		cur = edge->node[UPPER];
> -		goto again;
> +/*
> + * build backref tree for a given tree block. root of the backref tree
> + * corresponds the tree block, leaves of the backref tree correspond
> + * roots of b-trees that reference the tree block.
> + *
> + * the basic idea of this function is check backrefs of a given block
> + * to find upper level blocks that reference the block, and then check
> + * backrefs of these upper level blocks recursively. the recursion stop
> + * when tree root is reached or backrefs for the block is cached.
> + *
> + * NOTE: if we find backrefs for a block are cached, we know backrefs
> + * for all upper level blocks that directly/indirectly reference the
> + * block are also cached.
> + */
> +static noinline_for_stack
> +struct backref_node *build_backref_tree(struct reloc_control *rc,
> +					struct btrfs_key *node_key,
> +					int level, u64 bytenr)
> +{
> +	struct btrfs_backref_iter *iter;
> +	struct backref_cache *cache = &rc->backref_cache;
> +	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */
> +	struct backref_node *cur;
> +	struct backref_node *upper;
> +	struct backref_node *lower;
> +	struct backref_node *node = NULL;
> +	struct backref_edge *edge;
> +	struct rb_node *rb_node;
> +	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked */
> +	LIST_HEAD(useless);
> +	int cowonly;
> +	int ret;
> +	int err = 0;
> +
> +	iter = btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS);
> +	if (!iter)
> +		return ERR_PTR(-ENOMEM);

This iterator can be made private to handle_one_tree_block as I don't see it being used outside of that function. 

> +	path = btrfs_alloc_path();
> +	if (!path) {
> +		err = -ENOMEM;
> +		goto out;
> +	}

Same thing with this path. Overall this will reduce the argument to handle_one_tree_block by 2.

> +	path->reada = READA_FORWARD;
> +
> +	node = alloc_backref_node(cache, bytenr, level);
> +	if (!node) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	node->lowest = 1;
> +	cur = node;
> +
> +	/* Breadth-first search to build backref cache */
> +	while (1) {
> +		ret = handle_one_tree_block(rc, &useless, &list, path, iter,
> +					    node_key, cur);
> +		if (ret < 0) {
> +			err = ret;
> +			goto out;
> +		}
> +		/* the pending list isn't empty, take the first block to process */
> +		if (!list_empty(&list)) {
> +			edge = list_entry(list.next, struct backref_edge, list[UPPER]);

Use list_first_entry_or_null or it would become: 

edge = list_first_entry_or_null();
if (edge) {
list_del_init(&edge->list[UPPER]);
cur = edge->node[UPPER]
} else {
breakl
}

or simply if (!edge)
break;

Also this loop can be rewritten as a do {} while() and it will look:

        /* Breadth-first search to build backref cache */                       
        do {                                                                    
                ret = handle_one_tree_block(rc, &useless, &list, path, iter,    
                                            node_key, cur);                     
                if (ret < 0) {                                                  
                        err = ret;                                              
                        goto out;                                               
                }                                                               
                edge = list_first_entry_or_null(&list, struct backref_edge,     
                                                list[UPPER]);                   
                /* the pending list isn't empty, take the first block to process */
                if (edge) {                                                     
                        list_del_init(&edge->list[UPPER]);                      
                        cur = edge->node[UPPER];                                
                }                                                               
        } while (edge)

IMO this is shorter than the original version and it's very expicit about it's terminating conditions:
a). handle_one_tree_block returns an error
b) list becomes empty. 

Alternatively list being empty is really a proxy for "is cur a valid inode". We know it's always
valid on the first iteration since it's passed form the caller, subsequent iterations assign cur 
to edge->node[UPPER] so it could even be 

while(cur) {} 

In my opinion reducing while(1) loops where it makes sense (as in this case) is preferable. 

NB: I've only compile-tested it. 

> +			list_del_init(&edge->list[UPPER]);
> +			cur = edge->node[UPPER];
> +		} else {
> +			break;
> +		}
>  	}
>  
>  	/*
> 
