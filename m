Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0C3FC667
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhHaLJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:09:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37010 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbhHaLJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:09:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 210072220C;
        Tue, 31 Aug 2021 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630408137;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GjRIWePieKeOqgPWk6hqO5U4bMFmVX8ppuRx4MJUyo=;
        b=HPc4iVEVOuelDukpuCvDzWBImwTpIa0g0icyoYzucOwBHf7eON9fKVbt8YJT/pS82l/uLK
        OuO3hUn80dSTUV0Cz4sZrJO5Bl0t3vWnZxp5bOqpApiVq3uRX8e7wB3Id+0T78Szak7kUu
        fZzDXslLoiqWp7biZWKFcyubmJRFlgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630408137;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GjRIWePieKeOqgPWk6hqO5U4bMFmVX8ppuRx4MJUyo=;
        b=BA/vpWbPJuf13e2+1umTJgUoH76yiFEyaJm4lbol8vHRFUhzWX+Dt7x+nt5sQmIT9ie+y1
        JM0z6SX5LtpjOlBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 19D29A3B95;
        Tue, 31 Aug 2021 11:08:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 636E0DA733; Tue, 31 Aug 2021 13:06:06 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:06:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 1/8] fs: btrfs: Introduce btrfs_for_each_slot
Message-ID: <20210831110606.GG3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-2-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826164054.14993-2-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 01:40:47PM -0300, Marcos Paulo de Souza wrote:
> There is a common pattern when search for a key in btrfs:
> 
>  * Call btrfs_search_slot
>  * Endless loop
>          * If the found slot is bigger than the current items in the leaf, check the
>            next one
>          * If still not found in the next leaf, return 1
>          * Do something with the code
>          * Increment current slot, and continue
> 
> This pattern can be improved by creating an iterator macro, similar to
> those for_each_X already existing in the linux kernel. Using this
> approach means to reduce significantly boilerplate code, along making it
> easier to newcomers to understand how to code works.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/ctree.c | 28 ++++++++++++++++++++++++++++
>  fs/btrfs/ctree.h | 25 +++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 84627cbd5b5b..b1aa6e3987d0 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2122,6 +2122,34 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  	return ret;
>  }
>  
> +/* Search for a valid slot for the given path.
> + * @root: The root node of the tree.
> + * @key: Will contain a valid item if found.
> + * @path: The start point to validate the slot.
> + *
> + * Return 0 if the item is valid, 1 if not found and < 0 if error.
> + */

Please fix the comment formatting like

/*
 * Search for a valid slot ...
 *
 * @root:  root node of the tre
 * @key:   ...
 *
 * Return 0 if ...
 */

> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,
> +		     struct btrfs_path *path)
> +{
> +	while (1) {
> +		int ret;
> +		const int slot = path->slots[0];
> +		const struct extent_buffer *leaf = path->nodes[0];
> +
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
> index f07c82fafa04..1e3c4a7741ca 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2912,6 +2912,31 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
>  int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  			   struct btrfs_path *path);
>  
> +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key *key,
> +		     struct btrfs_path *path);
> +
> +/* Search in @root for a given @key, and store the slot found in @found_key.
> + * @root: The root node of the tree.
> + * @key: The key we are looking for.
> + * @found_key: Will hold the found item.
> + * @path: Holds the current slot/leaf.
> + * @iter_ret: Contains the returned value from btrfs_search_slot and
> + *            btrfs_valid_slot, whatever is executed later.
> + *
> + * The iter_ret is an output variable that will contain the result of the
> + * btrfs_search_slot if it returns an error, or the value returned from
> + * btrfs_valid_slot otherwise. The return value can be 0 if the something was
> + * found, 1 if there weren't bigger leaves, and <0 if error.
> + */

Same.

> +#define btrfs_for_each_slot(root, key, found_key, path, iter_ret)		\
> +	for (iter_ret = btrfs_search_slot(NULL, root, key, path, 0, 0);		\
> +		(								\
> +			iter_ret >= 0 &&					\
> +			(iter_ret = btrfs_valid_slot(root, found_key, path)) == 0 \
> +		);								  \

The innter ( ) and indentation is redundant and looks confusing, like
it's another statement block.

> +		path->slots[0]++						  \
> +	)
> +
>  static inline int btrfs_next_old_item(struct btrfs_root *root,
>  				      struct btrfs_path *p, u64 time_seq)
>  {
> -- 
> 2.31.1
