Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B422495D8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 11:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379963AbiAUKQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 05:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379967AbiAUKQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 05:16:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D819FC061746
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7809A61A17
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF85C340E3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642760189;
        bh=YZ8g+LVHoY7fymjdC7xQqgKtPjlirRqD+VCQ1BqCCUk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfO6izpZOZIoYyoYS8I22UbAEtQbYxDdI7pLeYli40g0Pn/V56CRaS1IhN2qKW4Zt
         nKds/kmKJY8IQOHocxJJ3xOBd7FzfeBhay6dcenGX3mKuklCM/nH9xlCFSOX5uwxEd
         r8h8X/4InnnKgyQ3J2qaq+dcuTm8dODZI4VpC+UWEPC3jgWYI/otPDNXAbSOS296dL
         LSJ97DQUiDXJZmsarPtuH6FVNdMdpo6PUwZV7soLPTV/KNHKZHIHXUokBDniw0ThgR
         jUh64tFRf0TMwukpAuhEUvyfHGjxkhFu+PtcBO6q7volfsc+qrZNlh8bmx8nr4dxLA
         jkrU/JftNOsCg==
Received: by mail-qt1-f171.google.com with SMTP id h15so9533644qtx.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:16:29 -0800 (PST)
X-Gm-Message-State: AOAM532cCuNWvDQIrjTV9tpIPZPqFJNAKgkGDSrbhEnDIWj1PIhZ5vzQ
        /U0JJqbxQIAdaBbXbamdbiY8uvHLsvcvaaZSZMk=
X-Google-Smtp-Source: ABdhPJwtEA8tPAVmPMyrzhVqLxNP6QK6efy3Bd+r3d5dMUfqmdySV9fZt7QYspL4C8pITa5L5vPsAzCnWcShbQA/qh8=
X-Received: by 2002:ac8:58c4:: with SMTP id u4mr2544047qta.516.1642760188891;
 Fri, 21 Jan 2022 02:16:28 -0800 (PST)
MIME-Version: 1.0
References: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
 <f0e65987-7673-0334-fd00-03d36b832722@gmx.com>
In-Reply-To: <f0e65987-7673-0334-fd00-03d36b832722@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 21 Jan 2022 10:15:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4mw0V8ttrZBpB=twwNCVM=vBu+2UEf0zHzy+ObuxESVg@mail.gmail.com>
Message-ID: <CAL3q7H4mw0V8ttrZBpB=twwNCVM=vBu+2UEf0zHzy+ObuxESVg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock when reserving space during defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 11:39 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/20 22:27, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When defragging we can end up collecting a range for defrag that has
> > already pages under delalloc (dirty), as long as the respective extent
> > map for their range is not mapped to a hole, a prealloc extent or
> > the extent map is from an old generation.
> >
> > Most of the time that is harmless from a functional perspective at
> > least, however it can result in a deadlock:
> >
> > 1) At defrag_collect_targets() we find an extent map that meets all
> >     requirements but there's delalloc for the range it covers, and we add
> >     its range to list of ranges to defrag;
> >
> > 2) The defrag_collect_targets() function is called at defrag_one_range(),
> >     after it locked a range that overlaps the range of the extent map;
> >
> > 3) At defrag_one_range(), while the range is still locked, we call
> >     defrag_one_locked_target() for the range associated to the extent
> >     map we collected at step 1);
> >
> > 4) Then finally at defrag_one_locked_target() we do a call to
> >     btrfs_delalloc_reserve_space(), which will reserve data and metadata
> >     space. If the space reservations can not be satisfied right away, the
> >     flusher might be kicked in and start flushing delalloc and wait for
> >     the respective ordered extents to complete. If this happens we will
> >     deadlock, because both flushing delalloc and finishing an ordered
> >     extent, requires locking the range in the inode's io tree, which was
> >     already locked at defrag_collect_targets().
>
> That's the part I missed.
>
> >
> > So fix this by skipping extent maps for which there's already delalloc.
> >
> > Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect target file extents")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> But I have some concern over one comment below.
>
> > ---
> >   fs/btrfs/ioctl.c | 31 ++++++++++++++++++++++++++++++-
> >   1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 550d8f2dfa37..0082e9a60bfc 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -1211,6 +1211,35 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >               if (em->generation < newer_than)
> >                       goto next;
> >
> > +             /*
> > +              * Our start offset might be in the middle of an existing extent
> > +              * map, so take that into account.
> > +              */
> > +             range_len = em->len - (cur - em->start);
> > +             /*
> > +              * If this range of the extent map is already flagged for delalloc,
> > +              * skipt it, because:
> > +              *
> > +              * 1) We could deadlock later, when trying to reserve space for
> > +              *    delalloc, because in case we can't immediately reserve space
> > +              *    the flusher can start delalloc and wait for the respective
> > +              *    ordered extents to complete. The deadlock would happen
> > +              *    because we do the space reservation while holding the range
> > +              *    locked, and starting writeback, or finishing an ordered
> > +              *    extent, requires locking the range;
> > +              *
> > +              * 2) If there's delalloc there, it means there's dirty pages for
> > +              *    which writeback has not started yet (we clean the delalloc
> > +              *    flag when starting writeback and after creating an ordered
> > +              *    extent). If we mark pages in an adjacent range for defrag,
> > +              *    then we will have a larger contiguous range for delalloc,
> > +              *    very likely resulting in a larger extent after writeback is
> > +              *    triggered (except in a case of free space fragmentation).
>
> If the page is already under writeback, won't we wait for it in
> defrag_one_range() by defrag_prepare_one_page() and
> wait_on_page_writeback()?

Yes, we wait.

And? The comment is about ranges that are dirty but not under writeback yet.
Once writeback starts, EXTENT_DELALLOC is removed from the range (an
ordered extent created and a new extent map created).

>
> Thus I think this case is not really possible here.
>
> Thanks,
> Qu
>
> > +              */
> > +             if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
> > +                                EXTENT_DELALLOC, 0, NULL))
> > +                     goto next;
> > +
> >               /*
> >                * For do_compress case, we want to compress all valid file
> >                * extents, thus no @extent_thresh or mergeable check.
> > @@ -1219,7 +1248,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >                       goto add;
> >
> >               /* Skip too large extent */
> > -             if (em->len >= extent_thresh)
> > +             if (range_len >= extent_thresh)
> >                       goto next;
> >
> >               next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
