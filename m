Return-Path: <linux-btrfs+bounces-14870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A3AE462C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FC5440179
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945906EB79;
	Mon, 23 Jun 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ffZv9t6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B914A0B7
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687496; cv=none; b=NlntMZhqdEmpKRCdFcJ1hTIuNb4tTaFehIK/8zzHlS6rCB8EBd2Ec2DXpUaQm7EH1EPwPEOl5tz3wV6WUsYhueTf1eJt9xb2xpss/7S8X+Undd7MPSwtzPtlTv/GYwOh1nktBvO0465WmJdKXMtYkNowQ7BO28wSOsPnrxD5jN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687496; c=relaxed/simple;
	bh=RmiCXxDHhTGbGoBiT3oHockHpnGGspLZPHTDXEctQeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewvV2HuUBeKxDhpbggahUd0T6cWhLc78HutYalQq+3j7rL9a4Lm9fVGSr+f83k7bAokNBJnhE/WH1RdcCm5sQlBcXFO/yu9cVlMRiMDYNoMfPdBv1D7lERoKfZdgD8FQrYFxolziXlG4Rb8xtdsbjfF70AgkbmvkN5fasXC/7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ffZv9t6C; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade48b24c97so741900266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750687493; x=1751292293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfrBqzsSE7yWX19A0UXME0A5ZkQZKzUcZdws1aPCR9I=;
        b=ffZv9t6CrlkmIvxYheA/qv9dPROvWIovHQkwU9zIrU9Ywkg2p9F+0L+W6BHddb+QIW
         drBzkLzHK27yRCmGM2Qw4wwGse6RgpmDz5zrVYcl4rR4lhk/WBuXVUKhGSjwBevI4iHK
         B5FoMFyd3J2UQ8+kuUio2E71otHmEzv3zy/MiIXTNxSVhz2WXswRBiBEZf5jixmvcBFS
         RtbEP3UZXlTe3x0RUaY662bExT3tcXvDJSvDtv5BVRdZ28YkuQmHFpiRPWYe4hiYrWtY
         z7C0JI7kezAwlZBMUmYOBkwRD3uBs27PbqFp+yu3uDT92YI40woMOghlyOZbE0cDia4s
         U5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687493; x=1751292293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfrBqzsSE7yWX19A0UXME0A5ZkQZKzUcZdws1aPCR9I=;
        b=Gpb/05KBTWVptxjk9vWhVI+wAr0stibEDWsrFsgO++Xl4NgY3VaxLYbA7tAjMqZsOj
         Ays1RFTLS+c2Cl6jJVVSbLnzlpo5oe80DsS877XEREgJslnf4cAgI4X0g0PYD5aiFNy0
         qsPwMogrNO3GkN2v7HSFqiWwWiHoD6EzSUk7iqIC5OsB6g84W9GQwqcZ5iBY/4zrd/AD
         eJjdzqcHkWfurEJYFav9O5t6mgCnlRKAftqGLNwNbM2ofznlb6Ihim+1cBTuh+5Val+M
         U+4rvGvt+HnByjuUwInUsq0TmxcmTe/H0jHFnR3RmGcQq3XKxU+l064FgWW9r719jcvX
         4gxw==
X-Forwarded-Encrypted: i=1; AJvYcCW3zEa8hldTTef85daVry5sL8Qdz6hulnXsM6yuRiH9RmkNIfErO9iBwHwIfUCQqpfgjnum37RnEIRjRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdPhKVvgCrtRJ/TRoOEvKpYmQczPqxAehJqlLju1MZ1rLRlqz
	mARGCOkFKBtbgLr1W2mIU8ialqsvtsppomgIKLjQ/RzllmPIR+cAYWRO0mnuo6Yxseca7djPpIx
	DY3ccusndd91SHsQLyLTGcq9wIKbI5m+Xdqw9HxJHsQ==
X-Gm-Gg: ASbGncsWrSaXOCDn/XxzC30OjNI/YBz5ApZsehcm2wIlN8YA3Ay5qBm7HIYsrGQL8LJ
	rr1gxGz9kyv5wdnwuhIv/n35k2iNZ0ohVrCEzvHSyku5h/lPwV0AahpZMVsHWH4hMpYLxyEQnxd
	3mQ2Y07TDWImkvZJQ671cLslCZqYTUPdHXG1NFV5xGxwfkfbiYpraB
X-Google-Smtp-Source: AGHT+IHi5Ofr1jXDQL9A3pBCC+mfedFK5U5X2wO7Bw3uj1n1UulpZGduhQJr1+fIy7dJghdlKPl7aLvA1ImTJl/KUek=
X-Received: by 2002:a17:907:dab:b0:ace:c518:1327 with SMTP id
 a640c23a62f3a-ae0579bc890mr1248239666b.14.1750687492202; Mon, 23 Jun 2025
 07:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612084724.3149616-1-neelx@suse.com> <20250620125744.GT4037@twin.jikos.cz>
In-Reply-To: <20250620125744.GT4037@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 23 Jun 2025 16:04:39 +0200
X-Gm-Features: AX0GCFva0Yh7S-w2S6mbYE5090otnPbf9ZE5WT4zU80YuH9-VXYcmO5B_pS6L4Y
Message-ID: <CAPjX3FdgS4xJBvvsx9zRxiuRm9=5VcTynmtnidga4gcqewLrUw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: index buffer_tree using node size
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 14:57, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jun 12, 2025 at 10:47:23AM +0200, Daniel Vacek wrote:
> > So far we are deriving the buffer tree index using the sector size. But each
> > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> >
> > For example the typical and quite common configuration uses sector size of 4KiB
> > and node size of 16KiB. In this case it means the buffer tree is using up to
> > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > slots are wasted as never used.
> >
> > We can score significant memory savings on the required tree nodes by indexing
> > the tree using the node size instead. As a result far less slots are wasted
> > and the tree can now use up to all 100% of it's slots this way.
> >
> > Note: This works even with unaligned tree blocks as we can still get unique
> >       index by doing eb->start >> nodesize_shift.
>
> Can we have at least some numbers? As we've talked about it and you
> showed me the number of radix nodes or other internal xarray structures
> before/after.

The numbers are in this email thread. Do you mean to put them directly
into the commit message?

> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > ---
> > v2 changes:
> >  * Note that this is still correct even with unaligned tree blocks.
> >  * Rename node_bits to nodesize_bits to stay consistent.
> >  * Move the nodesize_bits member next to nodesize and make it u32.
> >
> > ---
> >  fs/btrfs/disk-io.c   |  1 +
> >  fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
> >  fs/btrfs/fs.h        |  3 ++-
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 0d6ad7512f217..3d465258f15b7 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3396,6 +3396,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >       fs_info->delalloc_batch = sectorsize * 512 * (1 + ilog2(nr_cpu_ids));
> >
> >       fs_info->nodesize = nodesize;
> > +     fs_info->nodesize_bits = ilog2(nodesize);
> >       fs_info->sectorsize = sectorsize;
> >       fs_info->sectorsize_bits = ilog2(sectorsize);
> >       fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index e9ba80a56172d..a55c7c7eb8990 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
> >        */
> >       spin_lock(&eb->refs_lock);
> >       if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> > -             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> > +             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
> >               unsigned long flags;
> >
> >               set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> > @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer *eb)
> >  static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
> >  {
> >       struct btrfs_fs_info *fs_info = eb->fs_info;
> > -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> > +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
> >       unsigned long flags;
> >
> >       xas_lock_irqsave(&xas, flags);
> > @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
> >  static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_mark_t mark)
> >  {
> >       struct btrfs_fs_info *fs_info = eb->fs_info;
> > -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
> > +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->nodesize_bits);
> >       unsigned long flags;
> >
> >       xas_lock_irqsave(&xas, flags);
> > @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
> >       rcu_read_lock();
> >       while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
> >               if (!eb_batch_add(batch, eb)) {
> > -                     *start = ((eb->start + eb->len) >> fs_info->sectorsize_bits);
> > +                     *start = (eb->start + eb->len) >> fs_info->nodesize_bits;
>
> In other places you drop the outer ( ) from the shifts, please keep it
> if it's there (or add if it's missing).

Right. This happened by the rebase as they were not there before. So
is this the preferred code style from now on?

> >                       goto out;
> >               }
> >       }
> > @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_nolock(
> >               struct btrfs_fs_info *fs_info, u64 start)
> >  {
> >       struct extent_buffer *eb;
> > -     unsigned long index = (start >> fs_info->sectorsize_bits);
> > +     unsigned long index = start >> fs_info->nodesize_bits;
> >
> >       rcu_read_lock();
> >       eb = xa_load(&fs_info->buffer_tree, index);
> > @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btrfs_fs_info *fs_info, u64 start,
> >                                     u64 end)
> >  {
> >       struct eb_batch batch;
> > -     unsigned long start_index = (start >> fs_info->sectorsize_bits);
> > -     unsigned long end_index = (end >> fs_info->sectorsize_bits);
> > +     unsigned long start_index = start >> fs_info->nodesize_bits;
> > +     unsigned long end_index = end >> fs_info->nodesize_bits;
> >
> >       eb_batch_init(&batch);
> >       while (start_index <= end_index) {
> > @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space *mapping,
> >
> >       eb_batch_init(&batch);
> >       if (wbc->range_cyclic) {
> > -             index = ((mapping->writeback_index << PAGE_SHIFT) >> fs_info->sectorsize_bits);
> > +             index = (mapping->writeback_index << PAGE_SHIFT) >> fs_info->nodesize_bits;
> >               end = -1;
> >
> >               /*
> > @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space *mapping,
> >                */
> >               scanned = (index == 0);
> >       } else {
> > -             index = (wbc->range_start >> fs_info->sectorsize_bits);
> > -             end = (wbc->range_end >> fs_info->sectorsize_bits);
> > +             index = wbc->range_start >> fs_info->nodesize_bits;
> > +             end = wbc->range_end >> fs_info->nodesize_bits;
> >
> >               scanned = 1;
> >       }
> > @@ -3038,7 +3038,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> >       eb->fs_info = fs_info;
> >  again:
> >       xa_lock_irq(&fs_info->buffer_tree);
> > -     exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->sectorsize_bits,
> > +     exists = __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info->nodesize_bits,
> >                             NULL, eb, GFP_NOFS);
> >       if (xa_is_err(exists)) {
> >               ret = xa_err(exists);
> > @@ -3355,7 +3355,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >  again:
> >       xa_lock_irq(&fs_info->buffer_tree);
> >       existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
> > -                                start >> fs_info->sectorsize_bits, NULL, eb,
> > +                                start >> fs_info->nodesize_bits, NULL, eb,
> >                                  GFP_NOFS);
> >       if (xa_is_err(existing_eb)) {
> >               ret = xa_err(existing_eb);
> > @@ -3458,7 +3458,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
> >                * in this case.
> >                */
> >               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > -                            eb->start >> fs_info->sectorsize_bits, eb, NULL,
> > +                            eb->start >> fs_info->nodesize_bits, eb, NULL,
> >                              GFP_ATOMIC);
> >
> >               btrfs_leak_debug_del_eb(eb);
> > @@ -4300,9 +4300,9 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >  {
> >       struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
> >       struct extent_buffer *eb;
> > -     unsigned long start = (folio_pos(folio) >> fs_info->sectorsize_bits);
> > +     unsigned long start = folio_pos(folio) >> fs_info->nodesize_bits;
> >       unsigned long index = start;
> > -     unsigned long end = index + (PAGE_SIZE >> fs_info->sectorsize_bits) - 1;
> > +     unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
> >       int ret;
> >
> >       xa_lock_irq(&fs_info->buffer_tree);
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index b239e4b8421cf..fd7cbbe3515d6 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -781,7 +781,7 @@ struct btrfs_fs_info {
> >
> >       struct btrfs_delayed_root *delayed_root;
> >
> > -     /* Entries are eb->start / sectorsize */
> > +     /* Entries are eb->start >> nodesize_bits */
> >       struct xarray buffer_tree;
> >
> >       /* Next backup root to be overwritten */
> > @@ -813,6 +813,7 @@ struct btrfs_fs_info {
> >
> >       /* Cached block sizes */
> >       u32 nodesize;
> > +     u32 nodesize_bits;
> >       u32 sectorsize;
> >       /* ilog2 of sectorsize, use to avoid 64bit division */
> >       u32 sectorsize_bits;
> > --
> > 2.47.2
> >

