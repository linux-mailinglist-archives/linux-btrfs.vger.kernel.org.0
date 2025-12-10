Return-Path: <linux-btrfs+bounces-19626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32522CB2F79
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 14:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 101FE300728E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1773203AB;
	Wed, 10 Dec 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHV3Nyyn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06A19D07A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371804; cv=none; b=Y9BJrBUuIgJ/BRAUsd5JXNZISKtcrU56ckHlAIxf9Q+gmIWDwbrC2tXW9WaleT0reHfBXcnDoYJbV3hh7ZfyFuGYkZ3loNKo6tpiL98OrNMdX9BODGW0krf2P8QAi8hCsW7K5c1UPbO5Gf0gjiQCGeSPPGD5GQJvzZfFsuRqGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371804; c=relaxed/simple;
	bh=WUNbnK32HJZeeK32aH2T01vCUfGXwgDgGrgqj63bf38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t41IjSeFiT2WEf4lEW8zJWsnunHs+yW0nN7FGR/k3tRx17o92c28G8BLcBsqSoFe//YH7jF0hYO0iqKilnduDoVSQ09DpnfC5hw0+ZGa0n6T1/HNYx8RVgzob2UT3TiMpBOrZQiC8JGrUOJuywF45kJICcj4Kj2VdMvdWP+D3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHV3Nyyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532ABC19422
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765371804;
	bh=WUNbnK32HJZeeK32aH2T01vCUfGXwgDgGrgqj63bf38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YHV3NyynReyaJ2waB0qm2grP+aQ4tsqndeHw5iw8Ua0YWuIAUZHdMBOYOuHIvLhRC
	 xNasH0SAHW4hPVR4Ab2EA7zbV17J5no2KH/ol6GuDqgyZ5rfFMsMmGUiH199Q5UDnR
	 TwY/ZbRGr0s0+S6jKdafYD5VmMH561LRZc43Ff8RMPs/60Yne3ewZl9mjyIfGrA2AF
	 DrkF89zi60mBOv/YD5TMyGhVYlLGVyu5vwnyFAAc6s0R8tzrahIy9503SJ/mhx4Y5g
	 fuCNJPIMlZFSbaCtGgcR2KYVgMCfEw/quKIuuPcInfU2JWLoudIN8II4ZZQ3Efmchz
	 wRXTvkXNsIodw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73545723ebso65369766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 05:03:24 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3lInExOm0k0H1PDZWMkTm/JzLV58rUBVsR8wdL0ASghvfuz0T
	it+Rx+tv2u8OEkmivzvje+Fjphi0sDD8q0m7yXhdN2LK2jEjj4pSbYOLcY60BSit/IRxdkBk9ef
	AM0OboYp+3x1Di4IcvHqPh4VrxCgUDQI=
X-Google-Smtp-Source: AGHT+IGj9133cPvshYnM8H0CbEsXnEd707YS0U+vgz1jgmFaJ08OApcW+TCgk5CH4aAyTOzdxYwbJFIOBUqZE+hw2OE=
X-Received: by 2002:a17:907:7244:b0:b79:de59:4002 with SMTP id
 a640c23a62f3a-b7ce82d34d8mr224398266b.2.1765371802846; Wed, 10 Dec 2025
 05:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210110442.11866-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20251210110442.11866-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 10 Dec 2025 13:02:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ArKoO+yrUQiAsVcybTJgDOKTNn5zJOz_F_Cj_mt82OA@mail.gmail.com>
X-Gm-Features: AQt7F2pReJ6r50IWqVMfe3TEqFjFhMY4XfbOokjtEoEZ0TAyiWLaS0zLQS2o-Vs
Message-ID: <CAL3q7H4ArKoO+yrUQiAsVcybTJgDOKTNn5zJOz_F_Cj_mt82OA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: print block-group type for zoned statistics
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:06=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> When printing the zoned statistics, also include the block-group type in
> the block-group listing output.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/sysfs.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7f00e4babbc1..5411e5275f83 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1188,6 +1188,20 @@ static ssize_t btrfs_commit_stats_store(struct kob=
ject *kobj,
>  }
>  BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stat=
s_store);
>
> +static const char *btrfs_block_group_type_name(u64 flags)
> +{
> +       switch (flags & BTRFS_BLOCK_GROUP_TYPE_MASK) {
> +       case BTRFS_BLOCK_GROUP_SYSTEM:
> +               return "SYSTEM";
> +       case BTRFS_BLOCK_GROUP_METADATA:
> +               return "METADATA";
> +       case BTRFS_BLOCK_GROUP_DATA:
> +               return "DATA";

Can we have mixed block groups for zoned?

Otherwise we miss a:

case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
    return "DATA+METADATA";

Just like we do in space_info_flag_to_str(), which is very similar to
this function by the way.
Maybe we can have a common function to repeat duplicated logic.

Thanks.

> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
>  static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
>                                       struct kobj_attribute *a, char *buf=
)
>  {
> @@ -1229,9 +1243,9 @@ static ssize_t btrfs_zoned_stats_show(struct kobjec=
t *kobj,
>         ret +=3D sysfs_emit_at(buf, ret, "active zones:\n");
>         list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list=
) {
>                 ret +=3D sysfs_emit_at(buf, ret,
> -                                    "\tstart: %llu, wp: %llu used: %llu,=
 reserved: %llu, unusable: %llu\n",
> +                                    "\tstart: %llu, wp: %llu used: %llu,=
 reserved: %llu, unusable: %llu (%s)\n",
>                                      bg->start, bg->alloc_offset, bg->use=
d,
> -                                    bg->reserved, bg->zone_unusable);
> +                                    bg->reserved, bg->zone_unusable, btr=
fs_block_group_type_name(bg->flags));
>         }
>         spin_unlock(&fs_info->zone_active_bgs_lock);
>         return ret;
> --
> 2.52.0
>
>

