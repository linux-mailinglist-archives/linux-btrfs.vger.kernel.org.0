Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F0596E88
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiHQMgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 08:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiHQMgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 08:36:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C30088DF2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 05:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4CD0B81D9F
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 12:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DB5C433D6;
        Wed, 17 Aug 2022 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660739759;
        bh=lgJrDFWQ8Owez/0oTsYEWWYyQRTEgVskaUmgqoVEzvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hegjE2nNpXNea/SB7e9PDl8rjG8QHdNzNjBFaLqStuhU9BWWxHT5Ez/4OCjD1vTEb
         2kq8Oz//fISky7DfpERF32a1SQ/exwTH8rWJ96At+MufIPzKwTYF44Q0hHFV+ZuNmw
         6+HE2eYgQfBvqcfqYUKQDNh563xC/pfdTEZH1TfF2XzC+4SVlr+o+pd3m4ssI6tuoC
         Hlb8cXA8qHAtmbTkqJ0ktWtYlZETGAD4pwvnOubppjUZDsJk0v5R3zMeJDwxLhsiXu
         a11H3zflIuxI2Ca2+dSU0ddei9Tcqx02lBpLGvPGlSBNEIWd2D8abLpGSdpxuyUIGS
         0Gd9rhb8rRtrQ==
Date:   Wed, 17 Aug 2022 13:35:56 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Ethan Lien <cunankimo@gmail.com>
Cc:     ethanlien <ethanlien@synology.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary EXTENT_UPTODATE state in
 buffered I/O path
Message-ID: <20220817123556.GA2832930@falcondesktop>
References: <20220815024209.26122-1-ethanlien@synology.com>
 <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
 <CA+SFa0NPa64rqJfQ+EdV2BUdwAhZOFqoXTG7iTHU0uhGf2erJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+SFa0NPa64rqJfQ+EdV2BUdwAhZOFqoXTG7iTHU0uhGf2erJA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 17, 2022 at 02:30:25PM +0800, Ethan Lien wrote:
> Filipe Manana <fdmanana@kernel.org> 於 2022年8月16日 週二 下午4:49寫道：
> >
> > On Mon, Aug 15, 2022 at 4:16 AM ethanlien <ethanlien@synology.com> wrote:
> > >
> > > From: Ethan Lien <ethanlien@synology.com>
> > >
> > > After we copied data to page cache in buffered I/O, we
> > > 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
> > >    endio_readpage_release_extent(), set_extent_delalloc() or
> > >    set_extent_defrag().
> > > 2. Set page uptodate before we unlock the page.
> > >
> > > But the only place we check io_tree's EXTENT_UPTODATE state is in
> > > btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
> > > have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.
> > >
> > > For example, when performing a buffered random read:
> > >
> > >         fio --rw=randread --ioengine=libaio --direct=0 --numjobs=4 \
> > >                 --filesize=32G --size=4G --bs=4k --name=job \
> > >                 --filename=/mnt/file --name=job
> > >
> > > Then check how many extent_state in io_tree:
> > >
> > >         cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'
> > >
> > > w/o this patch, we got 640567 btrfs_extent_state.
> > > w/  this patch, we got    204 btrfs_extent_state.
> >
> > Did fio also report increased throughput?
> >
> 
> Yes, but only when we have a lot of memory (32GB or above).
> In a read benchmark, most of the memory can be used as page cache,
> so there are no ways we can free those UPTODATE extent states unless
> we explicitly call drop cache.
> We have observed millions of useless EXTENT_UPTODATE extent states
> in inode's io_tree, if w/o this patch.
> 
> > >
> > > Maintaining such a big tree brings overhead since every I/O needs to insert
> > > EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And in
> > > every insert or remove, we need to lock io_tree, do tree search, alloc or
> > > dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
> > > io_tree in a minimal size and reduce overhead when performing buffered I/O.
> >
> > The idea is sound, and I don't see a reason to keep using
> > EXTENT_UPTODATE as well.
> >
> > >
> > > Signed-off-by: Ethan Lien <ethanlien@synology.com>
> > > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > > ---
> > >  fs/btrfs/extent-io-tree.h | 4 ++--
> > >  fs/btrfs/extent_io.c      | 3 ---
> > >  2 files changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> > > index c3eb52dbe61c..53ae849d0248 100644
> > > --- a/fs/btrfs/extent-io-tree.h
> > > +++ b/fs/btrfs/extent-io-tree.h
> > > @@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
> > >                                       struct extent_state **cached_state)
> > >  {
> > >         return set_extent_bit(tree, start, end,
> > > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
> > > +                             EXTENT_DELALLOC | extra_bits,
> > >                               0, NULL, cached_state, GFP_NOFS, NULL);
> > >  }
> > >
> > > @@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
> > >                 u64 end, struct extent_state **cached_state)
> > >  {
> > >         return set_extent_bit(tree, start, end,
> > > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
> > > +                             EXTENT_DELALLOC | EXTENT_DEFRAG,
> > >                               0, NULL, cached_state, GFP_NOFS, NULL);
> > >  }
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index bfae67c593c5..e0f0a39cd6eb 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
> > >          * Now we don't have range contiguous to the processed range, release
> > >          * the processed range now.
> > >          */
> > > -       if (processed->uptodate && tree->track_uptodate)
> > > -               set_extent_uptodate(tree, processed->start, processed->end,
> > > -                                   &cached, GFP_ATOMIC);
> >
> > This is another good thing, to get rid of a GFP_ATOMIC allocation.
> >
> > Why didn't you remove the set_extent_uptodate() call at btrfs_get_extent() too?
> > It can only be set during a page read at btrfs_do_readpage(), for an
> > inline extent.
> >
> > Also, having the tests for EXTENT_UPTODATE at btrfs_do_readpage() now become
> > useless too, don't they? Why have you kept them?
> >
> 
> Currently if we found a inline extent in btrfs_get_extent(), we set
> page uptodate
> or page error in btrfs_do_readpage().
> So we still need EXTENT_UPTODATE to let btrfs_do_readpage() knows what to do.
> 
> Or do you suggest we set page uptodate or error in btrfs_get_extent(),
> for inline extent?

My idea was like this:

1) Remove the set_extent_uptodate() call at btrfs_get_extent();

2) At btrfs_do_readpage(), if we get a inline extent (em->block_start == EXTENT_MAP_INLINE),
   then we set the page up to date (at btrfs_do_readpage()).

For step 2, we could also set the page up to date at btrfs_get_extent(), as
you said.

The only case where we get a page passed to btrfs_get_extent() is through
btrfs_do_readpage(), so I think either approach should work, and then remove
the remaining cases where we test for the EXTENT_UPTODATE state at
btrfs_do_readpage().

Thanks.

> 
> Thanks.
> 
> > Thanks.
> >
> > >         unlock_extent_cached_atomic(tree, processed->start, processed->end,
> > >                                     &cached);
> > >
> > > --
> > > 2.17.1
> > >
