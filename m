Return-Path: <linux-btrfs+bounces-17872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BDBE20B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B84FAFC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C6C2FD7DA;
	Thu, 16 Oct 2025 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5q4g6g9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1723AB95
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601153; cv=none; b=uw8vUqzLrHPIYgEDbYUl6ISHNWdF3XxtUyv+oHstCFnUiRvB5uOO99/bF3XItH1I6jM6m0vys/RxiiR/7l49eUk2gVYxYNd4N1N8+PkNUIbdAdcmRBKgc2/rK4nT81Kbo2SsYLpVm5PzODA2GZQ/AnKjWyhY+2u0vBwYkYostu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601153; c=relaxed/simple;
	bh=xfJIokLxItT+EtNAs2hXhZrIRg6o7sQu8SXW2jKP0jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/LFZqZGp64cGR3jRfQ4C8voDBMizFEk6q0UeXtQPWi6g80T6O2xgWIwJCR7/qvWoUN3/4Np8rClz0ClnG6iqjoIv4+c0olDced3mKv0cHmGRi49obo47/BFZHxQTLsKfFvEgVMFFiEzA6IbnVv0ptuIhvEoJQLeI8bmI/KmQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5q4g6g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8123CC113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601151;
	bh=xfJIokLxItT+EtNAs2hXhZrIRg6o7sQu8SXW2jKP0jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q5q4g6g9c7iIkAQEdpV7sMDACsJL1UnR+UJNeow06Cd9pUoyajJZ/36GuStpoE23h
	 L8nb9KvazEh32e+9Ps4FuzVqjIv6RdteRKPIaf1gg8HrCxGOcA3KOOA4Vz7jRGk9Sr
	 q/6e6C/FYMpIPNcl+yN4pKuwYl7dAbgs7ZNhULhW6KRprkFmyydoYilrGpilDHaNSZ
	 /2nqqt5WHyB09tw8e4HdSv+k2duWJl9+ARdA5lU83FKc88mblmjGt80vs5EVweACZr
	 asSxcHt7MNGWRB+PhMxZOPJWaWlCIEGbZPRH7ppRMAQGj8N5QHt1WA+p+xNyYjz7/p
	 h/kNi+dEyzQPA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deaef9so77865266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 00:52:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwRlx0G9qzhTdm++JP5mlsO1/39DaMmUHGoIltxeLneaStvdlc1
	5LdIxuAiKZLjOYdOBHpMBgdUzONQP0IX7mRF7x9aPuSD6PdwhO2Z5MA+89qQMr3nWXGbNGEYbJa
	d49AoLS/spzIEIYx0xZFrzIK9sbxUdXw=
X-Google-Smtp-Source: AGHT+IFwFUwld57erDnW9zry4d0P9Eu5kymmpoOb+YK9nCvR79aH7jG9lKcHCtdUenxz/RP3FtYein3/XwBG1j85wB0=
X-Received: by 2002:a17:907:7ea8:b0:b4a:f6c3:7608 with SMTP id
 a640c23a62f3a-b50aa792794mr3611598966b.3.1760601149918; Thu, 16 Oct 2025
 00:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760588662.git.wqu@suse.com> <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
In-Reply-To: <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 16 Oct 2025 08:51:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7q9=Fk=2EjC44dB8HnnsUv7EBZPLt=kot7quWD8=Jvaw@mail.gmail.com>
X-Gm-Features: AS18NWCzzP5Dgd8DTj7TqwhUSHbcuk00aXky60msrXGBl_MeM_xNYyRVz6AKO2c
Message-ID: <CAL3q7H7q9=Fk=2EjC44dB8HnnsUv7EBZPLt=kot7quWD8=Jvaw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> It's a known bug that btrfs scrub/dev-replace can prevent the system
> from suspending.
>
> There are at least two factors involved:
>
> - Holding super_block::s_writers for the whole scrub/dev-replace
>   duration
>   We hold that mutex through mnt_want_write_file() for the whole

It's not a mutex, it's a percpu rw semaphore.

>   scrub/dev-replace duration.
>
>   That will prevent the fs being frozen.
>   It's tunable for the kernel to suspend all fses before suspending, if
>   that's the case, a running scrub will refuse to be frozen and prevent
>   suspension.
>
> - Stuck in kernel space for a long time
>   During suspension all user processes (and some kernel threads) will
>   be frozen.
>   But if a user space progress has fallen into kernel (scrub ioctl) and
>   do not return for a long time, it will make suspension time out.
>
>   Unfortunately scrub/dev-replace is a long running ioctl, and it will
>   prevent the btrfs process from returning to user space.
>
> Address them in one go:
>
> - Introduce a new helper should_cancel_scrub()
>   Which checks both fs and process freezing.
>
> - Cancel the run if should_cancel_scrub() is true
>   The check is done at scrub_simple_mirror() and
>   scrub_raid56_parity_stripe().
>
>   Unfortunately canceling is the only feasible solution here, pausing is
>   not possible as we will still stay in the kernel state thus will still
>   prevent the process from being frozen.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index facbaf3cc231..728d4e666054 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2069,6 +2069,20 @@ static int queue_scrub_stripe(struct scrub_ctx *sc=
tx, struct btrfs_block_group *
>         return 0;
>  }
>
> +static bool should_cancel_scrub(struct btrfs_fs_info *fs_info)
> +{
> +       /*
> +        * For fs and process freezing case, it can be preparation
> +        * for a incoming pm suspension.
> +        * In that case we have to return to the user space, thus
> +        * canceling is the only feasible solution.
> +        */
> +       if (fs_info->sb->s_writers.frozen > SB_UNFROZEN ||
> +           freezing(current))

Why the check for sb->s_writers.frozen > SB_UNFROZEN?
I don't see why freezing() is not enough and would prefer to not
access such low level details of the vfs directly.

> +               return true;
> +       return false;
> +}
> +
>  static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
>                                       struct btrfs_device *scrub_dev,
>                                       struct btrfs_block_group *bg,
> @@ -2093,7 +2107,8 @@ static int scrub_raid56_parity_stripe(struct scrub_=
ctx *sctx,
>
>         /* Canceled? */
>         if (atomic_read(&fs_info->scrub_cancel_req) ||
> -           atomic_read(&sctx->cancel_req))
> +           atomic_read(&sctx->cancel_req) ||
> +           should_cancel_scrub(fs_info))

If we now have a should_cancel_scrub(), the checks for the cancel
atomics should be moved there, otherwise it's confusing why some
cancel checks are in the helper and others are not.

>                 return -ECANCELED;
>
>         /* Paused? */
> @@ -2281,7 +2296,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sc=
tx,
>
>                 /* Canceled? */
>                 if (atomic_read(&fs_info->scrub_cancel_req) ||
> -                   atomic_read(&sctx->cancel_req)) {
> +                   atomic_read(&sctx->cancel_req) ||
> +                   should_cancel_scrub(fs_info)) {

And it would avoid duplicating the atomic checks by having them in the
new helper.

Thanks.
>                         ret =3D -ECANCELED;
>                         break;
>                 }
> --
> 2.51.0
>
>

