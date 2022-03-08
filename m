Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8014D1AA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbiCHOgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 09:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiCHOgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 09:36:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF54BB99
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 06:35:22 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3EAB7210EF;
        Tue,  8 Mar 2022 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646750121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM0sU9QLUWYsWg9WE7UFGxX4tQZaPJ2aOPYyKrTgOx4=;
        b=HYNdFZYMQQPLx1bypQ56L6Y0yHf8hj43lnB7AtOXuyqaDT6ToJKx+u10GSRg+Y2jtdwy2c
        NWA2yowu6NooaREXEO1zV+0ld3LaGMPWUFFEKaZyDhYUNuzhM0U4i5oP+yxbWpeEF+a4bt
        IBClI2l8GCdx1Jd5M3BHrTKrqPO8lvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646750121;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM0sU9QLUWYsWg9WE7UFGxX4tQZaPJ2aOPYyKrTgOx4=;
        b=jPGEkMHEVHjxyq3DmzjqpBKj4YeSIvS2MSltosC0bft+z7+QAHVjLmvKppcLKVE2+O/T9U
        T7n6Tdj+VAbkLdCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 36784A3B88;
        Tue,  8 Mar 2022 14:35:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2D519DA823; Tue,  8 Mar 2022 15:31:26 +0100 (CET)
Date:   Tue, 8 Mar 2022 15:31:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v3 01/14] btrfs: Introduce btrfs_for_each_slot iterator
 macro
Message-ID: <20220308143126.GL12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20220302164829.17524-1-gniebler@suse.com>
 <20220302164829.17524-2-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302164829.17524-2-gniebler@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 05:48:16PM +0100, Gabriel Niebler wrote:
> There is a common pattern when searching for a key in btrfs:
> 
> * Call btrfs_search_slot to find the slot for the key
> * Enter an endless loop:
> 	* If the found slot is larger than the no. of items in the current leaf,
> 	  check the next leaf
> 	* If it's still not found in the next leaf, terminate the loop
> 	* Otherwise do something with the found key
> 	* Increment the current slot and continue
> 
> To reduce code duplication, we can replace this code pattern with an iterator
> macro, similar to the existing for_each_X macros found elsewhere in the kernel.
> This also makes the code easier to understand for newcomers by putting a name
> to the encapsulated functionality.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---
>  fs/btrfs/ctree.c | 33 +++++++++++++++++++++++++++++++++
>  fs/btrfs/ctree.h | 24 ++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a7db3f6f1b7b..d735bd472616 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2277,6 +2277,39 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  	return ret;
>  }
>  
> +/* Search for a valid slot for the given path.

Multi-line comments should start with
/*
 * Text ...
 * ...
 */

> + *
> + * @root: The root node of the tree.
> + * @key: Will contain a valid item if found.
> + * @path: The starting point to validate the slot.

Please align the descriptions, an example is here
https://btrfs.wiki.kernel.org/index.php/Development_notes#Comments

> + *
> + * Return 0 if the item is valid, 1 if not found and < 0 if error.
> + */
> +int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
> +			      struct btrfs_path *path)
> +{
> +	while (1) {
> +		int ret;
> +		const int slot = path->slots[0];
> +		const struct extent_buffer *leaf = path->nodes[0];

Newline between declarations and statements.

> +		/* this is where we start walking through the path */

The comments should read like a sentence, so the first letter should be
uppercase unless it's an identifier.

> +		if (slot >= btrfs_header_nritems(leaf)) {
> +			/*
> +			 * if we've reached the last slot in this leaf we need
> +			 * to go to the next leaf and reset the path
> +			 */
> +			ret = btrfs_next_leaf(root, path);
> +			if (ret)
> +				return ret;
> +			continue;
> +		}
> +		/* store the found, valid item in key */
> +		btrfs_item_key_to_cpu(leaf, key, slot);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * adjust the pointers going up the tree, starting at level
>   * making sure the right key of each node is points to 'key'.
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 947f04789389..98091334b749 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2976,6 +2976,30 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
>  int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
>  			   struct btrfs_path *path);
>  
> +int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
> +			      struct btrfs_path *path);
> +
> +/* Search in @root for a given @key, and store the slot found in @found_key.
> + *
> + * @root: The root node of the tree.
> + * @key: The key we are looking for.
> + * @found_key: Will hold the found item.
> + * @path: Holds the current slot/leaf.
> + * @iter_ret: Contains the value returned from btrfs_search_slot or
> + *            btrfs_get_next_valid_item, whichever was executed last.
> + *
> + * The iter_ret is an output variable that will contain the return value of
> + * btrfs_search_slot, if it encountered an error, or the value returned from
> + * btrfs_get_next_valid_item, otherwise. That return value can be 0, if a valid
> + * slot was found, 1 if there were no more leaves, and <0 if there was an error.
> + */
> +#define btrfs_for_each_slot(root, key, found_key, path, iter_ret)		\
> +	for (iter_ret = btrfs_search_slot(NULL, root, key, path, 0, 0);		\
> +		iter_ret >= 0 &&						\
> +		(iter_ret = btrfs_get_next_valid_item(root, found_key, path)) == 0; \
> +		path->slots[0]++						  \

As the arguments can be more than just an identifier it's safer to put
them in ( ) in the definition, ie root/key/found_key/path/iter_ret
shouls be all (root) etc
