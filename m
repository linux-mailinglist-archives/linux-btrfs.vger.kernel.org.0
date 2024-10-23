Return-Path: <linux-btrfs+bounces-9099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536389ACB86
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F012811FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FFC1B4F17;
	Wed, 23 Oct 2024 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9PWmwV5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE0E56A
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691224; cv=none; b=Pb+Q+UktoAJVZnoLhWZLtMAsYgHCpg0jO1XmEFUlAmt8QDmHMkyQL9N5FUX8KIJWcqmcDvvgKRkv1TUdG3Q7rUH13a263PXWGoOkwrRLOPOMzXyMQ+VvWyRnn+uz9QrdSXOA3eMoPZ8osiX4v0ZweihQH+/Rbu9arDDUJ92dPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691224; c=relaxed/simple;
	bh=7lwD/R5+N1kPBT9u9h6XmWN6LEehHFsT4sOrAp2xavM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZzlsjZt555Vk9+4PVtRRNuU53BpoUCYUgTX6wQDCXFqZBRiDL0sJ4jBEsVU+2yMov7nPhPv/QnJarNeWJT1Y2VYi0aUVHenMpDpDUNC977i7EhHWLCga5bPAH2Pp0Yt9fvJX5lIG5iUjo8hBwhtAWG9ZoOBL7+3MblSZ1LXSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9PWmwV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF12C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729691223;
	bh=7lwD/R5+N1kPBT9u9h6XmWN6LEehHFsT4sOrAp2xavM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u9PWmwV5j7kFtVWfpEDI1kpYr/kJqIFdLmWiUh3btmik33OZiocEIyJIT+vfSAB2Z
	 GKtcUQVEM9/rxWxXqMFmvdkGosxM+QMl4T4stvMsNnz/EnczNA0Ug2RvzPvha2GGgj
	 k91Vpv0Mklay5ze/J/uPyb+i2ioXiw3Pbrs95aPnRRsfABwc/xdKK1iVRHnrizcO/a
	 ZG4wI9VQCzANxDvhgkZM+QJktEwxiguR5uAG/EuFkR+iRqjDCZAQlpbV3AfhkulvsV
	 tKrR9wr/kx7V9Jtl6K6CsqXGg4VV7CIt3nTrKf1e2z12hM9zS8od9TdRPwXASttwdb
	 C5hR1hBpC7+Pg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so780677666b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 06:47:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhdfpmKK+dU1htSTVD1Y/8p9D4WZuXWJCy+rCfPQrBFdahuXYf
	FlyZbRVREfQsd+Z4pTZZFVGT/jMKwEBD3S7BQbHOuw5Zj/EU5y7bQYGuJ89EQA/Q259QsnfLqt/
	4USAStPKxGQUwpmv659A3AkyuGgY=
X-Google-Smtp-Source: AGHT+IGhg7BlCJt0Ivery5+cuIxK+gYtW8iM+TVE6G8gnwTRHGBtZLlrLTQf1InIhB8+psCE5QUZnPKywd4S2d080mo=
X-Received: by 2002:a17:906:7309:b0:a9a:55de:11f4 with SMTP id
 a640c23a62f3a-a9abf96d176mr226931766b.54.1729691221858; Wed, 23 Oct 2024
 06:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023132518.19830-1-jth@kernel.org> <20241023132518.19830-2-jth@kernel.org>
In-Reply-To: <20241023132518.19830-2-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Oct 2024 14:46:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4k0YezVj5+8h2ct9DCieD5vEvWJRMtb2hyYUnBZfx28Q@mail.gmail.com>
Message-ID: <CAL3q7H4k0YezVj5+8h2ct9DCieD5vEvWJRMtb2hyYUnBZfx28Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] btrfs: implement partial deletion of RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:25=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/raid-stripe-tree.c | 81 +++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 41970bbdb05f..9ffc79f250fb 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -13,6 +13,39 @@
>  #include "volumes.h"
>  #include "print-tree.h"
>
> +static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle=
 *trans,
> +                                              struct btrfs_path *path,
> +                                              const struct btrfs_key *ol=
dkey,
> +                                              u64 newlen, u64 frontpad)
> +{
> +       struct btrfs_stripe_extent *extent;
> +       struct extent_buffer *leaf;
> +       int slot;
> +       size_t item_size;
> +       struct btrfs_key newkey =3D {
> +               .objectid =3D oldkey->objectid + frontpad,
> +               .type =3D BTRFS_RAID_STRIPE_KEY,
> +               .offset =3D newlen,
> +       };
> +
> +       ASSERT(oldkey->type =3D=3D BTRFS_RAID_STRIPE_KEY);
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
> +       btrfs_set_item_key_safe(trans, path, &newkey);
> +}
> +
>  int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start=
, u64 length)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -36,23 +69,24 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
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
> @@ -61,7 +95,40 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
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
> +                       btrfs_partially_delete_raid_extent(trans, path, &=
key,
> +                                                          diff, 0);
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
> +                       btrfs_partially_delete_raid_extent(trans, path, &=
key,
> +                                                          diff, diff);
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

