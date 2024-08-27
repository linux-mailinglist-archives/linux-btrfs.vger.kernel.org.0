Return-Path: <linux-btrfs+bounces-7551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E749607B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2E1C22497
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 10:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8196619E7E5;
	Tue, 27 Aug 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCQW4DRy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09FE2FB2
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755453; cv=none; b=MbFptmBi/vDdIyuD8jVF93noViVWrmR21ZW8G6aBpqlXJGrJaYzuS0OFiYrJPd5Jo1xoDACCCmhlPWXf0KbDcg/7CCmovagz0k6aNLgP4mRqZBRSUCFOkQegnuhZ97Y8Cdh4RBoHS1ZrbqaJ6BQIhRqCN5hw0N8fhplUn8BXlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755453; c=relaxed/simple;
	bh=j/5pBuvfy6iB19xeBXoCwhBjInxAcX12+DAz6uabASI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e2e+z8P/IKytF5vXI7gwpje8vJBHEmdIEw3QMoYcPuq9QSIXLmyBuGx9Dsm/09cnnGaSwrO9fvu9o+BaV/tdfjC90qQpmhqduTTEO6/x8AJcCNliANUPL6SWdRL6JIn5KVpl3IHdO84su4QIXV8mZh2/8w+iDAETuPJYeCF0jPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCQW4DRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF39C4FEEA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724755453;
	bh=j/5pBuvfy6iB19xeBXoCwhBjInxAcX12+DAz6uabASI=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=WCQW4DRyki35gRP+vAIk+BoZFy1xVVtl7A+Hc0Y0iMVGZt5Ba+FwB8K+eIa6LWBmG
	 63n7N20YEPs6SIXbqVPRMxBgjMdBPtTLxkBPVJhsnleaNJ+Y13iDr2SzYeW7i64BMU
	 WxpP29OVC6dMeTogpN8cZxBQyRA+t3Ax+4QGVenFDFACS2pNsizNzBCNVlshqzvpcj
	 ome9bCI+ZjMjv+n5dsnoBcQNoLLaHwWZSQUF6RvVRYFOZikEWLji6pNl3pXjeL7s3L
	 kVXY2AJstu/gMqN2PJgNfJarzPNliBPooZjE+aLI2s5RUGpEeeeyd+eE+jzMnjW0ph
	 +AP1F9vTfHzWQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so65164966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 03:44:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YwI5v9Tcqji74elOR4DKwHV88MexR1U9uFBCddYOJbHu9Ln27px
	cqOLBO1/mOulKIL76xmp0i0kRlTynjz0lDJ9GjFQTifNs18GRnt0yW6QoHmUHywjlo+RGJxPOJE
	wKNaIsovEF3jS3BdRFDexxzktpSU=
X-Google-Smtp-Source: AGHT+IHZof7PaptRZbql3mdC4DvFNj3eGTP/2011rXd9p0ZU+KiO8ohhMpXtITw6W3ffv0us2q0Th8oChNhj3BR8x4o=
X-Received: by 2002:a17:907:c7e6:b0:a86:82da:2c3c with SMTP id
 a640c23a62f3a-a86a52c1b34mr862235566b.40.1724755451805; Tue, 27 Aug 2024
 03:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e6fea9cb64a7c98b4f83e2fd75de31a1475fce28.1724755223.git.fdmanana@suse.com>
In-Reply-To: <e6fea9cb64a7c98b4f83e2fd75de31a1475fce28.1724755223.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 Aug 2024 11:43:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6-89=UVNnq2eB73Vh=8g4s6G+yJYwmVBDEWKGso_f9rQ@mail.gmail.com>
Message-ID: <CAL3q7H6-89=UVNnq2eB73Vh=8g4s6G+yJYwmVBDEWKGso_f9rQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized return value from btrfs_reclaim_sweep()
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:41=E2=80=AFAM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> The return variable 'ret' at btrfs_reclaim_sweep() is never assigned if
> none of the space infos is reclaimable (for example if periodic reclaim
> is disabled, which is the default), so we return an undefined value.
>
> This can be fixed my making btrfs_reclaim_sweep() not return any value
> as well as do_reclaim_sweep() because:
>
> 1) do_reclaim_sweep() always returns 0, so we can make it return void;
>
> 2) The only caller of btrfs_reclaim_sweep() (btrfs_reclaim_bgs()) doesn't
>    care about its return value, and in its context there's nothing to do
>    about any errors anyway.
>
> Therefore return the return value from btrfs_reclaim_sweep() and

The first "return" should be "remove", I'll amend that when committing
the patch to for-next.

> do_reclaim_sweep().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/space-info.c | 17 +++++------------
>  fs/btrfs/space-info.h |  2 +-
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 68e14fd48638..c691784b4660 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1985,8 +1985,8 @@ static bool is_reclaim_urgent(struct btrfs_space_in=
fo *space_info)
>         return unalloc < data_chunk_size;
>  }
>
> -static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
> -                           struct btrfs_space_info *space_info, int raid=
)
> +static void do_reclaim_sweep(struct btrfs_fs_info *fs_info,
> +                            struct btrfs_space_info *space_info, int rai=
d)
>  {
>         struct btrfs_block_group *bg;
>         int thresh_pct;
> @@ -2031,7 +2031,6 @@ static int do_reclaim_sweep(struct btrfs_fs_info *f=
s_info,
>         }
>
>         up_read(&space_info->groups_sem);
> -       return 0;
>  }
>
>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_=
info, s64 bytes)
> @@ -2074,21 +2073,15 @@ bool btrfs_should_periodic_reclaim(struct btrfs_s=
pace_info *space_info)
>         return ret;
>  }
>
> -int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
> +void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
>  {
> -       int ret;
>         int raid;
>         struct btrfs_space_info *space_info;
>
>         list_for_each_entry(space_info, &fs_info->space_info, list) {
>                 if (!btrfs_should_periodic_reclaim(space_info))
>                         continue;
> -               for (raid =3D 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> -                       ret =3D do_reclaim_sweep(fs_info, space_info, rai=
d);
> -                       if (ret)
> -                               return ret;
> -               }
> +               for (raid =3D 0; raid < BTRFS_NR_RAID_TYPES; raid++)
> +                       do_reclaim_sweep(fs_info, space_info, raid);
>         }
> -
> -       return ret;
>  }
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 88b44221ce97..5602026c5e14 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -294,6 +294,6 @@ void btrfs_space_info_update_reclaimable(struct btrfs=
_space_info *space_info, s6
>  void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_inf=
o, bool ready);
>  bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
>  int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
> -int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
> +void btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
>
>  #endif /* BTRFS_SPACE_INFO_H */
> --
> 2.43.0
>
>

