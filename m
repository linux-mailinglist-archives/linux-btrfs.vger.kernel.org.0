Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24B8597F3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 09:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiHRHcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243789AbiHRHcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 03:32:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06729D8D2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 00:32:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso1010011pjj.4
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ZNtLhHuzoEms5ErFtFzhJVQNX6Ekb2ggQdolvBV0ou8=;
        b=fMtkhddyFSCkDhPMdgljgt5khvnQVR4APjQPuJoHhBADhtDhEOPqOrhYnz59iPHwFw
         /mfeGQ9Dncnk4x9Oq7zNGjh77yhVIiUaYC6lHSU1PWpkg4bYYdV2VC9IcKy1ixga9kSQ
         AdkAURdNGZC5t1J3EnVhDYb6aUEot5DflyWkPYtJpRtytS3x26Vne56PptCVCJ+clN6l
         WK32nBwQ7I+WQHLwQEX6mn+1JG6RFXICjjjw5DgGXk6vncxGl/7R248c5eZHuHl+8Iob
         2HDqdnmUQKkm9xnxCvrTgNepzBU+lNMzEAN7MhSlaMEUfbzBdM6RmogA/OOdWSWVDvwG
         QLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ZNtLhHuzoEms5ErFtFzhJVQNX6Ekb2ggQdolvBV0ou8=;
        b=kNzQUH6icum0LnnSgAKrMOYJwsvRqTfXZM8n9GvfOAUx36DnibsMMpATAY3ADmDdfl
         cycIHm7vRIqZxjdEoIQLQd+F5klYKLN9Yh3xiwQzR1uI19BaBgdLNudjHmEbgjCXlKll
         S42mh97ddANt+WIEDY/DOrQ+AzYqAFhqUNldZFaE8+MhmWIKydYNcStbGgdKv5JE8Jo8
         xx2gL91+cj6vGS5gaLd9zFyDnK++KjibAQvocbEvPxcrKl4e2YfW7Qo/kAIQmPCgvFqG
         oUTcquFn4uL98mckZ7tiHTgU3BaBYeaeAl4z/DjTzZE04OcUPFrmSP4YiYFiMCcpCiCF
         kX0w==
X-Gm-Message-State: ACgBeo2w6FXgOWxuHe/fJ12QdfQxTfxyLuCphezA0rRxQFe+rWZsN8eF
        0jAGkrXHrumslqoSW5MAI0VTN0rglE9NQ4sKJTU=
X-Google-Smtp-Source: AA6agR5Aq4/rybl6ww87XKZGbjeFfk5e0silJ/3vMdt7CYggvvVJCrrPh7ZVfRFEEafLCtaovJGRxC/FehHpLA1qlw8=
X-Received: by 2002:a17:90b:33c5:b0:1fa:773f:d4d9 with SMTP id
 lk5-20020a17090b33c500b001fa773fd4d9mr1797575pjb.90.1660807931217; Thu, 18
 Aug 2022 00:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220815024209.26122-1-ethanlien@synology.com>
 <CAL3q7H6DkF-tJA2K8beUg93o851-2tqxyD7LtJwoirO060EOLQ@mail.gmail.com>
 <CA+SFa0NPa64rqJfQ+EdV2BUdwAhZOFqoXTG7iTHU0uhGf2erJA@mail.gmail.com> <20220817123556.GA2832930@falcondesktop>
In-Reply-To: <20220817123556.GA2832930@falcondesktop>
From:   Ethan Lien <cunankimo@gmail.com>
Date:   Thu, 18 Aug 2022 15:32:00 +0800
Message-ID: <CA+SFa0PNMYj_agC7vm-ECOQXO62R2JL6WLhUFO3vCCRPJmLj8Q@mail.gmail.com>
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

Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Aug 17, 2022 at 02:30:25PM +0800, Ethan Lien wrote:
> > Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:49=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Mon, Aug 15, 2022 at 4:16 AM ethanlien <ethanlien@synology.com> wr=
ote:
> > > >
> > > > From: Ethan Lien <ethanlien@synology.com>
> > > >
> > > > After we copied data to page cache in buffered I/O, we
> > > > 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
> > > >    endio_readpage_release_extent(), set_extent_delalloc() or
> > > >    set_extent_defrag().
> > > > 2. Set page uptodate before we unlock the page.
> > > >
> > > > But the only place we check io_tree's EXTENT_UPTODATE state is in
> > > > btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when=
 we
> > > > have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODA=
TE.
> > > >
> > > > For example, when performing a buffered random read:
> > > >
> > > >         fio --rw=3Drandread --ioengine=3Dlibaio --direct=3D0 --numj=
obs=3D4 \
> > > >                 --filesize=3D32G --size=3D4G --bs=3D4k --name=3Djob=
 \
> > > >                 --filename=3D/mnt/file --name=3Djob
> > > >
> > > > Then check how many extent_state in io_tree:
> > > >
> > > >         cat /proc/slabinfo | grep btrfs_extent_state | awk '{print =
$2}'
> > > >
> > > > w/o this patch, we got 640567 btrfs_extent_state.
> > > > w/  this patch, we got    204 btrfs_extent_state.
> > >
> > > Did fio also report increased throughput?
> > >
> >
> > Yes, but only when we have a lot of memory (32GB or above).
> > In a read benchmark, most of the memory can be used as page cache,
> > so there are no ways we can free those UPTODATE extent states unless
> > we explicitly call drop cache.
> > We have observed millions of useless EXTENT_UPTODATE extent states
> > in inode's io_tree, if w/o this patch.
> >
> > > >
> > > > Maintaining such a big tree brings overhead since every I/O needs t=
o insert
> > > > EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. A=
nd in
> > > > every insert or remove, we need to lock io_tree, do tree search, al=
loc or
> > > > dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we =
keep
> > > > io_tree in a minimal size and reduce overhead when performing buffe=
red I/O.
> > >
> > > The idea is sound, and I don't see a reason to keep using
> > > EXTENT_UPTODATE as well.
> > >
> > > >
> > > > Signed-off-by: Ethan Lien <ethanlien@synology.com>
> > > > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > > > ---
> > > >  fs/btrfs/extent-io-tree.h | 4 ++--
> > > >  fs/btrfs/extent_io.c      | 3 ---
> > > >  2 files changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> > > > index c3eb52dbe61c..53ae849d0248 100644
> > > > --- a/fs/btrfs/extent-io-tree.h
> > > > +++ b/fs/btrfs/extent-io-tree.h
> > > > @@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct ex=
tent_io_tree *tree, u64 start,
> > > >                                       struct extent_state **cached_=
state)
> > > >  {
> > > >         return set_extent_bit(tree, start, end,
> > > > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | e=
xtra_bits,
> > > > +                             EXTENT_DELALLOC | extra_bits,
> > > >                               0, NULL, cached_state, GFP_NOFS, NULL=
);
> > > >  }
> > > >
> > > > @@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct exte=
nt_io_tree *tree, u64 start,
> > > >                 u64 end, struct extent_state **cached_state)
> > > >  {
> > > >         return set_extent_bit(tree, start, end,
> > > > -                             EXTENT_DELALLOC | EXTENT_UPTODATE | E=
XTENT_DEFRAG,
> > > > +                             EXTENT_DELALLOC | EXTENT_DEFRAG,
> > > >                               0, NULL, cached_state, GFP_NOFS, NULL=
);
> > > >  }
> > > >
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index bfae67c593c5..e0f0a39cd6eb 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(str=
uct processed_extent *processed,
> > > >          * Now we don't have range contiguous to the processed rang=
e, release
> > > >          * the processed range now.
> > > >          */
> > > > -       if (processed->uptodate && tree->track_uptodate)
> > > > -               set_extent_uptodate(tree, processed->start, process=
ed->end,
> > > > -                                   &cached, GFP_ATOMIC);
> > >
> > > This is another good thing, to get rid of a GFP_ATOMIC allocation.
> > >
> > > Why didn't you remove the set_extent_uptodate() call at btrfs_get_ext=
ent() too?
> > > It can only be set during a page read at btrfs_do_readpage(), for an
> > > inline extent.
> > >
> > > Also, having the tests for EXTENT_UPTODATE at btrfs_do_readpage() now=
 become
> > > useless too, don't they? Why have you kept them?
> > >
> >
> > Currently if we found a inline extent in btrfs_get_extent(), we set
> > page uptodate
> > or page error in btrfs_do_readpage().
> > So we still need EXTENT_UPTODATE to let btrfs_do_readpage() knows what =
to do.
> >
> > Or do you suggest we set page uptodate or error in btrfs_get_extent(),
> > for inline extent?
>
> My idea was like this:
>
> 1) Remove the set_extent_uptodate() call at btrfs_get_extent();
>
> 2) At btrfs_do_readpage(), if we get a inline extent (em->block_start =3D=
=3D EXTENT_MAP_INLINE),
>    then we set the page up to date (at btrfs_do_readpage()).
>
> For step 2, we could also set the page up to date at btrfs_get_extent(), =
as
> you said.
>

It is possible we found a compressed inline extent and got error in
uncompress_inline().
So we can't unconditionally set page uptodate in btrfs_do_readpage(),
if we found em->block_start =3D=3D EXTENT_MAP_INLINE.
I think the only solution is we set page uptodate in btrfs_get_extent()?

Thanks.

> The only case where we get a page passed to btrfs_get_extent() is through
> btrfs_do_readpage(), so I think either approach should work, and then rem=
ove
> the remaining cases where we test for the EXTENT_UPTODATE state at
> btrfs_do_readpage().
>
> Thanks.
>
> >
> > Thanks.
> >
> > > Thanks.
> > >
> > > >         unlock_extent_cached_atomic(tree, processed->start, process=
ed->end,
> > > >                                     &cached);
> > > >
> > > > --
> > > > 2.17.1
> > > >
