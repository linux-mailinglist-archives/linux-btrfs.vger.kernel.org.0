Return-Path: <linux-btrfs+bounces-13429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B46A9CD93
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0587E9E00BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C128DEE0;
	Fri, 25 Apr 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PV6o/aaA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD9288C9F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596129; cv=none; b=qMp8jkXIBm7T4TKpKGEQr+spsQR+25cmeA7VArQysCmCwFLHL5emsveNgcOJOJMIAAOuSODZ9PtRAnjOhtUedHJdqPq1o1YTle5DhMKBKveGGNqiE3tRQp7tZwNgKDA6oCezJbEbafnXPQPWyAXJ89DL0AJ5cpL9Ne60w9Zo4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596129; c=relaxed/simple;
	bh=tFvrd9uQeDsyUW0xLZO+/jHQIeVstozKb62/sepRJSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzLJggG81bbF0sPYuChbqp971WBY3NGcm8W0MenIzLVGS8BHJeUTRHGeKIJZcJLfGP2zyV3fpDeEAWGtWrGDpThn2ijKQJB1LGS5HfxgpnrfvOGfS6t6FV7Am9ojInxDlmnwzj6tWqGaBQ1lwaRbbNI7VdfG/RmED6Qw0Sn1LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PV6o/aaA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47692b9d059so40658241cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745596126; x=1746200926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z84Ukz9VTrC+G6FLjnwiM7n7fgCc7B52JuYTE96GSuk=;
        b=PV6o/aaAVcWi8MEesQXK7bsImnhVeg6poDBp8tzjOzPCUij1G9qpZquw++6czdvyqB
         fLad5d9e6xTdTAM16bXdErQmDVqV3OISMo/5IfRozTD8gVoJhLlJMCC5/dc0gmu0WHgY
         P/NOzlw/SPwDQo9bTtfJaqzXA05eltxr/HAyfZRHCWoKEsQY4x66SMdE7vGowkv/ascx
         +wo1mX5sGn7e04O9b5eyDUF+8H1RhC0iGOoumA9iidqqhV0fJcDI6enVZEbr7bjfpI0j
         5qjd7zAFGSP05WSTWZwODJ+MwbNb3NBYJXitanIVjp8YM3rnU36nNao9raFuMGp5ABfs
         /wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596126; x=1746200926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z84Ukz9VTrC+G6FLjnwiM7n7fgCc7B52JuYTE96GSuk=;
        b=ceUexNCPKK4uKdr1neQV2tfGV2ZssFGBiXAPqzyr9dPp3likpR171/z3ThdgjnF+Um
         /kYavPDl2FapCnBTbGhM4m0GkZJ+cu2Gq1Ix7rHZY9yzpOKyHuUr6rI2uVUEsZyfhRn2
         LCwxoPvre1aBocq+h3SAEqMdlrlCRo59tFrTl3qfEOhxq74c/Mi6ipOzuHBUpkakWZ+Y
         GoLHasfjT7F7bxK5h1YegP6yu4+YuQZD2/nrqVVucsjaltKLUo9zG3r+peqrcA444s+j
         ZKjsAvLx51hvILM7jkhWVpQBLeKEAaYmGA7Jnl6eTKIMzaAaZCiYaB0cI7js7Sy5yG9b
         bDWg==
X-Gm-Message-State: AOJu0YxoYiHPGMl62DeWUmtmXwUCBgNvh4OtJtjLrRMPvDCTAldgtEg2
	X1l3kpGepScm8Q0AchR9q3yh7prg2JJecZ7tUgWx3azoWIq2GR/4F3aYwVUHRO8=
X-Gm-Gg: ASbGnctoa2jO7V9Z+M9ICQ3GY+Ec7rWp6xUpj5laN6Ahk6S5wqyYroYfHTRgjfxVcli
	/6aVbhAhfYcAIrqgvYf2LtRdj2t13TtgtgOzaJJ1sxfRazBGyqwW0Dgz5xXZRDBIe0+wp8kJ+Bq
	1SIYAUhAhh8IR3ppsfh2iDAcGmi1ljhU+sfdmzji625khHw5quySljrIjFEHbS5XZp2yaH7GzfX
	3apePo7hG3Qqkm24+g5SthgAqsmQxtVN2nsR77eR/ZX0SiG55ZHgkjSKPrXels5DF4Ir7Xf68fO
	FWY+4p01covrPaB7O2ay3MkO3Ww+kwsY+UEAy7muUGEmIX20/I99mVcVQRkoljun0tQgvjd7mph
	pUw==
X-Google-Smtp-Source: AGHT+IFQSuyAtb7H3dCana9dRSuA96zFZj8+s4ssVx/ZIAuxzaTkpBg1BhBn4kwUEfI9rCIi3V4ZjQ==
X-Received: by 2002:a05:622a:14e:b0:476:74de:81e2 with SMTP id d75a77b69052e-4801eadafb2mr48012241cf.43.1745596125936;
        Fri, 25 Apr 2025 08:48:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1693378sm26774411cf.64.2025.04.25.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:48:45 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:48:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, willy@infradead.org
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
Message-ID: <20250425154844.GB494636@perftesting>
References: <cover.1744984487.git.josef@toxicpanda.com>
 <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>
 <20250424154719.GA311510@perftesting>
 <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>

On Thu, Apr 24, 2025 at 05:07:29PM +0100, Filipe Manana wrote:
> On Thu, Apr 24, 2025 at 4:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 04:08:56PM +0100, Filipe Manana wrote:
> > > On Fri, Apr 18, 2025 at 2:58 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > In order to fully utilize xarray tagging to improve writeback we need to
> > > > convert the buffer_radix to a proper xarray.  This conversion is
> > > > relatively straightforward as the radix code uses the xarray underneath.
> > > > Using xarray directly allows for quite a lot less code.
> > > >
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > >  fs/btrfs/disk-io.c           |  15 ++-
> > > >  fs/btrfs/extent_io.c         | 196 +++++++++++++++--------------------
> > > >  fs/btrfs/fs.h                |   4 +-
> > > >  fs/btrfs/tests/btrfs-tests.c |  27 ++---
> > > >  fs/btrfs/zoned.c             |  16 +--
> > > >  5 files changed, 113 insertions(+), 145 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > > index 59da809b7d57..24c08eb86b7b 100644
> > > > --- a/fs/btrfs/disk-io.c
> > > > +++ b/fs/btrfs/disk-io.c
> > > > @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
> > > >         return ret;
> > > >  }
> > > >
> > > > +/*
> > > > + * lockdep gets confused between our buffer_tree which requires IRQ locking
> > > > + * because we modify marks in the IRQ context, and our delayed inode xarray
> > > > + * which doesn't have these requirements. Use a class key so lockdep doesn't get
> > > > + * them mixed up.
> > > > + */
> > > > +static struct lock_class_key buffer_xa_class;
> > > > +
> > > >  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> > > >  {
> > > >         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> > > > -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> > > > +
> > > > +       /* Use the same flags as mapping->i_pages. */
> > > > +       xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> > > > +       lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_class);
> > > > +
> > > >         INIT_LIST_HEAD(&fs_info->trans_list);
> > > >         INIT_LIST_HEAD(&fs_info->dead_roots);
> > > >         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> > > > @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> > > >         spin_lock_init(&fs_info->delayed_iput_lock);
> > > >         spin_lock_init(&fs_info->defrag_inodes_lock);
> > > >         spin_lock_init(&fs_info->super_lock);
> > > > -       spin_lock_init(&fs_info->buffer_lock);
> > > >         spin_lock_init(&fs_info->unused_bgs_lock);
> > > >         spin_lock_init(&fs_info->treelog_bg_lock);
> > > >         spin_lock_init(&fs_info->zone_active_bgs_lock);
> > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > index 6cfd286b8bbc..aa451ad52528 100644
> > > > --- a/fs/btrfs/extent_io.c
> > > > +++ b/fs/btrfs/extent_io.c
> > > > @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buffer *eb)
> > > >   * context.
> > > >   */
> > > >  static struct extent_buffer *find_extent_buffer_nolock(
> > > > -               const struct btrfs_fs_info *fs_info, u64 start)
> > > > +               struct btrfs_fs_info *fs_info, u64 start)
> > > >  {
> > > > +       XA_STATE(xas, &fs_info->buffer_tree, start >> fs_info->sectorsize_bits);
> > > >         struct extent_buffer *eb;
> > > >
> > > >         rcu_read_lock();
> > > > -       eb = radix_tree_lookup(&fs_info->buffer_radix,
> > > > -                              start >> fs_info->sectorsize_bits);
> > > > -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> > > > -               rcu_read_unlock();
> > > > -               return eb;
> > > > -       }
> > > > +       do {
> > > > +               eb = xas_load(&xas);
> > > > +       } while (xas_retry(&xas, eb));
> > >
> > > Why not use the simpler xarray API?
> > > This is basically open coding what xa_load() does, so we can get rid
> > > of this loop and no need to define a XA_STATE above.
> >
> > Because we have to do the atomic_inc_not_zero() under the rcu_lock(), so we have
> > have to open code the retry logic.
> 
> Sure, but xa_load() can still be called while we are under the rcu
> read section, can't it?
> 
> >
> > >
> > > > +
> > > > +       if (eb && !atomic_inc_not_zero(&eb->refs))
> > > > +               eb = NULL;
> > > >         rcu_read_unlock();
> > > > -       return NULL;
> > > > +       return eb;
> > > >  }
> > > >
> > > >  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> > > > @@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > > >
> > > >         if (!btrfs_meta_is_subpage(fs_info)) {
> > > >                 /*
> > > > -                * We do this since we'll remove the pages after we've
> > > > -                * removed the eb from the radix tree, so we could race
> > > > -                * and have this page now attached to the new eb.  So
> > > > -                * only clear folio if it's still connected to
> > > > -                * this eb.
> > > > +                * We do this since we'll remove the pages after we've removed
> > > > +                * the eb from the xarray, so we could race and have this page
> > > > +                * now attached to the new eb.  So only clear folio if it's
> > > > +                * still connected to this eb.
> > > >                  */
> > > >                 if (folio_test_private(folio) && folio_get_private(folio) == eb) {
> > > >                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> > > > @@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
> > > >  {
> > > >         int refs;
> > > >         /*
> > > > -        * The TREE_REF bit is first set when the extent_buffer is added
> > > > -        * to the radix tree. It is also reset, if unset, when a new reference
> > > > -        * is created by find_extent_buffer.
> > > > +        * The TREE_REF bit is first set when the extent_buffer is added to the
> > > > +        * xarray. It is also reset, if unset, when a new reference is created
> > > > +        * by find_extent_buffer.
> > > >          *
> > > >          * It is only cleared in two cases: freeing the last non-tree
> > > >          * reference to the extent_buffer when its STALE bit is set or
> > > > @@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
> > > >          * conditions between the calls to check_buffer_tree_ref in those
> > > >          * codepaths and clearing TREE_REF in try_release_extent_buffer.
> > > >          *
> > > > -        * The actual lifetime of the extent_buffer in the radix tree is
> > > > -        * adequately protected by the refcount, but the TREE_REF bit and
> > > > -        * its corresponding reference are not. To protect against this
> > > > -        * class of races, we call check_buffer_tree_ref from the codepaths
> > > > -        * which trigger io. Note that once io is initiated, TREE_REF can no
> > > > -        * longer be cleared, so that is the moment at which any such race is
> > > > -        * best fixed.
> > > > +        * The actual lifetime of the extent_buffer in the xarray is adequately
> > > > +        * protected by the refcount, but the TREE_REF bit and its corresponding
> > > > +        * reference are not. To protect against this class of races, we call
> > > > +        * check_buffer_tree_ref from the codepaths which trigger io. Note that
> > > > +        * once io is initiated, TREE_REF can no longer be cleared, so that is
> > > > +        * the moment at which any such race is best fixed.
> > > >          */
> > > >         refs = atomic_read(&eb->refs);
> > > >         if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> > > > @@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> > > >                 return ERR_PTR(-ENOMEM);
> > > >         eb->fs_info = fs_info;
> > > >  again:
> > > > -       ret = radix_tree_preload(GFP_NOFS);
> > > > -       if (ret) {
> > > > -               exists = ERR_PTR(ret);
> > > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > > +       exists = __xa_cmpxchg(&fs_info->buffer_tree,
> > > > +                             start >> fs_info->sectorsize_bits, NULL, eb,
> > > > +                             GFP_NOFS);
> > > > +       if (xa_is_err(exists)) {
> > > > +               ret = xa_err(exists);
> > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > +               btrfs_release_extent_buffer(eb);
> > > > +               return ERR_PTR(ret);
> > > > +       }
> > > > +       if (exists) {
> > > > +               if (!atomic_inc_not_zero(&exists->refs)) {
> > > > +                       /* The extent buffer is being freed, retry. */
> > > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > > +                       goto again;
> > > > +               }
> > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > >                 goto free_eb;
> > > >         }
> > > > -       spin_lock(&fs_info->buffer_lock);
> > > > -       ret = radix_tree_insert(&fs_info->buffer_radix,
> > > > -                               start >> fs_info->sectorsize_bits, eb);
> > > > -       spin_unlock(&fs_info->buffer_lock);
> > > > -       radix_tree_preload_end();
> > > > -       if (ret == -EEXIST) {
> > > > -               exists = find_extent_buffer(fs_info, start);
> > > > -               if (exists)
> > > > -                       goto free_eb;
> > > > -               else
> > > > -                       goto again;
> > > > -       }
> > > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > > >         check_buffer_tree_ref(eb);
> > > >
> > > >         return eb;
> > > > @@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
> > > >         lockdep_assert_held(&folio->mapping->i_private_lock);
> > > >
> > > >         /*
> > > > -        * For subpage case, we completely rely on radix tree to ensure we
> > > > -        * don't try to insert two ebs for the same bytenr.  So here we always
> > > > -        * return NULL and just continue.
> > > > +        * For subpage case, we completely rely on xarray to ensure we don't try
> > > > +        * to insert two ebs for the same bytenr.  So here we always return NULL
> > > > +        * and just continue.
> > > >          */
> > > >         if (btrfs_meta_is_subpage(fs_info))
> > > >                 return NULL;
> > > > @@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> > > >         /*
> > > >          * To inform we have an extra eb under allocation, so that
> > > >          * detach_extent_buffer_page() won't release the folio private when the
> > > > -        * eb hasn't been inserted into radix tree yet.
> > > > +        * eb hasn't been inserted into the xarray yet.
> > > >          *
> > > >          * The ref will be decreased when the eb releases the page, in
> > > >          * detach_extent_buffer_page().  Thus needs no special handling in the
> > > > @@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > > >
> > > >                 /*
> > > >                  * We can't unlock the pages just yet since the extent buffer
> > > > -                * hasn't been properly inserted in the radix tree, this
> > > > -                * opens a race with btree_release_folio which can free a page
> > > > -                * while we are still filling in all pages for the buffer and
> > > > -                * we could crash.
> > > > +                * hasn't been properly inserted in the xarray, this opens a
> > > > +                * race with btree_release_folio which can free a page while we
> > > > +                * are still filling in all pages for the buffer and we could
> > > > +                * crash.
> > > >                  */
> > > >         }
> > > >         if (uptodate)
> > > > @@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > > >         if (page_contig)
> > > >                 eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
> > > >  again:
> > > > -       ret = radix_tree_preload(GFP_NOFS);
> > > > -       if (ret)
> > > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > > +       existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
> > > > +                                  start >> fs_info->sectorsize_bits, NULL, eb,
> > > > +                                  GFP_NOFS);
> > > > +       if (xa_is_err(existing_eb)) {
> > > > +               ret = xa_err(existing_eb);
> > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > >                 goto out;
> > > > -
> > > > -       spin_lock(&fs_info->buffer_lock);
> > > > -       ret = radix_tree_insert(&fs_info->buffer_radix,
> > > > -                               start >> fs_info->sectorsize_bits, eb);
> > > > -       spin_unlock(&fs_info->buffer_lock);
> > > > -       radix_tree_preload_end();
> > > > -       if (ret == -EEXIST) {
> > > > -               ret = 0;
> > > > -               existing_eb = find_extent_buffer(fs_info, start);
> > > > -               if (existing_eb)
> > > > -                       goto out;
> > > > -               else
> > > > -                       goto again;
> > > >         }
> > > > +       if (existing_eb) {
> > > > +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> > > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > > +                       goto again;
> > > > +               }
> > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > +               goto out;
> > > > +       }
> > > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > > > +
> > > >         /* add one reference for the tree */
> > > >         check_buffer_tree_ref(eb);
> > > >
> > > > @@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct extent_buffer *eb)
> > > >
> > > >                 spin_unlock(&eb->refs_lock);
> > > >
> > > > -               spin_lock(&fs_info->buffer_lock);
> > > > -               radix_tree_delete_item(&fs_info->buffer_radix,
> > > > -                                      eb->start >> fs_info->sectorsize_bits, eb);
> > > > -               spin_unlock(&fs_info->buffer_lock);
> > > > +               /*
> > > > +                * We're erasing, theoretically there will be no allocations, so
> > > > +                * just use GFP_ATOMIC.
> > > > +                */
> > > > +               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > > > +                              eb->start >> fs_info->sectorsize_bits, eb, NULL,
> > > > +                              GFP_ATOMIC);
> > >
> > > This I don't get. Why are we doing a cmp exchange with NULL and not
> > > removing the entry?
> > > Swapping with NULL doesn't release the entry, as xarray permits
> > > storing NULL values. So after a long time releasing extent buffers we
> > > may be holding on to memory unnecessarily.
> > >
> > > Why not use xa_erase()?
> >
> > Because we may be freeing a buffer that we raced with the insert, so we don't
> > want to replace the winner with NULL.
> >
> > Assume that we allocate two buffers for ->start == 0, we insert one buffer into
> > the xarray, and we free the other.  When we're freeing the other we will not
> > delete the xarray entry because it doesn't match the buffer we're removing.
> 
> Sure, I get that part, that we don't want to delete an entry if it
> doesn't match our eb.
> But if it matches, we store a NULL in it, meaning the xarray entry
> will remain and potentially hold unnecessary memory for a long time
> unless that index gets reused soon or there are  other indexes in the
> region.
> 
> That was (and is my) my concern.
> 
> As far as I can see we never do actual index deletions from the
> xarray, just store NULL values, not allowing the xarray to release
> space.

From what I gathered xa_erase() and storing a NULL is the same thing?

From the documentation:

You can then set entries using xa_store() and get entries using
xa_load().  xa_store() will overwrite any entry with the new entry and
return the previous entry stored at that index.  You can unset entries
using xa_erase() or by setting the entry to ``NULL`` using xa_store().
There is no difference between an entry that has never been stored to
and one that has been erased with xa_erase(); an entry that has most
recently had ``NULL`` stored to it is also equivalent except if the
XArray was initialized with ``XA_FLAGS_ALLOC``.

So this seems to say that if we store a ``NULL`` value it's the same as deleting
it, so we should be fine with this pattern?

Willy am I doing this wrong?  What should I do instead if this is indeed
incorrect?  Do an xa_load(), check the value, then xa_erase() if it matches, all
under the lock?  Thanks,

Josef

