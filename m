Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48295FC34B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLJvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLJvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCBD3B72E
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDBE261461
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FAC433C1;
        Wed, 12 Oct 2022 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665568310;
        bh=3al8esyx8SNWO9KyTP6XF1xNHacTKJrl9UbgtJyRlNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Prdj99LXYEwohaaV0dN3VnjNsAc0AUChdZ2jEFWSxyWYQR/9PQvCIuU5kDRRVTFGO
         kwwPYnORvJ1ulaxzHoS4Z/alLs0gSLc+0HIPLldI3q/o3W8SAcj8xP5/gDLWUEFD/q
         keCWN3Ikk4aRIkktqGLdcAFQL4yQWG1wSaeOrfcsGQ9nLNLPLPnyJE62OJOPpTpEv2
         aGZr2uY+o/n8mPWWUuKQZqAryRP/q6j8/F/qNT1K2/zA6LG0EhBaLiYwaudeJvIXa1
         Dj6QUPtJt0f0K01/jeQWjMsDcR3Sian3mmMvZ3cSiR+TXMDkyEa5I8Uuvm/11c9S4a
         RCxaWkTz9gpgw==
Date:   Wed, 12 Oct 2022 10:51:47 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: skip reclaim if block_group is empty
Message-ID: <20221012095147.GA2290976@falcondesktop>
References: <8f825fce9d2968034da43e09a4ebc38ec19a2e49.1665427766.git.boris@bur.io>
 <CAL3q7H4L6ST88RpTojMmb-nQ82Y7ZYY-80Z+GSyLkMJ7zzVkDg@mail.gmail.com>
 <Y0WwW21CPYUeidwQ@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0WwW21CPYUeidwQ@zen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 11, 2022 at 11:05:15AM -0700, Boris Burkov wrote:
> On Tue, Oct 11, 2022 at 10:43:33AM +0100, Filipe Manana wrote:
> > On Mon, Oct 10, 2022 at 8:25 PM Boris Burkov <boris@bur.io> wrote:
> > >
> > > As we delete extents from a block group, at some deletion we cross below
> > > the reclaim threshold. It is possible we are still in the middle of
> > > deleting more extents and might soon hit 0. If that occurs, we would
> > > leave the block group on the reclaim list, not in the care of unused
> > > deletion or async discard.
> > >
> > > It is pointless and wasteful to relocate empty block groups, so if we do
> > 
> > Hum? Why pointless and wasteful?
> > Relocating an empty block group results in deleting it.
> > 
> > In fact, before we tracked unused block groups and had the cleaner
> > kthread remove them, that was the only
> > way to delete unused block groups - trigger relocation from user space.
> > 
> > btrfs_relocate_chunk() explicitly calls btrfs_remove_chunk() at the
> > end, and the relocation itself
> > will do nothing except:
> > 
> > 1) commit the current transaction when it starts
> > 2) search the extent tree for extents in this block group - here it
> > will not find anything, and therefore do nothing.
> > 3) commit another transaction
> > 
> > So I don't quite understand what this patch is trying to accomplish.
> > 
> > At the very least the changelog needs to be more detailed.
> > 
> > As it is, it gives the wrong idea that the relocation will leave the
> > block group around.
> > If your goal is to avoid the 2 transaction commits and the search on
> > the extent tree, then please be explicit in
> > the changelog.
> > 
> > Thanks.
> 
> Apologies for the exuberant and unclear language. I'm happy to tone it
> down and make it more precise. Thanks for the feedback.
> 
> We see a lot of these empty reclaims in practice and I thought this
> could be a helpful little cleanup, nothing major.
> 
> My aim was essentially what you said. In my mind, delete unused is less
> complicated and has less overhead than an empty relocation. I agree
> that the empty relocation does accomplish the task of getting rid of the
> bg, but I figure if we have a more direct way of accomplishing it
> already, we should go with that. To be completely clear, I was also 
> thinking about creating the relocation inode as un-needed overhead.
> For what it's worth, I have not benchmarked btrfs_delete_unused_bgs
> against relocating empty bgs.

Ok. It was not clear to me if you were experiencing empty block groups not
being deleted and/or some significant performance problem.

The idea looks fine to me.

I only think we should have the changelog more explicit and detailed.

I.e., mention that although the block group gets deleted by relecation,
it's less efficient due to those transaction commits, extent tree search
(plus anything else I may have missed).

Plus that through the cleaner kthread (btrfs_delete_unused_bgs()) we also
do other important things like dealing with trim/discard and zone finishing,
and that's why we defer the task to the cleaner instead of calling
btrfs_remove_chunk() directly from the block group reclaim worker.

Thanks.

> 
> Thanks,
> Boris
> 
> > 
> > > notice that case (we might not if the reclaim worker runs *before* we
> > > finish emptying it), don't bother with relocating the block group.
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/block-group.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 11fd52657b76..c3ea627d2457 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -1608,6 +1608,25 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> > >                         up_write(&space_info->groups_sem);
> > >                         goto next;
> > >                 }
> > > +               if (bg->used == 0) {
> > > +                       /*
> > > +                        * It is possible that we trigger relocation on a block
> > > +                        * group as its extents are deleted and it first goes
> > > +                        * below the threshold, then shortly goes empty. In that
> > > +                        * case, we will do relocation, even though we could
> > > +                        * more cheaply just delete the unused block group. Try
> > > +                        * to catch that case here, though of course it is
> > > +                        * possible there is a delete still coming the future,
> > > +                        * so we can't avoid needless relocation of this sort
> > > +                        * altogether. We can at least avoid relocating empty
> > > +                        * block groups.
> > > +                        */
> > > +                       if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
> > > +                               btrfs_mark_bg_unused(bg);
> > > +                       spin_unlock(&bg->lock);
> > > +                       up_write(&space_info->groups_sem);
> > > +                       goto next;
> > > +               }
> > >                 spin_unlock(&bg->lock);
> > >
> > >                 /* Get out fast, in case we're unmounting the filesystem */
> > > --
> > > 2.37.2
> > >
