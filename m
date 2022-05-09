Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85751FB53
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiEILeE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEILeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 07:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC9179418
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 04:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B47C611B1
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 11:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A657C385AF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652095805;
        bh=ZKE+iDfiNjlLjxBAue/kj8wKU4To9MlMJMS9DCD/7sA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tixk0inQQU2nie46uVSM1mXU4c77ZAdkOv1e1IDMqFIUTV/vWn/ODBCSuzpt98izz
         g9tHaczZs5KqUGyxHYHYa/5MSlsj5UsUYBPMlt1ky+2t/swX5UcWJa3aT093TfEOZS
         Gp0shllDjp/Mo8vj7s9D7N1fUhJjXgyWDt/lX9rgUqykEEuSFeTLFIkNp/fZ0UPF/6
         cf7vLPERFlkuaBCsra5SASpiAVYKm6qbrrS7J3Z6wSTnUHD97bCTNqMjeUDKXACHwn
         k1XqCgc8uH+xdVwSo8Y+6iOASLa/dP2l+jlkIaBh56M3ii02HSXCqYMEnims2N62lQ
         dUpsAuWTpzKqA==
Received: by mail-qt1-f176.google.com with SMTP id fu47so10710538qtb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 04:30:05 -0700 (PDT)
X-Gm-Message-State: AOAM531t7C2XedaRChAIXLPgrYROY4ybFVUJQqqqu1DmZ7Mv+KkppuAj
        xs4cLG/Uu5C78lNa/cTmNDb2IuqVlNxxxvUv/Yg=
X-Google-Smtp-Source: ABdhPJy5vSUfDgatvHD5KF9K79qVLf5/qVkit+NMPBTdNXnjfcKVaGegcZ/PCaL1iuYv3jtONKbUhMaJQWrrpsehZDQ=
X-Received: by 2002:a05:622a:148f:b0:2f3:b46a:f197 with SMTP id
 t15-20020a05622a148f00b002f3b46af197mr14439360qtx.233.1652095804323; Mon, 09
 May 2022 04:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
 <20220509095630.GA2270453@falcondesktop> <9a9880f9-6e61-97c8-db9b-651d3518d0c7@gmx.com>
In-Reply-To: <9a9880f9-6e61-97c8-db9b-651d3518d0c7@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 9 May 2022 12:29:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4vNdmuGDCr6Rq4Q=vBKAXoE=DB5+sShZ=UygvunpMu6g@mail.gmail.com>
Message-ID: <CAL3q7H4vNdmuGDCr6Rq4Q=vBKAXoE=DB5+sShZ=UygvunpMu6g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 9, 2022 at 12:12 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/5/9 17:56, Filipe Manana wrote:
> > On Sat, May 07, 2022 at 02:39:27PM +0800, Qu Wenruo wrote:
> >> Btrfs defaults to max_inline=2K to make small writes inlined into
> >> metadata.
> >>
> >> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
> >> metadata usage, it should still cause less physical space used compared
> >> to a 4K regular extents.
> >>
> >> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
> >> users may find inlined extents causing too much space wasted, and want
> >> to convert those inlined extents back to regular extents.
> >>
> >> Unfortunately defrag will unconditionally skip all inline extents, no
> >> matter if the user is trying to converting them back to regular extents.
> >>
> >> So this patch will add a small exception for defrag_collect_targets() to
> >> allow defragging inline extents, if and only if the inlined extents are
> >> larger than max_inline, allowing users to convert them to regular ones.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
> >>   1 file changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index 9d8e46815ee4..852c49565ab2 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >>              if (!em)
> >>                      break;
> >>
> >> -            /* Skip hole/inline/preallocated extents */
> >> -            if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
> >> +            /*
> >> +             * If the file extent is an inlined one, we may still want to
> >> +             * defrag it (fallthrough) if it will cause a regular extent.
> >> +             * This is for users who want to convert inline extents to
> >> +             * regular ones through max_inline= mount option.
> >> +             */
> >> +            if (em->block_start == EXTENT_MAP_INLINE &&
> >> +                em->len <= inode->root->fs_info->max_inline)
> >> +                    goto next;
> >> +
> >> +            /* Skip hole/delalloc/preallocated extents */
> >> +            if (em->block_start == EXTENT_MAP_HOLE ||
> >> +                em->block_start == EXTENT_MAP_DELALLOC ||
> >>                  test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> >>                      goto next;
> >>
> >> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >>              if (em->len >= get_extent_max_capacity(em))
> >>                      goto next;
> >>
> >> +            /*
> >> +             * For inline extent it should be the first extent and it
> >> +             * should not have a next extent.
> >
> > This is misleading.
> >
> > As you know, and we've discussed this in a few threads in the past, there are
> > at least a couple causes where we can have an inline extent followed by other
> > extents. One has to do with compresson and the other with fallocate.
>
> Yes, I totally know the case. That's why I only mentioned "should", not
> "must".
>
> >
> > So either this part of the comment should be rephrased or go away.
>
> Since Anand questioned why we need to skip the next mergeable check, it
> looks like we'd better re-phase it.
>
> What about "normally inline extents should have no more extent after it,
> thus @next_mergeable would be false under most cases."?

Yes, that's fine.
Thanks.

>
> Thanks,
> Qu
>
> >
> > This is also a good oppurtunity to convert cases where we have an inlined
> > compressed extent followed by one (or more) extents:
> >
> >    $ mount -o compress /dev/sdi /mnt
> >    $ xfs_io -f -s -c "pwrite -S 0xab 0 4K" -c "pwrite -S 0xcd -b 16K 4K 16K" /mnt/foobar
> >
> > In this case a defrag could mark the [0, 20K[ for defrag and we end up saving
> > both data and metadata space (one less extent item in the fs tree and maybe in
> > the extent tree too).
> >
> > Thanks.
> >
> >> +             * If the inlined extent passed all above checks, just add it
> >> +             * for defrag, and be converted to regular extents.
> >> +             */
> >> +            if (em->block_start == EXTENT_MAP_INLINE)
> >> +                    goto add;
> >> +
> >>              next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> >>                                              extent_thresh, newer_than, locked);
> >>              if (!next_mergeable) {
> >> --
> >> 2.36.0
> >>
