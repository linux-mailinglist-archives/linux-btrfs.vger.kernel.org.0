Return-Path: <linux-btrfs+bounces-13146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601DA92BDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 21:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6603A7CD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457F202988;
	Thu, 17 Apr 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTxJlWiS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A11FE469
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918364; cv=none; b=Nhxapk8BQh35ngC2F9h9Zrn5q92l7GAkjTvKo425/WGmq2CsWWFx10trM7Iyq+aZPxAKaYTdMWskQVK/sfiX97PJ2c4IsJBB+lRpV8+ccba7qjDllfyXlUYYuov8rns0ul8RLMy6g92EFJPR7XbB09Ejeq4nyu0cUCUhmDT4xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918364; c=relaxed/simple;
	bh=OW8DKpgNkG/2SOWO6TUdPh4RP847nEw5ebBPMsSxRE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpjJCVPADhn01qiWf6Qm8DN6S7QAKTSyAMh6BST1zldb1YYkd9Pte/j9otFxzu0IFaETZixVu85GC1tqpOoT8LXNijmPUfFp+caOnUUrm6x/SNNFNJ0rEfzW6Ji5YTj8O9r8xdTR2Dt81WvgQ5o0NeIpO1XTJmISsyQZJHoi8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTxJlWiS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac73723b2d5so212745166b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744918360; x=1745523160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcsXiUB4mrYSkQoTdqSvQvQNpllWt+pblrzGpxrnEQw=;
        b=eTxJlWiS1DkphegpEyabHlPDgD4iQmBHXmZwMhfR74IVt+T2pIah3WllYm0CL45FIW
         5FghW33dUFGJuxo80RcbTFzMzgyDaXU9+WSHBx3vttDIbiu/kDG6PV7LHt368bSHBd6B
         B3Oz4KM7ErG4B1zIZ/l47hv+b27nBs+nnPUwcJDQzzu4NXG5rZTqz11K6XEQB74xA2Xw
         1wa9gBBmsaXuHS2BdpYqGOTqu4FntBfBe8uwJoqR1n+tuqU19UGpDTrbjWqGOFwnpS+I
         1tOzgZH6S/q1oRnkHdCIe0+yeRtjaNHGmXcQY0xA5WRsUd7xnW9TICSdCnKnEK9MWOF0
         PBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744918360; x=1745523160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcsXiUB4mrYSkQoTdqSvQvQNpllWt+pblrzGpxrnEQw=;
        b=BbDcZZlrSCtXQ6pkaFzOiKYKCuT5N7YDs03EZgxLxNm02xneAKtvIkR+KQo7AcCuPp
         4II8+ttfU4J6XpH43PbA0KHcCB68uO3DH4xM/w4qM6n5gvSKmSvat2M3UrhLL5cnn2Jx
         QJvY9xT29ik77lUHclo3ccBoncPg+ZQ40E7z1qN1HuFtUrCfteXTlfETb8WCjjodpoUt
         nMgG0/a2mSBmpX+8dbJyCzOM40FVxtViHiYFu1jEodRTMKpZrGVSK4WcO06HPS7ndrMH
         UsfNYNRg/D4ZYUOuWvxOt6oRpXKjMjGLjFHMKrtaej/B4cM85ZW4yIkmGcoHl362WWQE
         NB+Q==
X-Gm-Message-State: AOJu0Yw9RyN77V4w5aP17ezh2wye61roLLBoF9AN95XJG5TdKTCzjeHb
	igPaUnzlfm4ETckXcpxT7ywNSrFDLxY8K9d7CDmI6y8bIRwSw03Qn+8W2o0ukFnTxn01N1R0lhZ
	WLi2akiIE3KMg6Y2pqtrAhYgRirQFW8vRhSL+sQ==
X-Gm-Gg: ASbGnctGRoP2AWYeYIc6oy0SZLPV+oEQOwrVRzViey2MrSCp+n19h0BYmQ+ItRHm30h
	IJOPE661Gr2A9NscRhPt+fvL2DAak+gvmY81/7VR3sSq8vcJ4fw+L+xuDJ196aSE1g95+a1JFTU
	nXUjMeFbvn8ZmcwVbDVCrywBEXfOhjv34=
X-Google-Smtp-Source: AGHT+IGsI8AGwWMxHTW41CNLdWeaF/CyhxaqzK0rhEIY3quwfF713Fznzk9W/UVc1sO8If1OAPLGljR9prZ2TmOkyWw=
X-Received: by 2002:a17:907:1c92:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-acb74b4d9b9mr7399666b.21.1744918359699; Thu, 17 Apr 2025
 12:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744840038.git.josef@toxicpanda.com> <1f3982ec56c49f642ef35698c39e16f56f4bc4f5.1744840038.git.josef@toxicpanda.com>
In-Reply-To: <1f3982ec56c49f642ef35698c39e16f56f4bc4f5.1744840038.git.josef@toxicpanda.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 17 Apr 2025 21:32:28 +0200
X-Gm-Features: ATxdqUGBwtC2pyhe6-cj92IZk7IBbcPuzYQalr4LQy5aQydXu5MUIBK0XDyAoEM
Message-ID: <CAPjX3FdNYekOPOg+8MB9HeJ5AWsd+TUbOX2vpCqdJGr4+tD3bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: convert the buffer_radix to an xarray
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 23:50, Josef Bacik <josef@toxicpanda.com> wrote:
>
> In order to fully utilize xarray tagging to improve writeback we need to
> convert the buffer_radix to a proper xarray.  This conversion is
> relatively straightforward as the radix code uses the xarray underneath.
> Using xarray directly allows for quite a lot less code.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c           |  15 ++-
>  fs/btrfs/extent_io.c         | 196 +++++++++++++++--------------------
>  fs/btrfs/fs.h                |   4 +-
>  fs/btrfs/tests/btrfs-tests.c |  27 ++---
>  fs/btrfs/zoned.c             |  16 +--
>  5 files changed, 113 insertions(+), 145 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 59da809b7d57..5593873f5c0f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>         return ret;
>  }
>
> +/*
> + * lockdep gets confused between our buffer_xarray which requires IRQ locking
> + * because we modify marks in the IRQ context, and our delayed inode xarray
> + * which doesn't have these requirements. Use a class key so lockdep doesn't get
> + * them mixed up.
> + */
> +static struct lock_class_key buffer_xa_class;
> +
>  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  {
>         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> +
> +       /* Use the same flags as mapping->i_pages. */
> +       xa_init_flags(&fs_info->buffer_xarray, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> +       lockdep_set_class(&fs_info->buffer_xarray.xa_lock, &buffer_xa_class);
> +
>         INIT_LIST_HEAD(&fs_info->trans_list);
>         INIT_LIST_HEAD(&fs_info->dead_roots);
>         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>         spin_lock_init(&fs_info->delayed_iput_lock);
>         spin_lock_init(&fs_info->defrag_inodes_lock);
>         spin_lock_init(&fs_info->super_lock);
> -       spin_lock_init(&fs_info->buffer_lock);
>         spin_lock_init(&fs_info->unused_bgs_lock);
>         spin_lock_init(&fs_info->treelog_bg_lock);
>         spin_lock_init(&fs_info->zone_active_bgs_lock);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6cfd286b8bbc..309c86d1a696 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buffer *eb)
>   * context.
>   */
>  static struct extent_buffer *find_extent_buffer_nolock(
> -               const struct btrfs_fs_info *fs_info, u64 start)
> +               struct btrfs_fs_info *fs_info, u64 start)
>  {
> +       XA_STATE(xas, &fs_info->buffer_xarray, start >> fs_info->sectorsize_bits);
>         struct extent_buffer *eb;
>
>         rcu_read_lock();
> -       eb = radix_tree_lookup(&fs_info->buffer_radix,
> -                              start >> fs_info->sectorsize_bits);
> -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> -               rcu_read_unlock();
> -               return eb;
> -       }
> +       do {
> +               eb = xas_load(&xas);
> +       } while (xas_retry(&xas, eb));
> +
> +       if (eb && !atomic_inc_not_zero(&eb->refs))
> +               eb = NULL;
>         rcu_read_unlock();
> -       return NULL;
> +       return eb;
>  }
>
>  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> @@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
>
>         if (!btrfs_meta_is_subpage(fs_info)) {
>                 /*
> -                * We do this since we'll remove the pages after we've
> -                * removed the eb from the radix tree, so we could race
> -                * and have this page now attached to the new eb.  So
> -                * only clear folio if it's still connected to
> -                * this eb.
> +                * We do this since we'll remove the pages after we've removed
> +                * the eb from the xarray, so we could race and have this page
> +                * now attached to the new eb.  So only clear folio if it's
> +                * still connected to this eb.
>                  */
>                 if (folio_test_private(folio) && folio_get_private(folio) == eb) {
>                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> @@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
>  {
>         int refs;
>         /*
> -        * The TREE_REF bit is first set when the extent_buffer is added
> -        * to the radix tree. It is also reset, if unset, when a new reference
> -        * is created by find_extent_buffer.
> +        * The TREE_REF bit is first set when the extent_buffer is added to the
> +        * xarray. It is also reset, if unset, when a new reference is created
> +        * by find_extent_buffer.
>          *
>          * It is only cleared in two cases: freeing the last non-tree
>          * reference to the extent_buffer when its STALE bit is set or
> @@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
>          * conditions between the calls to check_buffer_tree_ref in those
>          * codepaths and clearing TREE_REF in try_release_extent_buffer.
>          *
> -        * The actual lifetime of the extent_buffer in the radix tree is
> -        * adequately protected by the refcount, but the TREE_REF bit and
> -        * its corresponding reference are not. To protect against this
> -        * class of races, we call check_buffer_tree_ref from the codepaths
> -        * which trigger io. Note that once io is initiated, TREE_REF can no
> -        * longer be cleared, so that is the moment at which any such race is
> -        * best fixed.
> +        * The actual lifetime of the extent_buffer in the xarray is adequately
> +        * protected by the refcount, but the TREE_REF bit and its corresponding
> +        * reference are not. To protect against this class of races, we call
> +        * check_buffer_tree_ref from the codepaths which trigger io. Note that
> +        * once io is initiated, TREE_REF can no longer be cleared, so that is
> +        * the moment at which any such race is best fixed.
>          */
>         refs = atomic_read(&eb->refs);
>         if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> @@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>                 return ERR_PTR(-ENOMEM);
>         eb->fs_info = fs_info;
>  again:
> -       ret = radix_tree_preload(GFP_NOFS);
> -       if (ret) {
> -               exists = ERR_PTR(ret);
> +       xa_lock_irq(&fs_info->buffer_xarray);
> +       exists = __xa_cmpxchg(&fs_info->buffer_xarray,
> +                             start >> fs_info->sectorsize_bits, NULL, eb,
> +                             GFP_NOFS);

I think the xa_unlock_irq() can go straight here. Or rather you could
use xa_cmpxchg_irq() instead?
Or do you protect exists->refs with it as well? It seems so, IIUC. Not
sure it is strictly needed, though.

> +       if (xa_is_err(exists)) {
> +               ret = xa_err(exists);
> +               xa_unlock_irq(&fs_info->buffer_xarray);
> +               btrfs_release_extent_buffer(eb);
> +               return ERR_PTR(ret);
> +       }
> +       if (exists) {
> +               if (!atomic_inc_not_zero(&exists->refs)) {
> +                       /* The extent buffer is being freed, retry. */
> +                       xa_unlock_irq(&fs_info->buffer_xarray);
> +                       goto again;
> +               }
> +               xa_unlock_irq(&fs_info->buffer_xarray);
>                 goto free_eb;
>         }
> -       spin_lock(&fs_info->buffer_lock);
> -       ret = radix_tree_insert(&fs_info->buffer_radix,
> -                               start >> fs_info->sectorsize_bits, eb);
> -       spin_unlock(&fs_info->buffer_lock);
> -       radix_tree_preload_end();
> -       if (ret == -EEXIST) {
> -               exists = find_extent_buffer(fs_info, start);
> -               if (exists)
> -                       goto free_eb;
> -               else
> -                       goto again;
> -       }
> +       xa_unlock_irq(&fs_info->buffer_xarray);
>         check_buffer_tree_ref(eb);
>
>         return eb;
> @@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
>         lockdep_assert_held(&folio->mapping->i_private_lock);
>
>         /*
> -        * For subpage case, we completely rely on radix tree to ensure we
> -        * don't try to insert two ebs for the same bytenr.  So here we always
> -        * return NULL and just continue.
> +        * For subpage case, we completely rely on xarray to ensure we don't try
> +        * to insert two ebs for the same bytenr.  So here we always return NULL
> +        * and just continue.
>          */
>         if (btrfs_meta_is_subpage(fs_info))
>                 return NULL;
> @@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
>         /*
>          * To inform we have an extra eb under allocation, so that
>          * detach_extent_buffer_page() won't release the folio private when the
> -        * eb hasn't been inserted into radix tree yet.
> +        * eb hasn't been inserted into the xarray yet.
>          *
>          * The ref will be decreased when the eb releases the page, in
>          * detach_extent_buffer_page().  Thus needs no special handling in the
> @@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>
>                 /*
>                  * We can't unlock the pages just yet since the extent buffer
> -                * hasn't been properly inserted in the radix tree, this
> -                * opens a race with btree_release_folio which can free a page
> -                * while we are still filling in all pages for the buffer and
> -                * we could crash.
> +                * hasn't been properly inserted in the xarray, this opens a
> +                * race with btree_release_folio which can free a page while we
> +                * are still filling in all pages for the buffer and we could
> +                * crash.
>                  */
>         }
>         if (uptodate)
> @@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>         if (page_contig)
>                 eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
>  again:
> -       ret = radix_tree_preload(GFP_NOFS);
> -       if (ret)
> +       xa_lock_irq(&fs_info->buffer_xarray);
> +       existing_eb = __xa_cmpxchg(&fs_info->buffer_xarray,
> +                                  start >> fs_info->sectorsize_bits, NULL, eb,
> +                                  GFP_NOFS);

Ditto.

> +       if (xa_is_err(existing_eb)) {
> +               ret = xa_err(existing_eb);
> +               xa_unlock_irq(&fs_info->buffer_xarray);
>                 goto out;
> -
> -       spin_lock(&fs_info->buffer_lock);
> -       ret = radix_tree_insert(&fs_info->buffer_radix,
> -                               start >> fs_info->sectorsize_bits, eb);
> -       spin_unlock(&fs_info->buffer_lock);
> -       radix_tree_preload_end();
> -       if (ret == -EEXIST) {
> -               ret = 0;
> -               existing_eb = find_extent_buffer(fs_info, start);
> -               if (existing_eb)
> -                       goto out;
> -               else
> -                       goto again;
>         }
> +       if (existing_eb) {
> +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> +                       xa_unlock_irq(&fs_info->buffer_xarray);
> +                       goto again;
> +               }
> +               xa_unlock_irq(&fs_info->buffer_xarray);
> +               goto out;
> +       }
> +       xa_unlock_irq(&fs_info->buffer_xarray);
> +
>         /* add one reference for the tree */
>         check_buffer_tree_ref(eb);
>
> @@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct extent_buffer *eb)
>
>                 spin_unlock(&eb->refs_lock);
>
> -               spin_lock(&fs_info->buffer_lock);
> -               radix_tree_delete_item(&fs_info->buffer_radix,
> -                                      eb->start >> fs_info->sectorsize_bits, eb);
> -               spin_unlock(&fs_info->buffer_lock);
> +               /*
> +                * We're erasing, theoretically there will be no allocations, so
> +                * just use GFP_ATOMIC.
> +                */
> +               xa_cmpxchg_irq(&fs_info->buffer_xarray,
> +                              eb->start >> fs_info->sectorsize_bits, eb, NULL,
> +                              GFP_ATOMIC);
>
>                 btrfs_leak_debug_del_eb(eb);
>                 /* Should be safe to release folios at this point. */
> @@ -4260,44 +4267,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
>         }
>  }
>
> -#define GANG_LOOKUP_SIZE       16
> -static struct extent_buffer *get_next_extent_buffer(
> -               const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
> -{
> -       struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> -       struct extent_buffer *found = NULL;
> -       u64 folio_start = folio_pos(folio);
> -       u64 cur = folio_start;
> -
> -       ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
> -       lockdep_assert_held(&fs_info->buffer_lock);
> -
> -       while (cur < folio_start + PAGE_SIZE) {
> -               int ret;
> -               int i;
> -
> -               ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> -                               (void **)gang, cur >> fs_info->sectorsize_bits,
> -                               min_t(unsigned int, GANG_LOOKUP_SIZE,
> -                                     PAGE_SIZE / fs_info->nodesize));
> -               if (ret == 0)
> -                       goto out;
> -               for (i = 0; i < ret; i++) {
> -                       /* Already beyond page end */
> -                       if (gang[i]->start >= folio_start + PAGE_SIZE)
> -                               goto out;
> -                       /* Found one */
> -                       if (gang[i]->start >= bytenr) {
> -                               found = gang[i];
> -                               goto out;
> -                       }
> -               }
> -               cur = gang[ret - 1]->start + gang[ret - 1]->len;
> -       }
> -out:
> -       return found;
> -}
> -
>  static int try_release_subpage_extent_buffer(struct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
> @@ -4306,21 +4275,26 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>         int ret;
>
>         while (cur < end) {
> +               XA_STATE(xas, &fs_info->buffer_xarray,
> +                        cur >> fs_info->sectorsize_bits);
>                 struct extent_buffer *eb = NULL;
>
>                 /*
>                  * Unlike try_release_extent_buffer() which uses folio private
> -                * to grab buffer, for subpage case we rely on radix tree, thus
> -                * we need to ensure radix tree consistency.
> +                * to grab buffer, for subpage case we rely on xarray, thus we
> +                * need to ensure xarray tree consistency.
>                  *
> -                * We also want an atomic snapshot of the radix tree, thus go
> +                * We also want an atomic snapshot of the xarray tree, thus go
>                  * with spinlock rather than RCU.
>                  */
> -               spin_lock(&fs_info->buffer_lock);
> -               eb = get_next_extent_buffer(fs_info, folio, cur);
> +               xa_lock_irq(&fs_info->buffer_xarray);
> +               do {
> +                       eb = xas_find(&xas, end >> fs_info->sectorsize_bits);
> +               } while (xas_retry(&xas, eb));
> +
>                 if (!eb) {
>                         /* No more eb in the page range after or at cur */
> -                       spin_unlock(&fs_info->buffer_lock);
> +                       xa_unlock(&fs_info->buffer_xarray);

I may be missing something but is this a typo? Should this be xa_unlock_irq()?

>                         break;
>                 }
>                 cur = eb->start + eb->len;
> @@ -4332,10 +4306,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>                 spin_lock(&eb->refs_lock);
>                 if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
>                         spin_unlock(&eb->refs_lock);
> -                       spin_unlock(&fs_info->buffer_lock);
> +                       xa_unlock(&fs_info->buffer_xarray);

xa_unlock_irq() again?

I don't even see any reason for XA_FLAGS_LOCK_IRQ in the first place
to be honest.
(Ah, OK. It's because of clearing the writeback tag in the
end_bbio_meta_write() in the second patch. On my machine it runs from
a threaded interrupt but that's not universal I guess.)

>                         break;
>                 }
> -               spin_unlock(&fs_info->buffer_lock);
> +               xa_unlock_irq(&fs_info->buffer_xarray);
>
>                 /*
>                  * If tree ref isn't set then we know the ref on this eb is a
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index bcca43046064..d5d94977860c 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -776,10 +776,8 @@ struct btrfs_fs_info {
>
>         struct btrfs_delayed_root *delayed_root;
>
> -       /* Extent buffer radix tree */
> -       spinlock_t buffer_lock;
>         /* Entries are eb->start / sectorsize */
> -       struct radix_tree_root buffer_radix;
> +       struct xarray buffer_xarray;

I'm not exactly a fan of encoding the type in the name. I'd simply
call this 'buffers' or 'extent_buffers'.

>         /* Next backup root to be overwritten */
>         int backup_root_index;
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 02a915eb51fb..741117ce7d3f 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
>
>  void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>  {
> -       struct radix_tree_iter iter;
> -       void **slot;
> +       XA_STATE(xas, &fs_info->buffer_xarray, 0);
>         struct btrfs_device *dev, *tmp;
> +       struct extent_buffer *eb;
>
>         if (!fs_info)
>                 return;
> @@ -169,25 +169,16 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>
>         test_mnt->mnt_sb->s_fs_info = NULL;
>
> -       spin_lock(&fs_info->buffer_lock);
> -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
> -               struct extent_buffer *eb;
> -
> -               eb = radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
> -               if (!eb)
> +       xa_lock_irq(&fs_info->buffer_xarray);
> +       xas_for_each(&xas, eb, ULONG_MAX) {
> +               if (xas_retry(&xas, eb))
>                         continue;
> -               /* Shouldn't happen but that kind of thinking creates CVE's */
> -               if (radix_tree_exception(eb)) {
> -                       if (radix_tree_deref_retry(eb))
> -                               slot = radix_tree_iter_retry(&iter);
> -                       continue;
> -               }
> -               slot = radix_tree_iter_resume(slot, &iter);
> -               spin_unlock(&fs_info->buffer_lock);
> +               xas_pause(&xas);
> +               xa_unlock_irq(&fs_info->buffer_xarray);
>                 free_extent_buffer_stale(eb);
> -               spin_lock(&fs_info->buffer_lock);
> +               xa_lock_irq(&fs_info->buffer_xarray);
>         }
> -       spin_unlock(&fs_info->buffer_lock);
> +       xa_unlock_irq(&fs_info->buffer_xarray);
>
>         btrfs_mapping_tree_free(fs_info);
>         list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7b30700ec930..7ed19ca399f3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2170,28 +2170,22 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
>  static void wait_eb_writebacks(struct btrfs_block_group *block_group)
>  {
>         struct btrfs_fs_info *fs_info = block_group->fs_info;
> +       XA_STATE(xas, &fs_info->buffer_xarray,
> +                block_group->start >> fs_info->sectorsize_bits);
>         const u64 end = block_group->start + block_group->length;
> -       struct radix_tree_iter iter;
>         struct extent_buffer *eb;
> -       void __rcu **slot;
>
>         rcu_read_lock();
> -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
> -                                block_group->start >> fs_info->sectorsize_bits) {
> -               eb = radix_tree_deref_slot(slot);
> -               if (!eb)
> +       xas_for_each(&xas, eb, end >> fs_info->sectorsize_bits) {
> +               if (xas_retry(&xas, eb))
>                         continue;
> -               if (radix_tree_deref_retry(eb)) {
> -                       slot = radix_tree_iter_retry(&iter);
> -                       continue;
> -               }
>
>                 if (eb->start < block_group->start)
>                         continue;
>                 if (eb->start >= end)
>                         break;
>
> -               slot = radix_tree_iter_resume(slot, &iter);
> +               xas_pause(&xas);
>                 rcu_read_unlock();
>                 wait_on_extent_buffer_writeback(eb);
>                 rcu_read_lock();
> --
> 2.48.1
>
>

