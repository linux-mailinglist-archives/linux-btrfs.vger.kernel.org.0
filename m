Return-Path: <linux-btrfs+bounces-17883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC8BE2C09
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A63A4076
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC39326D4C;
	Thu, 16 Oct 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqlunuGB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D7323403
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609014; cv=none; b=Opx2yFuTlpmClVKhFewP9H1Y2i3JDSzPg4GkrtBEnEJwdqQ0M/rzEEqfN4+r7Lm+j95EmdJkr8rEI0ppl4P/YLtvtiY8/ZEetjrpER1qt6QEYXQxj3uOq5U+va1mtXcHkpcgb/tIcwsp4tszM/BTusXn4afVFrC/oUkgLLjfTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609014; c=relaxed/simple;
	bh=sC8DjIRaqWh/3MbCTwXskJZsDrzuT7T+7tsaMs8OBTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2sBloexiMdo2ISDBKROqiALVL786BcAeMnxNtZShTLamHV3yYsMxOmJOLxinBR+Ko7mEmiqK59+jKv90Suuze9hUbhsl145389w6H26q3tCoFHln9/oTlOMKh/YedmElmWEE6AikWd25fqIMx3l0W6au0jkIS5cct5qePAKKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqlunuGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DF2C4CEF9
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760609014;
	bh=sC8DjIRaqWh/3MbCTwXskJZsDrzuT7T+7tsaMs8OBTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZqlunuGBMfPfRZmixlLeNTuO866T6zjph1tKBIf2agjBtRFSvMyyL5inKS+iw0F/n
	 vEpSJqAaG3O3/Hm4dr7/ZHbwNUo43wHa13mrNDlfWjvE15yPvmbauET3O0iEuCS7YF
	 94eAz4a1uLKmGX/Sqb2BEp63th5SNbZtvf8qjtWYKOFO7EszbKbsbwEvTx70eaJ+CW
	 T2sq2W7OfHwdYQlswOROI8DdUhHrF+7xjqlRCm0kGx79VK4C0ge2XFIcOnEVQWw7Gz
	 ShaeXw+Kij6KxBGLSRjzEHPiaJ4WgePC0ZXeAXUGxGOqnyGJ+mk8NhdrQv19kQVq3J
	 6X8Bs56fzs2KA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b50206773adso332265366b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 03:03:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLlS9le6X8Oqdrnhmf0/kNk+9nkvaDKAkeebP3+dZu/YRenwo9
	+xVdXzjuwaddt7FrF2mzyEJA46tOd5TdbB+JEr/sLpw/xcIeKHlxt84OqeV+AOK1EStylIjtx2F
	kpAwX7B11cpV4VChNIeImOIF+Dnjc+jM=
X-Google-Smtp-Source: AGHT+IGdvCE7YFwVRAEmwWsL3B9NL1GWIofHQp4XrJ1ctam3MCRh+pPjaL/yzJ5IlTAJ1BaLJtAaadwGR7Omk4t7DaE=
X-Received: by 2002:a17:907:7e95:b0:b40:1a0b:f0fe with SMTP id
 a640c23a62f3a-b6053913e0emr371313666b.22.1760609013045; Thu, 16 Oct 2025
 03:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760607566.git.wqu@suse.com> <0cce8f800341d8bb55ed128b0b45afb345964816.1760607566.git.wqu@suse.com>
In-Reply-To: <0cce8f800341d8bb55ed128b0b45afb345964816.1760607566.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 Oct 2025 11:02:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4xdCfVJszmKXgQZJeZRuT_Vxrom+uraSEZLEoG6mh4Ow@mail.gmail.com>
X-Gm-Features: AS18NWBXq-XZKV38Eqjs_tGKTYNbDQwf-ObWs0lNmN_1xEuzK9neaZ8SZ9pgWbQ
Message-ID: <CAL3q7H4xdCfVJszmKXgQZJeZRuT_Vxrom+uraSEZLEoG6mh4Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: scrub: cancel the run if the process or fs
 is being frozen
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:43=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> It's a known bug that btrfs scrub/dev-replace can prevent the system
> from suspending.
>
> There are at least two factors involved:
>
> - Holding super_block::s_writers for the whole scrub/dev-replace
>   duration
>   We hold that percpu rw semaphore through mnt_want_write_file() for the
>   whole scrub/dev-replace duration.
>
>   That will prevent the fs being frozen, which can be initiated by
>   either the user (e.g. fsfreeze) or power management suspension/hiberati=
on.
>
> - Stuck in the kernel space for a long time
>   During suspension all user processes (and some kernel threads) will
>   be frozen.
>   But if a user space progress has fallen into kernel (scrub ioctl) and
>   do not return for a long time, it will make process freezing time out.
>
>   Unfortunately scrub/dev-replace is a long running ioctl, and it will
>   prevent the btrfs process from returning to the user space, thus make p=
m
>   suspension/hiberation time out.
>
> Address them in one go:
>
> - Introduce a new helper should_cancel_scrub()
>   Which includes the existing cancel request and new fs/process freezing
>   checks.
>
>   Here we have to check both fs and process freezing for pm
>   suspension/hiberation.
>
>   Pm can be configured to freeze fses before processes.
>   (The current default is not to freeze fses, but planned to freeze the
>   fses as the new default)
>
>   Checking only fs freezing will fail pm without fs freezing, as the
>   process freezing will time out.
>
>   Checking only process freezing will fail pm with fs freezing since the
>   fs freezing happens before process freezing.
>
> - Cancel the run if should_cancel_scrub() is true
>   Unfortunately canceling is the only feasible solution here, pausing is
>   not possible as we will still stay in the kernel space thus will still
>   prevent the process from being frozen.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c3e7e543d350..214285b216ec 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2069,6 +2069,38 @@ static int queue_scrub_stripe(struct scrub_ctx *sc=
tx, struct btrfs_block_group *
>         return 0;
>  }
>
> +static bool should_cancel_scrub(struct scrub_ctx *sctx)

I think it can be made const.

Anyway, it looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Also, don't forget the Reported-by tag and Link when pushing this.

Thanks.

> +{
> +       struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> +
> +       if (atomic_read(&fs_info->scrub_cancel_req) ||
> +           atomic_read(&sctx->cancel_req))
> +               return true;
> +
> +       /*
> +        * The user (e.g. fsfreeze command) or power management (pm)
> +        * suspension/hibernation can freeze the fs.
> +        * And pm suspension/hibernation will also freeze all user proces=
ses.
> +        *
> +        * A process can only be frozen when it is in the user space, thu=
s we
> +        * have to cancel the run so that the process can return to the u=
ser
> +        * space.
> +        *
> +        * Furthermore we have to check both fs and process freezing, as =
pm can
> +        * be configured to freeze the fses before processes.
> +        *
> +        * If we only check fs freezing, then suspension without fs freez=
ing
> +        * will timeout, as the process is still in the kernel space.
> +        *
> +        * If we only check process freezing, then suspension with fs fre=
ezing
> +        * will timeout, as the running scrub will prevent the fs from be=
ing frozen.
> +        */
> +       if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
> +           freezing(current))
> +               return true;
> +       return false;
> +}
> +
>  static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>                                       struct btrfs_device *scrub_dev,
>                                       struct btrfs_block_group *bg,
> @@ -2091,8 +2123,7 @@ static int scrub_raid56_parity_stripe(struct scrub_=
ctx *sctx,
>
>         ASSERT(sctx->raid56_data_stripes);
>
> -       if (atomic_read(&fs_info->scrub_cancel_req) ||
> -           atomic_read(&sctx->cancel_req))
> +       if (should_cancel_scrub(sctx))
>                 return -ECANCELED;
>
>         if (atomic_read(&fs_info->scrub_pause_req))
> @@ -2275,8 +2306,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sc=
tx,
>                 u64 found_logical =3D U64_MAX;
>                 u64 cur_physical =3D physical + cur_logical - logical_sta=
rt;
>
> -               if (atomic_read(&fs_info->scrub_cancel_req) ||
> -                   atomic_read(&sctx->cancel_req)) {
> +               if (should_cancel_scrub(sctx)) {
>                         ret =3D -ECANCELED;
>                         break;
>                 }
> --
> 2.51.0
>
>

