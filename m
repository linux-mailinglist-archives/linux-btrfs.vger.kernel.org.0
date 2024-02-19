Return-Path: <linux-btrfs+bounces-2506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A8485A335
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BDD1C2391D
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0752E645;
	Mon, 19 Feb 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiXPnyn+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732B2E40D
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345702; cv=none; b=o/y5TilDUN06TbUjHKs2ttkb+BCoLjB+j/oRFeLyJ7TkOi3dZtPkZXmz/pQF/prlvsdkZ8uvv3kt8b3BBlR9kKMGcV12jQPfTWh6WKa9p0XjBRfbk5xF8zpXo46yvBxj1l3N1hsY2bmebSw1HaIeCysLfRM1QOPJJTLRjvvAybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345702; c=relaxed/simple;
	bh=sdZbAi/+BPUl5mkt8dqlBaFmzMKOUeQD2+DbyVpX1d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxW57hcuqQAwZcziRh1mECli/NUGQLuSebj8+AJkcwh7+N0mCRkmWz+tU7VyFCv/4A/FpmWj4ny521lcRZ2ayzzpCSMWw2xArDfhS6HzAeOk0u/wJv4ns2CMl21LvA4YYcFkZKZ41jBVo7DbsiW6qkhJ+XaL78Fl6VrCZX58h8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiXPnyn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A12C433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345702;
	bh=sdZbAi/+BPUl5mkt8dqlBaFmzMKOUeQD2+DbyVpX1d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LiXPnyn+9udk8HMyiYaLk1J4dIpkm555H96pCkKIl23G+ZHqva6qHl4tOKknO4pu0
	 967Nex5e5q0sq5O7UFN+A6FbJjkrRye055LJj/XFI+6T1jq96cqjd30RGpGmNPWyGX
	 Y/zHD/sTsb+6gED+jUghT+VdPHKGYfKcxqcIr/7lSbQeaG5s1MM3cFwyecsTv/xwJS
	 NOQq0/K+CHcp3RwTicmZBYWWQe2eR/wzUHoHFcIY/0itSVpzObBQU36l3SK3DvNkeV
	 DBhbKoBC7tpJQc7gguxf8tDo1P9LOJoJA2RZ9wHpi524mQ+ty3Tl1dKWkpNcjPmozQ
	 X2r6PXZsobtcA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563e330351dso3204050a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 04:28:22 -0800 (PST)
X-Gm-Message-State: AOJu0Ywg/62BqS9CR7Nv4OFXP69McPZOh36O1WICl0RoHprkV5mhjLQe
	TBogUK87no+r/wdbhEsf3jMUdCa4DpK8uTtJSvfR3TSSUpdnnxCY9TEeok7BkzLOUk3K1vRhzss
	HQ9gnRP7wnk7bsU5ne0+6U29ekCw=
X-Google-Smtp-Source: AGHT+IFjgDPFXvqf6DKP65WLsEHUTsGynDbPk8M3e95qgAmIpkf/QrNpR8n5C9Akw+9BabtI8KrrIQTn2gW3nW3f/L4=
X-Received: by 2002:a17:906:714a:b0:a3e:bc98:7243 with SMTP id
 z10-20020a170906714a00b00a3ebc987243mr941300ejj.71.1708345700601; Mon, 19 Feb
 2024 04:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708339010.git.dsterba@suse.com> <cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com>
In-Reply-To: <cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 Feb 2024 12:27:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6MyuNBkRaYHzwid6ccOSYC0Yym2VgwozsqZbVS_6Fzvw@mail.gmail.com>
Message-ID: <CAL3q7H6MyuNBkRaYHzwid6ccOSYC0Yym2VgwozsqZbVS_6Fzvw@mail.gmail.com>
Subject: Re: [PATCH 08/10] btrfs: simplify conditions in btrfs_free_chunk_map()
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:14=E2=80=AFAM David Sterba <dsterba@suse.com> wr=
ote:
>
> The helper is simple enough for inlining, we can further simplify it by
> removing the check for map pointer validity. After this patch all
> callers always pass a valid pointer.

So by making btrfs_free_chunk_map() to not ignore a NULL pointer, we
are adding rather
surprising behaviour and inconsistency.

Most free functions ignore a NULL pointer, take the example of the
kfree() family and even free() family in the standard C library,
as well as most of the free functions we have in btrfs as well, which
are modeled on that common pattern.

Ignoring NULL makes error handling simpler, by not having the need to
take special care to call the free function with a non-NULL pointer.

Besides that, this change doesn't seem to improve anything.

Thanks.

>
> The changes to achieve this:
>
> - in verify_one_dev_extent() return and don't jump to the out label
>   that could potentially pass a NULL pointer to btrfs_free_chunk_map
>
> - in btrfs_load_block_group_zone_info() add a label that specifically
>   clears the map and does not go through label out that could encounter
>   a NULL pointer in cache->physical_map
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/volumes.c | 3 +--
>  fs/btrfs/volumes.h | 2 +-
>  fs/btrfs/zoned.c   | 3 ++-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 752144a31d79..55b91807aba4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7979,8 +7979,7 @@ static int verify_one_dev_extent(struct btrfs_fs_in=
fo *fs_info,
>                 btrfs_err(fs_info,
>  "dev extent physical offset %llu on devid %llu doesn't have correspondin=
g chunk",
>                           physical_offset, devid);
> -               ret =3D -EUCLEAN;
> -               goto out;
> +               return -EUCLEAN;
>         }
>
>         stripe_len =3D btrfs_calc_stripe_length(map);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 21d4de0e3f1f..ce1aa7684c74 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -566,7 +566,7 @@ struct btrfs_chunk_map {
>
>  static inline void btrfs_free_chunk_map(struct btrfs_chunk_map *map)
>  {
> -       if (map && refcount_dec_and_test(&map->refs)) {
> +       if (refcount_dec_and_test(&map->refs)) {
>                 ASSERT(RB_EMPTY_NODE(&map->rb_node));
>                 kfree(map);
>         }
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3317bebfca95..b9346ca82c47 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1564,7 +1564,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>         cache->physical_map =3D btrfs_clone_chunk_map(map, GFP_NOFS);
>         if (!cache->physical_map) {
>                 ret =3D -ENOMEM;
> -               goto out;
> +               goto out_free_map;
>         }
>
>         zone_info =3D kcalloc(map->num_stripes, sizeof(*zone_info), GFP_N=
OFS);
> @@ -1677,6 +1677,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_b=
lock_group *cache, bool new)
>         }
>         bitmap_free(active);
>         kfree(zone_info);
> +out_free_map:
>         btrfs_free_chunk_map(map);
>
>         return ret;
> --
> 2.42.1
>
>

