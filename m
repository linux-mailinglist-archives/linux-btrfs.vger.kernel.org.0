Return-Path: <linux-btrfs+bounces-4268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE68A500A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49C4286572
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9CB12AACE;
	Mon, 15 Apr 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvODWCmr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC5129A6D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185418; cv=none; b=kPI6NTNKTgyGlAukgitV71huy2lo4Q+Kej6X7qFC8/pQphl9ENM1kAUYkJQnKBookj3xQUevwJuoYoBwffuOJRgZgKSSkmGoM9XVx3R+oNwwrjlHNLDsVyPB4wq78KlWRDo7SbifFhYh8XNnBgu7Hdp5Uh/g4Bw1t+TyR4GbkO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185418; c=relaxed/simple;
	bh=9JbRGXAuT45k6vChYmgiuLce952Gn8/5N8cngcJBopA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbI6z4tfjIhEU00u4KaIdU3p+k/5FPtvdAW0P0EpD76p7hu2gboV2FjlTbk1JbvTLgYWMOFZeVjSRZzPs1DItH1Ax7tznSmTNp7f1xYULbLjET0jhjE7wXE/BAdKdPgGmHrAKoDjvKxjMuJrxioYPEwq2YmaYJLbY80ymLaE86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvODWCmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07CAC3277B
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185417;
	bh=9JbRGXAuT45k6vChYmgiuLce952Gn8/5N8cngcJBopA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LvODWCmrsrLoCis+YbFNishrecUf7VkiHGTi0vdDhivKbZxHrK/2j6A2VQUfKq6FV
	 8PyvWJAI0KHJwLA2fvCSU6rWksJ3tIOmUwJbpfPUt5s69bT7p3p4tS8vVNgTZl7E/z
	 LIvNwUEnv6yv9XeKs/eWpleVPiZT1rGis4F3NZZIZ92GZ1KJL13KSp+Nrcu9r6mZNa
	 3ABAEB45Ckx7XHKYpiWd36fHzueDz0EBH82MgGtZSPZjrr4NXQ0Kjt8K1nI1c4m7EU
	 Jf1hlPGGRn/rIsiuOv6v9f8xVSMfo31eG8Wld2POGoUyFr4WZI7iGlA0LdS6vbkOqp
	 REpJT20TX3Hcg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a523dad53e0so379751066b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:50:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSBxzOdHVvVyu9gJuD16NXq/QX9Sx1gxBP+cwTE1SNbf2ugQgS
	d4hENaXyknCUT3e45G18JBDY5mywJKffj4/tR3JRSRtuaXfRbY7dGl2NE2pzaNuV0VWk5RlZWn0
	OWM/Zw14s7dwVHBxFEIGQImnL9nw=
X-Google-Smtp-Source: AGHT+IGBBvhubHI0ncmAJ5RSdYSS/aAeEh9iw6IumejTkJ2d+rPPXbmyJuaNPDHjlTCBfMdH8dJb8dWP1NQpM0S7iLs=
X-Received: by 2002:a17:906:f187:b0:a52:613d:b5 with SMTP id
 gs7-20020a170906f18700b00a52613d00b5mr3114445ejb.13.1713185416168; Mon, 15
 Apr 2024 05:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <62df4a1c018a2b6de344b4ed9db11a59df3a3448.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <62df4a1c018a2b6de344b4ed9db11a59df3a3448.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:49:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H781PpwAbOsqxVeceGibSwjLK0BdBNAvEtTTUALMXkkYg@mail.gmail.com>
Message-ID: <CAL3q7H781PpwAbOsqxVeceGibSwjLK0BdBNAvEtTTUALMXkkYg@mail.gmail.com>
Subject: Re: [PATCH 10/19] btrfs: rename ->len to ->num_bytes in btrfs_ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We consistently use ->num_bytes everywhere through the delayed ref code,
> except in btrfs_ref.  Rename btrfs_ref to match all the other code.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c |  8 ++++----
>  fs/btrfs/delayed-ref.h |  2 +-
>  fs/btrfs/extent-tree.c | 14 +++++++-------
>  fs/btrfs/file.c        | 10 +++++-----
>  fs/btrfs/inode-item.c  |  2 +-
>  fs/btrfs/ref-verify.c  |  2 +-
>  fs/btrfs/relocation.c  | 14 +++++++-------
>  fs/btrfs/tree-log.c    |  2 +-
>  8 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 342f32ae08c9..a3eb3eb2f321 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -874,7 +874,7 @@ static void init_delayed_ref_head(struct btrfs_delaye=
d_ref_head *head_ref,
>
>         refcount_set(&head_ref->refs, 1);
>         head_ref->bytenr =3D generic_ref->bytenr;
> -       head_ref->num_bytes =3D generic_ref->len;
> +       head_ref->num_bytes =3D generic_ref->num_bytes;
>         head_ref->ref_mod =3D count_mod;
>         head_ref->reserved_bytes =3D reserved;
>         head_ref->must_insert_reserved =3D must_insert_reserved;
> @@ -895,7 +895,7 @@ static void init_delayed_ref_head(struct btrfs_delaye=
d_ref_head *head_ref,
>                         qrecord->data_rsv_refroot =3D generic_ref->ref_ro=
ot;
>                 }
>                 qrecord->bytenr =3D generic_ref->bytenr;
> -               qrecord->num_bytes =3D generic_ref->len;
> +               qrecord->num_bytes =3D generic_ref->num_bytes;
>                 qrecord->old_roots =3D NULL;
>         }
>  }
> @@ -1000,7 +1000,7 @@ static void init_delayed_ref_common(struct btrfs_fs=
_info *fs_info,
>
>         refcount_set(&ref->refs, 1);
>         ref->bytenr =3D generic_ref->bytenr;
> -       ref->num_bytes =3D generic_ref->len;
> +       ref->num_bytes =3D generic_ref->num_bytes;
>         ref->ref_mod =3D 1;
>         ref->action =3D action;
>         ref->seq =3D seq;
> @@ -1157,7 +1157,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_=
handle *trans,
>                 .type =3D BTRFS_REF_METADATA,
>                 .action =3D BTRFS_UPDATE_DELAYED_HEAD,
>                 .bytenr =3D bytenr,
> -               .len =3D num_bytes,
> +               .num_bytes =3D num_bytes,
>         };
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 83fcb32715a4..000fdcaf2314 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -260,7 +260,7 @@ struct btrfs_ref {
>         u64 real_root;
>  #endif
>         u64 bytenr;
> -       u64 len;
> +       u64 num_bytes;
>         u64 owning_root;
>
>         /*
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 805e3e904368..268516003927 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2542,7 +2542,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handl=
e *trans,
>                         if (ref.bytenr =3D=3D 0)
>                                 continue;
>
> -                       ref.len =3D btrfs_file_extent_disk_num_bytes(buf,=
 fi);
> +                       ref.num_bytes =3D btrfs_file_extent_disk_num_byte=
s(buf, fi);
>                         ref.owning_root =3D ref_root;
>
>                         key.offset -=3D btrfs_file_extent_offset(buf, fi)=
;
> @@ -2557,7 +2557,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handl=
e *trans,
>                 } else {
>                         /* We don't know the owning_root, leave as 0. */
>                         ref.bytenr =3D btrfs_node_blockptr(buf, i);
> -                       ref.len =3D fs_info->nodesize;
> +                       ref.num_bytes =3D fs_info->nodesize;
>
>                         btrfs_init_tree_ref(&ref, level - 1,
>                                             root->root_key.objectid, for_=
reloc);
> @@ -3466,7 +3466,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>                 struct btrfs_ref generic_ref =3D {
>                         .action =3D BTRFS_DROP_DELAYED_REF,
>                         .bytenr =3D buf->start,
> -                       .len =3D buf->len,
> +                       .num_bytes =3D buf->len,
>                         .parent =3D parent,
>                         .owning_root =3D btrfs_header_owner(buf),
>                         .ref_root =3D root_id,
> @@ -3560,7 +3560,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *tr=
ans, struct btrfs_ref *ref)
>          * tree, just update pinning info and exit early.
>          */
>         if (ref->ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID) {
> -               btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
> +               btrfs_pin_extent(trans, ref->bytenr, ref->num_bytes, 1);
>                 ret =3D 0;
>         } else if (ref->type =3D=3D BTRFS_REF_METADATA) {
>                 ret =3D btrfs_add_delayed_tree_ref(trans, ref, NULL);
> @@ -4967,7 +4967,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_t=
rans_handle *trans,
>         struct btrfs_ref generic_ref =3D {
>                 .action =3D BTRFS_ADD_DELAYED_EXTENT,
>                 .bytenr =3D ins->objectid,
> -               .len =3D ins->offset,
> +               .num_bytes =3D ins->offset,
>                 .owning_root =3D root->root_key.objectid,
>                 .ref_root =3D root->root_key.objectid,
>         };
> @@ -5209,7 +5209,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct=
 btrfs_trans_handle *trans,
>                 struct btrfs_ref generic_ref =3D {
>                         .action =3D BTRFS_ADD_DELAYED_EXTENT,
>                         .bytenr =3D ins.objectid,
> -                       .len =3D ins.offset,
> +                       .num_bytes =3D ins.offset,
>                         .parent =3D parent,
>                         .owning_root =3D owning_root,
>                         .ref_root =3D root_objectid,
> @@ -5594,7 +5594,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                 struct btrfs_ref ref =3D {
>                         .action =3D BTRFS_DROP_DELAYED_REF,
>                         .bytenr =3D bytenr,
> -                       .len =3D fs_info->nodesize,
> +                       .num_bytes =3D fs_info->nodesize,
>                         .owning_root =3D owner_root,
>                         .ref_root =3D root->root_key.objectid,
>                 };
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 416fa1f48fe5..c657dea23396 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -375,7 +375,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tra=
ns,
>                                 struct btrfs_ref ref =3D {
>                                         .action =3D BTRFS_ADD_DELAYED_REF=
,
>                                         .bytenr =3D disk_bytenr,
> -                                       .len =3D num_bytes,
> +                                       .num_bytes =3D num_bytes,
>                                         .parent =3D 0,
>                                         .owning_root =3D root->root_key.o=
bjectid,
>                                         .ref_root =3D root->root_key.obje=
ctid,
> @@ -468,7 +468,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tra=
ns,
>                                 struct btrfs_ref ref =3D {
>                                         .action =3D BTRFS_DROP_DELAYED_RE=
F,
>                                         .bytenr =3D disk_bytenr,
> -                                       .len =3D num_bytes,
> +                                       .num_bytes =3D num_bytes,
>                                         .parent =3D 0,
>                                         .owning_root =3D root->root_key.o=
bjectid,
>                                         .ref_root =3D root->root_key.obje=
ctid,
> @@ -753,7 +753,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_hand=
le *trans,
>
>                 ref.action =3D BTRFS_ADD_DELAYED_REF;
>                 ref.bytenr =3D bytenr;
> -               ref.len =3D num_bytes;
> +               ref.num_bytes =3D num_bytes;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D root->root_key.objectid;
>                 ref.ref_root =3D root->root_key.objectid;
> @@ -783,7 +783,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_hand=
le *trans,
>
>         ref.action =3D BTRFS_DROP_DELAYED_REF;
>         ref.bytenr =3D bytenr;
> -       ref.len =3D num_bytes;
> +       ref.num_bytes =3D num_bytes;
>         ref.parent =3D 0;
>         ref.owning_root =3D root->root_key.objectid;
>         ref.ref_root =3D root->root_key.objectid;
> @@ -2326,7 +2326,7 @@ static int btrfs_insert_replace_extent(struct btrfs=
_trans_handle *trans,
>                 struct btrfs_ref ref =3D {
>                         .action =3D BTRFS_ADD_DELAYED_REF,
>                         .bytenr =3D extent_info->disk_offset,
> -                       .len =3D extent_info->disk_len,
> +                       .num_bytes =3D extent_info->disk_len,
>                         .owning_root =3D root->root_key.objectid,
>                         .ref_root =3D root->root_key.objectid,
>                 };
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index e24605df35bb..7565ff15a69a 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -673,7 +673,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_han=
dle *trans,
>                         struct btrfs_ref ref =3D {
>                                 .action =3D BTRFS_DROP_DELAYED_REF,
>                                 .bytenr =3D extent_start,
> -                               .len =3D extent_num_bytes,
> +                               .num_bytes =3D extent_num_bytes,
>                                 .owning_root =3D root->root_key.objectid,
>                                 .ref_root =3D btrfs_header_owner(leaf),
>                         };
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 1108be7a050c..94bbb7ef9a13 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -673,7 +673,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>         int ret =3D 0;
>         bool metadata;
>         u64 bytenr =3D generic_ref->bytenr;
> -       u64 num_bytes =3D generic_ref->len;
> +       u64 num_bytes =3D generic_ref->num_bytes;
>         u64 parent =3D generic_ref->parent;
>         u64 ref_root =3D 0;
>         u64 owner =3D 0;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9e460b79f8b2..9a5a9142ea53 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1162,7 +1162,7 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
>                 key.offset -=3D btrfs_file_extent_offset(leaf, fi);
>                 ref.action =3D BTRFS_ADD_DELAYED_REF;
>                 ref.bytenr =3D new_bytenr;
> -               ref.len =3D num_bytes;
> +               ref.num_bytes =3D num_bytes;
>                 ref.parent =3D parent;
>                 ref.owning_root =3D root->root_key.objectid;
>                 ref.ref_root =3D btrfs_header_owner(leaf);
> @@ -1176,7 +1176,7 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
>
>                 ref.action =3D BTRFS_DROP_DELAYED_REF;
>                 ref.bytenr =3D bytenr;
> -               ref.len =3D num_bytes;
> +               ref.num_bytes =3D num_bytes;
>                 ref.parent =3D parent;
>                 ref.owning_root =3D root->root_key.objectid;
>                 ref.ref_root =3D btrfs_header_owner(leaf);
> @@ -1392,7 +1392,7 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>
>                 ref.action =3D BTRFS_ADD_DELAYED_REF;
>                 ref.bytenr =3D old_bytenr;
> -               ref.len =3D blocksize;
> +               ref.num_bytes =3D blocksize;
>                 ref.parent =3D path->nodes[level]->start;
>                 ref.owning_root =3D src->root_key.objectid;
>                 ref.ref_root =3D src->root_key.objectid;
> @@ -1405,7 +1405,7 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>
>                 ref.action =3D BTRFS_ADD_DELAYED_REF;
>                 ref.bytenr =3D new_bytenr;
> -               ref.len =3D blocksize;
> +               ref.num_bytes =3D blocksize;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D dest->root_key.objectid;
>                 ref.ref_root =3D dest->root_key.objectid;
> @@ -1419,7 +1419,7 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 /* We don't know the real owning_root, use 0. */
>                 ref.action =3D BTRFS_DROP_DELAYED_REF;
>                 ref.bytenr =3D new_bytenr;
> -               ref.len =3D blocksize;
> +               ref.num_bytes =3D blocksize;
>                 ref.parent =3D path->nodes[level]->start;
>                 ref.owning_root =3D 0;
>                 ref.ref_root =3D src->root_key.objectid;
> @@ -1433,7 +1433,7 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 /* We don't know the real owning_root, use 0. */
>                 ref.action =3D BTRFS_DROP_DELAYED_REF;
>                 ref.bytenr =3D old_bytenr;
> -               ref.len =3D blocksize;
> +               ref.num_bytes =3D blocksize;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D 0;
>                 ref.ref_root =3D dest->root_key.objectid;
> @@ -2537,7 +2537,7 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>                         struct btrfs_ref ref =3D {
>                                 .action =3D BTRFS_ADD_DELAYED_REF,
>                                 .bytenr =3D node->eb->start,
> -                               .len =3D blocksize,
> +                               .num_bytes =3D blocksize,
>                                 .parent =3D upper->eb->start,
>                                 .owning_root =3D btrfs_header_owner(upper=
->eb),
>                                 .ref_root =3D btrfs_header_owner(upper->e=
b),
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index da319ffda4ee..d8e7eb53cd0b 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -764,7 +764,7 @@ static noinline int replay_one_extent(struct btrfs_tr=
ans_handle *trans,
>                                 struct btrfs_ref ref =3D {
>                                         .action =3D BTRFS_ADD_DELAYED_REF=
,
>                                         .bytenr =3D ins.objectid,
> -                                       .len =3D ins.offset,
> +                                       .num_bytes =3D ins.offset,
>                                         .owning_root =3D root->root_key.o=
bjectid,
>                                         .ref_root =3D root->root_key.obje=
ctid,
>                                 };
> --
> 2.43.0
>
>

