Return-Path: <linux-btrfs+bounces-17295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64504BAE065
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAEF1943379
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D30309DCC;
	Tue, 30 Sep 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnIsQFqh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF944501A
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248771; cv=none; b=rShDvXli1RivCryJiYsf/MFTDz7HBKCCMMkx+GiP1GB5cBX8KjH/xpbOFcTEKbBIJm+Ycoa/ekyg1mOrS/HdN8DMwlKd0KAR6f3hnMvpLku1B245SDxWlL3+PxrYofAibaAJ9VuBwGKWTs/yZR/MSg9Rq+UDqij4gHsJKFbs5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248771; c=relaxed/simple;
	bh=Nblw4AibWIEoUqbfoaJhynNC/tdUWYxkcN0099Tf8ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAx6bPCVXQJsUWoRLS/wirxhmpAH6awY5UkbQ4+t7HbotwMmUswit7oo+ngIIicvEHJqnhrvAPKHL/DM1MRYRONkCW+nFvIB38FoPNh7gqgtNIpnifle3EJ6ocj9OECKXhRvFKFIucdDkHmdWLM9CAPXzc4jWVDdGG8qAh+eNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnIsQFqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93228C116B1
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759248770;
	bh=Nblw4AibWIEoUqbfoaJhynNC/tdUWYxkcN0099Tf8ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnIsQFqhfZE3MtEq8ySFxuy21GVL0glVwR5fCGUz+2ju/EGbfpthXLwc91+rXe1A6
	 l5L7MTmgo2bLe6dpfAeYE+79PALph5VZOlZ2+6uv53sLwzWT9sTVwKhxL3BcpkII58
	 gm2zw8NGzgEtC4VFg4njtAEYfWL8byQC2CG3U1JH/JWkcg1mM5RmniCEoADN/POPuI
	 bFYSrkJDCtFhTOVPQlLlo3sCgu5jHBFZAUOAq6xdvrlRybhiqSx/MyE5lF1tCLUgv/
	 800fSGuVKndQ1Ab91iB9ZTfO8P2mVorLcuZP7YGCNHX2otfJinxtnAg9Lvuq69rQAo
	 1DT3JolK15vSg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3727611c1bso1142550466b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 09:12:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1tZ4GNsd3cltp5Y67108xLSwYOmqe2wy9x0Z9WWKo2QMBq+Sk
	xF9TI9JuCHI2kIYRL1iM5+xXlgszXHhuBnamKcv+HOv4DyS88VzaaLKlufMSNQjghczIkXZuk8B
	ZFoKEjGhceA4Drehs/eLmT5TTi7nqXNE=
X-Google-Smtp-Source: AGHT+IFeoCpbWP3ThLVAEfTGy6k0CDNkgrRJNIwAjFgT0cWKAXkHAfADEnZvXv1qYU2FTnnSwHG6gfByVzR49XAz69A=
X-Received: by 2002:a17:907:3f9e:b0:b3c:82d5:211c with SMTP id
 a640c23a62f3a-b46e5d3b5famr22811166b.27.1759248769081; Tue, 30 Sep 2025
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930130452.297576-1-mssola@mssola.com> <CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
In-Reply-To: <CAL3q7H66AOc_hbXX_PN-DGP5fT36NnxE7p4j2LqjPXyRaOu=iA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 30 Sep 2025 17:12:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4ijVSVZXahhN85D0LBSAJZPhP1-sqqFQXasdQwfjnyuQ@mail.gmail.com>
X-Gm-Features: AS18NWC1Ybdi1fJfuTJIjXwWHhaH18_0HdJFWoAa0CRK2V1aXbRQACCA1iHEObI
Message-ID: <CAL3q7H4ijVSVZXahhN85D0LBSAJZPhP1-sqqFQXasdQwfjnyuQ@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: prevent a double kfree on delayed-ref
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	fdmanana@suse.com, wqu@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 5:07=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Tue, Sep 30, 2025 at 2:05=E2=80=AFPM Miquel Sabat=C3=A9 Sol=C3=A0 <mss=
ola@mssola.com> wrote:
> >
> > In the previous code it was possible to incur into a double kfree()
> > scenario when calling 'add_delayed_ref_head'. This could happen if the
> > record was reported to already exist in the
> > 'btrfs_qgroup_trace_extent_nolock' call, but then there was an error
> > later on 'add_delayed_ref_head'. In this case, since
> > 'add_delayed_ref_head' returned an error, the caller went to free the
> > record. Since 'add_delayed_ref_head' couldn't set this kfree'd pointer
> > to NULL, then kfree() would have acted on a non-NULL 'record' object
> > which was pointing to memory already freed by the callee.
> >
> > The problem comes from the fact that the responsibility to kfree the
> > object is on both the caller and the callee at the same time. Hence, th=
e
> > fix for this is to shift the ownership of the 'qrecord' object out of
> > the 'add_delayed_ref_head'. That is, we will never attempt to kfree()
> > the given object inside of this function, and will expect the caller to
> > act on the 'qrecord' object on its own. The only exception where the
> > 'qrecord' object cannot be kfree'd is if it was inserted into the
> > tracing logic, for which we already have the 'qrecord_inserted_ret'
> > boolean to account for this. Hence, the caller has to kfree the object
> > only if 'add_delayed_ref_head' reports not to have inserted it on the
> > tracing logic.
> >
> > As a side-effect of the above, we must guarantee that
> > 'qrecord_inserted_ret' is properly initialized at the start of the
> > function, not at the end, and then set when an actual insert
> > happens. This way we avoid 'qrecord_inserted_ret' having an invalid
> > value on an early exit.
> >
> > The documentation from the 'add_delayed_ref_head' has also been updated
> > to reflect on the exact ownership of the 'qrecord' object.
> >
> > Fixes: 6ef8fbce0104 ("btrfs: fix missing error handling when adding del=
ayed ref with qgroups enabled")
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> > ---
> >  fs/btrfs/delayed-ref.c | 39 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index 481802efaa14..bc61e0eacc69 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -798,10 +798,14 @@ static void init_delayed_ref_head(struct btrfs_de=
layed_ref_head *head_ref,
> >  }
> >
> >  /*
> > - * helper function to actually insert a head node into the rbtree.
> > + * Helper function to actually insert a head node into the rbtree.
>
> Since you are updating this line just to capitalize the first word,
> you might as well replace rbtree with xarray as we don't use rbtree
> anymore.
>
> >   * this does all the dirty work in terms of maintaining the correct
> >   * overall modification count.
> >   *
> > + * The caller is responsible for calling kfree() on @qrecord. More spe=
cifically,
> > + * if this function reports that it did not insert it as noted in
> > + * @qrecord_inserted_ret, then it's safe to call kfree() on it.
> > + *
> >   * Returns an error pointer in case of an error.
> >   */
> >  static noinline struct btrfs_delayed_ref_head *
> > @@ -814,7 +818,14 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
> >         struct btrfs_delayed_ref_head *existing;
> >         struct btrfs_delayed_ref_root *delayed_refs;
> >         const unsigned long index =3D (head_ref->bytenr >> fs_info->sec=
torsize_bits);
> > -       bool qrecord_inserted =3D false;
> > +
> > +       /*
> > +        * If 'qrecord_inserted_ret' is provided, then the first thing =
we need
> > +        * to do is to initialize it to false just in case we have an e=
xit
> > +        * before trying to insert the record.
> > +        */
> > +       if (qrecord_inserted_ret)
> > +               *qrecord_inserted_ret =3D false;
> >
> >         delayed_refs =3D &trans->transaction->delayed_refs;
> >         lockdep_assert_held(&delayed_refs->lock);
> > @@ -833,6 +844,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *tr=
ans,
> >
> >         /* Record qgroup extent info if provided */
> >         if (qrecord) {
> > +               /*
> > +                * Setting 'qrecord' but not 'qrecord_inserted_ret' wil=
l likely
> > +                * result in a memory leakage.
> > +                */
> > +               WARN_ON(!qrecord_inserted_ret);
>
> For this sort of mandatory stuff, we use assertions, not warnings:
>
> ASSERT(qrecord_insert_ret !=3D NULL);
>
>
> > +
> >                 int ret;
> >
> >                 ret =3D btrfs_qgroup_trace_extent_nolock(fs_info, delay=
ed_refs, qrecord,
> > @@ -840,12 +857,10 @@ add_delayed_ref_head(struct btrfs_trans_handle *t=
rans,
> >                 if (ret) {
> >                         /* Clean up if insertion fails or item exists. =
*/
> >                         xa_release(&delayed_refs->dirty_extents, index)=
;
> > -                       /* Caller responsible for freeing qrecord on er=
ror. */
> >                         if (ret < 0)
> >                                 return ERR_PTR(ret);
> > -                       kfree(qrecord);
> > -               } else {
> > -                       qrecord_inserted =3D true;
> > +               } else if (qrecord_inserted_ret) {
> > +                       *qrecord_inserted_ret =3D true;
> >                 }
> >         }
> >
> > @@ -888,8 +903,6 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
> >                 delayed_refs->num_heads++;
> >                 delayed_refs->num_heads_ready++;
> >         }
> > -       if (qrecord_inserted_ret)
> > -               *qrecord_inserted_ret =3D qrecord_inserted;
> >
> >         return head_ref;
> >  }
> > @@ -1049,6 +1062,14 @@ static int add_delayed_ref(struct btrfs_trans_ha=
ndle *trans,
> >                 xa_release(&delayed_refs->head_refs, index);
> >                 spin_unlock(&delayed_refs->lock);
> >                 ret =3D PTR_ERR(new_head_ref);
> > +
> > +               /*
> > +                * It's only safe to call kfree() on 'qrecord' if
> > +                * 'add_delayed_ref_head' has _not_ inserted it for
>
> The notation we use for function names is  function_name(), not 'function=
_name'.
>
> Otherwise it looks good, thanks.

Also, the subject should just be "btrfs: ....", no need to add extra
"fs: " prefix - we never do that.
>
> > +                * tracing. Otherwise we need to handle this here.
> > +                */
> > +               if (!qrecord_reserved || qrecord_inserted)
> > +                       goto free_head_ref;
> >                 goto free_record;
> >         }
> >         head_ref =3D new_head_ref;
> > @@ -1071,6 +1092,8 @@ static int add_delayed_ref(struct btrfs_trans_han=
dle *trans,
> >
> >         if (qrecord_inserted)
> >                 return btrfs_qgroup_trace_extent_post(trans, record, ge=
neric_ref->bytenr);
> > +
> > +       kfree(record);
> >         return 0;
> >
> >  free_record:
> > --
> > 2.51.0
> >
> >

