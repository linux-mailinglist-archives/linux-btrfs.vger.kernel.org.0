Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40206F6CA4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEDNKq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 4 May 2023 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDNKp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 09:10:45 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43920F2
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 06:10:41 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 78BC3865347; Thu,  4 May 2023 09:10:39 -0400 (EDT)
Date:   Thu, 4 May 2023 09:10:39 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
Message-ID: <ZFOuzwqFgsqazX8i@hungrycats.org>
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
 <ZFKAT6u7XEY1Y4yQ@hungrycats.org>
 <CAL3q7H4idLr3VNB_UG30BMoW9=HcZmWotgnfue4QuQtSHnGJ9w@mail.gmail.com>
 <ZFLYv8rawcgDfymY@hungrycats.org>
 <CAL3q7H6jY487q9_BAgwMfCXYW0tVSL+15ZZGLykE+j-O3kxqgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL3q7H6jY487q9_BAgwMfCXYW0tVSL+15ZZGLykE+j-O3kxqgw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 04, 2023 at 11:11:43AM +0100, Filipe Manana wrote:
> On Wed, May 3, 2023 at 10:57 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Wed, May 03, 2023 at 04:56:39PM +0100, Filipe Manana wrote:
> > > On Wed, May 3, 2023 at 4:40 PM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > > >
> > > > On Wed, May 03, 2023 at 01:49:16PM +0100, Filipe Manana wrote:
> > > > > On Wed, May 3, 2023 at 1:37 PM Filipe Manana <fdmanana@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, May 3, 2023 at 1:33 PM Vladimir Panteleev
> > > > > > <git@vladimir.panteleev.md> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have broken
> > > > > > > the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
> > > > > > > BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return zero
> > > > > > > inodes with the flag, if the same happened without the flag, thus
> > > > > > > making it not very useful.
> > > > > > >
> > > > > > > Context: I maintain btdu, a disk usage profiler for btrfs. It uses
> > > > > > > BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the amount
> > > > > > > of space wasted by bookend extents, and identify files / applications
> > > > > > > / IO patterns which create excessive amounts of them.
> > > > > >
> > > > > > Are you able to apply and test a kernel patch?
> > > > > >
> > > > > > If so, try the following one (also at:
> > > > > > https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792)
> > > > > >
> > > > > > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > > > > > index e54f0884802a..c4c5784e897a 100644
> > > > > > --- a/fs/btrfs/backref.c
> > > > > > +++ b/fs/btrfs/backref.c
> > > > > > @@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
> > > > > > btrfs_backref_walk_ctx *ctx,
> > > > > >         int root_count;
> > > > > >         bool cached;
> > > > > >
> > > > > > -       if (!btrfs_file_extent_compression(eb, fi) &&
> > > > > > +       if (!ctx->ignore_extent_item_pos &&
> > > > >
> > > > > This misses a:
> > > > >
> > > > > .. && ctx->extent_item_pos > 0 &&
> > > >
> > > > Ummm...why?
> > >
> > > Because if it's 0 it will trigger an underflow at check_extent_in_eb():
> > >
> > > offset += ctx->extent_item_pos - data_offset;
> > >
> > > if the file extent item's data offset is > 0.
> > > So the filtering must happen only if the offset is not zero, and it was computed
> > > earlier at iterate_inodes_from_logical().
> > >
> > > > With IGNORE_OFFSET set, we want to ignore the offset on the candidate
> > > > matching extent and on the original search bytenr, so we get matches in
> > > > cases where the search bytenr happens to be at offset 0 in the extent.
> > >
> > > And that's what happens with the patch.
> >
> > That's true, but the real reason why it works for the IGNORE_OFFSET case
> > is that I misread the condition:
> >
> >         if (!ctx->ignore_extent_item_pos &&
> >                 // nothing else matters
> >                 // because !ctx->ignore_extent_item_pos is false,
> >                 // so the rest of the && aren't evaluated, or the
> >                 // if true branch
> >
> > so the rest of the code carries on using the extent's bytenr as 'offset'.
> >
> > The true branch of the 'if' is only relevant if we are _not_ ignoring
> > the offset, since that is where the offset gets checked against the
> > file extent item.  In that case, the target block could be on either
> > side of the file extent item's reference range (below data_offset,
> > or above data_offset + data_length) as well as inside the range.
> > The outside-the-range case is handled here:
> >
> >                 data_offset = btrfs_file_extent_offset(eb, fi);
> >
> >                 if (ctx->extent_item_pos < data_offset ||
> >                     ctx->extent_item_pos >= data_offset + data_len)
> >                         return 1;
> >
> > so we don't get to the line you mentioned:
> >
> >         offset += ctx->extent_item_pos - data_offset;
> 
> Yes.
> I realized that later and left tests running overnight after removing
> that and integrating Vladimir's patch.
> 
> I think I was originally confused by looking at the old code where
> there was an "extent_item_pos" which was a u64 pointer in some
> functions and a plain u64 in others.
> 
> I removed it from v2.
> 
> I'm also writing a test case for fstests to exercise the logical to
> ino ioctl, to cover these cases and many others, as unfortunately we
> don't have any coverage for it in fstests.

Cool!

Thanks for giving it your attention.

> Thanks.
> 
> >
> > ctx->extent_item_pos >= data_offset and
> > ctx->extent_item_pos < data_offset + data_len, so
> > offset + ctx->extent_item_pos - data_offset must be within the extent
> > (assuming the referencing file_extent_item isn't busted).
> >
> > > Any file extent item that points to the target bytenr, will be
> > > considered when the ignore flag is given.
> > >
> > > > I think your first patch was the better one.  What am I missing?
> > >
> > > I think the above explains it.
> > >
> > > >
> > > > > I've updated the gist with it:
> > > > > https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.patch
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > +           !btrfs_file_extent_compression(eb, fi) &&
> > > > > >             !btrfs_file_extent_encryption(eb, fi) &&
> > > > > >             !btrfs_file_extent_other_encoding(eb, fi)) {
> > > > > >                 u64 data_offset;
> > > > > > @@ -552,13 +553,10 @@ static int add_all_parents(struct
> > > > > > btrfs_backref_walk_ctx *ctx,
> > > > > >                                 count++;
> > > > > >                         else
> > > > > >                                 goto next;
> > > > > > -                       if (!ctx->ignore_extent_item_pos) {
> > > > > > -                               ret = check_extent_in_eb(ctx, &key,
> > > > > > eb, fi, &eie);
> > > > > > -                               if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP ||
> > > > > > -                                   ret < 0)
> > > > > > -                                       break;
> > > > > > -                       }
> > > > > > -                       if (ret > 0)
> > > > > > +                       ret = check_extent_in_eb(ctx, &key, eb, fi, &eie);
> > > > > > +                       if (ret == BTRFS_ITERATE_EXTENT_INODES_STOP || ret < 0)
> > > > > > +                               break;
> > > > > > +                       else if (ret > 0)
> > > > > >                                 goto next;
> > > > > >                         ret = ulist_add_merge_ptr(parents, eb->start,
> > > > > >                                                   eie, (void **)&old, GFP_NOFS);
> > > > > >
> > > > > > Thanks.
> > > > > > >
> > > > > > > Thanks!
