Return-Path: <linux-btrfs+bounces-10407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C121C9F2F16
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD5167212
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7EC204576;
	Mon, 16 Dec 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj1TWCUz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C2040BA;
	Mon, 16 Dec 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348287; cv=none; b=Xp6vvFBQTzJ1zzl7bfxoriHCcZBiuhJ5aaToakF2KDe6+5h5+MPO3aYsZZ7RPN3kuLD7yuv2eIY3XRUuAeVbTfThU2ol2ceVXl/DSmnW2OlakhCHgZ4m1vfSXB9wMFpZk6jlalmncUczCSmrtN6lEv6En7f+WVSHZESU9gkjGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348287; c=relaxed/simple;
	bh=5pRDc1IZfHbe2Auig8bTWZOh9bf23ak3HIyObhcqgI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqbivaa5fYS606gZVDjMyPgvEpOMn4gdGq/tgckiH5unWTMMjDvy34nn6l1p4uh3633SwY+Dy+lCbG20YrxQz7Sj+wkHrGylp5+/kokBSp5kz0ougHAd6w23uMsLOYvmcIuQxhlZj8N9RGMJIMq+6dc89XiSBFPpZ3nYUPfby0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj1TWCUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C4DC4AF09;
	Mon, 16 Dec 2024 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734348287;
	bh=5pRDc1IZfHbe2Auig8bTWZOh9bf23ak3HIyObhcqgI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pj1TWCUzsiKpN+p7r/hySwZXE2DqpxScRVwoOc4/aEySflBdMbDraGfngisbZeeC9
	 i33a82yhDL/n1j8Ob4eKApSdCQWiwRGzQEBdc2ll1zFoD2pR91aRiaodJUnQetKmyX
	 +1RtF0JH4edZwW8lgYu4gcApvjrBaom2I7Ch28DrMlQDxAiDxACxpgHeW9Ehcbv9fw
	 CBbGsSEyOD38K3eBwSZLO5Xmhr1tfxVqJdOIQk+WewqtL+CG3yepjdjVs38Zv9NtLs
	 Q00i6WaDO9jU1GjDrYBRwU4r/SzZqpj9OjtedXzlAi6LbS/F/fmOMzlAN2au9+xI63
	 hDpk5eaACowgA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6a92f863cso799529066b.1;
        Mon, 16 Dec 2024 03:24:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKpMtIaWqY/fi+XLrPaLocJDeedGsy8X+PNZd051uqCxJOsKcZDqbWmn4xCGBoNzyAB3qRwLjf6c7WQQ==@vger.kernel.org, AJvYcCVMChe7e0tth7AV2eSMAZe6TtTw6nux8RKjTTQacAm2A313EE0DtwY//2c5ZZQgxdk/W3lOBuDTaj+UsQJX@vger.kernel.org
X-Gm-Message-State: AOJu0YzS15s1bgYfit/85JWNMwl+FfdmtUQaxJFe5EJJyhYx+vuFCveI
	CZ7etFzbnrajQ/vu8fWESCjX15jqq5scb/ZJ0BDC2SgBpUAoQbgDheQL+d8e/CJtISdFWAGtuuu
	LK7wATV1pBhfnnUv9XX+r7gtKVjE=
X-Google-Smtp-Source: AGHT+IEJsgU6jXryolA7tIyew0D6DpScFVLFrmp7zQu4vZEk5ZmbTT0vgfPn8OYQWegM7L3bE1XRG6zXuofjLyo9YIw=
X-Received: by 2002:a17:906:7314:b0:aa6:74a9:ce6e with SMTP id
 a640c23a62f3a-aab77909d56mr1184940666b.16.1734348285752; Mon, 16 Dec 2024
 03:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
 <20241216-btrfs_need_stripe_tree_update-cleanups-v2-3-42b6d0274da7@kernel.org>
In-Reply-To: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-3-42b6d0274da7@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Dec 2024 11:24:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5vp=G=RzvYOdYq8FMTSyGbdSObo4w76SjaaTq4Nmpn1g@mail.gmail.com>
Message-ID: <CAL3q7H5vp=G=RzvYOdYq8FMTSyGbdSObo4w76SjaaTq4Nmpn1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: pass btrfs_io_geometry to is_single_device_io
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:12=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Now that we have the stripe tree decision saved in struct
> btrfs_io_geometry we can pass it into is_single_device_io() and get rid o=
f
> another call to btrfs_need_raid_stripe_tree_update().
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/volumes.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 088ba0499e184c93a402a3f92167cccfa33eec58..fcd80ba9dd4286305ebeea58a=
dc5950a532cc06c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6362,7 +6362,7 @@ static bool is_single_device_io(struct btrfs_fs_inf=
o *fs_info,
>                                 const struct btrfs_io_stripe *smap,
>                                 const struct btrfs_chunk_map *map,
>                                 int num_alloc_stripes,
> -                               enum btrfs_map_op op, int mirror_num)
> +                               struct btrfs_io_geometry *io_geom)
>  {
>         if (!smap)
>                 return false;
> @@ -6370,10 +6370,10 @@ static bool is_single_device_io(struct btrfs_fs_i=
nfo *fs_info,
>         if (num_alloc_stripes !=3D 1)
>                 return false;
>
> -       if (btrfs_need_stripe_tree_update(fs_info, map->type) && op !=3D =
BTRFS_MAP_READ)
> +       if (io_geom->use_rst && io_geom->op !=3D BTRFS_MAP_READ)
>                 return false;
>
> -       if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && mirror_num > 1=
)
> +       if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) && io_geom->mirro=
r_num > 1)
>                 return false;
>
>         return true;
> @@ -6648,8 +6648,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>          * physical block information on the stack instead of allocating =
an
>          * I/O context structure.
>          */
> -       if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op=
,
> -                               io_geom.mirror_num)) {
> +       if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, &i=
o_geom)) {
>                 ret =3D set_io_stripe(fs_info, logical, length, smap, map=
, &io_geom);
>                 if (mirror_num_ret)
>                         *mirror_num_ret =3D io_geom.mirror_num;
>
> --
> 2.43.0
>
>

