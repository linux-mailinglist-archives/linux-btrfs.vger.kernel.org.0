Return-Path: <linux-btrfs+bounces-17874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5096BE20B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6E0188468C
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2192FCBF5;
	Thu, 16 Oct 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2Rn3o6u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DA2BAF9
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601366; cv=none; b=nH7u++MF+Wp0iKlfQ7QPae1J2EKcGOr8P9yAzN7dN8LkGZWqZJjnmXN4/WIOBEJvMNbOBm2Mj5Kr+yvVbrjxUnFCvYxo8RPEHgYCODp9CEdlefGeaPMpAYE1JtovdA0pAB1qF3O/DPJZxxqfud7sWo9+gxUriTKEFMHzFGNDpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601366; c=relaxed/simple;
	bh=ntTEdITUavi9u7ZdaT6JDmY6BU1rFeI7CB4bjwXDtiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj0lePWtKztk+6c2PeleHNmArrH1/7DsiAlyVkezVwOZ1BYo2AJwEs3Ps83rDDRsndpxbR2T20ZzOtMChNDsmbOKOwb12JY02Eoh/IeMp6a4OK+OzJppIC7urdOJ1Uhpf95/ZjXUiN/n4qX4ZPsiSyLtDdHWR//qUEpAQLskHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2Rn3o6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFDBC4CEF1
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601366;
	bh=ntTEdITUavi9u7ZdaT6JDmY6BU1rFeI7CB4bjwXDtiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I2Rn3o6uZmQ+jmeub9sO1jSIfuhU2oaE/5d1YEjp+ZlBUIIrkDdtv5bxVGL5DteDi
	 os21LR+vbQjBTfSLWh5hjS1RKZgAtzlZK+v6XwKdkcBVuuVAeqF9jEbS5/mg4Zb51r
	 RdBDw31I3EAADl+/Ol1LDl7KRTQTxRPl4KWsCsHW1J/okeKh7OaZYAKq7st45zu5q4
	 b97m9EPghhprlsxaV5kUPiEt0tVAB49TUhgcpFlwiS0XUpmA3iD9z2h4TSG07Lndhw
	 7+lq8AAUKY1vlmpGiJk37RyXBuIBApBGntFPnrHpqY2uyYy1Fu2hOUuTkPGEDAHvRw
	 E/ozMsBp6jzuw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso72519266b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 00:56:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHbPY4rN8M7HaiVuURcHxchfU5b+VNnG1to9OdcQ11ghr8q9SS
	fgtFFGolOqKfuVm6wBT4WRSuzwOaK7/jJyKbjKftZ7W9q4kYA6CmXgfFmr74Gf1Wv6yJaCfAmsP
	a0PPkNcwgm6WehHo4gO1/snNYuuIkj58=
X-Google-Smtp-Source: AGHT+IFUa5ZIUjM3x2x1PMPjsdgbPRo079PtymhTKQaE3IrWRbF3T1MI8oL+35vpz12cw6yGhSfWmbDHBFfSDZM6Bus=
X-Received: by 2002:a17:906:4795:b0:b41:1657:2b1d with SMTP id
 a640c23a62f3a-b50abfcc8dbmr3355647866b.50.1760601364586; Thu, 16 Oct 2025
 00:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760588662.git.wqu@suse.com> <f8acf0633c2486088f91bde313d8430ff42e3602.1760588662.git.wqu@suse.com>
In-Reply-To: <f8acf0633c2486088f91bde313d8430ff42e3602.1760588662.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 Oct 2025 08:55:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6cbeQmDNoPxNKnpXN1b+FnuZqvEbaRXtxF1yKh6=oNrw@mail.gmail.com>
X-Gm-Features: AS18NWDJt0gtTPYNWTdkak1oMGO-Se5Rl3ssAR_RfHPXcmRZZCk2CepA7dtWNZ4
Message-ID: <CAL3q7H6cbeQmDNoPxNKnpXN1b+FnuZqvEbaRXtxF1yKh6=oNrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: scrub: add cancel/pause/removed bg checks for
 raid56 parity stripes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> For raid56, data and parity stripes are handled differently.
>
> For data stripes they are handled just like regular RAID1/RAID10 stripes,
> going through the regular scrub_simple_mirror().
>
> But for parity stripes we have to read out all involved data stripes and
> do any needed verification and repair, then scrub the parity stripe.
>
> This process will take a much longer time than a regular stripe, but
> unlike scrub_simple_mirror(), we do not check if we should cancel/pause
> or the block group is already removed.
>
> Aligned the behavior of scrub_raid56_parity_stripe() to
> scrub_simple_mirror(), by adding:
>
> - Cancel check
> - Pause check
> - Removed block group check
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index fe266785804e..facbaf3cc231 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2091,6 +2091,24 @@ static int scrub_raid56_parity_stripe(struct scrub=
_ctx *sctx,
>
>         ASSERT(sctx->raid56_data_stripes);
>
> +       /* Canceled? */

This comment is useless, it's obvious from the checks belows we are
checking if we're canceled, as the atomics have "cancel" in their
name.

> +       if (atomic_read(&fs_info->scrub_cancel_req) ||
> +           atomic_read(&sctx->cancel_req))
> +               return -ECANCELED;
> +
> +       /* Paused? */

Same here, the atomic has "pause" in its name.

> +       if (atomic_read(&fs_info->scrub_pause_req))
> +               /* Push queued extents */

Please always end comments with punctuation.
Also add { }.

> +               scrub_blocked_if_needed(fs_info);
> +
> +       /* Block group removed? */

Same here, we 're testing for a flag with "removed" in its name in the
block group's flags.

With those changes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       spin_lock(&bg->lock);
> +       if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
> +               spin_unlock(&bg->lock);
> +               return 0;
> +       }
> +       spin_unlock(&bg->lock);
> +
>         /*
>          * For data stripe search, we cannot reuse the same extent/csum p=
aths,
>          * as the data stripe bytenr may be smaller than previous extent.=
  Thus
> --
> 2.51.0
>
>

