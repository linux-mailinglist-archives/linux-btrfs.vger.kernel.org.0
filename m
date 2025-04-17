Return-Path: <linux-btrfs+bounces-13148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0AA92C8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 23:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131593BDCF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F320A5F5;
	Thu, 17 Apr 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bQsrV5K1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434141D6AA
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924380; cv=none; b=iDjOmYmtKAppAub6ylVVNrbXWwEiJkwGQiSfelOzMIaaUbSTOpouVJrSir8nvB7Ik0rgaToQxquytqI6B2NfmzgLTQ/yutP1YXMiDPK4/Ffdxtx5e6FtqL7923p7OrDugkB3+tmpSSE58YvdALPoYqtcb3aFZkFu0uJPfZQgFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924380; c=relaxed/simple;
	bh=Wo5M39fOerS07S+QIC4pDo1OAo8cc9MRKR//xts13eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zce4M5rPoQyvPZ/EGumuKBVZmreHn+f+V2zBQKZ1uuaqUI6azeteR1noWRefpT3k6JMxx73ebfzEWc4gWcilgrE/hcHiXCfi1Jxh+Hq3XHW6jK1RMFdurfB8EGh1ZigKdQwRY5DfguG/Twdes3cjFzixnlfuaAco8cRdCUpT/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bQsrV5K1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-477282401b3so13041791cf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744924376; x=1745529176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9s2vXy45iFZxmnNlDTY0p4M7GjeaXC3uf77oeFlFds=;
        b=bQsrV5K1f3MwAT231fsa2oEDSUWpM7Fd9Om9pM8aX0nTCeNrhPhQEBFoLJmbGP9yFv
         x1ne7xqUtzxq9XU7RBK6QH1knNy38Ulpg5UtHKH33bvjKE9RMfbw6c1PqEVqnWPAWBv2
         p7Eq61PycVJJcjehvNvOGtw89nakXYbnNjyqDQsI5L9+El6im9hOc6ncULRZOOUvuUhF
         lkzgb0fhSl8S28eViscfu7HAmDelS8p2mgXzJnBtM78/OOWSkBhMvN2ruoIHSDHzojI9
         34p6i7NcvPJSeKyzzcnhFNbpA0Uo1pO0VY/6jS7LaMTHd5iLwgnvQlk4Rsj+QffvAaJj
         NOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924376; x=1745529176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9s2vXy45iFZxmnNlDTY0p4M7GjeaXC3uf77oeFlFds=;
        b=GSiD39aPlNRPPYbY4z2Zwk12bpFPlkFtitRvUTIVJRay9/I6zYnG1LjOxFxfS9uNej
         ofTuOXaV6TXdTHAsmCYj60xNiRlBVQhAxKVzqiEQ1J6U2gWzPJciVK2kAsmFuxqvWwQ5
         4GPm6sPztZzJYUtyyNoon2ffjx3J14JdiollW7i0fZzjMRSNUA0esLGGVH+mVLaAyP/G
         G0iYWzGBPp6Hph1Yzmp9hD85mXVt4lr6/WS3D9a+G02lhgEN9u2jOAiFeZQK9ZGJxnrk
         x95fMVsgx27USPt9cssiK610J01w7VRs/tD/rF1b3xjr5Hhzj0q/B4yHalUfPdiyr1Zf
         izCQ==
X-Gm-Message-State: AOJu0Yw6WIkqDjqyRB7tmYkNsAWyGnRRqkAy0GbnRoNdxnXcwKwin5b2
	SLtMJCNrvcS4i7Uxy6KpEuXMVsoAPXWQRh/wsihbx1s8KG6C5KFkGdMpNloIAv/yNaTDg3X+qkc
	2
X-Gm-Gg: ASbGncvIh3lp6J4ST0286ztGRtfB9NBNLwXuV0RRswFT2XNTrFaH7fjCsWYOnVcP/yJ
	/UF26WLof/sOW6QfnaU3IveWQk5wRQiti/FVmamAYUnanurZh6ZUG6BLoiH8Q0T/jXq4+dL+9ML
	2J2Oaxe/wDTkFC7GmZMZ/t7Y6ZVdcp9le0uashS0NAJVJ9Sv9n1Y4HFEuFnzFcq+pNWpnaZ4qi+
	592G56U53+UOxHI3MhSNlmK1LT9SHOQSAHaHQyz4O/A4WKYC+ml8AWHjLPbGusTWwVRz4zr7ULt
	lX2k3VeG0CD+IiX5+FzexsE7VN5xdh2NHLyroA==
X-Google-Smtp-Source: AGHT+IFUVATp8u1iZwhjErb5jXrcCTRAzMqpQ+KNMJRTFj7LtGyp4Vf0xHW9tfLs8VJ2xK34wEH2qQ==
X-Received: by 2002:a05:622a:c8:b0:47a:d51b:c7f2 with SMTP id d75a77b69052e-47aec3cfa64mr6183191cf.28.1744924375870;
        Thu, 17 Apr 2025 14:12:55 -0700 (PDT)
Received: from localhost ([67.209.234.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3aed1sm3276831cf.19.2025.04.17.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:55 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] btrfs: convert the buffer_radix to an xarray
Message-ID: <20250417211253.GA34694@fedora>
References: <cover.1744840038.git.josef@toxicpanda.com>
 <1f3982ec56c49f642ef35698c39e16f56f4bc4f5.1744840038.git.josef@toxicpanda.com>
 <CAPjX3FdNYekOPOg+8MB9HeJ5AWsd+TUbOX2vpCqdJGr4+tD3bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdNYekOPOg+8MB9HeJ5AWsd+TUbOX2vpCqdJGr4+tD3bA@mail.gmail.com>

On Thu, Apr 17, 2025 at 09:32:28PM +0200, Daniel Vacek wrote:
> On Wed, 16 Apr 2025 at 23:50, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > In order to fully utilize xarray tagging to improve writeback we need to
> > convert the buffer_radix to a proper xarray.  This conversion is
> > relatively straightforward as the radix code uses the xarray underneath.
> > Using xarray directly allows for quite a lot less code.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/disk-io.c           |  15 ++-
> >  fs/btrfs/extent_io.c         | 196 +++++++++++++++--------------------
> >  fs/btrfs/fs.h                |   4 +-
> >  fs/btrfs/tests/btrfs-tests.c |  27 ++---
> >  fs/btrfs/zoned.c             |  16 +--
> >  5 files changed, 113 insertions(+), 145 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 59da809b7d57..5593873f5c0f 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
> >         return ret;
> >  }
> >
> > +/*
> > + * lockdep gets confused between our buffer_xarray which requires IRQ locking
> > + * because we modify marks in the IRQ context, and our delayed inode xarray
> > + * which doesn't have these requirements. Use a class key so lockdep doesn't get
> > + * them mixed up.
> > + */
> > +static struct lock_class_key buffer_xa_class;
> > +
> >  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> >  {
> >         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> > -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> > +
> > +       /* Use the same flags as mapping->i_pages. */
> > +       xa_init_flags(&fs_info->buffer_xarray, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> > +       lockdep_set_class(&fs_info->buffer_xarray.xa_lock, &buffer_xa_class);
> > +
> >         INIT_LIST_HEAD(&fs_info->trans_list);
> >         INIT_LIST_HEAD(&fs_info->dead_roots);
> >         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> > @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> >         spin_lock_init(&fs_info->delayed_iput_lock);
> >         spin_lock_init(&fs_info->defrag_inodes_lock);
> >         spin_lock_init(&fs_info->super_lock);
> > -       spin_lock_init(&fs_info->buffer_lock);
> >         spin_lock_init(&fs_info->unused_bgs_lock);
> >         spin_lock_init(&fs_info->treelog_bg_lock);
> >         spin_lock_init(&fs_info->zone_active_bgs_lock);
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6cfd286b8bbc..309c86d1a696 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buffer *eb)
> >   * context.
> >   */
> >  static struct extent_buffer *find_extent_buffer_nolock(
> > -               const struct btrfs_fs_info *fs_info, u64 start)
> > +               struct btrfs_fs_info *fs_info, u64 start)
> >  {
> > +       XA_STATE(xas, &fs_info->buffer_xarray, start >> fs_info->sectorsize_bits);
> >         struct extent_buffer *eb;
> >
> >         rcu_read_lock();
> > -       eb = radix_tree_lookup(&fs_info->buffer_radix,
> > -                              start >> fs_info->sectorsize_bits);
> > -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> > -               rcu_read_unlock();
> > -               return eb;
> > -       }
> > +       do {
> > +               eb = xas_load(&xas);
> > +       } while (xas_retry(&xas, eb));
> > +
> > +       if (eb && !atomic_inc_not_zero(&eb->refs))
> > +               eb = NULL;
> >         rcu_read_unlock();
> > -       return NULL;
> > +       return eb;
> >  }
> >
> >  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> > @@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> >
> >         if (!btrfs_meta_is_subpage(fs_info)) {
> >                 /*
> > -                * We do this since we'll remove the pages after we've
> > -                * removed the eb from the radix tree, so we could race
> > -                * and have this page now attached to the new eb.  So
> > -                * only clear folio if it's still connected to
> > -                * this eb.
> > +                * We do this since we'll remove the pages after we've removed
> > +                * the eb from the xarray, so we could race and have this page
> > +                * now attached to the new eb.  So only clear folio if it's
> > +                * still connected to this eb.
> >                  */
> >                 if (folio_test_private(folio) && folio_get_private(folio) == eb) {
> >                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> > @@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
> >  {
> >         int refs;
> >         /*
> > -        * The TREE_REF bit is first set when the extent_buffer is added
> > -        * to the radix tree. It is also reset, if unset, when a new reference
> > -        * is created by find_extent_buffer.
> > +        * The TREE_REF bit is first set when the extent_buffer is added to the
> > +        * xarray. It is also reset, if unset, when a new reference is created
> > +        * by find_extent_buffer.
> >          *
> >          * It is only cleared in two cases: freeing the last non-tree
> >          * reference to the extent_buffer when its STALE bit is set or
> > @@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
> >          * conditions between the calls to check_buffer_tree_ref in those
> >          * codepaths and clearing TREE_REF in try_release_extent_buffer.
> >          *
> > -        * The actual lifetime of the extent_buffer in the radix tree is
> > -        * adequately protected by the refcount, but the TREE_REF bit and
> > -        * its corresponding reference are not. To protect against this
> > -        * class of races, we call check_buffer_tree_ref from the codepaths
> > -        * which trigger io. Note that once io is initiated, TREE_REF can no
> > -        * longer be cleared, so that is the moment at which any such race is
> > -        * best fixed.
> > +        * The actual lifetime of the extent_buffer in the xarray is adequately
> > +        * protected by the refcount, but the TREE_REF bit and its corresponding
> > +        * reference are not. To protect against this class of races, we call
> > +        * check_buffer_tree_ref from the codepaths which trigger io. Note that
> > +        * once io is initiated, TREE_REF can no longer be cleared, so that is
> > +        * the moment at which any such race is best fixed.
> >          */
> >         refs = atomic_read(&eb->refs);
> >         if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> > @@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
> >                 return ERR_PTR(-ENOMEM);
> >         eb->fs_info = fs_info;
> >  again:
> > -       ret = radix_tree_preload(GFP_NOFS);
> > -       if (ret) {
> > -               exists = ERR_PTR(ret);
> > +       xa_lock_irq(&fs_info->buffer_xarray);
> > +       exists = __xa_cmpxchg(&fs_info->buffer_xarray,
> > +                             start >> fs_info->sectorsize_bits, NULL, eb,
> > +                             GFP_NOFS);
> 
> I think the xa_unlock_irq() can go straight here. Or rather you could
> use xa_cmpxchg_irq() instead?
> Or do you protect exists->refs with it as well? It seems so, IIUC. Not
> sure it is strictly needed, though.
> 

We can't trust the value of exists after we've unlocked the xarray.

> > +       if (xa_is_err(exists)) {
> > +               ret = xa_err(exists);
> > +               xa_unlock_irq(&fs_info->buffer_xarray);
> > +               btrfs_release_extent_buffer(eb);
> > +               return ERR_PTR(ret);
> > +       }
> > +       if (exists) {
> > +               if (!atomic_inc_not_zero(&exists->refs)) {
> > +                       /* The extent buffer is being freed, retry. */
> > +                       xa_unlock_irq(&fs_info->buffer_xarray);
> > +                       goto again;
> > +               }
> > +               xa_unlock_irq(&fs_info->buffer_xarray);
> >                 goto free_eb;
> >         }
> > -       spin_lock(&fs_info->buffer_lock);
> > -       ret = radix_tree_insert(&fs_info->buffer_radix,
> > -                               start >> fs_info->sectorsize_bits, eb);
> > -       spin_unlock(&fs_info->buffer_lock);
> > -       radix_tree_preload_end();
> > -       if (ret == -EEXIST) {
> > -               exists = find_extent_buffer(fs_info, start);
> > -               if (exists)
> > -                       goto free_eb;
> > -               else
> > -                       goto again;
> > -       }
> > +       xa_unlock_irq(&fs_info->buffer_xarray);
> >         check_buffer_tree_ref(eb);
> >
> >         return eb;
> > @@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
> >         lockdep_assert_held(&folio->mapping->i_private_lock);
> >
> >         /*
> > -        * For subpage case, we completely rely on radix tree to ensure we
> > -        * don't try to insert two ebs for the same bytenr.  So here we always
> > -        * return NULL and just continue.
> > +        * For subpage case, we completely rely on xarray to ensure we don't try
> > +        * to insert two ebs for the same bytenr.  So here we always return NULL
> > +        * and just continue.
> >          */
> >         if (btrfs_meta_is_subpage(fs_info))
> >                 return NULL;
> > @@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> >         /*
> >          * To inform we have an extra eb under allocation, so that
> >          * detach_extent_buffer_page() won't release the folio private when the
> > -        * eb hasn't been inserted into radix tree yet.
> > +        * eb hasn't been inserted into the xarray yet.
> >          *
> >          * The ref will be decreased when the eb releases the page, in
> >          * detach_extent_buffer_page().  Thus needs no special handling in the
> > @@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >
> >                 /*
> >                  * We can't unlock the pages just yet since the extent buffer
> > -                * hasn't been properly inserted in the radix tree, this
> > -                * opens a race with btree_release_folio which can free a page
> > -                * while we are still filling in all pages for the buffer and
> > -                * we could crash.
> > +                * hasn't been properly inserted in the xarray, this opens a
> > +                * race with btree_release_folio which can free a page while we
> > +                * are still filling in all pages for the buffer and we could
> > +                * crash.
> >                  */
> >         }
> >         if (uptodate)
> > @@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >         if (page_contig)
> >                 eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
> >  again:
> > -       ret = radix_tree_preload(GFP_NOFS);
> > -       if (ret)
> > +       xa_lock_irq(&fs_info->buffer_xarray);
> > +       existing_eb = __xa_cmpxchg(&fs_info->buffer_xarray,
> > +                                  start >> fs_info->sectorsize_bits, NULL, eb,
> > +                                  GFP_NOFS);
> 
> Ditto.

Same comment as above.

> 
> > +       if (xa_is_err(existing_eb)) {
> > +               ret = xa_err(existing_eb);
> > +               xa_unlock_irq(&fs_info->buffer_xarray);
> >                 goto out;
> > -
> > -       spin_lock(&fs_info->buffer_lock);
> > -       ret = radix_tree_insert(&fs_info->buffer_radix,
> > -                               start >> fs_info->sectorsize_bits, eb);
> > -       spin_unlock(&fs_info->buffer_lock);
> > -       radix_tree_preload_end();
> > -       if (ret == -EEXIST) {
> > -               ret = 0;
> > -               existing_eb = find_extent_buffer(fs_info, start);
> > -               if (existing_eb)
> > -                       goto out;
> > -               else
> > -                       goto again;
> >         }
> > +       if (existing_eb) {
> > +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> > +                       xa_unlock_irq(&fs_info->buffer_xarray);
> > +                       goto again;
> > +               }
> > +               xa_unlock_irq(&fs_info->buffer_xarray);
> > +               goto out;
> > +       }
> > +       xa_unlock_irq(&fs_info->buffer_xarray);
> > +
> >         /* add one reference for the tree */
> >         check_buffer_tree_ref(eb);
> >
> > @@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct extent_buffer *eb)
> >
> >                 spin_unlock(&eb->refs_lock);
> >
> > -               spin_lock(&fs_info->buffer_lock);
> > -               radix_tree_delete_item(&fs_info->buffer_radix,
> > -                                      eb->start >> fs_info->sectorsize_bits, eb);
> > -               spin_unlock(&fs_info->buffer_lock);
> > +               /*
> > +                * We're erasing, theoretically there will be no allocations, so
> > +                * just use GFP_ATOMIC.
> > +                */
> > +               xa_cmpxchg_irq(&fs_info->buffer_xarray,
> > +                              eb->start >> fs_info->sectorsize_bits, eb, NULL,
> > +                              GFP_ATOMIC);
> >
> >                 btrfs_leak_debug_del_eb(eb);
> >                 /* Should be safe to release folios at this point. */
> > @@ -4260,44 +4267,6 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
> >         }
> >  }
> >
> > -#define GANG_LOOKUP_SIZE       16
> > -static struct extent_buffer *get_next_extent_buffer(
> > -               const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
> > -{
> > -       struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> > -       struct extent_buffer *found = NULL;
> > -       u64 folio_start = folio_pos(folio);
> > -       u64 cur = folio_start;
> > -
> > -       ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
> > -       lockdep_assert_held(&fs_info->buffer_lock);
> > -
> > -       while (cur < folio_start + PAGE_SIZE) {
> > -               int ret;
> > -               int i;
> > -
> > -               ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> > -                               (void **)gang, cur >> fs_info->sectorsize_bits,
> > -                               min_t(unsigned int, GANG_LOOKUP_SIZE,
> > -                                     PAGE_SIZE / fs_info->nodesize));
> > -               if (ret == 0)
> > -                       goto out;
> > -               for (i = 0; i < ret; i++) {
> > -                       /* Already beyond page end */
> > -                       if (gang[i]->start >= folio_start + PAGE_SIZE)
> > -                               goto out;
> > -                       /* Found one */
> > -                       if (gang[i]->start >= bytenr) {
> > -                               found = gang[i];
> > -                               goto out;
> > -                       }
> > -               }
> > -               cur = gang[ret - 1]->start + gang[ret - 1]->len;
> > -       }
> > -out:
> > -       return found;
> > -}
> > -
> >  static int try_release_subpage_extent_buffer(struct folio *folio)
> >  {
> >         struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
> > @@ -4306,21 +4275,26 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >         int ret;
> >
> >         while (cur < end) {
> > +               XA_STATE(xas, &fs_info->buffer_xarray,
> > +                        cur >> fs_info->sectorsize_bits);
> >                 struct extent_buffer *eb = NULL;
> >
> >                 /*
> >                  * Unlike try_release_extent_buffer() which uses folio private
> > -                * to grab buffer, for subpage case we rely on radix tree, thus
> > -                * we need to ensure radix tree consistency.
> > +                * to grab buffer, for subpage case we rely on xarray, thus we
> > +                * need to ensure xarray tree consistency.
> >                  *
> > -                * We also want an atomic snapshot of the radix tree, thus go
> > +                * We also want an atomic snapshot of the xarray tree, thus go
> >                  * with spinlock rather than RCU.
> >                  */
> > -               spin_lock(&fs_info->buffer_lock);
> > -               eb = get_next_extent_buffer(fs_info, folio, cur);
> > +               xa_lock_irq(&fs_info->buffer_xarray);
> > +               do {
> > +                       eb = xas_find(&xas, end >> fs_info->sectorsize_bits);
> > +               } while (xas_retry(&xas, eb));
> > +
> >                 if (!eb) {
> >                         /* No more eb in the page range after or at cur */
> > -                       spin_unlock(&fs_info->buffer_lock);
> > +                       xa_unlock(&fs_info->buffer_xarray);
> 
> I may be missing something but is this a typo? Should this be xa_unlock_irq()?
> 
> >                         break;
> >                 }
> >                 cur = eb->start + eb->len;
> > @@ -4332,10 +4306,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >                 spin_lock(&eb->refs_lock);
> >                 if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> >                         spin_unlock(&eb->refs_lock);
> > -                       spin_unlock(&fs_info->buffer_lock);
> > +                       xa_unlock(&fs_info->buffer_xarray);
> 
> xa_unlock_irq() again?
> 

Ah yeah, I'll fix this, I must not have hit reclaim while running fstests
otherwise lockdep would have complained about this.

> I don't even see any reason for XA_FLAGS_LOCK_IRQ in the first place
> to be honest.
> (Ah, OK. It's because of clearing the writeback tag in the
> end_bbio_meta_write() in the second patch. On my machine it runs from
> a threaded interrupt but that's not universal I guess.)
> 
> >                         break;
> >                 }
> > -               spin_unlock(&fs_info->buffer_lock);
> > +               xa_unlock_irq(&fs_info->buffer_xarray);
> >
> >                 /*
> >                  * If tree ref isn't set then we know the ref on this eb is a
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index bcca43046064..d5d94977860c 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -776,10 +776,8 @@ struct btrfs_fs_info {
> >
> >         struct btrfs_delayed_root *delayed_root;
> >
> > -       /* Extent buffer radix tree */
> > -       spinlock_t buffer_lock;
> >         /* Entries are eb->start / sectorsize */
> > -       struct radix_tree_root buffer_radix;
> > +       struct xarray buffer_xarray;
> 
> I'm not exactly a fan of encoding the type in the name. I'd simply
> call this 'buffers' or 'extent_buffers'.

Those are too generic, I prefer the more specific name.  Multiple times
throughout this project I did `git grep buffer_radix` or `git grep buffer_xarra`
to check stuff, a more generic name would make it harder to spot the relevant
thing I care about.  Thanks,

Josef

