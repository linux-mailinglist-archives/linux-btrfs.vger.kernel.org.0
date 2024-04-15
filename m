Return-Path: <linux-btrfs+bounces-4272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4A8A50E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C717728CEF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD0824BD;
	Mon, 15 Apr 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STIGhkKE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C953757FA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186094; cv=none; b=A2rdjSGZAXU3krOb4NXgR4H6Czk0oBz4tGRTEsDsbC84YLwiORxD/cFrQho3hm01htKRBMfQJ/3nJRKCKmVyVSiQOtMudWtRI5DCiSPhkjW61twEPZ2EWsS75ofXGA2UyeC8iRvcI+8R5FDg/B7RKb6qhYdBSgCaBZMjq6aHHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186094; c=relaxed/simple;
	bh=+Zubz3KMdA1+gpz8OBr4gwy6M4aeJ9NbdkaMAwNYh9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iwd7HOLC54ad0MsM9SiX1SbIk+xV0AOCxNP1ciIkybkW2/8BjgjCktmy5NqJnCXn6IARfoW2y4sCLAkY9Sfq4h8K3gUlWt3OQtrawI41WV+BZXHhV8nAjOgF+AlSBVeL5B2z+jeEXaoVhdrLw4uEbdDaha3Z2DxFaonHpJOaFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STIGhkKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44D0C2BD11
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186093;
	bh=+Zubz3KMdA1+gpz8OBr4gwy6M4aeJ9NbdkaMAwNYh9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=STIGhkKE0OyIDoug3e4KNkir5/5+6HCAd/T1k9Na16I5ihtKnrKkCeBOFj4uXubL5
	 p26SvrpZHXdkouY05QBSNiBQn4i1RwY2hhMIvLpLgP1oga0YBf4t6a/1RjKA5NGoA5
	 r6CksgAnbs7Volt5KK9tFx/bdS/L0pAeA4kkVkOsdYLNuu2FItVh3NpfYLMJZNBjWB
	 Zv8xN/5mLxvBNFlL05JOTi27fXWQkElayPmInL8J4rQpt9DZQzcNObAd60JynEe+8E
	 9BTYcfvgYX2R/gdwO1I2uKJK93O+j9k+dAaNiFueBwvd+rvK2v6R6wYcenJqx/6/KI
	 +S54vhY1jlusQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44ad785a44so374462466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:01:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYljibC1EZ/Or/miG7eo0kBGw3D/faQeyHJR0/CT/ww0Ror2dW
	jp698vn+vrSbgY+r4xkrZbzXx9MjDWPSLED/tQqz8nUrOXpGoPZ72T0VlLTV8ASgtJyLFILGkCy
	dMM58hruPwn9J7JMNFuyN8NB7ZIg=
X-Google-Smtp-Source: AGHT+IHZxNLo3LiwdboTZpZijVCEuTKkepe2Gna0XN5OIAqjoY5Hf1mVuWpyw1HGm0VdyZFgGyBsCI+TWide4CvXEDc=
X-Received: by 2002:a17:907:7ea1:b0:a52:3bc1:3383 with SMTP id
 qb33-20020a1709077ea100b00a523bc13383mr7214302ejc.36.1713186091584; Mon, 15
 Apr 2024 06:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <6a421fc3d13c9a6520e7e5c041ddb199116c91e6.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <6a421fc3d13c9a6520e7e5c041ddb199116c91e6.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:00:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4xw6pp_7SxmrdAM6P1aeA-g-XjJX6B9S6P+pacpV1GEw@mail.gmail.com>
Message-ID: <CAL3q7H4xw6pp_7SxmrdAM6P1aeA-g-XjJX6B9S6P+pacpV1GEw@mail.gmail.com>
Subject: Re: [PATCH 14/19] btrfs: drop unnecessary arguments from __btrfs_free_extent
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> We have all the information we need in our btrfs_delayed_ref_node, which
> we already pass into __btrfs_free_extent.  Drop the extra arguments and
> just extract the values from btrfs_delayed_ref_node.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent-tree.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 6a8108e151d7..540dadcefb92 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -46,9 +46,7 @@
>
>  static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>                                struct btrfs_delayed_ref_head *href,
> -                              struct btrfs_delayed_ref_node *node, u64 p=
arent,
> -                              u64 root_objectid, u64 owner_objectid,
> -                              u64 owner_offset,
> +                              struct btrfs_delayed_ref_node *node,
>                                struct btrfs_delayed_extent_op *extra_op);
>  static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *exte=
nt_op,
>                                     struct extent_buffer *leaf,
> @@ -1586,9 +1584,7 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>         } else if (node->action =3D=3D BTRFS_ADD_DELAYED_REF) {
>                 ret =3D __btrfs_inc_extent_ref(trans, node, extent_op);
>         } else if (node->action =3D=3D BTRFS_DROP_DELAYED_REF) {
> -               ret =3D __btrfs_free_extent(trans, href, node, parent,
> -                                         node->ref_root, ref->objectid,
> -                                         ref->offset, extent_op);
> +               ret =3D __btrfs_free_extent(trans, href, node, extent_op)=
;
>         } else {
>                 BUG();
>         }
> @@ -1710,11 +1706,9 @@ static int run_delayed_tree_ref(struct btrfs_trans=
_handle *trans,
>  {
>         int ret =3D 0;
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_delayed_tree_ref *ref;
>         u64 parent =3D 0;
>         u64 ref_root =3D 0;
>
> -       ref =3D btrfs_delayed_node_to_tree_ref(node);
>         trace_run_delayed_tree_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY)
> @@ -1744,8 +1738,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_=
handle *trans,
>         } else if (node->action =3D=3D BTRFS_ADD_DELAYED_REF) {
>                 ret =3D __btrfs_inc_extent_ref(trans, node, extent_op);
>         } else if (node->action =3D=3D BTRFS_DROP_DELAYED_REF) {
> -               ret =3D __btrfs_free_extent(trans, href, node, parent, re=
f_root,
> -                                         ref->level, 0, extent_op);
> +               ret =3D __btrfs_free_extent(trans, href, node, extent_op)=
;
>         } else {
>                 BUG();
>         }
> @@ -3077,9 +3070,7 @@ static int do_free_extent_accounting(struct btrfs_t=
rans_handle *trans,
>   */
>  static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>                                struct btrfs_delayed_ref_head *href,
> -                              struct btrfs_delayed_ref_node *node, u64 p=
arent,
> -                              u64 root_objectid, u64 owner_objectid,
> -                              u64 owner_offset,
> +                              struct btrfs_delayed_ref_node *node,
>                                struct btrfs_delayed_extent_op *extent_op)
>  {
>         struct btrfs_fs_info *info =3D trans->fs_info;
> @@ -3099,6 +3090,8 @@ static int __btrfs_free_extent(struct btrfs_trans_h=
andle *trans,
>         u64 refs;
>         u64 bytenr =3D node->bytenr;
>         u64 num_bytes =3D node->num_bytes;
> +       u64 owner_objectid =3D btrfs_delayed_ref_owner(node);
> +       u64 owner_offset =3D btrfs_delayed_ref_offset(node);
>         bool skinny_metadata =3D btrfs_fs_incompat(info, SKINNY_METADATA)=
;
>         u64 delayed_ref_root =3D href->owning_root;
>
> @@ -3124,7 +3117,7 @@ static int __btrfs_free_extent(struct btrfs_trans_h=
andle *trans,
>                 skinny_metadata =3D false;
>
>         ret =3D lookup_extent_backref(trans, path, &iref, bytenr, num_byt=
es,
> -                                   parent, root_objectid, owner_objectid=
,
> +                                   node->parent, node->ref_root, owner_o=
bjectid,
>                                     owner_offset);
>         if (ret =3D=3D 0) {
>                 /*
> @@ -3226,7 +3219,7 @@ static int __btrfs_free_extent(struct btrfs_trans_h=
andle *trans,
>         } else if (WARN_ON(ret =3D=3D -ENOENT)) {
>                 abort_and_dump(trans, path,
>  "unable to find ref byte nr %llu parent %llu root %llu owner %llu offset=
 %llu slot %d",
> -                              bytenr, parent, root_objectid, owner_objec=
tid,
> +                              bytenr, node->parent, node->ref_root, owne=
r_objectid,
>                                owner_offset, path->slots[0]);
>                 goto out;
>         } else {
> --
> 2.43.0
>
>

