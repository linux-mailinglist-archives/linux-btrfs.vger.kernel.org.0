Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75879918E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjIHVkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbjIHVky (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 17:40:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED721FD9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 14:40:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 512C03200684;
        Fri,  8 Sep 2023 17:40:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Sep 2023 17:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694209245; x=1694295645; bh=Yh
        BC0ah4/DaL7x2ymEY1X+U7Yr8J2T4vBcFRl6cHrFc=; b=iNo0xElabItHG+taVz
        u5NPmPyZUB6d5ubyx41CHfY+Ns+NeKQnO98z8tKroLFTswtjNYCz9io5/rXjp6ib
        oVdud9YXPP2xYv4EG4kuKwn5YbGpTeevZVH9BflU+8jd2wkXKjyeGmdYdW4hdWj9
        sNxRggfzdJvhX3d4wkkFof3aIU9OTjwjOiiNlW6ZN8C7kprwQhuMu98cevX1xXN7
        vuyPStfsrcJTPJ/iaqUINe4pK8/qPGkWMM+dNk781YojpwYApBqS9fQtNq0Q9htE
        AY8i/cBCCfbmFufI6m3sSNmPsaDvAUgZrqkaHo5C/2ox09bEHpljmOEVi1ij6C8z
        gcvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694209245; x=1694295645; bh=YhBC0ah4/DaL7
        x2ymEY1X+U7Yr8J2T4vBcFRl6cHrFc=; b=aBqaP/C5ZeTE0r+pvAHC2elkC3de2
        uk//gOaksiW2uIOi7V0Z7e9M/41XtaQzLdqogClQk78oGXhqSkf+zjZzIwK5yxyW
        2rHk3N9BjZ/8QYffaPSnArg33YtcnyNXahovswAAs9WL9s6aHHx23n7h4Ma2A1hH
        1ifYkOvYpwku9UHLyX3wMBnOdil6cDwFhviYO5i9J1QT1oj0LMwjnWZJMoWi7RIp
        zb06YbYmIVLbBlxLspMIjjpu7wUQ2bZ+98lyAa7ldg8BsRpb1l29dlr4pD/TF6Vu
        7LZ32MVZC+Z5oXCdsJLYy49tsjMhmyYXpokOd51y3VHK8e7hi6lIcF2rA==
X-ME-Sender: <xms:3ZT7ZHvY88bAdXe3UyLWHuUjKToKX3Zq1_rsG1L7myOYloOvBW8Auw>
    <xme:3ZT7ZIfKq00RBfaxmCe1qfC50usajBaItIxj0efloXj1E0aCaQ5UC3X8IOpVGxiGF
    m_SZ7lUV9Do4gDeTVE>
X-ME-Received: <xmr:3ZT7ZKzd7idaPhvZIX8N_9VqXdG2aAQcd8KeLj5Ln8Y3SnT92P42xuIWFbuOiikTOkypMY8Biax-Xa1lWoUAxabkV5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:3ZT7ZGNWUGMNG5zEjc588WPGJjag9CZZ6KjHeo35uH5n_4bqoA4lsA>
    <xmx:3ZT7ZH9-WTDiR4mnM-6v9bnrvclHEXof_a6ytQzb_MaGLknvryeojQ>
    <xmx:3ZT7ZGWSuz2gSCNliCwz5uoVpOR5CUsZ2fi7zG1uFjo1geH0LnFVJw>
    <xmx:3ZT7ZBmrqMdOaJ9QEaLI5l60bTYDbbDkdjPg0ZLSSzakw5ZJtEMOmg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 17:40:45 -0400 (EDT)
Date:   Fri, 8 Sep 2023 14:41:46 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 15/18] btrfs: check generation when recording simple
 quota delta
Message-ID: <20230908214146.GA172348@zen>
References: <cover.1690495785.git.boris@bur.io>
 <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
 <20230907122449.GL3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907122449.GL3159@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 02:24:49PM +0200, David Sterba wrote:
> On Thu, Jul 27, 2023 at 03:13:02PM -0700, Boris Burkov wrote:
> > Simple quotas count extents only from the moment the feature is enabled.
> > Therefore, if we do something like:
> > 1. create subvol S
> > 2. write F in S
> > 3. enable quotas
> > 4. remove F
> > 5. write G in S
> > 
> > then after 3. and 4. we would expect the simple quota usage of S to be 0
> > (putting aside some metadata extents that might be written) and after
> > 5., it should be the size of G plus metadata. Therefore, we need to be
> > able to determine whether a particular quota delta we are processing
> > predates simple quota enablement.
> > 
> > To do this, store the transaction id when quotas were enabled. In
> > fs_info for immediate use and in the quota status item to make it
> > recoverable on mount. When we see a delta, check if the generation of
> > the extent item is less than that of quota enablement. If so, we should
> > ignore the delta from this extent.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/accessors.h            |  2 ++
> >  fs/btrfs/extent-tree.c          |  4 ++++
> >  fs/btrfs/fs.h                   |  2 ++
> >  fs/btrfs/qgroup.c               | 14 ++++++++++++--
> >  fs/btrfs/qgroup.h               |  1 +
> >  include/uapi/linux/btrfs_tree.h |  7 +++++++
> >  6 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> > index a23045c05937..513f8edbd98e 100644
> > --- a/fs/btrfs/accessors.h
> > +++ b/fs/btrfs/accessors.h
> > @@ -970,6 +970,8 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
> >  		   flags, 64);
> >  BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
> >  		   rescan, 64);
> > +BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
> > +		   enable_gen, 64);
> >  
> >  /* btrfs_qgroup_info_item */
> >  BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 1b5efd03ef83..395ab46e520b 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -1513,6 +1513,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
> >  			.rsv_bytes = href->reserved_bytes,
> >  			.is_data = true,
> >  			.is_inc	= true,
> > +			.generation = trans->transid,
> >  		};
> >  
> >  		if (extent_op)
> > @@ -1676,6 +1677,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
> >  			.rsv_bytes = 0,
> >  			.is_data = false,
> >  			.is_inc = true,
> > +			.generation = trans->transid,
> >  		};
> >  
> >  		BUG_ON(!extent_op || !extent_op->update_flags);
> > @@ -3217,6 +3219,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
> >  			.rsv_bytes = 0,
> >  			.is_data = is_data,
> >  			.is_inc = false,
> > +			.generation = btrfs_extent_generation(leaf, ei),
> >  		};
> >  
> >  		/* In this branch refs == 1 */
> > @@ -4850,6 +4853,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
> >  	struct btrfs_simple_quota_delta delta = {
> >  		.root = root_objectid,
> >  		.num_bytes = ins->offset,
> > +		.generation = trans->transid,
> >  		.rsv_bytes = 0,
> >  		.is_data = true,
> >  		.is_inc = true,
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index f76f450c2abf..da7b623ff15f 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -802,6 +802,8 @@ struct btrfs_fs_info {
> >  	spinlock_t eb_leak_lock;
> >  	struct list_head allocated_ebs;
> >  #endif
> > +
> > +	u64 quota_enable_gen;
> 
> Please move it to the other quota/qgroup related members, at the end of
> fs_info there's only debugging stuff.
> 
> >  };
> >  
> >  static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 58e9ed0deedd..a8a603242431 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -454,6 +454,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
> >  			}
> >  			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
> >  			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> > +			if (simple)
> > +				fs_info->quota_enable_gen = btrfs_qgroup_status_enable_gen(l, ptr);
> >  			if (btrfs_qgroup_status_generation(l, ptr) !=
> >  			    fs_info->generation && !simple) {
> >  				qgroup_mark_inconsistent(fs_info);
> > @@ -1107,10 +1109,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> >  	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
> >  	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
> >  	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
> > -	if (simple)
> > +	if (simple) {
> >  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> > -	else
> > +		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
> > +	} else {
> >  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +	}
> >  	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
> >  				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
> >  	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
> > @@ -1202,6 +1206,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> >  		goto out_free_path;
> >  	}
> >  
> > +	fs_info->quota_enable_gen = trans->transid;
> > +
> >  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >  	/*
> >  	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
> > @@ -4622,6 +4628,10 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
> >  	if (!is_fstree(root))
> >  		return 0;
> >  
> > +	/* If the extent predates enabling quotas, don't count it. */
> > +	if (delta->generation < fs_info->quota_enable_gen)
> > +		return 0;
> > +
> >  	spin_lock(&fs_info->qgroup_lock);
> >  	qgroup = find_qgroup_rb(fs_info, root);
> >  	if (!qgroup) {
> > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > index ce6fa8694ca7..ae1ce14b365c 100644
> > --- a/fs/btrfs/qgroup.h
> > +++ b/fs/btrfs/qgroup.h
> > @@ -241,6 +241,7 @@ struct btrfs_simple_quota_delta {
> >  	u64 rsv_bytes; /* The number of bytes reserved for this extent */
> >  	bool is_inc; /* Whether we are using or freeing the extent */
> >  	bool is_data; /* Whether the extent is data or metadata */
> > +	u64 generation; /* The generation the extent was created in */
> 
> Please reorder it so it does not leave gaps between struct members.
> 
> >  };
> >  
> >  static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
> > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > index eacb26caf3c6..1120ce3dae42 100644
> > --- a/include/uapi/linux/btrfs_tree.h
> > +++ b/include/uapi/linux/btrfs_tree.h
> > @@ -1242,6 +1242,13 @@ struct btrfs_qgroup_status_item {
> >  	 * of the scan. It contains a logical address
> >  	 */
> >  	__le64 rescan;
> > +
> > +	/*
> > +	 * the generation when quotas are enabled. Used by simple quotas to
> > +	 * avoid decrementing when freeing an extent that was written before
> > +	 * enable.
> > +	 */
> > +	__le64 enable_gen;
> 
> This is public interface and btrfs_qgroup_status_item is used in many
> places in user space at least in btrfs-progs. This needs a lot of
> sanity checks.

Totally agreed in principle, but not exactly sure how to proceed in
practice. I would definitely appreciate some tips/help!

How we interact with the new field:
- When enabling squota, set it, the incompat bit, and the status flag
- When reading in the qgroup status_item, if the status flag is set,
  then read the enable_gen.

I believe this prevents us from ever reading garbage while trying to
read an old fs (status flag won't be set) and it prevents any
btrfs-progs from getting confused by a wrong-sized status item, since
it would choke on the incompat bit first.

Am I missing some other case? I can try to make it more explicitly
zeroed when we enable qgroups but not squotas? I can add an ASSERT that
the incompat bit is set as expected when we read the status item with
the flag on (that seems good no matter what)?

I can also write a wrapper for getting it which does the incompat/status
flag checking to make it more clear that it isn't safe to read in
general. Or a comment on the struct saying it depends on the incompat
bit?

Thanks for all the review, by the way.

> 
> >  } __attribute__ ((__packed__));
> >  
> >  struct btrfs_qgroup_info_item {
> > -- 
> > 2.41.0
