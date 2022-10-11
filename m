Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3F5FBA19
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJKSFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJKSFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 14:05:24 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFDF6D9E5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 11:05:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8EA173200984;
        Tue, 11 Oct 2022 14:05:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 Oct 2022 14:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665511518; x=1665597918; bh=uqSnRJjEG1
        pFvxikbl0bnGHNBHxYwC4ZlAncRqiTI+I=; b=OjBH2iOizJUxmAuBkKAXAbofzj
        lA7hDX5nCQ1lsrHylYqxKQk6KH/5NHlpzg0+rmNOh/PqbipNKGTfBOoVpVVhIOkz
        RtVqNWi5TrqGv/ucsTBkJMZdwEdv9p9Ys0tiWS+p9UXwjloMVa5HFtJWf8Hjcx8E
        bKy7avwodz2kNCuhcHwRidO563ebBzb0kiIvB0HBRLn09Si+kriZ7gwfhVTnALUp
        N4aE1rxrNT2ABX0Sa4bdsXSAUbY1yCOh4ioMJDMm0Dxvy4843RoCr8iq4DZlU0Gd
        ZiTu3ZGTgUtKAOOog17/Eo16y5g4bUvJHz1DIVzW5/yoSdYXDzwhWnWHYIcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665511518; x=1665597918; bh=uqSnRJjEG1pFvxikbl0bnGHNBHxY
        wC4ZlAncRqiTI+I=; b=VegQV/PA62ATb+MB4QZSu5CeaJdxZoepHumR5OXwFvGH
        ayqtrIdKAzO5ldvqmH7RGew8gw3SuujX+1OvBwkWdlvoBniKZOEGz/sAPOpFSJqu
        b3CvkbKu80DMXdIEbZKCsRUNQ2aiEdacdj5sIwwuhHO0h8d4E+OPuKtLclzPEYH5
        ciz9CHUYaqepvVPibYN/CpAz5jMNjguNX+s/Fb7OTZBXFGSvvv+0UTgP6IA1jH9P
        wk6o5gz8pwFWjjtlxB074vmcG4oVg1Vf5rMZMrhEi5k7YjbHOV4pZMo+n03CpFuN
        +BiTJR5O3fJ+k1AnJHONMNXcl0V5nGbSL7Wo6GPMBg==
X-ME-Sender: <xms:XbBFY5UPg1Gel4fpzrJ_EvMllXxYjzxqne2d8lBeJPanLZcxX5bnvw>
    <xme:XbBFY5mcH1ANXtABEoyZfsEypEJ_XvQO8KxoN4PIz5GXtxHQbSYEXUoaevUXxmlle
    nB3FDDLV75el4UYKcc>
X-ME-Received: <xmr:XbBFY1Z7k4bIbO4BR2XZZT6yqhbBuohIOA7ZsAGlVkBL4qoAAdyvLBeL3GmoAPqg9TQ1ui9SZtE99zBzIdn9Qt9yBhqLhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:XbBFY8Uzxlm8R_VBrXo2cqi4krB0gOYFPxIyHmsmhwuo3rLr5OzogQ>
    <xmx:XbBFYznNxhfU3lZOptW75JSE2F0xungFk5Eodr5XiTqg3aDoGsRaZg>
    <xmx:XbBFY5czedvy2Zy6THUu_xaeZccUHSMJzLFVW7nATgIqNFtTnm2irw>
    <xmx:XrBFY7sShJ5sAbEuexZYB5wq0X8ltQfcSukPMPbsH_q_EGlaIHyjgQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Oct 2022 14:05:17 -0400 (EDT)
Date:   Tue, 11 Oct 2022 11:05:15 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: skip reclaim if block_group is empty
Message-ID: <Y0WwW21CPYUeidwQ@zen>
References: <8f825fce9d2968034da43e09a4ebc38ec19a2e49.1665427766.git.boris@bur.io>
 <CAL3q7H4L6ST88RpTojMmb-nQ82Y7ZYY-80Z+GSyLkMJ7zzVkDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4L6ST88RpTojMmb-nQ82Y7ZYY-80Z+GSyLkMJ7zzVkDg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 10:43:33AM +0100, Filipe Manana wrote:
> On Mon, Oct 10, 2022 at 8:25 PM Boris Burkov <boris@bur.io> wrote:
> >
> > As we delete extents from a block group, at some deletion we cross below
> > the reclaim threshold. It is possible we are still in the middle of
> > deleting more extents and might soon hit 0. If that occurs, we would
> > leave the block group on the reclaim list, not in the care of unused
> > deletion or async discard.
> >
> > It is pointless and wasteful to relocate empty block groups, so if we do
> 
> Hum? Why pointless and wasteful?
> Relocating an empty block group results in deleting it.
> 
> In fact, before we tracked unused block groups and had the cleaner
> kthread remove them, that was the only
> way to delete unused block groups - trigger relocation from user space.
> 
> btrfs_relocate_chunk() explicitly calls btrfs_remove_chunk() at the
> end, and the relocation itself
> will do nothing except:
> 
> 1) commit the current transaction when it starts
> 2) search the extent tree for extents in this block group - here it
> will not find anything, and therefore do nothing.
> 3) commit another transaction
> 
> So I don't quite understand what this patch is trying to accomplish.
> 
> At the very least the changelog needs to be more detailed.
> 
> As it is, it gives the wrong idea that the relocation will leave the
> block group around.
> If your goal is to avoid the 2 transaction commits and the search on
> the extent tree, then please be explicit in
> the changelog.
> 
> Thanks.

Apologies for the exuberant and unclear language. I'm happy to tone it
down and make it more precise. Thanks for the feedback.

We see a lot of these empty reclaims in practice and I thought this
could be a helpful little cleanup, nothing major.

My aim was essentially what you said. In my mind, delete unused is less
complicated and has less overhead than an empty relocation. I agree
that the empty relocation does accomplish the task of getting rid of the
bg, but I figure if we have a more direct way of accomplishing it
already, we should go with that. To be completely clear, I was also 
thinking about creating the relocation inode as un-needed overhead.
For what it's worth, I have not benchmarked btrfs_delete_unused_bgs
against relocating empty bgs.

Thanks,
Boris

> 
> > notice that case (we might not if the reclaim worker runs *before* we
> > finish emptying it), don't bother with relocating the block group.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/block-group.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 11fd52657b76..c3ea627d2457 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1608,6 +1608,25 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >                         up_write(&space_info->groups_sem);
> >                         goto next;
> >                 }
> > +               if (bg->used == 0) {
> > +                       /*
> > +                        * It is possible that we trigger relocation on a block
> > +                        * group as its extents are deleted and it first goes
> > +                        * below the threshold, then shortly goes empty. In that
> > +                        * case, we will do relocation, even though we could
> > +                        * more cheaply just delete the unused block group. Try
> > +                        * to catch that case here, though of course it is
> > +                        * possible there is a delete still coming the future,
> > +                        * so we can't avoid needless relocation of this sort
> > +                        * altogether. We can at least avoid relocating empty
> > +                        * block groups.
> > +                        */
> > +                       if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
> > +                               btrfs_mark_bg_unused(bg);
> > +                       spin_unlock(&bg->lock);
> > +                       up_write(&space_info->groups_sem);
> > +                       goto next;
> > +               }
> >                 spin_unlock(&bg->lock);
> >
> >                 /* Get out fast, in case we're unmounting the filesystem */
> > --
> > 2.37.2
> >
