Return-Path: <linux-btrfs+bounces-13431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99A9A9CDA3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5504C51E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB0F28DF19;
	Fri, 25 Apr 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KL3Fbe+r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D13633F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596762; cv=none; b=X0XOqQkuFOftiwmZk17quM5EQZ7KsDCOd5888cLEZ06ZE09z9874YLkOrlRmqlvOb7pSwvMAYD1foB9oFLndf8fE0Gk9i/fGVeeBLFL1NhrF8NGT7MdpbeaAKUFpvt70HrTpcC5+XELm4yEUZ5q0xS5FSRNfaIgZTrVRHQRunY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596762; c=relaxed/simple;
	bh=iAJECWniAD/xB289KttV2zognZ/Z5zawl/6qjjM5IaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3zzoMz81bsnICmI/FBluNQXxPDL8yeiN8mONXBvfMs4nJrbDwRZn+ZCd1o4YYs8xTaXKeYo4Zi+R78HLl9h1nvvhx5ddYIGK8Sxjx/Q5vuFyM4lvyrJg1Z55uojBvx+ZGWDFYpalT2izy31EAnBZ6N8GThikkq8klg0pSWi54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KL3Fbe+r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac3b12e8518so430300266b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745596757; x=1746201557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK3rtqR6Y5XuJpGqb21ipr1Hnb+fU1KdoACkIn0q6ZE=;
        b=KL3Fbe+r76lBUfWXtgLE1UoLESVivpSZcx1/xw4IxR/TeRUOsPmJh3HvzYz+dp71Dd
         jftgTTjMvBgowfCz+wvReOuMC69Od/PzfFPnEiR5LneDU5i598VEIZerF+vbZhbN99ed
         SQHtwZEOs+S6TH85OTvv0xhVSzd75EF9/rbyNiz9VccDgOSN4lCrDo178K7wBM1a1rir
         B9CBBsQ7hNhYHCn9a9O49sEea1DCFKfBS5ODrNWqAvqMvmwAqzamTC/7AJ1MBO8Uwrbd
         8KtSUD00TTF76xEDXGi7j5GiQljJ41adJmoEV4UArzcl/clex+SaVDaBxo+SpZKemO3C
         rLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596757; x=1746201557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK3rtqR6Y5XuJpGqb21ipr1Hnb+fU1KdoACkIn0q6ZE=;
        b=GO3n95zA3B7Y0blMOZGr/svBbwPW/+RgGLfTBUdijOVfQAVLKRHXIYJuWF3rGUF9XK
         NLRVP2dJw8ZycTXpol+Kwsp5tHFudyBjOz4kxkxyABp6rPvyzn5jfRXXLKDWG541ndlg
         ITp2s4QP6DGM1qoaCMzyvF7JCLh0hpkyQKPK06UMVraASNUSAU+BzzwYBDCV9ccTQV0C
         AXNkPI2bSkHUhK7tLYaMSb3pDE+/yapPh2rvKrbx1ggZX8ZuLtwkDu1ZRBcqkqenIM6K
         +j1EVwwNEO4/kIPqkJ1Dq9u14OewaQIzUloQlZ/IJ0x/IcT53nD9saIjRwgdT0E671Gn
         w5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXD3HhbhgU5zQioC7/mPgp43dQgyPhpxlCrTjCXxVHZ84YeCyPKmQUJQS34jA9W5Kg3j1eV2AhfCNbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IafxVid709emSVp3Z5ben3eOuz8aAJ6vGSOSYiKJ6V8iswId
	1qFpBVIhy0jQeUiETBbOblrJ9xF7BdHQoB/4Y8ZvjPperIIlT6qSb14b/ewpkVOtf2+3l2tmfZQ
	AqEFv9wX6esHLmBNgcjXpZjDbkKAxIMbTIBnnkg==
X-Gm-Gg: ASbGnctLKghBRc7f64d8EspMgcnJGDpZEjVY9cHUf9fzYihe0Arzds7dSJeqig2sYoA
	esPk0oB6ZZVOJUKHpJyjzSAfoVdExRqVcTkdnZqM6Y5KJRNc3btPmaYzF8t3XaB/2i+ue4vfOdl
	kBLUCoK3bUdEji/QRtsQjY
X-Google-Smtp-Source: AGHT+IFpHFfxQnjv2+YnvoIFf0d6T4k2TYgqOk4Cgk6iytEZbqjTbrF8e/HtMyf97Z0yTLEPoQAL94N8enmOk6OVlfc=
X-Received: by 2002:a17:907:6d27:b0:acb:33c6:5c71 with SMTP id
 a640c23a62f3a-ace710f1a40mr292579566b.29.1745596757497; Fri, 25 Apr 2025
 08:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744984487.git.josef@toxicpanda.com> <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>
 <20250424154719.GA311510@perftesting> <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
 <20250425154844.GB494636@perftesting>
In-Reply-To: <20250425154844.GB494636@perftesting>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 25 Apr 2025 17:59:06 +0200
X-Gm-Features: ATxdqUErBnJEJspsonDthuhubBu9yoEunXBnKEhQy7i-1Yodiq-jjqpDrBZGUjc
Message-ID: <CAPjX3FfcJcn4r35CJqCb_31Ui5f+zpDNoyWxyq4w01W=aMvF2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
To: Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Apr 2025 at 17:49, Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Thu, Apr 24, 2025 at 05:07:29PM +0100, Filipe Manana wrote:
> > On Thu, Apr 24, 2025 at 4:47=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Wed, Apr 23, 2025 at 04:08:56PM +0100, Filipe Manana wrote:
> > > > On Fri, Apr 18, 2025 at 2:58=E2=80=AFPM Josef Bacik <josef@toxicpan=
da.com> wrote:
> > > > >
> > > > > In order to fully utilize xarray tagging to improve writeback we =
need to
> > > > > convert the buffer_radix to a proper xarray.  This conversion is
> > > > > relatively straightforward as the radix code uses the xarray unde=
rneath.
> > > > > Using xarray directly allows for quite a lot less code.
> > > > >
> > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > ---
> > > > >  fs/btrfs/disk-io.c           |  15 ++-
> > > > >  fs/btrfs/extent_io.c         | 196 +++++++++++++++--------------=
------
> > > > >  fs/btrfs/fs.h                |   4 +-
> > > > >  fs/btrfs/tests/btrfs-tests.c |  27 ++---
> > > > >  fs/btrfs/zoned.c             |  16 +--
> > > > >  5 files changed, 113 insertions(+), 145 deletions(-)
> > > > >
> > > > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > > > index 59da809b7d57..24c08eb86b7b 100644
> > > > > --- a/fs/btrfs/disk-io.c
> > > > > +++ b/fs/btrfs/disk-io.c
> > > > > @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct =
btrfs_fs_info *fs_info)
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * lockdep gets confused between our buffer_tree which requires =
IRQ locking
> > > > > + * because we modify marks in the IRQ context, and our delayed i=
node xarray
> > > > > + * which doesn't have these requirements. Use a class key so loc=
kdep doesn't get
> > > > > + * them mixed up.
> > > > > + */
> > > > > +static struct lock_class_key buffer_xa_class;
> > > > > +
> > > > >  void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> > > > >  {
> > > > >         INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> > > > > -       INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> > > > > +
> > > > > +       /* Use the same flags as mapping->i_pages. */
> > > > > +       xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | =
XA_FLAGS_ACCOUNT);
> > > > > +       lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_=
xa_class);
> > > > > +
> > > > >         INIT_LIST_HEAD(&fs_info->trans_list);
> > > > >         INIT_LIST_HEAD(&fs_info->dead_roots);
> > > > >         INIT_LIST_HEAD(&fs_info->delayed_iputs);
> > > > > @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_inf=
o *fs_info)
> > > > >         spin_lock_init(&fs_info->delayed_iput_lock);
> > > > >         spin_lock_init(&fs_info->defrag_inodes_lock);
> > > > >         spin_lock_init(&fs_info->super_lock);
> > > > > -       spin_lock_init(&fs_info->buffer_lock);
> > > > >         spin_lock_init(&fs_info->unused_bgs_lock);
> > > > >         spin_lock_init(&fs_info->treelog_bg_lock);
> > > > >         spin_lock_init(&fs_info->zone_active_bgs_lock);
> > > > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > > > index 6cfd286b8bbc..aa451ad52528 100644
> > > > > --- a/fs/btrfs/extent_io.c
> > > > > +++ b/fs/btrfs/extent_io.c
> > > > > @@ -1893,19 +1893,20 @@ static void set_btree_ioerr(struct extent=
_buffer *eb)
> > > > >   * context.
> > > > >   */
> > > > >  static struct extent_buffer *find_extent_buffer_nolock(
> > > > > -               const struct btrfs_fs_info *fs_info, u64 start)
> > > > > +               struct btrfs_fs_info *fs_info, u64 start)
> > > > >  {
> > > > > +       XA_STATE(xas, &fs_info->buffer_tree, start >> fs_info->se=
ctorsize_bits);
> > > > >         struct extent_buffer *eb;
> > > > >
> > > > >         rcu_read_lock();
> > > > > -       eb =3D radix_tree_lookup(&fs_info->buffer_radix,
> > > > > -                              start >> fs_info->sectorsize_bits)=
;
> > > > > -       if (eb && atomic_inc_not_zero(&eb->refs)) {
> > > > > -               rcu_read_unlock();
> > > > > -               return eb;
> > > > > -       }
> > > > > +       do {
> > > > > +               eb =3D xas_load(&xas);
> > > > > +       } while (xas_retry(&xas, eb));
> > > >
> > > > Why not use the simpler xarray API?
> > > > This is basically open coding what xa_load() does, so we can get ri=
d
> > > > of this loop and no need to define a XA_STATE above.
> > >
> > > Because we have to do the atomic_inc_not_zero() under the rcu_lock(),=
 so we have
> > > have to open code the retry logic.
> >
> > Sure, but xa_load() can still be called while we are under the rcu
> > read section, can't it?
> >
> > >
> > > >
> > > > > +
> > > > > +       if (eb && !atomic_inc_not_zero(&eb->refs))
> > > > > +               eb =3D NULL;
> > > > >         rcu_read_unlock();
> > > > > -       return NULL;
> > > > > +       return eb;
> > > > >  }
> > > > >
> > > > >  static void end_bbio_meta_write(struct btrfs_bio *bbio)
> > > > > @@ -2769,11 +2770,10 @@ static void detach_extent_buffer_folio(co=
nst struct extent_buffer *eb, struct fo
> > > > >
> > > > >         if (!btrfs_meta_is_subpage(fs_info)) {
> > > > >                 /*
> > > > > -                * We do this since we'll remove the pages after =
we've
> > > > > -                * removed the eb from the radix tree, so we coul=
d race
> > > > > -                * and have this page now attached to the new eb.=
  So
> > > > > -                * only clear folio if it's still connected to
> > > > > -                * this eb.
> > > > > +                * We do this since we'll remove the pages after =
we've removed
> > > > > +                * the eb from the xarray, so we could race and h=
ave this page
> > > > > +                * now attached to the new eb.  So only clear fol=
io if it's
> > > > > +                * still connected to this eb.
> > > > >                  */
> > > > >                 if (folio_test_private(folio) && folio_get_privat=
e(folio) =3D=3D eb) {
> > > > >                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb-=
>bflags));
> > > > > @@ -2938,9 +2938,9 @@ static void check_buffer_tree_ref(struct ex=
tent_buffer *eb)
> > > > >  {
> > > > >         int refs;
> > > > >         /*
> > > > > -        * The TREE_REF bit is first set when the extent_buffer i=
s added
> > > > > -        * to the radix tree. It is also reset, if unset, when a =
new reference
> > > > > -        * is created by find_extent_buffer.
> > > > > +        * The TREE_REF bit is first set when the extent_buffer i=
s added to the
> > > > > +        * xarray. It is also reset, if unset, when a new referen=
ce is created
> > > > > +        * by find_extent_buffer.
> > > > >          *
> > > > >          * It is only cleared in two cases: freeing the last non-=
tree
> > > > >          * reference to the extent_buffer when its STALE bit is s=
et or
> > > > > @@ -2952,13 +2952,12 @@ static void check_buffer_tree_ref(struct =
extent_buffer *eb)
> > > > >          * conditions between the calls to check_buffer_tree_ref =
in those
> > > > >          * codepaths and clearing TREE_REF in try_release_extent_=
buffer.
> > > > >          *
> > > > > -        * The actual lifetime of the extent_buffer in the radix =
tree is
> > > > > -        * adequately protected by the refcount, but the TREE_REF=
 bit and
> > > > > -        * its corresponding reference are not. To protect agains=
t this
> > > > > -        * class of races, we call check_buffer_tree_ref from the=
 codepaths
> > > > > -        * which trigger io. Note that once io is initiated, TREE=
_REF can no
> > > > > -        * longer be cleared, so that is the moment at which any =
such race is
> > > > > -        * best fixed.
> > > > > +        * The actual lifetime of the extent_buffer in the xarray=
 is adequately
> > > > > +        * protected by the refcount, but the TREE_REF bit and it=
s corresponding
> > > > > +        * reference are not. To protect against this class of ra=
ces, we call
> > > > > +        * check_buffer_tree_ref from the codepaths which trigger=
 io. Note that
> > > > > +        * once io is initiated, TREE_REF can no longer be cleare=
d, so that is
> > > > > +        * the moment at which any such race is best fixed.
> > > > >          */
> > > > >         refs =3D atomic_read(&eb->refs);
> > > > >         if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->=
bflags))
> > > > > @@ -3022,23 +3021,26 @@ struct extent_buffer *alloc_test_extent_b=
uffer(struct btrfs_fs_info *fs_info,
> > > > >                 return ERR_PTR(-ENOMEM);
> > > > >         eb->fs_info =3D fs_info;
> > > > >  again:
> > > > > -       ret =3D radix_tree_preload(GFP_NOFS);
> > > > > -       if (ret) {
> > > > > -               exists =3D ERR_PTR(ret);
> > > > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > > > +       exists =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > > > > +                             start >> fs_info->sectorsize_bits, =
NULL, eb,
> > > > > +                             GFP_NOFS);
> > > > > +       if (xa_is_err(exists)) {
> > > > > +               ret =3D xa_err(exists);
> > > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > > +               btrfs_release_extent_buffer(eb);
> > > > > +               return ERR_PTR(ret);
> > > > > +       }
> > > > > +       if (exists) {
> > > > > +               if (!atomic_inc_not_zero(&exists->refs)) {
> > > > > +                       /* The extent buffer is being freed, retr=
y. */
> > > > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > > > +                       goto again;
> > > > > +               }
> > > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > >                 goto free_eb;
> > > > >         }
> > > > > -       spin_lock(&fs_info->buffer_lock);
> > > > > -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> > > > > -                               start >> fs_info->sectorsize_bits=
, eb);
> > > > > -       spin_unlock(&fs_info->buffer_lock);
> > > > > -       radix_tree_preload_end();
> > > > > -       if (ret =3D=3D -EEXIST) {
> > > > > -               exists =3D find_extent_buffer(fs_info, start);
> > > > > -               if (exists)
> > > > > -                       goto free_eb;
> > > > > -               else
> > > > > -                       goto again;
> > > > > -       }
> > > > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > > > >         check_buffer_tree_ref(eb);
> > > > >
> > > > >         return eb;
> > > > > @@ -3059,9 +3061,9 @@ static struct extent_buffer *grab_extent_bu=
ffer(struct btrfs_fs_info *fs_info,
> > > > >         lockdep_assert_held(&folio->mapping->i_private_lock);
> > > > >
> > > > >         /*
> > > > > -        * For subpage case, we completely rely on radix tree to =
ensure we
> > > > > -        * don't try to insert two ebs for the same bytenr.  So h=
ere we always
> > > > > -        * return NULL and just continue.
> > > > > +        * For subpage case, we completely rely on xarray to ensu=
re we don't try
> > > > > +        * to insert two ebs for the same bytenr.  So here we alw=
ays return NULL
> > > > > +        * and just continue.
> > > > >          */
> > > > >         if (btrfs_meta_is_subpage(fs_info))
> > > > >                 return NULL;
> > > > > @@ -3194,7 +3196,7 @@ static int attach_eb_folio_to_filemap(struc=
t extent_buffer *eb, int i,
> > > > >         /*
> > > > >          * To inform we have an extra eb under allocation, so tha=
t
> > > > >          * detach_extent_buffer_page() won't release the folio pr=
ivate when the
> > > > > -        * eb hasn't been inserted into radix tree yet.
> > > > > +        * eb hasn't been inserted into the xarray yet.
> > > > >          *
> > > > >          * The ref will be decreased when the eb releases the pag=
e, in
> > > > >          * detach_extent_buffer_page().  Thus needs no special ha=
ndling in the
> > > > > @@ -3328,10 +3330,10 @@ struct extent_buffer *alloc_extent_buffer=
(struct btrfs_fs_info *fs_info,
> > > > >
> > > > >                 /*
> > > > >                  * We can't unlock the pages just yet since the e=
xtent buffer
> > > > > -                * hasn't been properly inserted in the radix tre=
e, this
> > > > > -                * opens a race with btree_release_folio which ca=
n free a page
> > > > > -                * while we are still filling in all pages for th=
e buffer and
> > > > > -                * we could crash.
> > > > > +                * hasn't been properly inserted in the xarray, t=
his opens a
> > > > > +                * race with btree_release_folio which can free a=
 page while we
> > > > > +                * are still filling in all pages for the buffer =
and we could
> > > > > +                * crash.
> > > > >                  */
> > > > >         }
> > > > >         if (uptodate)
> > > > > @@ -3340,23 +3342,25 @@ struct extent_buffer *alloc_extent_buffer=
(struct btrfs_fs_info *fs_info,
> > > > >         if (page_contig)
> > > > >                 eb->addr =3D folio_address(eb->folios[0]) + offse=
t_in_page(eb->start);
> > > > >  again:
> > > > > -       ret =3D radix_tree_preload(GFP_NOFS);
> > > > > -       if (ret)
> > > > > +       xa_lock_irq(&fs_info->buffer_tree);
> > > > > +       existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> > > > > +                                  start >> fs_info->sectorsize_b=
its, NULL, eb,
> > > > > +                                  GFP_NOFS);
> > > > > +       if (xa_is_err(existing_eb)) {
> > > > > +               ret =3D xa_err(existing_eb);
> > > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > >                 goto out;
> > > > > -
> > > > > -       spin_lock(&fs_info->buffer_lock);
> > > > > -       ret =3D radix_tree_insert(&fs_info->buffer_radix,
> > > > > -                               start >> fs_info->sectorsize_bits=
, eb);
> > > > > -       spin_unlock(&fs_info->buffer_lock);
> > > > > -       radix_tree_preload_end();
> > > > > -       if (ret =3D=3D -EEXIST) {
> > > > > -               ret =3D 0;
> > > > > -               existing_eb =3D find_extent_buffer(fs_info, start=
);
> > > > > -               if (existing_eb)
> > > > > -                       goto out;
> > > > > -               else
> > > > > -                       goto again;
> > > > >         }
> > > > > +       if (existing_eb) {
> > > > > +               if (!atomic_inc_not_zero(&existing_eb->refs)) {
> > > > > +                       xa_unlock_irq(&fs_info->buffer_tree);
> > > > > +                       goto again;
> > > > > +               }
> > > > > +               xa_unlock_irq(&fs_info->buffer_tree);
> > > > > +               goto out;
> > > > > +       }
> > > > > +       xa_unlock_irq(&fs_info->buffer_tree);
> > > > > +
> > > > >         /* add one reference for the tree */
> > > > >         check_buffer_tree_ref(eb);
> > > > >
> > > > > @@ -3426,10 +3430,13 @@ static int release_extent_buffer(struct e=
xtent_buffer *eb)
> > > > >
> > > > >                 spin_unlock(&eb->refs_lock);
> > > > >
> > > > > -               spin_lock(&fs_info->buffer_lock);
> > > > > -               radix_tree_delete_item(&fs_info->buffer_radix,
> > > > > -                                      eb->start >> fs_info->sect=
orsize_bits, eb);
> > > > > -               spin_unlock(&fs_info->buffer_lock);
> > > > > +               /*
> > > > > +                * We're erasing, theoretically there will be no =
allocations, so
> > > > > +                * just use GFP_ATOMIC.
> > > > > +                */
> > > > > +               xa_cmpxchg_irq(&fs_info->buffer_tree,
> > > > > +                              eb->start >> fs_info->sectorsize_b=
its, eb, NULL,
> > > > > +                              GFP_ATOMIC);
> > > >
> > > > This I don't get. Why are we doing a cmp exchange with NULL and not
> > > > removing the entry?
> > > > Swapping with NULL doesn't release the entry, as xarray permits
> > > > storing NULL values. So after a long time releasing extent buffers =
we
> > > > may be holding on to memory unnecessarily.
> > > >
> > > > Why not use xa_erase()?
> > >
> > > Because we may be freeing a buffer that we raced with the insert, so =
we don't
> > > want to replace the winner with NULL.
> > >
> > > Assume that we allocate two buffers for ->start =3D=3D 0, we insert o=
ne buffer into
> > > the xarray, and we free the other.  When we're freeing the other we w=
ill not
> > > delete the xarray entry because it doesn't match the buffer we're rem=
oving.
> >
> > Sure, I get that part, that we don't want to delete an entry if it
> > doesn't match our eb.
> > But if it matches, we store a NULL in it, meaning the xarray entry
> > will remain and potentially hold unnecessary memory for a long time
> > unless that index gets reused soon or there are  other indexes in the
> > region.
> >
> > That was (and is my) my concern.
> >
> > As far as I can see we never do actual index deletions from the
> > xarray, just store NULL values, not allowing the xarray to release
> > space.
>
> From what I gathered xa_erase() and storing a NULL is the same thing?
>
> From the documentation:
>
> You can then set entries using xa_store() and get entries using
> xa_load().  xa_store() will overwrite any entry with the new entry and
> return the previous entry stored at that index.  You can unset entries
> using xa_erase() or by setting the entry to ``NULL`` using xa_store().
> There is no difference between an entry that has never been stored to
> and one that has been erased with xa_erase(); an entry that has most
> recently had ``NULL`` stored to it is also equivalent except if the
> XArray was initialized with ``XA_FLAGS_ALLOC``.
>
> So this seems to say that if we store a ``NULL`` value it's the same as d=
eleting
> it, so we should be fine with this pattern?
>
> Willy am I doing this wrong?  What should I do instead if this is indeed
> incorrect?  Do an xa_load(), check the value, then xa_erase() if it match=
es, all
> under the lock?  Thanks,

Nothing wrong really. Since XA_FLAGS_ALLOC is not being used in this
case the pattern is indeed fine.

I guess you may have missed the Filipe's email agreeing on this:

https://lore.kernel.org/linux-btrfs/CAL3q7H7Tv+MSz9+_TKoVrRNcf6_khOOPaEr21m=
cF=3Df6L2pZc7w@mail.gmail.com/

>
> Josef
>

