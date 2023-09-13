Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2BC79DD14
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 02:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjIMAQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 20:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjIMAQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 20:16:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1022E10F2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 17:16:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3EE5132004E7;
        Tue, 12 Sep 2023 20:16:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 20:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694564166; x=1694650566; bh=ea
        fn9znU0+gPi+Q9pJXOvX6ZNQE7Gfom9l8d44isyes=; b=c58y83voBG1sCbeDss
        PNzLlLCcL4Tobd62XsQcFioCQE7mBE1QJ0YgzIHRKEf2GkweIg34zaEk1gPdaZ+E
        um9fSnUAIb/sCl+7vEK4BXzGkW6GzSDB/I4rw980lXMckn5jN6Nage1QnPmaj7YC
        KSzofqhRu2EkvS2Agj89/xcYGVEn2vPhoHwo5mOT+JxY+Z6+s09b3syHOP0DEhpe
        9W5CJ7Tmct+mWEFU3Y6+CwpT/Wp+p1AZUGy50ApEy9onxQT2o4LdmY6H/J3EbAXo
        PeI4r5mJt/NZG1pGJzWp/e48sTeOm0zQ7YKYjtXmuhVQyhg3AynkFqrt69ZWbCeC
        zJsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694564166; x=1694650566; bh=eafn9znU0+gPi
        +Q9pJXOvX6ZNQE7Gfom9l8d44isyes=; b=Il4Lpmo7m0W+VTdjKHrb58esadHHS
        /shXPgBwqb2h6/3zAgCkpWyKksrzvg2HqXmny36LWDpQx7v9lAN0CLcUDZScaBlO
        P64uPHaBkx4/qGi1QW0T9e9Z5ypw836zi60Bhsct+CxvqZVSQcJkOBAnPd64jMet
        j8lEubAFx2ccCrUpP7yG+kG/9l7t5FoEk2K9JjrdPjuSpcpgsOdW0yIejUyy9L1F
        51K0oDbU9qk7aFkLI2b2915lweez/PU8RSAiIlYst7ihbHtykLs/3jPRLq2kwYPg
        T9mrcUsWK6IswB382eL5dgqQllCjbclbj7SY9wcPFaMsZiTEbYhtdoO0A==
X-ME-Sender: <xms:Rv8AZTJiT5Fk8hzoE--EGjwAy29syFKRqdOiwa8ZKSeK_LabC0kUSw>
    <xme:Rv8AZXLXE1uRAueaVKnDl1TqqnCH8_gBwe_OhsbOORNBR6iN22tmhl__9qXbCWLuL
    GjJuqz55ym9tzhMyrE>
X-ME-Received: <xmr:Rv8AZbt_ewtiN20hNjdKeho1p8JqEhyubIr-Hdph4wcTPLkQHLCd-LmN7dG8hplZpGbl22-FWUaGCZHoeF5NEKs-E7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeijedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:Rv8AZcbQngctds0a7XhV5UXRlv5rMzsNA5aTv64UrFyXNORauAxStQ>
    <xmx:Rv8AZaaM_FTCn2sWw4pq223M6efdALDV_pWUQ63ew_Te1GlBap-fwQ>
    <xmx:Rv8AZQCj0zMiixciP7wue8vVn8fwpfOZzknAb6GoCaG8JBZgeE39fA>
    <xmx:Rv8AZdzuGOHFrcmcCCDKqDvMWOJcZRhVlVRsjpW8zpKgYj88oCIy4w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 20:16:06 -0400 (EDT)
Date:   Tue, 12 Sep 2023 17:17:02 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 15/18] btrfs: check generation when recording simple
 quota delta
Message-ID: <20230913001702.GA224634@zen>
References: <cover.1690495785.git.boris@bur.io>
 <04ffbfcc145951c2f570312901b2c03c3c74e48e.1690495785.git.boris@bur.io>
 <20230907122449.GL3159@twin.jikos.cz>
 <20230908214146.GA172348@zen>
 <20230911180020.GF3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911180020.GF3159@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 08:00:20PM +0200, David Sterba wrote:
> On Fri, Sep 08, 2023 at 02:41:46PM -0700, Boris Burkov wrote:
> > On Thu, Sep 07, 2023 at 02:24:49PM +0200, David Sterba wrote:
> > > On Thu, Jul 27, 2023 at 03:13:02PM -0700, Boris Burkov wrote:
> > > > Simple quotas count extents only from the moment the feature is enabled.
> > > > Therefore, if we do something like:
> > > > 1. create subvol S
> > > > 2. write F in S
> > > > 3. enable quotas
> > > > 4. remove F
> > > > 5. write G in S
> > > > 
> > > > then after 3. and 4. we would expect the simple quota usage of S to be 0
> > > > (putting aside some metadata extents that might be written) and after
> > > > 5., it should be the size of G plus metadata. Therefore, we need to be
> > > > able to determine whether a particular quota delta we are processing
> > > > predates simple quota enablement.
> > > > 
> > > > To do this, store the transaction id when quotas were enabled. In
> > > > fs_info for immediate use and in the quota status item to make it
> > > > recoverable on mount. When we see a delta, check if the generation of
> > > > the extent item is less than that of quota enablement. If so, we should
> > > > ignore the delta from this extent.
> > > > 
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  fs/btrfs/accessors.h            |  2 ++
> > > >  fs/btrfs/extent-tree.c          |  4 ++++
> > > >  fs/btrfs/fs.h                   |  2 ++
> > > >  fs/btrfs/qgroup.c               | 14 ++++++++++++--
> > > >  fs/btrfs/qgroup.h               |  1 +
> > > >  include/uapi/linux/btrfs_tree.h |  7 +++++++
> > > >  6 files changed, 28 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> > > > index a23045c05937..513f8edbd98e 100644
> > > > --- a/fs/btrfs/accessors.h
> > > > +++ b/fs/btrfs/accessors.h
> > > > @@ -970,6 +970,8 @@ BTRFS_SETGET_FUNCS(qgroup_status_flags, struct btrfs_qgroup_status_item,
> > > >  		   flags, 64);
> > > >  BTRFS_SETGET_FUNCS(qgroup_status_rescan, struct btrfs_qgroup_status_item,
> > > >  		   rescan, 64);
> > > > +BTRFS_SETGET_FUNCS(qgroup_status_enable_gen, struct btrfs_qgroup_status_item,
> > > > +		   enable_gen, 64);
> > > >  
> > > >  /* btrfs_qgroup_info_item */
> > > >  BTRFS_SETGET_FUNCS(qgroup_info_generation, struct btrfs_qgroup_info_item,
> > > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > > index 1b5efd03ef83..395ab46e520b 100644
> > > > --- a/fs/btrfs/extent-tree.c
> > > > +++ b/fs/btrfs/extent-tree.c
> > > > @@ -1513,6 +1513,7 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
> > > >  			.rsv_bytes = href->reserved_bytes,
> > > >  			.is_data = true,
> > > >  			.is_inc	= true,
> > > > +			.generation = trans->transid,
> > > >  		};
> > > >  
> > > >  		if (extent_op)
> > > > @@ -1676,6 +1677,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
> > > >  			.rsv_bytes = 0,
> > > >  			.is_data = false,
> > > >  			.is_inc = true,
> > > > +			.generation = trans->transid,
> > > >  		};
> > > >  
> > > >  		BUG_ON(!extent_op || !extent_op->update_flags);
> > > > @@ -3217,6 +3219,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
> > > >  			.rsv_bytes = 0,
> > > >  			.is_data = is_data,
> > > >  			.is_inc = false,
> > > > +			.generation = btrfs_extent_generation(leaf, ei),
> > > >  		};
> > > >  
> > > >  		/* In this branch refs == 1 */
> > > > @@ -4850,6 +4853,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
> > > >  	struct btrfs_simple_quota_delta delta = {
> > > >  		.root = root_objectid,
> > > >  		.num_bytes = ins->offset,
> > > > +		.generation = trans->transid,
> > > >  		.rsv_bytes = 0,
> > > >  		.is_data = true,
> > > >  		.is_inc = true,
> > > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > > > index f76f450c2abf..da7b623ff15f 100644
> > > > --- a/fs/btrfs/fs.h
> > > > +++ b/fs/btrfs/fs.h
> > > > @@ -802,6 +802,8 @@ struct btrfs_fs_info {
> > > >  	spinlock_t eb_leak_lock;
> > > >  	struct list_head allocated_ebs;
> > > >  #endif
> > > > +
> > > > +	u64 quota_enable_gen;
> > > 
> > > Please move it to the other quota/qgroup related members, at the end of
> > > fs_info there's only debugging stuff.
> > > 
> > > >  };
> > > >  
> > > >  static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
> > > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > > index 58e9ed0deedd..a8a603242431 100644
> > > > --- a/fs/btrfs/qgroup.c
> > > > +++ b/fs/btrfs/qgroup.c
> > > > @@ -454,6 +454,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
> > > >  			}
> > > >  			fs_info->qgroup_flags = btrfs_qgroup_status_flags(l, ptr);
> > > >  			simple = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> > > > +			if (simple)
> > > > +				fs_info->quota_enable_gen = btrfs_qgroup_status_enable_gen(l, ptr);
> > > >  			if (btrfs_qgroup_status_generation(l, ptr) !=
> > > >  			    fs_info->generation && !simple) {
> > > >  				qgroup_mark_inconsistent(fs_info);
> > > > @@ -1107,10 +1109,12 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> > > >  	btrfs_set_qgroup_status_generation(leaf, ptr, trans->transid);
> > > >  	btrfs_set_qgroup_status_version(leaf, ptr, BTRFS_QGROUP_STATUS_VERSION);
> > > >  	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
> > > > -	if (simple)
> > > > +	if (simple) {
> > > >  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE;
> > > > -	else
> > > > +		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
> > > > +	} else {
> > > >  		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > > > +	}
> > > >  	btrfs_set_qgroup_status_flags(leaf, ptr, fs_info->qgroup_flags &
> > > >  				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
> > > >  	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
> > > > @@ -1202,6 +1206,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
> > > >  		goto out_free_path;
> > > >  	}
> > > >  
> > > > +	fs_info->quota_enable_gen = trans->transid;
> > > > +
> > > >  	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > > >  	/*
> > > >  	 * Commit the transaction while not holding qgroup_ioctl_lock, to avoid
> > > > @@ -4622,6 +4628,10 @@ int btrfs_record_simple_quota_delta(struct btrfs_fs_info *fs_info,
> > > >  	if (!is_fstree(root))
> > > >  		return 0;
> > > >  
> > > > +	/* If the extent predates enabling quotas, don't count it. */
> > > > +	if (delta->generation < fs_info->quota_enable_gen)
> > > > +		return 0;
> > > > +
> > > >  	spin_lock(&fs_info->qgroup_lock);
> > > >  	qgroup = find_qgroup_rb(fs_info, root);
> > > >  	if (!qgroup) {
> > > > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > > > index ce6fa8694ca7..ae1ce14b365c 100644
> > > > --- a/fs/btrfs/qgroup.h
> > > > +++ b/fs/btrfs/qgroup.h
> > > > @@ -241,6 +241,7 @@ struct btrfs_simple_quota_delta {
> > > >  	u64 rsv_bytes; /* The number of bytes reserved for this extent */
> > > >  	bool is_inc; /* Whether we are using or freeing the extent */
> > > >  	bool is_data; /* Whether the extent is data or metadata */
> > > > +	u64 generation; /* The generation the extent was created in */
> > > 
> > > Please reorder it so it does not leave gaps between struct members.
> > > 
> > > >  };
> > > >  
> > > >  static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
> > > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > > index eacb26caf3c6..1120ce3dae42 100644
> > > > --- a/include/uapi/linux/btrfs_tree.h
> > > > +++ b/include/uapi/linux/btrfs_tree.h
> > > > @@ -1242,6 +1242,13 @@ struct btrfs_qgroup_status_item {
> > > >  	 * of the scan. It contains a logical address
> > > >  	 */
> > > >  	__le64 rescan;
> > > > +
> > > > +	/*
> > > > +	 * the generation when quotas are enabled. Used by simple quotas to
> > > > +	 * avoid decrementing when freeing an extent that was written before
> > > > +	 * enable.
> > > > +	 */
> > > > +	__le64 enable_gen;
> > > 
> > > This is public interface and btrfs_qgroup_status_item is used in many
> > > places in user space at least in btrfs-progs. This needs a lot of
> > > sanity checks.
> > 
> > Totally agreed in principle, but not exactly sure how to proceed in
> > practice. I would definitely appreciate some tips/help!
> > 
> > How we interact with the new field:
> > - When enabling squota, set it, the incompat bit, and the status flag
> > - When reading in the qgroup status_item, if the status flag is set,
> >   then read the enable_gen.
> > 
> > I believe this prevents us from ever reading garbage while trying to
> > read an old fs (status flag won't be set) and it prevents any
> > btrfs-progs from getting confused by a wrong-sized status item, since
> > it would choke on the incompat bit first.
> > 
> > Am I missing some other case? I can try to make it more explicitly
> > zeroed when we enable qgroups but not squotas? I can add an ASSERT that
> > the incompat bit is set as expected when we read the status item with
> > the flag on (that seems good no matter what)?
> > 
> > I can also write a wrapper for getting it which does the incompat/status
> > flag checking to make it more clear that it isn't safe to read in
> > general. Or a comment on the struct saying it depends on the incompat
> > bit?
> 
> All of the above makes sense and I had something like that in mind when
> writing the comment. The wrappers can make sure the bit is set when
> reading the item. I think there's an example in existing code that
> versions an item based on size, I can't find it now (probably something
> from the send/receive time where several new struct members were added).
> 
> I just noticed we have versioning for the qgoup status item,
> BTRFS_QGROUP_STATUS_VERSION is now 1 and has backward compatibility
> handling. We can probably use version 2 for squotas, in addition to the
> helpers with sanity checks.

I made the helper/validation changes in V6, but forgot to address the
BTRFS_QGROUP_STATUS_VERSION idea. Right now, that field is for
preventing forward compatibility as well as backward (for lack of a
better term?) The check on it is a !=, so if you bump the version, you
can no longer honor old fs-es qgroups, which is not the case with this
change. Since the version has never been bumped, I believe we can safely
change it to a backwards compatibility check and use it for squotas.
