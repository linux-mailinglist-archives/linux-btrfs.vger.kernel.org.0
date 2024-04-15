Return-Path: <linux-btrfs+bounces-4259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BF8A4F39
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA12D283E00
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA906F07D;
	Mon, 15 Apr 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQL3+Qsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1315CDD9
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184736; cv=none; b=Zv8/0bNkwK/ABwVp1JiNepoazmvbcF/wOr+Pt0tL1Ga6rkvITkrshxAJBWwO2twIJDIktfEaUxt5/4yuJfuWi+xAVhoMqr80ufm3SQOqpAEEgRpyn6NhzcgLlyJV28SiujoWdQQo0+Wl/spfxbnN97m++ihYVUL7Ih2STrvPno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184736; c=relaxed/simple;
	bh=hfRfWRLiksUR6eHrSFR9Gyh/NkB2uW/LiS5iAPSdfrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1Nwlf8Ka3yMX4bvZ0gwHM/o/Z1F7Y8L0zIH4pHJxYdzcEryen5UdXZ7pPabgd1TVzCUyw9vb6aZ9Q8HcckUBmOynRo0rdDX+0pLhMWC7MERhxCMoKiEQrEX+cE3oD8TUi4andeqKxN2Y2gefLtjgbeFqZ03ohnBumMFad6wxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQL3+Qsv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518c9ff3e29so1473650e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713184732; x=1713789532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kv4ceTT6CTVSABWmDxDvSKmkUhzp3VHLczuYR1C86JQ=;
        b=EQL3+Qsvybpdfh+yf4E1Bjdt7aVOMAVW1uQR2I6Ujb7zzvtyPXA7ACaCvyeTjDJDSf
         VeKrBBrfGbb03CzkHwqECly2DUvE75v0TWgl0RnSQ0Xd6s5gRAPzS36QszECYlLN6VjM
         VNm+yiUWiUA21CCwLN4/JKnl4z9tJBEQ1IiMj7lji8PMVyEMf3MqZH5IB9wb+2v3UeEi
         9MwMtdMB9rZEgbKnMsZ3NxtqjLXf1uFiz58IM/mNGRO1/VjO968soSg8Yvkv0tBkpy+C
         BckyF/EkE2z8762KaBzuuCGtoknHTZ/SsbNVWtcaDtc8bxLWPC2+AYz37XyzHmWVfRK2
         8CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184732; x=1713789532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kv4ceTT6CTVSABWmDxDvSKmkUhzp3VHLczuYR1C86JQ=;
        b=PCmPu/ntZG1q+b4oIUWp9gbEZzGNT+gV7vwLfOpjy9MiqJuhKZ/AFngsQfPM6puIX3
         Jd+Cxkn5WZ0XiAeyz+IuncPWVCdleFA5ITSr+LjH7KSmRwQQHVlcLo7rsOgTpldoSDPx
         KjBpYWTxQhlfPwVqaFP1MoS6cgi4JABgsZDv5+6apdTWTJ5NzZiesbZDo/4gCdzNUc02
         f19D3mG93bWHJP0effeoHu/rk8craG4yHhUmk2qyOWIV9UZKU51u6UWSR8H3B2sfOxIr
         AtJLsKESF2OFOR5ddatGmtZeJg8nIdxjXKFmTziISuV+j6Nzvg35UG+ktSDlrn+VwBL4
         jAIQ==
X-Gm-Message-State: AOJu0YyNzn0etCnCXxZdjN5kA2NQx2T53FrfAEWp9GhqYtRBO8dPI9q7
	1G7s5cTAB27p1ABSNBDRAuN8IB0lUfdUrkwGihxRmFVo0haNWKkp79UYQ1kFg9Ll7x9rJlsMkiD
	w1WfNOnPGCcp7fsk7A12R4VdBmzXQL2x/
X-Google-Smtp-Source: AGHT+IEeBT0ORZdfb4pUa67Qrxlltc4YoKfCnsz2MeJ/RcPXpPuqrpUz2JMLo8kieK6RYLfPOPW4zcHQGwuLDUHkwGg=
X-Received: by 2002:a19:f80a:0:b0:513:d3c0:f66 with SMTP id
 a10-20020a19f80a000000b00513d3c00f66mr5922993lff.51.1713184732236; Mon, 15
 Apr 2024 05:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <cb592516a71f62dd136bd858670d0ae6f54d8cdc.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <cb592516a71f62dd136bd858670d0ae6f54d8cdc.1713052088.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Mon, 15 Apr 2024 13:38:15 +0100
Message-ID: <CAL3q7H4dwFgf_Bvy9KmYXXjrGJ1GzHnTKXFB4VwhPU=QCTxNRg@mail.gmail.com>
Subject: Re: [PATCH 02/19] btrfs: embed data_ref and tree_ref in btrfs_delayed_ref_node
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:53=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We have been embedding btrfs_delayed_ref_node in the
> btrfs_delayed_data_ref and btrfs_delayed_tree_ref, and then we have two
> sets of cachep's and a variety of handling that is awkward because of
> this separation.
>
> Instead union these two members inside of btrfs_delayed_ref_node and
> make that the first class object.  This allows us to go down to one
> cachep for our delayed ref nodes instead of two.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c | 51 ++++++++++++++----------------------------
>  fs/btrfs/delayed-ref.h | 44 +++++++++++++++++++-----------------
>  2 files changed, 40 insertions(+), 55 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index d920663a18fd..9382f7c81c25 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -16,8 +16,7 @@
>  #include "fs.h"
>
>  struct kmem_cache *btrfs_delayed_ref_head_cachep;
> -struct kmem_cache *btrfs_delayed_tree_ref_cachep;
> -struct kmem_cache *btrfs_delayed_data_ref_cachep;
> +struct kmem_cache *btrfs_delayed_ref_node_cachep;
>  struct kmem_cache *btrfs_delayed_extent_op_cachep;
>  /*
>   * delayed back reference update tracking.  For subvolume trees
> @@ -1082,26 +1081,26 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>         is_system =3D (generic_ref->tree_ref.ref_root =3D=3D BTRFS_CHUNK_=
TREE_OBJECTID);
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
> -       ref =3D kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS)=
;
> -       if (!ref)
> +       node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> +       if (!node)
>                 return -ENOMEM;
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
>         if (!head_ref) {
> -               kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> +               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>                 return -ENOMEM;
>         }
>
>         if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
>                 record =3D kzalloc(sizeof(*record), GFP_NOFS);
>                 if (!record) {
> -                       kmem_cache_free(btrfs_delayed_tree_ref_cachep, re=
f);
> +                       kmem_cache_free(btrfs_delayed_ref_node_cachep, no=
de);
>                         kmem_cache_free(btrfs_delayed_ref_head_cachep, he=
ad_ref);
>                         return -ENOMEM;
>                 }
>         }
>
> -       node =3D btrfs_delayed_tree_ref_to_node(ref);
> +       ref =3D btrfs_delayed_node_to_tree_ref(node);
>
>         if (parent)
>                 ref_type =3D BTRFS_SHARED_BLOCK_REF_KEY;
> @@ -1143,7 +1142,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>                                    action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
>                                    BTRFS_ADD_DELAYED_REF : action);
>         if (merged)
> -               kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
> +               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
>         if (qrecord_inserted)
>                 btrfs_qgroup_trace_extent_post(trans, record);
> @@ -1176,11 +1175,11 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans=
_handle *trans,
>         u8 ref_type;
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && action);
> -       ref =3D kmem_cache_alloc(btrfs_delayed_data_ref_cachep, GFP_NOFS)=
;
> -       if (!ref)
> +       node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> +       if (!node)
>                 return -ENOMEM;
>
> -       node =3D btrfs_delayed_data_ref_to_node(ref);
> +       ref =3D btrfs_delayed_node_to_data_ref(node);
>
>         if (parent)
>                 ref_type =3D BTRFS_SHARED_DATA_REF_KEY;
> @@ -1196,14 +1195,14 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans=
_handle *trans,
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
>         if (!head_ref) {
> -               kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> +               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>                 return -ENOMEM;
>         }
>
>         if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
>                 record =3D kzalloc(sizeof(*record), GFP_NOFS);
>                 if (!record) {
> -                       kmem_cache_free(btrfs_delayed_data_ref_cachep, re=
f);
> +                       kmem_cache_free(btrfs_delayed_ref_node_cachep, no=
de);
>                         kmem_cache_free(btrfs_delayed_ref_head_cachep,
>                                         head_ref);
>                         return -ENOMEM;
> @@ -1237,7 +1236,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>                                    action =3D=3D BTRFS_ADD_DELAYED_EXTENT=
 ?
>                                    BTRFS_ADD_DELAYED_REF : action);
>         if (merged)
> -               kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
> +               kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
>
>         if (qrecord_inserted)
> @@ -1280,18 +1279,7 @@ void btrfs_put_delayed_ref(struct btrfs_delayed_re=
f_node *ref)
>  {
>         if (refcount_dec_and_test(&ref->refs)) {
>                 WARN_ON(!RB_EMPTY_NODE(&ref->ref_node));
> -               switch (ref->type) {
> -               case BTRFS_TREE_BLOCK_REF_KEY:
> -               case BTRFS_SHARED_BLOCK_REF_KEY:
> -                       kmem_cache_free(btrfs_delayed_tree_ref_cachep, re=
f);
> -                       break;
> -               case BTRFS_EXTENT_DATA_REF_KEY:
> -               case BTRFS_SHARED_DATA_REF_KEY:
> -                       kmem_cache_free(btrfs_delayed_data_ref_cachep, re=
f);
> -                       break;
> -               default:
> -                       BUG();
> -               }
> +               kmem_cache_free(btrfs_delayed_ref_node_cachep, ref);
>         }
>  }
>
> @@ -1310,8 +1298,7 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_re=
f_root *delayed_refs, u64 byt
>  void __cold btrfs_delayed_ref_exit(void)
>  {
>         kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
> -       kmem_cache_destroy(btrfs_delayed_tree_ref_cachep);
> -       kmem_cache_destroy(btrfs_delayed_data_ref_cachep);
> +       kmem_cache_destroy(btrfs_delayed_ref_node_cachep);
>         kmem_cache_destroy(btrfs_delayed_extent_op_cachep);
>  }
>
> @@ -1321,12 +1308,8 @@ int __init btrfs_delayed_ref_init(void)
>         if (!btrfs_delayed_ref_head_cachep)
>                 goto fail;
>
> -       btrfs_delayed_tree_ref_cachep =3D KMEM_CACHE(btrfs_delayed_tree_r=
ef, 0);
> -       if (!btrfs_delayed_tree_ref_cachep)
> -               goto fail;
> -
> -       btrfs_delayed_data_ref_cachep =3D KMEM_CACHE(btrfs_delayed_data_r=
ef, 0);
> -       if (!btrfs_delayed_data_ref_cachep)
> +       btrfs_delayed_ref_node_cachep =3D KMEM_CACHE(btrfs_delayed_ref_no=
de, 0);
> +       if (!btrfs_delayed_ref_node_cachep)
>                 goto fail;
>
>         btrfs_delayed_extent_op_cachep =3D KMEM_CACHE(btrfs_delayed_exten=
t_op, 0);
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index b3a78bf7b072..2de447d9aaba 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -30,6 +30,19 @@ enum btrfs_delayed_ref_action {
>         BTRFS_UPDATE_DELAYED_HEAD,
>  } __packed;
>
> +struct btrfs_delayed_tree_ref {
> +       u64 root;
> +       u64 parent;
> +       int level;
> +};
> +
> +struct btrfs_delayed_data_ref {
> +       u64 root;
> +       u64 parent;
> +       u64 objectid;
> +       u64 offset;
> +};
> +
>  struct btrfs_delayed_ref_node {
>         struct rb_node ref_node;
>         /*
> @@ -64,6 +77,11 @@ struct btrfs_delayed_ref_node {
>
>         unsigned int action:8;
>         unsigned int type:8;
> +
> +       union {
> +               struct btrfs_delayed_tree_ref tree_ref;
> +               struct btrfs_delayed_data_ref data_ref;
> +       };
>  };
>
>  struct btrfs_delayed_extent_op {
> @@ -151,21 +169,6 @@ struct btrfs_delayed_ref_head {
>         bool processing;
>  };
>
> -struct btrfs_delayed_tree_ref {
> -       struct btrfs_delayed_ref_node node;
> -       u64 root;
> -       u64 parent;
> -       int level;
> -};
> -
> -struct btrfs_delayed_data_ref {
> -       struct btrfs_delayed_ref_node node;
> -       u64 root;
> -       u64 parent;
> -       u64 objectid;
> -       u64 offset;
> -};
> -
>  enum btrfs_delayed_ref_flags {
>         /* Indicate that we are flushing delayed refs for the commit */
>         BTRFS_DELAYED_REFS_FLUSHING,
> @@ -279,8 +282,7 @@ struct btrfs_ref {
>  };
>
>  extern struct kmem_cache *btrfs_delayed_ref_head_cachep;
> -extern struct kmem_cache *btrfs_delayed_tree_ref_cachep;
> -extern struct kmem_cache *btrfs_delayed_data_ref_cachep;
> +extern struct kmem_cache *btrfs_delayed_ref_node_cachep;
>  extern struct kmem_cache *btrfs_delayed_extent_op_cachep;
>
>  int __init btrfs_delayed_ref_init(void);
> @@ -404,25 +406,25 @@ bool btrfs_check_space_for_delayed_refs(struct btrf=
s_fs_info *fs_info);
>  static inline struct btrfs_delayed_tree_ref *
>  btrfs_delayed_node_to_tree_ref(struct btrfs_delayed_ref_node *node)
>  {
> -       return container_of(node, struct btrfs_delayed_tree_ref, node);
> +       return &node->tree_ref;
>  }
>
>  static inline struct btrfs_delayed_data_ref *
>  btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
>  {
> -       return container_of(node, struct btrfs_delayed_data_ref, node);
> +       return &node->data_ref;
>  }
>
>  static inline struct btrfs_delayed_ref_node *
>  btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
>  {
> -       return &ref->node;
> +       return container_of(ref, struct btrfs_delayed_ref_node, tree_ref)=
;
>  }
>
>  static inline struct btrfs_delayed_ref_node *
>  btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
>  {
> -       return &ref->node;
> +       return container_of(ref, struct btrfs_delayed_ref_node, data_ref)=
;
>  }
>
>  #endif
> --
> 2.43.0
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

