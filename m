Return-Path: <linux-btrfs+bounces-20395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEFD12942
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CEF530938D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BA7357A22;
	Mon, 12 Jan 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDZV9c1S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821A14BF92
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221622; cv=none; b=Wpsfi9OU9d2BygKdgvKjczyxBnCq7ugpuyn3vu/FcVydO/xneRlO6YmR6v+LB/64V0p8UITfX5jap3NuSKPbQnujWnPcW3wWJCEBkvPwxK9w/xs4gA7ld2bUgpMYMhVP4tc+seCJx1M75CUq9MdYwH8QdnBam2U1d350GIBG3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221622; c=relaxed/simple;
	bh=Avrxx2MoP1cpa3Im5iSgDOPrVMa9u48vCPQB8yAMjJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqs+sL1GOym3CIfRNb8/U0OazljLckW9zKQ0xT1LW2uMJexjJX6XSWie3U2YTl0GelNGmMsL72lJVRjsjbYjxNiaoV4PKvNpQjF2q03cl0dv0+NcUeO97Nlhsy9aoJt+SCYNXjBKqLWTOhhKO12szm33JphORMx5/W6ITlFeQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDZV9c1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04FC19424
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768221622;
	bh=Avrxx2MoP1cpa3Im5iSgDOPrVMa9u48vCPQB8yAMjJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDZV9c1SEQ5/Ky8rZjfzGYJMQsJhzduZ1dnCOSpD2QaAW4bDDCF4QSpyo+Xp/8oT1
	 RFd9rPq/j7rZ7K+sw2Xie/Jn8MCz/6mMRCi/KzwVNtoYClmSjiApP+w8oZFXV4UuKY
	 ZAAJ8NonmVOcWseNHv49itMJ7aH85hMBaZ5X4kLn/8RSvJ2qgDY+hGHNAPA9oZpbBC
	 HsaSryLB3mRXBCAdLDfwTBSfdOveVXuO1iCLgAQsBrAiGP440rXc3auDXwvYAgURMx
	 C3diQoaZcwAGYHM1lMIozhyLr2BxfFxdrsl/Ku6FMOBeFnxue3HHdUY1wogZNGlg98
	 i2fEdD1zZOyLw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8707005183so203484266b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 04:40:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWgmN0DPqfOvA/5DEdaZEkRr7/gwwo6+Bl36vz1e3/gm5Zgx1QszC1lCJUOok3k95Zn9xZzGT3qqt4JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZCHiUzRm/OyPQMTxkCvELm/qWOKW4n2JW4l51qBHAdYfuB2g
	vCKoWDfVzCCl99/zqMjW4QXcz1ANCy5TVXLgVZ/2lM4dud8HchJyXr/rTf/GI0BqW4MhL9BElaQ
	W4Cp7oX++pioBIMNcIVHyK5f2KJA4HoM=
X-Google-Smtp-Source: AGHT+IGoz34SNiUV+9qgG3GsiSpTOoKqRL4a9w91qvwZ9gFdSRueYTxsoRJpgpt4N7jV9yNgFsSJ8eppbwzFYZXV6gw=
X-Received: by 2002:a17:907:1c11:b0:b87:22b2:6533 with SMTP id
 a640c23a62f3a-b8722b287ddmr216954766b.54.1768221620788; Mon, 12 Jan 2026
 04:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5TPCmtbupb_gQuEnvFhh2dKU89T6C2TsUJqts8gxW00w@mail.gmail.com>
 <20260111202457.23698-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260111202457.23698-1-jiashengjiangcool@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 Jan 2026 12:39:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7c=Pa1D63M50MEn7PoSqi4K749KD5S2+EaVz=n53h2sw@mail.gmail.com>
X-Gm-Features: AZwV_QiFxP079jsxABb8B9YPgDbqVaoxEXSqw71SGpGPN0ISb0RMB-OgC-TlBBM
Message-ID: <CAL3q7H7c=Pa1D63M50MEn7PoSqi4K749KD5S2+EaVz=n53h2sw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reset block group size class when reservations
 are freed
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:25=E2=80=AFPM Jiasheng Jiang
<jiashengjiangcool@gmail.com> wrote:
>
> Differential analysis of block-group.c shows an inconsistency between
> btrfs_add_reserved_bytes() and btrfs_free_reserved_bytes().
>
> When space is reserved, btrfs_use_block_group_size_class() is called to
> set a block group's size class, specializing it for a specific allocation
> size to reduce fragmentation. However, when these reservations are
> subsequently freed (e.g., due to an error or transaction abort),
> btrfs_free_reserved_bytes() fails to perform the corresponding cleanup.
>
> This leads to a state leak where a block group remains stuck with a
> specific size class even if it contains no used or reserved bytes. This
> stale state causes find_free_extent to unnecessarily skip these block
> groups for mismatched size requests, leading to suboptimal allocation
> behavior.

Not necessarily always. If there are subsequent allocations for the
same extent size, then there's no problem at all.

There's more than skipping, it can cause allocation of new block
groups if there are none with a matching size class and there aren't
any without a size class.

I wonder if you observed this in practice and what kind of workload.

I think that should be rephrased because as it's stated it gives the
wrong idea that it will always cause bad behaviour, while in reality
that depends a lot on the workload.

>
> Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
> btrfs_free_reserved_bytes() when the block group becomes completely
> empty.
>
> Fixes: 606d1bf10d7e ("btrfs: migrate the block group space accounting hel=
pers")

What? That's completely wrong.

First, that commit only moved code around.
Secondly, that commit happened (2019) before we had support for block
group size classes (2022).

The proper commit would be 52bb7a2166af ("btrfs: introduce size class
to block group allocator").


> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Inlined btrfs_maybe_reset_size_class() function.
> 2. Moved check below the reserved bytes decrement in btrfs_free_reserved_=
bytes().
> ---
>  fs/btrfs/block-group.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..8339ad001d3f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3867,6 +3867,12 @@ void btrfs_free_reserved_bytes(struct btrfs_block_=
group *cache, u64 num_bytes,
>         spin_lock(&cache->lock);
>         bg_ro =3D cache->ro;
>         cache->reserved -=3D num_bytes;
> +
> +       if (btrfs_block_group_should_use_size_class(cache)) {
> +               if (cache->used =3D=3D 0 && cache->reserved =3D=3D 0)
> +                       cache->size_class =3D BTRFS_BG_SZ_NONE;
> +       }
> +
>         if (is_delalloc)
>                 cache->delalloc_bytes -=3D num_bytes;
>         spin_unlock(&cache->lock);
> --
> 2.25.1
>

