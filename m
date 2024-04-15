Return-Path: <linux-btrfs+bounces-4273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F458A50E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FEF1F20FD7
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DAF127E16;
	Mon, 15 Apr 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCNzc6UO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7CF745C4
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186153; cv=none; b=UmRRMzh4e5sclVvkLbqtXX6FfWoOt5sSDwJACdzAJMvznrFrWx3bXsI649SNni95iMFCFmMHXAEyFf3eg4cVNRfmv2bj3IOUJlbEnORAiNj7Lz00ZNzkek/sVvy5bx1r0L1HzGNKVqWF9NdeJRG11ljEQXZvPrhxAC/yA1cAvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186153; c=relaxed/simple;
	bh=lr9TcPP2FyHHzcPXKkp1HFhwftTE4zdwVHzEzo1TBTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfRnkITf/6m8RSrr+WPnxK5j0qSYn4TRDjl7UDM1t8sftgnsQM0oFTOlKAlOndoXgSFcnFkkh+fnMYWeSFaLay2KsZxC8wG14vuVj/qUvtXtkU5JIGxwwhl1ncW13v9ISZKm2hl4BAzMeRS6uqCaqN04EzVMjwqRJvucLoz6QiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCNzc6UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E5C2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186153;
	bh=lr9TcPP2FyHHzcPXKkp1HFhwftTE4zdwVHzEzo1TBTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dCNzc6UOdW8HuJ9a6ID+YNniwtQLRPAnJWRWhxhZJnlJCEmZVrlTzX3dP9RqTdGYK
	 GoGfzmMIqGPzobnxSyV8vMc542fTYpdUQTQhI13/YNiyJtMIA0i/kPZFzJwUjEpZc8
	 HutO5ILyvlfaT3GicipuHydh9xbvFJFxF8w52DivKn/+SNj38aGQ7UsljeYo2SfSZN
	 Tcf7R0p3q5+AzQHzbnuo8+U1xRr4+s3iG1b5QM7D2hqabAx8aVr996c7eqEm71oiMH
	 9HSH0QjOXiPMKEu7rwAXxrNLOkL5DMDI8XRZCsEIuaxzVSzMBeG2yXMtPCbZYMFv++
	 unKQa2jvElWOQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso3665890a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:02:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMKxNc8lP+iphLPZ5aFQnMk3RNalC/4PWx65mSxxKqEvpv22/P
	kt9NgRyh62w1CMKE6cTKSMwj1fr4Ick78JFxel1oXlsUXvNc6z+eVi6RFePhY1FL/GkBwy06mIo
	GoGWYpRURdVFfHtIa6rgEtsMwUW0=
X-Google-Smtp-Source: AGHT+IEBzoVqnmsiWciwBYVPBydYM3GXRX+541d7bDeRkwmB94j1pC/+Zl6GHR3KBiQXLSaKGvK3sQinLFE9nFiETl4=
X-Received: by 2002:a17:907:983:b0:a52:19cb:fb48 with SMTP id
 bf3-20020a170907098300b00a5219cbfb48mr7350118ejc.77.1713186151578; Mon, 15
 Apr 2024 06:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <c849bc3ba7c0871ff672eca80e4f096eec92fe98.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <c849bc3ba7c0871ff672eca80e4f096eec92fe98.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:01:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5jwqGoWsHmJz2w+A_V8hbsbv3VGgbCxp7XQePYHpLcEg@mail.gmail.com>
Message-ID: <CAL3q7H5jwqGoWsHmJz2w+A_V8hbsbv3VGgbCxp7XQePYHpLcEg@mail.gmail.com>
Subject: Re: [PATCH 15/19] btrfs: make the insert backref helpers take a btrfs_delayed_ref_node
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:56=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We don't need to pass in all the elements for the backrefs as function
> arguments, simply pass through the btrfs_delayed_ref_node and then
> extract the values we need from that.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent-tree.c | 46 +++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 540dadcefb92..d85bc31f2e57 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -513,26 +513,26 @@ static noinline int lookup_extent_data_ref(struct b=
trfs_trans_handle *trans,
>
>  static noinline int insert_extent_data_ref(struct btrfs_trans_handle *tr=
ans,
>                                            struct btrfs_path *path,
> -                                          u64 bytenr, u64 parent,
> -                                          u64 root_objectid, u64 owner,
> -                                          u64 offset, int refs_to_add)
> +                                          struct btrfs_delayed_ref_node =
*node,
> +                                          u64 bytenr)
>  {
>         struct btrfs_root *root =3D btrfs_extent_root(trans->fs_info, byt=
enr);
>         struct btrfs_key key;
>         struct extent_buffer *leaf;
> +       u64 owner =3D btrfs_delayed_ref_owner(node);
> +       u64 offset =3D btrfs_delayed_ref_offset(node);
>         u32 size;
>         u32 num_refs;
>         int ret;
>
>         key.objectid =3D bytenr;
> -       if (parent) {
> +       if (node->parent) {
>                 key.type =3D BTRFS_SHARED_DATA_REF_KEY;
> -               key.offset =3D parent;
> +               key.offset =3D node->parent;
>                 size =3D sizeof(struct btrfs_shared_data_ref);
>         } else {
>                 key.type =3D BTRFS_EXTENT_DATA_REF_KEY;
> -               key.offset =3D hash_extent_data_ref(root_objectid,
> -                                                 owner, offset);
> +               key.offset =3D hash_extent_data_ref(node->ref_root, owner=
, offset);
>                 size =3D sizeof(struct btrfs_extent_data_ref);
>         }
>
> @@ -541,15 +541,15 @@ static noinline int insert_extent_data_ref(struct b=
trfs_trans_handle *trans,
>                 goto fail;
>
>         leaf =3D path->nodes[0];
> -       if (parent) {
> +       if (node->parent) {
>                 struct btrfs_shared_data_ref *ref;
>                 ref =3D btrfs_item_ptr(leaf, path->slots[0],
>                                      struct btrfs_shared_data_ref);
>                 if (ret =3D=3D 0) {
> -                       btrfs_set_shared_data_ref_count(leaf, ref, refs_t=
o_add);
> +                       btrfs_set_shared_data_ref_count(leaf, ref, node->=
ref_mod);
>                 } else {
>                         num_refs =3D btrfs_shared_data_ref_count(leaf, re=
f);
> -                       num_refs +=3D refs_to_add;
> +                       num_refs +=3D node->ref_mod;
>                         btrfs_set_shared_data_ref_count(leaf, ref, num_re=
fs);
>                 }
>         } else {
> @@ -557,7 +557,7 @@ static noinline int insert_extent_data_ref(struct btr=
fs_trans_handle *trans,
>                 while (ret =3D=3D -EEXIST) {
>                         ref =3D btrfs_item_ptr(leaf, path->slots[0],
>                                              struct btrfs_extent_data_ref=
);
> -                       if (match_extent_data_ref(leaf, ref, root_objecti=
d,
> +                       if (match_extent_data_ref(leaf, ref, node->ref_ro=
ot,
>                                                   owner, offset))
>                                 break;
>                         btrfs_release_path(path);
> @@ -572,14 +572,13 @@ static noinline int insert_extent_data_ref(struct b=
trfs_trans_handle *trans,
>                 ref =3D btrfs_item_ptr(leaf, path->slots[0],
>                                      struct btrfs_extent_data_ref);
>                 if (ret =3D=3D 0) {
> -                       btrfs_set_extent_data_ref_root(leaf, ref,
> -                                                      root_objectid);
> +                       btrfs_set_extent_data_ref_root(leaf, ref, node->r=
ef_root);
>                         btrfs_set_extent_data_ref_objectid(leaf, ref, own=
er);
>                         btrfs_set_extent_data_ref_offset(leaf, ref, offse=
t);
> -                       btrfs_set_extent_data_ref_count(leaf, ref, refs_t=
o_add);
> +                       btrfs_set_extent_data_ref_count(leaf, ref, node->=
ref_mod);
>                 } else {
>                         num_refs =3D btrfs_extent_data_ref_count(leaf, re=
f);
> -                       num_refs +=3D refs_to_add;
> +                       num_refs +=3D node->ref_mod;
>                         btrfs_set_extent_data_ref_count(leaf, ref, num_re=
fs);
>                 }
>         }
> @@ -703,20 +702,20 @@ static noinline int lookup_tree_block_ref(struct bt=
rfs_trans_handle *trans,
>
>  static noinline int insert_tree_block_ref(struct btrfs_trans_handle *tra=
ns,
>                                           struct btrfs_path *path,
> -                                         u64 bytenr, u64 parent,
> -                                         u64 root_objectid)
> +                                         struct btrfs_delayed_ref_node *=
node,
> +                                         u64 bytenr)
>  {
>         struct btrfs_root *root =3D btrfs_extent_root(trans->fs_info, byt=
enr);
>         struct btrfs_key key;
>         int ret;
>
>         key.objectid =3D bytenr;
> -       if (parent) {
> +       if (node->parent) {
>                 key.type =3D BTRFS_SHARED_BLOCK_REF_KEY;
> -               key.offset =3D parent;
> +               key.offset =3D node->parent;
>         } else {
>                 key.type =3D BTRFS_TREE_BLOCK_REF_KEY;
> -               key.offset =3D root_objectid;
> +               key.offset =3D node->ref_root;
>         }
>
>         ret =3D btrfs_insert_empty_item(trans, root, path, &key, 0);
> @@ -1509,12 +1508,9 @@ static int __btrfs_inc_extent_ref(struct btrfs_tra=
ns_handle *trans,
>
>         /* now insert the actual backref */
>         if (owner < BTRFS_FIRST_FREE_OBJECTID)
> -               ret =3D insert_tree_block_ref(trans, path, bytenr, node->=
parent,
> -                                           node->ref_root);
> +               ret =3D insert_tree_block_ref(trans, path, node, bytenr);
>         else
> -               ret =3D insert_extent_data_ref(trans, path, bytenr, node-=
>parent,
> -                                            node->ref_root, owner, offse=
t,
> -                                            refs_to_add);
> +               ret =3D insert_extent_data_ref(trans, path, node, bytenr)=
;
>
>         if (ret)
>                 btrfs_abort_transaction(trans, ret);
> --
> 2.43.0
>
>

