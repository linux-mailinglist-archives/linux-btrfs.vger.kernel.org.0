Return-Path: <linux-btrfs+bounces-15590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CF9B0C246
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFD418C356D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC562951D2;
	Mon, 21 Jul 2025 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4UGCnqI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BBD27F4CB
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096191; cv=none; b=E0wYE9rTejzQqiUa4yWA5HBa1TY4541BDAm5GBgMGT9LhB+h5Dm+C15dujIQfsB86vqhh0x3oLW7lX8JwG9eRF/ovBYHQxir0DSFpuBn2A2JcB476cNP9CHCR7QjwFsNbdvIDEk1LOLLTTEsapFEEbiQxrCWRJGfYiqHevJn2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096191; c=relaxed/simple;
	bh=tiwvntAM/cnoH22fNnq4qsnT0OywyVASo2H+PVgEBM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed+YCOQy0rQ4RBGQM+6an/FCNFouA9UglWnZelWKEVsuE+xoz78l9BQlymQbpozxlX89SCZ4MMz8i8mAc6v5z1Phjn61VUQh+nWynigOJzy1beku0zlj/lGmR2MuMZ31xV/0E0M4dAl91hIl2WLI0QtHuJvGMVQ9CICXVzXHFSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4UGCnqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A56C4CEED
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 11:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753096190;
	bh=tiwvntAM/cnoH22fNnq4qsnT0OywyVASo2H+PVgEBM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W4UGCnqIiXT2jBsPVl/4XGjy0iPqI87SOgbpHLYBUBUZVPzZ3+OGfWSFnj2VnJzlx
	 j+W65E4gEV+TNMnVeQLWdHeSA3rX0i7yi3xR92I5kAU7z0NcANH4EHUjj/Lt5oJLsy
	 yylhPDTR5x8sKJpdTan2j0pZsGquD3CO5DEH/ENdoJ9/I9gsj+tdTXBKFCTtCnIVti
	 sGIWc7awuH90U3052Px26s0UaEgp4wSNWXAF1x/z69GLsWQaQkSfo7xohOERoRmAjb
	 6XDQjTudlg9e3mVeS1xOTLyHOGF7sCOGiDs6WxBcnDQ2kP8DtryHV11VUihU3flRdF
	 as1q/0QJsVHiA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so6523171a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 04:09:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy26rZ6zHcy29aYA2toShzEmxCygJ043W4x1EcyXrA2NPCRnRau
	+utSAlXE8Tn1cWovXWhX0nfTzyxp9LcVrd1mny8cDorV3qSsuQQRgNF4+GE/wWeD23jk4P3Tpv5
	zvBMJwQW3jJ4lThR+2TbJKSTNM90Vn00=
X-Google-Smtp-Source: AGHT+IEjai5h9M8ZBdDBJWZUKYEZfsm4Q1s5tJ2QblCyssEKT17qIzNV3erHJcSXH9W9Tvslj5vFkW2Jxbgq3cPPe5s=
X-Received: by 2002:a17:906:4791:b0:ae9:8cb4:2fe8 with SMTP id
 a640c23a62f3a-ae9c9ac0f24mr1816462866b.37.1753096189526; Mon, 21 Jul 2025
 04:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721070216.701986-1-jth@kernel.org> <20250721070216.701986-3-jth@kernel.org>
In-Reply-To: <20250721070216.701986-3-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 21 Jul 2025 12:09:12 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7wsjYFq8D61FC90Gcg4=cnyx1FQfWb_wAD4EyZ26OzQw@mail.gmail.com>
X-Gm-Features: Ac12FXyQcbEat3L8IE5GckpacI2lDUiVQ2GrK4W8ar8HsIwaxeJK3QlpIB5Nw7E
Message-ID: <CAL3q7H7wsjYFq8D61FC90Gcg4=cnyx1FQfWb_wAD4EyZ26OzQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: zoned: return error from btrfs_zone_finish_endio()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:02=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Now that btrfs_zone_finish_endio_workfn() is directly calling
> do_zone_finish() the only caller of btrfs_zone_finish_endio() is
> btrfs_finish_one_ordered().
>
> btrfs_finish_one_ordered() already has error handling in-place so
> btrfs_zone_finish_endio() can return an error if the block group lookup
> fails.
>
> Also as btrfs_zone_finish_endio() already checks for zoned filesystems an=
d
> returns early, there's no need to do this in the caller. For developer
> builds leave the ASSERT() in place to check for a block-group lookup
> failure.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c |  8 +++++---
>  fs/btrfs/zoned.c | 10 +++++++---
>  fs/btrfs/zoned.h |  9 ++++++---
>  3 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7ed340cac33f..bfddbbd46366 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3102,9 +3102,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>                 goto out;
>         }
>
> -       if (btrfs_is_zoned(fs_info))
> -               btrfs_zone_finish_endio(fs_info, ordered_extent->disk_byt=
enr,
> -                                       ordered_extent->disk_num_bytes);
> +       ret =3D btrfs_zone_finish_endio(fs_info, ordered_extent->disk_byt=
enr,
> +                                     ordered_extent->disk_num_bytes);
> +       if (ret) {
> +               goto out;
> +       }

There's a single statement inside the if block, so no { } please.

>
>         if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
>                 truncated =3D true;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 4444a667c71e..b1320b12e0e4 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2431,16 +2431,19 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devi=
ces *fs_devices, u64 flags)
>         return ret;
>  }
>
> -void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,=
 u64 length)
> +int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, =
u64 length)
>  {
>         struct btrfs_block_group *block_group;
>         u64 min_alloc_bytes;
>
>         if (!btrfs_is_zoned(fs_info))
> -               return;
> +               return 0;
>
>         block_group =3D btrfs_lookup_block_group(fs_info, logical);
> -       ASSERT(block_group);
> +       if (!block_group) {
> +               ASSERT(block_group);

This is an odd style and was pointed out before in other patches.
The ASSERT before the if check was perfectly fine and less odd.

But if we can handle the error, why an assert at all?
We could just do:

if (WARN_ON_ONCE(!block_group))
     return -ENOENT;

As it's one of those "impossible" errors, the stack trace from the
WARN_ON will let us know where it happened in case CONFIG_BTRFS_ASSERT
is not enabled plus allows the compiler to generate better code due to
'unlikely' inside the macro.

> +               return -EIO;

-EIO is an odd choice as this is not an IO error.
-ENOENT is more meaningful here.

Thanks.

> +       }
>
>         /* No MIXED_BG on zoned btrfs. */
>         if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
> @@ -2457,6 +2460,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *=
fs_info, u64 logical, u64 len
>
>  out:
>         btrfs_put_block_group(block_group);
> +       return 0;
>  }
>
>  static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 6e11533b8e14..17c5656580dd 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -83,7 +83,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *=
tgt_dev, u64 logical,
>  bool btrfs_zone_activate(struct btrfs_block_group *block_group);
>  int btrfs_zone_finish(struct btrfs_block_group *block_group);
>  bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 fl=
ags);
> -void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
> +int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
>                              u64 length);
>  void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
>                                    struct extent_buffer *eb);
> @@ -234,8 +234,11 @@ static inline bool btrfs_can_activate_zone(struct bt=
rfs_fs_devices *fs_devices,
>         return true;
>  }
>
> -static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info=
,
> -                                          u64 logical, u64 length) { }
> +static inline int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
> +                                          u64 logical, u64 length)
> +{
> +       return 0;
> +}
>
>  static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_grou=
p *bg,
>                                                  struct extent_buffer *eb=
) { }
> --
> 2.50.0
>
>

