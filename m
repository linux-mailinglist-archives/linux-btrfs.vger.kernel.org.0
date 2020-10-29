Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAB29EA0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 12:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgJ2LHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 07:07:52 -0400
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:41961 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJ2LHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 07:07:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00786222-8.26784e-05-0.992055;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Iq0DKdU_1603969668;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Iq0DKdU_1603969668)
          by smtp.aliyun-inc.com(10.147.41.121);
          Thu, 29 Oct 2020 19:07:48 +0800
Date:   Thu, 29 Oct 2020 19:07:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v5 09/10] btrfs: remove free space items when disabling space cache v1
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <750174b66139e105150b988b35705a1a708b2eb5.1603828718.git.boris@bur.io>
References: <cover.1603828718.git.boris@bur.io> <750174b66139e105150b988b35705a1a708b2eb5.1603828718.git.boris@bur.io>
Message-Id: <20201029190748.563D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

'mkfs.btrfs -R free-space-tree'  still create 'space cache v1'?

#mkfs.btrfs-5.9 -R free-space-tree /dev/sdb1 -f

1st time mount
#mount /dev/sdb1 /btrfs/
#dmesg
BTRFS info (device sdb1): cleaning free space cache v1
#umount

2nd time mount
#mount /dev/sdb1 /btrfs/
#dmesg
NO BTRFS info (device sdb1): cleaning free space cache v1
#umount

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2020/10/29

> When the file system transitions from space cache v1 to v2 or to
> nospace_cache, it removes the old cached data, but does not remove
> the FREE_SPACE items nor the free space inodes they point to. This
> doesn't cause any issues besides being a bit inefficient, since these
> items no longer do anything useful.
> 
> To fix it, when we are mounting, and plan to disable the space cache,
> destroy each block group's free space item and free space inode.
> The code to remove the items is lifted from the existing use case of
> removing the block group, with a light adaptation to handle whether or
> not we have already looked up the free space inode.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c      |  39 +-------------
>  fs/btrfs/free-space-cache.c | 101 ++++++++++++++++++++++++++++++++++--
>  fs/btrfs/free-space-cache.h |   3 ++
>  3 files changed, 102 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c0f1d6818df7..8938b11a3339 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -892,8 +892,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	struct btrfs_path *path;
>  	struct btrfs_block_group *block_group;
>  	struct btrfs_free_cluster *cluster;
> -	struct btrfs_root *tree_root = fs_info->tree_root;
> -	struct btrfs_key key;
>  	struct inode *inode;
>  	struct kobject *kobj = NULL;
>  	int ret;
> @@ -971,42 +969,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	spin_unlock(&trans->transaction->dirty_bgs_lock);
>  	mutex_unlock(&trans->transaction->cache_write_mutex);
>  
> -	if (!IS_ERR(inode)) {
> -		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> -		if (ret) {
> -			btrfs_add_delayed_iput(inode);
> -			goto out;
> -		}
> -		clear_nlink(inode);
> -		/* One for the block groups ref */
> -		spin_lock(&block_group->lock);
> -		if (block_group->iref) {
> -			block_group->iref = 0;
> -			block_group->inode = NULL;
> -			spin_unlock(&block_group->lock);
> -			iput(inode);
> -		} else {
> -			spin_unlock(&block_group->lock);
> -		}
> -		/* One for our lookup ref */
> -		btrfs_add_delayed_iput(inode);
> -	}
> -
> -	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
> -	key.type = 0;
> -	key.offset = block_group->start;
> -
> -	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> -	if (ret < 0)
> +	ret = btrfs_remove_free_space_inode(trans, inode, block_group);
> +	if (ret)
>  		goto out;
> -	if (ret > 0)
> -		btrfs_release_path(path);
> -	if (ret == 0) {
> -		ret = btrfs_del_item(trans, tree_root, path);
> -		if (ret)
> -			goto out;
> -		btrfs_release_path(path);
> -	}
>  
>  	spin_lock(&fs_info->block_group_cache_lock);
>  	rb_erase(&block_group->cache_node,
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 3acf935536ea..5d357786c9da 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -207,6 +207,65 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
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
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	if (!inode)
> +		inode = lookup_free_space_inode(block_group, path);
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
> +	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path,
> +				-1, 1);
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
> @@ -3997,6 +4056,28 @@ bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info)
>  	return btrfs_super_cache_generation(fs_info->super_copy);
>  }
>  
> +static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
> +				       struct btrfs_trans_handle *trans)
> +{
> +	struct btrfs_block_group *block_group;
> +	struct rb_node *node;
> +	int ret;
> +
> +	btrfs_info(fs_info, "cleaning free space cache v1");
> +
> +	node = rb_first(&fs_info->block_group_cache_tree);
> +	while (node) {
> +		block_group = rb_entry(node, struct btrfs_block_group,
> +				       cache_node);
> +		ret = btrfs_remove_free_space_inode(trans, NULL, block_group);
> +		if (ret)
> +			goto out;
> +		node = rb_next(node);
> +	}
> +out:
> +	return ret;
> +}
> +
>  int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
>  					 bool active)
>  {
> @@ -4004,18 +4085,30 @@ int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info,
>  	int ret;
>  
>  	/*
> -	 * update_super_roots will appropriately set
> -	 * fs_info->super_copy->cache_generation based on the SPACE_CACHE
> -	 * option, so all we have to do is trigger a transaction commit.
> +	 * update_super_roots will appropriately set or unset
> +	 * fs_info->super_copy->cache_generation based on SPACE_CACHE and
> +	 * BTRFS_FS_CLEANUP_SPACE_CACHE_V1. For this reason, we need a
> +	 * transaction commit whether we are enabling space cache v1 and don't
> +	 * have any other work to do, or are disabling it and removing free
> +	 * space inodes.
>  	 */
>  	trans = btrfs_start_transaction(fs_info->tree_root, 0);
>  	if (IS_ERR(trans))
>  		return PTR_ERR(trans);
>  
> -	if (!active)
> +	if (!active) {
>  		set_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
> +		ret = cleanup_free_space_cache_v1(fs_info, trans);
> +		if (ret)
> +			goto abort;
> +	}
>  
>  	ret = btrfs_commit_transaction(trans);
> +	goto out;
> +abort:
> +	btrfs_abort_transaction(trans, ret);
> +	btrfs_end_transaction(trans);
> +out:
>  	clear_bit(BTRFS_FS_CLEANUP_SPACE_CACHE_V1, &fs_info->flags);
>  	return ret;
>  }
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index 5c546898ded9..8df4b2925eca 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -84,6 +84,9 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
>  int create_free_space_inode(struct btrfs_trans_handle *trans,
>  			    struct btrfs_block_group *block_group,
>  			    struct btrfs_path *path);
> +int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
> +				  struct inode *inode,
> +				  struct btrfs_block_group *block_group);
>  
>  int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
>  				       struct btrfs_block_rsv *rsv);
> -- 
> 2.24.1


