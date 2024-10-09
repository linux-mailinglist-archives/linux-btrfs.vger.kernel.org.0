Return-Path: <linux-btrfs+bounces-8740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5299722C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9971C23E72
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC081DF722;
	Wed,  9 Oct 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzDFEBd9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C94199EBB
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492156; cv=none; b=F4iHUaysoeSFdayVbbZ3z1Xesl3jALjfrQ2+dTU6PsNzZebp3qOud4UIq8WpTSDy0KWRaLwNCNXrFVylz5Gm7EABAPdWHOI5+w1X/N7LWp3/pGc4Xha7sQY5Lvic3c+0mGGb06IVG42V4KNq0l1HwQSHVHJecp2M8I9pMHUS8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492156; c=relaxed/simple;
	bh=Mgaqr8APBlSHXtNuaVxh7WbNe/SFhU/2eewDtyGx2G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp4kQauLW/KqiZiw8HGngD1m7qxLeNZTkTvkNEJLF4jT+w7UUUZyNmo4VmAkqxA4ZukMM3RVE2tBDQuzh+EA2CpkQdoxIhvZpFpaT0K52Z0I25auD36J3V+wx62SReMSdYkpVV2y/ROdJHgBUtDBMzjRASkXAfhmxktQie0QB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzDFEBd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75877C4AF0B
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728492155;
	bh=Mgaqr8APBlSHXtNuaVxh7WbNe/SFhU/2eewDtyGx2G0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HzDFEBd9eSpLwJOmSBc2cE9J2AjlnxIql1TJO/uqN5AgVrMqME2B2yCwIuvFUdKhC
	 SOta2bf0LwLQCzyFNZjaAzL8AjJXgfNi3LljPfGfna1wW/TTV2szO7BQmrOgEKofuw
	 TL7F26gyQHvhxEn56i2E/z9w0cnPG5USJEtYGYeTADilM39ef5niwW/RKiIp+ozzo6
	 Ckvu8hv3ueppQ+WuY1kokVjNP+FWHcaRZABlLDkvk0y2QyRlAZr2hMKdeRtBxGa+50
	 OXAdjaxdlkM3fpGG+i/ey5RfWJW2/qWnaOhf9cU1wgjM7W4l+BJ+aQo4RsJYPUKxXE
	 9HDxAHYzdl/AA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99422929c5so2717366b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 09:42:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3JxQkonoHMLkePehPPy+317Z4x6EKmkgP40EL9Vwwsld1R5EH+35BoOPxM7c6GHbTaeGChQB8jD4Q8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6k4Q45Zx808bDvLSx1HMm/s+tel5FMagP05PBL46VN8AFKSYA
	ItlaYazmQo4Li6IsGfr7jMcpNWwX/tD/E8t8JegouuL+RMcN8cl5lRsNYpN0PKHJggixAYUHME9
	ugVd5da4J7953oBNa6D0SNL8UrIk=
X-Google-Smtp-Source: AGHT+IHEeSau5EIH0cBT/XrqKgKEzuHG/w8hCoGc95X70pt9RKemji3AN3CslOlQFxbL6tqFdTx2wazh2doS0Nj3xlM=
X-Received: by 2002:a17:906:d7dc:b0:a99:9ff2:a8c6 with SMTP id
 a640c23a62f3a-a999ff2ab1cmr45830466b.48.1728492154016; Wed, 09 Oct 2024
 09:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009153032.23336-1-jth@kernel.org> <20241009153032.23336-2-jth@kernel.org>
In-Reply-To: <20241009153032.23336-2-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Oct 2024 17:41:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Nv+GSpPHMsQ-H4gdz4vk-ecXgtScqCHP1wsNkaB7H9w@mail.gmail.com>
Message-ID: <CAL3q7H6Nv+GSpPHMsQ-H4gdz4vk-ecXgtScqCHP1wsNkaB7H9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, 
	Filipe Manana <fdmanana@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:00=E2=80=AFPM Johannes Thumshirn <jth@kernel.org> =
wrote:
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
>  fs/btrfs/raid-stripe-tree.c | 85 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 41970bbdb05f..40cc0a392be2 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -13,6 +13,54 @@
>  #include "volumes.h"
>  #include "print-tree.h"
>
> +static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle =
*trans,
> +                                             struct btrfs_path *path,
> +                                             struct btrfs_key *oldkey,
> +                                             u64 newlen, u64 frontpad)
> +{
> +       struct btrfs_root *stripe_root =3D trans->fs_info->stripe_root;
> +       struct btrfs_stripe_extent *extent, *new;
> +       struct extent_buffer *leaf =3D path->nodes[0];
> +       int slot =3D path->slots[0];
> +       const size_t item_size =3D btrfs_item_size(leaf, slot);
> +       struct btrfs_key newkey;
> +       int ret;
> +       int i;
> +
> +       new =3D kzalloc(item_size, GFP_NOFS);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       memcpy(&newkey, oldkey, sizeof(struct btrfs_key));
> +       newkey.objectid +=3D frontpad;
> +       newkey.offset -=3D newlen;
> +
> +       extent =3D btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent)=
;
> +
> +       for (i =3D 0; i < btrfs_num_raid_stripes(item_size); i++) {

The loop variable could be declared here in the for expression, as
it's not used anywhere outside it.

> +               u64 devid;
> +               u64 phys;
> +
> +               devid =3D btrfs_raid_stride_devid(leaf, &extent->strides[=
i]);
> +               btrfs_set_stack_raid_stride_devid(&new->strides[i], devid=
);
> +
> +               phys =3D btrfs_raid_stride_physical(leaf, &extent->stride=
s[i]);
> +               phys +=3D frontpad;
> +               btrfs_set_stack_raid_stride_physical(&new->strides[i], ph=
ys);
> +       }
> +
> +       ret =3D btrfs_del_item(trans, stripe_root, path);
> +       if (ret)
> +               goto out;
> +
> +       btrfs_release_path(path);
> +       ret =3D btrfs_insert_item(trans, stripe_root, &newkey, new, item_=
size);

So instead of doing a deletion followed by an insertion, which implies
two searches in the btree and occasional node/leaf merges and splits,
can't we do this in a single search?
By adjusting item keys, updating items and duplicating them (followed
by updating them), similar to what we do at btrfs_drop_extents() for
example.
Otherwise this may result in very high lock contention and extra work.

It's ok for an initial implementation and can be improved later, but I
was just curious if there's any reason besides simplicity for now.

Thanks.

> +
> + out:
> +       kfree(new);
> +       return ret;
> +}
> +
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start=
, u64 length)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -43,9 +91,8 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle =
*trans, u64 start, u64 le
>                         break;
>                 if (ret > 0) {
>                         ret =3D 0;
> -                       if (path->slots[0] =3D=3D 0)
> -                               break;
> -                       path->slots[0]--;
> +                       if (path->slots[0] > 0)
> +                               path->slots[0]--;
>                 }
>
>                 leaf =3D path->nodes[0];
> @@ -61,7 +108,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
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
> +                       ret =3D btrfs_partially_delete_raid_extent(trans,=
 path, &key,
> +                                                       start - found_sta=
rt, 0);
> +                       break;
> +               }
> +
> +               /*
> +                * The stripe extent ends after the range we want to dele=
te:
> +                *
> +                * |--- RAID Stripe Extent ---|
> +                * |--- drop  ---|--- keep ---|
> +                * This means we have to duplicate the tree item, truncat=
e the
> +                * length to the new size and then re-insert the item.
> +                */
> +               if (found_end > end) {
> +                       u64 diff =3D found_end - end;
> +
> +                       ret =3D btrfs_partially_delete_raid_extent(trans,=
 path, &key,
> +                                                                diff, di=
ff);
> +                       break;
> +               }
>                 ret =3D btrfs_del_item(trans, stripe_root, path);
>                 if (ret)
>                         break;
> --
> 2.43.0
>
>

