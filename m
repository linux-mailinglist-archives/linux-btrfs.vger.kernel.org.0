Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E874752AAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjGMTCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGMTCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 15:02:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732312D77
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 12:02:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3A90D3200900;
        Thu, 13 Jul 2023 15:02:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jul 2023 15:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689274921; x=1689361321; bh=7M
        R/I9AUsYbWE0LjG9Wjl8iOfwW6KsAdLViGcfp6Q90=; b=WUJmmu2C2PLL7Xxq9k
        eUuf/Wbnw4omY1G4RLbiXBRUFHriEJpKxffCn5edDmTm7dp8OxtqEzqWuYbbCRf1
        Zvce4ObaIiGzcCI2YmKB2YDJZtVEzi8FiL46EfN7sgE5hVkHAoJianvZGEF6FxKw
        LWZyHYx/P9djFMBcxYEBCOKQtOBOz7n6N26ajOvoEOGsXa6BisTcmrr47iVASbyx
        Ian0h7zhg8sfXexuLNgHhAU5KU2zZXRqcizDvCujdKQjX2fqyBI7H+GSdF8c9iea
        xdBidd2yKblYJRFNKArBDxr+468fMR9FabVvOHRdV3cBXMCHnVHnoP5YU4hdGbOP
        AWLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689274921; x=1689361321; bh=7MR/I9AUsYbWE
        0LjG9Wjl8iOfwW6KsAdLViGcfp6Q90=; b=SdJKNrW1B0A0DaoaKuI3ePdHrvgEM
        kbB1S74yHQWg3xcTwrMZFc9D21PmbX5/LYsQQpxTGM3qK7Am8vDwVPajWvRVhlEA
        i1WJXSAuxwHcmbTe6uKCd/nQVhthbkY68H0qk6PoSwUJkJ1R6YFl5Iocj38RfM8N
        KtvljBiaANTx0SwebwqVkqVy3ehs9LggXv2IH42ah5Rs8GNAb2hyHsEOs1oNh3um
        nxIVr3b/x1BAFcM2FZVST2puSjeJ38cO6I6Dz+cpmWlUHLw9EEfPXu33ESeGC5Zt
        6XMfqRwFUlYeyJ937XSxYZg2c9qcSPKKTfViMaXzPAjcjQuFEdz73GyWg==
X-ME-Sender: <xms:KUqwZMOjW4d_4tKmzye4wT_SK5igI0Fzf8f6rT5fEXH-1V7Nfz5uLg>
    <xme:KUqwZC8I4FBEwSYLgyMBGTh5GyDIy87BIyVLJUGl-x59YDaldOA93q78M5hNOA2Cr
    aJRF8qQT-udE6oMjzc>
X-ME-Received: <xmr:KUqwZDQOcvv-J9BlCW3IaDBBX8v6iYP8ZRuSd-5NDAmrQKTeh-x5wda2jiLvPaHgsgKz2AgXf-RW4-kK6AZ-9bhaXok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:KUqwZEswJv32Pbqz2hCbh4TxIj4iWYozxf-m3Qka9Gpj9LdIlE8kIA>
    <xmx:KUqwZEe2DeTVzKgRB1kjkfVMexk2w0T-y5U4TRKNj1lhe6obO0J81g>
    <xmx:KUqwZI0C9Ye1Ctb7Hj-NoOWxn44L4UJz_1HPbJ4zayZyB6ekqBcVKw>
    <xmx:KUqwZAHaGAXok2KwX2CC_Dc44-djEE1-fjU1VjN-GPDSKgF7CrALog>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 15:02:00 -0400 (EDT)
Date:   Thu, 13 Jul 2023 12:00:42 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/18] btrfs: create qgroup earlier in snapshot creation
Message-ID: <20230713190042.GA2626930@zen>
References: <cover.1688597211.git.boris@bur.io>
 <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
 <20230713142600.GG207541@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713142600.GG207541@perftesting>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 10:26:00AM -0400, Josef Bacik wrote:
> On Wed, Jul 05, 2023 at 04:20:44PM -0700, Boris Burkov wrote:
> > Pull creating the qgroup earlier in the snapshot. This allows simple
> > quotas qgroups to see all the metadata writes related to the snapshot
> > being created and to be born with the root node accounted.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/qgroup.c      | 3 +++
> >  fs/btrfs/transaction.c | 5 +++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 75afd8212bc0..8419270f7417 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1670,6 +1670,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
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
> > index f644c7c04d53..2bb5a64f6d84 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -1716,6 +1716,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
> >  	}
> >  	btrfs_release_path(path);
> >  
> > +	ret = btrfs_create_qgroup(trans, objectid);
> > +	if (ret) {
> > +		btrfs_abort_transaction(trans, ret);
> > +		goto fail;
> > +	}
> 
> Newline please.
> 
> How is this ok with normal qgroups?  We weren't creating a qgroup at snapshot
> creation time at all it seems, so I don't understand how this is ok for qgroups.

qgroup_account_snapshot calls btrfs_qgroup_inherit which contains a
separate implementation of qgroup creation.

> Thanks,
> 
> Josef
