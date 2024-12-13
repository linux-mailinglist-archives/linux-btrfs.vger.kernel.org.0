Return-Path: <linux-btrfs+bounces-10349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3E9F0BF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D60188B196
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4B1DF741;
	Fri, 13 Dec 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gslJveAU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB31DE3BB;
	Fri, 13 Dec 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091855; cv=none; b=nHfiClaOKOwD2GPxWHg898+8ZWfShQ+3Bk5+efCMSA96hGUE74kGXN/89mMH9+5s+hOjhERJ6Sc2avFykobWcQyjGgQpTuV5lxWH3760wjDAu/4GA48Sqdryl88/bnAlXM1/z0eRTSmWUiHJhQ/RgC2/afaOVGWikA4RIvafUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091855; c=relaxed/simple;
	bh=xMRuNPTj8LbtBlRYpPCkBgneS+7LAseKtv/8FEuen3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH1/uURsAmOo0zDOMVQncvhiH6zpYUdbj0J2kdWhRGf0u9msEAmAFf65gPKeOz7OmFSR+5YjXo8j/orLlXnID173ln2r6u3V9DrsEavNwrqn/ji12jXzRJXtTHzNHj4yXWfhPMdwClfemLYw4SfsL1u780ia1bI3/5QNED4xog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gslJveAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0251DC4CED6;
	Fri, 13 Dec 2024 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734091855;
	bh=xMRuNPTj8LbtBlRYpPCkBgneS+7LAseKtv/8FEuen3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gslJveAU8h6+an8e/lhC6s9CtEof1O68fEomYv/V21DwJhIypchNgB4Fuc3EIfX8l
	 /+Cibti4TmRFOcT4kXr3oIjFd4oq3E8mZj896qomBVtz1BQpSFcphqmVJqqNaIxQ1A
	 2DrhmMPUh8aEv3ElKOS6eMJ/U10TaFjLMbq0zEv4douDs5P9T4+3T1527f3yGStpcr
	 Mx9lcP0fFv3l9ZiioZReXsrwQY1qju9uexuKbClpNUv5jGUIuzcJ32n9nXi6RjOJNX
	 ceftQjpR7V3wS2Izx183sCEkuz4RuGpK2lzT0GR/05IsqxGmhpJ070syxbB4Yxdteq
	 V8Yqzkwd36kVg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa69251292dso328310566b.2;
        Fri, 13 Dec 2024 04:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAhuZE1YOpDOp4Ho4kqyj0tsN7lpeAvt2jqBk9VIOjRNr4HKS3ujkEMuigOn5fbSLruBbosgittsqd8w==@vger.kernel.org, AJvYcCWNOqF9uwzyWe37XB/pyANifxWpD9v/yEkxS/qexFXWj/ZxOjsCa7sgP3RyiRGjbYbX9zkT97OW/7XuENbt@vger.kernel.org
X-Gm-Message-State: AOJu0Yylbw2RyY+pVCWt0mUx1/JNwqwy1il9/HJM93s9r1E+fzedtYxu
	9NTM9xn8wNKCx+1i55FIIhMWx4/26w06tbuRfzdDIC06bu3daJSa5LlQsniKEnNnEtMIQQEWg85
	0NsgKm7IF9HdFvuVLDUX1DPfxGwQ=
X-Google-Smtp-Source: AGHT+IH1/GhbRsWSyANh50uc8M88WSxjprZCDk8VoeIYC1jtxBcv4TnQK+5M7MLYjGQig1BT6KeOLruZs65IMzaTUzk=
X-Received: by 2002:a17:906:3112:b0:aa6:707a:af59 with SMTP id
 a640c23a62f3a-aab77ec20acmr202767666b.50.1734091853539; Fri, 13 Dec 2024
 04:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-0-d842b6d8d02b@kernel.org>
 <20241212-btrfs_need_stripe_tree_update-cleanups-v1-3-d842b6d8d02b@kernel.org>
In-Reply-To: <20241212-btrfs_need_stripe_tree_update-cleanups-v1-3-d842b6d8d02b@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 12:10:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53==1femrx1u+T-azp0rjVpdvFgSEpufQGVR2+zdvf1Q@mail.gmail.com>
Message-ID: <CAL3q7H53==1femrx1u+T-azp0rjVpdvFgSEpufQGVR2+zdvf1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: pass btrfs_io_geometry to is_single_device_io
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 1:01=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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
> ---
>  fs/btrfs/volumes.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 088ba0499e184c93a402a3f92167cccfa33eec58..3636586371f6de2df76ecc67c=
2dbf2fdf3848995 100644
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
> @@ -6370,10 +6370,11 @@ static bool is_single_device_io(struct btrfs_fs_i=
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
> +       if ((map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
> +           io_geom->mirror_num > 1)

You can leave this in a single line, it stays at 83 characters, which
is not too long, making the code a bit more readable.

>                 return false;
>
>         return true;
> @@ -6648,8 +6649,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>          * physical block information on the stack instead of allocating =
an
>          * I/O context structure.
>          */
> -       if (is_single_device_io(fs_info, smap, map, num_alloc_stripes, op=
,
> -                               io_geom.mirror_num)) {
> +       if (is_single_device_io(fs_info, smap, map, num_alloc_stripes,
> +                               &io_geom)) {

Same here, can place the whole thing in a single line, it stays at 82
characters, making it more readable than 2 lines.

Like suggested for the previous patches, you can also mention this
reduces the object size since btrfs_need_stripe_tree_update() is a
non-trivial inline function.

Thanks.

>                 ret =3D set_io_stripe(fs_info, logical, length, smap, map=
, &io_geom);
>                 if (mirror_num_ret)
>                         *mirror_num_ret =3D io_geom.mirror_num;
>
> --
> 2.43.0
>
>

