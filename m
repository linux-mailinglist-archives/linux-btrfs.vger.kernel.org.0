Return-Path: <linux-btrfs+bounces-3470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A6881263
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8975A286716
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02814481A6;
	Wed, 20 Mar 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE4KlaCY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8347F72
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941649; cv=none; b=o9I+A15lzlJymTgb6P7jATkrkiePyzm3fw4kXr8mBmRVEaSM5HK0nLY0EJZzm3+Hh8I+wH6PajK22Xa6MfZUnnxuOWGT30xqhkx7C5SzIVuh44KJjDoSo2Y8iPexNNWphy+6JJaLIQT4udfQ6CCLCGBWERXcnxe9CUVF9EEOPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941649; c=relaxed/simple;
	bh=yXO6B6oO7FIU47tSdk/oRQ26sQHKYH5b6niAkwavfNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGG618D8BcW82B/4vzQ9LK2wazxFdNpaC+zhwWfC03IlfR7wGwDfvryJXLSe/KkBIe3/G07FDxXrnjeZIpkA9P5hd6vcOcK4VRaYn070oMk9sbXkOqdU5MpLPzLDixvPmZobgF8ufgPlFvJCesCVpzdooWSHWTHgRc1VPCTAQlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE4KlaCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F141FC43390
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710941649;
	bh=yXO6B6oO7FIU47tSdk/oRQ26sQHKYH5b6niAkwavfNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BE4KlaCYNUVltL+uApKtM5eR4mubwdn67clfTsLFpGTZw/gbgmQRcrjqe/RXsWjRO
	 eEGLMzMHGpKYXiS0fLNi4W+OgdKw4rum1mCp1MdA0UoUXM45grYe9t3k1lEWjssIzj
	 cJxsmzWve3Lw99GWVRw24Tlvt2LTh5ZDSyyZPOEj92S4bJTz64jCMDUixns0zL+GGc
	 GCgYLFKvaOuiiw7NlDEVgN9RqPtAY5wwqhPRm+GS0td0F/D6QTzk3pZaTgfqGt/Jqj
	 ATmxpJxX3K80/8Gf8GvPFo/fIi17NivrPLCjCNpdByy5spBB0PtTzfNAQedyyK5fqp
	 YHsFLQJ5Ox01w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44f2d894b7so808281766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 06:34:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYuC3IKdzHIUwC4DMYMXkgaLezEaQBW6n2QnReFf4wNH7V2duT
	/yZWuVzTMFNPSJ+fOIiwmfA8FdDp+/nhLhyZwVU481/zTSRYl3hj7G5dJs0iUs3T+UzmQiryPzE
	Ewn1WHeOad35zBUSmZFFp9tqTQJ8=
X-Google-Smtp-Source: AGHT+IEB2zCEVKK4XhCQn6JfRJUIj3pb6ZMhWhgdSaZOcICdfked1M9/NKSZV8pSZPX8Pi6vQFEI+fTUeICN6hM8ELU=
X-Received: by 2002:a17:906:6545:b0:a45:2e21:c78c with SMTP id
 u5-20020a170906654500b00a452e21c78cmr12637830ejn.13.1710941647414; Wed, 20
 Mar 2024 06:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710906371.git.wqu@suse.com> <15b30ab7f305a81238ec74f84a84564137f45d0a.1710906371.git.wqu@suse.com>
In-Reply-To: <15b30ab7f305a81238ec74f84a84564137f45d0a.1710906371.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 13:33:30 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53g_MqJY3YEcRinWoUFxXOpZsmoT5kRwFGrC-ksiFHSg@mail.gmail.com>
Message-ID: <CAL3q7H53g_MqJY3YEcRinWoUFxXOpZsmoT5kRwFGrC-ksiFHSg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: scrub: use generic ratelimit helpers to
 output error messages
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently scrub goes different ways to rate limits its error messages:
>
> - regular btrfs_err_rl_in_rcu() helper for repaired sectors and
>   the initial message for unrepaired sectors
>
> - Manually rate limits scrub_print_common_warning()
>
> I'd say the different rate limits could lead to cases where we only got
> the "unable to fixup (regular) error" messages but the detailed report
> about that corruption is ratelimited.
>
> To make the whole rate limit works more consistently, change the rate
> limit by:
>
> - Always using btrfs_*_rl() helpers
>
> - Remove the initial "unable to fixup (regular) error" message
>   Since we're ensured to have at least one error message for each
>   unrepaired sector (before rate limit), there is no need for
>   a duplicated line.
>
>   And if we hit rate limits, we will rate limit all the error messages
>   together, not treating different error messages differently.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/scrub.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 0d2b042d75c2..f942c9e3f121 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -427,7 +427,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>          * hold all of the paths here
>          */
>         for (i =3D 0; i < ipath->fspath->elem_cnt; ++i) {
> -               btrfs_warn_in_rcu(fs_info,
> +               btrfs_warn_rl_in_rcu(fs_info,
>  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, off=
set %llu, path: %s",
>                                   swarn->errstr, swarn->logical,
>                                   btrfs_dev_name(swarn->dev),
> @@ -442,7 +442,7 @@ static int scrub_print_warning_inode(u64 inum, u64 of=
fset, u64 num_bytes,
>         return 0;
>
>  err:
> -       btrfs_warn_in_rcu(fs_info,
> +       btrfs_warn_rl_in_rcu(fs_info,
>                           "%s at logical %llu on dev %s, physical %llu, r=
oot %llu, inode %llu, offset %llu: path resolving failed with ret=3D%d",
>                           swarn->errstr, swarn->logical,
>                           btrfs_dev_name(swarn->dev),
> @@ -500,7 +500,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>                                 break;
>                         if (ret > 0)
>                                 break;
> -                       btrfs_warn_in_rcu(fs_info,
> +                       btrfs_warn_rl_in_rcu(fs_info,
>  "%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in =
tree %llu",
>                                 errstr, swarn.logical, btrfs_dev_name(dev=
),
>                                 swarn.physical, (ref_level ? "node" : "le=
af"),
> @@ -508,7 +508,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>                         swarn.message_printed =3D true;
>                 }
>                 if (!swarn.message_printed)
> -                       btrfs_warn_in_rcu(fs_info,
> +                       btrfs_warn_rl_in_rcu(fs_info,
>                         "%s at metadata, logical %llu on dev %s physical =
%llu",
>                                           errstr, swarn.logical,
>                                           btrfs_dev_name(dev), swarn.phys=
ical);
> @@ -527,7 +527,7 @@ static void scrub_print_common_warning(const char *er=
rstr, struct btrfs_device *
>
>                 iterate_extent_inodes(&ctx, true, scrub_print_warning_ino=
de, &swarn);
>                 if (!swarn.message_printed)
> -                       btrfs_warn_in_rcu(fs_info,
> +                       btrfs_warn_rl_in_rcu(fs_info,
>         "%s at data, filename unresolved, logical %llu on dev %s physical=
 %llu",
>                                           errstr, swarn.logical,
>                                           btrfs_dev_name(dev), swarn.phys=
ical);
> @@ -846,8 +846,6 @@ static void scrub_stripe_submit_repair_read(struct sc=
rub_stripe *stripe,
>  static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>                                        struct scrub_stripe *stripe)
>  {
> -       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> -                                     DEFAULT_RATELIMIT_BURST);
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>         struct btrfs_device *dev =3D stripe->dev;
>         u64 stripe_physical =3D stripe->physical;
> @@ -899,22 +897,14 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                 }
>
>                 /* The remaining are all for unrepaired. */
> -               btrfs_err_rl_in_rcu(fs_info,
> -       "unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
> -                                           logical, btrfs_dev_name(dev),
> -                                           physical);
> -
>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
> -                       if (__ratelimit(&rs))
> -                               scrub_print_common_warning("i/o error", d=
ev,
> +                       scrub_print_common_warning("i/o error", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
> -                       if (__ratelimit(&rs))
> -                               scrub_print_common_warning("checksum erro=
r", dev,
> +                       scrub_print_common_warning("checksum error", dev,
>                                                      logical, physical);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
> -                       if (__ratelimit(&rs))
> -                               scrub_print_common_warning("header error"=
, dev,
> +                       scrub_print_common_warning("header error", dev,
>                                                      logical, physical);
>         }
>
> --
> 2.44.0
>
>

