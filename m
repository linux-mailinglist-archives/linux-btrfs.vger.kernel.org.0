Return-Path: <linux-btrfs+bounces-6460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8779312B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733A6B22507
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F05188CD9;
	Mon, 15 Jul 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKVsv9VB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A816E877
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041389; cv=none; b=cPF5keHdcWcuNwlHdWNeFJEI+uQKqlBI7tRflqsFfhvC9r6qSFSkXrvB6WyD9+dZtpD3sCKQe1P/ij55OrAbyI5vHV9SyTEZ2IzXGzy8JABGURSOY3zBfklXs32lT1ulMSLtoPvcWsBznrCpsupVKxHfuvNT7Xs8U2gDLfNT18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041389; c=relaxed/simple;
	bh=UhGysZfwN/rp427OrBl8iN/ur14mQw8Tvz1cXgajAYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpya2WHd7orR+QWqnMUm/bNzYfMqM3S16tl2FK9JG2wBdJoHBgPIhrd1ztFOBoRKu85RfZn2as8OlVHPj0tPPQklcweTFFvU2UXCNqHSTGXDP2tkp+bWcQXKV0tnhN3f47HYKQ8SGznFCJQQUjGQRueIsEY5qPFfdUXTJHEVmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKVsv9VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2FDC4AF0A
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721041388;
	bh=UhGysZfwN/rp427OrBl8iN/ur14mQw8Tvz1cXgajAYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NKVsv9VBqOGe2Y+UvgaCvtS5QS9MqcRNsvjTk8tZMR43xRyXCEnVgiBX/Palf8qel
	 o1KSTXiiX1Ui/HhuI62myomwpVYwFXsC1irXKfUeqL/0/064H8mPDb58F51QQnJy+E
	 AtRIQwRuCo6IZUUEcaMkJ1NdeyBar7KoJiwU10kvci/1bA4C2Y3wtIe3kJI0gHQTm4
	 LBL3PJPMK9JqAetTsiNt5twGvKgxMGW/VxSl39J2OdopvbMZFMMdybWbmL/ykuI+gu
	 5n++yPt5j9hf5fkHoAxPdks8Tip1xsd06hrDs6vf1kZyeh4KrAAlrA5cwpuvYLzBJV
	 BaovNJ6jK4LhQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fd513f18bso440548866b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 04:03:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxYB3c1hQDQbUFvjFYb2yj4W5WdD//8hKz4H37HoMdVH1OA87Gy
	laN30vOQdu3o5XZrBgvzhKUkmgekKC5TyVYM4UeFTl+X5Vm8u3ARQLGR81Wn1rw4HXLZXPdrYbm
	2gTnExqSr8afbPrSOiZUOOV58rrk=
X-Google-Smtp-Source: AGHT+IEjzK1fnX+sX8UPO2rl4YRMbYa4Kn9ojIWcKEp1hHlnaGZBhSZUu0uIbtv+kWSDB+mezfz6EB+3h21PluCAroQ=
X-Received: by 2002:a17:906:c007:b0:a72:6f10:52da with SMTP id
 a640c23a62f3a-a780b8848d0mr1181427566b.59.1721041386939; Mon, 15 Jul 2024
 04:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b16a2e2f704d80edfb0f52ed91ba50fbd39dbaa.1721031688.git.wqu@suse.com>
In-Reply-To: <2b16a2e2f704d80edfb0f52ed91ba50fbd39dbaa.1721031688.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Jul 2024 12:02:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6UDyKZg9zmEFaST_ZwXtB1-fvtGGzGeeoWBjr6JqjVyA@mail.gmail.com>
Message-ID: <CAL3q7H6UDyKZg9zmEFaST_ZwXtB1-fvtGGzGeeoWBjr6JqjVyA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: validate dref root and objectid
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Kai Krakow <hurikhan77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:23=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CORRUPTION]
> There is a bug report that btrfs flips RO due to a corruption in the
> extent tree, the involved dumps looks like this:
>
>         item 188 key (402811572224 168 4096) itemoff 14598 itemsize 79
>                 extent refs 3 gen 3678544 flags 1
>                 ref#0: extent data backref root 13835058055282163977 obje=
ctid 281473384125923 offset 81432576 count 1
>                 ref#1: shared data backref parent 1947073626112 count 1
>                 ref#2: shared data backref parent 1156030103552 count 1
>  BTRFS critical (device vdc1: state EA): unable to find ref byte nr 40281=
1572224 parent 0 root 265 owner 28703026 offset 81432576 slot 189
>  BTRFS error (device vdc1: state EA): failed to run delayed ref for logic=
al 402811572224 num_bytes 4096 type 178 action 2 ref_mod 1: -2
>
> [CAUSE]
> The corrupted entry is ref#0 of item 188.
> The root number 13835058055282163977 is beyond the upper limit for root
> items (the current limit is 1 << 48), and the objectid also looks
> suspicious.
>
> Only the offset and count is correct.
>
> [ENHANCEMENT]
> Although it's still unknown why we have such many bytes corrupted
> randomly, we can still enhance the tree-checker for data backrefs by:
>
> - Validate the root value
>   For now there should only be 3 types of roots can have data backref:
>   * subvolume trees
>   * data reloc trees
>   * root tree
>     Only for v1 space cache
>
> - validate the objectid value
>   The objectid should be a valid inode number.
>
> Hopefully we can catch such problem in the future with the new checkers.
>
> Reported-by: Kai Krakow <hurikhan77@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=
=3DJywF+D1_h+JYxe=3DWKp-Q@mail.gmail.com/#t
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tree-checker.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 6388786fd8b5..d9d0f1f91feb 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1289,6 +1289,19 @@ static void extent_err(const struct extent_buffer =
*eb, int slot,
>         va_end(args);
>  }
>
> +static int is_valid_dref_root(u64 rootid)

This only needs to return true or false, so use a bool type please.

> +{
> +       /*
> +        * The following tree root objectid are allowed to have a data ba=
ckref:

objectid -> objectids (plural)

Everything else looks fine, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +        * - subvolume trees
> +        * - data reloc tree
> +        * - tree root
> +        *   For v1 space cache
> +        */
> +       return is_fstree(rootid) || rootid =3D=3D BTRFS_DATA_RELOC_TREE_O=
BJECTID ||
> +              rootid =3D=3D BTRFS_ROOT_TREE_OBJECTID;
> +}
> +
>  static int check_extent_item(struct extent_buffer *leaf,
>                              struct btrfs_key *key, int slot,
>                              struct btrfs_key *prev_key)
> @@ -1441,6 +1454,8 @@ static int check_extent_item(struct extent_buffer *=
leaf,
>                 struct btrfs_extent_data_ref *dref;
>                 struct btrfs_shared_data_ref *sref;
>                 u64 seq;
> +               u64 dref_root;
> +               u64 dref_objectid;
>                 u64 dref_offset;
>                 u64 inline_offset;
>                 u8 inline_type;
> @@ -1484,11 +1499,26 @@ static int check_extent_item(struct extent_buffer=
 *leaf,
>                  */
>                 case BTRFS_EXTENT_DATA_REF_KEY:
>                         dref =3D (struct btrfs_extent_data_ref *)(&iref->=
offset);
> +                       dref_root =3D btrfs_extent_data_ref_root(leaf, dr=
ef);
> +                       dref_objectid =3D btrfs_extent_data_ref_objectid(=
leaf, dref);
>                         dref_offset =3D btrfs_extent_data_ref_offset(leaf=
, dref);
>                         seq =3D hash_extent_data_ref(
>                                         btrfs_extent_data_ref_root(leaf, =
dref),
>                                         btrfs_extent_data_ref_objectid(le=
af, dref),
>                                         btrfs_extent_data_ref_offset(leaf=
, dref));
> +                       if (unlikely(!is_valid_dref_root(dref_root))) {
> +                               extent_err(leaf, slot,
> +                                          "invalid data ref root value %=
llu",
> +                                          dref_root);
> +                               return -EUCLEAN;
> +                       }
> +                       if (unlikely(dref_objectid < BTRFS_FIRST_FREE_OBJ=
ECTID ||
> +                                    dref_objectid > BTRFS_LAST_FREE_OBJE=
CTID)) {
> +                               extent_err(leaf, slot,
> +                                          "invalid data ref objectid val=
ue %llu",
> +                                          dref_root);
> +                               return -EUCLEAN;
> +                       }
>                         if (unlikely(!IS_ALIGNED(dref_offset,
>                                                  fs_info->sectorsize))) {
>                                 extent_err(leaf, slot,
> @@ -1627,6 +1657,8 @@ static int check_extent_data_ref(struct extent_buff=
er *leaf,
>                 return -EUCLEAN;
>         }
>         for (; ptr < end; ptr +=3D sizeof(*dref)) {
> +               u64 root;
> +               u64 objectid;
>                 u64 offset;
>
>                 /*
> @@ -1634,7 +1666,22 @@ static int check_extent_data_ref(struct extent_buf=
fer *leaf,
>                  * overflow from the leaf due to hash collisions.
>                  */
>                 dref =3D (struct btrfs_extent_data_ref *)ptr;
> +               root =3D btrfs_extent_data_ref_root(leaf, dref);
> +               objectid =3D btrfs_extent_data_ref_objectid(leaf, dref);
>                 offset =3D btrfs_extent_data_ref_offset(leaf, dref);
> +               if (unlikely(!is_valid_dref_root(root))) {
> +                       extent_err(leaf, slot,
> +                                  "invalid extent data backref root valu=
e %llu",
> +                                  root);
> +                       return -EUCLEAN;
> +               }
> +               if (unlikely(objectid < BTRFS_FIRST_FREE_OBJECTID ||
> +                            objectid > BTRFS_LAST_FREE_OBJECTID)) {
> +                       extent_err(leaf, slot,
> +                                  "invalid extent data backref objectid =
value %llu",
> +                                  root);
> +                       return -EUCLEAN;
> +               }
>                 if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsiz=
e))) {
>                         extent_err(leaf, slot,
>         "invalid extent data backref offset, have %llu expect aligned to =
%u",
> --
> 2.45.2
>
>

