Return-Path: <linux-btrfs+bounces-4258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB478A4F38
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF897B217C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019E6F505;
	Mon, 15 Apr 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN6hw7X+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452166BFA6
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184715; cv=none; b=kf9gfGTqpYSOI+mQrKPi584XNZ+OZ3dddonYif+/9Op/kOfPpbUaZRhLuzp21qdN9iO7uCqpW3DPnJlmXhrVQzoF63+sioFgy9w8hqM88K/idUPnuuWN04JUOBqiq25vtmWIuJ7uarZ0ir9C4x/4cx5Iil1ZgUIUxhOfQkBXQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184715; c=relaxed/simple;
	bh=9gwhggrQ4IwEXndt61qrjHBRtDiGn7nC3Ig0ArrDlFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hodEk+TpvnrIaGxLs6G/UjGbzmQvb3ERXoAoWRuAUiVwzRL5r3VmbQGc5Ce1UJpWpK5cSJ8OjgvhtKiIBeSeL1iaOZELpSPkE09hUai/AC3RBo9AA8JYAkJS8pq8ycwMVwAOxPkuDBmvC2jzrxnJlFFM7R6cbQPYZg/l9NTHdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN6hw7X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE25AC4AF08
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713184714;
	bh=9gwhggrQ4IwEXndt61qrjHBRtDiGn7nC3Ig0ArrDlFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rN6hw7X+ofIpdXrMMyq3ZNOqD/GGW06aVVPC1iPlZkyY1QNADLAMPpvy5GDlwhUu9
	 +hsWawBESyvd886p4q0leVNd9eQxUhpbX8h64iRb10OFrwUwc35QIT5fNv7GfA+hAf
	 vyrw39Ol/x+SLJWOCsVVzme0T35YpcsqfAnJaR/dLhuvN6VQkYsjFlJPKClKOlT7is
	 DEd00nlbUm+qJ2/OS7a4u/ntrnYFGODRHuX0gAoGrUomsxIafVQUwsYy8yNzM3068N
	 ttKPZVObo5msfukmU3IZEQng4gIfJjDEACdenhHk8jLb1jbiCj0yBFySyrD7H/tftm
	 JY41eAamV43zA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso359755766b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:38:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzuAYFnmjsBOeyv9tcmOa+ut/tzLhmfXkXvrzg2IJLTvMJk7hEb
	48OlTTnBanv1nQMFjjq1FiJjr08C6gwfD5ceMuZIDZpIdClGJ0VTtrz15ziG15yYZlPnhhPnqMt
	xJSP4XzjGw3QgbV5Q66fld2b9Uuw=
X-Google-Smtp-Source: AGHT+IF0s4NYZrG/WwVqJmXyZnUVNJ0WryCBVDjlvCygKNc2DisNHdlvkr7J2ewyRqEhEROlqg3bvp+jXjxtruR+MfE=
X-Received: by 2002:a17:906:6954:b0:a52:5774:69cc with SMTP id
 c20-20020a170906695400b00a52577469ccmr2594318ejs.46.1713184713214; Mon, 15
 Apr 2024 05:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <2b6d5c91e6d8d25c9a8d4d21d7ce46df6ddba7f8.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <2b6d5c91e6d8d25c9a8d4d21d7ce46df6ddba7f8.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:37:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4=krmhG2+u8pQ7N_2FVUA0GFFB0n+stnU=JXB_PDMwzQ@mail.gmail.com>
Message-ID: <CAL3q7H4=krmhG2+u8pQ7N_2FVUA0GFFB0n+stnU=JXB_PDMwzQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] btrfs: add a helper to get the delayed ref node
 from the data/tree ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:53=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We have several different ways we refer to references throughout the
> code and it's not consistent and there's a bit of duplication.  In order
> to clean this up I want to have one structure we use to define reference
> information, and one structure we use for the delayed reference
> information.
> Start this process by adding a helper to get from the
> btrfs_delayed_data_ref/btrfs_delayed_tree_ref to the
> btrfs_delayed_ref_node so that it'll make moving these structures around
> simpler.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c | 28 +++++++++++++++++++---------
>  fs/btrfs/delayed-ref.h | 12 ++++++++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index e44e62cf76bc..d920663a18fd 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -310,7 +310,9 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_inf=
o *fs_info,
>  static int comp_tree_refs(struct btrfs_delayed_tree_ref *ref1,
>                           struct btrfs_delayed_tree_ref *ref2)
>  {
> -       if (ref1->node.type =3D=3D BTRFS_TREE_BLOCK_REF_KEY) {
> +       struct btrfs_delayed_ref_node *node =3D btrfs_delayed_tree_ref_to=
_node(ref1);
> +
> +       if (node->type =3D=3D BTRFS_TREE_BLOCK_REF_KEY) {
>                 if (ref1->root < ref2->root)
>                         return -1;
>                 if (ref1->root > ref2->root)
> @@ -330,7 +332,9 @@ static int comp_tree_refs(struct btrfs_delayed_tree_r=
ef *ref1,
>  static int comp_data_refs(struct btrfs_delayed_data_ref *ref1,
>                           struct btrfs_delayed_data_ref *ref2)
>  {
> -       if (ref1->node.type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) {
> +       struct btrfs_delayed_ref_node *node =3D btrfs_delayed_data_ref_to=
_node(ref1);
> +
> +       if (node->type =3D=3D BTRFS_EXTENT_DATA_REF_KEY) {
>                 if (ref1->root < ref2->root)
>                         return -1;
>                 if (ref1->root > ref2->root)
> @@ -1061,6 +1065,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_delayed_tree_ref *ref;
> +       struct btrfs_delayed_ref_node *node;
>         struct btrfs_delayed_ref_head *head_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_qgroup_extent_record *record =3D NULL;
> @@ -1096,12 +1101,14 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>                 }
>         }
>
> +       node =3D btrfs_delayed_tree_ref_to_node(ref);
> +
>         if (parent)
>                 ref_type =3D BTRFS_SHARED_BLOCK_REF_KEY;
>         else
>                 ref_type =3D BTRFS_TREE_BLOCK_REF_KEY;
>
> -       init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
> +       init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
>                                 generic_ref->tree_ref.ref_root, action,
>                                 ref_type);
>         ref->root =3D generic_ref->tree_ref.ref_root;
> @@ -1123,7 +1130,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         head_ref =3D add_delayed_ref_head(trans, head_ref, record,
>                                         action, &qrecord_inserted);
>
> -       merged =3D insert_delayed_ref(trans, head_ref, &ref->node);
> +       merged =3D insert_delayed_ref(trans, head_ref, node);
>         spin_unlock(&delayed_refs->lock);
>
>         /*
> @@ -1132,7 +1139,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>          */
>         btrfs_update_delayed_refs_rsv(trans);
>
> -       trace_add_delayed_tree_ref(fs_info, &ref->node, ref,
> +       trace_add_delayed_tree_ref(fs_info, node, ref,
>                                    action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
>                                    BTRFS_ADD_DELAYED_REF : action);
>         if (merged)
> @@ -1153,6 +1160,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_delayed_data_ref *ref;
> +       struct btrfs_delayed_ref_node *node;
>         struct btrfs_delayed_ref_head *head_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_qgroup_extent_record *record =3D NULL;
> @@ -1172,12 +1180,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans=
_handle *trans,
>         if (!ref)
>                 return -ENOMEM;
>
> +       node =3D btrfs_delayed_data_ref_to_node(ref);
> +
>         if (parent)
>                 ref_type =3D BTRFS_SHARED_DATA_REF_KEY;
>         else
>                 ref_type =3D BTRFS_EXTENT_DATA_REF_KEY;
> -       init_delayed_ref_common(fs_info, &ref->node, bytenr, num_bytes,
> -                               ref_root, action, ref_type);
> +       init_delayed_ref_common(fs_info, node, bytenr, num_bytes, ref_roo=
t,
> +                               action, ref_type);
>         ref->root =3D ref_root;
>         ref->parent =3D parent;
>         ref->objectid =3D owner;
> @@ -1214,7 +1224,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>         head_ref =3D add_delayed_ref_head(trans, head_ref, record,
>                                         action, &qrecord_inserted);
>
> -       merged =3D insert_delayed_ref(trans, head_ref, &ref->node);
> +       merged =3D insert_delayed_ref(trans, head_ref, node);
>         spin_unlock(&delayed_refs->lock);
>
>         /*
> @@ -1223,7 +1233,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>          */
>         btrfs_update_delayed_refs_rsv(trans);
>
> -       trace_add_delayed_data_ref(trans->fs_info, &ref->node, ref,
> +       trace_add_delayed_data_ref(trans->fs_info, node, ref,
>                                    action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
>                                    BTRFS_ADD_DELAYED_REF : action);
>         if (merged)
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index b291147cb8ab..b3a78bf7b072 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -413,4 +413,16 @@ btrfs_delayed_node_to_data_ref(struct btrfs_delayed_=
ref_node *node)
>         return container_of(node, struct btrfs_delayed_data_ref, node);
>  }
>
> +static inline struct btrfs_delayed_ref_node *
> +btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
> +{
> +       return &ref->node;
> +}
> +
> +static inline struct btrfs_delayed_ref_node *
> +btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
> +{
> +       return &ref->node;
> +}
> +
>  #endif
> --
> 2.43.0
>
>

