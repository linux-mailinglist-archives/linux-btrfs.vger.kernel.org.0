Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED04D67EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 18:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbiCKRoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 12:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiCKRoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 12:44:23 -0500
X-Greylist: delayed 1934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 09:43:20 PST
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCAAFCB63
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 09:43:19 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 402B68062C;
        Fri, 11 Mar 2022 12:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647020599; bh=G+4JL4euSSV86a45JzG/PTggjzdvlwLV9w/XoO6CxjY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a0UvwqWsfx6cy2Qb2Lt7AEzzGQQVHqUz3FMQDaEoy/5sSqvVF3lzSXsA3DKeARzBo
         7MuCtxweFxOv4LbTOsiPEJXZET0VawY6KdQ/yL5Q0MS7V2SiQFQwLqiVYKprWO0ZCW
         uajCNw/PtSY6kB3OfLiTQn8VTk3o+RS0bXMkOxR1LV1KtIjJou0y6DL3UUwOeuQPGV
         WHis/ieaV/vTidDEcM++HqBnHrZTZAkvk0WRtDi5GCfutJynOobKYoPWWww78ixN7x
         Mhj9B4zOABv6N0d9fvN5itJacM3WWV+7rSQUVCJuZ9d2sALDm+jWTvr+CqnqlIFbh3
         Wksy1zBQSA3Aw==
Message-ID: <c3577add-3acd-8c4d-9b8a-7a90d2eb10d7@dorminy.me>
Date:   Fri, 11 Mar 2022 12:43:18 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 14/16] btrfs: factor out common part of
 btrfs_{mknod,create,mkdir}()
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <2258575acbbf50aae5436b01e8d4400ecb905570.1646875648.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <2258575acbbf50aae5436b01e8d4400ecb905570.1646875648.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 3/9/22 20:31, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> btrfs_{mknod,create,mkdir}() are now identical other than the inode
> initialization and some inconsequential function call order differences.
> Factor out the common code to reduce code duplication.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>   fs/btrfs/inode.c | 152 ++++++++++-------------------------------------
>   1 file changed, 33 insertions(+), 119 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ff780256c936..bea2cb2d90a5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6346,82 +6346,15 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
>   	return ret;
>   }
>   
> -static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode, dev_t rdev)
> +static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
> +			       struct inode *inode)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> -	struct btrfs_trans_handle *trans;
>   	struct btrfs_root *root = BTRFS_I(dir)->root;
> -	struct inode *inode;
> +	struct btrfs_trans_handle *trans;
>   	int err;
>   	u64 index = 0;
>   
> -	inode = new_inode(dir->i_sb);
> -	if (!inode)
> -		return -ENOMEM;
> -	inode_init_owner(mnt_userns, inode, dir, mode);
> -	inode->i_op = &btrfs_special_inode_operations;
> -	init_special_inode(inode, inode->i_mode, rdev);
> -
> -	/*
> -	 * 2 for inode item and ref
> -	 * 2 for dir items
> -	 * 1 for xattr if selinux is on
> -	 */
> -	trans = btrfs_start_transaction(root, 5);
> -	if (IS_ERR(trans)) {
> -		iput(inode);
> -		return PTR_ERR(trans);
> -	}
> -
> -	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> -			      dentry->d_name.len, &index);
> -	if (err) {
> -		iput(inode);
> -		inode = NULL;
> -		goto out_unlock;
> -	}
> -
> -	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> -	if (err)
> -		goto out_unlock;
> -
> -	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
> -			     dentry->d_name.name, dentry->d_name.len, 0, index);
> -	if (err)
> -		goto out_unlock;
> -
> -	btrfs_update_inode(trans, root, BTRFS_I(inode));
> -	d_instantiate_new(dentry, inode);
> -
> -out_unlock:
> -	btrfs_end_transaction(trans);
> -	btrfs_btree_balance_dirty(fs_info);
> -	if (err && inode) {
> -		inode_dec_link_count(inode);
> -		discard_new_inode(inode);
> -	}
> -	return err;
> -}
> -
> -static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
> -			struct dentry *dentry, umode_t mode, bool excl)
> -{
> -	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> -	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *root = BTRFS_I(dir)->root;
> -	struct inode *inode;
> -	int err;
> -	u64 index = 0;
> -
> -	inode = new_inode(dir->i_sb);
> -	if (!inode)
> -		return -ENOMEM;
> -	inode_init_owner(mnt_userns, inode, dir, mode);
> -	inode->i_fop = &btrfs_file_operations;
> -	inode->i_op = &btrfs_file_inode_operations;
> -	inode->i_mapping->a_ops = &btrfs_aops;
> -
>   	/*
>   	 * 2 for inode item and ref
>   	 * 2 for dir items
> @@ -6466,6 +6399,35 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
>   	return err;
>   }
>   
> +static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> +		       struct dentry *dentry, umode_t mode, dev_t rdev)
> +{
> +	struct inode *inode;
> +
> +	inode = new_inode(dir->i_sb);
> +	if (!inode)
> +		return -ENOMEM;
> +	inode_init_owner(mnt_userns, inode, dir, mode);
> +	inode->i_op = &btrfs_special_inode_operations;
> +	init_special_inode(inode, inode->i_mode, rdev);
> +	return btrfs_create_common(dir, dentry, inode);
> +}
> +
> +static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
> +			struct dentry *dentry, umode_t mode, bool excl)
> +{
> +	struct inode *inode;
> +
> +	inode = new_inode(dir->i_sb);
> +	if (!inode)
> +		return -ENOMEM;
> +	inode_init_owner(mnt_userns, inode, dir, mode);
> +	inode->i_fop = &btrfs_file_operations;
> +	inode->i_op = &btrfs_file_inode_operations;
> +	inode->i_mapping->a_ops = &btrfs_aops;
> +	return btrfs_create_common(dir, dentry, inode);
> +}
> +
>   static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>   		      struct dentry *dentry)
>   {
> @@ -6547,12 +6509,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>   static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   		       struct dentry *dentry, umode_t mode)
>   {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
>   	struct inode *inode;
> -	struct btrfs_trans_handle *trans;
> -	struct btrfs_root *root = BTRFS_I(dir)->root;
> -	int err;
> -	u64 index = 0;
>   
>   	inode = new_inode(dir->i_sb);
>   	if (!inode)
> @@ -6560,50 +6517,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>   	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
>   	inode->i_op = &btrfs_dir_inode_operations;
>   	inode->i_fop = &btrfs_dir_file_operations;
> -
> -	/*
> -	 * 2 items for inode and ref
> -	 * 2 items for dir items
> -	 * 1 for xattr if selinux is on
> -	 */
> -	trans = btrfs_start_transaction(root, 5);
> -	if (IS_ERR(trans)) {
> -		iput(inode);
> -		return PTR_ERR(trans);
> -	}
> -
> -	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> -			      dentry->d_name.len, &index);
> -	if (err) {
> -		iput(inode);
> -		inode = NULL;
> -		goto out_fail;
> -	}
> -
> -	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> -	if (err)
> -		goto out_fail;
> -
> -	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
> -	if (err)
> -		goto out_fail;
> -
> -	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
> -			dentry->d_name.name,
> -			dentry->d_name.len, 0, index);
> -	if (err)
> -		goto out_fail;
> -
> -	d_instantiate_new(dentry, inode);
> -
> -out_fail:
> -	btrfs_end_transaction(trans);
> -	if (err && inode) {
> -		inode_dec_link_count(inode);
> -		discard_new_inode(inode);
> -	}
> -	btrfs_btree_balance_dirty(fs_info);
> -	return err;
> +	return btrfs_create_common(dir, dentry, inode);
>   }
>   
>   static noinline int uncompress_inline(struct btrfs_path *path,
