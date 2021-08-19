Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB63F1991
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhHSMi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:38:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhHSMiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:38:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19B7522096;
        Thu, 19 Aug 2021 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629376668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSlXr+kVUXvjB7HSDOXX1qtzSUYJxkxISvnyI5CVinE=;
        b=EPr3R/Sem/ipo1tK+fCIfOV7hwsTyDvblG586ip6GHaI8Yd98SteM8y2ehFdja9SWc09NX
        KmbwiO7mAiznM20jlXQvhuXt0vEww9SpX9k6JUNbCofbE6+Cx1pV9pqKrrRfREyobyrp0a
        v00KLEArzxJhZ01xNE8699hn4OXBh/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629376668;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSlXr+kVUXvjB7HSDOXX1qtzSUYJxkxISvnyI5CVinE=;
        b=N+yZ7Zlloerdc6H4/wwdLEyEYkkQsJn/mXiz5+/aqVCzuQnplmXv6H6xaCdUf2oCCkzRgx
        6HFpCXHJdp5WLyDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 83611A3B9E;
        Thu, 19 Aug 2021 12:37:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0A3DDA72C; Thu, 19 Aug 2021 14:34:50 +0200 (CEST)
Date:   Thu, 19 Aug 2021 14:34:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210819123450.GF5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210802125738.22588-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802125738.22588-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 02, 2021 at 09:57:38AM -0300, Marcos Paulo de Souza wrote:
> There is a common pattern when search for a key in btrfs:
> 
>  * Call btrfs_search_slot
>  * Endless loop
> 	 * If the found slot is bigger than the current items in the leaf, check the
> 	   next one
> 	 * If still not found in the next leaf, return 1
> 	 * Do something with the code
> 	 * Increment current slot, and continue
> 
> This pattern can be improved by creating an iterator macro, similar to
> those for_each_X already existing in the linux kernel. using this
> approach means to reduce significantly boilerplate code, along making it
> easier to newcomers to understand how to code works.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> 
>  I've being testing this approach in the last few weeks, and using this macro
>  all over the btrfs codebase, and not issues found yet. This is just a RFC
>  showing how the xattr code would benefit using the macro.
> 
>  The only part that I didn't like was using the ret variable as a macro
>  argument, but I couldn't find a better way to do it...

The extra variable for ret is acceptable but it must be a separate from
the one that can be used inside the loop, otherwise the value could get
overwritten and affect the for loop. Ie. you'd have give an extra one
jsut for the loop and then it also deserves a proper documentation of
the whole btrfs_for_each_slot macro.

>  fs/btrfs/ctree.c | 23 +++++++++++++++++++++++
>  fs/btrfs/ctree.h | 12 ++++++++++++
>  fs/btrfs/xattr.c | 37 +++++++++----------------------------
>  3 files changed, 44 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4f8d8fa1e085..a49b256d78f7 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2123,6 +2123,29 @@ int btrfs_search_backwards(struct btrfs_root *root,
>  	return ret;
>  }
>  
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,
> +		     struct btrfs_path *path)

Interface function should be documented and parameters should be const
where applicable.

> +{
> +	struct extent_buffer *leaf;
> +	int slot;
> +	int ret;
> +
> +	while (1) {
> +		slot = path->slots[0];
> +		leaf = path->nodes[0];

The variables should be defined in the inner-most scope

> +		if (slot >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(root, path);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		btrfs_item_key_to_cpu(leaf, key, slot);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * adjust the pointers going up the tree, starting at level
>   * making sure the right key of each node is points to 'key'.
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0a971e98f5f9..cff2a94700b2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2912,6 +2912,18 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
>  int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  			   struct btrfs_path *path);
>  
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *f,

The parameter names don't match the definition, especially 'f' is a
misnomer and a single letter.

> +		     struct btrfs_path *path);
> +
> +#define btrfs_for_each_slot(root, key, found_key, path, ret)		\
> +	for (ret = btrfs_search_slot(NULL, root, key, path, 0, 0);		\
> +		({								\
> +			ret >= 0 &&						\
> +			(ret = btrfs_valid_slot(root, found_key, path)) == 0;	\
> +		});								\
> +		path->slots[0]++						\
> +	)
> +
>  static inline int btrfs_next_old_item(struct btrfs_root *root,
>  				      struct btrfs_path *p, u64 time_seq)
>  {
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 8a4514283a4b..0562a17ff3b1 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -274,6 +274,7 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
>  ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  {
>  	struct btrfs_key key;
> +	struct btrfs_key found_key;
>  	struct inode *inode = d_inode(dentry);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct btrfs_path *path;
> @@ -295,44 +296,22 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  	path->reada = READA_FORWARD;
>  
>  	/* search for our xattrs */
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -	if (ret < 0)
> -		goto err;
> -
> -	while (1) {
> +	btrfs_for_each_slot(root, &key, &found_key, path, ret) {
>  		struct extent_buffer *leaf;
>  		int slot;
>  		struct btrfs_dir_item *di;
> -		struct btrfs_key found_key;
>  		u32 item_size;
>  		u32 cur;
>  
>  		leaf = path->nodes[0];
>  		slot = path->slots[0];
>  
> -		/* this is where we start walking through the path */
> -		if (slot >= btrfs_header_nritems(leaf)) {
> -			/*
> -			 * if we've reached the last slot in this leaf we need
> -			 * to go to the next leaf and reset everything
> -			 */
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0)
> -				goto err;
> -			else if (ret > 0)
> -				break;
> -			continue;
> -		}
> -
> -		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> -
>  		/* check to make sure this item is what we want */
> -		if (found_key.objectid != key.objectid)
> -			break;
> -		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
> +		if (found_key.objectid != key.objectid ||
> +		    found_key.type > BTRFS_XATTR_ITEM_KEY)
>  			break;
>  		if (found_key.type < BTRFS_XATTR_ITEM_KEY)
> -			goto next_item;
> +			continue;
>  
>  		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
>  		item_size = btrfs_item_size_nr(leaf, slot);
> @@ -365,9 +344,11 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
>  			cur += this_len;
>  			di = (struct btrfs_dir_item *)((char *)di + this_len);
>  		}
> -next_item:
> -		path->slots[0]++;
>  	}
> +
> +	if (ret < 0)
> +		goto err;
> +
>  	ret = total_size;
>  
>  err:
> -- 
> 2.26.2
