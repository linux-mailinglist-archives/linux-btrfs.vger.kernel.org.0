Return-Path: <linux-btrfs+bounces-9065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C82F9AB01E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD01C211D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3E19F127;
	Tue, 22 Oct 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS9hiVsn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2A45945
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605209; cv=none; b=OVikb1pwCgeaQvD+TeCYA2NzBJXYEPBrQdmIg17TwVg22DSnKLwyTGASSkNCS1SvtJivxuRbnHoeiJY/8E1Rhg0Uaw9I0KnOZPTTbsVQODGTQNd+3cadA9Jt8vPG/WiZjYbO+k2RW0KSuBEpp7jKPsxCoDi7mKmWYA2MUhppclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605209; c=relaxed/simple;
	bh=3C2+RuUKWexcpYo/2/AGRBP858PObtahXkCY1INzPhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwGBonMC9erIDff4ggBumY2dVtT4jrY+bPowLYc6zgMxMCxJxQJzaHEyC/HwR+kr/GKa4ZUYM0lEJek0i3+opF57+8BSZTj0U49m3jLXLh0m8KuDnhHmZx+vgYvuLLVVN7w9522CwEB4KlJYRKQ+NJjvysp4ciN4BDM+2/bVW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS9hiVsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F11C4CEE4
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605209;
	bh=3C2+RuUKWexcpYo/2/AGRBP858PObtahXkCY1INzPhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZS9hiVsnwwK8tPBEcq33BRCGfX5+3j0gyS3JZ10qisNV0+DmC8b98qfMUMpkbiRHE
	 sDyGjZHkg7u2BgwLsXVIkMGttifpEpn7bFtvsozac5oy39+UgZZ+yQh7/9aaMscOCW
	 LJxCbpKlP1pKONHvezoOirNewcoii97CbSCMHIXVBkNyl1loAN7wf1hb1R2qYk9Ae0
	 slmmbTK5CRE0ccdHnvOHE6nMesHXc9xOeFn6ZYMZZtQet8ALg8NE2XuSnIB5JlxQ9q
	 UG7/yqi+0oHQpyPCZ4Wg4imk2BZ62tB0kWBLvsyz3jsCQEiJAZ2iAoLTMVIPn3ZKFy
	 n/Ksf6+qddLWQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fb49c64aso7985131e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 06:53:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFl3jJK4lIzLlLqc1H+FgTBtAaeLUED2SEIl4iK7/B+u0xvze1
	uMatxFo038yEvMLGSVVzO5S3TMsr6av3sNnGz67Hb1sUIPOqNopW2X3cKRaU7P0qMJs8D05rnkx
	6uoxNVoeNm9D9B/9kcHXMg0UeYlA=
X-Google-Smtp-Source: AGHT+IH+eFQ7kw9MPQ/SWcz7nP874ISVtRD6eiKVwa/l1h0MnwO8NkPPrP7bE7fp2mIuVTUki7GDNV1Y9htZQ81k6YA=
X-Received: by 2002:a05:6512:2315:b0:533:4620:ebec with SMTP id
 2adb3069b0e04-53a153408b3mr14106391e87.3.1729605207440; Tue, 22 Oct 2024
 06:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017090411.25336-1-jth@kernel.org> <20241017090411.25336-2-jth@kernel.org>
In-Reply-To: <20241017090411.25336-2-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Oct 2024 14:52:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H45VMP=NeU7itO4M-T4m0kA9XYEsTkLttODy5W4_m5OLw@mail.gmail.com>
Message-ID: <CAL3q7H45VMP=NeU7itO4M-T4m0kA9XYEsTkLttODy5W4_m5OLw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] btrfs: implement partial deletion of RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:04=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> In our CI system, the RAID stripe tree configuration sometimes fails with
> the following ASSERT():
>
>  assertion failed: found_start >=3D start && found_end <=3D end, in fs/bt=
rfs/raid-stripe-tree.c:64
>
> This ASSERT()ion triggers, because for the initial design of RAID
> stripe-tree, I had the "one ordered-extent equals one bio" rule of zoned
> btrfs in mind.
>
> But for a RAID stripe-tree based system, that is not hosted on a zoned
> storage device, but on a regular device this rule doesn't apply.
>
> So in case the range we want to delete starts in the middle of the
> previous item, grab the item and "truncate" it's length. That is, clone
> the item, subtract the deleted portion from the key's offset, delete the
> old item and insert the new one.
>
> In case the range to delete ends in the middle of an item, we have to
> adjust both the item's key as well as the stripe extents and then
> re-insert the modified clone into the tree after deleting the old stripe
> extent.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.c            |  1 +
>  fs/btrfs/raid-stripe-tree.c | 94 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 88 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index b11ec86102e3..3f320f6e7767 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct btr=
fs_trans_handle *trans,
>         btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>
>         BUG_ON(key.type !=3D BTRFS_EXTENT_DATA_KEY &&
> +              key.type !=3D BTRFS_RAID_STRIPE_KEY &&
>                key.type !=3D BTRFS_EXTENT_CSUM_KEY);
>
>         if (btrfs_leaf_free_space(leaf) >=3D ins_len)
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 41970bbdb05f..569273e42d85 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -13,6 +13,50 @@
>  #include "volumes.h"
>  #include "print-tree.h"
>
> +static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle =
*trans,
> +                                             struct btrfs_path *path,
> +                                             struct btrfs_key *oldkey,

oldkey can be made const.

> +                                             u64 newlen, u64 frontpad)
> +{
> +       struct btrfs_root *stripe_root =3D trans->fs_info->stripe_root;
> +       struct btrfs_stripe_extent *extent;
> +       struct extent_buffer *leaf;
> +       int slot;
> +       size_t item_size;
> +       int ret;
> +       struct btrfs_key newkey =3D {
> +               .objectid =3D oldkey->objectid + frontpad,
> +               .type =3D BTRFS_RAID_STRIPE_KEY,
> +               .offset =3D newlen,
> +       };
> +
> +       ASSERT(oldkey->type =3D=3D BTRFS_RAID_STRIPE_KEY);
> +       ret =3D btrfs_duplicate_item(trans, stripe_root, path, &newkey);
> +       if (ret)
> +               return ret;
> +
> +       leaf =3D path->nodes[0];
> +       slot =3D path->slots[0];
> +       item_size =3D btrfs_item_size(leaf, slot);
> +       extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent)=
;
> +
> +       for (int i =3D 0; i < btrfs_num_raid_stripes(item_size); i++) {
> +               struct btrfs_raid_stride *stride =3D &extent->strides[i];
> +               u64 phys;
> +
> +               phys =3D btrfs_raid_stride_physical(leaf, stride);
> +               btrfs_set_raid_stride_physical(leaf, stride, phys + front=
pad);
> +       }
> +
> +       btrfs_mark_buffer_dirty(trans, leaf);

This is redundant, it was already done by btrfs_duplicate_item(), by
the btrfs_search_slot() call in the caller and done by
btrfs_del_item() below as well.


> +
> +       /* delete the old item, after we've inserted a new one. */
> +       path->slots[0]--;
> +       ret =3D btrfs_del_item(trans, stripe_root, path);

So actually looking at this, we don't need  btrfs_duplicate_item()
plus btrfs_del_item(), this can be more lightweight and simpler by
doing just:

1) Do the for loop as it is.

2) Then after, or before the for loop, the order doesn't really
matter, just do:   btrfs_set_item_key_safe(trans, path, &newkey).

Less code and it avoids adding a new item and deleting another one,
with the shiftings of data in the leaf, etc.

Thanks.

> +
> +       return ret;
> +}
> +
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start=
, u64 length)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -36,23 +80,24 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>         while (1) {
>                 key.objectid =3D start;
>                 key.type =3D BTRFS_RAID_STRIPE_KEY;
> -               key.offset =3D length;
> +               key.offset =3D 0;
>
>                 ret =3D btrfs_search_slot(trans, stripe_root, &key, path,=
 -1, 1);
>                 if (ret < 0)
>                         break;
> -               if (ret > 0) {
> -                       ret =3D 0;
> -                       if (path->slots[0] =3D=3D 0)
> -                               break;
> +
> +               if (path->slots[0] =3D=3D btrfs_header_nritems(path->node=
s[0]))
>                         path->slots[0]--;
> -               }
>
>                 leaf =3D path->nodes[0];
>                 slot =3D path->slots[0];
>                 btrfs_item_key_to_cpu(leaf, &key, slot);
>                 found_start =3D key.objectid;
>                 found_end =3D found_start + key.offset;
> +               ret =3D 0;
> +
> +               if (key.type !=3D BTRFS_RAID_STRIPE_KEY)
> +                       break;
>
>                 /* That stripe ends before we start, we're done. */
>                 if (found_end <=3D start)
> @@ -61,7 +106,42 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>                 trace_btrfs_raid_extent_delete(fs_info, start, end,
>                                                found_start, found_end);
>
> -               ASSERT(found_start >=3D start && found_end <=3D end);
> +               /*
> +                * The stripe extent starts before the range we want to d=
elete:
> +                *
> +                * |--- RAID Stripe Extent ---|
> +                * |--- keep  ---|--- drop ---|
> +                *
> +                * This means we have to duplicate the tree item, truncat=
e the
> +                * length to the new size and then re-insert the item.
> +                */
> +               if (found_start < start) {
> +                       u64 diff =3D start - found_start;
> +
> +                       ret =3D btrfs_partially_delete_raid_extent(trans,=
 path,
> +                                                                &key,
> +                                                                diff, 0)=
;
> +                       break;
> +               }
> +
> +               /*
> +                * The stripe extent ends after the range we want to dele=
te:
> +                *
> +                * |--- RAID Stripe Extent ---|
> +                * |--- drop  ---|--- keep ---|
> +                *
> +                * This means we have to duplicate the tree item, truncat=
e the
> +                * length to the new size and then re-insert the item.
> +                */
> +               if (found_end > end) {
> +                       u64 diff =3D found_end - end;
> +
> +                       ret =3D btrfs_partially_delete_raid_extent(trans,=
 path,
> +                                                                &key,
> +                                                                diff, di=
ff);
> +                       break;
> +               }
> +
>                 ret =3D btrfs_del_item(trans, stripe_root, path);
>                 if (ret)
>                         break;
> --
> 2.43.0
>
>

