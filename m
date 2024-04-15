Return-Path: <linux-btrfs+bounces-4264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006798A4F65
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954211F21A09
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49836FE26;
	Mon, 15 Apr 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6fj3nvx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDF5FBA3
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185120; cv=none; b=JfqAvbdpVvA39+rbhAurDqR2btIIEGbH734hB2gE5kOErqIgmOx9C28fsIqPJQwZfIDE5XLp414PvCShcguzGfqr+xcfgcXCmPxwA5WkmoofCN+8Niu/7Rv9+3pzEts1ozWZ5Hhc3kLpf75VyfOgYK4HE4Aw7ujGg8MAApBdNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185120; c=relaxed/simple;
	bh=ycU0aKrEQQxTFIBnItYbqo8vshXO86oFOqNdpRxTccU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpxHsM1nxD49a6lhTCBTJCBtYY6oFSMb/7GLaPGx6lD8dHXEwFCkdE0/+gDYCFEOsBwiI4gYVvK5VdlnRD+SrgXQrXIBvwPUtSVFKrsIh0PHLNbSG7Y0ryKMMnCgxH2PXRvS47BXRVpl3yD4WB3JQR+e8Sy4GsqOKaAujEgtG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6fj3nvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C91C3277B
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185119;
	bh=ycU0aKrEQQxTFIBnItYbqo8vshXO86oFOqNdpRxTccU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H6fj3nvxqIxgjBJGUjH0nPKhGDohJMk390DP1pikJ/rsb/fEoMMaW8z3cJPQkR6DI
	 4jpMB78p+qYqpCOFWKIsFn1IABSKY/9c+Pd5UgMti+0HIyHwOWo42QJYXrvRDUdYfZ
	 h245viesf5Ly/I7UFSCeG7okAWwxOS38Hb+m39UGckaj2cCS5/PErM51ZsgGtrQETQ
	 6nwa+fEUBDwohIwjf8FWtONJkqLZ2ExIXd4tlJMR9KDq6c7csev9zn/n7U2JUnV9vE
	 LNx5R190Nah5oa+zS7wOlfKV2SFj4pv6MCyvk+1icAt4kSIm9XTT3pC2VjEHL2fHc5
	 sCadiyc610PSg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518e2283bd3so1542491e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:45:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzO1xwsMNXj6tTOAPTO5Dp+qOrLvVTUPsYzu7zL+r/jusnYC6t1
	5ZcZsKhKWBABAOP4wsSJtfPTzAXHM21yHwq/dfd5Mql/crt1Y9sKGee7DHlSwlTjbOnQ58BTs2V
	VWvTDFKcWQAzJLCgQBoYOV5SU7FE=
X-Google-Smtp-Source: AGHT+IEtpN3HK5VEbNJaUrhzPaxLbbVgxIPjpSTi/WHFCGBF9+GlP/sY4Jnvak6rMjDuQ6Tnrq9VMd4Rwff8NokOHh0=
X-Received: by 2002:a05:6512:32a6:b0:515:b0be:3a42 with SMTP id
 q6-20020a05651232a600b00515b0be3a42mr7691000lfe.33.1713185117882; Mon, 15 Apr
 2024 05:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <5b5efef95b6aeed43f99e156d8bbf55f5f9254c4.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <5b5efef95b6aeed43f99e156d8bbf55f5f9254c4.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:44:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Mr1DbEcAe61S59NceN-JO0EC+M509NtMiheaF6KVJiA@mail.gmail.com>
Message-ID: <CAL3q7H5Mr1DbEcAe61S59NceN-JO0EC+M509NtMiheaF6KVJiA@mail.gmail.com>
Subject: Re: [PATCH 07/19] btrfs: move ref specific initialization into init_delayed_ref_common
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Now that the btrfs_delayed_ref_node contains a union of the data and
> metadata specific information we can move the initialization into
> init_delayed_ref_common and just use the btrfs_ref to initialize the
> correct fields of the reference.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/delayed-ref.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 5ff6c109e5bf..743cc52c30af 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1007,6 +1007,17 @@ static void init_delayed_ref_common(struct btrfs_f=
s_info *fs_info,
>         ref->type =3D btrfs_ref_type(generic_ref);
>         RB_CLEAR_NODE(&ref->ref_node);
>         INIT_LIST_HEAD(&ref->add_list);
> +
> +       if (generic_ref->type =3D=3D BTRFS_REF_DATA) {
> +               ref->data_ref.root =3D generic_ref->ref_root;
> +               ref->data_ref.parent =3D generic_ref->parent;
> +               ref->data_ref.objectid =3D generic_ref->data_ref.ino;
> +               ref->data_ref.offset =3D generic_ref->data_ref.offset;
> +       } else {
> +               ref->tree_ref.root =3D generic_ref->ref_root;
> +               ref->tree_ref.parent =3D generic_ref->parent;
> +               ref->tree_ref.level =3D generic_ref->tree_ref.level;
> +       }
>  }
>
>  void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 m=
od_root,
> @@ -1061,8 +1072,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         bool qrecord_inserted;
>         bool merged;
>         int action =3D generic_ref->action;
> -       int level =3D generic_ref->tree_ref.level;
> -       u64 parent =3D generic_ref->parent;
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_METADATA && generic_ref=
->action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> @@ -1087,9 +1096,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_h=
andle *trans,
>         ref =3D btrfs_delayed_node_to_tree_ref(node);
>
>         init_delayed_ref_common(fs_info, node, generic_ref);
> -       ref->root =3D generic_ref->ref_root;
> -       ref->parent =3D parent;
> -       ref->level =3D level;
>
>         init_delayed_ref_head(head_ref, generic_ref, record, 0);
>         head_ref->extent_op =3D extent_op;
> @@ -1141,10 +1147,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>         bool qrecord_inserted;
>         int action =3D generic_ref->action;
>         bool merged;
> -       u64 parent =3D generic_ref->parent;
> -       u64 ref_root =3D generic_ref->ref_root;
> -       u64 owner =3D generic_ref->data_ref.ino;
> -       u64 offset =3D generic_ref->data_ref.offset;
>
>         ASSERT(generic_ref->type =3D=3D BTRFS_REF_DATA && action);
>         node =3D kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS=
);
> @@ -1154,11 +1156,6 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>         ref =3D btrfs_delayed_node_to_data_ref(node);
>
>         init_delayed_ref_common(fs_info, node, generic_ref);
> -       ref->root =3D ref_root;
> -       ref->parent =3D parent;
> -       ref->objectid =3D owner;
> -       ref->offset =3D offset;
> -
>
>         head_ref =3D kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_=
NOFS);
>         if (!head_ref) {
> --
> 2.43.0
>
>

