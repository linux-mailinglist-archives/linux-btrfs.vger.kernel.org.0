Return-Path: <linux-btrfs+bounces-4269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE738A50CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7070C28CE59
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BD74437;
	Mon, 15 Apr 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBZJEkrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098071B48
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185826; cv=none; b=tfg0SJgdTwvUj6ZLbO06TcfWychveW1XyTinV96US7seAmsLcuNW4lHwO9mPSecZ1OeNM5eRNbFLLhBP7em/K+F6pgMiu6S7yX94rfzxQOdLb7M7RlI2Qi2McptI7og+RvBYHqQCBlMkk/v17N5pqko7VjZMl1jE6Cab1IbLpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185826; c=relaxed/simple;
	bh=sA+JeUpoGyA39b15ZQIA9Hzpp291vOM6yI+Fiv3Pyos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpyx3uvj+ejpkDFaSyNGT97ogAYihTNHI3my3+poiL5eCXvO2bqksBb/iiMXN93AdF+Z1E/fReOjQtODxzUvAh8Y8nycwv8kslWUOmmX14aHgH1kpXm5kX94XbNmYhIBSA2DR3x4IrfYxD2FV0NYFeRvBz7BJAmVhNrdVrFJshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBZJEkrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3ECC113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185825;
	bh=sA+JeUpoGyA39b15ZQIA9Hzpp291vOM6yI+Fiv3Pyos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CBZJEkrzjoOCuh+pG61zuLcr9U5WumS+yWpF3tDA3wtgZb3vgftg4R5W+uCNNPG9V
	 p822/xQkksO8GasunduD3gThWv9TZJbU2ovAaAOQb/B32D+BFM9P87/lz7e+dWlbNw
	 7V8aJX+4Ds7/FbUSLxiipWCLvbMMFyHljgtMROoPaRE/X1q2UWhppdZd8wP4c8QqjQ
	 gZA0NF3RNiBwlol27TW51Dl4GQEbT2/XPQ3Xq3Um/AEDz9Dg/HLfySzCosCFcKxGx6
	 05+I3FHhItFXyu3KRBwIY7U4m3dSlCDSwH/ixr9+YM6orKuTGvTkfpmIVYzbphcRSA
	 tZN8j1iAUtLAQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4388732a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:57:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBkNQnj8HZ4+6K+e1gNHf5VuMA6OaBjNd3otwBlbrghMmXMQgg
	hx1AMvpWbXj0BMXL5yK8txtcBm2oriA7KASqvZIA1QkQXRVGhGBb/pmvZaYHQh0YbHsH0TjerYc
	3L0XfPYTaghuSTI3YCdFqIqRhhpY=
X-Google-Smtp-Source: AGHT+IEcmfqcSkOgfOxIPfFlSFv3HXFLm4ByfVAb8OXnGbKJdFUYCNQj9eJVJZgDbAB3Q4kf4RvfqJDwBSAHwlw2900=
X-Received: by 2002:a17:906:2a5a:b0:a51:80d0:c596 with SMTP id
 k26-20020a1709062a5a00b00a5180d0c596mr5430584eje.18.1713185824122; Mon, 15
 Apr 2024 05:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <b5d8f7677e5200ca546113804816fa811b502111.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <b5d8f7677e5200ca546113804816fa811b502111.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:56:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Dvwb0OtRyZGHA4Pb1sfLLjnyYo+8c8GxkTMf2VBCL1g@mail.gmail.com>
Message-ID: <CAL3q7H6Dvwb0OtRyZGHA4Pb1sfLLjnyYo+8c8GxkTMf2VBCL1g@mail.gmail.com>
Subject: Re: [PATCH 11/19] btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> These two members are shared by both the tree refs and data refs, so
> move them into btrfs_delayed_ref_node proper.  This allows us to greatly
> simplify the comparison code, as the shared refs always only sort on
> parent, and the non shared refs always sort first on ref_root, and then
> only data refs sort on their specific fields.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/backref.c           | 12 ++----
>  fs/btrfs/delayed-ref.c       | 82 ++++++++++++------------------------
>  fs/btrfs/delayed-ref.h       | 13 ++++--
>  fs/btrfs/extent-tree.c       | 18 ++++----
>  include/trace/events/btrfs.h |  8 ++--
>  5 files changed, 52 insertions(+), 81 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index c1e6a5bbeeaf..98a0cf68d198 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -928,7 +928,7 @@ static int add_delayed_refs(const struct btrfs_fs_inf=
o *fs_info,
>                         }
>
>                         ref =3D btrfs_delayed_node_to_tree_ref(node);
> -                       ret =3D add_indirect_ref(fs_info, preftrees, ref-=
>root,
> +                       ret =3D add_indirect_ref(fs_info, preftrees, node=
->ref_root,
>                                                key_ptr, ref->level + 1,
>                                                node->bytenr, count, sc,
>                                                GFP_ATOMIC);
> @@ -941,7 +941,7 @@ static int add_delayed_refs(const struct btrfs_fs_inf=
o *fs_info,
>                         ref =3D btrfs_delayed_node_to_tree_ref(node);
>
>                         ret =3D add_direct_ref(fs_info, preftrees, ref->l=
evel + 1,
> -                                            ref->parent, node->bytenr, c=
ount,
> +                                            node->parent, node->bytenr, =
count,
>                                              sc, GFP_ATOMIC);
>                         break;
>                 }
> @@ -972,18 +972,14 @@ static int add_delayed_refs(const struct btrfs_fs_i=
nfo *fs_info,
>                         if (sc && count < 0)
>                                 sc->have_delayed_delete_refs =3D true;
>
> -                       ret =3D add_indirect_ref(fs_info, preftrees, ref-=
>root,
> +                       ret =3D add_indirect_ref(fs_info, preftrees, node=
->ref_root,
>                                                &key, 0, node->bytenr, cou=
nt, sc,
>                                                GFP_ATOMIC);
>                         break;
>                 }
>                 case BTRFS_SHARED_DATA_REF_KEY: {
>                         /* SHARED DIRECT FULL backref */
> -                       struct btrfs_delayed_data_ref *ref;
> -
> -                       ref =3D btrfs_delayed_node_to_data_ref(node);
> -
> -                       ret =3D add_direct_ref(fs_info, preftrees, 0, ref=
->parent,
> +                       ret =3D add_direct_ref(fs_info, preftrees, 0, nod=
e->parent,
>                                              node->bytenr, count, sc,
>                                              GFP_ATOMIC);
>                         break;
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index a3eb3eb2f321..f9779142a174 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -303,55 +303,20 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_i=
nfo *fs_info,
>         return 0;
>  }
>
> -/*
> - * compare two delayed tree backrefs with same bytenr and type
> - */
> -static int comp_tree_refs(struct btrfs_delayed_tree_ref *ref1,
> -                         struct btrfs_delayed_tree_ref *ref2)
> -{
> -       struct btrfs_delayed_ref_node *node =3D btrfs_delayed_tree_ref_to=
_node(ref1);
> -
> -       if (node->type =3D=3D BTRFS_TREE_BLOCK_REF_KEY) {
> -               if (ref1->root < ref2->root)
> -                       return -1;
> -               if (ref1->root > ref2->root)
> -                       return 1;
> -       } else {
> -               if (ref1->parent < ref2->parent)
> -                       return -1;
> -               if (ref1->parent > ref2->parent)
> -                       return 1;
> -       }
> -       return 0;
> -}
> -
>  /*
>   * compare two delayed data backrefs with same bytenr and type
>   */
> -static int comp_data_refs(struct btrfs_delayed_data_ref *ref1,
> -                         struct btrfs_delayed_data_ref *ref2)
> +static int comp_data_refs(struct btrfs_delayed_ref_node *ref1,
> +                         struct btrfs_delayed_ref_node *ref2)
>  {
> -       struct btrfs_delayed_ref_node *node =3D btrfs_delayed_data_ref_to=
_node(ref1);
> -
> -       if (node->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) {
> -               if (ref1->root < ref2->root)
> -                       return -1;
> -               if (ref1->root > ref2->root)
> -                       return 1;
> -               if (ref1->objectid < ref2->objectid)
> -                       return -1;
> -               if (ref1->objectid > ref2->objectid)
> -                       return 1;
> -               if (ref1->offset < ref2->offset)
> -                       return -1;
> -               if (ref1->offset > ref2->offset)
> -                       return 1;
> -       } else {
> -               if (ref1->parent < ref2->parent)
> -                       return -1;
> -               if (ref1->parent > ref2->parent)
> -                       return 1;
> -       }
> +       if (ref1->data_ref.objectid < ref2->data_ref.objectid)
> +               return -1;
> +       if (ref1->data_ref.objectid > ref2->data_ref.objectid)
> +               return 1;
> +       if (ref1->data_ref.offset < ref2->data_ref.offset)
> +               return -1;
> +       if (ref1->data_ref.offset > ref2->data_ref.offset)
> +               return 1;
>         return 0;
>  }
>
> @@ -365,13 +330,20 @@ static int comp_refs(struct btrfs_delayed_ref_node =
*ref1,
>                 return -1;
>         if (ref1->type > ref2->type)
>                 return 1;
> -       if (ref1->type =3D=3D BTRFS_TREE_BLOCK_REF_KEY ||
> -           ref1->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY)
> -               ret =3D comp_tree_refs(btrfs_delayed_node_to_tree_ref(ref=
1),
> -                                    btrfs_delayed_node_to_tree_ref(ref2)=
);
> -       else
> -               ret =3D comp_data_refs(btrfs_delayed_node_to_data_ref(ref=
1),
> -                                    btrfs_delayed_node_to_data_ref(ref2)=
);
> +       if (ref1->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY ||
> +           ref1->type =3D=3D BTRFS_SHARED_DATA_REF_KEY) {
> +               if (ref1->parent < ref2->parent)
> +                       return -1;
> +               if (ref1->parent > ref2->parent)
> +                       return 1;
> +       } else {
> +               if (ref1->ref_root < ref2->ref_root)
> +                       return -1;
> +               if (ref1->ref_root > ref2->ref_root)
> +                       return -1;
> +               if (ref1->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY)
> +                       ret =3D comp_data_refs(ref1, ref2);
> +       }
>         if (ret)
>                 return ret;
>         if (check_seq) {
> @@ -1005,17 +977,15 @@ static void init_delayed_ref_common(struct btrfs_f=
s_info *fs_info,
>         ref->action =3D action;
>         ref->seq =3D seq;
>         ref->type =3D btrfs_ref_type(generic_ref);
> +       ref->ref_root =3D generic_ref->ref_root;
> +       ref->parent =3D generic_ref->parent;
>         RB_CLEAR_NODE(&ref->ref_node);
>         INIT_LIST_HEAD(&ref->add_list);
>
>         if (generic_ref->type =3D=3D BTRFS_REF_DATA) {
> -               ref->data_ref.root =3D generic_ref->ref_root;
> -               ref->data_ref.parent =3D generic_ref->parent;
>                 ref->data_ref.objectid =3D generic_ref->data_ref.ino;
>                 ref->data_ref.offset =3D generic_ref->data_ref.offset;
>         } else {
> -               ref->tree_ref.root =3D generic_ref->ref_root;
> -               ref->tree_ref.parent =3D generic_ref->parent;
>                 ref->tree_ref.level =3D generic_ref->tree_ref.level;
>         }
>  }
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 000fdcaf2314..6ad48e0a0a1a 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -31,14 +31,10 @@ enum btrfs_delayed_ref_action {
>  } __packed;
>
>  struct btrfs_delayed_tree_ref {
> -       u64 root;
> -       u64 parent;
>         int level;
>  };
>
>  struct btrfs_delayed_data_ref {
> -       u64 root;
> -       u64 parent;
>         u64 objectid;
>         u64 offset;
>  };
> @@ -61,6 +57,15 @@ struct btrfs_delayed_ref_node {
>         /* seq number to keep track of insertion order */
>         u64 seq;
>
> +       /* the ref_root for this ref */

Please capitalize the first world and add punctuation at the end of
the sentence.

> +       u64 ref_root;
> +
> +       /*
> +        * the parent for this ref, if this isn't set the ref_root is the
> +        * reference owner.

Same here, capitalize the first word of the sentence.

Other than that it looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> +        */
> +       u64 parent;
> +
>         /* ref count on this data structure */
>         refcount_t refs;
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 268516003927..0e42c8bddc0c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1577,7 +1577,7 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>         trace_run_delayed_data_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_DATA_REF_KEY)
> -               parent =3D ref->parent;
> +               parent =3D node->parent;
>
>         if (node->action =3D=3D BTRFS_ADD_DELAYED_REF && insert_reserved)=
 {
>                 struct btrfs_key key;
> @@ -1596,7 +1596,7 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>                 key.type =3D BTRFS_EXTENT_ITEM_KEY;
>                 key.offset =3D node->num_bytes;
>
> -               ret =3D alloc_reserved_file_extent(trans, parent, ref->ro=
ot,
> +               ret =3D alloc_reserved_file_extent(trans, parent, node->r=
ef_root,
>                                                  flags, ref->objectid,
>                                                  ref->offset, &key,
>                                                  node->ref_mod, href->own=
ing_root);
> @@ -1604,12 +1604,12 @@ static int run_delayed_data_ref(struct btrfs_tran=
s_handle *trans,
>                 if (!ret)
>                         ret =3D btrfs_record_squota_delta(trans->fs_info,=
 &delta);
>         } else if (node->action =3D=3D BTRFS_ADD_DELAYED_REF) {
> -               ret =3D __btrfs_inc_extent_ref(trans, node, parent, ref->=
root,
> +               ret =3D __btrfs_inc_extent_ref(trans, node, parent, node-=
>ref_root,
>                                              ref->objectid, ref->offset,
>                                              extent_op);
>         } else if (node->action =3D=3D BTRFS_DROP_DELAYED_REF) {
>                 ret =3D __btrfs_free_extent(trans, href, node, parent,
> -                                         ref->root, ref->objectid,
> +                                         node->ref_root, ref->objectid,
>                                           ref->offset, extent_op);
>         } else {
>                 BUG();
> @@ -1740,8 +1740,8 @@ static int run_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>         trace_run_delayed_tree_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY)
> -               parent =3D ref->parent;
> -       ref_root =3D ref->root;
> +               parent =3D node->parent;
> +       ref_root =3D node->ref_root;
>
>         if (unlikely(node->ref_mod !=3D 1)) {
>                 btrfs_err(trans->fs_info,
> @@ -2359,7 +2359,7 @@ static noinline int check_delayed_ref(struct btrfs_=
root *root,
>                  * If our ref doesn't match the one we're currently looki=
ng at
>                  * then we have a cross reference.
>                  */
> -               if (data_ref->root !=3D root->root_key.objectid ||
> +               if (ref->ref_root !=3D root->root_key.objectid ||
>                     data_ref->objectid !=3D objectid ||
>                     data_ref->offset !=3D offset) {
>                         ret =3D 1;
> @@ -4946,11 +4946,11 @@ static int alloc_reserved_tree_block(struct btrfs=
_trans_handle *trans,
>         if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY) {
>                 btrfs_set_extent_inline_ref_type(leaf, iref,
>                                                  BTRFS_SHARED_BLOCK_REF_K=
EY);
> -               btrfs_set_extent_inline_ref_offset(leaf, iref, ref->paren=
t);
> +               btrfs_set_extent_inline_ref_offset(leaf, iref, node->pare=
nt);
>         } else {
>                 btrfs_set_extent_inline_ref_type(leaf, iref,
>                                                  BTRFS_TREE_BLOCK_REF_KEY=
);
> -               btrfs_set_extent_inline_ref_offset(leaf, iref, ref->root)=
;
> +               btrfs_set_extent_inline_ref_offset(leaf, iref, node->ref_=
root);
>         }
>
>         btrfs_mark_buffer_dirty(trans, leaf);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index dae29f6d6b4c..e6cee75c384c 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -887,8 +887,8 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>                 __entry->bytenr         =3D ref->bytenr;
>                 __entry->num_bytes      =3D ref->num_bytes;
>                 __entry->action         =3D ref->action;
> -               __entry->parent         =3D ref->tree_ref.parent;
> -               __entry->ref_root       =3D ref->tree_ref.root;
> +               __entry->parent         =3D ref->parent;
> +               __entry->ref_root       =3D ref->ref_root;
>                 __entry->level          =3D ref->tree_ref.level;
>                 __entry->type           =3D ref->type;
>                 __entry->seq            =3D ref->seq;
> @@ -945,8 +945,8 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>                 __entry->bytenr         =3D ref->bytenr;
>                 __entry->num_bytes      =3D ref->num_bytes;
>                 __entry->action         =3D ref->action;
> -               __entry->parent         =3D ref->data_ref.parent;
> -               __entry->ref_root       =3D ref->data_ref.root;
> +               __entry->parent         =3D ref->parent;
> +               __entry->ref_root       =3D ref->ref_root;
>                 __entry->owner          =3D ref->data_ref.objectid;
>                 __entry->offset         =3D ref->data_ref.offset;
>                 __entry->type           =3D ref->type;
> --
> 2.43.0
>
>

