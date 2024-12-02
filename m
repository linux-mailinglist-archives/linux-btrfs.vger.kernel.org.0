Return-Path: <linux-btrfs+bounces-10010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDB9E081C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE4DB8583D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A3220B1ED;
	Mon,  2 Dec 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/DDNIYT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C6207A1A;
	Mon,  2 Dec 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150454; cv=none; b=HpPUz1f8LVwtufGHza50I0k1/Alznr1RvDoRnhZLI/sLGN1fUX8E2kt8TEJdKatdEMrOIMlYOhwn6a/sdZIU8QZ+AccgQ+dQvKzQA5C5VInfs5B+jCI4M4Q6GoW77gh5x4AHwXSZeQIe1oHtsEPCX19pFEe8AL1wnKEed7UHJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150454; c=relaxed/simple;
	bh=PRG7lRHfCH/AOy2IzK0/HINWKGXyVXfdIOvVYneWVQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPsAZLSwv8l53WexO+pECein/SDmYivXrpO1azyGgu/tGN5b9abAzZ6V+Ww60fceUL6SSyKcMfqg0XEEviw3hw0a6eQFTzjrMHKvMkCFYMQsGXubae0e3eoDBBgWttAJqHX7W7uHz0HJK91xp+mGbFWmHBam47ELna86rj7B94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/DDNIYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32F2C4AF0B;
	Mon,  2 Dec 2024 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733150453;
	bh=PRG7lRHfCH/AOy2IzK0/HINWKGXyVXfdIOvVYneWVQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n/DDNIYTszX+kVw5x5jfdEM66C7A/6xQxM/R6bWLfGRZstI2nCEpJZjFoT3JWmEFZ
	 RosYQYuW8/muDAZ/fnBL+NhbpCjuQJzkvtLEihWw/kgmT7Eq5sXzqWCiVEObtyauH5
	 +AHvVNgeuNjbl+qL6QL22XBC9CqA/vy6IPoET5KOA0hgLln0vJpSplytPX2c9Xws2H
	 VfomFhbKmf7Xkknc3OV5eehKrbkyQ/n6+QWgo4d3qiIFBAJV05oBDGR9I7bnoGAThW
	 CsJ5CG34O13RLxRZP+dB7oFzq4Um5POkKVhao4XE8rvzHwtcPnaSxCvVrEyQ6yDGzy
	 3Ix9JT6go51LA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso40197966b.2;
        Mon, 02 Dec 2024 06:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbo7kYlUwNiJmChnLV1+Lgtdkd+/qd+BAC11RTv61k7mVl/+zMh1ddXkR8Y50Cdz8BnfCTttTfDfym8Q==@vger.kernel.org, AJvYcCW/fZNU3GeXyfWvJjY24HmQe8KxDAw/JAw7dv40u2aovh0gPq5fX76+HKgR9X3ZaVi+d7gsBUpiLR/qsyAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRzWtrutn/h/IU5l/BK4g1XYUcVeK3vuqSI1Nr2Do26aNRDw7
	uLuxRp1waAghKmNmxa9jKGZenCaBzAtGaq6PW0sdihf50p8pfbiEyKal446L2HEuP56VOaydZBV
	HckO+OT+cjJCGaKuQFbHg9pswhYc=
X-Google-Smtp-Source: AGHT+IHBBtEUIfc5B+pRpoul44iMfPE/gDMvt+J38VE2ReEGeWOFBRm/diUV9cNrMyqVGIH7gnPjYjJ9MYzAFXln1tc=
X-Received: by 2002:a17:906:9d2:b0:a99:f605:7f1b with SMTP id
 a640c23a62f3a-aa581078a5fmr2321380466b.60.1733150452429; Mon, 02 Dec 2024
 06:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5U_88NA2PmyMvtwv1aZ7k+V6v=eetp7Hs2HqDdfVjokw@mail.gmail.com>
 <20241202133515.92286-1-zhenghaoran154@gmail.com>
In-Reply-To: <20241202133515.92286-1-zhenghaoran154@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Dec 2024 14:40:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7dxA+Y30XbB1nng1duaoT8c9Pf4ZG6+iwikTGvb4cAXA@mail.gmail.com>
Message-ID: <CAL3q7H7dxA+Y30XbB1nng1duaoT8c9Pf4ZG6+iwikTGvb4cAXA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix data race when accessing the inode's
 disk_i_size at btrfs_drop_extents()
To: Hao-ran Zheng <zhenghaoran154@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 1:35=E2=80=AFPM Hao-ran Zheng <zhenghaoran154@gmail.=
com> wrote:
>
> A data race occurs when the function `insert_ordered_extent_file_extent()=
`
> and the function `btrfs_inode_safe_disk_i_size_write()` are executed
> concurrently. The function `insert_ordered_extent_file_extent()` is not
> locked when reading inode->disk_i_size, causing
> `btrfs_inode_safe_disk_i_size_write()` to cause data competition when
> writing inode->disk_i_size, thus affecting the value of `modify_tree`.
>
> Since the impact of data race is limited, it is recommended to use the
> `data_race` mark judgment.

This should explain why it's a harmless race.
Also it's better to explicitly say harmless race rather than say it
has limited impact, because the latter gives the idea of rare problems
when we don't have any.

>
> The specific call stack that appears during testing is as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DDATA_RACE=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_drop_extents+0x89a/0xa060 [btrfs]
>  insert_reserved_file_extent+0xb54/0x2960 [btrfs]
>  insert_ordered_extent_file_extent+0xff5/0x1760 [btrfs]
>  btrfs_finish_one_ordered+0x1b85/0x36a0 [btrfs]
>  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>  finish_ordered_fn+0x3e/0x50 [btrfs]
>  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>  process_scheduled_works+0x716/0xf10
>  worker_thread+0xb6a/0x1190
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DOTHER_INFO=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>  btrfs_inode_safe_disk_i_size_write+0x4ec/0x600 [btrfs]
>  btrfs_finish_one_ordered+0x24c7/0x36a0 [btrfs]
>  btrfs_finish_ordered_io+0x37/0x60 [btrfs]
>  finish_ordered_fn+0x3e/0x50 [btrfs]
>  btrfs_work_helper+0x9c9/0x27a0 [btrfs]
>  process_scheduled_works+0x716/0xf10
>  worker_thread+0xb6a/0x1190
>  kthread+0x292/0x330
>  ret_from_fork+0x4d/0x80
>  ret_from_fork_asm+0x1a/0x30
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
> ---
> V1->V2: Modify patch description and format
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4fb521d91b06..f9631713f67d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -242,7 +242,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *tra=
ns,
>         if (args->drop_cache)
>                 btrfs_drop_extent_map_range(inode, args->start, args->end=
 - 1, false);
>
> -       if (args->start >=3D inode->disk_i_size && !args->replace_extent)
> +       if (data_race(args->start >=3D inode->disk_i_size && !args->repla=
ce_extent))

Don't surround the whole condition with data_race().
Just put it around the disk_i_size check:

if (data_race(args->start >=3D inode->disk_i_size) && !args->replace_extent=
))

This makes it more clear it's about disk_i_size and nothing else.

Thanks.

>                 modify_tree =3D 0;
>
>         update_refs =3D (btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJECTID=
);
> --
> 2.34.1
>
>

