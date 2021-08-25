Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B03F75EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhHYNee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 09:34:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54476 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhHYNed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 09:34:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 584842010D;
        Wed, 25 Aug 2021 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629898427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTgdMlqAwTVEdi2ml1n7IqB+3LSTEuZrWlRkFZv76Lw=;
        b=eMs6RFo9GgYfe/p0grDlrhMGkby8wtXtN/lpo6kLKN61pC738ZbR/E1YZmhXnhD5ai3CPC
        EXqGytnF+cG2/OV1Hm6jUw0mXPLqODExgHoQGt+JF5secX+xLA4uHonGgvQuglGKppj42t
        sbSCGhi23QNYNlJSeJQ3xcYFmQfY7Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629898427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTgdMlqAwTVEdi2ml1n7IqB+3LSTEuZrWlRkFZv76Lw=;
        b=opRzOvRVQmnz16zkjJd82TIeV8P/N6SlF2UjYixjx009tIvwHbcuGY9EkBwR8mq2DX1IQv
        1E/cTVQXLGbJXfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 933B313AD7;
        Wed, 25 Aug 2021 13:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6JXMFbhGJmEBWwAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Wed, 25 Aug 2021 13:33:44 +0000
Message-ID: <824cf659f83d3714a32ba99c951909e1f4aaff64.camel@suse.de>
Subject: Re: [PATCH 1/7] fs: btrfs: Introduce btrfs_for_each_slot
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Date:   Wed, 25 Aug 2021 10:32:13 -0300
In-Reply-To: <PH0PR04MB74165AAE8DA3D7BA81C2A0AC9BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210824170658.12567-1-mpdesouza@suse.com>
         <20210824170658.12567-2-mpdesouza@suse.com>
         <PH0PR04MB74165AAE8DA3D7BA81C2A0AC9BC69@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2021-08-25 at 07:42 +0000, Johannes Thumshirn wrote:
> On 24/08/2021 19:13, Marcos Paulo de Souza wrote:
> > There is a common pattern when search for a key in btrfs:
> > 
> >  * Call btrfs_search_slot
> >  * Endless loop
> > 	 * If the found slot is bigger than the current items in the
> > leaf, check the
> > 	   next one
> > 	 * If still not found in the next leaf, return 1
> > 	 * Do something with the code
> > 	 * Increment current slot, and continue
> > 
> > This pattern can be improved by creating an iterator macro, similar
> > to
> > those for_each_X already existing in the linux kernel. Using this
> > approach means to reduce significantly boilerplate code, along
> > making it
> > easier to newcomers to understand how to code works.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  fs/btrfs/ctree.c | 28 ++++++++++++++++++++++++++++
> >  fs/btrfs/ctree.h | 25 +++++++++++++++++++++++++
> >  fs/btrfs/xattr.c | 40 ++++++++++++----------------------------
> >  3 files changed, 65 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 84627cbd5b5b..b1aa6e3987d0 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2122,6 +2122,34 @@ int btrfs_search_backwards(struct btrfs_root
> > *root, struct btrfs_key *key,
> >  	return ret;
> >  }
> >  
> > +/* Search for a valid slot for the given path.
> > + * @root: The root node of the tree.
> > + * @key: Will contain a valid item if found.
> > + * @path: The start point to validate the slot.
> > + *
> > + * Return 0 if the item is valid, 1 if not found and < 0 if error.
> > + */
> > +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key
> > *key,
> > +		     struct btrfs_path *path)
> > +{
> > +	while (1) {
> > +		int ret;
> > +		const int slot = path->slots[0];
> > +		const struct extent_buffer *leaf = path->nodes[0];
> > +
> > +		if (slot >= btrfs_header_nritems(leaf)) {
> > +			ret = btrfs_next_leaf(root, path);
> > +			if (ret)
> > +				return ret;
> > +			continue;
> > +		}
> > +		btrfs_item_key_to_cpu(leaf, key, slot);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * adjust the pointers going up the tree, starting at level
> >   * making sure the right key of each node is points to 'key'.
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index f07c82fafa04..1e3c4a7741ca 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2912,6 +2912,31 @@ int btrfs_next_old_leaf(struct btrfs_root
> > *root, struct btrfs_path *path,
> >  int btrfs_search_backwards(struct btrfs_root *root, struct
> > btrfs_key *key,
> >  			   struct btrfs_path *path);
> >  
> > +int btrfs_valid_slot(struct btrfs_root *root, struct btrfs_key
> > *key,
> > +		     struct btrfs_path *path);
> > +
> > +/* Search in @root for a given @key, and store the slot found in
> > @found_key.
> > + * @root: The root node of the tree.
> > + * @key: The key we are looking for.
> > + * @found_key: Will hold the found item.
> > + * @path: Holds the current slot/leaf.
> > + * @iter_ret: Contains the returned value from btrfs_search_slot
> > and
> > + *            btrfs_valid_slot, whatever is executed later.
> > + *
> > + * The iter_ret is an output variable that will contain the result
> > of the
> > + * btrfs_search_slot if it returns an error, or the value returned
> > from
> > + * btrfs_valid_slot otherwise. The return value can be 0 if the
> > something was
> > + * found, 1 if there weren't bigger leaves, and <0 if error.
> > + */
> > +#define btrfs_for_each_slot(root, key, found_key, path, iter_ret)	
> > 	\
> > +	for (iter_ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
> > 		\
> > +		(								
> > \
> > +			iter_ret >= 0 &&					
> > \
> > +			(iter_ret = btrfs_valid_slot(root, found_key,
> > path)) == 0 \
> > +		);								
> >   \
> > +		path->slots[0]++						
> >   \
> > +	)
> > +
> >  static inline int btrfs_next_old_item(struct btrfs_root *root,
> >  				      struct btrfs_path *p, u64
> > time_seq)
> >  {
> 
> Shouldn't below xattr code be in a separate patch? Just like the
> block-group,
> dev-replace, etc changes?

You're right, this was a leftover of my RFC patches. I'll send a new
version as soon.

> 
> > diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> > index 8a4514283a4b..f85febba1891 100644
> > --- a/fs/btrfs/xattr.c
> > +++ b/fs/btrfs/xattr.c
> > @@ -274,10 +274,12 @@ int btrfs_setxattr_trans(struct inode *inode,
> > const char *name,
> >  ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer,
> > size_t size)
> >  {
> >  	struct btrfs_key key;
> > +	struct btrfs_key found_key;
> >  	struct inode *inode = d_inode(dentry);
> >  	struct btrfs_root *root = BTRFS_I(inode)->root;
> >  	struct btrfs_path *path;
> >  	int ret = 0;
> > +	int iter_ret = 0;
> >  	size_t total_size = 0, size_left = size;
> >  
> >  	/*
> > @@ -295,44 +297,22 @@ ssize_t btrfs_listxattr(struct dentry
> > *dentry, char *buffer, size_t size)
> >  	path->reada = READA_FORWARD;
> >  
> >  	/* search for our xattrs */
> > -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > -	if (ret < 0)
> > -		goto err;
> > -
> > -	while (1) {
> > +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
> >  		struct extent_buffer *leaf;
> >  		int slot;
> >  		struct btrfs_dir_item *di;
> > -		struct btrfs_key found_key;
> >  		u32 item_size;
> >  		u32 cur;
> >  
> >  		leaf = path->nodes[0];
> >  		slot = path->slots[0];
> >  
> > -		/* this is where we start walking through the path */
> > -		if (slot >= btrfs_header_nritems(leaf)) {
> > -			/*
> > -			 * if we've reached the last slot in this leaf
> > we need
> > -			 * to go to the next leaf and reset everything
> > -			 */
> > -			ret = btrfs_next_leaf(root, path);
> > -			if (ret < 0)
> > -				goto err;
> > -			else if (ret > 0)
> > -				break;
> > -			continue;
> > -		}
> > -
> > -		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> > -
> >  		/* check to make sure this item is what we want */
> > -		if (found_key.objectid != key.objectid)
> > -			break;
> > -		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
> > +		if (found_key.objectid != key.objectid ||
> > +		    found_key.type > BTRFS_XATTR_ITEM_KEY)
> >  			break;
> >  		if (found_key.type < BTRFS_XATTR_ITEM_KEY)
> > -			goto next_item;
> > +			continue;
> >  
> >  		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
> >  		item_size = btrfs_item_size_nr(leaf, slot);
> > @@ -365,9 +345,13 @@ ssize_t btrfs_listxattr(struct dentry *dentry,
> > char *buffer, size_t size)
> >  			cur += this_len;
> >  			di = (struct btrfs_dir_item *)((char *)di +
> > this_len);
> >  		}
> > -next_item:
> > -		path->slots[0]++;
> >  	}
> > +
> > +	if (iter_ret < 0) {
> > +		ret = iter_ret;
> > +		goto err;
> > +	}
> > +
> >  	ret = total_size;
> >  
> >  err:
> > 

