Return-Path: <linux-btrfs+bounces-20379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EFD0FA84
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 20:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878BD304F155
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213CD352F88;
	Sun, 11 Jan 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYoUcGQE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB91F8AC5
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159962; cv=none; b=IiH/e6/CO9uLl7yDcbsP+QnRfbhesIG2kSAsncgrwjwbTvRIm+3gjZDCpdhVtTB1RcbK7TPDJ2MwZU/Bk/cYCyEsAvKQKeLoLE6CAUYlWM5MFCr7wg8UkQ6/OlXyUrJc4Y9KrAZgSIZZJec2DWnAWdDZKHBv6NB/RNcwn7w9rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159962; c=relaxed/simple;
	bh=0lNg4jRY9Oh7qPX8/PN+mAElpU1u7Gc871L3knnaPTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtimmOC94QFhX+xaOJQ+q4Ew5TR5Bses0np+HbgG3Va5d6d+zYayuZtFbCOGtBaV6nZnOOqSdZpCwpA3afj8+12PVrsTmWii9cVx9t5OevUGOvxvQNHOfKefW3Yr0y3ZfG4hpWiOfsPSi0BoMtgbY8a8E9wR+h+xE06QRO5mNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYoUcGQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202C4C19425
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768159962;
	bh=0lNg4jRY9Oh7qPX8/PN+mAElpU1u7Gc871L3knnaPTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oYoUcGQEMwjkV0DCAr76SfP5CNJoZDOkbUHTJ10vsApqiQpiQj39kGUKc5pRLuMzg
	 2G4CDFNVmUTXkSLi6rPmRRwftB2LZ8avSc2ATejCtjxLHksV8Np0znKUNs1wxG0wt/
	 1bKKUnBysZIbccC3sl5oiKbvnFERIF1HgECfLfh8O4nv7uUyz3dUrwEoPnk/M8OFNB
	 eZX2Wld8slFMovbq2I5e3e7wCzWJInShdCb+5dHR7nQ/khW04MGI2TnJNCHzn6Yme7
	 WLMfF4MMQngNwS+beG7BTq6oHC+vjue4NksBsJBNGHDzyurE8ZeOl5Phw6Nov9FmVi
	 IQKG1Rum039sg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so945237566b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 11:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1QFwuHoWB6fRg36bXDPXepcHK5x0iSY4tQ8CqjLgSOZbLREPVvOWe50cG64BuzCTRskIw7INlAZcEiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOI/bkEnt0G4uPPYHWPHuGWYsru4KUa5qJQbfYZiMlXdc6Jfh
	UBVgKZRPJw/szE0A+Kq2jKpy1uGcm/CVUwjASViDlchMAC3oa14/EZnpGfNgWdDIK5SdOR8iJAB
	bHid/NY1Wn/wgV/FqKHWsQ5VBHnsTveI=
X-Google-Smtp-Source: AGHT+IHOhmYy31BtP5SOJ4FJ0A/sfxYIwdUl/Fl9zQYI5MfWIhRP4axqacYpn1oRvKNBYIRJzvgIO1zybe0M9Zyy6R0=
X-Received: by 2002:a17:906:c154:b0:b86:fc0a:8d86 with SMTP id
 a640c23a62f3a-b86fc0a98d4mr430427466b.39.1768159960681; Sun, 11 Jan 2026
 11:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110203340.12443-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260110203340.12443-1-jiashengjiangcool@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 11 Jan 2026 19:32:03 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5TPCmtbupb_gQuEnvFhh2dKU89T6C2TsUJqts8gxW00w@mail.gmail.com>
X-Gm-Features: AZwV_QimQ0xg-3u-Eg_wa-nWCMHlyILt0CU-I8aQjIpwUbCiF16Y-jVymcRl6Rg
Message-ID: <CAL3q7H5TPCmtbupb_gQuEnvFhh2dKU89T6C2TsUJqts8gxW00w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reset block group size class when reservations are freed
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 8:34=E2=80=AFPM Jiasheng Jiang
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
>
> Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
> btrfs_free_reserved_bytes() when the block group becomes completely
> empty.
>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/block-group.c | 11 +++++++++++
>  fs/btrfs/block-group.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..1ecac4613a3e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3865,6 +3865,10 @@ void btrfs_free_reserved_bytes(struct btrfs_block_=
group *cache, u64 num_bytes,
>
>         spin_lock(&space_info->lock);
>         spin_lock(&cache->lock);
> +
> +       if (btrfs_block_group_should_use_size_class(cache))
> +               btrfs_maybe_reset_size_class(cache);

This will do nothing, since we decrement the block group's reserved
counter below, and  btrfs_maybe_reset_size_class() only resets the
size class if cache->reserved =3D=3D 0.

> +
>         bg_ro =3D cache->ro;
>         cache->reserved -=3D num_bytes;
>         if (is_delalloc)
> @@ -4717,3 +4721,10 @@ bool btrfs_block_group_should_use_size_class(const=
 struct btrfs_block_group *bg)
>                 return false;
>         return true;
>  }
> +
> +void btrfs_maybe_reset_size_class(struct btrfs_block_group *bg)
> +{
> +       lockdep_assert_held(&bg->lock);
> +       if (bg->used =3D=3D 0 && bg->reserved =3D=3D 0)
> +               bg->size_class =3D BTRFS_BG_SZ_NONE;
> +}

This is so short and only used in one place.
So no need to make this a function and certainly no need to export it
as it's only used in this file.

Thanks.

> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5f933455118c..7e02db8a8bc6 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -395,5 +395,6 @@ int btrfs_use_block_group_size_class(struct btrfs_blo=
ck_group *bg,
>                                      enum btrfs_block_group_size_class si=
ze_class,
>                                      bool force_wrong_size_class);
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_gr=
oup *bg);
> +void btrfs_maybe_reset_size_class(struct btrfs_block_group *bg);
>
>  #endif /* BTRFS_BLOCK_GROUP_H */
> --
> 2.25.1
>
>

