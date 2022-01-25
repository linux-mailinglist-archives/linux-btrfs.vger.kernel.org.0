Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670E49B157
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiAYKGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 05:06:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49002 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbiAYKBb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 05:01:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA58615C5
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 10:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C984C340E0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643104875;
        bh=Z9beJSH5FDvScZ2jaElGUFQbWga+z5blDjgs3zggLEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tAbaDqLC3wrsceArOjI+QjtdvzKfKyu/pi1eS+4EWXnuNMvGodGi3P9UZPqbnr7K1
         3Zn7LDMc5wrgydiAHwd3FOQ2ti76UtLi1EuEIofZRqgqdukBEn3NNQAcvNs248dkIr
         aCwIp/BRSXiOogdzX2tRRtXoQE38pYrGh6IEBiPD7X+6EM+rmVyGKX0PyDvBsVn0ll
         q2Ujfg0SU1qu3EoP5cVKELZN3t9AuAGZh097pA6THA9UCaqk5JLalWMgdRzGa+jv5p
         nPGeC57lP3uzoYhvd3/RbGnHW3lbvtKDWGC5mX7nk0xsdN8pvXm23TRVDslgvdC7Ai
         z5LI3NfmlugmQ==
Received: by mail-qt1-f173.google.com with SMTP id bp39so22997249qtb.6
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 02:01:15 -0800 (PST)
X-Gm-Message-State: AOAM531+ykY45qgzEzKPtTrrqqdOLNXdv5cdi8S1TviJryo+o5WMEqW1
        UX6jkpcberpgPPYKR+fZrvTcNtbOxdj1E/Vg2Mc=
X-Google-Smtp-Source: ABdhPJxYUjj1b8iclZnXqw58LIog6qmFHf9l28SV9ixNk2AgY0Kdq0tCvOxA+3HazLeTkcNw8LIGNXkdfqlR3amh97Y=
X-Received: by 2002:a05:622a:1309:: with SMTP id v9mr15660424qtk.141.1643104874522;
 Tue, 25 Jan 2022 02:01:14 -0800 (PST)
MIME-Version: 1.0
References: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
 <9de78ba3-90e4-6408-98a2-766aaa10ecb1@gmx.com>
In-Reply-To: <9de78ba3-90e4-6408-98a2-766aaa10ecb1@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 25 Jan 2022 10:00:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5vr2H00moD0wQNTCa26LFGbDXbPLCG4VU6i95bGaaTNw@mail.gmail.com>
Message-ID: <CAL3q7H5vr2H00moD0wQNTCa26LFGbDXbPLCG4VU6i95bGaaTNw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock when reserving space during defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 9:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
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
> Could it be possible that we allow btrfs_delalloc_reserve_space() to
> choose the flush mode?
> Like changing it to NO_FLUSH for this particular call sites?

It could, but what do you gain with that?
Why would defrag be so special compared to everything else?

>
> Thanks,
> Qu
>
> >
> > So fix this by skipping extent maps for which there's already delalloc.
> >
> > Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect target file extents")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
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
