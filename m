Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B674C4D6B83
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 01:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiCLAql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 19:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiCLAql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 19:46:41 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0A1C9B6A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:45:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so12477246pjb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vB5SBmOmCAG0V6OAe0ZUsHNTHFBw1rRbJS06CllO3+k=;
        b=z3ipYpRTImfY9iwI5rcK8Zcbfj0IJ/t/ieOGk2n+QrXOFpuxJIdPKx7iaozMU2ftm5
         1Utyyo2W/U76Da9EsXFdjWM7oDLu64bynP0vGbNpbhEeX2XE6bF99a/M9QO69OZJfb2x
         ++g0Ca82Okl6eTV/MV3gPH1VKug5crSJ5aZiwesuk/xk8GCZZahgJrkf6UgtQMhfLu8h
         iiclq9F5bup3daC+V8UDpunAheoWTpuB062HU9CxGEW7pDps1xzhStYsvT/s7qgw/0N2
         /8tSxE0r0luIFhAdzDu+dy8AA4QcwAuFZVNUvmShK3Pbyvyk/67JIZtXPfgvo+5An19d
         bn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vB5SBmOmCAG0V6OAe0ZUsHNTHFBw1rRbJS06CllO3+k=;
        b=SiIL1C4PRZRPs7rKF5BH6aCMFG7eU+ls/unbHr2rhwQYvccqelU6E0+gRZj8inwYuu
         tlgIA2ybLr2NeLSf7vtAeTt965VjBEthnq7gC+MqEMnZTp8tWgLqUKMY4DTtwUR1xUgF
         b3uh963r2z6x/MUZ9/PNJiwXkMhNt88h4KY93AC5qEHHPlyscNZZdG1G8mtuz498aMtd
         UOXLbh0vlA94aFE9yAfxc7Dk8e6QjTTGpZ7Bjb4wfLp7lyeuQHqO2XJ5tdrBiBGJ83U8
         eSFsCabpvscgC/0hZvm6icl0plXs4xI8DyuJX9jArANZDbb3Jy6Y3G/QK52QK1FPPf7N
         6q2Q==
X-Gm-Message-State: AOAM5328wmyyaR30yLATySgz9cgDaLXxatEUhORxTmjbMO3+6en1bsnm
        RRHJ43aT01GuAyBV0iwj6HLlVg==
X-Google-Smtp-Source: ABdhPJyfJLM5siSq6+OWWhsqQi+PEq9ouXAmhzvhPZxxXZVsALiy6RFuA3qApbkUU4E7y4SJkWQp7A==
X-Received: by 2002:a17:90a:eb0b:b0:1be:ddea:29ef with SMTP id j11-20020a17090aeb0b00b001beddea29efmr24361934pjz.126.1647045936175;
        Fri, 11 Mar 2022 16:45:36 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9b1])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm5888768pfj.146.2022.03.11.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:45:35 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:45:34 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 15/16] btrfs: reserve correct number of items for
 inode creation
Message-ID: <YivtLhfbqAIw/aps@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <bdde51c0d6c3e20d3c0e1566f0342bc1820a2116.1646875648.git.osandov@fb.com>
 <b3ad488a-862d-6394-4bc8-2bd1bd443b5b@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ad488a-862d-6394-4bc8-2bd1bd443b5b@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 12:56:43PM -0500, Sweet Tea Dorminy wrote:
> 
> On 3/9/22 20:31, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The various inode creation code paths do not account for the compression
> > property, POSIX ACLs, or the parent inode item when starting a
> > transaction. Fix it by refactoring all of these code paths to use a new
> > function, btrfs_new_inode_prepare(), which computes the correct number
> > of items. To do so, it needs to know whether POSIX ACLs will be created,
> > so move the ACL creation into that function. To reduce the number of
> > arguments that need to be passed around for inode creation, define
> > struct btrfs_new_inode_args containing all of the relevant information.
> > 
> > btrfs_new_inode_prepare() will also be a good place to set up the
> > fscrypt context and encrypted filename in the future.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   fs/btrfs/acl.c   |  36 +------
> >   fs/btrfs/ctree.h |  34 +++++--
> >   fs/btrfs/inode.c | 256 ++++++++++++++++++++++++++++++++++-------------
> >   fs/btrfs/ioctl.c |  83 ++++++++++-----
> >   4 files changed, 277 insertions(+), 132 deletions(-)
> > 
> > diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
> > index a6909ec9bc38..548d6a5477b4 100644
> > --- a/fs/btrfs/acl.c
> > +++ b/fs/btrfs/acl.c
> > @@ -55,8 +55,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
> >   	return acl;
> >   }
> > -static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
> > -			   struct inode *inode, struct posix_acl *acl, int type)
> > +int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
> > +		    struct posix_acl *acl, int type)
> >   {
> >   	int ret, size = 0;
> >   	const char *name;
> > @@ -127,35 +127,3 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >   		inode->i_mode = old_mode;
> >   	return ret;
> >   }
> > -
> > -int btrfs_init_acl(struct btrfs_trans_handle *trans,
> > -		   struct inode *inode, struct inode *dir)
> > -{
> > -	struct posix_acl *default_acl, *acl;
> > -	int ret = 0;
> > -
> > -	/* this happens with subvols */
> > -	if (!dir)
> > -		return 0;
> > -
> > -	ret = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (default_acl) {
> > -		ret = __btrfs_set_acl(trans, inode, default_acl,
> > -				      ACL_TYPE_DEFAULT);
> > -		posix_acl_release(default_acl);
> > -	}
> > -
> > -	if (acl) {
> > -		if (!ret)
> > -			ret = __btrfs_set_acl(trans, inode, acl,
> > -					      ACL_TYPE_ACCESS);
> > -		posix_acl_release(acl);
> > -	}
> > -
> > -	if (!default_acl && !acl)
> > -		cache_no_acl(inode);
> > -	return ret;
> > -}
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index f39730420e8a..322c02610e9e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3254,11 +3254,32 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >   int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
> >   			      unsigned int extra_bits,
> >   			      struct extent_state **cached_state);
> > +struct btrfs_new_inode_args {
> > +	/* Input */
> > +	struct inode *dir;
> > +	struct dentry *dentry;
> > +	struct inode *inode;
> > +	bool orphan;
> > +	bool subvol;
> > +
> > +	/*
> > +	 * Output from btrfs_new_inode_prepare(), input to
> > +	 * btrfs_create_new_inode().
> > +	 */
> > +	struct posix_acl *default_acl;
> > +	struct posix_acl *acl;
> > +};
> > +int btrfs_new_inode_prepare(struct btrfs_new_inode_args *args,
> > +			    unsigned int *trans_num_items);
> > +int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
> > +			   struct btrfs_new_inode_args *args,
> > +			   u64 *index);
> > +void btrfs_new_inode_args_destroy(struct btrfs_new_inode_args *args);
> >   struct inode *btrfs_new_subvol_inode(struct user_namespace *mnt_userns,
> >   				     struct inode *dir);
> >   int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
> >   			     struct btrfs_root *parent_root,
> > -			     struct inode *inode);
> > +			     struct btrfs_new_inode_args *args);
> >    void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
> >   			       unsigned *bits);
> >   void btrfs_clear_delalloc_extent(struct inode *inode,
> > @@ -3816,15 +3837,16 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
> >   struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
> >   int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
> >   		  struct posix_acl *acl, int type);
> > -int btrfs_init_acl(struct btrfs_trans_handle *trans,
> > -		   struct inode *inode, struct inode *dir);
> > +int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
> > +		    struct posix_acl *acl, int type);
> >   #else
> >   #define btrfs_get_acl NULL
> >   #define btrfs_set_acl NULL
> > -static inline int btrfs_init_acl(struct btrfs_trans_handle *trans,
> > -				 struct inode *inode, struct inode *dir)
> > +static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
> > +				  struct inode *inode, struct posix_acl *acl,
> > +				  int type)
> >   {
> > -	return 0;
> > +	return -EOPNOTSUPP;
> >   }
> >   #endif
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index bea2cb2d90a5..e2b1b1969d0b 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -223,14 +223,26 @@ static int btrfs_dirty_inode(struct inode *inode);
> >   static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
> >   				     struct inode *inode,  struct inode *dir,
> > -				     const struct qstr *qstr)
> > +				     const struct qstr *qstr,
> > +				     struct posix_acl *default_acl,
> > +				     struct posix_acl *acl)
> >   {
> >   	int err;
> > -	err = btrfs_init_acl(trans, inode, dir);
> > -	if (!err)
> > -		err = btrfs_xattr_security_init(trans, inode, dir, qstr);
> > -	return err;
> > +	if (default_acl) {
> > +		err = __btrfs_set_acl(trans, inode, default_acl,
> > +				      ACL_TYPE_DEFAULT);
> > +		if (err)
> > +			return err;
> > +	}
> > +	if (acl) {
> > +		err = __btrfs_set_acl(trans, inode, acl, ACL_TYPE_ACCESS);
> > +		if (err)
> > +			return err;
> > +	}
> > +	if (!default_acl && !acl)
> > +		cache_no_acl(inode);
> > +	return btrfs_xattr_security_init(trans, inode, dir, qstr);
> >   }
> 
> 
> Would it be worth making this take a btrfs_new_inode_args also, since
> basically everything it needs is contained therein? I think the only place
> calling btrfs_init_inode_security() with params not just pulled out of the
> btrfs_new_inode_args is btrfs_tempfile, which is passing a NULL name instead
> of &dentry->d_name; I'm not clear on why in that case it's different...

That's a good idea, I'll do that.
