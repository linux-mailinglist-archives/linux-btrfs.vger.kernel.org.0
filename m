Return-Path: <linux-btrfs+bounces-19700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA0CB888D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3DA308DAFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC287313E0A;
	Fri, 12 Dec 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw39MQk6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E232874E3
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533002; cv=none; b=POSZhdenH38d9Ss1neM7/tGxtf1sP10seiyaAhRVN2jjKELcmNxrqmEvd67qmHeP3s/4p+DZuvuxYxabxf+85mxs1os6yrdjR5D+HL7+AVBjNAypdBs/Z9jx2KsEv1ClD3nbaDs0GiMBeAZjGpVwx5rqKGDBJL+CoI1o5QrRsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533002; c=relaxed/simple;
	bh=T4tNXu31ObA5nUgt/4TUzLsJ9g4Vl0CnbRCxl0D/dGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4ejiZB0jhYPP6p9tK1uxZWZ7mFgL0uUFoDChfc3gIvr0bYNA2Eg1Bi41zq+70CzDwsDf0OwyRC9fh1DEnvmk9OCNr+AElZjiLbqEQ3OCnkj4OkzZPkWJ6MDD9V8ergyDmyHAaCSMfEB8Ze8UPhce9WGoWOesplyZBRNipNEi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw39MQk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5DDC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765533001;
	bh=T4tNXu31ObA5nUgt/4TUzLsJ9g4Vl0CnbRCxl0D/dGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aw39MQk6CyR+y51VBQ/g7cR5YBySyop22EBxYwg8g/Ayftjls6G3Q+YRY0yjQsWK2
	 fNoQYK03VftueLvjNlHkcYqF8Z08E5Pg7lKMODBSMZBXCgVhoUp2ZlyVDORBmiNEs0
	 A4p2egS20aFsoz+lzk0goaKFl5fmQrf7IbDmydTlTTR5um7IGozf8zgVglwYtfuN5C
	 72vcLglQOXiU5LLNS4HaBK5BwjyNGWx8hgbqDMzMzS2yI2C5KM9hjDft8NfmNfjV4D
	 U3rMukWM/XjwkxDgS+HT4SZiKdK2Oog2Pf1ilE4k0wPzhBgspOo7a6uWW2lB2o/xCh
	 0auiDFc3Azhuw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b728a43e410so163509966b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:50:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3seG+zghdU53RuY22/jkf5sMkZoyTUVRvoy3+wV0/SkPo0lW8
	RDatA01grQRareCg57AoLdLYKeG/Ab3C+zPvtLSO/vL54OnA2kyv3Waowc+86X/fV7OjY8Eb20B
	3h632IXa1roqWp1HeJptpCUDPkd+Wmkg=
X-Google-Smtp-Source: AGHT+IE2iwfFbK9WXyykFEu6mrMvABFYz8cViSMTYeaeZmuu72dP+HLzZAP6QTT5+oy6hqorrDzB5oil8Qbr9UkRH20=
X-Received: by 2002:a17:907:1ca7:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b7d238f0470mr137275966b.13.1765533000360; Fri, 12 Dec 2025
 01:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212071000.135950-1-johannes.thumshirn@wdc.com> <20251212071000.135950-5-johannes.thumshirn@wdc.com>
In-Reply-To: <20251212071000.135950-5-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Dec 2025 09:49:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6tZXsXwbVLm2jPZLv2Dz+ovZGn8SSmoW7Ahq9Kp_L3ug@mail.gmail.com>
X-Gm-Features: AQt7F2oClsp_3LPLSP2RI7zvAIngmKpXrQwzd3VQbEc1WmhRaB5oA8Ks8IQapNg
Message-ID: <CAL3q7H6tZXsXwbVLm2jPZLv2Dz+ovZGn8SSmoW7Ahq9Kp_L3ug@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] btrfs: zoned: also print stats for reclaimable zones
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:10=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Currently the zoned stats are confined to the filesystems active zones
> and not to the reclaimable zones.
>
> Also print the zone information for the reclaimable zones.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 63588f445268..b3e523e6d6fd 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2988,6 +2988,7 @@ int btrfs_reset_unused_block_groups(struct btrfs_sp=
ace_info *space_info, u64 num
>  void btrfs_show_zoned_stats(struct btrfs_fs_info *fs_info, struct seq_fi=
le *s)
>  {
>         struct btrfs_block_group *bg;
> +       size_t reclaimable;
>
>         seq_puts(s, "\n");
>
> @@ -2998,8 +2999,8 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *f=
s_info, struct seq_file *s)
>
>         mutex_lock(&fs_info->reclaim_bgs_lock);
>         spin_lock(&fs_info->unused_bgs_lock);
> -       seq_printf(s, "\t  reclaimable: %zu\n",
> -                            list_count_nodes(&fs_info->reclaim_bgs));
> +       reclaimable =3D list_count_nodes(&fs_info->reclaim_bgs);
> +       seq_printf(s, "\t  reclaimable: %zu\n", reclaimable);
>         seq_printf(s, "\t  unused: %zu\n", list_count_nodes(&fs_info->unu=
sed_bgs));
>         spin_unlock(&fs_info->unused_bgs_lock);
>         mutex_unlock(&fs_info->reclaim_bgs_lock);
> @@ -3023,4 +3024,18 @@ void btrfs_show_zoned_stats(struct btrfs_fs_info *=
fs_info, struct seq_file *s)
>                            bg->zone_unusable, btrfs_space_info_type_str(b=
g->space_info));
>         }
>         spin_unlock(&fs_info->zone_active_bgs_lock);
> +
> +       if (reclaimable) {
> +               seq_puts(s, "\treclaimable zones:\n");
> +               mutex_lock(&fs_info->reclaim_bgs_lock);
> +               spin_lock(&fs_info->unused_bgs_lock);
> +               list_for_each_entry(bg, &fs_info->reclaim_bgs, list) {
> +                       seq_printf(s,
> +                                       "\t    start: %llu, wp: %llu used=
: %llu, reserved: %llu, unusable: %llu (%s)\n",
> +                                       bg->start, bg->alloc_offset, bg->=
used, bg->reserved,
> +                                       bg->zone_unusable, btrfs_space_in=
fo_type_str(bg->space_info));

Accessing a lot of block group fields without taking the block group's
lock, so there's the possibility of load/store tearing.

And also races that makes us print values that will seem out of sync -
for example on extent allocation the block group's used counter is
incremented while the reserved counter is decremented by the same
amount (see btrfs_update_block_group()) in the same critical section
delimited by the block group's spinlock, and similar for extent
deallocation, etc.

If these races are acceptable, then at least add data_race()
annotations to silence KCSAN and other tools.

Thanks.

> +               }
> +               spin_unlock(&fs_info->unused_bgs_lock);
> +               mutex_unlock(&fs_info->reclaim_bgs_lock);
> +       }
>  }
> --
> 2.52.0
>
>

