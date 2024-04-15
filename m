Return-Path: <linux-btrfs+bounces-4275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62CE8A5107
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F29B22F2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3676408;
	Mon, 15 Apr 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPd7wZE/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8771B51
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186368; cv=none; b=ERd/7GeRG9QoDKGIMYaknqohq4PfJ/19kEKFuVHTPfWhVulu5KY+5GIuGMoa/teAjjd9WvO8DauyTT1XEBjxRvKBI3uel/mwJoFLjszEjDtlo149getho3+imjps9gIYoRleftt+q9HfO0M/1v24Aah+DbCiyW+pTPs28uvb9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186368; c=relaxed/simple;
	bh=jCw2a0M65cRU6zhykfDtBCeN6WHREkhXQQ2dJxg/4kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVq+G90VUNnSb5AC6mysvU+xIRo9p4CmlqQmr9NNeRLwyxH9l/MStXj18ypD7Fa4E/Ziphze4XUXjH55waJuGthW9DVprMEWXJVp9bFNzJ7/IfrcglKHM9CrIN8QSTZCnMtlwta+eUZfJoD4TX6G5lOX1euYWk0aVjmeqCODMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPd7wZE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FDDC113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186368;
	bh=jCw2a0M65cRU6zhykfDtBCeN6WHREkhXQQ2dJxg/4kU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NPd7wZE/Tvj1C6ipRvA51o4ReqrygAUboxxjlUziybaJuzWXlbKw6xION8bDTVz0K
	 tBjWf/Tj8yaUwbFHd+Ajfjri1GvXozxuQS0rT70Q4rlpP9YPLIQVsQe2tQWD+GnaMH
	 /f+BxTIjfEsNbgxwzKzyivJg7zPX9/HlqCC86R9Xmm6byVm0kUdRoSe3EBnLnMXKho
	 +B4d6shF5ZA1dGVLIYg5DMJUY2YfzltINo9VTblGR74CkYY1rIVjJF275VCjWuLgRV
	 t0/rCt6N3dEq+ADtgdUh9YabeOUxn27oHh4dPq3mt5VfN1L4Yx4phFmm0Kw1GEoYGF
	 VBnJ7X3jEeuZA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso2941356a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:06:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfIf9A11HOwh9RlUm7ZWVgi9IVQn/WBaDtoV9Jn/eHkffdQCio
	GjfQjQZBKqYFtB/2K86HYzUE1W0QMB+KaVwmcK1uPQVYAMiV9JkNY/8UZ5im+LH+VsVvOwiYJb7
	lLWXZ0q+00ilveBySmRG8xrrXVUQ=
X-Google-Smtp-Source: AGHT+IHUXRdKUkeWLV2uGAVeFG1FN1woRzklYZMeo7X3nGROuCCV2zDjieMGgGSO0d8v6+Rewrrtr2F+do2PQwsTpEQ=
X-Received: by 2002:a17:906:514:b0:a52:6946:c0ae with SMTP id
 j20-20020a170906051400b00a526946c0aemr1992878eja.46.1713186366881; Mon, 15
 Apr 2024 06:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <ad30ad3095fe61d755fc6233e5334f953a68f495.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <ad30ad3095fe61d755fc6233e5334f953a68f495.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:05:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6SMJ27ujOEptW79dszHVepQ53wN46iE+4aWz8Kn=jUGA@mail.gmail.com>
Message-ID: <CAL3q7H6SMJ27ujOEptW79dszHVepQ53wN46iE+4aWz8Kn=jUGA@mail.gmail.com>
Subject: Re: [PATCH 17/19] btrfs: stop referencing btrfs_delayed_tree_ref directly
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:55=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We only ever need to use this to get the level of the tree block ref, so
> use the btrfs_delayed_ref_owner() helper, which returns the level for
> the given reference.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/backref.c           | 21 +++++++++++----------
>  fs/btrfs/extent-tree.c       | 10 +++++-----
>  include/trace/events/btrfs.h |  1 -
>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index eb9f2f078a26..574fb1d515b3 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -919,28 +919,29 @@ static int add_delayed_refs(const struct btrfs_fs_i=
nfo *fs_info,
>                 switch (node->type) {
>                 case BTRFS_TREE_BLOCK_REF_KEY: {
>                         /* NORMAL INDIRECT METADATA backref */
> -                       struct btrfs_delayed_tree_ref *ref;
>                         struct btrfs_key *key_ptr =3D NULL;
> +                       /* The owner of a tree block ref is the level. */
> +                       int level =3D btrfs_delayed_ref_owner(node);
>
>                         if (head->extent_op && head->extent_op->update_ke=
y) {
>                                 btrfs_disk_key_to_cpu(&key, &head->extent=
_op->key);
>                                 key_ptr =3D &key;
>                         }
>
> -                       ref =3D btrfs_delayed_node_to_tree_ref(node);
>                         ret =3D add_indirect_ref(fs_info, preftrees, node=
->ref_root,
> -                                              key_ptr, ref->level + 1,
> -                                              node->bytenr, count, sc,
> -                                              GFP_ATOMIC);
> +                                              key_ptr, level + 1, node->=
bytenr,
> +                                              count, sc, GFP_ATOMIC);
>                         break;
>                 }
>                 case BTRFS_SHARED_BLOCK_REF_KEY: {
> -                       /* SHARED DIRECT METADATA backref */
> -                       struct btrfs_delayed_tree_ref *ref;
> +                       /*
> +                        * SHARED DIRECT METADATA backref
> +                        *
> +                        * The owner of a tree block ref is the level.
> +                        */
> +                       int level =3D btrfs_delayed_ref_owner(node);
>
> -                       ref =3D btrfs_delayed_node_to_tree_ref(node);
> -
> -                       ret =3D add_direct_ref(fs_info, preftrees, ref->l=
evel + 1,
> +                       ret =3D add_direct_ref(fs_info, preftrees, level =
+ 1,
>                                              node->parent, node->bytenr, =
count,
>                                              sc, GFP_ATOMIC);
>                         break;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 839c64d5a12d..4fb3c466bbfc 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4865,16 +4865,16 @@ static int alloc_reserved_tree_block(struct btrfs=
_trans_handle *trans,
>         struct btrfs_extent_inline_ref *iref;
>         struct btrfs_path *path;
>         struct extent_buffer *leaf;
> -       struct btrfs_delayed_tree_ref *ref;
>         u32 size =3D sizeof(*extent_item) + sizeof(*iref);
>         u64 flags =3D extent_op->flags_to_set;
> +       /* The owner of a tree block is the level. */
> +       int level =3D btrfs_delayed_ref_owner(node);
>         bool skinny_metadata =3D btrfs_fs_incompat(fs_info, SKINNY_METADA=
TA);
>
> -       ref =3D btrfs_delayed_node_to_tree_ref(node);
> -
>         extent_key.objectid =3D node->bytenr;
>         if (skinny_metadata) {
> -               extent_key.offset =3D ref->level;
> +               /* The owner of a tree block is the level. */
> +               extent_key.offset =3D level;
>                 extent_key.type =3D BTRFS_METADATA_ITEM_KEY;
>         } else {
>                 extent_key.offset =3D node->num_bytes;
> @@ -4907,7 +4907,7 @@ static int alloc_reserved_tree_block(struct btrfs_t=
rans_handle *trans,
>         } else {
>                 block_info =3D (struct btrfs_tree_block_info *)(extent_it=
em + 1);
>                 btrfs_set_tree_block_key(leaf, block_info, &extent_op->ke=
y);
> -               btrfs_set_tree_block_level(leaf, block_info, ref->level);
> +               btrfs_set_tree_block_level(leaf, block_info, level);
>                 iref =3D (struct btrfs_extent_inline_ref *)(block_info + =
1);
>         }
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 89fa96fd95b4..8f2497603cb5 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -16,7 +16,6 @@ struct extent_map;
>  struct btrfs_file_extent_item;
>  struct btrfs_ordered_extent;
>  struct btrfs_delayed_ref_node;
> -struct btrfs_delayed_tree_ref;
>  struct btrfs_delayed_ref_head;
>  struct btrfs_block_group;
>  struct btrfs_free_cluster;
> --
> 2.43.0
>
>

