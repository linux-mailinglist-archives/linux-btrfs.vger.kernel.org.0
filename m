Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAC752DDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjGMXPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGMXPY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 19:15:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD89AA
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 16:15:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 72D373200645;
        Thu, 13 Jul 2023 19:15:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jul 2023 19:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689290116; x=1689376516; bh=QT
        Gr7ltvZRWFHxWANOCX/h4jzO+wMVsOb9qn2bxE1nY=; b=qQIOHKusgmY/Zryj0h
        Au/CsPOACLMe28WTChYANtEXgwYGaiji1ZlCe6nxMwULCKdiwfdgZN4VmhhKusLm
        K7fpR0Lxjms+EaqDPag5hJjOXA2eokwiq4odqCzjW/iQC/1yBkywpE8PeAcpa4GH
        W0m08V0dvo5tri9ztylcbdvPl1qlncV2wEfXqpCkniUhfmGQMTaspLXU7UMvY6Tv
        LXWbXR1CEAR2z+fa6rYIwDce6fMcKL8Qt1voxD6JM7/h2YAsmZ8TvkKYVLguYMvk
        3NyO2ix45xv2KufsTvL5TCDlxqnV+NI4zghyQcGndN07rHuycv3+FyQ40SdXu9LH
        XGRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689290116; x=1689376516; bh=QTGr7ltvZRWFH
        xWANOCX/h4jzO+wMVsOb9qn2bxE1nY=; b=kzvrHk0Obh0IKZD+sJW9ujmyeESMH
        fp1f6ZK4yl2m3oFHExCzyU2Q9njdDroXnsbDInIoSpcvep1rAGq1C8OvLxGANhEM
        62/Tb1tUUgvLzY4VWobVv7Mh8GtZWwQFH+BlyhQfTljUFxcBTUbjfDHo1bS5OER0
        +/fkfv9rnMDTrMtDYiIXiIQ24Uq2wn4yof+MATxGxWpfcLk/vDx0v5cqucTusb6m
        tRRvNM9dXEaNzAYYRbZl9FZUPm4JkdwCNgc476EY4hxjkqvsAISJcknnc0H+MiU8
        YNwdwYX6hMwU0/+0olKo6lPkFO5D4yPN22oBABAxSMbVVMlM7PGJN1ftw==
X-ME-Sender: <xms:hIWwZIAtW4YODGfj7UvRgVGHwdxqAC6rJcp6BpDm6wo2vz8CS-C0Jg>
    <xme:hIWwZKh7qVnZ7gi1wEoYnjrOTowEeO0vPG7cBYyvg3EUuAsBw6ArT6gOJBhwBoRn1
    QzLebdusPRHFms-mJ4>
X-ME-Received: <xmr:hIWwZLnughitbg_pU3SIEQR6a6dRmkarHEST7A9-P8MBYpcJ56AE-C9tMh-JJDg9v5g_3gfAG1u9TrVFFlE8JHunyUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:hIWwZOxGqdeBrMRHYmDnz8R3zWGzNVNTpHkfKZtoRJGcvRcePi-Rog>
    <xmx:hIWwZNT-ni5pecgdaORhqbzelHCTNOTSfkt7tzETiFRVLvlkm3533g>
    <xmx:hIWwZJaU-_a2RbbLAEj0YdRR2FtGkDKBx5xp5H-V0Yw3lXgpIXZfrQ>
    <xmx:hIWwZMLDUd-0uC8lX79N2UWKPc6Uf0uEX6MZRZin5faL-4i3EDtI1g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jul 2023 19:15:16 -0400 (EDT)
Date:   Thu, 13 Jul 2023 16:13:57 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/18] btrfs: create qgroup earlier in snapshot creation
Message-ID: <20230713231357.GA2710302@zen>
References: <cover.1688597211.git.boris@bur.io>
 <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
 <20230713142600.GG207541@perftesting>
 <20230713190042.GA2626930@zen>
 <20230713203704.GB338010@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713203704.GB338010@perftesting>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 04:37:04PM -0400, Josef Bacik wrote:
> On Thu, Jul 13, 2023 at 12:00:42PM -0700, Boris Burkov wrote:
> > On Thu, Jul 13, 2023 at 10:26:00AM -0400, Josef Bacik wrote:
> > > On Wed, Jul 05, 2023 at 04:20:44PM -0700, Boris Burkov wrote:
> > > > Pull creating the qgroup earlier in the snapshot. This allows simple
> > > > quotas qgroups to see all the metadata writes related to the snapshot
> > > > being created and to be born with the root node accounted.
> > > > 
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  fs/btrfs/qgroup.c      | 3 +++
> > > >  fs/btrfs/transaction.c | 5 +++++
> > > >  2 files changed, 8 insertions(+)
> > > > 
> > > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > > index 75afd8212bc0..8419270f7417 100644
> > > > --- a/fs/btrfs/qgroup.c
> > > > +++ b/fs/btrfs/qgroup.c
> > > > @@ -1670,6 +1670,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > > >  	struct btrfs_qgroup *qgroup;
> > > >  	int ret = 0;
> > > >  
> > > > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> > > > +		return 0;
> > > > +
> > > >  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> > > >  	if (!fs_info->quota_root) {
> > > >  		ret = -ENOTCONN;
> > > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > > index f644c7c04d53..2bb5a64f6d84 100644
> > > > --- a/fs/btrfs/transaction.c
> > > > +++ b/fs/btrfs/transaction.c
> > > > @@ -1716,6 +1716,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
> > > >  	}
> > > >  	btrfs_release_path(path);
> > > >  
> > > > +	ret = btrfs_create_qgroup(trans, objectid);
> > > > +	if (ret) {
> > > > +		btrfs_abort_transaction(trans, ret);
> > > > +		goto fail;
> > > > +	}
> > > 
> > > Newline please.
> > > 
> > > How is this ok with normal qgroups?  We weren't creating a qgroup at snapshot
> > > creation time at all it seems, so I don't understand how this is ok for qgroups.
> > 
> > qgroup_account_snapshot calls btrfs_qgroup_inherit which contains a
> > separate implementation of qgroup creation.
> 
> Which it still does, so I'm confused as to how this is ok.  How do we not get an
> EEXIST when we do the btrfs_qgroup_inherit?  Thanks,
> 
> Josef

add_qgroup_item ignores EEXIST. I believe this should be exercised by
a user intentionally creating a qgroup for a subvolume before
creating the subvolume (I believe that is explicitly supported, though
it does seem to rely on guessing the subvol ID?!)

from man btrfs-qgroup:
"For the 0/<subvolume id> qgroup, a qgroup can be created even before
the subvolume is created."
