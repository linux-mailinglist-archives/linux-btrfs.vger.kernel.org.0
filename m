Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88B6F6FF3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjEDQeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEDQe3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 12:34:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86E1BD3
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 09:34:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2665B32009A2;
        Thu,  4 May 2023 12:34:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 May 2023 12:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683218063; x=1683304463; bh=Jr
        KTDJ7/gPU89/QVkyN/U2e+tRz08Az28T87affdooQ=; b=Yut/xniI5gaxBePl90
        l9oDXNfPd623L5vrqpXZDx71iW1mLSnJR7VoNiDm1sV91s+ToTb2stDVmagpyeeZ
        9NrgGGd1e5Zf6eUB0pDeZPKilzacaKrqmfuSr0Kr9L61hgOR2Bzh6BFloMA57m9D
        /jODOQa0secTpv0bq3Q4qdqio4hPhm8TW/s0HowzUMotSdpCMc5QutmtoRI0z25Z
        JnJ+uQlNpK/R2uu41za7+wQzgjLJZv/7dU2sJ0jASG1XZbe9VAHmw4C9cif8dRGb
        yL+tEUfTM4524j1UdOEjJOrE7hTjtUcCwHdWxoY7DEmqHirfUC3HTUchU5vsmadj
        qRHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683218063; x=1683304463; bh=JrKTDJ7/gPU89
        /QVkyN/U2e+tRz08Az28T87affdooQ=; b=MtrxuZ90+5/BB50IJ+B1aTxkqd9TD
        SppNrf0Ms6YQcvEyvIiAUEKwiz410e4ssFOia9GP/LcKlc/ZpRC27QaPuC/UCvow
        PEIQTBZY2gOSM3PJQDIbOCsw3uRV2DuLHs8EQwRFH1z5Y4Wz86IMN9ek17ukpVyo
        GNh8NEgchVXioqqmtrnXIapPsVMNytR0Tr5OU07D6eTwGKAgReSAyGDl+hmK/WIc
        wYDGfpy48qqlx1ZIa3psnqlsOL2kznL1CjJqVJl25CKZ1KbhN+rwvdGilJTLsH6r
        JRwVFfjfe17C4sUaHGXw6IYrEfxTVGiL7Kb7Hf59+IJqMBja0+fDbHn4Q==
X-ME-Sender: <xms:j95TZIqDB4cq6O77jtjtRNUdBlhxVNuRToZ27seISvMdW-18Syt_Pw>
    <xme:j95TZOoZj3Xj--MaVcCZYZHefPuKHQ5cFyXISo471x3WhoDMsUVL9zhWg8fCo2iwT
    mo9qfHxX9C95g1ClVQ>
X-ME-Received: <xmr:j95TZNOcTmYetIiq30SLmWaR0yA-DwehUaOQkalWfcht1kPcLikCF91bkvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeftddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtrodttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekudegjedutddvuddvleekgeeuuddvvdffge
    ehfeduuefhhfehgfehkeevvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:j95TZP7DxQEvochHGF7vECEylIJ5fLCM5ICsp1Sp_jtGFgODcHkntw>
    <xmx:j95TZH5rtp36ZwdxI5nbHCU96xM4dFgiinX8cNJp3LCdeRa3vF35Ow>
    <xmx:j95TZPiUTej-WIzFdJbqrG-UolefPFj6kefqSIkq0NYhoqQGE0th3A>
    <xmx:j95TZBQRRkCD8UO2n-tmQCYlFgZVPFg13AepMHy5cVtOlG3EL3x5Aw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 12:34:22 -0400 (EDT)
Date:   Thu, 4 May 2023 09:34:13 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/9] btrfs: auto hierarchy for simple qgroups of nested
 subvols
Message-ID: <ZFPehaADwnSseFiG@devvm9258.prn0.facebook.com>
References: <cover.1683075170.git.boris@bur.io>
 <b311f17d76094253b5b38be3ea845438628f17ad.1683075170.git.boris@bur.io>
 <f488fc4e-3a5b-c3f6-1958-25f91c9d378e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f488fc4e-3a5b-c3f6-1958-25f91c9d378e@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 12:47:40PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/5/3 08:59, Boris Burkov wrote:
> > Consider the following sequence:
> > - enable quotas
> > - create subvol S id 256 at dir outer/
> > - create a qgroup 1/100
> > - add 0/256 (S's auto qgroup) to 1/100
> > - create subvol T id 257 at dir outer/inner/
> > 
> > With full qgroups, there is no relationship between 0/257 and either of
> > 0/256 or 1/100. There is an inherit feature that the creator of inner/
> > can use to specify it ought to be in 1/100.
> > 
> > Simple quotas are targeted at container isolation, where such automatic
> > inheritance for not necessarily trusted/controlled nested subvol
> > creation would be quite helpful. Therefore, add a new default behavior
> > for simple quotas: when you create a nested subvol, automatically
> > inherit as parents any parents of the qgroup of the subvol the new inode
> > is going in.
> > 
> > In our example, 257/0 would also be under 1/100, allowing easy control
> > of a total quota over an arbitrary hierarchy of subvolumes.
> > 
> > I think this _might_ be a generally useful behavior, so it could be
> > interesting to put it behind a new inheritance flag that simple quotas
> > always use while traditional quotas let the user specify, but this is a
> > minimally intrusive change to start.
> 
> I'm not sure if the automatically qgroup inherit is a good idea.
> 
> Consider the following case, a subvolume is created under another subvolume,
> then it got inherited into qgroup 1/0.

I am not sure I follow this concern. We automatically inherit
relationships of the inode containing subvolume, not its qgroup.

So if X/0 is in a different qgroup Q/1 and subvol Y is created with its
inode in X, Y/0 will be in Q/1, not X/0. I don't believe we would ever
introduce a dependency that would violate the level invariants.

> 
> But don't forget that a subvolume can be easily moved to other directory,
> should we also change which qgroup it belongs to?

I think this is a great point and I haven't spent enough time thinking
about it. Currently, the answer is no, but that might be surprising to a
user.

I imagine it gets even worse if you mount the same subvolume multiple times..

> 
> 
> Another point is, if a container manager tool wants to do the same inherit
> behavior, it's not that hard to query the owner group of the parent
> directory, then pass "-i" option for "btrfs subvolume create" or "btrfs
> subvolume snapshot" commands.
> 
> As the old saying goes, kernel should only provide a mechanism, not a
> policy. To me, automatically inherit qgroup owner looks more like a policy.

This is targeted at the case where the container management tool does
not own creating a subvol.

If we did it your way, then the second something running in a container
creates a subvol (a reasonable operation, for faster bulk deletes, e.g.),
they would trivially "escape" their disk limit. At that point you would
have to do convoluted things like LD_PRELOAD or convincing all users to
use a subvol creation util/lib (might be running some code we can't or
don't want to modify too..)

If we can do it automatically in the kernel, there really is value
there.

IMO, a useful analogy here is cgroups. When you put a process in a
cgroup, all its child processes automatically get rolled up into the
same cgroup, which is important for the same reasons as what I described
above. You can then do weird stuff and move procs to a different cgroup,
but by default everything is neatly nested, which I think is a good
behavior for simple quotas too.

If the functionality is not totally unpalatable, but it's too confusing
to make it default for only simple quotas, I can add an ioctl or subvol
creation flag or something that opts a subvol in to having its nested
subvols inherit its parent qgroups. That would be something the
container runtime could use to opt in.

Thanks for the review,
Boris

> 
> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/ioctl.c       |  2 +-
> >   fs/btrfs/qgroup.c      | 46 +++++++++++++++++++++++++++++++++++++++---
> >   fs/btrfs/qgroup.h      |  6 +++---
> >   fs/btrfs/transaction.c |  2 +-
> >   4 files changed, 48 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index ca7d2ef739c8..4d6d28feb5c6 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -652,7 +652,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
> >   	/* Tree log can't currently deal with an inode which is a new root. */
> >   	btrfs_set_log_full_commit(trans);
> > -	ret = btrfs_qgroup_inherit(trans, 0, objectid, inherit);
> > +	ret = btrfs_qgroup_inherit(trans, 0, objectid, root->root_key.objectid, inherit);
> >   	if (ret)
> >   		goto out;
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index e3d0630fef0c..6816e01f00b5 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1504,8 +1504,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
> >   	return ret;
> >   }
> > -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> > -			      u64 dst)
> > +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst)
> >   {
> >   	struct btrfs_fs_info *fs_info = trans->fs_info;
> >   	struct btrfs_qgroup *parent;
> > @@ -2945,6 +2944,42 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
> >   	return ret;
> >   }
> > +static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
> > +			       u64 inode_rootid,
> > +			       struct btrfs_qgroup_inherit **inherit)
> > +{
> > +	int i = 0;
> > +	u64 num_qgroups = 0;
> > +	struct btrfs_qgroup *inode_qg;
> > +	struct btrfs_qgroup_list *qg_list;
> > +
> > +	if (*inherit)
> > +		return -EEXIST;
> > +
> > +	inode_qg = find_qgroup_rb(fs_info, inode_rootid);
> > +	if (!inode_qg)
> > +		return -ENOENT;
> > +
> > +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> > +		++num_qgroups;
> > +	}
> > +
> > +	if (!num_qgroups)
> > +		return 0;
> > +
> > +	*inherit = kzalloc(sizeof(**inherit) + num_qgroups * sizeof(u64), GFP_NOFS);
> > +	if (!*inherit)
> > +		return -ENOMEM;
> > +	(*inherit)->num_qgroups = num_qgroups;
> > +
> > +	list_for_each_entry(qg_list, &inode_qg->groups, next_group) {
> > +		u64 qg_id = qg_list->group->qgroupid;
> > +		*((u64 *)((*inherit)+1) + i) = qg_id;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * Copy the accounting information between qgroups. This is necessary
> >    * when a snapshot or a subvolume is created. Throwing an error will
> > @@ -2952,7 +2987,8 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
> >    * when a readonly fs is a reasonable outcome.
> >    */
> >   int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> > -			 u64 objectid, struct btrfs_qgroup_inherit *inherit)
> > +			 u64 objectid, u64 inode_rootid,
> > +			 struct btrfs_qgroup_inherit *inherit)
> >   {
> >   	int ret = 0;
> >   	int i;
> > @@ -2994,6 +3030,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >   		goto out;
> >   	}
> > +	if (!inherit && btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> > +		qgroup_auto_inherit(fs_info, inode_rootid, &inherit);
> > +
> >   	if (inherit) {
> >   		i_qgroups = (u64 *)(inherit + 1);
> >   		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
> > @@ -3020,6 +3059,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >   	if (ret)
> >   		goto out;
> > +
> >   	/*
> >   	 * add qgroup to all inherited groups
> >   	 */
> > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > index b300998dcbc7..aecebe9d0d62 100644
> > --- a/fs/btrfs/qgroup.h
> > +++ b/fs/btrfs/qgroup.h
> > @@ -272,8 +272,7 @@ int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
> >   void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
> >   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
> >   				     bool interruptible);
> > -int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> > -			      u64 dst);
> > +int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst);
> >   int btrfs_del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
> >   			      u64 dst);
> >   int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid);
> > @@ -367,7 +366,8 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> >   int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
> >   int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
> >   int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> > -			 u64 objectid, struct btrfs_qgroup_inherit *inherit);
> > +			 u64 objectid, u64 inode_rootid,
> > +			 struct btrfs_qgroup_inherit *inherit);
> >   void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
> >   			       u64 ref_root, u64 num_bytes,
> >   			       enum btrfs_qgroup_rsv_type type);
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 0edfb58afd80..6befcf1b4b1f 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -1557,7 +1557,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
> >   	/* Now qgroup are all updated, we can inherit it to new qgroups */
> >   	ret = btrfs_qgroup_inherit(trans, src->root_key.objectid, dst_objectid,
> > -				   inherit);
> > +				   parent->root_key.objectid, inherit);
> >   	if (ret < 0)
> >   		goto out;
> 
