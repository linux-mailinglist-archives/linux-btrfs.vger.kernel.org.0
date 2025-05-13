Return-Path: <linux-btrfs+bounces-13960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645DAB4D9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22C63A6FA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A01B1F4CBB;
	Tue, 13 May 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UQu8zBL6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F11F473A
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123537; cv=none; b=baW7Dl1DQrI4tzR8EYgL9+M3Q3tBUyspEFdoeSaAs7+jk5xJT5JMvG+fx6ijYLAciYBZjsnPlm12KCmvv8K+rc3EETDiV2pPxzkQc6Ie9935cm1Iy7OpP+EkenLLwyHjNMTY9IysiNRta9CCUfz5z0FxzjHjyWDfRSdasZpXz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123537; c=relaxed/simple;
	bh=xeRrpxY0V0JSOPpsA2jfcUcSlgWLY0Qz9Agbyum24mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/iLBjA62ImiNkpumpjB/ufHYH1QpAjKc+ayhScjoECq6OBcHq3r2QE9t2KIi/woTvP76BXzOns0734I3DQFK7tUbbfupwjYgS0Wdc9aO5c4TrOJB8ZofGZB/DUPB/Qe15Izj5QPDrKDACvfaGds5rUVFyHXoRcqtzRIhOjdV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UQu8zBL6; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fc9c49c8adso5392647a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747123533; x=1747728333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkOu4+nKDBYbwGwT4FXrl1FBTR+kr1z9v9OQH4t25ng=;
        b=UQu8zBL6c4qJyDHRfVJRDUGEXjgLIbSz8QuD34zq0ScI0nK25FbFbaIUI6Tvsp4XTI
         M1IhvpgOPFm4zy92MX7pLDWb5enaUmwR3P38Mzk7D5K9mmpBASr/6KBUrGT69zl86UlE
         jdYAbQhnjlgHjLmug8ds0G+pmCAluC+VXrDmWHB1Q3yEcplJMzLKzrZYiL13Aqt1e558
         QXng3X8d86lUvlJiu7myw+NFUawPbTZQ/ACEo4OhoKOjXSNeXmF6Q37Lcp1XHwrAyjDa
         VTtUGMgTZd2xWAyojrABw8rHmTA5S4FYVrsAx4yIrGbcYijG/Dcl+WChAKWEf3MNzWj+
         IYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123533; x=1747728333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkOu4+nKDBYbwGwT4FXrl1FBTR+kr1z9v9OQH4t25ng=;
        b=EY7UobGmeQpvO4Ix5V6xeg5khCSg1nHQ/qFllxk0JQSAOi7jaxaBNBcLMBXTO+GUv2
         vCuZuNEC2LANc1Pn2tPipFmhacP6eUjQLi0NH8Ort/4g718aDtdFX46tuwWzOVPwTPyV
         V2woWCGYaBT9/S9yoVKQclWIU8k2sGmCMlrhstIhAG8Y0Tal1gD7bTxcJZkDB/F4rsVz
         H83r+nPstqu8h/n3O/GBNFFinBgwtc0TOWftu+G3XK5/Q30ZzhSCuSd9ClEgP95ysV7x
         rudnkA7Ue6iCbgsNfmZbbHujCyOJQd5XH3BlCYZQjFvlY38ZJbR2hgVi4aetoKHzDj9x
         d0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU4zf7rnEPi8PWFl2HlDfwvXSry9/adcVbWmOgCf0Wz8TRDh5pTWLvkhckhMnmtLG/H+oATGbC2ynROuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4dVthWObxdUSZRfhMqVZDx6FlbEXDDZ/OMBTayrzSD5WiQquv
	4uiMFNGf3fDBo9rXr7hQ1ua8+Rvh6eyN/ZjD3prpgmacqTruBrqq6JaNDUTq2cv7+w5roGTrqgT
	91wVVe/jz21UPs7NaR/U0S2dks4l79q+iLIgIkA==
X-Gm-Gg: ASbGnctHGUy7xlLaguTCa/B3Xw4XMGBXmLfb8rKnhkoDT/njRrx2sHI5odWt7RXBaqU
	oMv/IwA2U/7Bznb98Vb04YlyB0sJW88+6bOpK48oXIpomjJievn2uUChEcHOY53XD4nUnoUvguZ
	DJ3q2skB6veVbJV3kS6qDSzWCrLwkXrjBQ0uT+DEwzIw==
X-Google-Smtp-Source: AGHT+IEL8GBwqURutuVGLW5YArmvSNtv6FhhCWthsOdCfgNy2nEays6VWM8RSGd1GdUi5EVy4MUuMydvOwoSmSA05/M=
X-Received: by 2002:a17:907:7f0a:b0:ad2:4bd4:946f with SMTP id
 a640c23a62f3a-ad24bd4954dmr788459966b.12.1747123533255; Tue, 13 May 2025
 01:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com> <4b29d4b8-c823-44d0-8647-a53a09e20b5f@gmx.com>
In-Reply-To: <4b29d4b8-c823-44d0-8647-a53a09e20b5f@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 10:05:21 +0200
X-Gm-Features: AX0GCFsSIpSBEFBUOfEMFFjR0ziHwaQv6jdUumOIEEri7BAAudj4fVHCONGf300
Message-ID: <CAPjX3FdJGfHarYMjVyR7qzKowbiauepcOMDJjDRt6Rs-5w0pHA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2025 at 00:44, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> =E5=9C=A8 2025/5/13 02:53, Daniel Vacek =E5=86=99=E9=81=93:
> > So far we are deriving the buffer tree index using the sector size. But=
 each
> > extent buffer covers multiple sectors. This makes the buffer tree rathe=
r sparse.
> >
> > For example the typical and quite common configuration uses sector size=
 of 4KiB
> > and node size of 16KiB. In this case it means the buffer tree is using =
up to
> > the maximum of 25% of it's slots. Or in other words at least 75% of the=
 tree
> > slots are wasted as never used.
> >
> > We can score significant memory savings on the required tree nodes by i=
ndexing
> > the tree using the node size instead. As a result far less slots are wa=
sted
> > and the tree can now use up to all 100% of it's slots this way.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
>
> I'm fine with this change, but I still believe, we should address
> unaligned tree blocks before doing this.

Yeah, we discussed it on chat. But giving it another thought I
realized that the ebs don't overlap each other. Well, I think they do
not, right?

That means they are always nodesize apart. So no matter what
alignment/offset each one always falls into a dedicated tree slot. It
can never happen that two neighboring ebs would fall into the same
slot. Hence I think we're safe here with this regard.

> As this requires all tree blocks are nodesize aligned.

Does it? I don't think that's correct. Am I missing something?

> If we have some metadata chunks which starts at a bytenr that is not
> node size aligned, all tree blocks inside that chunk will not be
> nodesize aligned and causing problems.

As explained above, I don't really see any problems. But then again, I
may be missing something. Let me know, please.

> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/disk-io.c   |  1 +
> >   fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
> >   fs/btrfs/fs.h        |  3 ++-
> >   3 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5bcf11246ba66..dcea5b0a2db50 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3395,6 +3395,7 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
> >       fs_info->delalloc_batch =3D sectorsize * 512 * (1 + ilog2(nr_cpu_=
ids));
> >
> >       fs_info->nodesize =3D nodesize;
> > +     fs_info->node_bits =3D ilog2(nodesize);
> >       fs_info->sectorsize =3D sectorsize;
> >       fs_info->sectorsize_bits =3D ilog2(sectorsize);
> >       fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_inf=
o->csum_size;
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 4d3584790cf7f..80a8563a25add 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer=
_for_io(struct extent_buffer *e
> >        */
> >       spin_lock(&eb->refs_lock);
> >       if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> > -             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->sectorsize_bits);
> > +             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->node_bits);
> >               unsigned long flags;
> >
> >               set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer =
*eb)
> >   static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_m=
ark_t mark)
> >   {
> >       struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sector=
size_bits);
> > +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_b=
its);
> >       unsigned long flags;
> >
> >       xas_lock_irqsave(&xas, flags);
> > @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct ext=
ent_buffer *eb, xa_mark_t mark)
> >   static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa=
_mark_t mark)
> >   {
> >       struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sector=
size_bits);
> > +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_b=
its);
> >       unsigned long flags;
> >
> >       xas_lock_irqsave(&xas, flags);
> > @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struc=
t btrfs_fs_info *fs_info,
> >       rcu_read_lock();
> >       while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
> >               if (!eb_batch_add(batch, eb)) {
> > -                     *start =3D (eb->start + eb->len) >> fs_info->sect=
orsize_bits;
> > +                     *start =3D (eb->start + eb->len) >> fs_info->node=
_bits;
> >                       goto out;
> >               }
> >       }
> > @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_n=
olock(
> >               struct btrfs_fs_info *fs_info, u64 start)
> >   {
> >       struct extent_buffer *eb;
> > -     unsigned long index =3D start >> fs_info->sectorsize_bits;
> > +     unsigned long index =3D start >> fs_info->node_bits;
> >
> >       rcu_read_lock();
> >       eb =3D xa_load(&fs_info->buffer_tree, index);
> > @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrf=
s_fs_info *fs_info, u64 start,
> >                                     u64 end)
> >   {
> >       struct eb_batch batch;
> > -     unsigned long start_index =3D start >> fs_info->sectorsize_bits;
> > -     unsigned long end_index =3D end >> fs_info->sectorsize_bits;
> > +     unsigned long start_index =3D start >> fs_info->node_bits;
> > +     unsigned long end_index =3D end >> fs_info->node_bits;
> >
> >       eb_batch_init(&batch);
> >       while (start_index <=3D end_index) {
> > @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space =
*mapping,
> >
> >       eb_batch_init(&batch);
> >       if (wbc->range_cyclic) {
> > -             index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_=
info->sectorsize_bits;
> > +             index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_=
info->node_bits;
> >               end =3D -1;
> >
> >               /*
> > @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space =
*mapping,
> >                */
> >               scanned =3D (index =3D=3D 0);
> >       } else {
> > -             index =3D wbc->range_start >> fs_info->sectorsize_bits;
> > -             end =3D wbc->range_end >> fs_info->sectorsize_bits;
> > +             index =3D wbc->range_start >> fs_info->node_bits;
> > +             end =3D wbc->range_end >> fs_info->node_bits;
> >
> >               scanned =3D 1;
> >       }
> > @@ -3037,7 +3037,7 @@ struct extent_buffer *alloc_test_extent_buffer(st=
ruct btrfs_fs_info *fs_info,
> >       eb->fs_info =3D fs_info;
> >   again:
> >       xa_lock_irq(&fs_info->buffer_tree);
> > -     exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->=
sectorsize_bits,
> > +     exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->=
node_bits,
> >                             NULL, eb, GFP_NOFS);
> >       if (xa_is_err(exists)) {
> >               ret =3D xa_err(exists);
> > @@ -3353,7 +3353,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
> >   again:
> >       xa_lock_irq(&fs_info->buffer_tree);
> >       existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > -                                start >> fs_info->sectorsize_bits, NUL=
L, eb,
> > +                                start >> fs_info->node_bits, NULL, eb,
> >                                  GFP_NOFS);
> >       if (xa_is_err(existing_eb)) {
> >               ret =3D xa_err(existing_eb);
> > @@ -3456,7 +3456,7 @@ static int release_extent_buffer(struct extent_bu=
ffer *eb)
> >                * in this case.
> >                */
> >               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > -                            eb->start >> fs_info->sectorsize_bits, eb,=
 NULL,
> > +                            eb->start >> fs_info->node_bits, eb, NULL,
> >                              GFP_ATOMIC);
> >
> >               btrfs_leak_debug_del_eb(eb);
> > @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(stru=
ct folio *folio)
> >   {
> >       struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> >       struct extent_buffer *eb;
> > -     unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize_b=
its;
> > +     unsigned long start =3D folio_pos(folio) >> fs_info->node_bits;
> >       unsigned long index =3D start;
> > -     unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize_b=
its) - 1;
> > +     unsigned long end =3D index + (PAGE_SIZE >> fs_info->node_bits) -=
 1;
> >       int ret;
> >
> >       xa_lock_irq(&fs_info->buffer_tree);
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index cf805b4032af3..8c9113304fabe 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -778,8 +778,9 @@ struct btrfs_fs_info {
> >
> >       struct btrfs_delayed_root *delayed_root;
> >
> > -     /* Entries are eb->start / sectorsize */
> > +     /* Entries are eb->start >> node_bits */
> >       struct xarray buffer_tree;
> > +     int node_bits;
> >
> >       /* Next backup root to be overwritten */
> >       int backup_root_index;
>

