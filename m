Return-Path: <linux-btrfs+bounces-19600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C87CAFDD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 13:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11F83014731
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AEE31ED7B;
	Tue,  9 Dec 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEPosgXz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F42E091B
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281943; cv=none; b=c/sChZ7ZEeayyewR5xRAsx8kzncj4dyWFK4eiuizj3dXQpgbLgqumZBx9r068oY1GgiAPQ/KvRPJz7odQlOckhBoBpuEmxDMkZX9L+78EKQowlh15rY+j52HWKsxS9L1gDDbYFpMSxxvPqI+6j/cAHYplpd0ijZIoUn1CwHxW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281943; c=relaxed/simple;
	bh=WkSEZCblPxWwZ3LBYXYTGPnzDpnhgmXTuLf1ErWK4LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRlJv4nAJsnkxiKu/wi05mrS504Lb65hj7EiHpeNn+8AttW5SoG9UQ1mhc5VSAUsC8/zwGppA8mZ5YluYGNejaZfE9qMvPbiiOMdYTkwhInEAORDqWWsH7sRSgY/hwOi6IuVaFtZ1KHvWyWES0qT6vLE/Li4j9ZNLIZUnkNMMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEPosgXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB920C4CEF5
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281942;
	bh=WkSEZCblPxWwZ3LBYXYTGPnzDpnhgmXTuLf1ErWK4LY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEPosgXznegVLzfyv+QZsmdeKnwcBzvxQBHSrhtLSMQuF16bm2Q91QlziHEXCLYGP
	 wclLin93XYlOim9dQtHaqMyELs9npxIzu7Eiq4tZIYhbhdjw2vbB5vb9XT3IUw5B8L
	 UQltt3RFWVLxvL1Q/QEfMyO854+q2Mxyx6M2Nb4ps60BQj6BhLQmW3xB2G/3WTQVMa
	 67RlH0433Zc+7Jzze37UFUhkbXea9UVnZLtQqgvl4v6mb/hSBBefq9UFxkyprQAh6R
	 fyA3bI46aJzGTih78qZaWnoGqOwbx3Kkyc2VztgjiTUdn0XL6V84yuELWAsgWF0hd/
	 Qqmmemx0fF+UA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79ea617f55so1051934366b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Dec 2025 04:05:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yxd7ENGS1mKkPMTxsCZSWzDuFSZt7g7nicUMDVpDDPCOaMPaG6e
	1wS81U/hCOuWSe8CN8/TSRz0JxtFyulYDfEfBuZQpzfXiVreUBo1L3R2lpAnkFqS3IUd2UK/RSa
	RzQylttQph/mobey5uJnBeBdKQ1zfNRc=
X-Google-Smtp-Source: AGHT+IFoxyWFfYGOcYL8X0/pyvWVRN244we/sx4Jk2TIPwJfQ+M84/wjnW95y9rwmAegJdcdLaC8su3fUGeyeI0FQcw=
X-Received: by 2002:a17:907:7250:b0:b76:bb0e:5ac9 with SMTP id
 a640c23a62f3a-b7a2455e570mr1319003866b.40.1765281941231; Tue, 09 Dec 2025
 04:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209033747.31010-1-sunk67188@gmail.com> <20251209033747.31010-5-sunk67188@gmail.com>
In-Reply-To: <20251209033747.31010-5-sunk67188@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 9 Dec 2025 12:05:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
X-Gm-Features: AQt7F2qw1a0kTLkiseB3lTOqVB8AxwbuQLD8LTdLTlzydwTx2KBYmO2UOFq9YYo
Message-ID: <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 3:38=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> wr=
ote:
>
> There's a common parttern in callers of btrfs_prev_leaf:
> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
>
> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
> valid slot and cleanup its over complex logic.
>
> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
> should insert the key.

Hell no! path->slots[0] can end up pointing to the original key, which is w=
hat
should be the location for the computed previous key, and the
comments there explain how that can happen.

> So just slots[0]-- is enough to get the previous
> item.

All that logic in btrfs_prev_leaf() is necessary.

We release the path and then do a btrfs_search_slot() for the computed
previous key, but after the release and before the search, the
structure of the tree may have changed, keys moved between leaves, new
keys added, previous keys removed, and so on.

I left all such cases commented in detail in btrfs_prev_leaf() for a reason=
...

Removing that logic is just wrong and there's no explanation here for it.

Thanks.



>
> And then remove the related logic and cleanup the callers.
>
> ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]))
> is enough to make sure that nritems !=3D 0 and slots[0] points to a valid
> btrfs_item.
>
> And getting a `nritems=3D=3D0` when btrfs_prev_leaf() returns 0 is a logi=
c
> error because btrfs_pref_leaf() should always
>
> 1. either find a non-empty leaf
> 2. or return 1
>
> So we can use ASSERT here.
>
> No functional changes.
>
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/ctree.c | 100 +++++++++--------------------------------------
>  1 file changed, 19 insertions(+), 81 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bb886f9508e2..07e6433cde61 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2365,12 +2365,9 @@ int btrfs_search_old_slot(struct btrfs_root *root,=
 const struct btrfs_key *key,
>  static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *p=
ath)
>  {
>         struct btrfs_key key;
> -       struct btrfs_key orig_key;
> -       struct btrfs_disk_key found_key;
>         int ret;
>
>         btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
> -       orig_key =3D key;
>
>         if (key.offset > 0) {
>                 key.offset--;
> @@ -2390,48 +2387,12 @@ static int btrfs_prev_leaf(struct btrfs_root *roo=
t, struct btrfs_path *path)
>         if (ret <=3D 0)
>                 return ret;
>
> -       /*
> -        * Previous key not found. Even if we were at slot 0 of the leaf =
we had
> -        * before releasing the path and calling btrfs_search_slot(), we =
now may
> -        * be in a slot pointing to the same original key - this can happ=
en if
> -        * after we released the path, one of more items were moved from =
a
> -        * sibling leaf into the front of the leaf we had due to an inser=
tion
> -        * (see push_leaf_right()).
> -        * If we hit this case and our slot is > 0 and just decrement the=
 slot
> -        * so that the caller does not process the same key again, which =
may or
> -        * may not break the caller, depending on its logic.
> -        */
> -       if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
> -               btrfs_item_key(path->nodes[0], &found_key, path->slots[0]=
);
> -               ret =3D btrfs_comp_keys(&found_key, &orig_key);
> -               if (ret =3D=3D 0) {
> -                       if (path->slots[0] > 0) {
> -                               path->slots[0]--;
> -                               return 0;
> -                       }
> -                       /*
> -                        * At slot 0, same key as before, it means orig_k=
ey is
> -                        * the lowest, leftmost, key in the tree. We're d=
one.
> -                        */
> -                       return 1;
> -               }
> -       }
> +       /* There's no smaller keys in the whole tree. */
> +       if (path->slots[0] =3D=3D 0)
> +               return 1;
>
> -       btrfs_item_key(path->nodes[0], &found_key, 0);
> -       ret =3D btrfs_comp_keys(&found_key, &key);
> -       /*
> -        * We might have had an item with the previous key in the tree ri=
ght
> -        * before we released our path. And after we released our path, t=
hat
> -        * item might have been pushed to the first slot (0) of the leaf =
we
> -        * were holding due to a tree balance. Alternatively, an item wit=
h the
> -        * previous key can exist as the only element of a leaf (big fat =
item).
> -        * Therefore account for these 2 cases, so that our callers (like
> -        * btrfs_previous_item) don't miss an existing item with a key ma=
tching
> -        * the previous key we computed above.
> -        */
> -       if (ret <=3D 0)
> -               return 0;
> -       return 1;
> +       path->slots[0]--;
> +       return 0;
>  }
>
>  /*
> @@ -2461,19 +2422,10 @@ int btrfs_search_slot_for_read(struct btrfs_root =
*root,
>                 if (p->slots[0] >=3D btrfs_header_nritems(p->nodes[0]))
>                         return btrfs_next_leaf(root, p);
>         } else {
> -               if (p->slots[0] =3D=3D 0) {
> -                       ret =3D btrfs_prev_leaf(root, p);
> -                       if (ret < 0)
> -                               return ret;
> -                       if (!ret) {
> -                               if (p->slots[0] =3D=3D btrfs_header_nrite=
ms(p->nodes[0]))
> -                                       p->slots[0]--;
> -                               return 0;
> -                       }
> -                       return 1;
> -               } else {
> -                       p->slots[0]--;
> -               }
> +               if (p->slots[0] =3D=3D 0)
> +                       return btrfs_prev_leaf(root, p);
> +
> +               p->slots[0]--;
>         }
>         return 0;
>  }
> @@ -4957,26 +4909,19 @@ int btrfs_previous_item(struct btrfs_root *root,
>                         int type)
>  {
>         struct btrfs_key found_key;
> -       struct extent_buffer *leaf;
> -       u32 nritems;
>         int ret;
>
>         while (1) {
>                 if (path->slots[0] =3D=3D 0) {
>                         ret =3D btrfs_prev_leaf(root, path);
> -                       if (ret !=3D 0)
> +                       if (ret)
>                                 return ret;
> -               } else {
> -                       path->slots[0]--;
> -               }
> -               leaf =3D path->nodes[0];
> -               nritems =3D btrfs_header_nritems(leaf);
> -               if (nritems =3D=3D 0)
> -                       return 1;
> -               if (path->slots[0] =3D=3D nritems)
> +               } else
>                         path->slots[0]--;
>
> -               btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +               ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[=
0]));
> +
> +               btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->s=
lots[0]);
>                 if (found_key.objectid < min_objectid)
>                         break;
>                 if (found_key.type =3D=3D type)
> @@ -4998,26 +4943,19 @@ int btrfs_previous_extent_item(struct btrfs_root =
*root,
>                         struct btrfs_path *path, u64 min_objectid)
>  {
>         struct btrfs_key found_key;
> -       struct extent_buffer *leaf;
> -       u32 nritems;
>         int ret;
>
>         while (1) {
>                 if (path->slots[0] =3D=3D 0) {
>                         ret =3D btrfs_prev_leaf(root, path);
> -                       if (ret !=3D 0)
> +                       if (ret)
>                                 return ret;
> -               } else {
> -                       path->slots[0]--;
> -               }
> -               leaf =3D path->nodes[0];
> -               nritems =3D btrfs_header_nritems(leaf);
> -               if (nritems =3D=3D 0)
> -                       return 1;
> -               if (path->slots[0] =3D=3D nritems)
> +               } else
>                         path->slots[0]--;
>
> -               btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +               ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[=
0]));
> +
> +               btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->s=
lots[0]);
>                 if (found_key.objectid < min_objectid)
>                         break;
>                 if (found_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> --
> 2.51.2
>
>

