Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C155B78C28B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjH2Kr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjH2KrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 06:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0C1A6
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 03:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0C2263B5F
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 10:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF637C433C7;
        Tue, 29 Aug 2023 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306013;
        bh=k9+aIW32JxUwOCWHDbJXbK0wPnSjJFm/bb1XeD7707o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFYtGLxfG7O/SNBVC4cay8wG/5vy7jgt4bbzt84cYzy3qswVByYmgd7brAG0zJ36G
         hKPIVNk/Cj2eu0Q1D+Uyl8ym9sB8MYTQE2pvR/ndaz9jEb5PonbWCOjxe3LJU9nOEa
         I5lRtN1D1X93zkbP65KCXwhr3LE4Ihe9zkbPqhd+y7Ij7nXcmVeN1Xbft3teQLdEQ2
         NZjl51O6JU8fNdWtRdUIe1XbhOwV9ZwxI12N0p/KWINq2m/7E9Mnr3FKBLuIai4DP/
         Ai0NU6oG9M22CXX739oSxQQadUudmE658zJykwQpt7UYjpfaHRoSfAnTDmRqFRwq/5
         t2I2aADeWqp2w==
Date:   Tue, 29 Aug 2023 11:46:49 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
 GFP_ATOMIC usage
Message-ID: <ZO3MmTSkdN1kq2va@debian0.Home>
References: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 29, 2023 at 09:08:08AM +0800, Qu Wenruo wrote:
> Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
> really need GFP_ATOMIC, that is add_qgroup_rb().
> 
> That function only search the rb tree to find if we already have such
> tree.
> If there is no such tree, then it would try to allocate memory for it.
> 
> This means we can afford to pre-allocate such structure unconditionally,
> then free the memory if it's not needed.
> 
> Considering this function is not a hot path, only utilized by the
> following functions:
> 
> - btrfs_qgroup_inherit()
>   For "btrfs subvolume snapshot -i" option.
> 
> - btrfs_read_qgroup_config()
>   At mount time, and we're ensured there would be no existing rb tree
>   entry for each qgroup.
> 
> - btrfs_create_qgroup()
> 
> Thus we're completely safe to pre-allocate the extra memory for btrfs_qgroup
> structure, and reduce unnecessary GFP_ATOMIC usage.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Loose the GFP flag for btrfs_read_qgroup_config()
>   At that stage we can go GFP_KERNEL instead of GFP_NOFS.
> 
> - Do not mark qgroup inconsistent if memory allocation failed at
>   btrfs_qgroup_inherit()
>   At the very beginning, if we hit -ENOMEM, we haven't done anything,
>   thus qgroup is still consistent.
> ---
>  fs/btrfs/qgroup.c | 79 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 54 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index b99230db3c82..2a3da93fd266 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -182,28 +182,31 @@ static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
>  
>  /* must be called with qgroup_lock held */
>  static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
> +					  struct btrfs_qgroup *prealloc,
>  					  u64 qgroupid)
>  {
>  	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
>  	struct rb_node *parent = NULL;
>  	struct btrfs_qgroup *qgroup;
>  
> +	/* Caller must have pre-allocated @prealloc. */
> +	ASSERT(prealloc);
> +
>  	while (*p) {
>  		parent = *p;
>  		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
>  
> -		if (qgroup->qgroupid < qgroupid)
> +		if (qgroup->qgroupid < qgroupid) {
>  			p = &(*p)->rb_left;
> -		else if (qgroup->qgroupid > qgroupid)
> +		} else if (qgroup->qgroupid > qgroupid) {
>  			p = &(*p)->rb_right;
> -		else
> +		} else {
> +			kfree(prealloc);
>  			return qgroup;
> +		}
>  	}
>  
> -	qgroup = kzalloc(sizeof(*qgroup), GFP_ATOMIC);
> -	if (!qgroup)
> -		return ERR_PTR(-ENOMEM);
> -
> +	qgroup = prealloc;
>  	qgroup->qgroupid = qgroupid;
>  	INIT_LIST_HEAD(&qgroup->groups);
>  	INIT_LIST_HEAD(&qgroup->members);
> @@ -434,11 +437,15 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
>  			qgroup_mark_inconsistent(fs_info);
>  		}
>  		if (!qgroup) {
> -			qgroup = add_qgroup_rb(fs_info, found_key.offset);
> -			if (IS_ERR(qgroup)) {
> -				ret = PTR_ERR(qgroup);
> +			struct btrfs_qgroup *prealloc = NULL;
> +
> +			prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
> +			if (!prealloc) {
> +				ret = -ENOMEM;
>  				goto out;
>  			}
> +			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
> +			prealloc = NULL;
>  		}
>  		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>  		if (ret < 0)
> @@ -959,6 +966,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	struct btrfs_key key;
>  	struct btrfs_key found_key;
>  	struct btrfs_qgroup *qgroup = NULL;
> +	struct btrfs_qgroup *prealloc = NULL;
>  	struct btrfs_trans_handle *trans = NULL;
>  	struct ulist *ulist = NULL;
>  	int ret = 0;
> @@ -1094,6 +1102,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  			/* Release locks on tree_root before we access quota_root */
>  			btrfs_release_path(path);
>  
> +			/* We should not have a stray @prealloc pointer. */
> +			ASSERT(prealloc == NULL);
> +			prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> +			if (!prealloc) {
> +				ret = -ENOMEM;
> +				btrfs_abort_transaction(trans, ret);
> +				goto out_free_path;
> +			}
> +
>  			ret = add_qgroup_item(trans, quota_root,
>  					      found_key.offset);
>  			if (ret) {
> @@ -1101,7 +1118,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  				goto out_free_path;
>  			}
>  
> -			qgroup = add_qgroup_rb(fs_info, found_key.offset);
> +			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
> +			prealloc = NULL;
>  			if (IS_ERR(qgroup)) {
>  				ret = PTR_ERR(qgroup);
>  				btrfs_abort_transaction(trans, ret);
> @@ -1144,12 +1162,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  		goto out_free_path;
>  	}
>  
> -	qgroup = add_qgroup_rb(fs_info, BTRFS_FS_TREE_OBJECTID);
> -	if (IS_ERR(qgroup)) {
> -		ret = PTR_ERR(qgroup);
> -		btrfs_abort_transaction(trans, ret);
> +	ASSERT(prealloc == NULL);
> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> +	if (!prealloc) {
> +		ret = -ENOMEM;
>  		goto out_free_path;
>  	}
> +	qgroup = add_qgroup_rb(fs_info, prealloc, BTRFS_FS_TREE_OBJECTID);
> +	prealloc = NULL;
>  	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>  	if (ret < 0) {
>  		btrfs_abort_transaction(trans, ret);
> @@ -1222,6 +1242,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  	else if (trans)
>  		ret = btrfs_end_transaction(trans);
>  	ulist_free(ulist);
> +	kfree(prealloc);
>  	return ret;
>  }
>  
> @@ -1608,6 +1629,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *qgroup;
> +	struct btrfs_qgroup *prealloc = NULL;
>  	int ret = 0;
>  
>  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> @@ -1622,21 +1644,25 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
>  		goto out;
>  	}
>  
> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> +	if (!prealloc) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	ret = add_qgroup_item(trans, quota_root, qgroupid);
>  	if (ret)
>  		goto out;
>  
>  	spin_lock(&fs_info->qgroup_lock);
> -	qgroup = add_qgroup_rb(fs_info, qgroupid);
> +	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
>  	spin_unlock(&fs_info->qgroup_lock);
> +	prealloc = NULL;
>  
> -	if (IS_ERR(qgroup)) {
> -		ret = PTR_ERR(qgroup);
> -		goto out;
> -	}
>  	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>  out:
>  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +	kfree(prealloc);
>  	return ret;
>  }
>  
> @@ -2906,10 +2932,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  	struct btrfs_root *quota_root;
>  	struct btrfs_qgroup *srcgroup;
>  	struct btrfs_qgroup *dstgroup;
> +	struct btrfs_qgroup *prealloc = NULL;

This initialization is not needed, since we never read prealloc before
the allocation below.

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>  	bool need_rescan = false;
>  	u32 level_size = 0;
>  	u64 nums;
>  
> +	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
> +	if (!prealloc)
> +		return -ENOMEM;
> +
>  	/*
>  	 * There are only two callers of this function.
>  	 *
> @@ -2987,11 +3018,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  
>  	spin_lock(&fs_info->qgroup_lock);
>  
> -	dstgroup = add_qgroup_rb(fs_info, objectid);
> -	if (IS_ERR(dstgroup)) {
> -		ret = PTR_ERR(dstgroup);
> -		goto unlock;
> -	}
> +	dstgroup = add_qgroup_rb(fs_info, prealloc, objectid);
> +	prealloc = NULL;
>  
>  	if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
>  		dstgroup->lim_flags = inherit->lim.flags;
> @@ -3102,6 +3130,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
>  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
>  	if (need_rescan)
>  		qgroup_mark_inconsistent(fs_info);
> +	kfree(prealloc);
>  	return ret;
>  }
>  
> -- 
> 2.41.0
> 
