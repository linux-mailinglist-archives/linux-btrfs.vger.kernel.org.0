Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE34D6B7F
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 01:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiCLAmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiCLAmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 19:42:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FF226E01E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:41:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so9613129pjb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CIQo14L38Q7qPdQHYjxbxWZWjz+AuJ8Nkqd/cyZjw5A=;
        b=jOVqPeNz9PaKUIz+Bgv48Lqlcz0/lPqjJvaoJBYgkBXGgZlyQrDHJcwq8bZG6FSrck
         4vKSSHNWfe7gjH9fuiVU/adtwfV2Zw1cd0FqO76GOIpEqQvmT9GOvDYxcTM+36df/M0i
         p41P60zFbyAzAz6PQ/HfCKKlbfNPjUpwq4Cgso/x/dMX88Rn3a4lWPfMEbs85FXl0rW2
         DGRdySUcNeRZ3jj1VNMvNmlt7JGhhUVz2uk68RGHTXo3NfH+sADjDDFMFZHCSJAKED1V
         qhpzYkeu+k8O9ghIm5u6usD9pEHvDWDa4z7W3+SZD7clbmeBvjqLv+BKoymAHUvkkDU5
         NiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CIQo14L38Q7qPdQHYjxbxWZWjz+AuJ8Nkqd/cyZjw5A=;
        b=FbQ9ngrfbYEKsB2Z8nCxAdIVEb3qxec+LBGRHRHmjKTFyaB3ouex5EQJqnSR2JaWDU
         4WPVt1j+0UbMUKhU+MRgLlbmYaHUxt9rmMCz9CUxpGbpefNtC6zcYn5+khUvSWf6CKp+
         9RLrMq7MWo7CrVkspLBrq9IpyCy6c1PVZaIepEDwIZ9m6aDlwmZau0xYiosizkUjhThB
         G2K0bqR5++7jbxQ6Rj4kDweCFY5davN/v2yVp6TvS+d44QPAZtc/HepMC3EgBC9qLNeD
         iznvRMCspKL7xWfZZ3L+s3lH0u3bQxd1d49+CmONmz385Ag1GDyufC8KNkIur34WxU4z
         crCQ==
X-Gm-Message-State: AOAM532IHQGnF/ZgvYzYTAQm2adjJ2NBFnBTePosdW5GnSz04hAWngPa
        sPD8cJhTja+qnTsRf3gkGUuo5eoJJr+DvA==
X-Google-Smtp-Source: ABdhPJzlxFKTtKAWXWw7QnTbFKtkokeJlFkS/RloV03xnctY/YnbxCrf5QI1buyY/B2TQEErQduEEA==
X-Received: by 2002:a17:90b:1a81:b0:1bc:ec26:40a6 with SMTP id ng1-20020a17090b1a8100b001bcec2640a6mr13517280pjb.0.1647045678139;
        Fri, 11 Mar 2022 16:41:18 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9b1])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm9508746pga.58.2022.03.11.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:41:17 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:41:16 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 13/16] btrfs: allocate inode outside of
 btrfs_new_inode()
Message-ID: <YivsLP3YP2VUoa9I@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
 <be62317b-7cd1-2247-2e33-145ff8cb9a61@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be62317b-7cd1-2247-2e33-145ff8cb9a61@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 12:11:03PM -0500, Sweet Tea Dorminy wrote:
> On 3/9/22 20:31, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Instead of calling new_inode() and inode_init_owner() inside of
> > btrfs_new_inode(), do it in the callers. This allows us to pass in just
> > the inode instead of the mnt_userns and mode and removes the need for
> > memalloc_nofs_{save,restores}() since we do it before starting a
> > transaction. This also paves the way for some more cleanups in later
> > patches.
> > 
> > This also removes the comments about Smack checking i_op, which are no
> > longer true since commit 5d6c31910bc0 ("xattr: Add
> > __vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags &
> > IOP_XATTR, which is set based on sb->s_xattr.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   fs/btrfs/ctree.h |   5 +-
> >   fs/btrfs/inode.c | 284 +++++++++++++++++++++++++----------------------
> >   fs/btrfs/ioctl.c |  22 ++--
> >   3 files changed, 167 insertions(+), 144 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 4db17bd05a21..f39730420e8a 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3254,10 +3254,11 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >   int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
> >   			      unsigned int extra_bits,
> >   			      struct extent_state **cached_state);
> > +struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
> > +				     struct inode *dir);
> >   int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> > -			     struct btrfs_root *new_root,
> >   			     struct btrfs_root *parent_root,
> > -			     struct user_namespace *mnt_userns);
> > +			     struct inode *inode);
> >    void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
> >   			       unsigned *bits);
> >   void btrfs_clear_delalloc_extent(struct inode *inode,
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index c47bdada2440..ff780256c936 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -6090,15 +6090,12 @@ static void btrfs_inherit_iflags(struct inode *inode, struct inode *dir)
> >   	btrfs_sync_inode_flags_to_i_flags(inode);
> >   }
> > -static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> > -				     struct btrfs_root *root,
> > -				     struct user_namespace *mnt_userns,
> > -				     struct inode *dir,
> > -				     const char *name, int name_len,
> > -				     umode_t mode, u64 *index)
> > +static int btrfs_new_inode(struct btrfs_trans_handle *trans,
> > +			   struct btrfs_root *root, struct inode *inode,
> > +			   struct inode *dir, const char *name, int name_len,
> > +			   u64 *index)
> 
> 
> This is a triviality, but now that it doesn't allocate a new inode, I'm not
> sure it deserves the word 'new' in its name -- new_inode() does the
> allocation, and then inode_init_owner() initializes some part of the new
> inode, and then btrfs_new_inode() initializes the rest. Might it be worth
> renaming it something that emphasizes that it initializes a preallocated
> inode, btrfs_prepare/init/init_new/etc_inode()?

One of the later changes renames it to btrfs_create_new_inode(). I.e.,
it creates (on disk) a new inode that you allocated.

> >   {
> >   	struct btrfs_fs_info *fs_info = root->fs_info;
> > -	struct inode *inode;
> >   	struct btrfs_inode_item *inode_item;
> >   	struct btrfs_key *location;
> >   	struct btrfs_path *path;
> > @@ -6108,20 +6105,11 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   	u32 sizes[2];
> >   	struct btrfs_item_batch batch;
> >   	unsigned long ptr;
> > -	unsigned int nofs_flag;
> >   	int ret;
> >   	path = btrfs_alloc_path();
> >   	if (!path)
> > -		return ERR_PTR(-ENOMEM);
> > -
> > -	nofs_flag = memalloc_nofs_save();
> > -	inode = new_inode(fs_info->sb);
> > -	memalloc_nofs_restore(nofs_flag);
> > -	if (!inode) {
> > -		btrfs_free_path(path);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > +		return -ENOMEM;
> >   	/*
> >   	 * O_TMPFILE, set link count to 0, so that after this point,
> > @@ -6133,8 +6121,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   	ret = btrfs_get_free_objectid(root, &objectid);
> >   	if (ret) {
> >   		btrfs_free_path(path);
> > -		iput(inode);
> > -		return ERR_PTR(ret);
> > +		return ret;
> >   	}
> >   	inode->i_ino = objectid;
> > @@ -6144,8 +6131,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   		ret = btrfs_set_inode_index(BTRFS_I(dir), index);
> >   		if (ret) {
> >   			btrfs_free_path(path);
> > -			iput(inode);
> > -			return ERR_PTR(ret);
> > +			return ret;
> >   		}
> >   	} else if (dir) {
> >   		*index = 0;
> > @@ -6163,7 +6149,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   	btrfs_inherit_iflags(inode, dir);
> > -	if (S_ISREG(mode)) {
> > +	if (S_ISREG(inode->i_mode)) {
> >   		if (btrfs_test_opt(fs_info, NODATASUM))
> >   			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
> >   		if (btrfs_test_opt(fs_info, NODATACOW))
> > @@ -6208,10 +6194,8 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   	location->type = BTRFS_INODE_ITEM_KEY;
> >   	ret = btrfs_insert_inode_locked(inode);
> > -	if (ret < 0) {
> > -		iput(inode);
> > +	if (ret < 0)
> >   		goto fail;
> > -	}
> >   	batch.keys = &key[0];
> >   	batch.data_sizes = &sizes[0];
> > @@ -6221,8 +6205,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   	if (ret != 0)
> >   		goto fail_unlock;
> > -	inode_init_owner(mnt_userns, inode, dir, mode);
> > -
> >   	inode->i_mtime = current_time(inode);
> >   	inode->i_atime = inode->i_mtime;
> >   	inode->i_ctime = inode->i_mtime;
> > @@ -6259,15 +6241,20 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
> >   			  "error inheriting props for ino %llu (root %llu): %d",
> >   			btrfs_ino(BTRFS_I(inode)), root->root_key.objectid, ret);
> > -	return inode;
> > +	return 0;
> >   fail_unlock:
> > +	/*
> > +	 * discard_new_inode() calls iput(), but the caller owns the reference
> > +	 * to the inode.
> > +	 */
> > +	ihold(inode);
> >   	discard_new_inode(inode);
> >   fail:
> >   	if (dir && name)
> >   		BTRFS_I(dir)->index_cnt--;
> >   	btrfs_free_path(path);
> > -	return ERR_PTR(ret);
> > +	return ret;
> >   }
> >   /*
> > @@ -6365,37 +6352,36 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> >   	struct btrfs_trans_handle *trans;
> >   	struct btrfs_root *root = BTRFS_I(dir)->root;
> > -	struct inode *inode = NULL;
> > +	struct inode *inode;
> >   	int err;
> >   	u64 index = 0;
> > +	inode = new_inode(dir->i_sb);
> > +	if (!inode)
> > +		return -ENOMEM;
> > +	inode_init_owner(mnt_userns, inode, dir, mode);
> > +	inode->i_op = &btrfs_special_inode_operations;
> > +	init_special_inode(inode, inode->i_mode, rdev);
> > +
> >   	/*
> >   	 * 2 for inode item and ref
> >   	 * 2 for dir items
> >   	 * 1 for xattr if selinux is on
> >   	 */
> >   	trans = btrfs_start_transaction(root, 5);
> > -	if (IS_ERR(trans))
> > +	if (IS_ERR(trans)) {
> > +		iput(inode);
> >   		return PTR_ERR(trans);
> > +	}
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
> > -			dentry->d_name.name, dentry->d_name.len,
> > -			mode, &index);
> > -	if (IS_ERR(inode)) {
> > -		err = PTR_ERR(inode);
> > +	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> > +			      dentry->d_name.len, &index);
> > +	if (err) {
> > +		iput(inode);
> >   		inode = NULL;
> >   		goto out_unlock;
> >   	}
> > -	/*
> > -	* If the active LSM wants to access the inode during
> > -	* d_instantiate it needs these. Smack checks to see
> > -	* if the filesystem supports xattrs by looking at the
> > -	* ops vector.
> > -	*/
> > -	inode->i_op = &btrfs_special_inode_operations;
> > -	init_special_inode(inode, inode->i_mode, rdev);
> > -
> >   	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> >   	if (err)
> >   		goto out_unlock;
> > @@ -6424,36 +6410,36 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> >   	struct btrfs_trans_handle *trans;
> >   	struct btrfs_root *root = BTRFS_I(dir)->root;
> > -	struct inode *inode = NULL;
> > +	struct inode *inode;
> >   	int err;
> >   	u64 index = 0;
> > +	inode = new_inode(dir->i_sb);
> > +	if (!inode)
> > +		return -ENOMEM;
> > +	inode_init_owner(mnt_userns, inode, dir, mode);
> > +	inode->i_fop = &btrfs_file_operations;
> > +	inode->i_op = &btrfs_file_inode_operations;
> > +	inode->i_mapping->a_ops = &btrfs_aops;
> > +
> >   	/*
> >   	 * 2 for inode item and ref
> >   	 * 2 for dir items
> >   	 * 1 for xattr if selinux is on
> >   	 */
> >   	trans = btrfs_start_transaction(root, 5);
> > -	if (IS_ERR(trans))
> > +	if (IS_ERR(trans)) {
> > +		iput(inode);
> >   		return PTR_ERR(trans);
> > +	}
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
> > -			dentry->d_name.name, dentry->d_name.len,
> > -			mode, &index);
> > -	if (IS_ERR(inode)) {
> > -		err = PTR_ERR(inode);
> > +	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> > +			      dentry->d_name.len, &index);
> > +	if (err) {
> > +		iput(inode);
> >   		inode = NULL;
> >   		goto out_unlock;
> >   	}
> > -	/*
> > -	* If the active LSM wants to access the inode during
> > -	* d_instantiate it needs these. Smack checks to see
> > -	* if the filesystem supports xattrs by looking at the
> > -	* ops vector.
> > -	*/
> > -	inode->i_fop = &btrfs_file_operations;
> > -	inode->i_op = &btrfs_file_inode_operations;
> > -	inode->i_mapping->a_ops = &btrfs_aops;
> >   	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> >   	if (err)
> > @@ -6562,34 +6548,38 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >   		       struct dentry *dentry, umode_t mode)
> >   {
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> > -	struct inode *inode = NULL;
> > +	struct inode *inode;
> >   	struct btrfs_trans_handle *trans;
> >   	struct btrfs_root *root = BTRFS_I(dir)->root;
> > -	int err = 0;
> > +	int err;
> >   	u64 index = 0;
> > +	inode = new_inode(dir->i_sb);
> > +	if (!inode)
> > +		return -ENOMEM;
> > +	inode_init_owner(mnt_userns, inode, dir, S_IFDIR | mode);
> > +	inode->i_op = &btrfs_dir_inode_operations;
> > +	inode->i_fop = &btrfs_dir_file_operations;
> > +
> >   	/*
> >   	 * 2 items for inode and ref
> >   	 * 2 items for dir items
> >   	 * 1 for xattr if selinux is on
> >   	 */
> >   	trans = btrfs_start_transaction(root, 5);
> > -	if (IS_ERR(trans))
> > +	if (IS_ERR(trans)) {
> > +		iput(inode);
> >   		return PTR_ERR(trans);
> > +	}
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
> > -			dentry->d_name.name, dentry->d_name.len,
> > -			S_IFDIR | mode, &index);
> > -	if (IS_ERR(inode)) {
> > -		err = PTR_ERR(inode);
> > +	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> > +			      dentry->d_name.len, &index);
> > +	if (err) {
> > +		iput(inode);
> >   		inode = NULL;
> >   		goto out_fail;
> >   	}
> > -	/* these must be set before we unlock the inode */
> > -	inode->i_op = &btrfs_dir_inode_operations;
> > -	inode->i_fop = &btrfs_dir_file_operations;
> > -
> >   	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> >   	if (err)
> >   		goto out_fail;
> > @@ -8747,25 +8737,39 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
> >   	return ret;
> >   }
> > +struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
> > +				     struct inode *dir)
> > +{
> > +	struct inode *inode;
> > +
> > +	inode = new_inode(dir->i_sb);
> > +	if (inode) {
> > +		/*
> > +		 * Subvolumes don't inherit the sgid bit or the parent's gid if
> > +		 * the parent's sgid bit is set. This is probably a bug.
> > +		 */
> > +		inode_init_owner(mnt_userns, inode, NULL,
> > +				 S_IFDIR | (~current_umask() & S_IRWXUGO));
> > +		inode->i_op = &btrfs_dir_inode_operations;
> > +		inode->i_fop = &btrfs_dir_file_operations;
> > +	}
> > +	return inode;
> > +}
> > +
> >   /*
> >    * create a new subvolume directory/inode (helper for the ioctl).
> >    */
> >   int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> > -			     struct btrfs_root *new_root,
> >   			     struct btrfs_root *parent_root,
> > -			     struct user_namespace *mnt_userns)
> > +			     struct inode *inode)
> >   {
> > -	struct inode *inode;
> > +	struct btrfs_root *new_root = BTRFS_I(inode)->root;
> >   	int err;
> >   	u64 index = 0;
> > -	inode = btrfs_new_inode(trans, new_root, mnt_userns, NULL, "..", 2,
> > -				S_IFDIR | (~current_umask() & S_IRWXUGO),
> > -				&index);
> > -	if (IS_ERR(inode))
> > -		return PTR_ERR(inode);
> > -	inode->i_op = &btrfs_dir_inode_operations;
> > -	inode->i_fop = &btrfs_dir_file_operations;
> > +	err = btrfs_new_inode(trans, new_root, inode, NULL, "..", 2, &index);
> > +	if (err)
> > +		return err;
> >   	unlock_new_inode(inode);
> > @@ -8776,8 +8780,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> >   			  new_root->root_key.objectid, err);
> >   	err = btrfs_update_inode(trans, new_root, BTRFS_I(inode));
> > -
> > -	iput(inode);
> >   	return err;
> >   }
> > @@ -9254,31 +9256,36 @@ static int btrfs_rename_exchange(struct inode *old_dir,
> >   	return ret;
> >   }
> > +static struct inode *new_whiteout_inode(struct user_namespace *mnt_userns,
> > +					struct inode *dir)
> > +{
> > +	struct inode *inode;
> > +
> > +	inode = new_inode(dir->i_sb);
> > +	if (inode) {
> > +		inode_init_owner(mnt_userns, inode, dir,
> > +				 S_IFCHR | WHITEOUT_MODE);
> > +		inode->i_op = &btrfs_special_inode_operations;
> > +		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
> > +	}
> > +	return inode;
> > +}
> > +
> >   static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
> >   				     struct btrfs_root *root,
> > -				     struct user_namespace *mnt_userns,
> > -				     struct inode *dir,
> > +				     struct inode *inode, struct inode *dir,
> >   				     struct dentry *dentry)
> >   {
> >   	int ret;
> > -	struct inode *inode;
> >   	u64 index;
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
> > -				dentry->d_name.name,
> > -				dentry->d_name.len,
> > -				S_IFCHR | WHITEOUT_MODE,
> > -				&index);
> > -
> > -	if (IS_ERR(inode)) {
> > -		ret = PTR_ERR(inode);
> > +	ret = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> > +			      dentry->d_name.len, &index);
> > +	if (ret) {
> > +		iput(inode);
> >   		return ret;
> >   	}
> > -	inode->i_op = &btrfs_special_inode_operations;
> > -	init_special_inode(inode, inode->i_mode,
> > -		WHITEOUT_DEV);
> > -
> >   	ret = btrfs_init_inode_security(trans, inode, dir,
> >   				&dentry->d_name);
> >   	if (ret)
> > @@ -9305,6 +9312,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
> >   			unsigned int flags)
> >   {
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
> > +	struct inode *whiteout_inode;
> >   	struct btrfs_trans_handle *trans;
> >   	unsigned int trans_num_items;
> >   	struct btrfs_root *root = BTRFS_I(old_dir)->root;
> > @@ -9359,6 +9367,12 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
> >   	if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
> >   		filemap_flush(old_inode->i_mapping);
> > +	if (flags & RENAME_WHITEOUT) {
> > +		whiteout_inode = new_whiteout_inode(mnt_userns, old_dir);
> > +		if (!whiteout_inode)
> > +			return -ENOMEM;
> > +	}
> > +
> >   	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
> >   		/* close the racy window with snapshot create/destroy ioctl */
> >   		down_read(&fs_info->subvol_sem);
> > @@ -9495,9 +9509,9 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
> >   				   rename_ctx.index, new_dentry->d_parent);
> >   	if (flags & RENAME_WHITEOUT) {
> > -		ret = btrfs_whiteout_for_rename(trans, root, mnt_userns,
> > +		ret = btrfs_whiteout_for_rename(trans, root, whiteout_inode,
> >   						old_dir, old_dentry);
> > -
> > +		whiteout_inode = NULL;
> >   		if (ret) {
> >   			btrfs_abort_transaction(trans, ret);
> >   			goto out_fail;
> > @@ -9509,7 +9523,8 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
> >   out_notrans:
> >   	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
> >   		up_read(&fs_info->subvol_sem);
> > -
> > +	if (flags & RENAME_WHITEOUT)
> > +		iput(whiteout_inode);
> >   	return ret;
> >   }
> > @@ -9728,7 +9743,7 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >   	struct btrfs_root *root = BTRFS_I(dir)->root;
> >   	struct btrfs_path *path;
> >   	struct btrfs_key key;
> > -	struct inode *inode = NULL;
> > +	struct inode *inode;
> >   	int err;
> >   	u64 index = 0;
> >   	int name_len;
> > @@ -9741,6 +9756,14 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >   	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
> >   		return -ENAMETOOLONG;
> > +	inode = new_inode(dir->i_sb);
> > +	if (!inode)
> > +		return -ENOMEM;
> > +	inode_init_owner(mnt_userns, inode, dir, S_IFLNK | S_IRWXUGO);
> > +	inode->i_op = &btrfs_symlink_inode_operations;
> > +	inode_nohighmem(inode);
> > +	inode->i_mapping->a_ops = &btrfs_aops;
> > +
> >   	/*
> >   	 * 2 items for inode item and ref
> >   	 * 2 items for dir items
> > @@ -9749,28 +9772,19 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >   	 * 1 item for xattr if selinux is on
> >   	 */
> >   	trans = btrfs_start_transaction(root, 7);
> > -	if (IS_ERR(trans))
> > +	if (IS_ERR(trans)) {
> > +		iput(inode);
> >   		return PTR_ERR(trans);
> > +	}
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
> > -				dentry->d_name.name, dentry->d_name.len,
> > -				S_IFLNK | S_IRWXUGO, &index);
> > -	if (IS_ERR(inode)) {
> > -		err = PTR_ERR(inode);
> > +	err = btrfs_new_inode(trans, root, inode, dir, dentry->d_name.name,
> > +			      dentry->d_name.len, &index);
> > +	if (err) {
> > +		iput(inode);
> >   		inode = NULL;
> >   		goto out_unlock;
> >   	}
> > -	/*
> > -	* If the active LSM wants to access the inode during
> > -	* d_instantiate it needs these. Smack checks to see
> > -	* if the filesystem supports xattrs by looking at the
> > -	* ops vector.
> > -	*/
> > -	inode->i_fop = &btrfs_file_operations;
> > -	inode->i_op = &btrfs_file_inode_operations;
> > -	inode->i_mapping->a_ops = &btrfs_aops;
> > -
> >   	err = btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
> >   	if (err)
> >   		goto out_unlock;
> > @@ -9806,8 +9820,6 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >   	btrfs_mark_buffer_dirty(leaf);
> >   	btrfs_free_path(path);
> > -	inode->i_op = &btrfs_symlink_inode_operations;
> > -	inode_nohighmem(inode);
> >   	inode_set_bytes(inode, name_len);
> >   	btrfs_i_size_write(BTRFS_I(inode), name_len);
> >   	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
> > @@ -10087,30 +10099,34 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> >   	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
> >   	struct btrfs_trans_handle *trans;
> >   	struct btrfs_root *root = BTRFS_I(dir)->root;
> > -	struct inode *inode = NULL;
> > +	struct inode *inode;
> >   	u64 index;
> > -	int ret = 0;
> > +	int ret;
> > +
> > +	inode = new_inode(dir->i_sb);
> > +	if (!inode)
> > +		return -ENOMEM;
> > +	inode_init_owner(mnt_userns, inode, dir, mode);
> > +	inode->i_fop = &btrfs_file_operations;
> > +	inode->i_op = &btrfs_file_inode_operations;
> > +	inode->i_mapping->a_ops = &btrfs_aops;
> >   	/*
> >   	 * 5 units required for adding orphan entry
> >   	 */
> >   	trans = btrfs_start_transaction(root, 5);
> > -	if (IS_ERR(trans))
> > +	if (IS_ERR(trans)) {
> > +		iput(inode);
> >   		return PTR_ERR(trans);
> > +	}
> > -	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
> > -			mode, &index);
> > -	if (IS_ERR(inode)) {
> > -		ret = PTR_ERR(inode);
> > +	ret = btrfs_new_inode(trans, root, inode, dir, NULL, 0, &index);
> > +	if (ret) {
> > +		iput(inode);
> >   		inode = NULL;
> >   		goto out;
> >   	}
> > -	inode->i_fop = &btrfs_file_operations;
> > -	inode->i_op = &btrfs_file_inode_operations;
> > -
> > -	inode->i_mapping->a_ops = &btrfs_aops;
> > -
> >   	ret = btrfs_init_inode_security(trans, inode, dir, NULL);
> >   	if (ret)
> >   		goto out;
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 891352fd6d0f..60c907b14547 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -587,6 +587,12 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
> >   	if (ret < 0)
> >   		goto out_root_item;
> > +	inode = btrfs_new_subvol_inode(mnt_userns, dir);
> > +	if (!inode) {
> > +		ret = -ENOMEM;
> > +		goto out_anon_dev;
> > +	}
> > +
> >   	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
> >   	/*
> >   	 * The same as the snapshot creation, please see the comment
> > @@ -594,13 +600,13 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
> >   	 */
> >   	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 8, false);
> >   	if (ret)
> > -		goto out_anon_dev;
> > +		goto out_inode;
> >   	trans = btrfs_start_transaction(root, 0);
> >   	if (IS_ERR(trans)) {
> >   		ret = PTR_ERR(trans);
> >   		btrfs_subvolume_release_metadata(root, &block_rsv);
> > -		goto out_anon_dev;
> > +		goto out_inode;
> >   	}
> >   	trans->block_rsv = &block_rsv;
> >   	trans->bytes_reserved = block_rsv.size;
> > @@ -683,16 +689,16 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
> >   	}
> >   	/* anon_dev is owned by new_root now. */
> >   	anon_dev = 0;
> > +	BTRFS_I(inode)->root = new_root;
> > +	/* ... and new_root is owned by inode now. */
> >   	ret = btrfs_record_root_in_trans(trans, new_root);
> >   	if (ret) {
> > -		btrfs_put_root(new_root);
> >   		btrfs_abort_transaction(trans, ret);
> >   		goto out;
> >   	}
> > -	ret = btrfs_create_subvol_root(trans, new_root, root, mnt_userns);
> > -	btrfs_put_root(new_root);
> > +	ret = btrfs_create_subvol_root(trans, root, inode);
> >   	if (ret) {
> >   		/* We potentially lose an unused inode item here */
> >   		btrfs_abort_transaction(trans, ret);
> > @@ -745,11 +751,11 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
> >   		ret = btrfs_commit_transaction(trans);
> >   	if (!ret) {
> > -		inode = btrfs_lookup_dentry(dir, dentry);
> > -		if (IS_ERR(inode))
> > -			return PTR_ERR(inode);
> >   		d_instantiate(dentry, inode);
> > +		inode = NULL;
> >   	}
> 
> I don't understand this. Why do we not need to look up the dentry anymore? 
> Was that always unneeded?

We previously needed it because btrfs_create_subvol_root() did not
return the struct inode it created, so to get it back here, we had to
look it up. (In fact, it might even be the case that the struct inode
allocated by btrfs_create_subvol_root() is freed by its call to iput(),
and then btrfs_lookup_dentry() has to reread it from the B-tree, which
would be silly.)

But now create_subvol() allocates the inode itself, so it has it handy
to use here.
