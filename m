Return-Path: <linux-btrfs+bounces-3468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D098A88120F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D366282256
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5ED40877;
	Wed, 20 Mar 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUTJw78g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF061DFD9
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940215; cv=none; b=LXYX0AMeqEifCQW1zJ0GD9/GQAhOzP/OZMYLqjlmN4zbYUi8mj/jjKDHW+662qmQAxUUNWi9IrV8vNZU5Jn6ZZqU9VMXJgmwIribAmt91QeB5n7d5P9hq1sfmZ2Iawaf/dXCgvLzUSPOSrWt8yFdvhdkEDJ4d7rhr9Pc7vslLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940215; c=relaxed/simple;
	bh=fIH2A4EUrqRB7XZI0dR2EkQgb5KT08JRoxaV3mBjvFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDAcmGSTfFtX+d8aTC43GeiH9Vln/WjlObXsUM/ZVjrBIElu1sQoo3P/3+x3nq0pKRVQu/awKtRl9PKDhfhHBsRFLCREKeipJ+coq60nr1db46mkgIjAhh2Ploldjf3nVy3hf952jhi4h0nxfMioBNtP2ofvubmtrhH9LtPteck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUTJw78g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6957C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710940214;
	bh=fIH2A4EUrqRB7XZI0dR2EkQgb5KT08JRoxaV3mBjvFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DUTJw78gLglkCj5wq+6T3eYsa36gg85FOxdIyxFb32dOlok9bzv8yerG4CQWfpagF
	 Tr8L7juH6IU0TPOL6oXLmI/IfiY2/ftNODuEaZJxCrgUtKSKcKo6zVWAfY+BI7dhlu
	 5I2pwYpbNMBsKcqLDgE2yZeCR9/6eonRc+GYERMA0mpTdZeDQy9hGR2p9V7OJXx+ln
	 8Q3gCkToX1re2JR7dM8UceQKzFCgX/qg3qvF1+i+gOIUo/vBr72D6BF0V9zwaVnsIx
	 YYPRy07nNlNR1to+UV0f17VcR3IxbrvEL5VelGLs4pSESpX0foraqy3HXDSSpDy/Hz
	 TsTq2/INOTvIg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso365766366b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 06:10:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzvmdBEv7IXzaNCKuc7fzsGOhwqyBfI2Vy9SXqC7KXp+Ozt8QoI
	3bCX016vS8p/KqcQPwvRBDlKj58hqxJqi0nwCfpuIwXLChA/KIwQqIjvFJdakWxIdOqnoNeuLqs
	DeUpC1pmtco5tpPJ5DNUK32jki+0=
X-Google-Smtp-Source: AGHT+IGdxxVPMXZcDMi8lVoFWx6qmxPxNZtseXitNBcS1ChedYDUiaUtm2+HtECvA6f5jOIkNumJOttN8xT5EDOvMkw=
X-Received: by 2002:a17:906:ae9b:b0:a44:d084:926b with SMTP id
 md27-20020a170906ae9b00b00a44d084926bmr1128228ejb.77.1710940213256; Wed, 20
 Mar 2024 06:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710906371.git.wqu@suse.com> <55061b90dd4fe3193ca9992ada5c6c79e8e9c32f.1710906371.git.wqu@suse.com>
In-Reply-To: <55061b90dd4fe3193ca9992ada5c6c79e8e9c32f.1710906371.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 13:09:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6bBgrRx22hHboV8ariGAivVr-Up6ygZBNU-iXOzGzxWA@mail.gmail.com>
Message-ID: <CAL3q7H6bBgrRx22hHboV8ariGAivVr-Up6ygZBNU-iXOzGzxWA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] btrfs: scrub: remove unnecessary dev/physical
 lookup for scrub_stripe_report_errors()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The @stripe passed into scrub_stripe_report_errors() either has
> stripe->dev and stripe->physical properly populated (regular data
> stripes) or stripe->flags would have SCRUB_STRIPE_FLAG_NO_REPORT
> (RAID56 P/Q stripes).
>
> Thus there is no need to go with btrfs_map_block() to get the
> dev/physical.
>
> Just add an extra ASSERT() to make sure we get stripe->dev populated
> correctly.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/scrub.c | 54 +++++++-----------------------------------------
>  1 file changed, 7 insertions(+), 47 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index a5a9fef2bdb2..ff952dd2b510 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -863,7 +863,7 @@ static void scrub_stripe_report_errors(struct scrub_c=
tx *sctx,
>         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> -       struct btrfs_device *dev =3D NULL;
> +       struct btrfs_device *dev =3D stripe->dev;
>         u64 stripe_physical =3D stripe->physical;
>         int nr_data_sectors =3D 0;
>         int nr_meta_sectors =3D 0;
> @@ -874,35 +874,7 @@ static void scrub_stripe_report_errors(struct scrub_=
ctx *sctx,
>         if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
>                 return;
>
> -       /*
> -        * Init needed infos for error reporting.
> -        *
> -        * Although our scrub_stripe infrastructure is mostly based on bt=
rfs_submit_bio()
> -        * thus no need for dev/physical, error reporting still needs dev=
 and physical.
> -        */
> -       if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)=
) {
> -               u64 mapped_len =3D fs_info->sectorsize;
> -               struct btrfs_io_context *bioc =3D NULL;
> -               int stripe_index =3D stripe->mirror_num - 1;
> -               int ret;
> -
> -               /* For scrub, our mirror_num should always start at 1. */
> -               ASSERT(stripe->mirror_num >=3D 1);
> -               ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRO=
RS,
> -                                     stripe->logical, &mapped_len, &bioc=
,
> -                                     NULL, NULL);
> -               /*
> -                * If we failed, dev will be NULL, and later detailed rep=
orts
> -                * will just be skipped.
> -                */
> -               if (ret < 0)
> -                       goto skip;
> -               stripe_physical =3D bioc->stripes[stripe_index].physical;
> -               dev =3D bioc->stripes[stripe_index].dev;
> -               btrfs_put_bioc(bioc);
> -       }
> -
> -skip:
> +       ASSERT(dev);
>         for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe=
->nr_sectors) {
>                 const u64 logical =3D stripe->logical +
>                                     (sector_nr << fs_info->sectorsize_bit=
s);
> @@ -933,41 +905,29 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                  * output the message of repaired message.
>                  */
>                 if (repaired) {
> -                       if (dev) {
> -                               btrfs_err_rl_in_rcu(fs_info,
> +                       btrfs_err_rl_in_rcu(fs_info,
>                         "fixed up error at logical %llu on dev %s physica=
l %llu",
>                                             logical, btrfs_dev_name(dev),
>                                             physical);
> -                       } else {
> -                               btrfs_err_rl_in_rcu(fs_info,
> -                       "fixed up error at logical %llu on mirror %u",
> -                                           logical, stripe->mirror_num);
> -                       }
>                         continue;
>                 }
>
>                 /* The remaining are all for unrepaired. */
> -               if (dev) {
> -                       btrfs_err_rl_in_rcu(fs_info,
> +               btrfs_err_rl_in_rcu(fs_info,
>         "unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
>                                             logical, btrfs_dev_name(dev),
>                                             physical);
> -               } else {
> -                       btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu on mirror %u",
> -                                           logical, stripe->mirror_num);
> -               }
>
>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
> -                       if (__ratelimit(&rs) && dev)
> +                       if (__ratelimit(&rs))
>                                 scrub_print_common_warning("i/o error", d=
ev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
> -                       if (__ratelimit(&rs) && dev)
> +                       if (__ratelimit(&rs))
>                                 scrub_print_common_warning("checksum erro=
r", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
> -                       if (__ratelimit(&rs) && dev)
> +                       if (__ratelimit(&rs))
>                                 scrub_print_common_warning("header error"=
, dev,
>                                                      logical, physical);
>         }
> --
> 2.44.0
>
>

