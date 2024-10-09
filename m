Return-Path: <linux-btrfs+bounces-8693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5D996D89
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408041F23739
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21219D088;
	Wed,  9 Oct 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmABB8MW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C719AD71
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483667; cv=none; b=FOfTOxBsSAe7+kiO7siA1CGi47ZcKe7trM5w/X4IbPJeGPmduL4Wpi77RVD9tR8RuyKs6XZiCvFaRi2JbjnXCFhFO6EuROZRLbc986rVCVaqbFGm49x62MckQReJl0kzfOn1YkJHwxWJxKckiNRoo3j/SbXm+pkkkFJel3km0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483667; c=relaxed/simple;
	bh=SxafWfTwEl69I9YA3nlrqySfiEI/ln/qkBXjHGcl7Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOPvsVp9kkK5Tuxx1b5tybY4lzhqagsW7Adn9s63aoIezVP5Wv0PwMQ9Hdu9B4U/02oLfX0wHyjdW6CMgwTDhpYZpSi/x0eSFlSN8cJY8nWmAPdWEvr/iUsX+obFFs88zbsvTo1LV6qsAiR2+UVSU8zlCES1R1YEf/da+44klPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmABB8MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F31C4CECE
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483667;
	bh=SxafWfTwEl69I9YA3nlrqySfiEI/ln/qkBXjHGcl7Rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gmABB8MWG9bMONqzYEEk5s5SqHlsQal1zVWIwsMi/8HeSDuT7Jsjj58GV1ZOTKNXo
	 /jcgPFFoU5ZS2PUb+13lOFzi1gzDsKjPAhmtNv/gp+ekollTqMg4OrZlrEit8C25DJ
	 ugk+1MJDVgS8eA+Oyezwz/CM6nMvBKCg8Tpdk1DzwCMFgHk3w8h0QRcQWpEMjZWgAy
	 22BD7WLllI9r2ia1kgv8YRbAbkCcxow9r9uMB0rG2bM3iLdi3GJ/GHSV9tnWrJqLDb
	 m2k2Ogq3mch+AA1ccnzYq0wmFy/vvvjEU+63LEPkPOV3Ez9tTvZpnSwiWG93lrRGs/
	 3JDBZT570RLig==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a993f6916daso594453766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 07:21:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzvmr40/3Nj02dEtAeKnJQ30peZ4URkyhAoaEdv0+sTR9a4pQsy
	wy35VS/oBxczQj8PlxzfqyQV9co2kOxXnt48gcANHFIpWTHpoBQFF+JREPXRxngrTeqyz7mDMnB
	MgyVAsdNQjsAa+ynxq+5k1r2LYzU=
X-Google-Smtp-Source: AGHT+IHhZbiNCFjsBHZS+rOo1OlNqHp8UySRQTgLMCCEuAalmYHEnqiqlFLw8l1iSeLVk5lymYf1cKKrryhUfWdW/gw=
X-Received: by 2002:a17:907:d869:b0:a99:45c5:339 with SMTP id
 a640c23a62f3a-a998d2193c2mr242406966b.32.1728483665957; Wed, 09 Oct 2024
 07:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009020149.23467-1-robbieko@synology.com> <CAL3q7H4sjkQ2-s=jdP-bsF3Jpc7iqGTkOfKe1asfo17+a4Mvgg@mail.gmail.com>
In-Reply-To: <CAL3q7H4sjkQ2-s=jdP-bsF3Jpc7iqGTkOfKe1asfo17+a4Mvgg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Oct 2024 15:20:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6+v9UWjC7O6Ubf73N4MSncgtf8axZui7szB7Y=-iNwQQ@mail.gmail.com>
Message-ID: <CAL3q7H6+v9UWjC7O6Ubf73N4MSncgtf8axZui7szB7Y=-iNwQQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reduce lock contention when eb cache miss for
 btree search
To: robbieko <robbieko@synology.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:18=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Wed, Oct 9, 2024 at 3:09=E2=80=AFAM robbieko <robbieko@synology.com> w=
rote:
> >
> > From: Robbie Ko <robbieko@synology.com>
> >
> > When crawling btree, if an eb cache miss occurs, we change to use
> > the eb read lock and release all previous locks to reduce lock contenti=
on.
> >
> > Because we have prepared the check parameters and the read lock
> > of eb we hold, we can ensure that no race will occur during the check
> > and cause unexpected errors.
> >
> > Signed-off-by: Robbie Ko <robbieko@synology.com>
> > ---
> >  fs/btrfs/ctree.c | 88 ++++++++++++++++++++++++++++--------------------
> >  1 file changed, 52 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 0cc919d15b14..0efbe61497f3 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -1515,12 +1515,12 @@ read_block_for_search(struct btrfs_root *root, =
struct btrfs_path *p,
> >         struct btrfs_tree_parent_check check =3D { 0 };
> >         u64 blocknr;
> >         u64 gen;
> > -       struct extent_buffer *tmp;
> > -       int ret;
> > +       struct extent_buffer *tmp =3D NULL;
> > +       int ret, err;
>
> Please avoid declaring two (or more) variables in the same line. 1 per
> line is prefered for readability and be consistent with this
> function's code.
>
> >         int parent_level;
> > -       bool unlock_up;
> > +       bool create =3D false;
> > +       bool lock =3D false;
> >
> > -       unlock_up =3D ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level =
+ 1]);
> >         blocknr =3D btrfs_node_blockptr(*eb_ret, slot);
> >         gen =3D btrfs_node_ptr_generation(*eb_ret, slot);
> >         parent_level =3D btrfs_header_level(*eb_ret);
> > @@ -1551,52 +1551,66 @@ read_block_for_search(struct btrfs_root *root, =
struct btrfs_path *p,
> >                          */
> >                         if (btrfs_verify_level_key(tmp,
> >                                         parent_level - 1, &check.first_=
key, gen)) {
> > -                               free_extent_buffer(tmp);
> > -                               return -EUCLEAN;
> > +                               ret =3D -EUCLEAN;
> > +                               goto out;
> >                         }
> >                         *eb_ret =3D tmp;
> > -                       return 0;
> > +                       tmp =3D NULL;
> > +                       ret =3D 0;
> > +                       goto out;
>
> By setting tmp to NULL and jumping to the out label, we leak a
> reference on the tmp extent buffer.

Never mind about this one, it's the reference for the caller as we've
set *eb_ret to tmp.

>
> >                 }
> >
> >                 if (p->nowait) {
> > -                       free_extent_buffer(tmp);
> > -                       return -EAGAIN;
> > +                       ret =3D -EAGAIN;
> > +                       btrfs_release_path(p);
>
> To reduce the critical section sizes, please set ret to -EAGAIN after
> releasing the path.
>
> > +                       goto out;
> >                 }
> >
> > -               if (unlock_up)
> > -                       btrfs_unlock_up_safe(p, level + 1);
> > +               ret =3D -EAGAIN;
> > +               btrfs_unlock_up_safe(p, level + 1);
>
> Same here, set ret after the unlocking.
>
> But why set ret to -EAGAIN? Here we know p->nowait is false.
>
> > +               btrfs_tree_read_lock(tmp);
> > +               lock =3D true;
>
> And here, with the same reasoning, set 'lock' to true before calling
> btrfs_tree_read_lock().
>
> > +               btrfs_release_path(p);
> >
> >                 /* now we're allowed to do a blocking uptodate check */
> > -               ret =3D btrfs_read_extent_buffer(tmp, &check);
> > -               if (ret) {
> > -                       free_extent_buffer(tmp);
> > -                       btrfs_release_path(p);
> > -                       return ret;
> > +               err =3D btrfs_read_extent_buffer(tmp, &check);
> > +               if (err) {
> > +                       ret =3D err;
> > +                       goto out;
>
> Why do we need to have this 'err' variable?
> Why not use 'ret' and simplify?
>
> >                 }
> > -
> > -               if (unlock_up)
> > -                       ret =3D -EAGAIN;
> > -
> >                 goto out;
> >         } else if (p->nowait) {
> > -               return -EAGAIN;
> > -       }
> > -
> > -       if (unlock_up) {
> > -               btrfs_unlock_up_safe(p, level + 1);
> >                 ret =3D -EAGAIN;
> > -       } else {
> > -               ret =3D 0;
> > +               btrfs_release_path(p);
>
> Same here, set 'ret' to -EAGAIN after releasing the path.
>
> > +               goto out;
> >         }
> >
> > +       ret =3D -EAGAIN;
> > +       btrfs_unlock_up_safe(p, level + 1);
>
> Same here.
>
> But why set ret to -EAGAIN? Here we know p->nowait is false.
>
> > +
> >         if (p->reada !=3D READA_NONE)
> >                 reada_for_search(fs_info, p, level, slot, key->objectid=
);
> >
> > -       tmp =3D read_tree_block(fs_info, blocknr, &check);
> > +       tmp =3D btrfs_find_create_tree_block(fs_info, blocknr, check.ow=
ner_root, check.level);
> >         if (IS_ERR(tmp)) {
> > +               ret =3D PTR_ERR(tmp);
> > +               tmp =3D NULL;
> >                 btrfs_release_path(p);
> > -               return PTR_ERR(tmp);
> > +               goto out;
> >         }
> > +       create =3D true;
> > +
> > +       btrfs_tree_read_lock(tmp);
> > +       lock =3D true;
>
> Same here, set 'lock' to true before the call to btrfs_tree_read_lock();
>
> > +       btrfs_release_path(p);
> > +
> > +       /* now we're allowed to do a blocking uptodate check */
>
> Please capitalize the first word of a sentence and end the sentence
> with punctuation.
> This is the preferred style and we strive to do that for new comments
> or code that moves comments around.
>
> > +       err =3D btrfs_read_extent_buffer(tmp, &check);
>
> This can block, so if p->nowait at this point we should instead exit
> with -EAGAIN and not call this function.
>
> > +       if (err) {
> > +               ret =3D err;
> > +               goto out;
> > +       }
>
> Same here, no need to use extra variable 'err', can just use 'ret'.
>
> > +
> >         /*
> >          * If the read above didn't mark this buffer up to date,
> >          * it will never end up being up to date.  Set ret to EIO now
> > @@ -1607,11 +1621,13 @@ read_block_for_search(struct btrfs_root *root, =
struct btrfs_path *p,
> >                 ret =3D -EIO;
> >
> >  out:
> > -       if (ret =3D=3D 0) {
> > -               *eb_ret =3D tmp;
> > -       } else {
> > -               free_extent_buffer(tmp);
> > -               btrfs_release_path(p);
> > +       if (tmp) {
> > +               if (lock)
> > +                       btrfs_tree_read_unlock(tmp);
> > +               if (create && ret && ret !=3D -EAGAIN)
> > +                       free_extent_buffer_stale(tmp);
> > +               else
> > +                       free_extent_buffer(tmp);
>
> So in the success case we no longer set *eb_ret to tmp. Why? The
> callers expect that.
>
> Thanks.
>
> >         }
> >
> >         return ret;
> > @@ -2198,7 +2214,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *=
trans, struct btrfs_root *root,
> >                 }
> >
> >                 err =3D read_block_for_search(root, p, &b, level, slot,=
 key);
> > -               if (err =3D=3D -EAGAIN)
> > +               if (err =3D=3D -EAGAIN && !p->nowait)
> >                         goto again;
> >                 if (err) {
> >                         ret =3D err;
> > @@ -2325,7 +2341,7 @@ int btrfs_search_old_slot(struct btrfs_root *root=
, const struct btrfs_key *key,
> >                 }
> >
> >                 err =3D read_block_for_search(root, p, &b, level, slot,=
 key);
> > -               if (err =3D=3D -EAGAIN)
> > +               if (err =3D=3D -EAGAIN && !p->nowait)
> >                         goto again;
> >                 if (err) {
> >                         ret =3D err;
> > --
> > 2.17.1
> >
> >

