Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5EA3FB753
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhH3NyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:54:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhH3NyH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:54:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4464C22161;
        Mon, 30 Aug 2021 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630331592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeYPEL+rQudNW2iLkG8c4k3xUxDaYKoBl6MMiRB1XBQ=;
        b=FZ1Xvar/AqNwky8at6eaEq/bI8OKlPN/w2bS2DW+Gkos16+1n1bEcrJA5xBRFKvJj/DHb9
        ML36QRFUbv+isUbwzK4+tOV2uqr6FfCXGJIMRpPY+QmizM+qG5Gb8FF1tMxQ7Ex0bkZqG6
        vRKcrJJtdSrUO5mTBVv0K6utDWwALXU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 117C313982;
        Mon, 30 Aug 2021 13:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id SEWkAcjiLGHSegAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 13:53:12 +0000
Subject: Re: [PATCH 6/8] btrfs: send: Use btrfs_for_each_slot macro
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-7-mpdesouza@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7cdf951f-7ecc-8946-5c2a-0036457e70ac@suse.com>
Date:   Mon, 30 Aug 2021 16:53:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826164054.14993-7-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.21 г. 19:40, Marcos Paulo de Souza wrote:
> This makes the code much simpler and smaller.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/send.c | 222 +++++++++++++-----------------------------------
>  1 file changed, 59 insertions(+), 163 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index afdcbe7844e0..3e32886e171e 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -2647,6 +2647,7 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
>   */
>  static int did_create_dir(struct send_ctx *sctx, u64 dir)
>  {
> +	int iter_ret;
>  	int ret = 0;
>  	struct btrfs_path *path = NULL;
>  	struct btrfs_key key;
> @@ -2654,43 +2655,23 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
>  	struct btrfs_key di_key;
>  	struct extent_buffer *eb;
>  	struct btrfs_dir_item *di;
> -	int slot;
>  
>  	path = alloc_path_for_send();
> -	if (!path) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!path)
> +		return -ENOMEM;
>  

This is irrelevant changes, albeit it's good. But please refrain from
mixing unrelated changes as it makes review a bit harder.

>  	key.objectid = dir;
>  	key.type = BTRFS_DIR_INDEX_KEY;
>  	key.offset = 0;
> -	ret = btrfs_search_slot(NULL, sctx->send_root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto out;
> -
> -	while (1) {
> -		eb = path->nodes[0];
> -		slot = path->slots[0];

In the original code we take the node/slot in 2 local variables for
convenience.
> -		if (slot >= btrfs_header_nritems(eb)) {
> -			ret = btrfs_next_leaf(sctx->send_root, path);
> -			if (ret < 0) {
> -				goto out;
> -			} else if (ret > 0) {
> -				ret = 0;
> -				break;
> -			}
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(eb, &found_key, slot);
> +	btrfs_for_each_slot(sctx->send_root, &key, &found_key, path, iter_ret) {
>  		if (found_key.objectid != key.objectid ||
>  		    found_key.type != key.type) {

nit: The way the checks for termination are performed are somwhat
inconsistent. Here the original key is not touched hence its
.object/.type can be used when checking whether the found key is
appropriate, but in btrfs_unlink_all_paths you use 'key' as both an
input and an output and for the terminating condition you refer to the
original vales that the search key was set to. I don't have an opinion
which is better but I'd rather have a single style in the file.

>  			ret = 0;
>  			goto out;
>  		}
>  
> -		di = btrfs_item_ptr(eb, slot, struct btrfs_dir_item);
> +		eb = path->nodes[0];
> +		di = btrfs_item_ptr(eb, path->slots[0], struct btrfs_dir_item);

nit: In the refactored code you eliminated the 'slot' variable but
retained the eb. This seems to be a rather arbitrary choice. While not
wrong technically, it adds unnecessary diff hunks, which again make
review more involved that it could have been. What's more, in this
particular function actually retaining the 'eb' and 'slot definition and
making them local to the btrfs_for_each_slot loop would have resulted in
somewhat better code (albeit this might be subjective):

https://pastebin.com/avye4wZe

No need to resend but just something to keep in mind for future patches.


>  		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
>  
>  		if (di_key.type != BTRFS_ROOT_ITEM_KEY &&

<snip>

> @@ -4864,39 +4816,18 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
>  	key.objectid = sctx->cmp_key->objectid;
>  	key.type = BTRFS_XATTR_ITEM_KEY;
>  	key.offset = 0;
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto out;
> -
> -	while (1) {
> -		eb = path->nodes[0];
> -		slot = path->slots[0];
> -		if (slot >= btrfs_header_nritems(eb)) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0) {
> -				goto out;
> -			} else if (ret > 0) {
> -				ret = 0;
> -				break;
> -			}
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(eb, &found_key, slot);
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
>  		if (found_key.objectid != key.objectid ||
> -		    found_key.type != key.type) {
> -			ret = 0;

nit: You've removed this 'ret = 0', however AFAICS this is ok, because
iterate_dir_item returns either 0 or a negative error code so we can't
return from btrfs_for_each_slot with ret set to anything other than an
error code or 0.

> -			goto out;
> -		}
> +		    found_key.type != key.type)
> +			break;
>  
>  		ret = iterate_dir_item(root, path, __process_new_xattr, sctx);
>  		if (ret < 0)
> -			goto out;
> -
> -		path->slots[0]++;
> +			break;
>  	}
> +	if (iter_ret < 0)
> +		ret = iter_ret;
>  
> -out:
>  	btrfs_free_path(path);
>  	return ret;
>  }

<snip>

> @@ -5954,40 +5884,19 @@ static int process_all_extents(struct send_ctx *sctx)
>  	key.objectid = sctx->cmp_key->objectid;
>  	key.type = BTRFS_EXTENT_DATA_KEY;
>  	key.offset = 0;
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto out;
> -
> -	while (1) {
> -		eb = path->nodes[0];
> -		slot = path->slots[0];
> -
> -		if (slot >= btrfs_header_nritems(eb)) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0) {
> -				goto out;
> -			} else if (ret > 0) {
> -				ret = 0;
> -				break;
> -			}
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(eb, &found_key, slot);
> -
> +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
>  		if (found_key.objectid != key.objectid ||
> -		    found_key.type != key.type) {
> -			ret = 0;

However, here I think this is significant because process_extent can
return 1 via
process_extent
 find_extent_clone
   send_write_or_clone
     clone_range
      while (true) loop and the items are exhausted, we break with ret = 1


> +		    found_key.type != key.type)
>  			goto out;
> -		}
>  
>  		ret = process_extent(sctx, path, &found_key);
>  		if (ret < 0)
>  			goto out;
> -
> -		path->slots[0]++;
>  	}
>  
> +	if (iter_ret < 0)
> +		ret = iter_ret;
> +
>  out:
>  	btrfs_free_path(path);
>  	return ret;
> @@ -6180,36 +6089,20 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
>  	struct btrfs_path *path;
>  	struct btrfs_key key;
>  	struct parent_paths_ctx ctx;
> -	int ret;
> +	int iter_ret;
> +	int ret = 0;
>  
>  	path = alloc_path_for_send();
>  	if (!path)
>  		return -ENOMEM;
>  
> -	key.objectid = sctx->cur_ino;
> -	key.type = BTRFS_INODE_REF_KEY;
> -	key.offset = 0;
> -	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto out;
> -
>  	ctx.refs = &deleted_refs;
>  	ctx.sctx = sctx;
>  
> -	while (true) {
> -		struct extent_buffer *eb = path->nodes[0];
> -		int slot = path->slots[0];
> -
> -		if (slot >= btrfs_header_nritems(eb)) {
> -			ret = btrfs_next_leaf(sctx->parent_root, path);
> -			if (ret < 0)
> -				goto out;
> -			else if (ret > 0)
> -				break;
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(eb, &key, slot);
> +	key.objectid = sctx->cur_ino;
> +	key.type = BTRFS_INODE_REF_KEY;
> +	key.offset = 0;

Those 3 lines are moved needlessly after the 2 ctx assignments which
serve no purpose other than to increase the diff.

> +	btrfs_for_each_slot(sctx->parent_root, &key, &key, path, iter_ret) {
>  		if (key.objectid != sctx->cur_ino)
>  			break;
>  		if (key.type != BTRFS_INODE_REF_KEY &&
> @@ -6220,8 +6113,11 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
>  					record_parent_ref, &ctx);
>  		if (ret < 0)
>  			goto out;
> +	}
>  
> -		path->slots[0]++;
> +	if (iter_ret < 0) {
> +		ret = iter_ret;
> +		goto out;
>  	}
>  
>  	while (!list_empty(&deleted_refs)) {
> 
