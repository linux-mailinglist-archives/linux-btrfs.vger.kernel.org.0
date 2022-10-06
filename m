Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802E5F6E81
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiJFT4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiJFT4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 15:56:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F54A571A
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 12:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2A60CE16FF
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 19:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28463C433B5
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665086201;
        bh=5qhcNmmiTRbYfjZ1OekIVtyz7gUM/3bZWgMZf6Kc3fU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dvxhUCcPLloTWHOWatV9Z6U817CCIpSUJrA4sB1B0RWVdTiczfHLWzs9IbNQBgEaG
         AwvkRjL26pkE9F2D7BJ6SqLyDPKENwaZvTAwxtK287QrpOlh9Tz68hetyumJyWkK/6
         iisMBWu6CvKm+GNOinMY8+mXZ2ASe2bpHg42kCTowVtgLB2vL6HXWysZzPycWn7xjW
         d0WNEwrHl959h6XRLwx6qHSwMWZ32HU/Sk7OmAP17BIr6aIr3ONXxRsJ2edWRJ68VS
         ncmj0Rgz+A/kOLMRVIiX1bJ/YBkqNfsKRCOnYa8fE2Xbt0oFprd0pSssW8wucMCmKx
         3k3qZgaCsXrvA==
Received: by mail-oi1-f177.google.com with SMTP id g130so3211497oia.13
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Oct 2022 12:56:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf0CMMXf6YyzdCuN1k9eN3HORPjH2KanJEnaAIjgLT1W5CSrkXrq
        NjsA0FjYZxJ31oVTiVhXSBN2pd05wBzpFWmJPMQ=
X-Google-Smtp-Source: AMsMyM5QZaXnK+m77XU3cWvl3MRdvV+6wwnGQcfZ4v9xAHLj5znMdKQ8idlIEQ1nH1Vsxlc5E99ClbqKFhucYFbr1OE=
X-Received: by 2002:a05:6808:1691:b0:351:48da:62e0 with SMTP id
 bb17-20020a056808169100b0035148da62e0mr696187oib.98.1665086200208; Thu, 06
 Oct 2022 12:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664999303.git.boris@bur.io> <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com> <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
 <Yz8gq6ErCqeMGUO1@zen>
In-Reply-To: <Yz8gq6ErCqeMGUO1@zen>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 6 Oct 2022 20:56:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Bn47CFL0tOsjCZ3iLgEPRm9_ZXV7duUSMZ2H-g0JhgQ@mail.gmail.com>
Message-ID: <CAL3q7H6Bn47CFL0tOsjCZ3iLgEPRm9_ZXV7duUSMZ2H-g0JhgQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 6, 2022 at 7:38 PM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Oct 06, 2022 at 10:48:33AM +0100, Filipe Manana wrote:
> > On Thu, Oct 6, 2022 at 9:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >
> > >
> > >
> > > On 2022/10/6 03:49, Boris Burkov wrote:
> > > > When doing a large fallocate, btrfs will break it up into 256MiB
> > > > extents. Our data block groups are 1GiB, so a more natural maximum size
> > > > is 1GiB, so that we tend to allocate and fully use block groups rather
> > > > than fragmenting the file around.
> > > >
> > > > This is especially useful if large fallocates tend to be for "round"
> > > > amounts, which strikes me as a reasonable assumption.
> > > >
> > > > While moving to size classes reduces the value of this change, it is
> > > > also good to compare potential allocator algorithms against just 1G
> > > > extents.
> > >
> > > Btrfs extent booking is already causing a lot of wasted space, is this
> > > larger extent size really a good idea?
> > >
> > > E.g. after a lot of random writes, we may have only a very small part of
> > > the original 1G still being referred.
> > > (The first write into the pre-allocated range will not be COWed, but the
> > > next one over the same range will be COWed)
> > >
> > > But the full 1G can only be freed if none of its sectors is referred.
> > > Thus this would make preallocated space much harder to be free,
> > > snapshots/reflink can make it even worse.
> > >
> > > So wouldn't such enlarged preallocted extent size cause more pressure?
> >
> > I agree, increasing the max extent size here does not seem like a good
> > thing to do.
> >
> > If an application fallocates space, then it generally expects to write to all
> > that space. However future random partial writes may not rewrite the entire
> > extent for a very long time, therefore making us keep a 1G extent for a very
> > long time (or forever in the worst case).
> >
> > Even for NOCOW files, it's still an issue if snapshots are used.
> >
>
> I see your point, and agree 1GiB is worse with respect to bookend
> extents. Since the patchset doesn't really rely on this, I don't mind
> dropping the change. I was mostly trying to rule this out as a trivial
> fix that would obviate the need for other changes.
>
> However, I'm not completely convinced by the argument, for two reasons.
>
> The first is essentially Qu's last comment. If you guys are right, then
> 256MiB is probably a really bad value for this as well, and we should be
> reaping the wins of making it smaller.

Well, that's not a reason to increase the size, quite the opposite.

>
> The second is that I'm not convinced of how the regression is going to
> happen here in practice.

Over the years, every now and then there are users reporting that
their free space is mysteriously
going away and they have no clue why, even when not using snapshots.
More experienced users
provide help and eventually notice it's caused by many bookend
extents, and the given workaround
is to defrag the files.

You can frequently see such reports in threads on this mailing list or
in the IRC channel.

> Let's say someone does a 2GiB falloc and writes
> the file out once. In the old code that will be 8 256MiB extents, in the
> new code, 2 1GiB extents. Then, to have this be a regression, the user
> would have to fully overwrite one of the 256MiB extents, but not 1GiB.
> Are there a lot of workloads that don't use nocow, and which randomly
> overwrite all of a 256MiB extent of a larger file? Maybe..

Assuming that all or most workloads that use fallocate also set nocow
on the files, is quite a big stretch IMO.
It's true that for performance critical applications like traditional
relational databases, people usually set nocow,
or the application or some other software does it automatically for them.

But there are also many applications that use fallocate and people are
not aware of and don't set nocow, nor
anything else sets nocow automatically on the files used by them.
Specially if they are not IO intensive, in which
case they may not be noticed and therefore space wasted due to bookend
extents is more likely to happen.

Having a bunch of very small extents, say 4K to 512K, is clearly bad
compared to having just a few 256M extents.
But having a few 1G extents instead of a group of 256M extents,
probably doesn't make such a huge difference as
in the former case.

Does the 1G extents benefit some facebook specific workload, or some
well known workload?


>
> Since I'm making the change, it's incumbent on me to prove it's safe, so
> with that in mind, I would reiterate I'm fine to drop it.
>
> > >
> > > In fact, the original 256M is already too large to me.
> > >
> > > Thanks,
> > > Qu
> > > >
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >   fs/btrfs/inode.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > > index 45ebef8d3ea8..fd66586ae2fc 100644
> > > > --- a/fs/btrfs/inode.c
> > > > +++ b/fs/btrfs/inode.c
> > > > @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
> > > >       if (trans)
> > > >               own_trans = false;
> > > >       while (num_bytes > 0) {
> > > > -             cur_bytes = min_t(u64, num_bytes, SZ_256M);
> > > > +             cur_bytes = min_t(u64, num_bytes, SZ_1G);
> > > >               cur_bytes = max(cur_bytes, min_size);
> > > >               /*
> > > >                * If we are severely fragmented we could end up with really
