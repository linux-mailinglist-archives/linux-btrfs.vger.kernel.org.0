Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3199F495D9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349967AbiAUKTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 05:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiAUKT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 05:19:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB845C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:19:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3C661A21
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA75C340E1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642760368;
        bh=fvSU3osHe6PRWFs+pw2QxfRIBb6vthih4gNOkC9GAw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZDtlIy8yv8t8kYLrG1IKAxeI0N2dM7xTd9ntcFl0QScT4M07Z2mUt93fsXq156bPU
         6SgVrNU/11Y4IEcfyvKyVZ97iDVGPwX6bGT/G/3lQr8yZHVtnAcBVDreWll8JHQCO0
         cs6yU5kNMW6zdRGWmXcASLIe7XHbQ/eMiwA1b2/AlI9Gs6mkgozVPfCmtlQJkKZ8oc
         tIqvee8VTWXP/YWI0p7ie6MEmW4d0HkaBY0cjNtKmWsCLWLtCBCQRyLZxxBwZlKZE3
         fzOCv9lc6GTByENDD+V8zUqykHf70smIjhSA7a65GV3mtWnG3dRLfKbujOQeb7/oDn
         Tk/IYUzNb8lNg==
Received: by mail-qk1-f179.google.com with SMTP id s12so9359153qkg.6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 02:19:28 -0800 (PST)
X-Gm-Message-State: AOAM533kENx1QL1VB1YojiyOxJHEooBsNTi1J0DAsAbqK/Pj7XLoFxnD
        CWTXw1UUyQWzUZds1sqP5zNCZmJ9e857kWrb6j0=
X-Google-Smtp-Source: ABdhPJyx7VLijgh0k7aoAxGyMTt3DLjaVywNYe9Xmr89bjI5wqzfsZye8BXDsqc1hXfZO5nWtFjQ7OCJ/u94FnbFEZk=
X-Received: by 2002:a37:6782:: with SMTP id b124mr2158883qkc.476.1642760367743;
 Fri, 21 Jan 2022 02:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20aad8ccf0fbdecddd49216f25fa772754f77978.1642700395.git.fdmanana@suse.com>
 <4dd733ed-73ac-9e41-f716-0e04161bbfc6@gmx.com>
In-Reply-To: <4dd733ed-73ac-9e41-f716-0e04161bbfc6@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 21 Jan 2022 10:18:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6suP-Ssv_vy6O+d1mYCZ1Ltp5-9+NJqXeVHszhnABoqA@mail.gmail.com>
Message-ID: <CAL3q7H6suP-Ssv_vy6O+d1mYCZ1Ltp5-9+NJqXeVHszhnABoqA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: update writeback index when starting defrag
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 12:03 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/21 01:41, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When starting a defrag, we should update the writeback index of the
> > inode's mapping in case it currently has a value beyond the start of the
> > range we are defragging. This can help performance and often result in
> > getting less extents after writeback - for e.g., if the current value
> > of the writeback index sits somewhere in the middle of a range that
> > gets dirty by the defrag, then after writeback we can get two smaller
> > extents instead of a single, larger extent.
> >
> > We used to have this before the refactoring in 5.16, but it was removed
> > without any reason to do so. Orginally it was added in kernel 3.1, by
> > commit 2a0f7f5769992b ("Btrfs: fix recursive auto-defrag"), in order to
> > fix a loop with autodefrag resulting in dirtying and writing pages over
> > and over, but some testing on current code did not show that happening,
> > at least with the test described in that commit.
> >
> > So add back the behaviour, as at the very least it is a nice to have
> > optimization.
>
> Writeback_index is always one mystery to me.
>
> In fact just re-checking the writeback_index usage, I found the metadata
> writeback is reading that value just like data writeback.
> But we don't have any call sites to set writeback_index for btree inode.
>
> Is there any better doc for the proper behavior for writeback_index?

I don't know... maybe somewhere in the generic writeback code there
are comments.

>
> Thanks,
> Qu
>
> >
> > Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ioctl.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index bfe5ed65e92b..95d0e210f063 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -1535,6 +1535,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> >       int compress_type = BTRFS_COMPRESS_ZLIB;
> >       int ret = 0;
> >       u32 extent_thresh = range->extent_thresh;
> > +     pgoff_t start_index;
> >
> >       if (isize == 0)
> >               return 0;
> > @@ -1576,6 +1577,14 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> >                       file_ra_state_init(ra, inode->i_mapping);
> >       }
> >
> > +     /*
> > +      * Make writeback start from the beginning of the range, so that the
> > +      * defrag range can be written sequentially.
> > +      */
> > +     start_index = cur >> PAGE_SHIFT;
> > +     if (start_index < inode->i_mapping->writeback_index)
> > +             inode->i_mapping->writeback_index = start_index;
> > +
> >       while (cur < last_byte) {
> >               const unsigned long prev_sectors_defragged = sectors_defragged;
> >               u64 cluster_end;
