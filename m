Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B983D729B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhG0KIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:08:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhG0KIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:08:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 86F2E200F4;
        Tue, 27 Jul 2021 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627380495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nErKarhSUYsOWGRYeJfvZwGD2KF9rNJK2R+dy9yheE0=;
        b=EWRJL1iex99RHx0D9pyDQ93jDmEoJgo9u4dc6OOerFUpEzSXgHRcoAB3/lkVD/j5YsN2no
        rcVz5E2s+qvEjWnYLsddvxven5DSaNxUs8KQvDVs40ubSD2ggvUUYLPzKA4El1/uuvOQvU
        whOJwTBdQvSKLE3pPRwyNmecAgsu9E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627380495;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nErKarhSUYsOWGRYeJfvZwGD2KF9rNJK2R+dy9yheE0=;
        b=RNRtoke+BQN2/iudxcOYdcO9wlyw4tE2zR2unmiBQZu6HlAwcroZYaj2mYHeS14Co+AA9I
        mFwUpWILjA0Z66Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 802E2A3B88;
        Tue, 27 Jul 2021 10:08:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11CCCDA8CC; Tue, 27 Jul 2021 12:05:30 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:05:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: dir-item: Introduce btrfs_lookup_match_dir
Message-ID: <20210727100530.GO5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210726191909.31910-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726191909.31910-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 04:19:09PM -0300, Marcos Paulo de Souza wrote:
> btrfs_search_slot is called in multiple places in dir-item.c to search
> to a dir entry, and then calling btrfs_match_dir_name to return a
> btrfs_dir_item struct.
> 
> In order to reduce the number of callers of btrfs_search_slot, create a
> common function that check's if the dir key, and if found call
> btrfs_match_dir_item_name.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/dir-item.c | 77 +++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
> index 98b63ebed539..06ad692889cc 100644
> --- a/fs/btrfs/dir-item.c
> +++ b/fs/btrfs/dir-item.c
> @@ -170,6 +170,25 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
>  	return 0;
>  }
>  
> +static struct btrfs_dir_item *
> +btrfs_lookup_match_dir(struct btrfs_trans_handle *trans,
> +			struct btrfs_root *root, struct btrfs_path *path,
> +			struct btrfs_key *key, const char *name,
> +			int name_len, int mod)

Please keep the type and name on the same line, overflowing arguments go
to the next line.

> +{
> +	int ret;
> +	int ins_len = mod < 0 ? -1 : 0;
> +	int cow = mod != 0;

Both can be const.

> +
> +	ret = btrfs_search_slot(trans, root, key, path, ins_len, cow);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	if (ret > 0)
> +		return ERR_PTR(-ENOENT);
> +
> +	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
> +}
> +
>  /*
>   * lookup a directory item based on name.  'dir' is the objectid
>   * we're searching in, and 'mod' tells us if you plan on deleting the
> @@ -181,23 +200,18 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
>  					     const char *name, int name_len,
>  					     int mod)
>  {
> -	int ret;
>  	struct btrfs_key key;
> -	int ins_len = mod < 0 ? -1 : 0;
> -	int cow = mod != 0;
> +	struct btrfs_dir_item *di;
>  
>  	key.objectid = dir;
>  	key.type = BTRFS_DIR_ITEM_KEY;
> -
>  	key.offset = btrfs_name_hash(name, name_len);
>  
> -	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -	if (ret > 0)
> +	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
> +	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
>  		return NULL;
>  
> -	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
> +	return di;
>  }
>  
>  int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
> @@ -211,7 +225,6 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
>  	int slot;
>  	struct btrfs_path *path;
>  
> -
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> @@ -220,20 +233,21 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
>  	key.type = BTRFS_DIR_ITEM_KEY;
>  	key.offset = btrfs_name_hash(name, name_len);
>  
> -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> -
> -	/* return back any errors */
> -	if (ret < 0)
> -		goto out;
> +	di = btrfs_lookup_match_dir(NULL, root, path, &key, name, name_len, 0);
> +	if (IS_ERR(di)) {
> +		ret = PTR_ERR(di);
> +		/* nothing found, we're safe */
> +		if (ret == -ENOENT) {
> +			ret = 0;
> +			goto out;
> +		}
>  
> -	/* nothing found, we're safe */
> -	if (ret > 0) {
> -		ret = 0;
> -		goto out;
> +		/* return back any errors */
> +		if (ret < 0)
> +			goto out;
>  	}
>  
>  	/* we found an item, look for our name in the item */
> -	di = btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
>  	if (di) {
>  		/* our exact name was found */
>  		ret = -EEXIST;
> @@ -274,21 +288,13 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
>  			    u64 objectid, const char *name, int name_len,
>  			    int mod)
>  {
> -	int ret;
>  	struct btrfs_key key;
> -	int ins_len = mod < 0 ? -1 : 0;
> -	int cow = mod != 0;
>  
>  	key.objectid = dir;
>  	key.type = BTRFS_DIR_INDEX_KEY;
>  	key.offset = objectid;
>  
> -	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -	if (ret > 0)
> -		return ERR_PTR(-ENOENT);
> -	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
> +	return btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
>  }
>  
>  struct btrfs_dir_item *
> @@ -345,21 +351,18 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
>  					  const char *name, u16 name_len,
>  					  int mod)
>  {
> -	int ret;
>  	struct btrfs_key key;
> -	int ins_len = mod < 0 ? -1 : 0;
> -	int cow = mod != 0;
> +	struct btrfs_dir_item *di;
>  
>  	key.objectid = dir;
>  	key.type = BTRFS_XATTR_ITEM_KEY;
>  	key.offset = btrfs_name_hash(name, name_len);
> -	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
> -	if (ret < 0)
> -		return ERR_PTR(ret);
> -	if (ret > 0)
> +
> +	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
> +	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
>  		return NULL;
>  
> -	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
> +	return di;
>  }
>  
>  /*
> -- 
> 2.26.2
