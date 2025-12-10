Return-Path: <linux-btrfs+bounces-19624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B7ACB2F63
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5FF306AE1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B6318139;
	Wed, 10 Dec 2025 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpf40yhI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838A2741BC
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371504; cv=none; b=ksHJbV3858z+a83mDKeTf/9jm920ql1LO8DFkjLxq7zlx9z8oDBP1BtgtDT8YDn/GzYDUMY5eRB1VL5xDaoF5kaFQ/X1vFBLwiXh/+5QGOA3B9IZZOywAu9IFws5ydP+DITK/ao6EKNUm9L6oaXL4wiae4Yxs8HWVk9DEsjRA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371504; c=relaxed/simple;
	bh=NZfdv2mgM1JJrRO/oZRPoSsJvKth5gdElf4JIuWifg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sntp3Jk4FgNllXqKdFdf8WNM2Vjs6+BI96IlpB5zYSYuhzYY3JGzFZgOnxvjNHE3baMkQvNTZO1h5TAroEk9QqIuwAhyAAa2qURwtcipJ9B+ipBaXRZNi12/TeeiicU5Sudq1E3TEVIfXFYQJSc9Bawb9+lJYsGFl0nbIOazZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpf40yhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E13C113D0
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371503;
	bh=NZfdv2mgM1JJrRO/oZRPoSsJvKth5gdElf4JIuWifg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rpf40yhIkswQd9pgfXyqpEdpnHElHdfsAaAnjqBEVoxliyK/1t4DAFNbcIJahhfdg
	 e0sXJhPPjbONib/KVKxOP3Gq0oYqnCDq4R0BzuaFcEs+XNm/uP2vtwYQ2MF3d8d/pd
	 0qCKshUWw/xEOFY+y2Wrm1SH47sLmAxsRKZgOpGW0KtK3+NyUGa1DSciGbMh00wqRC
	 KPikkDO5BULGK+By5hWOD2BNh1vqq5Qtzr2CpTMjgA6PrTQvlGwu3MiEqnO2PU6mmm
	 X4dYH943Ojh/pG5M675Ab871QSs5Q+zxPUeNbhm/fUdKcfxNBrbwJk4PZMsyCERbjS
	 EH5/F/P641ytA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b736ffc531fso400717566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 04:58:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwIEqX3ix+uj4v68vMAuIjhuxCgYRFTj6mMLiaUMPrixDR63p2Y
	Gj2380MnOLUK6VA6KpkvGcMag9Z0iI+S/W7gf4k3WC8PrhcLdb2jrKEhIaImPsiMxVjmnAwhIfd
	s/HVdFgIBkweE0ptv4jdJCotEITsUPoY=
X-Google-Smtp-Source: AGHT+IH+XYRtQZN71gPgnnviYVQPPXXnBifFtDvq9T3m16l/qIVedXBuLe0UJcfLmG7AHkV/4ecM0H51/xyIR0oxOiI=
X-Received: by 2002:a17:907:da2:b0:b73:43ee:a262 with SMTP id
 a640c23a62f3a-b7ce847d2f4mr267602466b.51.1765371502169; Wed, 10 Dec 2025
 04:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 12:57:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7OzV-NeAV2i43JTjJxN0f=2SGdT0uWaz8-NDP6U8W0fw@mail.gmail.com>
X-Gm-Features: AQt7F2q4ebsw0T97Xp1b9CxEMfkX2I0IpeINZBshpk0J4Cn1VBYMPucLnqBqfnM
Message-ID: <CAL3q7H7OzV-NeAV2i43JTjJxN0f=2SGdT0uWaz8-NDP6U8W0fw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: rename btrfs_create_block_group_cache to btrfs_create_block_group
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 5:40=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> 'struct btrfs_block_group' used to be called 'struct
> btrfs_block_group_cache' but got renamed to btrfs_block_group with
> commit 32da5386d9a4 ("btrfs: rename btrfs_block_group_cache").
>
> Rename btrfs_create_block_group_cache() to btrfs_create_block_group() to
> reflect that change.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/block-group.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..a52642e88585 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2266,7 +2266,7 @@ static int exclude_super_stripes(struct btrfs_block=
_group *cache)
>         return 0;
>  }
>
> -static struct btrfs_block_group *btrfs_create_block_group_cache(
> +static struct btrfs_block_group *btrfs_create_block_group(
>                 struct btrfs_fs_info *fs_info, u64 start)
>  {
>         struct btrfs_block_group *cache;
> @@ -2370,7 +2370,7 @@ static int read_one_block_group(struct btrfs_fs_inf=
o *info,
>
>         ASSERT(key->type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY);
>
> -       cache =3D btrfs_create_block_group_cache(info, key->objectid);
> +       cache =3D btrfs_create_block_group(info, key->objectid);
>         if (!cache)
>                 return -ENOMEM;
>
> @@ -2491,7 +2491,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_=
info)
>                 struct btrfs_block_group *bg;
>
>                 map =3D rb_entry(node, struct btrfs_chunk_map, rb_node);
> -               bg =3D btrfs_create_block_group_cache(fs_info, map->start=
);
> +               bg =3D btrfs_create_block_group(fs_info, map->start);
>                 if (!bg) {
>                         ret =3D -ENOMEM;
>                         break;
> @@ -2886,7 +2886,7 @@ struct btrfs_block_group *btrfs_make_block_group(st=
ruct btrfs_trans_handle *tran
>
>         btrfs_set_log_full_commit(trans);
>
> -       cache =3D btrfs_create_block_group_cache(fs_info, chunk_offset);
> +       cache =3D btrfs_create_block_group(fs_info, chunk_offset);
>         if (!cache)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.52.0
>
>

