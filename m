Return-Path: <linux-btrfs+bounces-14171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3EABF2B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 13:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878707A823D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE3262D0C;
	Wed, 21 May 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV1BxaaU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9311F869E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826676; cv=none; b=Lpa2URkt62jZrwjTpDmOcM6ltBZdN5EXKTrU8VR+lVgxfk5n5M3vo3EF15WCnc8fdEKHcclukpU0Z8WsvXKj2MLHMKEfRkn7s60M50kbuaSmAWsSPwIoKHdNuIKX1QIX7OlYToouEc3LSQajbwXBALL1k1lnt3YpO9P7FUSxDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826676; c=relaxed/simple;
	bh=Cz6RH41aYtM/KcfqGAI1dlxTN6gvjPlt20SNZUdD/HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/T6drQJ0w0wwc5Ha3GbaCVYVgte+fPR29UsiDQjL5V/NcJ+L/+mq9T28OhWLPQKRGlwNWuLub3goVdfpwKpNryeKzJ89og6vvExGcFrqOiBmm0OZ5KcVsOtEGXPr7JQXXek2nQu4daadPAdd0bhO8QZIKzFmqjO8PvxqKy2tHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV1BxaaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDE9C4CEE4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747826676;
	bh=Cz6RH41aYtM/KcfqGAI1dlxTN6gvjPlt20SNZUdD/HE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lV1BxaaUmrQwUY0XHUWpaNlYT6zNIISaqZm8VMxCd0kJfXmpN51Ruq69wEOdMw1Ae
	 HiWLGu7S2YqWCp1K8YuTrWI2jeA++OUsH3Ysk8nYZV5gCfXGgAMqFMZ/kxF8t/iHBe
	 liK87mNRME8kf4l3x1bynCqOsAo05nHh9mJdsWFjb5iaAKP2U+gzQBwoYVadCvtdgg
	 DGkx6d3kJ0Kgg6AGaxg2IiHnkspFIjjKHDNO0lPP7ErQ66hFgVcjRcHjW202k0zCtS
	 fivlgH5+ORbdrstrywVfroisXiPOCFCtY0Ct6oTpuyH8I2gvHfyo4s0mk1wuZgfxG3
	 VXoXCQfBmze7g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so7782710a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 04:24:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyvxim53ZWfBSe35mjysUPYEBTP1tArbxj7l3li3LP1v40S7ire
	75QU2ojkw8u1bNJwq7iDumFk8CXo61EQUEFlf3irHSDTkErLqI9Uzr8qquwuVSEaxFZI2pRi5dH
	uwN8RdNwPPfUIci2C+cEgSsHIdqYtUPc=
X-Google-Smtp-Source: AGHT+IHsqye3OBk67wInfQlXzuDhwu5TG8YD/hYrSVcUtyVrQTi8mZKCEOBA+o/WQmJXye2N88USVaxLSh9T6Bfd2l4=
X-Received: by 2002:a17:907:7e87:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-ad52d42bf0cmr2006370866b.7.1747826674802; Wed, 21 May 2025
 04:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68089488d00605df41b859b5fdadbcf8f2fa6edf.1747822425.git.johannes.thumshirn@wdc.com>
In-Reply-To: <68089488d00605df41b859b5fdadbcf8f2fa6edf.1747822425.git.johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 21 May 2025 12:23:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4PA9rDpEqwrDGMVfTb8DdbBvTMZqXcHKdWkeSRn_Fing@mail.gmail.com>
X-Gm-Features: AX0GCFujcDMOAkaL8x6uu5nNSgSm8umNMVAT2e_8VpOn9lnFRde_n2c73pscrsg
Message-ID: <CAL3q7H4PA9rDpEqwrDGMVfTb8DdbBvTMZqXcHKdWkeSRn_Fing@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make btrfs_should_periodic_reclaim static
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:14=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> btrfs_should_periodic_reclaim() is not used outside of space-info.c so
> make it static and remove the prototype from space-info.h.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/space-info.c | 2 +-
>  fs/btrfs/space-info.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d9087aa81b21..23685d6e8cbc 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2139,7 +2139,7 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_=
space_info *space_info, bool
>         }
>  }
>
> -bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> +static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space=
_info)
>  {
>         bool ret;
>
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 92b7f5e2b850..7de31541ab45 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -306,7 +306,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct b=
trfs_space_info *sinfo);
>
>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_=
info, s64 bytes);
>  void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_inf=
o, bool ready);
> -bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
>  int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_in=
fo);
>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 le=
n);
> --
> 2.43.0
>
>

