Return-Path: <linux-btrfs+bounces-13975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85FAB574F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755D016AF2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD5F201031;
	Tue, 13 May 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VJ0wFnZz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687DDDC1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147071; cv=none; b=u+AKUGavL4wW0V0/bL3CL8h/16dssyxNkKmSiUVj4oHk8+mKCdzkhsXGJzV5t7ScKWJYbxTQGdl/Xpgm3VNeTcxM9C3qovDB3g9vmReU98gEsVEM7TLf7C/YcbgkSsHVKLSkGQlqGoFxA4BB9sQxNpeW0n1YlLhB3RK9a7GNhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147071; c=relaxed/simple;
	bh=CQ1eTpAirWAWicVJP9Z4ssU7VJWA2MrVQn6FMscmAM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2TREO9+wY4k4ktyCVwatdfEVMQgAZwQqRRrHozxDiqnXou43s2go/3nnD3vaQyANx5mjkb6zCMxRzVJsV0fvOXOJBPfto0T3hFG4abxWbMiRM+VGMiNhNIuQ5v5auTQjAU823P1zEbWfO+ZMGz7+nIdGOC7RtjbPtjh8VN3b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJ0wFnZz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad23ec87134so539202166b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747147067; x=1747751867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBbAyLqny0RImEAM2CODiB0gqDeoovZSecFLzkFrj30=;
        b=VJ0wFnZz0qBPSgKt5EDqPT3URSJL49pCk+uib4XiEV6nBpjVLM0A+fz6Cv1J65N4Pl
         8g5CXvmW+HRQPkO/kqF+Oxj7uNuleeOj47Y9CmtoBHlcyyPCB4uGpXmIYIC3BrUuBsuS
         2dvdaNxFhQKAZleQXQ0bjyN7WgvcXd7d3uJJfZMNaCAC4Nt/vCjH5GJXyg3kqnKKqpzB
         LTMZS9i2usdV+qVsDEqjrFs5GaEaXXz4GCI9Jf/LkiTHEFnqN08TyxnUnq9XvmH2kHz8
         NuZTpfNUAn4ZetQtJRAzhgICW9UG8sdUjasNhRdynV/p/iEgSy6A6D7YcTktszui5uSA
         +frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147067; x=1747751867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBbAyLqny0RImEAM2CODiB0gqDeoovZSecFLzkFrj30=;
        b=HfXSQdd0ow1bak/goAmUEYWMP1/h5CWY/yL5SMUA3g72nPs53izWsX3/PdgmMeA5Ws
         IPOUgZrdKZdFzM9KzDOszKOnHFkkEGOXYUu6qi+vmpE2foPA33rq6U/Wbhl+FmTi8Jd4
         BcDEzpYcmQ8nGyUG8dRJeGW0JWob1n2qKa8nh+lAi4zC696evzhsPUhpBLPdS2nue6Lb
         cOTpklCWr6IzLQTsVU3eK7BRobIgvvrE26XDfCWsI/C3+4VTG5M1mWpBbIPz+Y//7iDH
         /Mracjyyxyi8WunK88s32dqH8iOCi9ngMhj6FjtVEdzG+jHQrdXuQ8T07qlhCSXxfRjN
         8R+w==
X-Forwarded-Encrypted: i=1; AJvYcCUgxYIjUYj7H0NEuX3m0LjXazxb8BRIh1jIS1by9mpxolpunNl6tqIQSq70qk6VkRpH9NLYXwm5+8HztQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmdqfe9rkmPZqiTysAanzwheJhzJtrIa04LIy3Wev8S8C1L8DW
	d7OaMFBgEgkOEKYmAZkhPeVl8qZMxqiyUbtMAdrRQHbxfiTjPdgKch0+7yj577+WXblf9A39PcZ
	g23BvNdlg7oPHkVsyV118cionH4F79YK+b10fzg==
X-Gm-Gg: ASbGnctgA1bZ656cdMB2koSNmTYXl3R8NW7JQJzwf887mnRZ8orMxDxtwpgpEeF90UV
	jrn1W4HBqiPNfBxeeXGkv2Jb+tJKRd2ylCb0RfoivnPE/UJ2ZLVAatT9xkyRtE0yOw+Iwulz+f7
	ML+IPiSjYmaaonM8MRv0xam/c9OPOhWzDIVlhkQv5XPA==
X-Google-Smtp-Source: AGHT+IG8jJwG6WGrQYdVHirdz+fmJ6PUu4jl3YppfzRPrSvGdsxCuj94hLlUgd48ZLTDCHIu5fuySiAUFzGa1Bem4VI=
X-Received: by 2002:a17:906:6a0a:b0:ad2:2a5d:b1af with SMTP id
 a640c23a62f3a-ad22a5db5b9mr1571684066b.55.1747147066907; Tue, 13 May 2025
 07:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com> <CAL3q7H5WVUu3sHAJYhP+n2UKKKRNLbYHayBUvc8W9RC2_i5nuQ@mail.gmail.com>
In-Reply-To: <CAL3q7H5WVUu3sHAJYhP+n2UKKKRNLbYHayBUvc8W9RC2_i5nuQ@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 13 May 2025 16:37:34 +0200
X-Gm-Features: AX0GCFvgvhkhbNq5oCfHwVUrBRPkmkAca-V7VKJFmnNUEJPf22R4TzuLjJxbfp8
Message-ID: <CAPjX3FdOBKFYNkMiAa=cV6VUdqCLVGoHDCGnJsEP0-Mgn7azjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: Filipe Manana <fdmanana@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2025 at 12:12, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, May 12, 2025 at 6:24=E2=80=AFPM Daniel Vacek <neelx@suse.com> wro=
te:
> >
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
>
> Did you do any benchmarks? What results did you get?

Not really benchmarks. I just run fstests to make sure nothing fails.

> If we could get in practice such a huge amount of space gains and
> waste so much less memory, you should observe faster operations on the
> buffer tree (xarray) as well, as we would get a smaller data
> structure, with fewer nodes.

That's precisely the point, to save the memory with less nodes. I
don't expect to see any faster operations, really. I believe the radix
tree is quite efficient in the kernel. And for a tree in general
theory the operations are O(log(n)), so a bigger tree does not have
that much higher overhead.
But this reduces the tree height by one level tops. More likely not
even that. I still quite believe the tree operations overhead is well
below the threshold of noise for fs operations. You would really have
to microbenchmark just the tree operations themselves to see the
difference.

But I can still be pleasantly surprised.

> However, while this is a logically sound thing to do, in practice we
> will always get many unused slots per xarray node, because:
>
> 1) We don't keep all extent buffers in memory all the time - some are
> less frequently used and get evicted from memory after a while or
> rarely get loaded in the first place, not all parts of a btree are
> equally "hot";

No questions about that. This part does not change.

> 2) It's a COW filesystem and metadata is always COWed, so you get
> extent buffers allocated all over the place with big gaps between
> them, in different block groups, etc.

Yes, and sparse leaf nodes are actually expected and perfectly fine.
Still, there is no need to be more sparse than actually needed. Wasted
slots are wasted slots. Some leaf nodes are still full with 16 ebs
while 64 could have been fitted.

> And what about memory usage, did you see any significant reduction for
> some workload? What was the reduction, what was the workload?

I did not really check, to be honest. But since you're asking...

On my laptop with an uptime of two months and with a handful of sleep
cycles, workload about what you do on your workstation (couple VMs,
many FF tabs, many terminals and a live crash running), mem stats from
`top` below, 1T NVMe, there are 20610 ebs and 6455 tree leaves as I
type at the moment (but I bet it was similar yday or a week ago). The
highest tree index is 4341c9c which means 5 levels (with the patch it
would still be 5 levels, just the width would be 1/4 as the index
would become 10d0727) and that FS (/home) has 13k of the ebs and 4150
of leave nodes (/ is 7600 ebs / 2300 leaves and /boot has 10/5
allocated in memory), so you can see the tree is still fairly sparse
as there are way less ebs then available slots. Not even 3.2 ebs in
one leaf on average.

MiB Mem :  58470,3 total,   6035,4 free,  34408,7 used,  19525,8 buff/cache
MiB Swap:  32768,0 total,  15929,4 free,  16838,6 used.  24061,6 avail Mem

But I believe there are also huge parts of the tree not even
allocated. For example there are no nodes needed between indices 41ccc
and 3cc1d88 as there are no ebs allocated in this range. I did not
check but I guess the hole actually begins with the end of one bg and
ends with the start of another bg??

With the patch I guess you could expect something like 4k leaf nodes
instead of the 6k5 I see now. I estimate something like 30-40% savings
instead of the theoretical 75% if the ebs were fully present. Well
that's still not bad.

On the other hand if you check the absolute numbers, that's roughly
1.5 megs saved on a 64 gigs machine. And that's provided the slabs
were released, but see below...

Now even though it looks like a huge win if you focused only in terms
of btrfs, compared to the rest of the system it looks almost
insignificant:

> crash> kmem -s radix_tree_node
> CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
> ffff9eecc0045b00      576     464807    542899  19393    16k  radix_tree_=
node

I guess most of the tree nodes are used in memory mappings, vmas and
stuff, and inode mapping to page cache.

If btrfs is using 6.5k tree nodes (just for leaves to be fair, there
will be some more for inner nodes) out of the total of 0.5M nodes in
flight system-wide it's something over 1%, so maybe 2%. This patch can
reduce it by something like 0.5% being generous. Well, I can take it.

So yeah, we're wasting some memory and that can be fixed. But we're
far from being any significant user in the kernel. Just to fill in the
perspective.

> Xarray uses a kmem_cache to allocate nodes, so if we get such huge
> gains as the change log claims, we should see a reduction by
> monitoring files inside /sys/kernel/slab/radix_tree_node, like the
> "objects" and "total_objects" files which tell the us the total amount
> of allocated xarray nodes and how many are in use - this is for all
> xarrays, so many will not belong to the buffer tree or even btrfs, but
> it should still be very noticeable reduction on a workload that is
> heavy on metadata, like fs_mark with empty files creating a large fs
> tree (a few gigabytes at least).
>
> Thanks.
>
>
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >  fs/btrfs/disk-io.c   |  1 +
> >  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
> >  fs/btrfs/fs.h        |  3 ++-
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5bcf11246ba66..dcea5b0a2db50 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3395,6 +3395,7 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
> >         fs_info->delalloc_batch =3D sectorsize * 512 * (1 + ilog2(nr_cp=
u_ids));
> >
> >         fs_info->nodesize =3D nodesize;
> > +       fs_info->node_bits =3D ilog2(nodesize);
> >         fs_info->sectorsize =3D sectorsize;
> >         fs_info->sectorsize_bits =3D ilog2(sectorsize);
> >         fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_i=
nfo->csum_size;
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 4d3584790cf7f..80a8563a25add 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer=
_for_io(struct extent_buffer *e
> >          */
> >         spin_lock(&eb->refs_lock);
> >         if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> > -               XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_in=
fo->sectorsize_bits);
> > +               XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_in=
fo->node_bits);
> >                 unsigned long flags;
> >
> >                 set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer =
*eb)
> >  static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_ma=
rk_t mark)
> >  {
> >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > -       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sect=
orsize_bits);
> > +       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node=
_bits);
> >         unsigned long flags;
> >
> >         xas_lock_irqsave(&xas, flags);
> > @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct ext=
ent_buffer *eb, xa_mark_t mark)
> >  static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_=
mark_t mark)
> >  {
> >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > -       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sect=
orsize_bits);
> > +       XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node=
_bits);
> >         unsigned long flags;
> >
> >         xas_lock_irqsave(&xas, flags);
> > @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struc=
t btrfs_fs_info *fs_info,
> >         rcu_read_lock();
> >         while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
> >                 if (!eb_batch_add(batch, eb)) {
> > -                       *start =3D (eb->start + eb->len) >> fs_info->se=
ctorsize_bits;
> > +                       *start =3D (eb->start + eb->len) >> fs_info->no=
de_bits;
> >                         goto out;
> >                 }
> >         }
> > @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_n=
olock(
> >                 struct btrfs_fs_info *fs_info, u64 start)
> >  {
> >         struct extent_buffer *eb;
> > -       unsigned long index =3D start >> fs_info->sectorsize_bits;
> > +       unsigned long index =3D start >> fs_info->node_bits;
> >
> >         rcu_read_lock();
> >         eb =3D xa_load(&fs_info->buffer_tree, index);
> > @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrf=
s_fs_info *fs_info, u64 start,
> >                                       u64 end)
> >  {
> >         struct eb_batch batch;
> > -       unsigned long start_index =3D start >> fs_info->sectorsize_bits=
;
> > -       unsigned long end_index =3D end >> fs_info->sectorsize_bits;
> > +       unsigned long start_index =3D start >> fs_info->node_bits;
> > +       unsigned long end_index =3D end >> fs_info->node_bits;
> >
> >         eb_batch_init(&batch);
> >         while (start_index <=3D end_index) {
> > @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space =
*mapping,
> >
> >         eb_batch_init(&batch);
> >         if (wbc->range_cyclic) {
> > -               index =3D (mapping->writeback_index << PAGE_SHIFT) >> f=
s_info->sectorsize_bits;
> > +               index =3D (mapping->writeback_index << PAGE_SHIFT) >> f=
s_info->node_bits;
> >                 end =3D -1;
> >
> >                 /*
> > @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space =
*mapping,
> >                  */
> >                 scanned =3D (index =3D=3D 0);
> >         } else {
> > -               index =3D wbc->range_start >> fs_info->sectorsize_bits;
> > -               end =3D wbc->range_end >> fs_info->sectorsize_bits;
> > +               index =3D wbc->range_start >> fs_info->node_bits;
> > +               end =3D wbc->range_end >> fs_info->node_bits;
> >
> >                 scanned =3D 1;
> >         }
> > @@ -3037,7 +3037,7 @@ struct extent_buffer *alloc_test_extent_buffer(st=
ruct btrfs_fs_info *fs_info,
> >         eb->fs_info =3D fs_info;
> >  again:
> >         xa_lock_irq(&fs_info->buffer_tree);
> > -       exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info=
->sectorsize_bits,
> > +       exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info=
->node_bits,
> >                               NULL, eb, GFP_NOFS);
> >         if (xa_is_err(exists)) {
> >                 ret =3D xa_err(exists);
> > @@ -3353,7 +3353,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
> >  again:
> >         xa_lock_irq(&fs_info->buffer_tree);
> >         existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > -                                  start >> fs_info->sectorsize_bits, N=
ULL, eb,
> > +                                  start >> fs_info->node_bits, NULL, e=
b,
> >                                    GFP_NOFS);
> >         if (xa_is_err(existing_eb)) {
> >                 ret =3D xa_err(existing_eb);
> > @@ -3456,7 +3456,7 @@ static int release_extent_buffer(struct extent_bu=
ffer *eb)
> >                  * in this case.
> >                  */
> >                 xa_cmpxchg_irq(&fs_info->buffer_tree,
> > -                              eb->start >> fs_info->sectorsize_bits, e=
b, NULL,
> > +                              eb->start >> fs_info->node_bits, eb, NUL=
L,
> >                                GFP_ATOMIC);
> >
> >                 btrfs_leak_debug_del_eb(eb);
> > @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(stru=
ct folio *folio)
> >  {
> >         struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> >         struct extent_buffer *eb;
> > -       unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize=
_bits;
> > +       unsigned long start =3D folio_pos(folio) >> fs_info->node_bits;
> >         unsigned long index =3D start;
> > -       unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize=
_bits) - 1;
> > +       unsigned long end =3D index + (PAGE_SIZE >> fs_info->node_bits)=
 - 1;
> >         int ret;
> >
> >         xa_lock_irq(&fs_info->buffer_tree);
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index cf805b4032af3..8c9113304fabe 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -778,8 +778,9 @@ struct btrfs_fs_info {
> >
> >         struct btrfs_delayed_root *delayed_root;
> >
> > -       /* Entries are eb->start / sectorsize */
> > +       /* Entries are eb->start >> node_bits */
> >         struct xarray buffer_tree;
> > +       int node_bits;
> >
> >         /* Next backup root to be overwritten */
> >         int backup_root_index;
> > --
> > 2.47.2
> >
> >

