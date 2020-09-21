Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC22731D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIUSW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 14:22:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56255 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgIUSWZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 14:22:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E03575C0265;
        Mon, 21 Sep 2020 14:22:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 14:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=CoIDybJ4fdmI5szttCH4Udpiey/bBxoKK5vCzVeo
        I10=; b=mJ2wNaFQc3VBxyPW//RCmJgNuyvL2JT0nMrqeGHicxE8CdZyAaMMGFO6
        63jUF4jbUH/ReqU3oe2k6ABByprkyrDo/MGrAKO9G/W93WS3otQKsARXytBllAJO
        6y2QwzXzze3mSR9kdOrcWGFlmn1z84J7M6G9CAGZJmyG8ckqW/OavHl2F/pl1rVa
        O714F+wYkmyuqvxfnTARhdOEhkNlpLge3GWRtGpIfT6imDzbdxe4Ly/bZ3Km9njv
        +VpNTYiPSKe68dyX0mZ7kRadlWyDmu6BVvUuJbmlZwcWwWXKVopNAexi7Q89XFAt
        cED7oQnmWBoNN0ugyR+K6GIjgnHFbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CoIDyb
        J4fdmI5szttCH4Udpiey/bBxoKK5vCzVeoI10=; b=npkNqyYEsPhQ2mrz0NAMIa
        +Tpr3JlSeYZL0Z/Uo9ImWjjhxWl4w1vSEyZLrdooDSBAxmQcuW6vSe3dki32jDDQ
        xV/Z1cESJ/rOyW59pMnC2iq5RXEElEqSqefmmuFlQRWifpiLFVCQamy8Mr04VlN2
        sJIsChwSC7grV98yusHZiSKvqMFD8sADTsietsAkZD9MPL8m9Sl10+GEFPkNuHAg
        4llFj/oMMlR6NNkGFCXEi5gUQ8fFH+/UtlwyEh3hoxJRa0tn5RQgNq/cEajmRben
        MIBheY3hSz7h4yiXy4S6TbRmf9yYWyRymseP2/mDL+d0EOGCDDqTIsNBo6wDS/8w
        ==
X-ME-Sender: <xms:YO9oX_g9aajkAIj6s2yezgitTabR_1qne8SGJ3iU7E1FdKPHLMdrbw>
    <xme:YO9oX8BOEruPuocunPEegI7biupApooWFGbXFjIwL-M6SoCXQWsxlg7DFi20qn-zQ
    0pqdag9dVSJ0bwXsEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtredvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepvdfhgffhteeugefgtdegudevudegkeeguedvvd
    fhudegudfhteekvedtiedtgeeunecukfhppeduieefrdduudegrddufedvrdefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:YO9oX_Ff7ClYFq-CHa4yJ1pHEDhKFD79AP4AMuzoBQql0t6BYMkTLQ>
    <xmx:YO9oX8TL5uwDcYxcwDdAiyhinvWgft3iyPu0FzXnz_CZ4S3Fe_b3DQ>
    <xmx:YO9oX8yeSkabpZiUlk4Dn9r05qT2RbQAQcludYblGFI0Cl5Qij09Ug>
    <xmx:YO9oXyYqMeyczJ4Rg58zAwZQ2hFktlYaRleFy-YViynw7Y9aAUG1zA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id E903F328005D;
        Mon, 21 Sep 2020 14:22:23 -0400 (EDT)
Date:   Mon, 21 Sep 2020 11:22:20 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 3/4] btrfs: remove free space items when creating free
 space tree
Message-ID: <20200921182220.GB4045720@devvm842.ftw2.facebook.com>
References: <cover.1600282812.git.boris@bur.io>
 <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
 <20200921171304.GM6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921171304.GM6756@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 07:13:04PM +0200, David Sterba wrote:
> On Thu, Sep 17, 2020 at 11:13:40AM -0700, Boris Burkov wrote:
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3333,6 +3333,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >  			close_ctree(fs_info);
> >  			return ret;
> >  		}
> > +		/*
> > +		 * Creating the free space tree creates inode orphan items and
> > +		 * delayed iputs when it deletes the free space inodes. Later in
> > +		 * open_ctree, we run btrfs_orphan_cleanup which tries to clean
> > +		 * up the orphan items. However, the outstanding references on
> > +		 * the inodes from the delayed iputs causes the cleanup to fail.
> > +		 * To fix it, force going through the delayed iputs here.
> > +		 */
> > +		btrfs_run_delayed_iputs(fs_info);
> 
> This is called from open_ctree, so this is mount context and the free
> space tree creation is called before that. That will schedule all free
> space inodes for deletion and waits here. This takes time proportional
> to the filesystem size.
> 
> We've had reports that this takes a lot of time already, so I wonder if
> the delayed iputs can be avoided here.

Good point. The way I see it, deleting the inodes creates legitimate
orphan items, and the delayed_iput doesn't go down until after
open_ctree, I assume for the reason you give. So to delete the free
space inodes without incurring the iput cost during mount, we could:

1. make orphan cleanup smart enough to tell the difference between
orphan items left over from an old mount, vs. orphan items created while
mounting.

2. move orphan cleanup to before free space tree creation/free space
inode deletion in open_ctree.

I'll try to think of a way to do 1. or think of some option 3, as 2.
seems a bit hacky/fragile.

While thinking about a legitimate case for orphans, I realized that
unconditionally failing on free space inode delete errors in
create_free_space_tree without handling ENOENT is almost certainly
wrong, so I will likely need to resend this patch anyway.
