Return-Path: <linux-btrfs+bounces-10840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F8A075D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 13:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849EB188980E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9BE21773E;
	Thu,  9 Jan 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG4P80tf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB621E515;
	Thu,  9 Jan 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426145; cv=none; b=SPHwqn+Vcg+LntU8V/mEl7AzaxrW1twS6y7eXQE1YMoKOxtc3lvkxsu35ZwdNE6uF/rvp+9j+6aQ7/zE40HAWTH5C6M7kIH1M1S8NJzbLVnk9fZ3XC+6GhfNSRC9WnHt78RU+lJLSjEoBnkBBOAAaxqGzJGypEuTNgoO7aTtDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426145; c=relaxed/simple;
	bh=VVPQgmQJXby0NMWhsrzkT7TqUKIxrwYmL1IPrACHjhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgeJLJdbtdLBbu0QNG5hoe7d4uFSR8sSGM1WKU0YkGweg4V1eW1/91TGIuMgfpmgn97it8AFR18jZMF8Eyygt/iQxhmHBrSy6H18LetFvLdrYKtNBUwT+WKL0psLBVT8uCEwxIZV22f0R//5hrwGpA09O31CaFs8sVdW9MWyHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG4P80tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E1C4CEE4;
	Thu,  9 Jan 2025 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736426144;
	bh=VVPQgmQJXby0NMWhsrzkT7TqUKIxrwYmL1IPrACHjhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OG4P80tf5M7SuAuOCccne9/a14pCSugUnkhDFhG2I3dxFqNhn7MZdzVKNrECkde1h
	 PM1EL9SbVqeuTua5rm953MvXJF0pvW0Xvd0IUFMGkih9bOf4VtiupylOwDaFnftfep
	 SlCESkGmLjPa9CHQH0lMSt9TvY5R3w27P0XEBA+IruUulE7yo7kZL6hcL6hMHThpxC
	 P0xumBO0MXP1+kqWEFpF7PeFbyKqwAjFu4JaU9RM2Or3ZOffJSCXvwYOSzHpvoPEJT
	 v7whugGfIG29eyina/QWN0TdwOnxeu7ZaBbvxA49uxpXWvy4gYP9Wh2szd70S1/zoW
	 7f0xGvAtz4jDg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeef97ff02so153700766b.1;
        Thu, 09 Jan 2025 04:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDrAv+10CjA0uOhG/RhU8UgdSpP3Es1ndagY17uPYK0qM7EH5cm5tbS5H+lU96givavwQ97nVEZD2syg==@vger.kernel.org, AJvYcCVxWo2JLov82qbJ+vC25JH9GrcPJqIxwxcezXVs7yn5oum02abkXEQyeNsvPJYEi7Xe/RWpgDLWDUbVaRHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfLHeN/7ihi7dUaRS+HO64Ds/ytWoFcdCu8plxbDNQy/Qk5xu
	tSXDaOTbCg1UwoW8kDNqexbGt6zTUDlDYcUYEoWd1SQvpV19o/P+m62A4exXU2sYsPKEq2pLGi0
	gOdHArTdkqC3pSAg4pVZQcMEs+Xs=
X-Google-Smtp-Source: AGHT+IGlAEV3gFqhI/fCumKf4Y0/OejPZHhvvuxi2cl53MjeT71jqt9xdQ9qlN4pSyeYEYcpAUIz2D1YoMBn+y7o5Io=
X-Received: by 2002:a17:907:787:b0:aa6:af4b:7c87 with SMTP id
 a640c23a62f3a-ab2ab6c5072mr557133766b.21.1736426143162; Thu, 09 Jan 2025
 04:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 12:35:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
X-Gm-Features: AbW1kvawhMScf2uCo-MOi6RKV6MDgmg-VuDDG5qy0ZF8o7gw5iaEraL4xsM4g1E
Message-ID: <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:48=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't try to delete RAID stripe-extents if we don't need to.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c             | 15 ++++++++++++++-
>  fs/btrfs/tests/raid-stripe-tree-tests.c |  3 ++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 45b823a0913aea5fdaab91a80e79d253a66bb700..757e9c681f6c49f2d0295c1b3=
b2de56aad3c94a6 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -59,9 +59,22 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
>         int slot;
>         int ret;
>
> -       if (!stripe_root)
> +       if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE) || !stripe_root=
)
>                 return 0;
>
> +       if (!btrfs_is_testing(fs_info)) {
> +               struct btrfs_chunk_map *map;
> +               bool use_rst;
> +
> +               map =3D btrfs_find_chunk_map(fs_info, start, length);
> +               if (!map)
> +                       return -EINVAL;
> +               use_rst =3D btrfs_need_stripe_tree_update(fs_info, map->t=
ype);
> +               btrfs_free_chunk_map(map);
> +               if (!use_rst)
> +                       return 0;
> +       }
> +
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..f060c04c7f76357e6d2c6ba78=
a8ba981e35645bd 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -478,8 +478,9 @@ static int run_test(test_func_t test, u32 sectorsize,=
 u32 nodesize)
>                 ret =3D PTR_ERR(root);
>                 goto out;
>         }
> -       btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> +       btrfs_set_super_incompat_flags(root->fs_info->super_copy,
>                                         BTRFS_FEATURE_INCOMPAT_RAID_STRIP=
E_TREE);

This hunk seems unrelated to the rest of the patch, could be fixed in
a different patch in case it actually solves any problem (probably
not, but it's an incompat feature so it should be changed anyway).

I agree the changelog should be more clear, just say we don't need to
attempt the delete if the rst feature is not enabled.

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);
>         root->root_key.objectid =3D BTRFS_RAID_STRIPE_TREE_OBJECTID;
>         root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
>         root->root_key.offset =3D 0;
>
> --
> 2.43.0
>
>

