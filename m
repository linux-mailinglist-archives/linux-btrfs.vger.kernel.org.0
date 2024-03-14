Return-Path: <linux-btrfs+bounces-3300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75987C21B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48D8283439
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA1745F0;
	Thu, 14 Mar 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bk4mLDt2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85773188
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437210; cv=none; b=YFgqMXEUYKWA/Yf9nf56lz4Zf7ODR3Z3Yp/Hc1HxISPSl+9OkpAe6xB6f4a7r6P4a8G9DcYzWvOK9/DnC3IEmPl2AucBF8EKkmoa3nYGfKoB+5MrpJ0WBebpsvQGrKXpceLpiRutXKH4hoXhA+gw9fJcbt5RBuIKZpLfFYIzpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437210; c=relaxed/simple;
	bh=g7c3TudkT3gPtk64x/JjpoJYCyntGF2N2uLsGTD/HNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNvBC4uAzpyGf1+ITwL1yivkKC2zAymlAcY7hugm4sZOH+sbfEqL6LWCnrDdF47tJ3SVXv+QR6uWicdEsX250vY+mQjT6N6sO4oD3FLsblgi2fsEXrRL9HebCC3Y940gjCqR0d4bhE3eDabKQKuHJUPUVcj6802wH9Zu6mzzLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bk4mLDt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0EC433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710437209;
	bh=g7c3TudkT3gPtk64x/JjpoJYCyntGF2N2uLsGTD/HNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bk4mLDt2w0vg7Y5UTaEgVzaCrV76ha8Pe5VF0D7grG2hiZ/RPb+GYNa/dqfkRUAKH
	 Hyy2XI5Sb4FowvO7fPdYyXe437Xjfw5UPc9VHTsmfgBQFXaxCj7WHsipV88m+zLL24
	 h0EV4A1zBdhGlQcyQEEsM3zuvT/YfLEUwtR2sQkwX/UNnpqpokfp1s5Qe/E5LvooG2
	 GkP59glik/huoqWpw6GNUZjL0sCh8oq3yZVO85PoasdCYVR1gtf9Zoqm66YMb+kqnO
	 8QVajQOe75wzSu81rLZF34WMM1Sv2FZeTjYyqrXXdu4G9Nhm1dpd72VGX75d5t6bNm
	 JR6UOR9JPhIjA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45f257b81fso156524966b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:26:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YyWeTC7dK4KBcg4+SoQMymWP8HrXMl6FuXTsNavUup5c6PeRQAQ
	x9z4YlWZqW2ft/nnfm8vjtMnlPR9NFohHV7AlLIxg18wdZoff1yb4PZ8sFJo9x7dLcBHJQg+bpL
	1ZpU2xlmz2a/Vn1hNd7yyDj6TRe0=
X-Google-Smtp-Source: AGHT+IE4wantNPCEIs8j/pwEuxOiYKAm7Xxe2gnGPiZSGQ8YkKrKjuEUL5qqCDkEodub+8v1Xk10gbt0b6lC0zydRE0=
X-Received: by 2002:a17:906:3716:b0:a46:5b72:6d38 with SMTP id
 d22-20020a170906371600b00a465b726d38mr1559583ejc.63.1710437208447; Thu, 14
 Mar 2024 10:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
In-Reply-To: <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:26:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com>
Message-ID: <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: scrub: remove unnecessary dev/physical lookup
 for scrub_stripe_report_errors()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
>  fs/btrfs/scrub.c | 59 ++++++------------------------------------------
>  1 file changed, 7 insertions(+), 52 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 5e371ffdb37b..277583464371 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -860,10 +860,8 @@ static void scrub_stripe_submit_repair_read(struct s=
crub_stripe *stripe,
>  static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>                                        struct scrub_stripe *stripe)
>  {
> -       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> -                                     DEFAULT_RATELIMIT_BURST);
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> -       struct btrfs_device *dev =3D NULL;
> +       struct btrfs_device *dev =3D stripe->dev;
>         u64 stripe_physical =3D stripe->physical;
>         int nr_data_sectors =3D 0;
>         int nr_meta_sectors =3D 0;
> @@ -874,35 +872,7 @@ static void scrub_stripe_report_errors(struct scrub_=
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
>                 u64 logical =3D stripe->logical +
>                               (sector_nr << fs_info->sectorsize_bits);
> @@ -933,42 +903,27 @@ static void scrub_stripe_report_errors(struct scrub=
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
> -                               scrub_print_common_warning("i/o error", d=
ev,
> +                       scrub_print_common_warning("i/o error", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
> -                       if (__ratelimit(&rs) && dev)
> -                               scrub_print_common_warning("checksum erro=
r", dev,
> +                       scrub_print_common_warning("checksum error", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
> -                       if (__ratelimit(&rs) && dev)
> -                               scrub_print_common_warning("header error"=
, dev,
> +                       scrub_print_common_warning("header error", dev,

Why are we removing the rate limiting?
This seems like an unrelated change.

Everything else looks ok.

Thanks.

>                                                      logical, physical);
>         }
>
> --
> 2.44.0
>
>

