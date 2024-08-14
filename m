Return-Path: <linux-btrfs+bounces-7190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28E951BE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 15:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524FC1C250BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BA1B29CC;
	Wed, 14 Aug 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiGV8uqq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF41D52D;
	Wed, 14 Aug 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642300; cv=none; b=u5Z1XawT5AMhAsYm98e23fnyUtgsbNK9DhoEPi7Tt9DbztHLDiAS7IJrC/o2JbF+G6SaIUkPNghwL1XvDEP/TbHiGbZ3atS7cd06Gx5+FDFOMhCgYvnekKW+qt/VsKZS+pBmMBDOaCrGIg7vsH4x4EwswGaYGx6pRKofaCboFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642300; c=relaxed/simple;
	bh=N2JwO/fffqrGNr/VjKdAj72jF63IGLf9g/4hcjAjCOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJWtYhoyCQP8Oos6GJQLFqbBbW7aYCzbqvaDxdRh8TfGRyrxsG6hN1tpxgaGRUmvXrBKOoAr2INl2qlugUoC7nEVJJNNK3vNFdLaNcUplqrHdlhTDFgBlDrDyfOUseOiYotG4+OiwLcrWx/S1q++7VORU9zfJxXUjAVlf+q8Y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiGV8uqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC72C4AF12;
	Wed, 14 Aug 2024 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723642299;
	bh=N2JwO/fffqrGNr/VjKdAj72jF63IGLf9g/4hcjAjCOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CiGV8uqqCefq0FbnKNBCHJSjryx8f/ObU/tr6rx2+q3/7BpGwiEmW0IHARgbJwFiq
	 6h8nvCASuMqVefMcqEfmVB08gPXFsCnBEwOpZLWOleiIel0H78Mv/7HVOulsWgYYI/
	 zg2Pi2Je5YHzHCrriRTT1mpy947Sqbdotnfd2vEDYRNxODo1y6HBwDUyvrNkV6StMT
	 y2H1Fdn+Owrdt5oHubv0bHoAhZty6mL1jSaw/gHWX0hiA1oyiH0XA5EhavzEJ4/3sR
	 HERwwLKHU9CzKE8TPZXYPK1vHJrkEUZkJsRSSpf5OsffG0ZSUh3WpdTWOLdY+Nv+bl
	 QfTyefXf2KPtQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aac70e30dso739888866b.1;
        Wed, 14 Aug 2024 06:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmJXF+eVpTwjtRplXNHfNAwQd0dAmnlVVfTd5H75hR/0URW/voAiCAoADEbH6tcZ3AZcpESdmzpHu7TFuMxu7/XHnojr4JKflBwZUYM6mZUFY/7jIPEtdneO2zS7MA6Zxt+PKZ/jfxti8=
X-Gm-Message-State: AOJu0Yy0vYMkAO4o2cSkvWnOiX/4FJXhY5z4EZYz0q/me3Xk0q6EVABU
	sdveAmoYud6pDjy3TdVo1o8rznsDIX12gDm7gXpXu3qyocu+jdOrg0V72coqyEqZf8+t+uwya0U
	IARFg0D/7+V7cd0DFCsTa5DUvm4g=
X-Google-Smtp-Source: AGHT+IE4tbMsQyQ8pyIi2iebjAdBbDtNjchc/W2yBZTKl44QyGf35FA6kMeBHuRgtmpHys3A0WDL2aAA0CtlpHnpQGA=
X-Received: by 2002:a17:907:7e9b:b0:a72:4676:4f8 with SMTP id
 a640c23a62f3a-a83670955fdmr229678066b.62.1723642298112; Wed, 14 Aug 2024
 06:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
In-Reply-To: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 Aug 2024 14:31:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
Message-ID: <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:46=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshin <johannes.thumshirn@wdc.com>
>
> Running fstests btrfs/011 with MKFS_OPTIONS=3D"-O rst" to force the usage=
 of
> the RAID stripe-tree, we get the following splat from lockdep:
>
>  BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/sdb=
 started
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.11.0-rc3+ #592 Not tainted
>  --------------------------------------------
>  btrfs/4203 is trying to acquire lock:
>  ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_ma=
p_block+0x39f/0x2250
>
>  but task is already holding lock:
>  ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_ma=
p_block+0x39f/0x2250
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&fs_info->dev_replace.rwsem);
>    lock(&fs_info->dev_replace.rwsem);
>
>   *** DEADLOCK ***

Is this really the full splat?
There should be a stack trace showing that the problem happens when
btrfs_map_block() is called within the scrub/dev replace code, no?


>
>   May be due to missing lock nesting notation
>
>  1 lock held by btrfs/4203:
>   #0: ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btr=
fs_map_block+0x39f/0x2250
>
> This fixes a deadlock on RAID stripe-tree where device replace performs a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.
>
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>
>
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---
>  fs/btrfs/volumes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4b9b647a7e29..e5bd2bee912d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6459,6 +6459,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>         int dev_replace_is_ongoing =3D 0;
>         u16 num_alloc_stripes;
>         u64 max_len;
> +       bool rst;

The name is a bit confusing, something like "update_rst" is more
meaningful and clearly indicates it's a boolean/condition.

>
>         ASSERT(bioc_ret);
>
> @@ -6475,6 +6476,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>         if (io_geom.mirror_num > num_copies)
>                 return -EINVAL;
>
> +       rst =3D btrfs_need_stripe_tree_update(fs_info, map->type);
> +
>         map_offset =3D logical - map->start;
>         io_geom.raid56_full_stripe_start =3D (u64)-1;
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
> @@ -6597,13 +6600,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>                  * For all other non-RAID56 profiles, just copy the targe=
t
>                  * stripe into the bioc.
>                  */
> +               if (rst && dev_replace_is_ongoing)
> +                       up_read(&dev_replace->rwsem);
>                 for (int i =3D 0; i < io_geom.num_stripes; i++) {
>                         ret =3D set_io_stripe(fs_info, logical, length,
>                                             &bioc->stripes[i], map, &io_g=
eom);

So, why is this safe? The change log doesn't mention anything about
the chosen fix.

So even if this is called while we are not in the device replace code,
btrfs_need_stripe_tree_update() can return true.
In that case we unlock the device replace semaphore and can result in
a use-after-free on a device, like this:

1) btrfs_map_block() called while not in the device replace code
callchain, and there's a device replace for device X running in
parallel;

2) btrfs_need_stripe_tree_update() returns true;

3) we unlock device replace semaphore;

4) we call set_io_stripe() which makes bioc point to device X, which
is the old device (the one being replaced);

5) before we read lock the device replace semaphore at
btrfs_map_block(), the device replace finishes and frees device X;

6) the bioc still points to device X... and then it's used for doing IO lat=
er

Can't this happen? I don't see why not.
If this is safe we should have an explanation in the changelog about
the details.

Thanks.


> +
>                         if (ret < 0)
>                                 break;
>                         io_geom.stripe_index++;
>                 }
> +               if (rst && dev_replace_is_ongoing)
> +                       down_read(&dev_replace->rwsem);
> +
>         }
>
>         if (ret) {
>
> ---
> base-commit: 4ce21d87ae81a86b488e0d326682883485317dcb
> change-id: 20240814-dev_replace_rwsem-new-91c160579246
>
> Best regards,
> --
> Johannes Thumshirn <jth@kernel.org>
>
>

