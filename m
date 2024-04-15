Return-Path: <linux-btrfs+bounces-4260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4248A4F48
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BF4284175
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC06F514;
	Mon, 15 Apr 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpxSwCO+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62CD6F076
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184849; cv=none; b=d/mCykWvnxt4XIlQw43LOcJFkvWxTyPSgTyfg+zaZii6gfqXzZmkxG9Q6PAu3yhNgkHU3uxvRPM8Q8BtTMvt8mvFfeKo+05h57FCJP0gUYDsAb8TBJ2oceC07aKnf53JujfxrWiAfnfNpL0HZhRKDodLUk0TFZ9W2ov5GTCv8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184849; c=relaxed/simple;
	bh=i8FpOeejVNU5X3xQuCiWAewlZROI6J0f7HZJwXLCY/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB3yvlnWOJQjlmiBg15IjYCaBiSMSVr156AVfgBkqfHhjDLyL4rOf4ggVN93sZFfjHOdkYX6bSsWl2KIHQcG4q9Ypx7/c+EbAxc8i66xh3ay9lynjHkEMX9B0xJr8Mr2wuemeJ1fhNLyQC4/12wrvAPATLN4GtdD71ednstMDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpxSwCO+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-570175e8e6fso1840411a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713184845; x=1713789645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mNrfKA6bGOsJ/6nd/twhCdtGQSyYYD3jV6eWYf02oTU=;
        b=bpxSwCO+YYZ2GoL4WjkIg0r+jL5aIbtXJIRSBOdjLeZCELHzmbnHleVwNvWbACYrL3
         TmiPqZhccfHRarsy97W4CC8i/B/VIKDy3cj1uEeqrCN8Uv20sT3/w4eqsHyOB8rkH0dB
         qDJAlhRC59y4en1mz6cRk9yYdXlq+B4M/Co7A4g4w4N2ZyJBx/GxKuftSkoqsihtC8T4
         fKr8ABH5UxBlvvup+SU4CsPSRSBMWIK6fayu3kxFa1uJjSDapAM+BlWinU5rReqfRia0
         9DVy71nWxkTbaCqrKV4W6IsYub4zC21zq8iwYjXbVidjPuMR7XYUFV5nVndJ850bNmAy
         mGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184845; x=1713789645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNrfKA6bGOsJ/6nd/twhCdtGQSyYYD3jV6eWYf02oTU=;
        b=Zt6HIosVeAY/+GEkV0sspCctv2i5K00pak8orcx5RXu2gF7Mm8cRE/7S2sJtev4hiY
         2GouUKJ21aZ09VawXzQCUnin107L4K3ozr51BL/lXAdEYjFpZ72Lj5U8BGCoVXOljuAN
         xMNF6YKDtd6k188GTm9X0dzXOw6hRm7tryQUDu7EAHEalcO/a+cnPWvWD7h+0Dz9YS7Q
         MM+ZbNSF70m8dGymbGr9RF2rTboZ6jRxRuDBInYC+DK80viuLhIcztbEMHcdeDKyP4Db
         gNwJw/eZXBeb2aA9+RFr1oxqJZ5rlLpJU8YBuKzHeU7b9R80Rcxad5W0gJ4uKluYU9wb
         dTsg==
X-Gm-Message-State: AOJu0YySJEV+EE6RMCs3CxlhoamCeYy2mdKlhTUI1oZs/J/ZXQ97LGYb
	HQiV+lUuuq8C40Xea6/0F1mYgtZl0qGWCc2mpszc46XE1EvqDuF5S2+QuCtSQjeQeng23Vn8J0D
	ZxEFvpbHG3H3+h1rM0Rc6NK7M8EDeJ/rR
X-Google-Smtp-Source: AGHT+IHFQv75wy9IYB5xqid51E85T96eGCsOQixeHYv+BnWDyXa0UDlJ937/OmVARBlOTSoliFsSspdbIjqhgNCq/as=
X-Received: by 2002:a17:907:b9d5:b0:a54:c130:21fd with SMTP id
 xa21-20020a170907b9d500b00a54c13021fdmr833066ejc.13.1713184844589; Mon, 15
 Apr 2024 05:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <81b0d80d231d4acf5896522f4e98218718f669b2.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <81b0d80d231d4acf5896522f4e98218718f669b2.1713052088.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Mon, 15 Apr 2024 13:40:07 +0100
Message-ID: <CAL3q7H6om_dWxR+c7+UhZ_hShKbMkh-Kqk0a==9qgOc7USuvhw@mail.gmail.com>
Subject: Re: [PATCH 03/19] btrfs: do not use a function to initialize btrfs_ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:53=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> btrfs_ref currently has ->owning_root, and ->ref_root is shared between
> the tree ref and data ref, so in order to move that into btrfs_ref
> proper I would need to add another root parameter to the initialization
> function.  This function has too many arguments, and adding another root
> will make it easy to make mistakes about which root goes where.  Drop
> the generic ref init function and statically initialize the btrfs_ref in
> every usage.  This makes the code easier to read because we can see what
> elements we're assigning, and will make the upcoming change moving the
> ref_root into the btrfs_ref more clear and less error prone than adding
> a new element to the initialization function.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

Just one comment as we're touching all this code, and it applies to
all other patches.
Instead of doing:

root->root_key.objectid

We can use instead:

btrfs_root_id(root)

It's a bit shorter to type and clear.
As we're touching all this code, it could be a good opportunity to use
the helper.

> ---
>  fs/btrfs/delayed-ref.c | 10 -----
>  fs/btrfs/delayed-ref.h |  2 -
>  fs/btrfs/extent-tree.c | 87 ++++++++++++++++++++++++------------------
>  fs/btrfs/file.c        | 49 +++++++++++++++---------
>  fs/btrfs/inode-item.c  | 10 +++--
>  fs/btrfs/relocation.c  | 58 +++++++++++++++++++---------
>  fs/btrfs/tree-log.c    | 11 +++---
>  7 files changed, 131 insertions(+), 96 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 9382f7c81c25..1d0795aeba12 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1007,16 +1007,6 @@ static void init_delayed_ref_common(struct btrfs_f=
s_info *fs_info,
>         INIT_LIST_HEAD(&ref->add_list);
>  }
>
> -void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u=
64 bytenr,
> -                           u64 len, u64 parent, u64 owning_root)
> -{
> -       generic_ref->action =3D action;
> -       generic_ref->bytenr =3D bytenr;
> -       generic_ref->len =3D len;
> -       generic_ref->parent =3D parent;
> -       generic_ref->owning_root =3D owning_root;
> -}
> -
>  void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 r=
oot,
>                          u64 mod_root, bool skip_qgroup)
>  {
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 2de447d9aaba..b0b2d0e93996 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -320,8 +320,6 @@ static inline u64 btrfs_calc_delayed_ref_csum_bytes(c=
onst struct btrfs_fs_info *
>         return btrfs_calc_metadata_size(fs_info, num_csum_items);
>  }
>
> -void btrfs_init_generic_ref(struct btrfs_ref *generic_ref, int action, u=
64 bytenr,
> -                           u64 len, u64 parent, u64 owning_root);
>  void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 r=
oot,
>                          u64 mod_root, bool skip_qgroup);
>  void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ref_root, u6=
4 ino,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 42314604906a..7d38f1c15a25 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2492,14 +2492,11 @@ static int __btrfs_mod_ref(struct btrfs_trans_han=
dle *trans,
>                            int full_backref, int inc)
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> -       u64 bytenr;
> -       u64 num_bytes;
>         u64 parent;
>         u64 ref_root;
>         u32 nritems;
>         struct btrfs_key key;
>         struct btrfs_file_extent_item *fi;
> -       struct btrfs_ref generic_ref =3D { 0 };
>         bool for_reloc =3D btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC=
);
>         int i;
>         int action;
> @@ -2526,6 +2523,11 @@ static int __btrfs_mod_ref(struct btrfs_trans_hand=
le *trans,
>                 action =3D BTRFS_DROP_DELAYED_REF;
>
>         for (i =3D 0; i < nritems; i++) {
> +               struct btrfs_ref ref =3D {
> +                       .action =3D action,
> +                       .parent =3D parent,
> +               };
> +
>                 if (level =3D=3D 0) {
>                         btrfs_item_key_to_cpu(buf, &key, i);
>                         if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
> @@ -2535,35 +2537,34 @@ static int __btrfs_mod_ref(struct btrfs_trans_han=
dle *trans,
>                         if (btrfs_file_extent_type(buf, fi) =3D=3D
>                             BTRFS_FILE_EXTENT_INLINE)
>                                 continue;
> -                       bytenr =3D btrfs_file_extent_disk_bytenr(buf, fi)=
;
> -                       if (bytenr =3D=3D 0)
> +                       ref.bytenr =3D btrfs_file_extent_disk_bytenr(buf,=
 fi);
> +                       if (ref.bytenr =3D=3D 0)
>                                 continue;
>
> -                       num_bytes =3D btrfs_file_extent_disk_num_bytes(bu=
f, fi);
> +                       ref.len =3D btrfs_file_extent_disk_num_bytes(buf,=
 fi);
> +                       ref.owning_root =3D ref_root;
> +
>                         key.offset -=3D btrfs_file_extent_offset(buf, fi)=
;
> -                       btrfs_init_generic_ref(&generic_ref, action, byte=
nr,
> -                                              num_bytes, parent, ref_roo=
t);
> -                       btrfs_init_data_ref(&generic_ref, ref_root, key.o=
bjectid,
> +                       btrfs_init_data_ref(&ref, ref_root, key.objectid,
>                                             key.offset, root->root_key.ob=
jectid,
>                                             for_reloc);
>                         if (inc)
> -                               ret =3D btrfs_inc_extent_ref(trans, &gene=
ric_ref);
> +                               ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
>                         else
> -                               ret =3D btrfs_free_extent(trans, &generic=
_ref);
> +                               ret =3D btrfs_free_extent(trans, &ref);
>                         if (ret)
>                                 goto fail;
>                 } else {
> -                       bytenr =3D btrfs_node_blockptr(buf, i);
> -                       num_bytes =3D fs_info->nodesize;
> -                       /* We don't know the owning_root, use 0. */
> -                       btrfs_init_generic_ref(&generic_ref, action, byte=
nr,
> -                                              num_bytes, parent, 0);
> -                       btrfs_init_tree_ref(&generic_ref, level - 1, ref_=
root,
> +                       /* We don't know the owning_root, leave as 0. */
> +                       ref.bytenr =3D btrfs_node_blockptr(buf, i);
> +                       ref.len =3D fs_info->nodesize;
> +
> +                       btrfs_init_tree_ref(&ref, level - 1, ref_root,
>                                             root->root_key.objectid, for_=
reloc);
>                         if (inc)
> -                               ret =3D btrfs_inc_extent_ref(trans, &gene=
ric_ref);
> +                               ret =3D btrfs_inc_extent_ref(trans, &ref)=
;
>                         else
> -                               ret =3D btrfs_free_extent(trans, &generic=
_ref);
> +                               ret =3D btrfs_free_extent(trans, &ref);
>                         if (ret)
>                                 goto fail;
>                 }
> @@ -3462,7 +3463,13 @@ void btrfs_free_tree_block(struct btrfs_trans_hand=
le *trans,
>         int ret;
>
>         if (root_id !=3D BTRFS_TREE_LOG_OBJECTID) {
> -               struct btrfs_ref generic_ref =3D { 0 };
> +               struct btrfs_ref generic_ref =3D {
> +                       .action =3D BTRFS_DROP_DELAYED_REF,
> +                       .bytenr =3D buf->start,
> +                       .len =3D buf->len,
> +                       .parent =3D parent,
> +                       .owning_root =3D btrfs_header_owner(buf),
> +               };
>
>                 /*
>                  * Assert that the extent buffer is not cleared due to
> @@ -3472,9 +3479,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handl=
e *trans,
>                  */
>                 ASSERT(btrfs_header_bytenr(buf) !=3D 0);
>
> -               btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_R=
EF,
> -                                      buf->start, buf->len, parent,
> -                                      btrfs_header_owner(buf));
>                 btrfs_init_tree_ref(&generic_ref, btrfs_header_level(buf)=
,
>                                     root_id, 0, false);
>                 btrfs_ref_tree_mod(fs_info, &generic_ref);
> @@ -4966,17 +4970,19 @@ int btrfs_alloc_reserved_file_extent(struct btrfs=
_trans_handle *trans,
>                                      u64 offset, u64 ram_bytes,
>                                      struct btrfs_key *ins)
>  {
> -       struct btrfs_ref generic_ref =3D { 0 };
> +       struct btrfs_ref generic_ref =3D {
> +               .action =3D BTRFS_ADD_DELAYED_EXTENT,
> +               .bytenr =3D ins->objectid,
> +               .len =3D ins->offset,
> +               .owning_root =3D root->root_key.objectid,
> +       };
>         u64 root_objectid =3D root->root_key.objectid;
> -       u64 owning_root =3D root_objectid;
>
>         ASSERT(root_objectid !=3D BTRFS_TREE_LOG_OBJECTID);
>
>         if (btrfs_is_data_reloc_root(root) && is_fstree(root->relocation_=
src_root))
> -               owning_root =3D root->relocation_src_root;
> +               generic_ref.owning_root =3D root->relocation_src_root;
>
> -       btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
> -                              ins->objectid, ins->offset, 0, owning_root=
);
>         btrfs_init_data_ref(&generic_ref, root_objectid, owner,
>                             offset, 0, false);
>         btrfs_ref_tree_mod(root->fs_info, &generic_ref);
> @@ -5157,7 +5163,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct=
 btrfs_trans_handle *trans,
>         struct btrfs_block_rsv *block_rsv;
>         struct extent_buffer *buf;
>         struct btrfs_delayed_extent_op *extent_op;
> -       struct btrfs_ref generic_ref =3D { 0 };
>         u64 flags =3D 0;
>         int ret;
>         u32 blocksize =3D fs_info->nodesize;
> @@ -5208,6 +5213,13 @@ struct extent_buffer *btrfs_alloc_tree_block(struc=
t btrfs_trans_handle *trans,
>         }
>
>         if (root_objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
> +               struct btrfs_ref generic_ref =3D {
> +                       .action =3D BTRFS_ADD_DELAYED_EXTENT,
> +                       .bytenr =3D ins.objectid,
> +                       .len =3D ins.offset,
> +                       .parent =3D parent,
> +                       .owning_root =3D owning_root,
> +               };
>                 extent_op =3D btrfs_alloc_delayed_extent_op();
>                 if (!extent_op) {
>                         ret =3D -ENOMEM;
> @@ -5222,8 +5234,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct=
 btrfs_trans_handle *trans,
>                 extent_op->update_flags =3D true;
>                 extent_op->level =3D level;
>
> -               btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EX=
TENT,
> -                                      ins.objectid, ins.offset, parent, =
owning_root);
>                 btrfs_init_tree_ref(&generic_ref, level, root_objectid,
>                                     root->root_key.objectid, false);
>                 btrfs_ref_tree_mod(fs_info, &generic_ref);
> @@ -5468,11 +5478,9 @@ static noinline int do_walk_down(struct btrfs_tran=
s_handle *trans,
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         u64 bytenr;
>         u64 generation;
> -       u64 parent;
>         u64 owner_root =3D 0;
>         struct btrfs_tree_parent_check check =3D { 0 };
>         struct btrfs_key key;
> -       struct btrfs_ref ref =3D { 0 };
>         struct extent_buffer *next;
>         int level =3D wc->level;
>         int reada =3D 0;
> @@ -5589,8 +5597,14 @@ static noinline int do_walk_down(struct btrfs_tran=
s_handle *trans,
>         wc->refs[level - 1] =3D 0;
>         wc->flags[level - 1] =3D 0;
>         if (wc->stage =3D=3D DROP_REFERENCE) {
> +               struct btrfs_ref ref =3D {
> +                       .action =3D BTRFS_DROP_DELAYED_REF,
> +                       .bytenr =3D bytenr,
> +                       .len =3D fs_info->nodesize,
> +                       .owning_root =3D owner_root,
> +               };
>                 if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
> -                       parent =3D path->nodes[level]->start;
> +                       ref.parent =3D path->nodes[level]->start;
>                 } else {
>                         ASSERT(root->root_key.objectid =3D=3D
>                                btrfs_header_owner(path->nodes[level]));
> @@ -5601,7 +5615,6 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                                 ret =3D -EIO;
>                                 goto out_unlock;
>                         }
> -                       parent =3D 0;
>                 }
>
>                 /*
> @@ -5611,7 +5624,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                  * ->restarted flag.
>                  */
>                 if (wc->restarted) {
> -                       ret =3D check_ref_exists(trans, root, bytenr, par=
ent,
> +                       ret =3D check_ref_exists(trans, root, bytenr, ref=
.parent,
>                                                level - 1);
>                         if (ret < 0)
>                                 goto out_unlock;
> @@ -5646,8 +5659,6 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                 wc->drop_level =3D level;
>                 find_next_key(path, level, &wc->drop_progress);
>
> -               btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, byte=
nr,
> -                                      fs_info->nodesize, parent, owner_r=
oot);
>                 btrfs_init_tree_ref(&ref, level - 1, root->root_key.objec=
tid,
>                                     0, false);
>                 ret =3D btrfs_free_extent(trans, &ref);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0c23053951be..013bcd336215 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -206,7 +206,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tra=
ns,
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct extent_buffer *leaf;
>         struct btrfs_file_extent_item *fi;
> -       struct btrfs_ref ref =3D { 0 };
>         struct btrfs_key key;
>         struct btrfs_key new_key;
>         u64 ino =3D btrfs_ino(inode);
> @@ -373,10 +372,13 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>                         btrfs_mark_buffer_dirty(trans, leaf);
>
>                         if (update_refs && disk_bytenr > 0) {
> -                               btrfs_init_generic_ref(&ref,
> -                                               BTRFS_ADD_DELAYED_REF,
> -                                               disk_bytenr, num_bytes, 0=
,
> -                                               root->root_key.objectid);
> +                               struct btrfs_ref ref =3D {
> +                                       .action =3D BTRFS_ADD_DELAYED_REF=
,
> +                                       .bytenr =3D disk_bytenr,
> +                                       .len =3D num_bytes,
> +                                       .parent =3D 0,
> +                                       .owning_root =3D root->root_key.o=
bjectid,
> +                               };
>                                 btrfs_init_data_ref(&ref,
>                                                 root->root_key.objectid,
>                                                 new_key.objectid,
> @@ -464,10 +466,13 @@ int btrfs_drop_extents(struct btrfs_trans_handle *t=
rans,
>                                 extent_end =3D ALIGN(extent_end,
>                                                    fs_info->sectorsize);
>                         } else if (update_refs && disk_bytenr > 0) {
> -                               btrfs_init_generic_ref(&ref,
> -                                               BTRFS_DROP_DELAYED_REF,
> -                                               disk_bytenr, num_bytes, 0=
,
> -                                               root->root_key.objectid);
> +                               struct btrfs_ref ref =3D {
> +                                       .action =3D BTRFS_DROP_DELAYED_RE=
F,
> +                                       .bytenr =3D disk_bytenr,
> +                                       .len =3D num_bytes,
> +                                       .parent =3D 0,
> +                                       .owning_root =3D root->root_key.o=
bjectid,
> +                               };
>                                 btrfs_init_data_ref(&ref,
>                                                 root->root_key.objectid,
>                                                 key.objectid,
> @@ -748,8 +753,11 @@ int btrfs_mark_extent_written(struct btrfs_trans_han=
dle *trans,
>                                                 extent_end - split);
>                 btrfs_mark_buffer_dirty(trans, leaf);
>
> -               btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, byten=
r,
> -                                      num_bytes, 0, root->root_key.objec=
tid);
> +               ref.action =3D BTRFS_ADD_DELAYED_REF;
> +               ref.bytenr =3D bytenr;
> +               ref.len =3D num_bytes;
> +               ref.parent =3D 0;
> +               ref.owning_root =3D root->root_key.objectid;
>                 btrfs_init_data_ref(&ref, root->root_key.objectid, ino,
>                                     orig_offset, 0, false);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
> @@ -774,8 +782,12 @@ int btrfs_mark_extent_written(struct btrfs_trans_han=
dle *trans,
>
>         other_start =3D end;
>         other_end =3D 0;
> -       btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, bytenr,
> -                              num_bytes, 0, root->root_key.objectid);
> +
> +       ref.action =3D BTRFS_DROP_DELAYED_REF;
> +       ref.bytenr =3D bytenr;
> +       ref.len =3D num_bytes;
> +       ref.parent =3D 0;
> +       ref.owning_root =3D root->root_key.objectid;
>         btrfs_init_data_ref(&ref, root->root_key.objectid, ino, orig_offs=
et,
>                             0, false);
>         if (extent_mergeable(leaf, path->slots[0] + 1,
> @@ -2258,7 +2270,6 @@ static int btrfs_insert_replace_extent(struct btrfs=
_trans_handle *trans,
>         struct extent_buffer *leaf;
>         struct btrfs_key key;
>         int slot;
> -       struct btrfs_ref ref =3D { 0 };
>         int ret;
>
>         if (replace_len =3D=3D 0)
> @@ -2314,12 +2325,14 @@ static int btrfs_insert_replace_extent(struct btr=
fs_trans_handle *trans,
>                                                        extent_info->qgrou=
p_reserved,
>                                                        &key);
>         } else {
> +               struct btrfs_ref ref =3D {
> +                       .action =3D BTRFS_ADD_DELAYED_REF,
> +                       .bytenr =3D extent_info->disk_offset,
> +                       .len =3D extent_info->disk_len,
> +                       .owning_root =3D root->root_key.objectid,
> +               };
>                 u64 ref_offset;
>
> -               btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF,
> -                                      extent_info->disk_offset,
> -                                      extent_info->disk_len, 0,
> -                                      root->root_key.objectid);
>                 ref_offset =3D extent_info->file_offset - extent_info->da=
ta_offset;
>                 btrfs_init_data_ref(&ref, root->root_key.objectid,
>                                     btrfs_ino(inode), ref_offset, 0, fals=
e);
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 9c1394c0a6d7..d61bb65859a5 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -670,13 +670,15 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                 }
>
>                 if (del_item && extent_start !=3D 0 && !control->skip_ref=
_updates) {
> -                       struct btrfs_ref ref =3D { 0 };
> +                       struct btrfs_ref ref =3D {
> +                               .action =3D BTRFS_DROP_DELAYED_REF,
> +                               .bytenr =3D extent_start,
> +                               .len =3D extent_num_bytes,
> +                               .owning_root =3D root->root_key.objectid,
> +                       };
>
>                         bytes_deleted +=3D extent_num_bytes;
>
> -                       btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_R=
EF,
> -                                       extent_start, extent_num_bytes, 0=
,
> -                                       root->root_key.objectid);
>                         btrfs_init_data_ref(&ref, btrfs_header_owner(leaf=
),
>                                         control->ino, extent_offset,
>                                         root->root_key.objectid, false);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5c9ef6717f84..9a739e33a5fe 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1160,8 +1160,11 @@ int replace_file_extents(struct btrfs_trans_handle=
 *trans,
>                 dirty =3D 1;
>
>                 key.offset -=3D btrfs_file_extent_offset(leaf, fi);
> -               btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_b=
ytenr,
> -                                      num_bytes, parent, root->root_key.=
objectid);
> +               ref.action =3D BTRFS_ADD_DELAYED_REF;
> +               ref.bytenr =3D new_bytenr;
> +               ref.len =3D num_bytes;
> +               ref.parent =3D parent;
> +               ref.owning_root =3D root->root_key.objectid;
>                 btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
>                                     key.objectid, key.offset,
>                                     root->root_key.objectid, false);
> @@ -1171,8 +1174,11 @@ int replace_file_extents(struct btrfs_trans_handle=
 *trans,
>                         break;
>                 }
>
> -               btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, byte=
nr,
> -                                      num_bytes, parent, root->root_key.=
objectid);
> +               ref.action =3D BTRFS_DROP_DELAYED_REF;
> +               ref.bytenr =3D bytenr;
> +               ref.len =3D num_bytes;
> +               ref.parent =3D parent;
> +               ref.owning_root =3D root->root_key.objectid;
>                 btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
>                                     key.objectid, key.offset,
>                                     root->root_key.objectid, false);
> @@ -1384,9 +1390,11 @@ int replace_path(struct btrfs_trans_handle *trans,=
 struct reloc_control *rc,
>                                               path->slots[level], old_ptr=
_gen);
>                 btrfs_mark_buffer_dirty(trans, path->nodes[level]);
>
> -               btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, old_b=
ytenr,
> -                                      blocksize, path->nodes[level]->sta=
rt,
> -                                      src->root_key.objectid);
> +               ref.action =3D BTRFS_ADD_DELAYED_REF;
> +               ref.bytenr =3D old_bytenr;
> +               ref.len =3D blocksize;
> +               ref.parent =3D path->nodes[level]->start;
> +               ref.owning_root =3D src->root_key.objectid;
>                 btrfs_init_tree_ref(&ref, level - 1, src->root_key.object=
id,
>                                     0, true);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
> @@ -1394,8 +1402,12 @@ int replace_path(struct btrfs_trans_handle *trans,=
 struct reloc_control *rc,
>                         btrfs_abort_transaction(trans, ret);
>                         break;
>                 }
> -               btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_REF, new_b=
ytenr,
> -                                      blocksize, 0, dest->root_key.objec=
tid);
> +
> +               ref.action =3D BTRFS_ADD_DELAYED_REF;
> +               ref.bytenr =3D new_bytenr;
> +               ref.len =3D blocksize;
> +               ref.parent =3D 0;
> +               ref.owning_root =3D dest->root_key.objectid;
>                 btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objec=
tid, 0,
>                                     true);
>                 ret =3D btrfs_inc_extent_ref(trans, &ref);
> @@ -1405,8 +1417,11 @@ int replace_path(struct btrfs_trans_handle *trans,=
 struct reloc_control *rc,
>                 }
>
>                 /* We don't know the real owning_root, use 0. */
> -               btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, new_=
bytenr,
> -                                      blocksize, path->nodes[level]->sta=
rt, 0);
> +               ref.action =3D BTRFS_DROP_DELAYED_REF;
> +               ref.bytenr =3D new_bytenr;
> +               ref.len =3D blocksize;
> +               ref.parent =3D path->nodes[level]->start;
> +               ref.owning_root =3D 0;
>                 btrfs_init_tree_ref(&ref, level - 1, src->root_key.object=
id,
>                                     0, true);
>                 ret =3D btrfs_free_extent(trans, &ref);
> @@ -1416,8 +1431,11 @@ int replace_path(struct btrfs_trans_handle *trans,=
 struct reloc_control *rc,
>                 }
>
>                 /* We don't know the real owning_root, use 0. */
> -               btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF, old_=
bytenr,
> -                                      blocksize, 0, 0);
> +               ref.action =3D BTRFS_DROP_DELAYED_REF;
> +               ref.bytenr =3D old_bytenr;
> +               ref.len =3D blocksize;
> +               ref.parent =3D 0;
> +               ref.owning_root =3D 0;
>                 btrfs_init_tree_ref(&ref, level - 1, dest->root_key.objec=
tid,
>                                     0, true);
>                 ret =3D btrfs_free_extent(trans, &ref);
> @@ -2429,8 +2447,6 @@ static int do_relocation(struct btrfs_trans_handle =
*trans,
>         path->lowest_level =3D node->level + 1;
>         rc->backref_cache.path[node->level] =3D node;
>         list_for_each_entry(edge, &node->upper, list[LOWER]) {
> -               struct btrfs_ref ref =3D { 0 };
> -
>                 cond_resched();
>
>                 upper =3D edge->node[UPPER];
> @@ -2518,16 +2534,20 @@ static int do_relocation(struct btrfs_trans_handl=
e *trans,
>                          */
>                         ASSERT(node->eb =3D=3D eb);
>                 } else {
> +                       struct btrfs_ref ref =3D {
> +                               .action =3D BTRFS_ADD_DELAYED_REF,
> +                               .bytenr =3D node->eb->start,
> +                               .len =3D blocksize,
> +                               .parent =3D upper->eb->start,
> +                               .owning_root =3D btrfs_header_owner(upper=
->eb),
> +                       };
> +
>                         btrfs_set_node_blockptr(upper->eb, slot,
>                                                 node->eb->start);
>                         btrfs_set_node_ptr_generation(upper->eb, slot,
>                                                       trans->transid);
>                         btrfs_mark_buffer_dirty(trans, upper->eb);
>
> -                       btrfs_init_generic_ref(&ref, BTRFS_ADD_DELAYED_RE=
F,
> -                                              node->eb->start, blocksize=
,
> -                                              upper->eb->start,
> -                                              btrfs_header_owner(upper->=
eb));
>                         btrfs_init_tree_ref(&ref, node->level,
>                                             btrfs_header_owner(upper->eb)=
,
>                                             root->root_key.objectid, fals=
e);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index d9777649e170..27084c7519f9 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -748,7 +748,6 @@ static noinline int replay_one_extent(struct btrfs_tr=
ans_handle *trans,
>                         goto out;
>
>                 if (ins.objectid > 0) {
> -                       struct btrfs_ref ref =3D { 0 };
>                         u64 csum_start;
>                         u64 csum_end;
>                         LIST_HEAD(ordered_sums);
> @@ -762,10 +761,12 @@ static noinline int replay_one_extent(struct btrfs_=
trans_handle *trans,
>                         if (ret < 0) {
>                                 goto out;
>                         } else if (ret =3D=3D 0) {
> -                               btrfs_init_generic_ref(&ref,
> -                                               BTRFS_ADD_DELAYED_REF,
> -                                               ins.objectid, ins.offset,=
 0,
> -                                               root->root_key.objectid);
> +                               struct btrfs_ref ref =3D {
> +                                       .action =3D BTRFS_ADD_DELAYED_REF=
,
> +                                       .bytenr =3D ins.objectid,
> +                                       .len =3D ins.offset,
> +                                       .owning_root =3D root->root_key.o=
bjectid,
> +                               };
>                                 btrfs_init_data_ref(&ref,
>                                                 root->root_key.objectid,
>                                                 key->objectid, offset, 0,=
 false);
> --
> 2.43.0
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

