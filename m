Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6072277780
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgIXRJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 13:09:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:51358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgIXRJI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 13:09:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E34FABB2;
        Thu, 24 Sep 2020 17:09:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F1CFDA6E3; Thu, 24 Sep 2020 19:07:50 +0200 (CEST)
Date:   Thu, 24 Sep 2020 19:07:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 3/4] btrfs: remove free space items when creating free
 space tree
Message-ID: <20200924170750.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 17, 2020 at 11:13:40AM -0700, Boris Burkov wrote:
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -207,6 +207,64 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
>  					 ino, block_group->start);
>  }
>  
> +/*
> + * inode is an optional sink: if it is NULL, btrfs_remove_free_space_inode
> + * handles lookup, otherwise it takes ownership and iputs the inode.
> + * Don't reuse an inode pointer after passing it into this function.
> + */
> +int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
> +				  struct inode *inode,
> +				  struct btrfs_block_group *block_group)
> +{
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	int ret = 0;
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	if (!inode) {
> +		inode = lookup_free_space_inode(block_group, path);
> +	}

No { } around single statement

> +	if (IS_ERR(inode)) {
> +		if (PTR_ERR(inode) != -ENOENT)
> +			ret = PTR_ERR(inode);
> +		goto out;
> +	}
> +	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> +	if (ret) {
> +		btrfs_add_delayed_iput(inode);
> +		goto out;
> +	}
> +	clear_nlink(inode);
> +	/* One for the block groups ref */
> +	spin_lock(&block_group->lock);
> +	if (block_group->iref) {
> +		block_group->iref = 0;
> +		block_group->inode = NULL;
> +		spin_unlock(&block_group->lock);
> +		iput(inode);
> +	} else {
> +		spin_unlock(&block_group->lock);
> +	}
> +	/* One for the lookup ref */
> +	btrfs_add_delayed_iput(inode);
> +
> +	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
> +	key.type = 0;
> +	key.offset = block_group->start;
> +	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path, -1, 1);

This slightly overflows 80 but it's full one parameter so in this case
I'd rather wrap it (from -1). Otherwise, more than 80 is ok-ish if it's
the ); or end of an identifier that's half visible.


> +	if (ret) {
> +		if (ret > 0)
> +			ret = 0;
> +		goto out;
> +	}
> +	ret = btrfs_del_item(trans, trans->fs_info->tree_root, path);
> +out:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>  int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
>  				       struct btrfs_block_rsv *rsv)
>  {
