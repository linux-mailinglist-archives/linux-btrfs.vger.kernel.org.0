Return-Path: <linux-btrfs+bounces-13392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5BCA9B378
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BC9A418E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660227FD6B;
	Thu, 24 Apr 2025 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW54RH5q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28222127E
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510887; cv=none; b=eSPQqY76FNGGba1bGRqwvAqBjbUexv12DPiaidj3DKF7Cxv5KuK0ujNUjEwDWhgCNPADkQ7q58LxQiv3ngD4FPIUN38J1btLZjcoGmytMfOPjNYKCEYhF8uMiOPa0mRXZidlG+d4KUhbFtq1wWqFz4hrQrm++KqdmuIoWog/IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510887; c=relaxed/simple;
	bh=KMgUBW0yavhTSMjDNJMT22HsmxvuIZ4ZlmhRR1hGdCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I26y3msRN3bYleWTeUTBi5PDM7jDeSLuBsbCqfY0KBXequGMBnHhnndR1AhCozbqnChL3RO5A3+f3Vl3mnNCaWvTnOSnnlIoqtVX9S//UwkT554g2D56FTPlL/4NAWTLjTooNHrG51i37BlknCAMKClM8TeVZDpF96OIuDniI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW54RH5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D33EC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510887;
	bh=KMgUBW0yavhTSMjDNJMT22HsmxvuIZ4ZlmhRR1hGdCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GW54RH5qU1sc+0ilYLZ0nPRrPnNbLsn35ksLD7Xa4wj0f5a8FtZ/e4ypgF28ooiey
	 bjL8DOPAP3DhaO83RPqguFd7YA8MFKoKSAaUpiTjoR6GeMmwYpt4enSD/wJHgs6jAv
	 tab1pCVybxclakaWlmMIyDNQGQ+bbyQDjMIV2i92FmH6RZIVWaoYATnZYEmqyqF7qs
	 41VuG69NSDMLFn3JoCmrkmrhCmjr7rYhIK4vZenB/wUyga70b3Ij59YXEsfv31CHjr
	 9PP8IDe6GXlC2l2AgFQO0kIYefPkhXhRdoTpz+1YF+l0i445EyNafDsXVRLkNqotVH
	 0RAPY6EC4Dz1A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so1587972a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 09:08:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyU+HYPfpsVPKKZ0REmP6uPaBKy+VyhA7zkh3rt+CunfZnXgpjS
	7Yz+PU3L2tYA7BuMPkMiwPw6xyLN5VXXRlDbQKDZitskV/EwkwkZ74rhYFQZKJSZ/46WSfQWrKl
	RhPBM+OWyJpzXn0f6VSC4kCXRsfI=
X-Google-Smtp-Source: AGHT+IHIITwkALdKCWPmm3gkWYTG9u8EgJ/KMu90jQYnnXbSGN6CB6st9ixoRSoQc7K5rfnRREqN6u5NWzG68wF/EtE=
X-Received: by 2002:a17:907:1b03:b0:ac2:cae8:e153 with SMTP id
 a640c23a62f3a-ace6b35eb82mr17758766b.4.1745510885976; Thu, 24 Apr 2025
 09:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744984487.git.josef@toxicpanda.com> <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com> <20250424154719.GA311510@perftesting>
In-Reply-To: <20250424154719.GA311510@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 24 Apr 2025 17:07:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
X-Gm-Features: ATxdqUElBkbbn1-ReS2_SIE26CyvwiAyitk1zmKyDRpJqdKA5TeVr7OOkm510II
Message-ID: <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:47=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Apr 23, 2025 at 04:08:56PM +0100, Filipe Manana wrote:
> > On Fri, Apr 18, 2025 at 2:58=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > In order to fully utilize xarray tagging to improve writeback we need=
 to
> > > convert the buffer_radix to a proper xarray.  This conversion is
> > > relatively straightforward as the radix code uses the xarray undernea=
th.
> > > Using xarray directly allows for quite a lot less code.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/btrfs/disk-io.c           |  15 ++-
> > >  fs/btrfs/extent_io.c         | 196 +++++++++++++++------------------=
--
> > >  fs/btrfs/fs.h                |   4 +-
> > >  fs/btrfs/tests/btrfs-tests.c |  27 ++---
> > >  fs/btrfs/zoned.c             |  16 +--
> > >  5 files changed, 113 insertions(+), 145 deletions(-)
> > >
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 59da809b7d57..24c08eb86b7b 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrf=
s_fs_info *fs_info)
> > >         return ret;
> > >  }
> > >
> > > +/*
> > > + * lockdep gets confused between our buffer_tree which requires IRQ =
locking
> > > + * because we modify marks in the IRQ context, and our delayed inode=
 xarray
> > > + * which doesn't have these requirements. Use a class key so lockdep=
 doesn't get
> > > + * them mixed up.
> > > + */
> > > +static struct lock_class_key buffer_xa_class;
> > > +
> > >  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> > >  {
> > >         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> > > -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> > > +
> > > +       /* Use the same flags as mapping->i_pages. */
> > > +       xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_F=
LAGS_ACCOUNT);
> > > +       lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_c=
lass);
> > > +
> > >         INIT_LIST_HEAD(&fs_info->trans_list);
> > >         INIT_LIST_HEAD(&fs_info->dead_roots);
> > >         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> > > @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *f=
s_info)
> > >         spin_lock_init(&fs_info->delayed_iput_lock);
> > >         spin_lock_init(&fs_info->defrag_inodes_lock);
> > >         spin_lock_init(&fs_info->super_lock);
> > > -       spin_lock_init(&fs_info->buffer_lock);
> > >         spin_lock_init(&fs_info->unused_bgs_lock);
> > >         spin_lock_init(&fs_info->treelog_bg_lock);
> > >         spin_lock_init(&fs_info->zone_active_bgs_lock);
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 6cfd286b8bbc..aa451ad52528 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent_buf=
fer *eb)
> > >   * context.
> > >   */
> > >  static struct extent_buffer *find_extent_buffer_nolock(
> > > -               const struct btrfs_fs_info *fs_info, u64 start)
> > > +               struct btrfs_fs_info *fs_info, u64 start)
> > >  {
> > > +       XA_STATE(xas, &fs_info->buffer_tree, start >> fs_info->sector=
size_bits);
> > >         struct extent_buffer *eb;
> > >
> > >         rcu_read_lock();
> > > -       eb =3D radix_tree_lookup(&fs_info->buffer_radix,
> > > -                              start >> fs_info->sectorsize_bits);
> > > -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> > > -               rcu_read_unlock();
> > > -               return eb;
> > > -       }
> > > +       do {
> > > +               eb =3D xas_load(&xas);
> > > +       } while (xas_retry(&xas, eb));
> >
> > Why not use the simpler xarray API?
> > This is basically open coding what xa_load() does, so we can get rid
> > of this loop and no need to define a XA_STATE above.
>
> Because we have to do the atomic_inc_not_zero() under the rcu_lock(), so =
we have
> have to open code the retry logic.

Sure, but xa_load() can still be called while we are under the rcu
read section, can't it?

>
> >
> > > +
> > > +       if (eb && !atomic_inc_not_zero(&eb->refs))
> > > +               eb =3D NULL;
> > >         rcu_read_unlock();
> > > -       return NULL;
> > > +       return eb;
> > >  }
> > >
> > >  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> > > @@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(const =
struct extent_buffer *eb, struct fo
> > >
> > >         if (!btrfs_meta_is_subpage(fs_info)) {
> > >                 /*
> > > -                * We do this since we'll remove the pages after we'v=
e
> > > -                * removed the eb from the radix tree, so we could ra=
ce
> > > -                * and have this page now attached to the new eb.  So
> > > -                * only clear folio if it's still connected to
> > > -                * this eb.
> > > +                * We do this since we'll remove the pages after we'v=
e removed
> > > +                * the eb from the xarray, so we could race and have =
this page
> > > +                * now attached to the new eb.  So only clear folio i=
f it's
> > > +                * still connected to this eb.
> > >                  */
> > >                 if (folio_test_private(folio) && folio_get_private(fo=
lio) =3D=3D eb) {
> > >                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bfl=
ags));
> > > @@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct extent=
_buffer *eb)
> > >  {
> > >         int refs;
> > >         /*
> > > -        * The TREE_REF bit is first set when the extent_buffer is ad=
ded
> > > -        * to the radix tree. It is also reset, if unset, when a new =
reference
> > > -        * is created by find_extent_buffer.
> > > +        * The TREE_REF bit is first set when the extent_buffer is ad=
ded to the
> > > +        * xarray. It is also reset, if unset, when a new reference i=
s created
> > > +        * by find_extent_buffer.
> > >          *
> > >          * It is only cleared in two cases: freeing the last non-tree
> > >          * reference to the extent_buffer when its STALE bit is set o=
r
> > > @@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct exte=
nt_buffer *eb)
> > >          * conditions between the calls to check_buffer_tree_ref in t=
hose
> > >          * codepaths and clearing TREE_REF in try_release_extent_buff=
er.
> > >          *
> > > -        * The actual lifetime of the extent_buffer in the radix tree=
 is
> > > -        * adequately protected by the refcount, but the TREE_REF bit=
 and
> > > -        * its corresponding reference are not. To protect against th=
is
> > > -        * class of races, we call check_buffer_tree_ref from the cod=
epaths
> > > -        * which trigger io. Note that once io is initiated, TREE_REF=
 can no
> > > -        * longer be cleared, so that is the moment at which any such=
 race is
> > > -        * best fixed.
> > > +        * The actual lifetime of the extent_buffer in the xarray is =
adequately
> > > +        * protected by the refcount, but the TREE_REF bit and its co=
rresponding
> > > +        * reference are not. To protect against this class of races,=
 we call
> > > +        * check_buffer_tree_ref from the codepaths which trigger io.=
 Note that
> > > +        * once io is initiated, TREE_REF can no longer be cleared, s=
o that is
> > > +        * the moment at which any such race is best fixed.
> > >          */
> > >         refs =3D atomic_read(&eb->refs);
> > >         if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bfla=
gs))
> > > @@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_buffe=
r(struct btrfs_fs_info *fs_info,
> > >                 return ERR_PTR(-ENOMEM);
> > >         eb->fs_info =3D fs_info;
> > >  again:
> > > -       ret =3D radix_tree_preload(GFP_NOFS);
> > > -       if (ret) {
> > > -               exists =3D ERR_PTR(ret);
> > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > +       exists =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > > +                             start >> fs_info->sectorsize_bits, NULL=
, eb,
> > > +                             GFP_NOFS);
> > > +       if (xa_is_err(exists)) {
> > > +               ret =3D xa_err(exists);
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > +               btrfs_release_extent_buffer(eb);
> > > +               return ERR_PTR(ret);
> > > +       }
> > > +       if (exists) {
> > > +               if (!atomic_inc_not_zero(&exists->refs)) {
> > > +                       /* The extent buffer is being freed, retry. *=
/
> > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > +                       goto again;
> > > +               }
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > >                 goto free_eb;
> > >         }
> > > -       spin_lock(&fs_info->buffer_lock);
> > > -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> > > -                               start >> fs_info->sectorsize_bits, eb=
);
> > > -       spin_unlock(&fs_info->buffer_lock);
> > > -       radix_tree_preload_end();
> > > -       if (ret =3D=3D -EEXIST) {
> > > -               exists =3D find_extent_buffer(fs_info, start);
> > > -               if (exists)
> > > -                       goto free_eb;
> > > -               else
> > > -                       goto again;
> > > -       }
> > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > >         check_buffer_tree_ref(eb);
> > >
> > >         return eb;
> > > @@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_buffer=
(struct btrfs_fs_info *fs_info,
> > >         lockdep_assert_held(&folio->mapping->i_private_lock);
> > >
> > >         /*
> > > -        * For subpage case, we completely rely on radix tree to ensu=
re we
> > > -        * don't try to insert two ebs for the same bytenr.  So here =
we always
> > > -        * return NULL and just continue.
> > > +        * For subpage case, we completely rely on xarray to ensure w=
e don't try
> > > +        * to insert two ebs for the same bytenr.  So here we always =
return NULL
> > > +        * and just continue.
> > >          */
> > >         if (btrfs_meta_is_subpage(fs_info))
> > >                 return NULL;
> > > @@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struct ex=
tent_buffer *eb, int i,
> > >         /*
> > >          * To inform we have an extra eb under allocation, so that
> > >          * detach_extent_buffer_page() won't release the folio privat=
e when the
> > > -        * eb hasn't been inserted into radix tree yet.
> > > +        * eb hasn't been inserted into the xarray yet.
> > >          *
> > >          * The ref will be decreased when the eb releases the page, i=
n
> > >          * detach_extent_buffer_page().  Thus needs no special handli=
ng in the
> > > @@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer(str=
uct btrfs_fs_info *fs_info,
> > >
> > >                 /*
> > >                  * We can't unlock the pages just yet since the exten=
t buffer
> > > -                * hasn't been properly inserted in the radix tree, t=
his
> > > -                * opens a race with btree_release_folio which can fr=
ee a page
> > > -                * while we are still filling in all pages for the bu=
ffer and
> > > -                * we could crash.
> > > +                * hasn't been properly inserted in the xarray, this =
opens a
> > > +                * race with btree_release_folio which can free a pag=
e while we
> > > +                * are still filling in all pages for the buffer and =
we could
> > > +                * crash.
> > >                  */
> > >         }
> > >         if (uptodate)
> > > @@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer(str=
uct btrfs_fs_info *fs_info,
> > >         if (page_contig)
> > >                 eb->addr =3D folio_address(eb->folios[0]) + offset_in=
_page(eb->start);
> > >  again:
> > > -       ret =3D radix_tree_preload(GFP_NOFS);
> > > -       if (ret)
> > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > +       existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > > +                                  start >> fs_info->sectorsize_bits,=
 NULL, eb,
> > > +                                  GFP_NOFS);
> > > +       if (xa_is_err(existing_eb)) {
> > > +               ret =3D xa_err(existing_eb);
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > >                 goto out;
> > > -
> > > -       spin_lock(&fs_info->buffer_lock);
> > > -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> > > -                               start >> fs_info->sectorsize_bits, eb=
);
> > > -       spin_unlock(&fs_info->buffer_lock);
> > > -       radix_tree_preload_end();
> > > -       if (ret =3D=3D -EEXIST) {
> > > -               ret =3D 0;
> > > -               existing_eb =3D find_extent_buffer(fs_info, start);
> > > -               if (existing_eb)
> > > -                       goto out;
> > > -               else
> > > -                       goto again;
> > >         }
> > > +       if (existing_eb) {
> > > +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > +                       goto again;
> > > +               }
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > +               goto out;
> > > +       }
> > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > > +
> > >         /* add one reference for the tree */
> > >         check_buffer_tree_ref(eb);
> > >
> > > @@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct exten=
t_buffer *eb)
> > >
> > >                 spin_unlock(&eb->refs_lock);
> > >
> > > -               spin_lock(&fs_info->buffer_lock);
> > > -               radix_tree_delete_item(&fs_info->buffer_radix,
> > > -                                      eb->start >> fs_info->sectorsi=
ze_bits, eb);
> > > -               spin_unlock(&fs_info->buffer_lock);
> > > +               /*
> > > +                * We're erasing, theoretically there will be no allo=
cations, so
> > > +                * just use GFP_ATOMIC.
> > > +                */
> > > +               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > > +                              eb->start >> fs_info->sectorsize_bits,=
 eb, NULL,
> > > +                              GFP_ATOMIC);
> >
> > This I don't get. Why are we doing a cmp exchange with NULL and not
> > removing the entry?
> > Swapping with NULL doesn't release the entry, as xarray permits
> > storing NULL values. So after a long time releasing extent buffers we
> > may be holding on to memory unnecessarily.
> >
> > Why not use xa_erase()?
>
> Because we may be freeing a buffer that we raced with the insert, so we d=
on't
> want to replace the winner with NULL.
>
> Assume that we allocate two buffers for ->start =3D=3D 0, we insert one b=
uffer into
> the xarray, and we free the other.  When we're freeing the other we will =
not
> delete the xarray entry because it doesn't match the buffer we're removin=
g.

Sure, I get that part, that we don't want to delete an entry if it
doesn't match our eb.
But if it matches, we store a NULL in it, meaning the xarray entry
will remain and potentially hold unnecessary memory for a long time
unless that index gets reused soon or there are  other indexes in the
region.

That was (and is my) my concern.

As far as I can see we never do actual index deletions from the
xarray, just store NULL values, not allowing the xarray to release
space.

>
> >
> > >
> > >                 btrfs_leak_debug_del_eb(eb);
> > >                 /* Should be safe to release folios at this point. */
> > > @@ -4260,44 +4267,6 @@ void memmove_extent_buffer(const struct extent=
_buffer *dst,
> > >         }
> > >  }
> > >
> > > -#define GANG_LOOKUP_SIZE       16
> > > -static struct extent_buffer *get_next_extent_buffer(
> > > -               const struct btrfs_fs_info *fs_info, struct folio *fo=
lio, u64 bytenr)
> > > -{
> > > -       struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> > > -       struct extent_buffer *found =3D NULL;
> > > -       u64 folio_start =3D folio_pos(folio);
> > > -       u64 cur =3D folio_start;
> > > -
> > > -       ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
> > > -       lockdep_assert_held(&fs_info->buffer_lock);
> > > -
> > > -       while (cur < folio_start + PAGE_SIZE) {
> > > -               int ret;
> > > -               int i;
> > > -
> > > -               ret =3D radix_tree_gang_lookup(&fs_info->buffer_radix=
,
> > > -                               (void **)gang, cur >> fs_info->sector=
size_bits,
> > > -                               min_t(unsigned int, GANG_LOOKUP_SIZE,
> > > -                                     PAGE_SIZE / fs_info->nodesize))=
;
> > > -               if (ret =3D=3D 0)
> > > -                       goto out;
> > > -               for (i =3D 0; i < ret; i++) {
> > > -                       /* Already beyond page end */
> > > -                       if (gang[i]->start >=3D folio_start + PAGE_SI=
ZE)
> > > -                               goto out;
> > > -                       /* Found one */
> > > -                       if (gang[i]->start >=3D bytenr) {
> > > -                               found =3D gang[i];
> > > -                               goto out;
> > > -                       }
> > > -               }
> > > -               cur =3D gang[ret - 1]->start + gang[ret - 1]->len;
> > > -       }
> > > -out:
> > > -       return found;
> > > -}
> > > -
> > >  static int try_release_subpage_extent_buffer(struct folio *folio)
> > >  {
> > >         struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> > > @@ -4306,21 +4275,26 @@ static int try_release_subpage_extent_buffer(=
struct folio *folio)
> > >         int ret;
> > >
> > >         while (cur < end) {
> > > +               XA_STATE(xas, &fs_info->buffer_tree,
> > > +                        cur >> fs_info->sectorsize_bits);
> > >                 struct extent_buffer *eb =3D NULL;
> > >
> > >                 /*
> > >                  * Unlike try_release_extent_buffer() which uses foli=
o private
> > > -                * to grab buffer, for subpage case we rely on radix =
tree, thus
> > > -                * we need to ensure radix tree consistency.
> > > +                * to grab buffer, for subpage case we rely on xarray=
, thus we
> > > +                * need to ensure xarray tree consistency.
> > >                  *
> > > -                * We also want an atomic snapshot of the radix tree,=
 thus go
> > > +                * We also want an atomic snapshot of the xarray tree=
, thus go
> > >                  * with spinlock rather than RCU.
> > >                  */
> > > -               spin_lock(&fs_info->buffer_lock);
> > > -               eb =3D get_next_extent_buffer(fs_info, folio, cur);
> > > +               xa_lock_irq(&fs_info->buffer_tree);
> > > +               do {
> > > +                       eb =3D xas_find(&xas, end >> fs_info->sectors=
ize_bits);
> > > +               } while (xas_retry(&xas, eb));
> >
> > Same here as before, why not use xa_load()?
> > It would avoid  the need to define a XA_STATE and having the loop
> > doing the tretry.
>
> Because we need to be holding the lock while we're messing with the exten=
t
> buffer.  We could probably still use xa_load() here while holding the loc=
k since
> xa_load() just does rcu_read_lock(), but this is more explicit in what we=
're
> doing.

But it's more code unnecessarily. We use xa_load() while under an
xarray lock at delayed inodes for example, and there's no problem with
it.
It makes the code shorter and simpler.

Thanks.

>
> >
> > > +
> > >                 if (!eb) {
> > >                         /* No more eb in the page range after or at c=
ur */
> > > -                       spin_unlock(&fs_info->buffer_lock);
> > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > >                         break;
> > >                 }
> > >                 cur =3D eb->start + eb->len;
> > > @@ -4332,10 +4306,10 @@ static int try_release_subpage_extent_buffer(=
struct folio *folio)
> > >                 spin_lock(&eb->refs_lock);
> > >                 if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_un=
der_io(eb)) {
> > >                         spin_unlock(&eb->refs_lock);
> > > -                       spin_unlock(&fs_info->buffer_lock);
> > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > >                         break;
> > >                 }
> > > -               spin_unlock(&fs_info->buffer_lock);
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > >
> > >                 /*
> > >                  * If tree ref isn't set then we know the ref on this=
 eb is a
> > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > > index bcca43046064..ed02d276d908 100644
> > > --- a/fs/btrfs/fs.h
> > > +++ b/fs/btrfs/fs.h
> > > @@ -776,10 +776,8 @@ struct btrfs_fs_info {
> > >
> > >         struct btrfs_delayed_root *delayed_root;
> > >
> > > -       /* Extent buffer radix tree */
> > > -       spinlock_t buffer_lock;
> > >         /* Entries are eb->start / sectorsize */
> > > -       struct radix_tree_root buffer_radix;
> > > +       struct xarray buffer_tree;
> > >
> > >         /* Next backup root to be overwritten */
> > >         int backup_root_index;
> > > diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-test=
s.c
> > > index 02a915eb51fb..27fd05308a96 100644
> > > --- a/fs/btrfs/tests/btrfs-tests.c
> > > +++ b/fs/btrfs/tests/btrfs-tests.c
> > > @@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u=
32 nodesize, u32 sectorsize)
> > >
> > >  void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
> > >  {
> > > -       struct radix_tree_iter iter;
> > > -       void **slot;
> > > +       XA_STATE(xas, &fs_info->buffer_tree, 0);
> > >         struct btrfs_device *dev, *tmp;
> > > +       struct extent_buffer *eb;
> > >
> > >         if (!fs_info)
> > >                 return;
> > > @@ -169,25 +169,16 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_i=
nfo *fs_info)
> > >
> > >         test_mnt->mnt_sb->s_fs_info =3D NULL;
> > >
> > > -       spin_lock(&fs_info->buffer_lock);
> > > -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,=
 0) {
> > > -               struct extent_buffer *eb;
> > > -
> > > -               eb =3D radix_tree_deref_slot_protected(slot, &fs_info=
->buffer_lock);
> > > -               if (!eb)
> > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > +       xas_for_each(&xas, eb, ULONG_MAX) {
> > > +               if (xas_retry(&xas, eb))
> >
> > Can't we use a xa_for_each() variant here?
> > It would avoid the need to define a XA_STATE and to deal with these
> > retries and the pausing below.
>
> Agreed, I'll fix this up.
>
> >
> > >                         continue;
> > > -               /* Shouldn't happen but that kind of thinking creates=
 CVE's */
> > > -               if (radix_tree_exception(eb)) {
> > > -                       if (radix_tree_deref_retry(eb))
> > > -                               slot =3D radix_tree_iter_retry(&iter)=
;
> > > -                       continue;
> > > -               }
> > > -               slot =3D radix_tree_iter_resume(slot, &iter);
> > > -               spin_unlock(&fs_info->buffer_lock);
> > > +               xas_pause(&xas);
> > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > >                 free_extent_buffer_stale(eb);
> > > -               spin_lock(&fs_info->buffer_lock);
> > > +               xa_lock_irq(&fs_info->buffer_tree);
> > >         }
> > > -       spin_unlock(&fs_info->buffer_lock);
> > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > >
> > >         btrfs_mapping_tree_free(fs_info);
> > >         list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devi=
ces,
> > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > index 7b30700ec930..82fb08790b64 100644
> > > --- a/fs/btrfs/zoned.c
> > > +++ b/fs/btrfs/zoned.c
> > > @@ -2170,28 +2170,22 @@ bool btrfs_zone_activate(struct btrfs_block_g=
roup *block_group)
> > >  static void wait_eb_writebacks(struct btrfs_block_group *block_group=
)
> > >  {
> > >         struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> > > +       XA_STATE(xas, &fs_info->buffer_tree,
> > > +                block_group->start >> fs_info->sectorsize_bits);
> > >         const u64 end =3D block_group->start + block_group->length;
> > > -       struct radix_tree_iter iter;
> > >         struct extent_buffer *eb;
> > > -       void __rcu **slot;
> > >
> > >         rcu_read_lock();
> > > -       radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
> > > -                                block_group->start >> fs_info->secto=
rsize_bits) {
> > > -               eb =3D radix_tree_deref_slot(slot);
> > > -               if (!eb)
> > > +       xas_for_each(&xas, eb, end >> fs_info->sectorsize_bits) {
> > > +               if (xas_retry(&xas, eb))
> >
> > Same here, using the simpler API, one of the xa_for_each_range()
> > variants to avoid dealing with retry entries, defining a XA_STATE and
> > the pausing below.
>
> Agreed, thanks,
>
> Josef

