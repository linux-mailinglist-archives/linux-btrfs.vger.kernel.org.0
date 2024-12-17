Return-Path: <linux-btrfs+bounces-10468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D6E9F469E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659F1188B55C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7A1DEFEB;
	Tue, 17 Dec 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynn0L+q3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAF1DED49
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425760; cv=none; b=CqKmj0jOC6iPfFn6uUMpkqhdyLLIUty0dKmHf/We+osbfHgYlXrbhxBgsD/74hzKdXiX6hLTDlbTQymmCNtpzsoJ5zWKWhr+1zqoza6CqpZVjgSRNYpzLIBeyAumnutkAeSAlTTII6T/VOeXxInWn5yKIdk2DHiPy0RKrtzQZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425760; c=relaxed/simple;
	bh=hJnuaqxQUydM47hhDxBISMdc+gGzsDKQPXq1FaRljBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfaVQF8ZsyMUrBoliqDTozCvTBMjJBQEp5W60e5extM2bcExfhSJtWUsD655Ff2bG3/j8yha3yapY6L1PIxi7GwZMC6pW6/BDBRvUwMsYXdsDBuKBvW2pL2pG7Fup3eZAD/OgUlTO9yegY0Vb7WCO9/3kErgbbWuOyOcllmOK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynn0L+q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CC6C4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425759;
	bh=hJnuaqxQUydM47hhDxBISMdc+gGzsDKQPXq1FaRljBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ynn0L+q3hHmNbbaXm1SqyJPMrDE0KrRKYlD3SvWGaTTiyzH/Ph6zV4p5MWtqrCuxj
	 rBy2giKRwe/enxU2b0xqULR8y2BftnGewvDybAdphOvqYpET+dTiFLfAyJHXA5F3IE
	 jfn9qQLDPQUsTD9k0nUxJVQMikhLnhPviWQYPWGGKduvXucmHCPcVkszG4CenP3JAd
	 DrxReUEf30Wyh7ci123LP0BgPaElEwezHEYaN1BOB2yJ6Vgx7dcypxqORDYqV38olm
	 75/cenOXShpRUOQjxW6hRhcOuAJ1o8uFZtapDMZQfvsyqTLl63tTqWZmGuwnJ4NVn1
	 qQycspEhMUhFw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6a618981eso814456266b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:55:59 -0800 (PST)
X-Gm-Message-State: AOJu0YxKybuee76J6idtEf9XtxDGdKQ/QD5IjNBF6fUvPR4pn8DoOA3F
	9HghBfVuOuhsswvZzT/S68AQwxKJopyV6r+NsjKFQD13O4SgXWWOHMZy3eZGMiiVwstfHdQ68j3
	ePeoIIqI6qY3jtfD2pkpF3gyQ+zw=
X-Google-Smtp-Source: AGHT+IEUvqCA/FzxnUQVQMzJB+4CCjxr4pqRH6VZpX+60Zlyh1TsWeIe/DdPn6UFUrXvuStz79eLxWTP7WIaymVMJR0=
X-Received: by 2002:a17:907:7842:b0:aa6:9017:eaa5 with SMTP id
 a640c23a62f3a-aab77e7b95fmr1284519466b.37.1734425758013; Tue, 17 Dec 2024
 00:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734368270.git.fdmanana@suse.com> <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <36af89a5-f7e8-4a9f-a7ff-880a84d2fc6d@gmx.com>
In-Reply-To: <36af89a5-f7e8-4a9f-a7ff-880a84d2fc6d@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 08:55:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7pwip+TwR7tTS7cLHz0UWBzfAP9ZpcXN6OGT7O800i3Q@mail.gmail.com>
Message-ID: <CAL3q7H7pwip+TwR7tTS7cLHz0UWBzfAP9ZpcXN6OGT7O800i3Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into fs.c
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:26=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/12/17 03:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The ctree module is about the implementation of the btree data structur=
e
> > and not a place holder for generic filesystem things like the csum
> > algorithm details. Move the functions related to the csum algorithm
> > details away from ctree.c and into fs.c, which is a far better place fo=
r
> > them. Also fix missing punctuation in comments and change one multiline
> > comment to a single line comment since everything fits in under 80
> > characters.
> >
> > For some reason this also sligthly reduces the module's size.
> >
> > Before this change:
> >
> >    $ size fs/btrfs/btrfs.ko
> >       text       data     bss     dec     hex filename
> >    1782126     161045   16920 1960091  1de89b fs/btrfs/btrfs.ko
> >
> > After this change:
> >
> >    $ size fs/btrfs/btrfs.ko
> >       text       data     bss     dec     hex filename
> >    1782094     161045   16920 1960059  1de87b fs/btrfs/btrfs.ko
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c | 51 -----------------------------------------------=
-
> >   fs/btrfs/ctree.h |  6 ------
> >   fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> >   fs/btrfs/fs.h    |  6 ++++++
> >   4 files changed, 55 insertions(+), 57 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 99a58ede387e..c93f52a30a16 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -37,19 +37,6 @@ static int push_node_left(struct btrfs_trans_handle =
*trans,
> >   static int balance_node_right(struct btrfs_trans_handle *trans,
> >                             struct extent_buffer *dst_buf,
> >                             struct extent_buffer *src_buf);
> > -
> > -static const struct btrfs_csums {
> > -     u16             size;
> > -     const char      name[10];
> > -     const char      driver[12];
> > -} btrfs_csums[] =3D {
> > -     [BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
> > -     [BTRFS_CSUM_TYPE_XXHASH] =3D { .size =3D 8, .name =3D "xxhash64" =
},
> > -     [BTRFS_CSUM_TYPE_SHA256] =3D { .size =3D 32, .name =3D "sha256" }=
,
> > -     [BTRFS_CSUM_TYPE_BLAKE2] =3D { .size =3D 32, .name =3D "blake2b",
> > -                                  .driver =3D "blake2b-256" },
> > -};
> > -
> >   /*
> >    * The leaf data grows from end-to-front in the node.  this returns t=
he address
> >    * of the start of the last item, which is the stop of the leaf data =
stack.
> > @@ -148,44 +135,6 @@ static inline void copy_leaf_items(const struct ex=
tent_buffer *dst,
> >                             nr_items * sizeof(struct btrfs_item));
> >   }
> >
> > -/* This exists for btrfs-progs usages. */
> > -u16 btrfs_csum_type_size(u16 type)
> > -{
> > -     return btrfs_csums[type].size;
> > -}
> > -
> > -int btrfs_super_csum_size(const struct btrfs_super_block *s)
> > -{
> > -     u16 t =3D btrfs_super_csum_type(s);
> > -     /*
> > -      * csum type is validated at mount time
> > -      */
> > -     return btrfs_csum_type_size(t);
> > -}
> > -
> > -const char *btrfs_super_csum_name(u16 csum_type)
> > -{
> > -     /* csum type is validated at mount time */
> > -     return btrfs_csums[csum_type].name;
> > -}
> > -
> > -/*
> > - * Return driver name if defined, otherwise the name that's also a val=
id driver
> > - * name
> > - */
> > -const char *btrfs_super_csum_driver(u16 csum_type)
> > -{
> > -     /* csum type is validated at mount time */
> > -     return btrfs_csums[csum_type].driver[0] ?
> > -             btrfs_csums[csum_type].driver :
> > -             btrfs_csums[csum_type].name;
> > -}
> > -
> > -size_t __attribute_const__ btrfs_get_num_csums(void)
> > -{
> > -     return ARRAY_SIZE(btrfs_csums);
> > -}
> > -
> >   struct btrfs_path *btrfs_alloc_path(void)
> >   {
> >       might_sleep();
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 2c341956a01c..a1bab0b3f193 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -756,12 +756,6 @@ static inline bool btrfs_is_data_reloc_root(const =
struct btrfs_root *root)
> >       return root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJEC=
TID;
> >   }
> >
> > -u16 btrfs_csum_type_size(u16 type);
> > -int btrfs_super_csum_size(const struct btrfs_super_block *s);
> > -const char *btrfs_super_csum_name(u16 csum_type);
> > -const char *btrfs_super_csum_driver(u16 csum_type);
> > -size_t __attribute_const__ btrfs_get_num_csums(void);
> > -
> >   /*
> >    * We use folio flag owner_2 to indicate there is an ordered extent w=
ith
> >    * unfinished IO.
> > diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> > index 31c1648bc0b4..3756a3b9c9da 100644
> > --- a/fs/btrfs/fs.c
> > +++ b/fs/btrfs/fs.c
> > @@ -5,6 +5,55 @@
> >   #include "fs.h"
> >   #include "accessors.h"
> >
> > +static const struct btrfs_csums {
> > +     u16             size;
> > +     const char      name[10];
> > +     const char      driver[12];
> > +} btrfs_csums[] =3D {
> > +     [BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
> > +     [BTRFS_CSUM_TYPE_XXHASH] =3D { .size =3D 8, .name =3D "xxhash64" =
},
> > +     [BTRFS_CSUM_TYPE_SHA256] =3D { .size =3D 32, .name =3D "sha256" }=
,
> > +     [BTRFS_CSUM_TYPE_BLAKE2] =3D { .size =3D 32, .name =3D "blake2b",
> > +                                  .driver =3D "blake2b-256" },
> > +};
> > +
> > +/* This exists for btrfs-progs usages. */
> > +u16 btrfs_csum_type_size(u16 type)
> > +{
> > +     return btrfs_csums[type].size;
> > +}
> > +
> > +int btrfs_super_csum_size(const struct btrfs_super_block *s)
> > +{
> > +     u16 t =3D btrfs_super_csum_type(s);
> > +
> > +     /* csum type is validated at mount time. */
> > +     return btrfs_csum_type_size(t);
> > +}
> > +
> > +const char *btrfs_super_csum_name(u16 csum_type)
> > +{
> > +     /* csum type is validated at mount time. */
> > +     return btrfs_csums[csum_type].name;
> > +}
> > +
> > +/*
> > + * Return driver name if defined, otherwise the name that's also a val=
id driver
> > + * name.
> > + */
> > +const char *btrfs_super_csum_driver(u16 csum_type)
> > +{
> > +     /* csum type is validated at mount time */
> > +     return btrfs_csums[csum_type].driver[0] ?
> > +             btrfs_csums[csum_type].driver :
> > +             btrfs_csums[csum_type].name;
> > +}
> > +
> > +size_t __attribute_const__ btrfs_get_num_csums(void)
> > +{
> > +     return ARRAY_SIZE(btrfs_csums);
> > +}
> > +
>
> I'm wondering if those simple functions can be converted to inline.
>
> Although btrfs_csums[] array has to be put inside fs.c, those functions
> seems be fine defined as inline ones inside the header.

Yes, the array being inside fs.c makes it hard to inline in the header.

Keep in mind that this is a change just to move things around, the
goal is not to change the implementation or optimize anything.
Plus it's not like these functions are called in hot code paths where
saving a function call has any significant impact.

Thanks.

>
> Otherwise looks good to me.
>
> Thanks,
> Qu
> >   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> >                            const char *name)
> >   {
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 79a1a3d6f04d..b05f2af97140 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -982,6 +982,12 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs=
_info,
> >
> >   int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args=
 *vol_args);
> >
> > +u16 btrfs_csum_type_size(u16 type);
> > +int btrfs_super_csum_size(const struct btrfs_super_block *s);
> > +const char *btrfs_super_csum_name(u16 csum_type);
> > +const char *btrfs_super_csum_driver(u16 csum_type);
> > +size_t __attribute_const__ btrfs_get_num_csums(void);
> > +
> >   /* Compatibility and incompatibility defines */
> >   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> >                            const char *name);
>

