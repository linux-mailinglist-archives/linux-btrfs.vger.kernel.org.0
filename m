Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D43596997
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 08:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiHQGai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiHQGah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 02:30:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB526792FF
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 23:30:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p18so11193089plr.8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 23:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=bpzlVd17ZhZIFS4oGj699ijRako8pURqbZWioip7Xy0=;
        b=Q2bZDf3zMICoEGKztjYwkMwiemOy94fgnnjsDuHovEMBHgiScy1oj9bzoChCfWI+mP
         GlD7AHj3zuGRoNO/9XvgZxfAEL3R1z6RxaowXGLQ5XYF07LDKte/KXBV9yxwJXU2jNZ1
         2r2siONFADxfSids+uRkWytEpWMEbWc3kEwA8g2jVOBjeLzjxP5ALZN0LA/L313VmF1u
         mXtnh/iP1AueMEzdTK8y/ihlUucHRVzsRCS5ftfCkDWQ0F6Jwu+4HtpehfpTqZpYpmsR
         CxJHKnaHivhXuTaOnYt4VD4RUTxQ2zNUZoT0xXD5RgBxpzzg4q25+4QBrVZrHEq0c8zO
         6WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=bpzlVd17ZhZIFS4oGj699ijRako8pURqbZWioip7Xy0=;
        b=RWi0/sFOp4PmXQJyivt3VH9tP39RCAZM9YFvkoXnN5LTYxmxeEbFzU6dppKwqj+vpn
         fc0dgSg3oVQz6ZkJ73x2yR1GUWk+5vFFDCJUAGKqtgumGKs8uNnvy2rdtwTdvH6utSoT
         b3U0EsqF65ODjezNoTN6Odo7swKsz5u+ohWuCFwIBhO0QYkTHLl1kE0OtgM3HmO83OxO
         7SirgQDDm80MXC5iGILJc9jelGHQBvnUDLJ3NrH/KsnoFut/BcQkODsLzIykr1iU4vIu
         /fVBK5RW4/hVcTZFWBr3CUfHv/GldfpqgQWiwqUpW106FSdjyrFS1zvdfUVS2ueuMm6B
         4mtA==
X-Gm-Message-State: ACgBeo0ni5bwqr7TZj7srjGHYiWv+TuwR9V9I+bbaK0/MFaGiHLnEdUu
        OW55k1YCZpCW3y7oPyAE/4uLCtgTDdpffTlrF5s=
X-Google-Smtp-Source: AA6agR52QLAoFJL0QItDIi8+onylKG+IA+9vf/7sb8l8ScKv4p8/+AD4UGrKA/JkeGztRTBgl8Gsel3T8m2AJ2iCkQo=
X-Received: by 2002:a17:903:124e:b0:172:7d49:b843 with SMTP id
 u14-20020a170903124e00b001727d49b843mr6001658plh.52.1660717836222; Tue, 16
 Aug 2022 23:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220815024209.26122-1-ethanlien@synology.com> <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
From:   Ethan Lien <cunankimo@gmail.com>
Date:   Wed, 17 Aug 2022 14:30:25 +0800
Message-ID: <CA+SFa0NPa64rqJfQ+EdV2BUdwAhZOFqoXTG7iTHU0uhGf2erJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove unnecessary EXTENT_UPTODATE state in
 buffered I/O path
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     ethanlien <ethanlien@synology.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Aug 15, 2022 at 4:16 AM ethanlien <ethanlien@synology.com> wrote:
> >
> > From: Ethan Lien <ethanlien@synology.com>
> >
> > After we copied data to page cache in buffered I/O, we
> > 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
> >    endio_readpage_release_extent(), set_extent_delalloc() or
> >    set_extent_defrag().
> > 2. Set page uptodate before we unlock the page.
> >
> > But the only place we check io_tree's EXTENT_UPTODATE state is in
> > btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
> > have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.
> >
> > For example, when performing a buffered random read:
> >
> >         fio --rw=3Drandread --ioengine=3Dlibaio --direct=3D0 --numjobs=
=3D4 \
> >                 --filesize=3D32G --size=3D4G --bs=3D4k --name=3Djob \
> >                 --filename=3D/mnt/file --name=3Djob
> >
> > Then check how many extent_state in io_tree:
> >
> >         cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'
> >
> > w/o this patch, we got 640567 btrfs_extent_state.
> > w/  this patch, we got    204 btrfs_extent_state.
>
> Did fio also report increased throughput?
>

Yes, but only when we have a lot of memory (32GB or above).
In a read benchmark, most of the memory can be used as page cache,
so there are no ways we can free those UPTODATE extent states unless
we explicitly call drop cache.
We have observed millions of useless EXTENT_UPTODATE extent states
in inode's io_tree, if w/o this patch.

> >
> > Maintaining such a big tree brings overhead since every I/O needs to in=
sert
> > EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And i=
n
> > every insert or remove, we need to lock io_tree, do tree search, alloc =
or
> > dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
> > io_tree in a minimal size and reduce overhead when performing buffered =
I/O.
>
> The idea is sound, and I don't see a reason to keep using
> EXTENT_UPTODATE as well.
>
> >
> > Signed-off-by: Ethan Lien <ethanlien@synology.com>
> > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > ---
> >  fs/btrfs/extent-io-tree.h | 4 ++--
> >  fs/btrfs/extent_io.c      | 3 ---
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> > index c3eb52dbe61c..53ae849d0248 100644
> > --- a/fs/btrfs/extent-io-tree.h
> > +++ b/fs/btrfs/extent-io-tree.h
> > @@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct extent=
_io_tree *tree, u64 start,
> >                                       struct extent_state **cached_stat=
e)
> >  {
> >         return set_extent_bit(tree, start, end,
> > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | extra=
_bits,
> > +                             EXTENT_DELALLOC | extra_bits,
> >                               0, NULL, cached_state, GFP_NOFS, NULL);
> >  }
> >
> > @@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct extent_i=
o_tree *tree, u64 start,
> >                 u64 end, struct extent_state **cached_state)
> >  {
> >         return set_extent_bit(tree, start, end,
> > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | EXTEN=
T_DEFRAG,
> > +                             EXTENT_DELALLOC | EXTENT_DEFRAG,
> >                               0, NULL, cached_state, GFP_NOFS, NULL);
> >  }
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index bfae67c593c5..e0f0a39cd6eb 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(struct =
processed_extent *processed,
> >          * Now we don't have range contiguous to the processed range, r=
elease
> >          * the processed range now.
> >          */
> > -       if (processed->uptodate && tree->track_uptodate)
> > -               set_extent_uptodate(tree, processed->start, processed->=
end,
> > -                                   &cached, GFP_ATOMIC);
>
> This is another good thing, to get rid of a GFP_ATOMIC allocation.
>
> Why didn't you remove the set_extent_uptodate() call at btrfs_get_extent(=
) too?
> It can only be set during a page read at btrfs_do_readpage(), for an
> inline extent.
>
> Also, having the tests for EXTENT_UPTODATE at btrfs_do_readpage() now bec=
ome
> useless too, don't they? Why have you kept them?
>

Currently if we found a inline extent in btrfs_get_extent(), we set
page uptodate
or page error in btrfs_do_readpage().
So we still need EXTENT_UPTODATE to let btrfs_do_readpage() knows what to d=
o.

Or do you suggest we set page uptodate or error in btrfs_get_extent(),
for inline extent?

Thanks.

> Thanks.
>
> >         unlock_extent_cached_atomic(tree, processed->start, processed->=
end,
> >                                     &cached);
> >
> > --
> > 2.17.1
> >
