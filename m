Return-Path: <linux-btrfs+bounces-13970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42237AB52C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 12:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E589A352C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A112512DD;
	Tue, 13 May 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOoYM8hO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413521B199;
	Tue, 13 May 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131169; cv=none; b=klRz+TLYnHqoiacLUAk7g4PJh/nkodXkRXfKtm8UADgnCR76GKWttzM4l2QecV7q1BppJqOEAVL3agdDN51PpkXpMVv2Fb9vPWIHPKgorqmMyTwZ4HHilFJkId0kUcsRwmaeOPzIsxoQB/euURi/RA+nBHdE70bv9vpMwioXXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131169; c=relaxed/simple;
	bh=mtbSlGOD3Eh8R7i/GQYOUfu3zaEkdo/pg1/MzBiVbq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUz4CMuSHyMXtIMz2NCPB9mMTv3+mHJYKfzIcCk585+8F1xbZ5wc022lo7jJCDZLmLs+C7+WC0hU58n6GOjRe2pBUlAHakQGPPjo4opNk672Kq2CeJY68LV3pBagTr/yuUPvx5QVdjFVFq6Qy7c0H6yOceh7CkSXK0fB7zNooSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOoYM8hO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF7CC4CEEF;
	Tue, 13 May 2025 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747131168;
	bh=mtbSlGOD3Eh8R7i/GQYOUfu3zaEkdo/pg1/MzBiVbq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jOoYM8hO3bVCUJ0YsAQVHdrygrWDdrucEZiIFnb4i0d3H1Wet+q3t1WpydUBUBk6F
	 SxbMTtk8z3M8k9meA9Sr4BZ/OhhxUE3HEgYTNncFf5YRjSg25dR9MEJC6izc7ejqXh
	 ttDKmQoMtalqp7l7Icn0lFFDKWGtYMTfwMnVx3cDtnlkjpa+Lx48JvoTATo9OmIp+q
	 DrRe7CVLMyd80dDizjha5BNsXvKXrD8A4q0kNmFseidKzb4RZsCU4xSvfZ92NEavGz
	 mY4K6QX1ypbx6h39nRciOdj8hC/yyrPKzxt7rfQUzRFTRWxamqvj16T0cvTa50I+sW
	 0xwoSHUeVO+Kw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acacb8743a7so915287966b.1;
        Tue, 13 May 2025 03:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNiibanBIDEK5VLOVkwsF8havWDpagT6+pnN4PKZc0Ch2B405Nv8SlFxrbO2LCCCXCqO4e3pd2gEOJPgvr@vger.kernel.org, AJvYcCWUWKNaAqLg5y7X/Fz+ydjhm2b6kG1iefiGLkTdRNKFrjoNIK70A65dgFELLVY6D4POmWgFALDEsFT9Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb33q7C1TFA8yao+mzMe+47snAncsOwXzJWwr9PSxNgHmYDw7
	jsn45OA02BpnSNVLvRNr58y7T2oj1qvpmOXZlRqjLz/WsBVX6qRPmpBmR6feh50zsUooqsLxhUE
	EnzOKF7wOh2lc+jAXJGNFAn3pLsA=
X-Google-Smtp-Source: AGHT+IGYcveKxOlay4bGvFKD7Birh0Jg5WQaOKA96wL6RMWgoAaGVuVZBCIj0IVhB+mL4+55YXh8TMsC4yhy8NXLfHw=
X-Received: by 2002:a17:907:3f99:b0:ad2:2c83:fb43 with SMTP id
 a640c23a62f3a-ad4d52732bcmr243315766b.23.1747131167239; Tue, 13 May 2025
 03:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com>
In-Reply-To: <20250512172321.3004779-1-neelx@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 13 May 2025 11:12:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5WVUu3sHAJYhP+n2UKKKRNLbYHayBUvc8W9RC2_i5nuQ@mail.gmail.com>
X-Gm-Features: AX0GCFu6lq8nWhRMXBcGFHIx7zjVEmH3FQDll5qcDTiGgdh1i63Kkd8rr-1d31Q
Message-ID: <CAL3q7H5WVUu3sHAJYhP+n2UKKKRNLbYHayBUvc8W9RC2_i5nuQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:24=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote=
:
>
> So far we are deriving the buffer tree index using the sector size. But e=
ach
> extent buffer covers multiple sectors. This makes the buffer tree rather =
sparse.
>
> For example the typical and quite common configuration uses sector size o=
f 4KiB
> and node size of 16KiB. In this case it means the buffer tree is using up=
 to
> the maximum of 25% of it's slots. Or in other words at least 75% of the t=
ree
> slots are wasted as never used.
>
> We can score significant memory savings on the required tree nodes by ind=
exing
> the tree using the node size instead. As a result far less slots are wast=
ed
> and the tree can now use up to all 100% of it's slots this way.

Did you do any benchmarks? What results did you get?

If we could get in practice such a huge amount of space gains and
waste so much less memory, you should observe faster operations on the
buffer tree (xarray) as well, as we would get a smaller data
structure, with fewer nodes.

However, while this is a logically sound thing to do, in practice we
will always get many unused slots per xarray node, because:

1) We don't keep all extent buffers in memory all the time - some are
less frequently used and get evicted from memory after a while or
rarely get loaded in the first place, not all parts of a btree are
equally "hot";

2) It's a COW filesystem and metadata is always COWed, so you get
extent buffers allocated all over the place with big gaps between
them, in different block groups, etc.

And what about memory usage, did you see any significant reduction for
some workload? What was the reduction, what was the workload?

Xarray uses a kmem_cache to allocate nodes, so if we get such huge
gains as the change log claims, we should see a reduction by
monitoring files inside /sys/kernel/slab/radix_tree_node, like the
"objects" and "total_objects" files which tell the us the total amount
of allocated xarray nodes and how many are in use - this is for all
xarrays, so many will not belong to the buffer tree or even btrfs, but
it should still be very noticeable reduction on a workload that is
heavy on metadata, like fs_mark with empty files creating a large fs
tree (a few gigabytes at least).

Thanks.


>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  fs/btrfs/disk-io.c   |  1 +
>  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
>  fs/btrfs/fs.h        |  3 ++-
>  3 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5bcf11246ba66..dcea5b0a2db50 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3395,6 +3395,7 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>         fs_info->delalloc_batch =3D sectorsize * 512 * (1 + ilog2(nr_cpu_=
ids));
>
>         fs_info->nodesize =3D nodesize;
> +       fs_info->node_bits =3D ilog2(nodesize);
>         fs_info->sectorsize =3D sectorsize;
>         fs_info->sectorsize_bits =3D ilog2(sectorsize);
>         fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_inf=
o->csum_size;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4d3584790cf7f..80a8563a25add 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer_f=
or_io(struct extent_buffer *e
>          */
>         spin_lock(&eb->refs_lock);
>         if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> -               XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->sectorsize_bits);
> +               XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->node_bits);
>                 unsigned long flags;
>
>                 set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer *e=
b)
>  static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark=
_t mark)
>  {
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sector=
size_bits);
> +       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_b=
its);
>         unsigned long flags;
>
>         xas_lock_irqsave(&xas, flags);
> @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct exten=
t_buffer *eb, xa_mark_t mark)
>  static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_ma=
rk_t mark)
>  {
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> -       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sector=
size_bits);
> +       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_b=
its);
>         unsigned long flags;
>
>         xas_lock_irqsave(&xas, flags);
> @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct =
btrfs_fs_info *fs_info,
>         rcu_read_lock();
>         while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
>                 if (!eb_batch_add(batch, eb)) {
> -                       *start =3D (eb->start + eb->len) >> fs_info->sect=
orsize_bits;
> +                       *start =3D (eb->start + eb->len) >> fs_info->node=
_bits;
>                         goto out;
>                 }
>         }
> @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_nol=
ock(
>                 struct btrfs_fs_info *fs_info, u64 start)
>  {
>         struct extent_buffer *eb;
> -       unsigned long index =3D start >> fs_info->sectorsize_bits;
> +       unsigned long index =3D start >> fs_info->node_bits;
>
>         rcu_read_lock();
>         eb =3D xa_load(&fs_info->buffer_tree, index);
> @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrfs_=
fs_info *fs_info, u64 start,
>                                       u64 end)
>  {
>         struct eb_batch batch;
> -       unsigned long start_index =3D start >> fs_info->sectorsize_bits;
> -       unsigned long end_index =3D end >> fs_info->sectorsize_bits;
> +       unsigned long start_index =3D start >> fs_info->node_bits;
> +       unsigned long end_index =3D end >> fs_info->node_bits;
>
>         eb_batch_init(&batch);
>         while (start_index <=3D end_index) {
> @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space *m=
apping,
>
>         eb_batch_init(&batch);
>         if (wbc->range_cyclic) {
> -               index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_=
info->sectorsize_bits;
> +               index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs_=
info->node_bits;
>                 end =3D -1;
>
>                 /*
> @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space *m=
apping,
>                  */
>                 scanned =3D (index =3D=3D 0);
>         } else {
> -               index =3D wbc->range_start >> fs_info->sectorsize_bits;
> -               end =3D wbc->range_end >> fs_info->sectorsize_bits;
> +               index =3D wbc->range_start >> fs_info->node_bits;
> +               end =3D wbc->range_end >> fs_info->node_bits;
>
>                 scanned =3D 1;
>         }
> @@ -3037,7 +3037,7 @@ struct extent_buffer *alloc_test_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
>         eb->fs_info =3D fs_info;
>  again:
>         xa_lock_irq(&fs_info->buffer_tree);
> -       exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->=
sectorsize_bits,
> +       exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->=
node_bits,
>                               NULL, eb, GFP_NOFS);
>         if (xa_is_err(exists)) {
>                 ret =3D xa_err(exists);
> @@ -3353,7 +3353,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>  again:
>         xa_lock_irq(&fs_info->buffer_tree);
>         existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> -                                  start >> fs_info->sectorsize_bits, NUL=
L, eb,
> +                                  start >> fs_info->node_bits, NULL, eb,
>                                    GFP_NOFS);
>         if (xa_is_err(existing_eb)) {
>                 ret =3D xa_err(existing_eb);
> @@ -3456,7 +3456,7 @@ static int release_extent_buffer(struct extent_buff=
er *eb)
>                  * in this case.
>                  */
>                 xa_cmpxchg_irq(&fs_info->buffer_tree,
> -                              eb->start >> fs_info->sectorsize_bits, eb,=
 NULL,
> +                              eb->start >> fs_info->node_bits, eb, NULL,
>                                GFP_ATOMIC);
>
>                 btrfs_leak_debug_del_eb(eb);
> @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(struct=
 folio *folio)
>  {
>         struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
>         struct extent_buffer *eb;
> -       unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize_b=
its;
> +       unsigned long start =3D folio_pos(folio) >> fs_info->node_bits;
>         unsigned long index =3D start;
> -       unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize_b=
its) - 1;
> +       unsigned long end =3D index + (PAGE_SIZE >> fs_info->node_bits) -=
 1;
>         int ret;
>
>         xa_lock_irq(&fs_info->buffer_tree);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index cf805b4032af3..8c9113304fabe 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -778,8 +778,9 @@ struct btrfs_fs_info {
>
>         struct btrfs_delayed_root *delayed_root;
>
> -       /* Entries are eb->start / sectorsize */
> +       /* Entries are eb->start >> node_bits */
>         struct xarray buffer_tree;
> +       int node_bits;
>
>         /* Next backup root to be overwritten */
>         int backup_root_index;
> --
> 2.47.2
>
>

