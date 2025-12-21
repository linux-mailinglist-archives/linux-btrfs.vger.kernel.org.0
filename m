Return-Path: <linux-btrfs+bounces-19924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9E3CD3965
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F31300F9C0
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B6818C933;
	Sun, 21 Dec 2025 01:19:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-178.us.a.mail.aliyun.com (out198-178.us.a.mail.aliyun.com [47.90.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1E2AD37
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766279964; cv=none; b=uKddoQ75T8r/i+Zt92Z3GBt4k1LR+5jI2WcuOgX5AUpqWzEs5ZXRzQrfZFeHVhpKQPkJZyn6Qxh0qzc3faxh+cS7VkzV/yztEcp/BH40J3EsiNjqqvXaHWMfHwfwDaodcGL5KkR9galH0E2iBTWUsHy38Be6+dIUCggSEJCvsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766279964; c=relaxed/simple;
	bh=gw0n5kaahnYGPb/nl7TIgjsC5PIs6NdKVnIR59rQt9o=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=pB/Esw7wEIWH/Gx6R2yxqFOXvIvuJKipwoVJhY5WQCvGQnBMOou5hbhYwhtF6+20zaRvcdBPO3WaF959q8XQ7Tn9XxJM4Zj7af9Otx7Apa6cmtYpNIGB7JCFddJ3NcXSLgLA3SUvxaozX50cYfq+IhlCndXX3NhLTW6XUvP6oFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fpMY4pC_1766279625 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 21 Dec 2025 09:13:45 +0800
Date: Sun, 21 Dec 2025 09:13:47 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: add mount time auto fix for orphan fst entries
In-Reply-To: <f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com>
References: <f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com>
Message-Id: <20251221091346.4BD8.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

> [BUG]
> Before btrfs-progs v6.16.1 release, mkfs.btrfs can leave free space tree
> entries for deleted chunks:

more info maybe useful.

Before btrfs-progs v6.16.1 release (3fc9f1ed32780a1add9cc2b3fb638e8c750478ab
btrfs-progs: remove block group free space), mkfs.btrfs can leave free space
tree v1 entries for deleted chunks.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/21

> 
>  # mkfs.btrfs -f -O fst $dev
>  # btrfs ins dump-tree -t chunk $dev
>  btrfs-progs v6.16
>  chunk tree
>  leaf 22036480 items 4 free space 15781 generation 8 owner CHUNK_TREE
>  leaf 22036480 flags 0x1(WRITTEN) backref revision 1
> 	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
> 	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
>         ^^^ The first chunk is at 13631488
> 	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
> 	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112
> 
>  # btrfs ins dump-tree -t free-space-tree $dev
>  btrfs-progs v6.16
>  free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
>  leaf 30556160 items 13 free space 15918 generation 8 owner FREE_SPACE_TREE
>  leaf 30556160 flags 0x1(WRITTEN) backref revision 1
>  	item 0 key (1048576 FREE_SPACE_INFO 4194304) itemoff 16275 itemsize 8
> 		free space info extent count 1 flags 0
> 	item 1 key (1048576 FREE_SPACE_EXTENT 4194304) itemoff 16275 itemsize 0
> 		free space extent
> 	item 2 key (5242880 FREE_SPACE_INFO 8388608) itemoff 16267 itemsize 8
> 		free space info extent count 1 flags 0
> 	item 3 key (5242880 FREE_SPACE_EXTENT 8388608) itemoff 16267 itemsize 0
> 		free space extent
> 	^^^ Above 4 items are all before the first chunk.
> 	item 4 key (13631488 FREE_SPACE_INFO 8388608) itemoff 16259 itemsize 8
> 		free space info extent count 1 flags 0
> 	item 5 key (13631488 FREE_SPACE_EXTENT 8388608) itemoff 16259 itemsize 0
> 		free space extent
> 	...
> 
> This can trigger btrfs check errors.
> 
> [CAUSE]
> It's a bug in free space tree implementation of btrfs-progs, which
> doesn't delete involved fst entries for the to-be-deleted chunk/block
> group.
> 
> [ENHANCEMENT]
> The mostly common fix is to clear the space cache and rebuild it, but
> that requires a ro->rw remount which may not be possible for rootfs,
> and also relies on users to use "clear_cache" mount option manually.
> 
> Here introduce a kernel fix for it, which will delete any entries that
> is before the first block group automatically at the first RW mount.
> 
> For fses without such problem, the overhead is just a single tree
> search and no modification to the free space tree, thus the overhead
> should be minimal.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Rename the exported function to btrfs_delete_orphan_free_space_entries()
>   And minor rewords.
> - Use btrfs_err() if we failed to delete the orphan fst entries
> - Various grammar and code style fixes
> 
> v2:
> - Do not output the "deleted orphan free space tree entries" for error
> - Do not return >0 for delete_orphan_free_space_entries()
>   If we deleted a full leaf and the next item matches the first bg, we
>   will return 1. This should not happen in the real world though.
> - Add a comment for the inner for() loop break
>   For double loop, we need to take care of which loop we're breaking
>   out.
> ---
>  fs/btrfs/disk-io.c         |  10 ++++
>  fs/btrfs/free-space-tree.c | 104 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-tree.h |   1 +
>  3 files changed, 115 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e5535bdc5b0c..1015185c80ae 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3034,6 +3034,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  		}
>  	}
>  
> +	/*
> +	 * Before btrfs-progs v6.16.1 mkfs.btrfs can leave free space entries
> +	 * for deleted temporary chunks.
> +	 * Delete them if they exist.
> +	 */
> +	ret = btrfs_delete_orphan_free_space_entries(fs_info);
> +	if (ret < 0) {
> +		btrfs_err(fs_info, "failed to delete orphan free space tree entries: %d", ret);
> +		goto out;
> +	}
>  	/*
>  	 * btrfs_find_orphan_roots() is responsible for finding all the dead
>  	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index a66ce9ef3aff..e949dc3e5cd0 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1710,3 +1710,107 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
>  	else
>  		return load_free_space_extents(caching_ctl, path, extent_count);
>  }
> +
> +static int delete_orphan_free_space_entries(struct btrfs_root *fst_root,
> +					    struct btrfs_path *path,
> +					    u64 first_bg_bytenr)
> +{
> +	struct btrfs_trans_handle *trans;
> +	int ret;
> +
> +	trans = btrfs_start_transaction(fst_root, 1);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	while (true) {
> +		struct btrfs_key key = { 0 };
> +		int i;
> +
> +		ret = btrfs_search_slot(trans, fst_root, &key, path, -1, 1);
> +		if (ret < 0)
> +			break;
> +		ASSERT(ret > 0);
> +		ret = 0;
> +		for (i = 0; i < btrfs_header_nritems(path->nodes[0]); i++) {
> +			btrfs_item_key_to_cpu(path->nodes[0], &key, i);
> +			if (key.objectid >= first_bg_bytenr) {
> +				/*
> +				 * Only break the for() loop and continue to
> +				 * delete items.
> +				 */
> +				break;
> +			}
> +		}
> +		/* No items to delete, finished. */
> +		if (i == 0)
> +			break;
> +
> +		ret = btrfs_del_items(trans, fst_root, path, 0, i);
> +		if (ret < 0)
> +			break;
> +		btrfs_release_path(path);
> +	}
> +	btrfs_release_path(path);
> +	btrfs_end_transaction(trans);
> +	if (ret == 0)
> +		btrfs_info(fst_root->fs_info, "deleted orphan free space tree entries");
> +	return ret;
> +}
> +
> +/* Remove any free space entry before the first block group. */
> +int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info)
> +{
> +	BTRFS_PATH_AUTO_RELEASE(path);
> +	struct btrfs_key key = {
> +		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
> +		.type = BTRFS_ROOT_ITEM_KEY,
> +		.offset = 0,
> +	};
> +	struct btrfs_root *root;
> +	struct btrfs_block_group *bg;
> +	u64 first_bg_bytenr;
> +	int ret;
> +
> +	/*
> +	 * Extent tree v2 has multiple global roots based on the block group.
> +	 * This means we can not easily grab the global free space tree and locate
> +	 * orphan items.
> +	 * Furthermore this is still experimental, all users should use the latest
> +	 * btrfs-progs anyway.
> +	 */
> +	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +		return 0;
> +	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> +		return 0;
> +	root = btrfs_global_root(fs_info, &key);
> +	if (!root)
> +		return 0;
> +
> +	key.objectid = 0;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	bg = btrfs_lookup_first_block_group(fs_info, 0);
> +	if (unlikely(!bg)) {
> +		btrfs_err(fs_info, "no block group found");
> +		return -EUCLEAN;
> +	}
> +	first_bg_bytenr = bg->start;
> +	btrfs_put_block_group(bg);
> +
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +	/* There should not be an all-zero key in fst. */
> +	ASSERT(ret > 0);
> +
> +	/* Empty free space tree. */
> +	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
> +		return 0;
> +
> +	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +	if (key.objectid >= first_bg_bytenr)
> +		return 0;
> +	btrfs_release_path(&path);
> +	return delete_orphan_free_space_entries(root, &path, first_bg_bytenr);
> +}
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 3d9a5d4477fc..ca04fc7cf29e 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  				 u64 start, u64 size);
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  				      u64 start, u64 size);
> +int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
> -- 
> 2.52.0
> 



