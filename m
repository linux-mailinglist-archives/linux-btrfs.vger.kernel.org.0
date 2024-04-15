Return-Path: <linux-btrfs+bounces-4271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862918A50DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2231C21673
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006B8627E;
	Mon, 15 Apr 2024 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzyi8MjE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480C74E3A
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186041; cv=none; b=Xho5Xye95LVtAkg3Dd7RxWPu4wPAEVe3tiTSfG2bkXSsebgI+C17NGPOJahSr851Ay5JE0B6eDAdKkEr6idFS+VM1IVJ20Nsi2iUnz5RGhwKpPy4wjNpBAgzYjXetu7Ombsddnh9CoykXo71L218kv8Eo8x9AFFSBmiPy5j9qfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186041; c=relaxed/simple;
	bh=7sqjRin/PtFvbcHf7TEIz2QpuydAHBTYSLUmQi8FTQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enbg66VLmvvRDUdrLs41IEwrBqoPqDe01QiEVkUIHejggkUl9p4ZSQSzFHxIPEQNkyxEUj3e+3YG4xoYdE3TR+DnKJvKl1IuzbHdsUNZy2BUEmrXRmVLxAUFJqvXJr38EvCaqrARkFiTYgnkumsQln8wnFJ9V9EIbYPhHBn4UBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzyi8MjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB90C2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186041;
	bh=7sqjRin/PtFvbcHf7TEIz2QpuydAHBTYSLUmQi8FTQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vzyi8MjEQtt541VzbkyjHpJNIfQcdsuCW/rAarOqdDvbZOxGLX4q570+A6PGirFZg
	 QTluYKqbR0EIhfCG9CA5Ibdm3o1SgaWq7kWVoja9kaVytOrQbp6+DIY1KQmCCXBcwd
	 d+1BrW1Wt93npccp+i7CC9Z+I9dV5C4R8HQapbQi35irfTR5HzgrTsH2YdYtNUd2hy
	 eufZnTDiiMTHlWLghFeOZ7j6vvSl4XnRATeo7Uc9RMI4XjlYDAuoIwRQNva/cdcjbz
	 kKAF7Z9B5KVt/RD71EXWfS/hw+WLfjrqHLcavr0Z08NTd12Ie++1hzSe3QOqjipF+q
	 VQaFlw/5WfNMQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so3236519a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:00:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YySLz6D2u40StluDng7mO0QVU9frhgm5bYwF0KWo1cCm9FnDDzl
	0KTKzhkNHoyNYBEmDpIA4yuxGuyrWYUB/OtYOZVlCZIOyu5FjdbWTOBGWK2+9/A24IkF5htkFSP
	Tz5sUuZHdstb1QKrFrbtwATTNeF4=
X-Google-Smtp-Source: AGHT+IHXSrmoChAZrcsJ5sKvkWZ420GBFP5I7q+qqAHqHe4XlK5U4Qonsa1XAx/MwLepTtZ9UKUPZ7Su4Mx3mfGcWDM=
X-Received: by 2002:a17:907:7247:b0:a52:55c6:692c with SMTP id
 ds7-20020a170907724700b00a5255c6692cmr5512007ejc.76.1713186039446; Mon, 15
 Apr 2024 06:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <c927df817dc837de0678790446568f03b054feda.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <c927df817dc837de0678790446568f03b054feda.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:00:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4XooPFwnA4W7g-OEkkuG4dsT18PrKD+VCf7qF91Pif7A@mail.gmail.com>
Message-ID: <CAL3q7H4XooPFwnA4W7g-OEkkuG4dsT18PrKD+VCf7qF91Pif7A@mail.gmail.com>
Subject: Re: [PATCH 13/19] btrfs: make __btrfs_inc_extent_ref take a btrfs_delayed_ref_node
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We're just extracting the values from btrfs_delayed_ref_node and passing
> them through, simply pass the btrfs_delayed_ref_node into
> __btrfs_inc_extent_ref and shrink the function arguments.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.h | 16 ++++++++++++++++
>  fs/btrfs/extent-tree.c | 41 +++++++++--------------------------------
>  2 files changed, 25 insertions(+), 32 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 3e7afac518ac..0bc80ed8b2c7 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -426,6 +426,22 @@ btrfs_delayed_data_ref_to_node(struct btrfs_delayed_=
data_ref *ref)
>         return container_of(ref, struct btrfs_delayed_ref_node, data_ref)=
;
>  }
>
> +static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node =
*node)
> +{
> +       if ((node->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) ||
> +           (node->type =3D=3D BTRFS_SHARED_DATA_REF_KEY))

There's no need for so many parenthesis, easier to read and what we
generally do in simple cases like this:

if (node->type =3D=3D ... || node->type =3D=3D ...)
> +               return node->data_ref.objectid;
> +       return node->tree_ref.level;
> +}
> +
> +static inline u64 btrfs_delayed_ref_offset(struct btrfs_delayed_ref_node=
 *node)
> +{
> +       if ((node->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) ||
> +           (node->type =3D=3D BTRFS_SHARED_DATA_REF_KEY))

Same here.

Either way, the change looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               return node->data_ref.offset;
> +       return 0;
> +}
> +
>  static inline u8 btrfs_ref_type(struct btrfs_ref *ref)
>  {
>         ASSERT(ref->type !=3D BTRFS_REF_NOT_SET);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 0e42c8bddc0c..6a8108e151d7 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1462,34 +1462,12 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handl=
e *trans,
>   * @node:          The delayed ref node used to get the bytenr/length fo=
r
>   *                 extent whose references are incremented.
>   *
> - * @parent:        If this is a shared extent (BTRFS_SHARED_DATA_REF_KEY=
/
> - *                 BTRFS_SHARED_BLOCK_REF_KEY) then it holds the logical
> - *                 bytenr of the parent block. Since new extents are alw=
ays
> - *                 created with indirect references, this will only be t=
he case
> - *                 when relocating a shared extent. In that case, root_o=
bjectid
> - *                 will be BTRFS_TREE_RELOC_OBJECTID. Otherwise, parent =
must
> - *                 be 0
> - *
> - * @root_objectid:  The id of the root where this modification has origi=
nated,
> - *                 this can be either one of the well-known metadata tre=
es or
> - *                 the subvolume id which references this extent.
> - *
> - * @owner:         For data extents it is the inode number of the owning=
 file.
> - *                 For metadata extents this parameter holds the level i=
n the
> - *                 tree of the extent.
> - *
> - * @offset:        For metadata extents the offset is ignored and is cur=
rently
> - *                 always passed as 0. For data extents it is the fileof=
fset
> - *                 this extent belongs to.
> - *
>   * @extent_op       Pointer to a structure, holding information necessar=
y when
>   *                  updating a tree block's flags
>   *
>   */
>  static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>                                   struct btrfs_delayed_ref_node *node,
> -                                 u64 parent, u64 root_objectid,
> -                                 u64 owner, u64 offset,
>                                   struct btrfs_delayed_extent_op *extent_=
op)
>  {
>         struct btrfs_path *path;
> @@ -1498,6 +1476,8 @@ static int __btrfs_inc_extent_ref(struct btrfs_tran=
s_handle *trans,
>         struct btrfs_key key;
>         u64 bytenr =3D node->bytenr;
>         u64 num_bytes =3D node->num_bytes;
> +       u64 owner =3D btrfs_delayed_ref_owner(node);
> +       u64 offset =3D btrfs_delayed_ref_offset(node);
>         u64 refs;
>         int refs_to_add =3D node->ref_mod;
>         int ret;
> @@ -1508,7 +1488,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_tran=
s_handle *trans,
>
>         /* this will setup the path even if it fails to insert the back r=
ef */
>         ret =3D insert_inline_extent_backref(trans, path, bytenr, num_byt=
es,
> -                                          parent, root_objectid, owner,
> +                                          node->parent, node->ref_root, =
owner,
>                                            offset, refs_to_add, extent_op=
);
>         if ((ret < 0 && ret !=3D -EAGAIN) || !ret)
>                 goto out;
> @@ -1531,11 +1511,11 @@ static int __btrfs_inc_extent_ref(struct btrfs_tr=
ans_handle *trans,
>
>         /* now insert the actual backref */
>         if (owner < BTRFS_FIRST_FREE_OBJECTID)
> -               ret =3D insert_tree_block_ref(trans, path, bytenr, parent=
,
> -                                           root_objectid);
> +               ret =3D insert_tree_block_ref(trans, path, bytenr, node->=
parent,
> +                                           node->ref_root);
>         else
> -               ret =3D insert_extent_data_ref(trans, path, bytenr, paren=
t,
> -                                            root_objectid, owner, offset=
,
> +               ret =3D insert_extent_data_ref(trans, path, bytenr, node-=
>parent,
> +                                            node->ref_root, owner, offse=
t,
>                                              refs_to_add);
>
>         if (ret)
> @@ -1604,9 +1584,7 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>                 if (!ret)
>                         ret =3D btrfs_record_squota_delta(trans->fs_info,=
 &delta);
>         } else if (node->action =3D=3D BTRFS_ADD_DELAYED_REF) {
> -               ret =3D __btrfs_inc_extent_ref(trans, node, parent, node-=
>ref_root,
> -                                            ref->objectid, ref->offset,
> -                                            extent_op);
> +               ret =3D __btrfs_inc_extent_ref(trans, node, extent_op);
>         } else if (node->action =3D=3D BTRFS_DROP_DELAYED_REF) {
>                 ret =3D __btrfs_free_extent(trans, href, node, parent,
>                                           node->ref_root, ref->objectid,
> @@ -1764,8 +1742,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>                 if (!ret)
>                         btrfs_record_squota_delta(fs_info, &delta);
>         } else if (node->action =3D=3D BTRFS_ADD_DELAYED_REF) {
> -               ret =3D __btrfs_inc_extent_ref(trans, node, parent, ref_r=
oot,
> -                                            ref->level, 0, extent_op);
> +               ret =3D __btrfs_inc_extent_ref(trans, node, extent_op);
>         } else if (node->action =3D=3D BTRFS_DROP_DELAYED_REF) {
>                 ret =3D __btrfs_free_extent(trans, href, node, parent, re=
f_root,
>                                           ref->level, 0, extent_op);
> --
> 2.43.0
>
>

