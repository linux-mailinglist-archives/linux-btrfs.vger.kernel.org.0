Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB52979926C
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbjIHWuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjIHWuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 18:50:00 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1290C1FF0
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 15:49:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A5B683200938;
        Fri,  8 Sep 2023 18:49:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Sep 2023 18:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694213392; x=1694299792; bh=fU
        HQ+ir+5WL9uJ5+oythFJp7n/pTPSIlXmqd6PJn1Ro=; b=rFw+y4YSQ3GDvZmWs2
        uiXq1LURPpLj7nCgagZYXbZY0DYtLl6F5yFK4LNE/1jS/WhdG5Q54Pmrt0L7FYU9
        W8WuTEdaDJwINdqEIToy1/+rBLS//F3xKIGu1XnMYbGL9JMYZAFKavRHT2w6KlW5
        JB4YsVJu7Bnvts2UXSfAK/tWujoJbMBrWjXH8NgMhqIKwaKbNomfEOkuLmymp1f9
        vSyhdXdw1gKLIhS6BAVKvxvmo0iSsspo98s39pTfw/YADdUhhJw3tQs5e427wf3q
        OeZ5N5qpsi74PBwpc8sxgktNB8x1JZqR+feI/Gfx+afbWn3w0mRDbyn4gBgVzLpk
        xfww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694213392; x=1694299792; bh=fUHQ+ir+5WL9u
        J5+oythFJp7n/pTPSIlXmqd6PJn1Ro=; b=yTh3vyQSKI1whi7QbhMBJ9JUclkzX
        S/CAhGMXR2wkvRZUwSj9ifUbIde1Un4AJrHHi1nh3J4w8faGIX8fccy9pJi7/YQj
        U0Whl8YJOD9iqhtnFgTti7ciqnUn4cw5ckrWP1I87VkGyXHL89vvw8M+UHRGW8Gw
        8K5Dk6CxUAysM10YI3+RfAOOWSFe+CoBVb2cP3gt/wdDaWobYW32NYk6vy/83UL5
        I95ZA+42lmue72QaFEEmDVv13rEVHqcivE2PmoHOb1+QHQLZcm3AI4xU+XtMqCd/
        qmv3ufqafHJDCstUE0YNLmqCihvz3sD2y1ecni5EpCVnvWH4lhqqiUpjA==
X-ME-Sender: <xms:D6X7ZEGrDCWjY7KwURNFPsUF6CBP-zN3MvUw4u551ydin66KXQpoLA>
    <xme:D6X7ZNVsI65afw5NLcj97uAShtYE4ZMh2JIdcLhHpSTwW6XNQT8mlFy_jlU8HA78J
    hE9IOhN598X-UaRUT4>
X-ME-Received: <xmr:D6X7ZOIMmfooKxSYouReGCBbPZ5vnNpUg4lbgPERsFAh-ZuVA0i8R6_iskF0Gd9rlGY7e4Uo2zR4eRYpDfo7nf5t0XY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:D6X7ZGH0-FW_CY4H3-BxecUrUKunNhnwDSg7Uy60KZ5OG4NN85KTcw>
    <xmx:D6X7ZKX3PuqucilO5ZC2KaWNLFwqdN8McEQH604mtd6WBL8MaY9KeA>
    <xmx:D6X7ZJNLUDLPzaZLHPgYk-NMoZ0jBBGNxoynovfyB1tjVz-3evy3cg>
    <xmx:EKX7ZNfKO2GokoHsqBeGwua_AL9vRLMQvo3R8O8NnS0ftgAIA22s3g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 18:49:51 -0400 (EDT)
Date:   Fri, 8 Sep 2023 15:50:53 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 06/18] btrfs: create qgroup earlier in snapshot
 creation
Message-ID: <20230908225053.GB172348@zen>
References: <cover.1690495785.git.boris@bur.io>
 <4418d4544e16023fb0b7db6969b657b32cd25f93.1690495785.git.boris@bur.io>
 <20230907114135.GE3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907114135.GE3159@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 01:41:35PM +0200, David Sterba wrote:
> On Thu, Jul 27, 2023 at 03:12:53PM -0700, Boris Burkov wrote:
> > Pull creating the qgroup earlier in the snapshot. This allows simple
> > quotas qgroups to see all the metadata writes related to the snapshot
> > being created and to be born with the root node accounted.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/qgroup.c      | 3 +++
> >  fs/btrfs/transaction.c | 6 ++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 18f521716e8d..8e3a4ced3077 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1672,6 +1672,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> >  	struct btrfs_qgroup *qgroup;
> >  	int ret = 0;
> >  
> > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> > +		return 0;
> > +
> >  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> >  	if (!fs_info->quota_root) {
> >  		ret = -ENOTCONN;
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 89ff15aa085f..25217888e897 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -1722,6 +1722,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
> >  	}
> >  	btrfs_release_path(path);
> >  
> > +	ret = btrfs_create_qgroup(trans, objectid);
> > +	if (ret) {
> > +		btrfs_abort_transaction(trans, ret);
> 
> This adds and error case to the middle of a transaction commit.
> Snapshots are created in two parts, first is the ioctl adding the
> structure and then commit actually creates that. So the first phase
> preallocates what's needed (the root_item and path) and should do the
> same with the qgroups as much as possible.
> 
> Also check all the things that btrfs_create_qgroup() does, searches the
> qgroup tree, adds the new item, takes the qgroup_ioctl_lock mutex, and
> adds the sysfs entry (that does allocations under GFP_KERNEL).

I believe it does it with GFP_NOFS via allocating "prealloc". I might be
missing another allocation under the covers. That's covered below,
though.

> If you really need to create the qgroup like that then it needs much
> more care.

As I understand it, the way that the qgroup gets created currently is by
qgroup_account_snapshot which calls btrfs_qgroup_inherit in this same
function.

btrfs_create_qgroup consists of:
- lock qgroup_ioctl_lock
- do an rbtree lookup for the qgid
- do a NOFS "prealloc" allocation for the qgroup struct
- add the qgroup item
- add it to the rbtree
- add it to sysfs (using the above nofs prealloc)

With the exception of the qgroup_ioctl_lock, all those are in
btrfs_qgroup_inherit (and much more).

So that is all happening within create_pending_snapshot and thus the
commit critical section. It also does other work like backref walks,
and committing the roots.

Am I missing something important about the relative parts of
create_pending_snapshots where this work is happening? My intent was to
pull it up to before the run_delayed_refs in create_pending_snapshots
so that the new dir metadata item gets counted correctly. I think I may
have gotten delayed_refs and delayed_items confused and pulled it up
*too* far, and can probably stuff it earlier in that account function
or something.

Apologies if I am fundamentally misunderstanding something here.
