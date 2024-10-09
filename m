Return-Path: <linux-btrfs+bounces-8728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A420996F7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAE41F221DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99111E32BB;
	Wed,  9 Oct 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5KZZacK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B31E32DC
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486631; cv=none; b=n0nHuj78lyCY7S+bdFeUHxXm0Q2gr/xJmqvGcVW7WMYvCEJlLy7Op1VzCJlqyixq5I7NXKNATTQ7oTe82gyRCgrb9RHThmJrvK6WShSoqc+est5cGofW5VuaKPPW3xL7KXEjwsZpzDKvefRSj6+3Xdd53Ap9t0NdHJKHUhc9Vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486631; c=relaxed/simple;
	bh=9RtjoNsCFoyAzTw3fL96naAYKHnJMvWaYteLNNqnBpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrJkcjEPMZPyajGz7U513jnK6PyARnf7bquw4wgjntiAaQePO0LPy4yTOt/Vr9xGrXq+DpZ4H+693QWCs2kwaNhmxWsWEvB2dhiI/kHWfbWfKMacU+ohefvD+/tgI9i/A01HaaMV3o2JexwD5JU3t0rnAiQ30FPVO/PU8dWCnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5KZZacK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7188EC4CECF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486631;
	bh=9RtjoNsCFoyAzTw3fL96naAYKHnJMvWaYteLNNqnBpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L5KZZacKhZFoRxaVdC5BaZW6lSserA9r7bhOISRT4zCD1U+dTE6iPrfaMRkA+Rh94
	 C0r08Artrht4GlztaqKOkFBiV+9vJoLVfgALsriwm21JSjlEkTVC5iiMXSqQiuIhqD
	 IQWjVPtCnPTXjHO+9IDn2EKwepvdf4ARtxivGv80wZPMLqSbcGzkyZgdocz3sd3V3c
	 T+6CqVzHQEfWZd3tQ8clv85vVRT0eCOPE6fdaTufl1gIAxCnu/S6QCYMajQytAHtoU
	 UgKW2V6Ut+M4pAwpnlUjo65MJwTBpROQDLQnTaQUDi219iboOkt11KUDUbU4pyQ89j
	 fppZELAQMk6ew==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a995f56ea2dso479316366b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:10:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyFozH07+JNxPLZvSsE3Ca6GQqOj+WRcC5uPOFGZrD0QhdUXKip
	bfF9NdbFPEDO7zH+cWXZJDCTrGFB+3hQzS2sUr+NYFHPNaMdDIam69gJqGLV8BzoqWk80gmUxW0
	+l43ARy3J2swBC35l/3D09PPDbNs=
X-Google-Smtp-Source: AGHT+IE9nUh05E3g1BS2Y8SC0TxN87G8qJfD9yluIXePnzvDio/YV+aZW0R5m5/EGeKr5xgmIGsO6Yp/Qi/2H4U0/9A=
X-Received: by 2002:a17:907:7f94:b0:a7a:aa35:408c with SMTP id
 a640c23a62f3a-a998d10df8bmr235407066b.8.1728486629879; Wed, 09 Oct 2024
 08:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009020149.23467-1-robbieko@synology.com> <CAL3q7H4sjkQ2-s=jdP-bsF3Jpc7iqGTkOfKe1asfo17+a4Mvgg@mail.gmail.com>
In-Reply-To: <CAL3q7H4sjkQ2-s=jdP-bsF3Jpc7iqGTkOfKe1asfo17+a4Mvgg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Oct 2024 16:09:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4sdxdnLx9uaSDrhVpJCdsik+ZPVCH4cjeZKCBKY_ohzw@mail.gmail.com>
Message-ID: <CAL3q7H4sdxdnLx9uaSDrhVpJCdsik+ZPVCH4cjeZKCBKY_ohzw@mail.gmail.com>
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

Nevermind this is because of the unconditional unlock now.

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

Nevermind this is because of the unconditional unlock now.

In both cases we still don't need the 'err' variable.
Just set 'ret' to -EAGAIN if btrfs_find_create_tree_block() below
doesn't return an error and btrfs_read_extent_buffer() below and above
don't return an error.

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

Ok, it's because of the -EAGAIN due to having the unconditional unlock now.

And btw, have you observed any case where this improved anything? Any
benchmarks?

I can't see how this can make anything better because this function is
never called for a root node, and therefore level + 1 <
BTRFS_MAX_LEVEL.

But there is one case where this patch causes unnecessary path
releases and makes the caller retry a search:
when none of the levels above were locked. That's why we had the
following expression before:

unlock_up =3D ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);

So we wouldn't make the caller retry the search if upper levels aren't
locked or p->skip_locking =3D=3D 1.
But now after this patch we make the caller retry the search in that case.

Thanks.

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

