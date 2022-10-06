Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5995F63CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiJFJtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJFJtO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 05:49:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8A1696E9
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 02:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5020B82036
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 09:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD70C43470
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665049750;
        bh=GyscXwLfBCNb3H+dAej4vFMiaiyE9Tbm0RYuShoTRs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VFkHIJbrRKlQy+x25dLS4+RpgfWryCyhmIjl9VKFwodMvJr2WjubcYCTHejiX9tb+
         s+ZxZNpqOebRtz7WoQP646DvFg5WO7OmRqXTSvh+mf6LwosOwyusuSvOo5CfmWX8Ey
         5k1I4wiizYtmrb9ibSKFbEsA0bcJIiXVoFZyu8cOM9zWEEb9Ny/bh90xBP86Y/6W2K
         JLhBLcE9EVea8vc59w/gFSgp0OpZsttaxbguKx/TzpLDuIa1zJOP5YejVcAKOqeplv
         5afHJ/51Cw1ikxKft/zFpXh9haJ/08MOIyzjs5wMYpRk0/pUYx/ohJkS/vDaOutihk
         U6LY3CfHKo4mg==
Received: by mail-oi1-f172.google.com with SMTP id g130so1399940oia.13
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Oct 2022 02:49:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf3KcUCgCjw9vW/jGIW8pPazNA0J3iWku3ZRqU25U2TLaJgUVGno
        FQFg+vUxqAyZ/J2fucDzsqDzuW6PRv6iMFFeP6s=
X-Google-Smtp-Source: AMsMyM5YC9TXmPHK5q0D7C6dySCY+2LLnpGTO0LJee8giGYi1okM4goFeUaWgLw2dXcBc54o/4UusX4EjZhH/jz5BF4=
X-Received: by 2002:a05:6808:1a09:b0:350:1e6a:e469 with SMTP id
 bk9-20020a0568081a0900b003501e6ae469mr4230759oib.92.1665049749705; Thu, 06
 Oct 2022 02:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664999303.git.boris@bur.io> <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
 <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
In-Reply-To: <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 6 Oct 2022 10:48:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
Message-ID: <CAL3q7H4tYntEXyjbQ+9UMj1PjXOFsnvpxEOSBfEXNGjS7k3HVA@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
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

On Thu, Oct 6, 2022 at 9:06 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/10/6 03:49, Boris Burkov wrote:
> > When doing a large fallocate, btrfs will break it up into 256MiB
> > extents. Our data block groups are 1GiB, so a more natural maximum size
> > is 1GiB, so that we tend to allocate and fully use block groups rather
> > than fragmenting the file around.
> >
> > This is especially useful if large fallocates tend to be for "round"
> > amounts, which strikes me as a reasonable assumption.
> >
> > While moving to size classes reduces the value of this change, it is
> > also good to compare potential allocator algorithms against just 1G
> > extents.
>
> Btrfs extent booking is already causing a lot of wasted space, is this
> larger extent size really a good idea?
>
> E.g. after a lot of random writes, we may have only a very small part of
> the original 1G still being referred.
> (The first write into the pre-allocated range will not be COWed, but the
> next one over the same range will be COWed)
>
> But the full 1G can only be freed if none of its sectors is referred.
> Thus this would make preallocated space much harder to be free,
> snapshots/reflink can make it even worse.
>
> So wouldn't such enlarged preallocted extent size cause more pressure?

I agree, increasing the max extent size here does not seem like a good
thing to do.

If an application fallocates space, then it generally expects to write to all
that space. However future random partial writes may not rewrite the entire
extent for a very long time, therefore making us keep a 1G extent for a very
long time (or forever in the worst case).

Even for NOCOW files, it's still an issue if snapshots are used.

>
> In fact, the original 256M is already too large to me.
>
> Thanks,
> Qu
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 45ebef8d3ea8..fd66586ae2fc 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
> >       if (trans)
> >               own_trans = false;
> >       while (num_bytes > 0) {
> > -             cur_bytes = min_t(u64, num_bytes, SZ_256M);
> > +             cur_bytes = min_t(u64, num_bytes, SZ_1G);
> >               cur_bytes = max(cur_bytes, min_size);
> >               /*
> >                * If we are severely fragmented we could end up with really
