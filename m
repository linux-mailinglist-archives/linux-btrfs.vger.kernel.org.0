Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA34D681A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiCKR5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 12:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbiCKR5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 12:57:48 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088571C60DA
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 09:56:44 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 6FE458076A;
        Fri, 11 Mar 2022 12:56:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1647021404; bh=NZPQHQXaD19VIkyhmHkb7Q4Ts6SI4bT2SPx1QFECv3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jNmcmDsyjOQtz8FU2Vty4h+kGK7vgtmEzos8kJi9jV+EOwYUnOnvzyFbUHqYWFTOb
         wuc8o2S52U4un5kqTYcUrf9YLqwDnVQaVb6TSKEU1/oegq9xzuPlyRvN/tuVMZmxas
         iqVlVL60kywqi4lX83A76x5txhALFMCHnTlkP059+QsDzEjakWQFx5yvDLus6m0saQ
         evG7fnPoVXkZ17bEhpYhMoNp4UXhkdjByo7cSEi8qsaHbcUf60svQBAVU7wQXsdian
         d5qTthWLwmrzDkVC6ecXKOWSIT0j2QR/sax/jSIeoWCj4Vq1gpVCtM6Ch1jIAJmX6p
         LGqu+hhcIwmjg==
Message-ID: <b3ad488a-862d-6394-4bc8-2bd1bd443b5b@dorminy.me>
Date:   Fri, 11 Mar 2022 12:56:43 -0500
MIME-Version: 1.0
Subject: Re: [PATCH v2 15/16] btrfs: reserve correct number of items for inode
 creation
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <cover.1646875648.git.osandov@fb.com>
 <bdde51c0d6c3e20d3c0e1566f0342bc1820a2116.1646875648.git.osandov@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <bdde51c0d6c3e20d3c0e1566f0342bc1820a2116.1646875648.git.osandov@fb.com>
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
> The various inode creation code paths do not account for the compression
> property, POSIX ACLs, or the parent inode item when starting a
> transaction. Fix it by refactoring all of these code paths to use a new
> function, btrfs_new_inode_prepare(), which computes the correct number
> of items. To do so, it needs to know whether POSIX ACLs will be created,
> so move the ACL creation into that function. To reduce the number of
> arguments that need to be passed around for inode creation, define
> struct btrfs_new_inode_args containing all of the relevant information.
>
> btrfs_new_inode_prepare() will also be a good place to set up the
> fscrypt context and encrypted filename in the future.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   fs/btrfs/acl.c   |  36 +------
>   fs/btrfs/ctree.h |  34 +++++--
>   fs/btrfs/inode.c | 256 ++++++++++++++++++++++++++++++++++-------------
>   fs/btrfs/ioctl.c |  83 ++++++++++-----
>   4 files changed, 277 insertions(+), 132 deletions(-)
>
> diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
> index a6909ec9bc38..548d6a5477b4 100644
> --- a/fs/btrfs/acl.c
> +++ b/fs/btrfs/acl.c
> @@ -55,8 +55,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
>   	return acl;
>   }
>   
> -static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
> -			   struct inode *inode, struct posix_acl *acl, int type)
> +int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
> +		    struct posix_acl *acl, int type)
>   {
>   	int ret, size = 0;
>   	const char *name;
> @@ -127,35 +127,3 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   		inode->i_mode = old_mode;
>   	return ret;
>   }
> -
> -int btrfs_init_acl(struct btrfs_trans_handle *trans,
> -		   struct inode *inode, struct inode *dir)
> -{
> -	struct posix_acl *default_acl, *acl;
> -	int ret = 0;
> -
> -	/* this happens with subvols */
> -	if (!dir)
> -		return 0;
> -
> -	ret = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
> -	if (ret)
> -		return ret;
> -
> -	if (default_acl) {
> -		ret = __btrfs_set_acl(trans, inode, default_acl,
> -				      ACL_TYPE_DEFAULT);
> -		posix_acl_release(default_acl);
> -	}
> -
> -	if (acl) {
> -		if (!ret)
> -			ret = __btrfs_set_acl(trans, inode, acl,
> -					      ACL_TYPE_ACCESS);
> -		posix_acl_release(acl);
> -	}
> -
> -	if (!default_acl && !acl)
> -		cache_no_acl(inode);
> -	return ret;
> -}
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f39730420e8a..322c02610e9e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3254,11 +3254,32 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
>   int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
>   			      unsigned int extra_bits,
>   			      struct extent_state **cached_state);
> +struct btrfs_new_inode_args {
> +	/* Input */
> +	struct inode *dir;
> +	struct dentry *dentry;
> +	struct inode *inode;
> +	bool orphan;
> +	bool subvol;
> +
> +	/*
> +	 * Output from btrfs_new_inode_prepare(), input to
> +	 * btrfs_create_new_inode().
> +	 */
> +	struct posix_acl *default_acl;
> +	struct posix_acl *acl;
> +};
> +int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
> +			    unsigned int *trans_num_items);
> +int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
> +			   struct btrfs_new_inode_args *args,
> +			   u64 *index);
> +void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
>   struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
>   				     struct inode *dir);
>   int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
>   			     struct btrfs_root *parent_root,
> -			     struct inode *inode);
> +			     struct btrfs_new_inode_args *args);
>    void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
>   			       unsigned *bits);
>   void btrfs_clear_delalloc_extent(struct inode *inode,
> @@ -3816,15 +3837,16 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
>   struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
>   int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>   		  struct posix_acl *acl, int type);
> -int btrfs_init_acl(struct btrfs_trans_handle *trans,
> -		   struct inode *inode, struct inode *dir);
> +int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
> +		    struct posix_acl *acl, int type);
>   #else
>   #define btrfs_get_acl NULL
>   #define btrfs_set_acl NULL
> -static inline int btrfs_init_acl(struct btrfs_trans_handle *trans,
> -				 struct inode *inode, struct inode *dir)
> +static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
> +				  struct inode *inode, struct posix_acl *acl,
> +				  int type)
>   {
> -	return 0;
> +	return -EOPNOTSUPP;
>   }
>   #endif
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bea2cb2d90a5..e2b1b1969d0b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -223,14 +223,26 @@ static int btrfs_dirty_inode(struct inode *inode);
>   
>   static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
>   				     struct inode *inode,  struct inode *dir,
> -				     const struct qstr *qstr)
> +				     const struct qstr *qstr,
> +				     struct posix_acl *default_acl,
> +				     struct posix_acl *acl)
>   {
>   	int err;
>   
> -	err = btrfs_init_acl(trans, inode, dir);
> -	if (!err)
> -		err = btrfs_xattr_security_init(trans, inode, dir, qstr);
> -	return err;
> +	if (default_acl) {
> +		err = __btrfs_set_acl(trans, inode, default_acl,
> +				      ACL_TYPE_DEFAULT);
> +		if (err)
> +			return err;
> +	}
> +	if (acl) {
> +		err = __btrfs_set_acl(trans, inode, acl, ACL_TYPE_ACCESS);
> +		if (err)
> +			return err;
> +	}
> +	if (!default_acl && !acl)
> +		cache_no_acl(inode);
> +	return btrfs_xattr_security_init(trans, inode, dir, qstr);
>   }


Would it be worth making this take a btrfs_new_inode_args also, since 
basically everything it needs is contained therein? I think the only 
place calling btrfs_init_inode_security() with params not just pulled 
out of the btrfs_new_inode_args is btrfs_tempfile, which is passing a 
NULL name instead of &dentry->d_name; I'm not clear on why in that case 
it's different...

Either way,

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

