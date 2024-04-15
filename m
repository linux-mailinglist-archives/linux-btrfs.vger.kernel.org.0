Return-Path: <linux-btrfs+bounces-4263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A258A4F63
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB001F225D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFA6FE09;
	Mon, 15 Apr 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE/4kXkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A96F535
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185087; cv=none; b=rXZaXtc/tv2/PIWNMEKwNmHb2+eNbJu2lpwIPR2dEhPd9RRpYhQLgGBxnJFAk1JFQJ7LzYdQXXyAFV5Iitlkl+d5UVB2ciU2mumP9uM5yar3uYJUacvHFljcrpcB+VCtF+rHQxR2NT/r3fpHATqhjN8r/P9BNeTY9rWTs5WbY0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185087; c=relaxed/simple;
	bh=avNlwZ0GSrgxQR+TTN1HdKASJ0XT4bNOhefm9O5GGcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6komzQKB6vWlQHqLZfNVVcdJg2tZKeHGp/GDn1qXjT5n7ZaeLyeCxmC81OU+M3QbGEyuK+aoDxeGHadh8kGoL8wsbXwNNMpEmBaylkICBm1I43uWIrGcJvfUvOQl5jAwOObCHekwQCLd9l1eWCF/P1NlbsjScPjCDV4GQELuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE/4kXkF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2da08b07157so35297941fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713185084; x=1713789884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ipYgRU2/9Dhk3vhcwlrkHDT/XJHWFupFIkQbBsiE5Ng=;
        b=IE/4kXkFmHaAJ2SEzpU3qS7jhjEXUfOvcKnm8+8XL61lZmbfzWOSnbd2BPGGK3YnK+
         Fz4uM/rsx/FIU6hebXbHh7zMl+eU8eD7Z9r4JJCbvuGms9bgTD0eg3VLY3oeSuLMHKab
         oePuT5euR/jSbfJTT7etoDaCkK54noYefdExbPsAFHKhO9V5VlCbLx4nxNS3MTNv1Iti
         oHaS7qXCnbnZACc/WPnfOPwcLh5ZeXKsB3LKItR/mR28p0ehDKMrl4IOhuHppOlr39Nf
         Fb4Ppq/NW1CwqLyI3QvlOxL+UgjUl4EMylOWcn/tGS+x56uDXCgRaj3NZlHj+NdvY/3q
         mogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185084; x=1713789884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipYgRU2/9Dhk3vhcwlrkHDT/XJHWFupFIkQbBsiE5Ng=;
        b=CiKMz7ml5yn8GYwBiadIRaH26nlwoa4CN0iS1L2DeW/zLSfGykdxGLsmpazXYAscPq
         /iKN4m6kCkNecIi+Hkx/069CxfaBcw57xKqaHf0Tl9g+IlKXQsqc6jUQBup7YoEbq22c
         C1NdJxjxDul9CjY+w+t8I4cTodoxwbkSnC72f52j5CMcF2YFfEwZUDnRAlXsq7yp8s8w
         rZaL1laQep8Ah39KOJRIyH0Gz+ePiFd/U+A9vkMa5Y/6tH9PpVvJgqaVaGWduliz5DMc
         lusQZ5FANdhVjNwuiwgRUbs6P6qBEPerd5WZEsl/XhMCnBiwaXpyc9HvvVFEU50j1UmH
         uIvg==
X-Gm-Message-State: AOJu0YwTdcoB1Gn6wmRh6mM6bLsUwIDbs6nvD2d2SG1v+M5EkmA6bZr0
	5WugtIrxjF4xYeYhZlf9/AsU3lr/nkQ+jTQIgl0nhhAtfTfSaveeHSb3pmpV3q0acPFrFJ/i01n
	Wn2vsgZ3lNtasWGVXFuwYGUimG1dEXu+b
X-Google-Smtp-Source: AGHT+IEIM9KqEwGk0vT9Fkux1r966ZbWkc0rjXlspCnBrGvwLf04lsmdyFb5e2PkSZAiJphQ3mU95Hs+5+ErYMdN2ZU=
X-Received: by 2002:a19:381c:0:b0:518:ed96:6b12 with SMTP id
 f28-20020a19381c000000b00518ed966b12mr1636314lfa.61.1713185084056; Mon, 15
 Apr 2024 05:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <d5794f417b276985e21c50cbfeb8a4230bf492d5.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <d5794f417b276985e21c50cbfeb8a4230bf492d5.1713052088.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From: Filipe Manana <fdmanana@gmail.com>
Date: Mon, 15 Apr 2024 13:44:07 +0100
Message-ID: <CAL3q7H7h6VQtLbFCDGNnVVqw2N4Sehg51AiEOZHzqFtgLckb9g@mail.gmail.com>
Subject: Re: [PATCH 06/19] btrfs: initialize btrfs_delayed_ref_head with btrfs_ref
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We are calling init_delayed_ref_head with all of the elements from
> btrfs_ref, clean this up to simply pass in the btrfs_ref and initialize
> the btrfs_delayed_ref_head with the values from the btrfs_ref directly.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c | 53 ++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index f5e4a64283e4..5ff6c109e5bf 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -831,18 +831,20 @@ static noinline void update_existing_head_ref(struc=
t btrfs_trans_handle *trans,
>  }
>
>  static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_re=
f,
> +                                 struct btrfs_ref *generic_ref,
>                                   struct btrfs_qgroup_extent_record *qrec=
ord,
> -                                 u64 bytenr, u64 num_bytes, u64 ref_root=
,
> -                                 u64 reserved, int action, bool is_data,
> -                                 bool is_system, u64 owning_root)
> +                                 u64 reserved)
>  {
>         int count_mod =3D 1;
>         bool must_insert_reserved =3D false;
>
>         /* If reserved is provided, it must be a data extent. */
> -       BUG_ON(!is_data && reserved);
> +       BUG_ON(generic_ref->type !=3D BTRFS_REF_DATA && reserved);
>
> -       switch (action) {
> +       switch (generic_ref->action) {
> +       case BTRFS_ADD_DELAYED_REF:
> +               /* count_mod is already set to 1. */
> +               break;
>         case BTRFS_UPDATE_DELAYED_HEAD:
>                 count_mod =3D 0;
>                 break;
> @@ -871,14 +873,14 @@ static void init_delayed_ref_head(struct btrfs_dela=
yed_ref_head *head_ref,
>         }
>
>         refcount_set(&head_ref->refs, 1);
> -       head_ref->bytenr =3D bytenr;
> -       head_ref->num_bytes =3D num_bytes;
> +       head_ref->bytenr =3D generic_ref->bytenr;
> +       head_ref->num_bytes =3D generic_ref->len;
>         head_ref->ref_mod =3D count_mod;
>         head_ref->reserved_bytes =3D reserved;
>         head_ref->must_insert_reserved =3D must_insert_reserved;
> -       head_ref->owning_root =3D owning_root;
> -       head_ref->is_data =3D is_data;
> -       head_ref->is_system =3D is_system;
> +       head_ref->owning_root =3D generic_ref->owning_root;
> +       head_ref->is_data =3D (generic_ref->type =3D=3D BTRFS_REF_DATA);
> +       head_ref->is_system =3D (generic_ref->ref_root =3D=3D BTRFS_CHUNK=
_TREE_OBJECTID);
>         head_ref->ref_tree =3D RB_ROOT_CACHED;
>         INIT_LIST_HEAD(&head_ref->ref_add_list);
>         RB_CLEAR_NODE(&head_ref->href_node);
> @@ -888,12 +890,12 @@ static void init_delayed_ref_head(struct btrfs_dela=
yed_ref_head *head_ref,
>         mutex_init(&head_ref->mutex);
>
>         if (qrecord) {
> -               if (ref_root && reserved) {
> +               if (generic_ref->ref_root && reserved) {
>                         qrecord->data_rsv =3D reserved;
> -                       qrecord->data_rsv_refroot =3D ref_root;
> +                       qrecord->data_rsv_refroot =3D generic_ref->ref_ro=
ot;
>                 }
> -               qrecord->bytenr =3D bytenr;
> -               qrecord->num_bytes =3D num_bytes;
> +               qrecord->bytenr =3D generic_ref->bytenr;
> +               qrecord->num_bytes =3D generic_ref->len;
>                 qrecord->old_roots =3D NULL;
>         }
>  }
> @@ -1057,16 +1059,11 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_qgroup_extent_record *record =3D NULL;
>         bool qrecord_inserted;
> -       bool is_system;
>         bool merged;
>         int action =3D generic_ref->action;
>         int level =3D generic_ref->tree_ref.level;
> -       u64 bytenr =3D generic_ref->bytenr;
> -       u64 num_bytes =3D generic_ref->len;
>         u64 parent =3D generic_ref->parent;
>
> -       is_system =3D (generic_ref->ref_root =3D=3D BTRFS_CHUNK_TREE_OBJE=
CTID);
> -
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
>         if (!node)
> @@ -1094,9 +1091,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         ref->parent =3D parent;
>         ref->level =3D level;
>
> -       init_delayed_ref_head(head_ref, record, bytenr, num_bytes,
> -                             generic_ref->ref_root, 0, action,
> -                             false, is_system, generic_ref->owning_root)=
;
> +       init_delayed_ref_head(head_ref, generic_ref, record, 0);
>         head_ref->extent_op =3D extent_op;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> @@ -1146,8 +1141,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>         bool qrecord_inserted;
>         int action =3D generic_ref->action;
>         bool merged;
> -       u64 bytenr =3D generic_ref->bytenr;
> -       u64 num_bytes =3D generic_ref->len;
>         u64 parent =3D generic_ref->parent;
>         u64 ref_root =3D generic_ref->ref_root;
>         u64 owner =3D generic_ref->data_ref.ino;
> @@ -1183,8 +1176,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_h=
andle *trans,
>                 }
>         }
>
> -       init_delayed_ref_head(head_ref, record, bytenr, num_bytes, ref_ro=
ot,
> -                             reserved, action, true, false, generic_ref-=
>owning_root);
> +       init_delayed_ref_head(head_ref, generic_ref, record, reserved);
>         head_ref->extent_op =3D NULL;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> @@ -1224,13 +1216,18 @@ int btrfs_add_delayed_extent_op(struct btrfs_tran=
s_handle *trans,
>  {
>         struct btrfs_delayed_ref_head *head_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
> +       struct btrfs_ref generic_ref =3D {
> +               .type =3D BTRFS_REF_METADATA,
> +               .action =3D BTRFS_UPDATE_DELAYED_HEAD,
> +               .bytenr =3D bytenr,
> +               .len =3D num_bytes,
> +       };
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
>         if (!head_ref)
>                 return -ENOMEM;
>
> -       init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
> -                             BTRFS_UPDATE_DELAYED_HEAD, false, false, 0)=
;
> +       init_delayed_ref_head(head_ref, &generic_ref, NULL, 0);
>         head_ref->extent_op =3D extent_op;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> --
> 2.43.0
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

