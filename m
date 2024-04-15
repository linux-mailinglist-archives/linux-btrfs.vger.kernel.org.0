Return-Path: <linux-btrfs+bounces-4262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A688A4F61
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA9B1C20D26
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365971725;
	Mon, 15 Apr 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN1l4F+W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4470CD7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185054; cv=none; b=T/4+TZsb9qKJYQVneBs+FhIAiilF9iJk0WbgJwsezGSrsf5YqexlAxPopGAJV4IjvYGoT2PQtTyUNROr0zVcvjswxl4NCMcuI9G+PbmSNh5pf1jditBWw2mJ9sMkpJIs8Iy8q46PvU9X+PHbuaGLTxNGvR/MdKGD/fCjHM8/tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185054; c=relaxed/simple;
	bh=GO/NF08OEs+Vp2lw6bwJbmaUq+C7SElgBfrizeZMDww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYePb6v1Hm2KjYsXyRKs3OumzYk+8W/IoiJvrhgdpBm+c7OBGr/XLgnOZJrlDIKggQT/kX4XP0a7u6JGEqMvKrh3w6Yk4fDxguGzDDxne9GA1U+roml7KvYKLwc/gPzOE4CC/w4VxH4Xcx7RIzsmOIOSaISxc14NgxMMSgkvGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN1l4F+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4094AC32783
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185054;
	bh=GO/NF08OEs+Vp2lw6bwJbmaUq+C7SElgBfrizeZMDww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eN1l4F+WghCb1ys2bzDYOzyZ0L39D4GSMiAAcheO6+hLgcsRH84w3IOvx/K76Qva8
	 zDd4JAFjRjHUboyAqH4mVDEBNks0NK7LEMozhacCQOYM5tqKRlh/1MeLFO8uL7CtMl
	 5+71Exg6NyXXFFZZtfE5dKQT3CCByVnB7fV69lHBT+HOnhiVMO4nCTXWUc6+NhpXoU
	 QaCqJ0r0gGzACM0CGEb6joOuyWw2huWvd6ShNOf77GthQWYA22okshqLuciNBLdStj
	 rIFzrUIaMFa8d4tmgyuIyc6yuoa9wHmIAnb8GPy37DLRVkabKDYvxpln20Vln0h84a
	 qYIMlyiRL755Q==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a526d0b2349so100745066b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:44:14 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz3hxMdPkmbbAtEd2ZSj/hs9nINsK4VXe6edj6NL0XMiHthVpRq
	x/xYcSbKsdiqdF5RNGzqEBzu5CYzGE2f6X2/l1YDfHIeGdQv387ie8WCTqClid9vqaZ+UbAm7yP
	bKG+vimnxnERGC5tfHBcQ/vPZcNU=
X-Google-Smtp-Source: AGHT+IGY1nfekRIbGRFSP4Ql81MPj9NEMOIud/0184wce4YhwCR1c8llMgkO8cIlJxxC4vwbZ/P36IcyKfVFu0z/SlI=
X-Received: by 2002:a17:906:514:b0:a52:6946:c0ae with SMTP id
 j20-20020a170906051400b00a526946c0aemr1955668eja.46.1713185052693; Mon, 15
 Apr 2024 05:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <f31af8b1283c8dab1f07b0fb7a9617f97f991b7f.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <f31af8b1283c8dab1f07b0fb7a9617f97f991b7f.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:43:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7BoRSkRs06cJPJi43HrW6RZqRN0-LmE7xb52-Ht_=KCg@mail.gmail.com>
Message-ID: <CAL3q7H7BoRSkRs06cJPJi43HrW6RZqRN0-LmE7xb52-Ht_=KCg@mail.gmail.com>
Subject: Re: [PATCH 05/19] btrfs: pass btrfs_ref to init_delayed_ref_common
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We're extracting all of these values from the btrfs_ref we passed in
> already, just pass the btrfs_ref through to init_delayed_ref_common and
> get the values directly from the struct.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.c | 29 ++++++++---------------------
>  fs/btrfs/delayed-ref.h | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index c6a1b6938654..f5e4a64283e4 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -985,24 +985,24 @@ add_delayed_ref_head(struct btrfs_trans_handle *tra=
ns,
>   */
>  static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
>                                     struct btrfs_delayed_ref_node *ref,
> -                                   u64 bytenr, u64 num_bytes, u64 ref_ro=
ot,
> -                                   int action, u8 ref_type)
> +                                   struct btrfs_ref *generic_ref)
>  {
> +       int action =3D generic_ref->action;
>         u64 seq =3D 0;
>
>         if (action =3D=3D BTRFS_ADD_DELAYED_EXTENT)
>                 action =3D BTRFS_ADD_DELAYED_REF;
>
> -       if (is_fstree(ref_root))
> +       if (is_fstree(generic_ref->ref_root))
>                 seq =3D atomic64_read(&fs_info->tree_mod_seq);
>
>         refcount_set(&ref->refs, 1);
> -       ref->bytenr =3D bytenr;
> -       ref->num_bytes =3D num_bytes;
> +       ref->bytenr =3D generic_ref->bytenr;
> +       ref->num_bytes =3D generic_ref->len;
>         ref->ref_mod =3D 1;
>         ref->action =3D action;
>         ref->seq =3D seq;
> -       ref->type =3D ref_type;
> +       ref->type =3D btrfs_ref_type(generic_ref);
>         RB_CLEAR_NODE(&ref->ref_node);
>         INIT_LIST_HEAD(&ref->add_list);
>  }
> @@ -1064,7 +1064,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         u64 bytenr =3D generic_ref->bytenr;
>         u64 num_bytes =3D generic_ref->len;
>         u64 parent =3D generic_ref->parent;
> -       u8 ref_type;
>
>         is_system =3D (generic_ref->ref_root =3D=3D BTRFS_CHUNK_TREE_OBJE=
CTID);
>
> @@ -1090,13 +1089,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>
>         ref =3D btrfs_delayed_node_to_tree_ref(node);
>
> -       if (parent)
> -               ref_type =3D BTRFS_SHARED_BLOCK_REF_KEY;
> -       else
> -               ref_type =3D BTRFS_TREE_BLOCK_REF_KEY;
> -
> -       init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
> -                               generic_ref->ref_root, action, ref_type);
> +       init_delayed_ref_common(fs_info, node, generic_ref);
>         ref->root =3D generic_ref->ref_root;
>         ref->parent =3D parent;
>         ref->level =3D level;
> @@ -1159,7 +1152,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>         u64 ref_root =3D generic_ref->ref_root;
>         u64 owner =3D generic_ref->data_ref.ino;
>         u64 offset =3D generic_ref->data_ref.offset;
> -       u8 ref_type;
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> @@ -1168,12 +1160,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>
>         ref =3D btrfs_delayed_node_to_data_ref(node);
>
> -       if (parent)
> -               ref_type =3D BTRFS_SHARED_DATA_REF_KEY;
> -       else
> -               ref_type =3D BTRFS_EXTENT_DATA_REF_KEY;
> -       init_delayed_ref_common(fs_info, node, bytenr, num_bytes, ref_roo=
t,
> -                               action, ref_type);
> +       init_delayed_ref_common(fs_info, node, generic_ref);
>         ref->root =3D ref_root;
>         ref->parent =3D parent;
>         ref->objectid =3D owner;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index bf2916906bb8..83fcb32715a4 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -421,4 +421,23 @@ btrfs_delayed_data_ref_to_node(struct btrfs_delayed_=
data_ref *ref)
>         return container_of(ref, struct btrfs_delayed_ref_node, data_ref)=
;
>  }
>
> +static inline u8 btrfs_ref_type(struct btrfs_ref *ref)
> +{
> +       ASSERT(ref->type !=3D BTRFS_REF_NOT_SET);

Maybe:

ASSERT(ref->type =3D=3D BTRFS_REF_DATA || ref->type =3D=3D BTRFS_REF_METADA=
TA);

To catch any other unexpected value.

Other than that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +       if (ref->type =3D=3D BTRFS_REF_DATA) {
> +               if (ref->parent)
> +                       return BTRFS_SHARED_DATA_REF_KEY;
> +               else
> +                       return BTRFS_EXTENT_DATA_REF_KEY;
> +       } else {
> +               if (ref->parent)
> +                       return BTRFS_SHARED_BLOCK_REF_KEY;
> +               else
> +                       return BTRFS_TREE_BLOCK_REF_KEY;
> +       }
> +
> +       return 0;
> +}
> +
>  #endif
> --
> 2.43.0
>
>

