Return-Path: <linux-btrfs+bounces-4265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB88A4F66
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DA91F21610
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C776FE2D;
	Mon, 15 Apr 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXh0um9N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6F6FE15
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185149; cv=none; b=TBTEA/0FGsBvq9ucAd1VFWfi4wO89293WURXOMbBl2kdPOgFUkb5Elq/fADnx9gRnw0SI7MQV9ECN1FzrqjM41CjdNkoYLT56h6kLA4FjEcS30QWbPcvrrd4JriEJ8Zo8aVT+yAQuL85ynQYN6rc1UBlOSSCv/riHH9CNp8mMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185149; c=relaxed/simple;
	bh=9IWk7MmiDZLGVlRs9Pt6lCFZ9Rm4eDP31SLyIktnaTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXy7/wpbm1BNa0Ur5DGdK9vD/YG0N8BnuXAy9rVoQcNbpqBn1k2loOWfQqR64WC4px7ladQBWLdP2dQEaOt0aqCtTWVQP/Lfj7aGQG8eC1nwtISCqiSE6sB90fZhSO4NN2zYhNADp6Wp8AEj8CX3EyD4taxpGWTxhJK4gSSXMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXh0um9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB22C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185149;
	bh=9IWk7MmiDZLGVlRs9Pt6lCFZ9Rm4eDP31SLyIktnaTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MXh0um9Nei9E8w2JL95o+NGBwvrC0q5sQFMiiXmV7dpQBUNSRgfRVZXrpoKzmm2vr
	 jNhRyJ7o3Eo7BWhGcn99tqC5xC+I0iIQQPh1d7UenQ4nDesaXGpY9SGzq8XzoAiROy
	 MuohNi9sXEmbIfLg8YTF+xEcX/HZNN6RpDF5ljqFa40Up7jHpOM5MfvHQxLZ1F8FpU
	 5kDIMKWb2yUbt2B+8N+57ngKTONjKSxwj2XMy5S2FPG85Sq9wyQhTQwGLrdIX2+d6m
	 5PPZz+3yIuS54V0LIucZjsRrEV7iRZdMbzwMdclytz1Lq1dDJYtjfMhzv3Xk1spIQh
	 Q6bsGeNZCB1bg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so2903765a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:45:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXb07/7lnhWfm0BDdc+MgAeIhJaYrZ1r9CBisNDg/bAWvg0Kvq
	wPy0SfsSpEjszkL+wjxvTVvGZXzDGM4fwyqDbxp6UPAxyItt8XRza7mUDkOEJPT3ZYqxQ8KFfHc
	wsRYbUPPuNyHftKi84qxFMd8EIDI=
X-Google-Smtp-Source: AGHT+IEbUbHtJnDLm3GFDX/br5xcEvBl+KmeiCwxFunfhx5YnJ5WLVr3ba+0GwuDn/I3ATICWCXvh/uKbvvNAHfIKL8=
X-Received: by 2002:a17:907:9717:b0:a51:c88e:e95a with SMTP id
 jg23-20020a170907971700b00a51c88ee95amr7115794ejc.23.1713185147610; Mon, 15
 Apr 2024 05:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <ecd41b71527519744c006919ded25a3d70d6b51d.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <ecd41b71527519744c006919ded25a3d70d6b51d.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:45:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H56ay4j+LtXNNx_aJayL-+F5RapQQhjH-u6VzN4GwoVFQ@mail.gmail.com>
Message-ID: <CAL3q7H56ay4j+LtXNNx_aJayL-+F5RapQQhjH-u6VzN4GwoVFQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] btrfs: simplify delayed ref tracepoints
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that all of the delayed ref information is in the delayed ref node,
> drastically simplify the delayed ref tracepoints by simply passing in
> the btrfs_delayed_ref_node and populating the tracepoints with the
> values from the structure itself.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c       | 14 ++--------
>  fs/btrfs/extent-tree.c       |  4 +--
>  include/trace/events/btrfs.h | 54 ++++++++++++++----------------------
>  3 files changed, 25 insertions(+), 47 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 743cc52c30af..cc1510d7eee8 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1064,7 +1064,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>                                struct btrfs_delayed_extent_op *extent_op)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_delayed_tree_ref *ref;
>         struct btrfs_delayed_ref_node *node;
>         struct btrfs_delayed_ref_head *head_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
> @@ -1093,8 +1092,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>                 }
>         }
>
> -       ref =3D btrfs_delayed_node_to_tree_ref(node);
> -
>         init_delayed_ref_common(fs_info, node, generic_ref);
>
>         init_delayed_ref_head(head_ref, generic_ref, record, 0);
> @@ -1119,9 +1116,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>          */
>         btrfs_update_delayed_refs_rsv(trans);
>
> -       trace_add_delayed_tree_ref(fs_info, node, ref,
> -                                  action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
> -                                  BTRFS_ADD_DELAYED_REF : action);
> +       trace_add_delayed_tree_ref(fs_info, node);
>         if (merged)
>                 kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
> @@ -1139,7 +1134,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>                                u64 reserved)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_delayed_data_ref *ref;
>         struct btrfs_delayed_ref_node *node;
>         struct btrfs_delayed_ref_head *head_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
> @@ -1153,8 +1147,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>         if (!node)
>                 return -ENOMEM;
>
> -       ref =3D btrfs_delayed_node_to_data_ref(node);
> -
>         init_delayed_ref_common(fs_info, node, generic_ref);
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> @@ -1195,9 +1187,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>          */
>         btrfs_update_delayed_refs_rsv(trans);
>
> -       trace_add_delayed_data_ref(trans->fs_info, node, ref,
> -                                  action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
> -                                  BTRFS_ADD_DELAYED_REF : action);
> +       trace_add_delayed_data_ref(trans->fs_info, node);
>         if (merged)
>                 kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 275e3141dc1e..805e3e904368 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1574,7 +1574,7 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>         u64 flags =3D 0;
>
>         ref =3D btrfs_delayed_node_to_data_ref(node);
> -       trace_run_delayed_data_ref(trans->fs_info, node, ref, node->actio=
n);
> +       trace_run_delayed_data_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_DATA_REF_KEY)
>                 parent =3D ref->parent;
> @@ -1737,7 +1737,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>         u64 ref_root =3D 0;
>
>         ref =3D btrfs_delayed_node_to_tree_ref(node);
> -       trace_run_delayed_tree_ref(trans->fs_info, node, ref, node->actio=
n);
> +       trace_run_delayed_tree_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY)
>                 parent =3D ref->parent;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 766cfd48386c..dae29f6d6b4c 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -868,11 +868,9 @@ TRACE_EVENT(btrfs_add_block_group,
>  DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_tree_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action),
> +       TP_ARGS(fs_info, ref),
>
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
> @@ -888,10 +886,10 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>         TP_fast_assign_btrfs(fs_info,
>                 __entry->bytenr         =3D ref->bytenr;
>                 __entry->num_bytes      =3D ref->num_bytes;
> -               __entry->action         =3D action;
> -               __entry->parent         =3D full_ref->parent;
> -               __entry->ref_root       =3D full_ref->root;
> -               __entry->level          =3D full_ref->level;
> +               __entry->action         =3D ref->action;
> +               __entry->parent         =3D ref->tree_ref.parent;
> +               __entry->ref_root       =3D ref->tree_ref.root;
> +               __entry->level          =3D ref->tree_ref.level;
>                 __entry->type           =3D ref->type;
>                 __entry->seq            =3D ref->seq;
>         ),
> @@ -911,31 +909,25 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>  DEFINE_EVENT(btrfs_delayed_tree_ref,  add_delayed_tree_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_tree_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action)
> +       TP_ARGS(fs_info, ref)
>  );
>
>  DEFINE_EVENT(btrfs_delayed_tree_ref,  run_delayed_tree_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_tree_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action)
> +       TP_ARGS(fs_info, ref)
>  );
>
>  DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_data_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action),
> +       TP_ARGS(fs_info, ref),
>
>         TP_STRUCT__entry_btrfs(
>                 __field(        u64,  bytenr            )
> @@ -952,11 +944,11 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>         TP_fast_assign_btrfs(fs_info,
>                 __entry->bytenr         =3D ref->bytenr;
>                 __entry->num_bytes      =3D ref->num_bytes;
> -               __entry->action         =3D action;
> -               __entry->parent         =3D full_ref->parent;
> -               __entry->ref_root       =3D full_ref->root;
> -               __entry->owner          =3D full_ref->objectid;
> -               __entry->offset         =3D full_ref->offset;
> +               __entry->action         =3D ref->action;
> +               __entry->parent         =3D ref->data_ref.parent;
> +               __entry->ref_root       =3D ref->data_ref.root;
> +               __entry->owner          =3D ref->data_ref.objectid;
> +               __entry->offset         =3D ref->data_ref.offset;
>                 __entry->type           =3D ref->type;
>                 __entry->seq            =3D ref->seq;
>         ),
> @@ -978,21 +970,17 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>  DEFINE_EVENT(btrfs_delayed_data_ref,  add_delayed_data_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_data_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action)
> +       TP_ARGS(fs_info, ref)
>  );
>
>  DEFINE_EVENT(btrfs_delayed_data_ref,  run_delayed_data_ref,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info,
> -                const struct btrfs_delayed_ref_node *ref,
> -                const struct btrfs_delayed_data_ref *full_ref,
> -                int action),
> +                const struct btrfs_delayed_ref_node *ref),
>
> -       TP_ARGS(fs_info, ref, full_ref, action)
> +       TP_ARGS(fs_info, ref)
>  );
>
>  DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
> --
> 2.43.0
>
>

