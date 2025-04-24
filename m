Return-Path: <linux-btrfs+bounces-13391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD9A9B2D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4003A16F329
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1771805B;
	Thu, 24 Apr 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yJLx+2Kf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510434C7C
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509645; cv=none; b=Sl2YQFpcpPJzM8gjNf7acX4Gp0OZhjzrrE/MgX6ukhKQqmYSg2uRn9OTF26SaldslnqVCu18ZcnPjfEywz9AnQlwDiodQ6e2bMNcxn7gebHXzebW1vzGm/jnaP0qaGCOEZKtidtOU6iiJISYqNV8C0Zq6EhWEGYZ7L+noob6teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509645; c=relaxed/simple;
	bh=qQ2PMqpSY0AZvlS79C78NPWpoxb7Iq7rjlNfd6zbq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzIiqqiTZX03BhwtD6qMq7+EUhdJNT6R/+bG4FBXhlWGqXbXyeQ6N2rnbEhYwqMV5mVUW6DOFGYmMee0t9CAQN9NVc0hYLC2Mx425lm6rZNLKqlW4oM9+2N8pi1NcaV7nh/ShEuIT7BkIpgLHcBU7O3yyWPT/FXNwkB/jUu5ay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yJLx+2Kf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ed16ce246bso6460506d6.3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745509642; x=1746114442; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VnYNh14IUmy7oWkElQ1RBcCIvP7maQymq0t6AmG1VwU=;
        b=yJLx+2KffYjFNXpUQ2NBM05JpfiIplmfa0MZ1jg51KgEDznrMOZMxXpJavnHsAQTDV
         UeqyP9cnQtbdecQeko9il9mGT4UIKaN6j3hRcRVVDJB0Yyo6g2oPCEZ17Itpq4caE1fG
         LcQXX5f/MGdjdscS6MczilzHP662JGE5fA8OTMzHS1080+tBYCf9FL6v25qanAdNMCD7
         5E1+cHQ4Y5XdDHaENMjcd8utwLLL1ZFvAGzz5VMXm5HOTvft6enOy0omkVUKDwO0M8Ox
         djC6hNJmfHb/B6IUtpxnl9zHkVeQGE6yQmHpJH6kPl1J2zBDLV54svWdwX+8QlOzTdPS
         8ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509642; x=1746114442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYNh14IUmy7oWkElQ1RBcCIvP7maQymq0t6AmG1VwU=;
        b=p0NY+W2nahnMr6Cp+Hh/LdSPN+xQ0qvWZNOAA4bm+Zwwk9/P+xb6YZ6+dbQxBaGZTR
         kDm7LFXfXh0IAlE5uMsgSR7MSYe4JVB+vu47f394KADTVT+3BZL6cjvHdNcufRKodQuT
         xEmkb3MZuN2NwGEpsj+qWhZC8NKVKIAgL6XhH5drrq+iKeT4AFZ0I33dp0+b+1KTX0xx
         DRHec98Ojh0VV5PZG9DIFfUdS2cOinnz77BNaWy7CLTu/ndEATmNP4HsZ12fzJuwnaf6
         13YA45NGWst8jJ7jajBPOWVl9auNY2CHNYzHhl7dSni0sTGd/0E/WPOV2vfYYIM7rvOA
         +nOQ==
X-Gm-Message-State: AOJu0Yx3BMj3LSGiQkDezWpqbzTdfY4ClPwksDtS63djhFkuo12pDbjg
	HIXVmu8BBE8Lxao7f2Wt/h23TYgux1jlQNITPwdFCSog+Sl9C/eySZglvu1aAii4O7VGmjmLgRO
	aXQNW2w==
X-Gm-Gg: ASbGncsVik5+Kn9fZbtimne7lV11NjtIPz+P4udyuYK6ln5gP+0jeI7AFzJNKPu4EDa
	CcN3ORg6EC/khL2pnOYsQaeI1PbfFESBekvoZ9JCDWBpmJBK90iGlBKHj0Z/msVwhqtA/vy6uUV
	+kZOS3OzBm8LYQeUX5WiKoglwKQ6JzluZSuf8USpDd8vTNSHb4KdZn7AhtYAlfmXF6fkvJWl5JE
	w5RrwZpESTvoCxJko5YoKmbnRU8eC36xcN5xXVR0VgVk+dXWTiwSA7ymdM14aJ8uwqT9cPbHqKz
	tAm8JSPhemol8+13W7SktzLvxb2xvtvrfd8eJC+TAI4GQp77nRN7NUM6Bg7Jr/Zr2AknO8HpQYc
	vVg==
X-Google-Smtp-Source: AGHT+IHIaXr5YLQrjdcaLd1aotw/kK1JlH+f2FE17XvJcL4Movyh04ewAA/iZl84JvzYK8KYETOAmw==
X-Received: by 2002:a05:6214:21ad:b0:6f2:b551:a65 with SMTP id 6a1803df08f44-6f4c95e3141mr904046d6.38.1745509641800;
        Thu, 24 Apr 2025 08:47:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c08ef2c6sm10724966d6.2.2025.04.24.08.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:47:20 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:47:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
Message-ID: <20250424154719.GA311510@perftesting>
References: <cover.1744984487.git.josef@toxicpanda.com>
 <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>

On Wed, Apr 23, 2025 at 04:08:56PM +0100, Filipe Manana wrote:
> On Fri, Apr 18, 2025 at 2:58 PM Josef Bacik <josef@toxicpanda.com> wrote:
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
> > index 59da809b7d57..24c08eb86b7b 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
> >         return ret;
> >  }
> >
> > +/*
> > + * lockdep gets confused between our buffer_tree which requires IRQ locking
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
> > +       xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> > +       lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_class);
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
> > index 6cfd286b8bbc..aa451ad52528 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buffer *eb)
> >   * context.
> >   */
> >  static struct extent_buffer *find_extent_buffer_nolock(
> > -               const struct btrfs_fs_info *fs_info, u64 start)
> > +               struct btrfs_fs_info *fs_info, u64 start)
> >  {
> > +       XA_STATE(xas, &fs_info->buffer_tree, start >> fs_info->sectorsize_bits);
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
> 
> Why not use the simpler xarray API?
> This is basically open coding what xa_load() does, so we can get rid
> of this loop and no need to define a XA_STATE above.

Because we have to do the atomic_inc_not_zero() under the rcu_lock(), so we have
have to open code the retry logic.

> 
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
> > +       xa_lock_irq(&fs_info->buffer_tree);
> > +       exists = __xa_cmpxchg(&fs_info->buffer_tree,
> > +                             start >> fs_info->sectorsize_bits, NULL, eb,
> > +                             GFP_NOFS);
> > +       if (xa_is_err(exists)) {
> > +               ret = xa_err(exists);
> > +               xa_unlock_irq(&fs_info->buffer_tree);
> > +               btrfs_release_extent_buffer(eb);
> > +               return ERR_PTR(ret);
> > +       }
> > +       if (exists) {
> > +               if (!atomic_inc_not_zero(&exists->refs)) {
> > +                       /* The extent buffer is being freed, retry. */
> > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > +                       goto again;
> > +               }
> > +               xa_unlock_irq(&fs_info->buffer_tree);
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
> > +       xa_unlock_irq(&fs_info->buffer_tree);
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
> > +       xa_lock_irq(&fs_info->buffer_tree);
> > +       existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
> > +                                  start >> fs_info->sectorsize_bits, NULL, eb,
> > +                                  GFP_NOFS);
> > +       if (xa_is_err(existing_eb)) {
> > +               ret = xa_err(existing_eb);
> > +               xa_unlock_irq(&fs_info->buffer_tree);
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
> > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > +                       goto again;
> > +               }
> > +               xa_unlock_irq(&fs_info->buffer_tree);
> > +               goto out;
> > +       }
> > +       xa_unlock_irq(&fs_info->buffer_tree);
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
> > +               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > +                              eb->start >> fs_info->sectorsize_bits, eb, NULL,
> > +                              GFP_ATOMIC);
> 
> This I don't get. Why are we doing a cmp exchange with NULL and not
> removing the entry?
> Swapping with NULL doesn't release the entry, as xarray permits
> storing NULL values. So after a long time releasing extent buffers we
> may be holding on to memory unnecessarily.
> 
> Why not use xa_erase()?

Because we may be freeing a buffer that we raced with the insert, so we don't
want to replace the winner with NULL.

Assume that we allocate two buffers for ->start == 0, we insert one buffer into
the xarray, and we free the other.  When we're freeing the other we will not
delete the xarray entry because it doesn't match the buffer we're removing.

> 
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
> > +               XA_STATE(xas, &fs_info->buffer_tree,
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
> > +               xa_lock_irq(&fs_info->buffer_tree);
> > +               do {
> > +                       eb = xas_find(&xas, end >> fs_info->sectorsize_bits);
> > +               } while (xas_retry(&xas, eb));
> 
> Same here as before, why not use xa_load()?
> It would avoid  the need to define a XA_STATE and having the loop
> doing the tretry.

Because we need to be holding the lock while we're messing with the extent
buffer.  We could probably still use xa_load() here while holding the lock since
xa_load() just does rcu_read_lock(), but this is more explicit in what we're
doing.

> 
> > +
> >                 if (!eb) {
> >                         /* No more eb in the page range after or at cur */
> > -                       spin_unlock(&fs_info->buffer_lock);
> > +                       xa_unlock_irq(&fs_info->buffer_tree);
> >                         break;
> >                 }
> >                 cur = eb->start + eb->len;
> > @@ -4332,10 +4306,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >                 spin_lock(&eb->refs_lock);
> >                 if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> >                         spin_unlock(&eb->refs_lock);
> > -                       spin_unlock(&fs_info->buffer_lock);
> > +                       xa_unlock_irq(&fs_info->buffer_tree);
> >                         break;
> >                 }
> > -               spin_unlock(&fs_info->buffer_lock);
> > +               xa_unlock_irq(&fs_info->buffer_tree);
> >
> >                 /*
> >                  * If tree ref isn't set then we know the ref on this eb is a
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index bcca43046064..ed02d276d908 100644
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
> > +       struct xarray buffer_tree;
> >
> >         /* Next backup root to be overwritten */
> >         int backup_root_index;
> > diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> > index 02a915eb51fb..27fd05308a96 100644
> > --- a/fs/btrfs/tests/btrfs-tests.c
> > +++ b/fs/btrfs/tests/btrfs-tests.c
> > @@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
> >
> >  void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
> >  {
> > -       struct radix_tree_iter iter;
> > -       void **slot;
> > +       XA_STATE(xas, &fs_info->buffer_tree, 0);
> >         struct btrfs_device *dev, *tmp;
> > +       struct extent_buffer *eb;
> >
> >         if (!fs_info)
> >                 return;
> > @@ -169,25 +169,16 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
> >
> >         test_mnt->mnt_sb->s_fs_info = NULL;
> >
> > -       spin_lock(&fs_info->buffer_lock);
> > -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
> > -               struct extent_buffer *eb;
> > -
> > -               eb = radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
> > -               if (!eb)
> > +       xa_lock_irq(&fs_info->buffer_tree);
> > +       xas_for_each(&xas, eb, ULONG_MAX) {
> > +               if (xas_retry(&xas, eb))
> 
> Can't we use a xa_for_each() variant here?
> It would avoid the need to define a XA_STATE and to deal with these
> retries and the pausing below.

Agreed, I'll fix this up.

> 
> >                         continue;
> > -               /* Shouldn't happen but that kind of thinking creates CVE's */
> > -               if (radix_tree_exception(eb)) {
> > -                       if (radix_tree_deref_retry(eb))
> > -                               slot = radix_tree_iter_retry(&iter);
> > -                       continue;
> > -               }
> > -               slot = radix_tree_iter_resume(slot, &iter);
> > -               spin_unlock(&fs_info->buffer_lock);
> > +               xas_pause(&xas);
> > +               xa_unlock_irq(&fs_info->buffer_tree);
> >                 free_extent_buffer_stale(eb);
> > -               spin_lock(&fs_info->buffer_lock);
> > +               xa_lock_irq(&fs_info->buffer_tree);
> >         }
> > -       spin_unlock(&fs_info->buffer_lock);
> > +       xa_unlock_irq(&fs_info->buffer_tree);
> >
> >         btrfs_mapping_tree_free(fs_info);
> >         list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 7b30700ec930..82fb08790b64 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -2170,28 +2170,22 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
> >  static void wait_eb_writebacks(struct btrfs_block_group *block_group)
> >  {
> >         struct btrfs_fs_info *fs_info = block_group->fs_info;
> > +       XA_STATE(xas, &fs_info->buffer_tree,
> > +                block_group->start >> fs_info->sectorsize_bits);
> >         const u64 end = block_group->start + block_group->length;
> > -       struct radix_tree_iter iter;
> >         struct extent_buffer *eb;
> > -       void __rcu **slot;
> >
> >         rcu_read_lock();
> > -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
> > -                                block_group->start >> fs_info->sectorsize_bits) {
> > -               eb = radix_tree_deref_slot(slot);
> > -               if (!eb)
> > +       xas_for_each(&xas, eb, end >> fs_info->sectorsize_bits) {
> > +               if (xas_retry(&xas, eb))
> 
> Same here, using the simpler API, one of the xa_for_each_range()
> variants to avoid dealing with retry entries, defining a XA_STATE and
> the pausing below.

Agreed, thanks,

Josef

