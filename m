Return-Path: <linux-btrfs+bounces-4274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE78A5102
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03681F21137
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A612AAE0;
	Mon, 15 Apr 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3962b6g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011776033
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186316; cv=none; b=HsHVjNdoS85TWAjXanh2ktEniXTwrAnbHUd6cwEjOT62WdqbPAshVC29dPqJ2EMKaiecEm5Mz3DhXXi6oQccE/UTkecad9p+IJZ0HtImK1XV/tfMht5jQ9cUZBAeHBBtklOJAA3GXvvyoqV1JQ5C4TqnOkIUMYMXAsj5wSN/518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186316; c=relaxed/simple;
	bh=1q2cboRjHYviLodD7Oa6CiqYdN84ODPyjF0/TaQeRkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzXGoq0208ezpZqA8/IJ1sbrXq67QbZR0emYbcn7MlfY4reLjB6Nq4waoWsBmH2rKxZwC6XHi0BPl/l1OnUrQi3TtQtJ7juW/jEor/89g5Xh+NXakIlsTKIgNxy8W7veU4nuJi289jZU6KT1V8G9Azl5y6U9BhuRWeTJXBBotfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3962b6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96633C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186315;
	bh=1q2cboRjHYviLodD7Oa6CiqYdN84ODPyjF0/TaQeRkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I3962b6gl2sy6ydMLosmfMLr07r7DHhfCXaQinfamnDzw37PJtLlpSI4qKwLzH+PH
	 XdlBipg93M7Nm9Jqtfh6Mr4aSaxnmhlh5kUABamutqCc8vtg+DelotYQaMW8kWDH1s
	 PolHStNv98RxJ2aEqXzxyuuWsuJ/ioUU6DeP3/2tEo6NEO65JfRQ4dcs4Y4Se+igeD
	 BsKalc1VYqwja9yqEADOrL0fFKwNMKOl9d0ysMzoR+pg42butQ6LKw9iaq9LfqAREQ
	 xOsPPw8906XCzSAj+UW7X5lAnq02K9CKCAH4vbRr6SDBVQVbHFZbVuSaiEcw3TMN1i
	 7cme8/gCtPhSA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51ddc783e3so384925266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 06:05:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFRvoNEHl1cE74uprFzoCz+1YZgb9rHy3Ho4pWx2qOXPWTG4rO
	LAuCP3v8dTc5NOcZTn+ieFRgIGQkx4XauLdkvkCN5KO1lfByrymDNDSHX6VPPslnxjNFYOVtDel
	yhZpW+xwZzOcLi05qjAjNfyG3Qy8=
X-Google-Smtp-Source: AGHT+IGgr5xSy/O29vgwTw44cdh3pgQs5AWgvrwrmbc0RP3AAZiyaB8WG3vtLO4iYNRUjNvXb48LIIwh/5bTA4w7fjI=
X-Received: by 2002:a17:906:4956:b0:a52:6a4b:c810 with SMTP id
 f22-20020a170906495600b00a526a4bc810mr1537219ejt.35.1713186314100; Mon, 15
 Apr 2024 06:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <930cd415c44b9b034fa8a23a887275d12fad4e87.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <930cd415c44b9b034fa8a23a887275d12fad4e87.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 14:04:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Y2qqgiiO7VFinpu2wWNVL2r=o5Dgqf81BoN0yY9Az9w@mail.gmail.com>
Message-ID: <CAL3q7H5Y2qqgiiO7VFinpu2wWNVL2r=o5Dgqf81BoN0yY9Az9w@mail.gmail.com>
Subject: Re: [PATCH 16/19] btrfs: stop referencing btrfs_delayed_data_ref directly
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 2:51=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Now that most of our elements are inside of btrfs_delayed_ref_node
> directly and we have helpers for the delayed_data_ref bits, go ahead and
> remove all direct usage of btrfs_delayed_data_ref and use the helpers
> where needed.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/backref.c           |  7 ++-----
>  fs/btrfs/extent-tree.c       | 20 +++++++++++---------
>  include/trace/events/btrfs.h |  1 -
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 98a0cf68d198..eb9f2f078a26 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -947,12 +947,9 @@ static int add_delayed_refs(const struct btrfs_fs_in=
fo *fs_info,
>                 }
>                 case BTRFS_EXTENT_DATA_REF_KEY: {
>                         /* NORMAL INDIRECT DATA backref */
> -                       struct btrfs_delayed_data_ref *ref;
> -                       ref =3D btrfs_delayed_node_to_data_ref(node);
> -
> -                       key.objectid =3D ref->objectid;
> +                       key.objectid =3D btrfs_delayed_ref_owner(node);
>                         key.type =3D BTRFS_EXTENT_DATA_KEY;
> -                       key.offset =3D ref->offset;
> +                       key.offset =3D btrfs_delayed_ref_offset(node);
>
>                         /*
>                          * If we have a share check context and a referen=
ce for
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index d85bc31f2e57..839c64d5a12d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1543,11 +1543,9 @@ static int run_delayed_data_ref(struct btrfs_trans=
_handle *trans,
>                                 bool insert_reserved)
>  {
>         int ret =3D 0;
> -       struct btrfs_delayed_data_ref *ref;
>         u64 parent =3D 0;
>         u64 flags =3D 0;
>
> -       ref =3D btrfs_delayed_node_to_data_ref(node);
>         trace_run_delayed_data_ref(trans->fs_info, node);
>
>         if (node->type =3D=3D BTRFS_SHARED_DATA_REF_KEY)
> @@ -1562,6 +1560,8 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>                         .is_inc =3D true,
>                         .generation =3D trans->transid,
>                 };
> +               u64 owner =3D btrfs_delayed_ref_owner(node);
> +               u64 offset =3D btrfs_delayed_ref_offset(node);
>
>                 if (extent_op)
>                         flags |=3D extent_op->flags_to_set;
> @@ -1571,9 +1571,9 @@ static int run_delayed_data_ref(struct btrfs_trans_=
handle *trans,
>                 key.offset =3D node->num_bytes;
>
>                 ret =3D alloc_reserved_file_extent(trans, parent, node->r=
ef_root,
> -                                                flags, ref->objectid,
> -                                                ref->offset, &key,
> -                                                node->ref_mod, href->own=
ing_root);
> +                                                flags, owner, offset, &k=
ey,
> +                                                node->ref_mod,
> +                                                href->owning_root);
>                 free_head_ref_squota_rsv(trans->fs_info, href);
>                 if (!ret)
>                         ret =3D btrfs_record_squota_delta(trans->fs_info,=
 &delta);
> @@ -2258,7 +2258,6 @@ static noinline int check_delayed_ref(struct btrfs_=
root *root,
>  {
>         struct btrfs_delayed_ref_head *head;
>         struct btrfs_delayed_ref_node *ref;
> -       struct btrfs_delayed_data_ref *data_ref;
>         struct btrfs_delayed_ref_root *delayed_refs;
>         struct btrfs_transaction *cur_trans;
>         struct rb_node *node;
> @@ -2312,6 +2311,9 @@ static noinline int check_delayed_ref(struct btrfs_=
root *root,
>          */
>         for (node =3D rb_first_cached(&head->ref_tree); node;
>              node =3D rb_next(node)) {
> +               u64 ref_owner;
> +               u64 ref_offset;
> +
>                 ref =3D rb_entry(node, struct btrfs_delayed_ref_node, ref=
_node);
>                 /* If it's a shared ref we know a cross reference exists =
*/
>                 if (ref->type !=3D BTRFS_EXTENT_DATA_REF_KEY) {
> @@ -2319,15 +2321,15 @@ static noinline int check_delayed_ref(struct btrf=
s_root *root,
>                         break;
>                 }
>
> -               data_ref =3D btrfs_delayed_node_to_data_ref(ref);
> +               ref_owner =3D btrfs_delayed_ref_owner(ref);
> +               ref_offset =3D btrfs_delayed_ref_offset(ref);
>
>                 /*
>                  * If our ref doesn't match the one we're currently looki=
ng at
>                  * then we have a cross reference.
>                  */
>                 if (ref->ref_root !=3D root->root_key.objectid ||
> -                   data_ref->objectid !=3D objectid ||
> -                   data_ref->offset !=3D offset) {
> +                   ref_owner !=3D objectid || ref_offset !=3D offset) {
>                         ret =3D 1;
>                         break;
>                 }
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index e6cee75c384c..89fa96fd95b4 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -17,7 +17,6 @@ struct btrfs_file_extent_item;
>  struct btrfs_ordered_extent;
>  struct btrfs_delayed_ref_node;
>  struct btrfs_delayed_tree_ref;
> -struct btrfs_delayed_data_ref;
>  struct btrfs_delayed_ref_head;
>  struct btrfs_block_group;
>  struct btrfs_free_cluster;
> --
> 2.43.0
>
>

