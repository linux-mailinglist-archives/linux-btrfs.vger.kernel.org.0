Return-Path: <linux-btrfs+bounces-4261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C136E8A4F49
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77518284186
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097146F517;
	Mon, 15 Apr 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daqMR74u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E536F076
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184869; cv=none; b=eTuM9W8BQ/YHGRJZqEIkUXBVwJOdqy257G++0eROIQztIA6/vg/RbbgQ76o06+8tH1DHt3exCQZJr9qzD3wxyOx/5J756PodilS25hllxUpx1CBJYN+I6OEbG/6ay4TBXsgWdaa6AlBpOUaag6gAfv2d+LD4GbwSKrGMmpyNieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184869; c=relaxed/simple;
	bh=/RCeRujwk8gOBZ02AJI3OPig2Hcysi+l4ivDrgXQub0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RifAK6A83LlWWSUQbRchrn7lS/GqXkgD7guRH4GXc5Kfc6cAxCKrX7FGKlvoEcnaFI1of/A4DWWHo1VDE2pnSD7zuagfNh5Al572Iow2Ojdh+diGZkEEAK7gqxkQHJmQ9OakKcTSyWIyAQvbYaINPIxXfa4Tk4/Bqt4GffydiB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daqMR74u; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so5063622a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713184865; x=1713789665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+l9mKuvpd1Nxhx6RUNIdByJpKsUrlCTZttS1fkMpVA=;
        b=daqMR74u4lDthclR4go/5/yL9UvFHBPKFGycMACyxvIVtrHekdzNR7Al7fRjOaCqSl
         4YRexHTNk7skB22ggDqE2/zN0ut5yOn2sUaRaTLVLwpUUHz2jCB4fyvcMsG2ayrZshDo
         X2Mj88dL7OAuj03KyzVvr9Iz5LBLc6oMep1merpM3v0iyJscIRviVSL0tK9fJQ9kHCx9
         gRPp/vi7j4rBS6qQbHlNqGyeGDMLJyQhp4b7bmz9kbzVvklScggGLWQK+Wo6i31YM+SE
         8DZWuy3cS9Tm+lOmHGWJtcUg/J11cXSzEUg67yLeyCFEqMc/1IPq2KBjHWZRkA1zs6gk
         EkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184865; x=1713789665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+l9mKuvpd1Nxhx6RUNIdByJpKsUrlCTZttS1fkMpVA=;
        b=vS/wbPMKVJwcR79ZGVLIzAdasvMcC1cNjhcTVLWVnF/eiV/12BQjE4Nu4WZaeZBBUc
         ANfyLqzvqgojhGWnrhMAtxKIdLZNDonLMBZAeTx1LjHYDFooft58XLaWmvtMiq4eUSCL
         24+V0nCcqvt8IFsdoqRA9oMiGjhHYY9I4uuoHeY7mwnGNuF/oDea259/iAStcnfl4x/T
         Bi+RFTQMzJRViy8Mf1DCRFi9laGumkYzEUj7ui1IZsOvIpS4N4kJAa8/41xhLF2ddvrm
         PSZC3g5RvOKi7RwQGi1RespAXGTl52x2MgsuPeqdo9NaX6DjRIn2CpitXa3XeQRcm6Ir
         72Pg==
X-Gm-Message-State: AOJu0YwkQg1X3iB9IDajSTbwv8VoOBSRP9utXF8fEgv8FaZr8W80y/dO
	zmU08ZVy/K6E81JdQp97RDoSSLzXerSWTuvuZu+rRNYY3+lUjAGTQEpanfNqrPdrEPS1hUHxYk/
	SF7ritoby43bV1+p3CRFfT/3tD3I=
X-Google-Smtp-Source: AGHT+IFoa5K/bLNGdApCEptJgidZFSg/lzZvjkxeRnvStN8ZwRRKUXE9rnpV4x4XcJGXfH6lFlwFGOqMQNUMmPubwWo=
X-Received: by 2002:a17:906:f9ce:b0:a52:3648:67c1 with SMTP id
 lj14-20020a170906f9ce00b00a52364867c1mr6249780ejb.13.1713184864661; Mon, 15
 Apr 2024 05:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <c744c3adf986c3f2907492c33e3cfb88fb4d3aef.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <c744c3adf986c3f2907492c33e3cfb88fb4d3aef.1713052088.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Mon, 15 Apr 2024 13:40:28 +0100
Message-ID: <CAL3q7H5h7c4AFZLp6_3cTpHE1_f0zD7OtGSiqMvH=7RZBsTB5g@mail.gmail.com>
Subject: Re: [PATCH 04/19] btrfs: move ref_root into btrfs_ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We have this in both btrfs_tree_ref and btrfs_data_ref, which is just
> wasting space and making the code more complicated.  Move this into
> btrfs_ref proper and update all the call sites to do the assignment in
> btrfs_ref.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c | 29 +++++++++++++----------------
>  fs/btrfs/delayed-ref.h | 22 +++++++++-------------
>  fs/btrfs/extent-tree.c | 38 ++++++++++++++++----------------------
>  fs/btrfs/file.c        | 30 ++++++++++++++----------------
>  fs/btrfs/inode-item.c  |  6 +++---
>  fs/btrfs/ref-verify.c  |  4 ++--
>  fs/btrfs/relocation.c  | 26 +++++++++++++-------------
>  fs/btrfs/tree-log.c    |  6 +++---
>  8 files changed, 73 insertions(+), 88 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 1d0795aeba12..c6a1b6938654 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1007,17 +1007,16 @@ static void init_delayed_ref_common(struct btrfs_=
fs_info *fs_info,
>         INIT_LIST_HEAD(&ref->add_list);
>  }
>
> -void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 r=
oot,
> -                        u64 mod_root, bool skip_qgroup)
> +void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 m=
od_root,
> +                        bool skip_qgroup)
>  {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>         /* If @real_root not set, use @root as fallback */
> -       generic_ref->real_root =3D mod_root ?: root;
> +       generic_ref->real_root =3D mod_root ?: generic_ref->ref_root;
>  #endif
>         generic_ref->tree_ref.level =3D level;
> -       generic_ref->tree_ref.ref_root =3D root;
>         generic_ref->type =3D BTRFS_REF_METADATA;
> -       if (skip_qgroup || !(is_fstree(root) &&
> +       if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
>                              (!mod_root || is_fstree(mod_root))))
>                 generic_ref->skip_qgroup =3D true;
>         else
> @@ -1025,18 +1024,17 @@ void btrfs_init_tree_ref(struct btrfs_ref *generi=
c_ref, int level, u64 root,
>
>  }
>
> -void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u6=
4 ino,
> -                        u64 offset, u64 mod_root, bool skip_qgroup)
> +void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 off=
set,
> +                        u64 mod_root, bool skip_qgroup)
>  {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>         /* If @real_root not set, use @root as fallback */
> -       generic_ref->real_root =3D mod_root ?: ref_root;
> +       generic_ref->real_root =3D mod_root ?: generic_ref->ref_root;
>  #endif
> -       generic_ref->data_ref.ref_root =3D ref_root;
>         generic_ref->data_ref.ino =3D ino;
>         generic_ref->data_ref.offset =3D offset;
>         generic_ref->type =3D BTRFS_REF_DATA;
> -       if (skip_qgroup || !(is_fstree(ref_root) &&
> +       if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
>                              (!mod_root || is_fstree(mod_root))))
>                 generic_ref->skip_qgroup =3D true;
>         else
> @@ -1068,7 +1066,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         u64 parent =3D generic_ref->parent;
>         u8 ref_type;
>
> -       is_system =3D (generic_ref->tree_ref.ref_root =3D=3D BTRFS_CHUNK_=
TREE_OBJECTID);
> +       is_system =3D (generic_ref->ref_root =3D=3D BTRFS_CHUNK_TREE_OBJE=
CTID);
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> @@ -1098,14 +1096,13 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>                 ref_type =3D BTRFS_TREE_BLOCK_REF_KEY;
>
>         init_delayed_ref_common(fs_info, node, bytenr, num_bytes,
> -                               generic_ref->tree_ref.ref_root, action,
> -                               ref_type);
> -       ref->root =3D generic_ref->tree_ref.ref_root;
> +                               generic_ref->ref_root, action, ref_type);
> +       ref->root =3D generic_ref->ref_root;
>         ref->parent =3D parent;
>         ref->level =3D level;
>
>         init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
> -                             generic_ref->tree_ref.ref_root, 0, action,
> +                             generic_ref->ref_root, 0, action,
>                               false, is_system, generic_ref->owning_root)=
;
>         head_ref->extent_op =3D extent_op;
>
> @@ -1159,7 +1156,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>         u64 bytenr =3D generic_ref->bytenr;
>         u64 num_bytes =3D generic_ref->len;
>         u64 parent =3D generic_ref->parent;
> -       u64 ref_root =3D generic_ref->data_ref.ref_root;
> +       u64 ref_root =3D generic_ref->ref_root;
>         u64 owner =3D generic_ref->data_ref.ino;
>         u64 offset =3D generic_ref->data_ref.offset;
>         u8 ref_type;
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index b0b2d0e93996..bf2916906bb8 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -220,9 +220,6 @@ enum btrfs_ref_type {
>  struct btrfs_data_ref {
>         /* For EXTENT_DATA_REF */
>
> -       /* Root which owns this data reference. */
> -       u64 ref_root;
> -
>         /* Inode which refers to this data extent */
>         u64 ino;
>
> @@ -243,13 +240,6 @@ struct btrfs_tree_ref {
>          */
>         int level;
>
> -       /*
> -        * Root which owns this tree block reference.
> -        *
> -        * For TREE_BLOCK_REF (skinny metadata, either inline or keyed)
> -        */
> -       u64 ref_root;
> -
>         /* For non-skinny metadata, no special member needed */
>  };
>
> @@ -273,6 +263,12 @@ struct btrfs_ref {
>         u64 len;
>         u64 owning_root;
>
> +       /*
> +        * The root that owns the reference for this reference, this will=
 be set
> +        * or ->parent will be set, depending on what type of reference t=
his is.
> +        */
> +       u64 ref_root;
> +
>         /* Bytenr of the parent tree block */
>         u64 parent;
>         union {
> @@ -320,10 +316,10 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes=
(const struct btrfs_fs_info *
>         return btrfs_calc_metadata_size(fs_info, num_csum_items);
>  }
>
> -void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 r=
oot,
> +void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 m=
od_root,
> +                        bool skip_qgroup);
> +void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 off=
set,
>                          u64 mod_root, bool skip_qgroup);
> -void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u6=
4 ino,
> -                        u64 offset, u64 mod_root, bool skip_qgroup);
>
>  static inline struct btrfs_delayed_extent_op *
>  btrfs_alloc_delayed_extent_op(void)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7d38f1c15a25..275e3141dc1e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1439,7 +1439,7 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle =
*trans,
>         ASSERT(generic_ref->type !=3D BTRFS_REF_NOT_SET &&
>                generic_ref->action);
>         BUG_ON(generic_ref->type =3D=3D BTRFS_REF_METADATA &&
> -              generic_ref->tree_ref.ref_root =3D=3D BTRFS_TREE_LOG_OBJEC=
TID);
> +              generic_ref->ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID);
>
>         if (generic_ref->type =3D=3D BTRFS_REF_METADATA)
>                 ret =3D btrfs_add_delayed_tree_ref(trans, generic_ref, NU=
LL);
> @@ -2526,6 +2526,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handl=
e *trans,
>                 struct btrfs_ref ref =3D {
>                         .action =3D action,
>                         .parent =3D parent,
> +                       .ref_root =3D ref_root,
>                 };
>
>                 if (level =3D=3D 0) {
> @@ -2545,9 +2546,8 @@ static int __btrfs_mod_ref(struct btrfs_trans_handl=
e *trans,
>                         ref.owning_root =3D ref_root;
>
>                         key.offset -=3D btrfs_file_extent_offset(buf, fi)=
;
> -                       btrfs_init_data_ref(&ref, ref_root, key.objectid,
> -                                           key.offset, root->root_key.ob=
jectid,
> -                                           for_reloc);
> +                       btrfs_init_data_ref(&ref, key.objectid, key.offse=
t,
> +                                           root->root_key.objectid, for_=
reloc);
>                         if (inc)
>                                 ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
>                         else
> @@ -2559,7 +2559,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handl=
e *trans,
>                         ref.bytenr =3D btrfs_node_blockptr(buf, i);
>                         ref.len =3D fs_info->nodesize;
>
> -                       btrfs_init_tree_ref(&ref, level - 1, ref_root,
> +                       btrfs_init_tree_ref(&ref, level - 1,
>                                             root->root_key.objectid, for_=
reloc);
>                         if (inc)
>                                 ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
> @@ -3469,6 +3469,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>                         .len =3D buf->len,
>                         .parent =3D parent,
>                         .owning_root =3D btrfs_header_owner(buf),
> +                       .ref_root =3D root_id,
>                 };
>
>                 /*
> @@ -3479,8 +3480,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>                  */
>                 ASSERT(btrfs_header_bytenr(buf) !=3D 0);
>
> -               btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf)=
,
> -                                   root_id, 0, false);
> +               btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf)=
, 0, false);
>                 btrfs_ref_tree_mod(fs_info, &generic_ref);
>                 ret =3D btrfs_add_delayed_tree_ref(trans, &generic_ref, N=
ULL);
>                 BUG_ON(ret); /* -ENOMEM */
> @@ -3559,10 +3559,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *t=
rans, struct btrfs_ref *ref)
>          * tree log blocks never actually go into the extent allocation
>          * tree, just update pinning info and exit early.
>          */
> -       if ((ref->type =3D=3D BTRFS_REF_METADATA &&
> -            ref->tree_ref.ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID) ||
> -           (ref->type =3D=3D BTRFS_REF_DATA &&
> -            ref->data_ref.ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID)) {
> +       if (ref->ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID) {
>                 btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
>                 ret =3D 0;
>         } else if (ref->type =3D=3D BTRFS_REF_METADATA) {
> @@ -3571,10 +3568,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *t=
rans, struct btrfs_ref *ref)
>                 ret =3D btrfs_add_delayed_data_ref(trans, ref, 0);
>         }
>
> -       if (!((ref->type =3D=3D BTRFS_REF_METADATA &&
> -              ref->tree_ref.ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID) ||
> -             (ref->type =3D=3D BTRFS_REF_DATA &&
> -              ref->data_ref.ref_root =3D=3D BTRFS_TREE_LOG_OBJECTID)))
> +       if (ref->ref_root !=3D BTRFS_TREE_LOG_OBJECTID)
>                 btrfs_ref_tree_mod(fs_info, ref);
>
>         return ret;
> @@ -4975,16 +4969,15 @@ int btrfs_alloc_reserved_file_extent(struct btrfs=
_trans_handle *trans,
>                 .bytenr =3D ins->objectid,
>                 .len =3D ins->offset,
>                 .owning_root =3D root->root_key.objectid,
> +               .ref_root =3D root->root_key.objectid,
>         };
> -       u64 root_objectid =3D root->root_key.objectid;
>
> -       ASSERT(root_objectid !=3D BTRFS_TREE_LOG_OBJECTID);
> +       ASSERT(generic_ref.ref_root !=3D BTRFS_TREE_LOG_OBJECTID);
>
>         if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_=
src_root))
>                 generic_ref.owning_root =3D root->relocation_src_root;
>
> -       btrfs_init_data_ref(&generic_ref, root_objectid, owner,
> -                           offset, 0, false);
> +       btrfs_init_data_ref(&generic_ref, owner, offset, 0, false);
>         btrfs_ref_tree_mod(root->fs_info, &generic_ref);
>
>         return btrfs_add_delayed_data_ref(trans, &generic_ref, ram_bytes)=
;
> @@ -5219,6 +5212,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct=
 btrfs_trans_handle *trans,
>                         .len =3D ins.offset,
>                         .parent =3D parent,
>                         .owning_root =3D owning_root,
> +                       .ref_root =3D root_objectid,
>                 };
>                 extent_op =3D btrfs_alloc_delayed_extent_op();
>                 if (!extent_op) {
> @@ -5234,7 +5228,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct=
 btrfs_trans_handle *trans,
>                 extent_op->update_flags =3D true;
>                 extent_op->level =3D level;
>
> -               btrfs_init_tree_ref(&generic_ref, level, root_objectid,
> +               btrfs_init_tree_ref(&generic_ref, level,
>                                     root->root_key.objectid, false);
>                 btrfs_ref_tree_mod(fs_info, &generic_ref);
>                 ret =3D btrfs_add_delayed_tree_ref(trans, &generic_ref, e=
xtent_op);
> @@ -5602,6 +5596,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                         .bytenr =3D bytenr,
>                         .len =3D fs_info->nodesize,
>                         .owning_root =3D owner_root,
> +                       .ref_root =3D root->root_key.objectid,
>                 };
>                 if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
>                         ref.parent =3D path->nodes[level]->start;
> @@ -5659,8 +5654,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                 wc->drop_level =3D level;
>                 find_next_key(path, level, &wc->drop_progress);
>
> -               btrfs_init_tree_ref(&ref, level - 1, root->root_key.objec=
tid,
> -                                   0, false);
> +               btrfs_init_tree_ref(&ref, level - 1, 0, false);
>                 ret =3D btrfs_free_extent(trans, &ref);
>                 if (ret)
>                         goto out_unlock;
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 013bcd336215..416fa1f48fe5 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -378,12 +378,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>                                         .len =3D num_bytes,
>                                         .parent =3D 0,
>                                         .owning_root =3D root->root_key.o=
bjectid,
> +                                       .ref_root =3D root->root_key.obje=
ctid,
>                                 };
> -                               btrfs_init_data_ref(&ref,
> -                                               root->root_key.objectid,
> -                                               new_key.objectid,
> -                                               args->start - extent_offs=
et,
> -                                               0, false);
> +                               btrfs_init_data_ref(&ref, new_key.objecti=
d,
> +                                                   args->start - extent_=
offset,
> +                                                   0, false);
>                                 ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
>                                 if (ret) {
>                                         btrfs_abort_transaction(trans, re=
t);
> @@ -472,12 +471,11 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>                                         .len =3D num_bytes,
>                                         .parent =3D 0,
>                                         .owning_root =3D root->root_key.o=
bjectid,
> +                                       .ref_root =3D root->root_key.obje=
ctid,
>                                 };
> -                               btrfs_init_data_ref(&ref,
> -                                               root->root_key.objectid,
> -                                               key.objectid,
> -                                               key.offset - extent_offse=
t, 0,
> -                                               false);
> +                               btrfs_init_data_ref(&ref, key.objectid,
> +                                                   key.offset - extent_o=
ffset,
> +                                                   0, false);
>                                 ret =3D btrfs_free_extent(trans, &ref);
>                                 if (ret) {
>                                         btrfs_abort_transaction(trans, re=
t);
> @@ -758,8 +756,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_hand=
le *trans,
>                 ref.len =3D num_bytes;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D root->root_key.objectid;
> -               btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
> -                                   orig_offset, 0, false);
> +               ref.ref_root =3D root->root_key.objectid;
> +               btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
> @@ -788,8 +786,8 @@ int btrfs_mark_extent_written(struct btrfs_trans_hand=
le *trans,
>         ref.len =3D num_bytes;
>         ref.parent =3D 0;
>         ref.owning_root =3D root->root_key.objectid;
> -       btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offs=
et,
> -                           0, false);
> +       ref.ref_root =3D root->root_key.objectid;
> +       btrfs_init_data_ref(&ref, ino, orig_offset, 0, false);
>         if (extent_mergeable(leaf, path->slots[0] + 1,
>                              ino, bytenr, orig_offset,
>                              &other_start, &other_end)) {
> @@ -2330,12 +2328,12 @@ static int btrfs_insert_replace_extent(struct btr=
fs_trans_handle *trans,
>                         .bytenr =3D extent_info->disk_offset,
>                         .len =3D extent_info->disk_len,
>                         .owning_root =3D root->root_key.objectid,
> +                       .ref_root =3D root->root_key.objectid,
>                 };
>                 u64 ref_offset;
>
>                 ref_offset =3D extent_info->file_offset - extent_info->da=
ta_offset;
> -               btrfs_init_data_ref(&ref, root->root_key.objectid,
> -                                   btrfs_ino(inode), ref_offset, 0, fals=
e);
> +               btrfs_init_data_ref(&ref, btrfs_ino(inode), ref_offset, 0=
, false);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
>         }
>
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index d61bb65859a5..e24605df35bb 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -675,13 +675,13 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                                 .bytenr =3D extent_start,
>                                 .len =3D extent_num_bytes,
>                                 .owning_root =3D root->root_key.objectid,
> +                               .ref_root =3D btrfs_header_owner(leaf),
>                         };
>
>                         bytes_deleted +=3D extent_num_bytes;
>
> -                       btrfs_init_data_ref(&ref, btrfs_header_owner(leaf=
),
> -                                       control->ino, extent_offset,
> -                                       root->root_key.objectid, false);
> +                       btrfs_init_data_ref(&ref, control->ino, extent_of=
fset,
> +                                           root->root_key.objectid, fals=
e);
>                         ret =3D btrfs_free_extent(trans, &ref);
>                         if (ret) {
>                                 btrfs_abort_transaction(trans, ret);
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 8c4fc98ca9ce..1108be7a050c 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -684,10 +684,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_inf=
o,
>
>         if (generic_ref->type =3D=3D BTRFS_REF_METADATA) {
>                 if (!parent)
> -                       ref_root =3D generic_ref->tree_ref.ref_root;
> +                       ref_root =3D generic_ref->ref_root;
>                 owner =3D generic_ref->tree_ref.level;
>         } else if (!parent) {
> -               ref_root =3D generic_ref->data_ref.ref_root;
> +               ref_root =3D generic_ref->ref_root;
>                 owner =3D generic_ref->data_ref.ino;
>                 offset =3D generic_ref->data_ref.offset;
>         }
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9a739e33a5fe..9e460b79f8b2 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1165,8 +1165,8 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
>                 ref.len =3D num_bytes;
>                 ref.parent =3D parent;
>                 ref.owning_root =3D root->root_key.objectid;
> -               btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
> -                                   key.objectid, key.offset,
> +               ref.ref_root =3D btrfs_header_owner(leaf);
> +               btrfs_init_data_ref(&ref, key.objectid, key.offset,
>                                     root->root_key.objectid, false);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
>                 if (ret) {
> @@ -1179,8 +1179,8 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
>                 ref.len =3D num_bytes;
>                 ref.parent =3D parent;
>                 ref.owning_root =3D root->root_key.objectid;
> -               btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
> -                                   key.objectid, key.offset,
> +               ref.ref_root =3D btrfs_header_owner(leaf);
> +               btrfs_init_data_ref(&ref, key.objectid, key.offset,
>                                     root->root_key.objectid, false);
>                 ret =3D btrfs_free_extent(trans, &ref);
>                 if (ret) {
> @@ -1395,8 +1395,8 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 ref.len =3D blocksize;
>                 ref.parent =3D path->nodes[level]->start;
>                 ref.owning_root =3D src->root_key.objectid;
> -               btrfs_init_tree_ref(&ref, level - 1, src->root_key.object=
id,
> -                                   0, true);
> +               ref.ref_root =3D src->root_key.objectid;
> +               btrfs_init_tree_ref(&ref, level - 1, 0, true);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
> @@ -1408,8 +1408,8 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 ref.len =3D blocksize;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D dest->root_key.objectid;
> -               btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objec=
tid, 0,
> -                                   true);
> +               ref.ref_root =3D dest->root_key.objectid;
> +               btrfs_init_tree_ref(&ref, level - 1, 0, true);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
> @@ -1422,8 +1422,8 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 ref.len =3D blocksize;
>                 ref.parent =3D path->nodes[level]->start;
>                 ref.owning_root =3D 0;
> -               btrfs_init_tree_ref(&ref, level - 1, src->root_key.object=
id,
> -                                   0, true);
> +               ref.ref_root =3D src->root_key.objectid;
> +               btrfs_init_tree_ref(&ref, level - 1, 0, true);
>                 ret =3D btrfs_free_extent(trans, &ref);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
> @@ -1436,8 +1436,8 @@ int replace_path(struct btrfs_trans_handle *trans, =
struct reloc_control *rc,
>                 ref.len =3D blocksize;
>                 ref.parent =3D 0;
>                 ref.owning_root =3D 0;
> -               btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objec=
tid,
> -                                   0, true);
> +               ref.ref_root =3D dest->root_key.objectid;
> +               btrfs_init_tree_ref(&ref, level - 1, 0, true);
>                 ret =3D btrfs_free_extent(trans, &ref);
>                 if (ret) {
>                         btrfs_abort_transaction(trans, ret);
> @@ -2540,6 +2540,7 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>                                 .len =3D blocksize,
>                                 .parent =3D upper->eb->start,
>                                 .owning_root =3D btrfs_header_owner(upper=
->eb),
> +                               .ref_root =3D btrfs_header_owner(upper->e=
b),
>                         };
>
>                         btrfs_set_node_blockptr(upper->eb, slot,
> @@ -2549,7 +2550,6 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>                         btrfs_mark_buffer_dirty(trans, upper->eb);
>
>                         btrfs_init_tree_ref(&ref, node->level,
> -                                           btrfs_header_owner(upper->eb)=
,
>                                             root->root_key.objectid, fals=
e);
>                         ret =3D btrfs_inc_extent_ref(trans, &ref);
>                         if (!ret)
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 27084c7519f9..da319ffda4ee 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -766,10 +766,10 @@ static noinline int replay_one_extent(struct btrfs_=
trans_handle *trans,
>                                         .bytenr =3D ins.objectid,
>                                         .len =3D ins.offset,
>                                         .owning_root =3D root->root_key.o=
bjectid,
> +                                       .ref_root =3D root->root_key.obje=
ctid,
>                                 };
> -                               btrfs_init_data_ref(&ref,
> -                                               root->root_key.objectid,
> -                                               key->objectid, offset, 0,=
 false);
> +                               btrfs_init_data_ref(&ref, key->objectid, =
offset,
> +                                                   0, false);
>                                 ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
>                                 if (ret)
>                                         goto out;
> --
> 2.43.0
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

