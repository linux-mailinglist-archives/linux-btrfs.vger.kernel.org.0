Return-Path: <linux-btrfs+bounces-3297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9787C1E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7161F220E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EDF745CB;
	Thu, 14 Mar 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoyW81ja"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1487172C
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436286; cv=none; b=nDcULizSr00k60jnesZUc8CT+5s+j7sAGjt9qDrwOOg+195M5iuTwCDj8hzBGERc2ovv/6NkdblrUpEqf5zQglv9b/Lkkr6obMkkTVkSNNxvjUENrXh+8x2NzSQe7vPfmIkzlaB2zxEIJjZrER3Usuo5nHpQRQAflmtJVGmsQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436286; c=relaxed/simple;
	bh=Wl8oRXyjCuCOSOrW6xLOXOdzQT0r12vbUmEOMLgrCmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzhjDC34HkiggcPdtazlK4AMt3CGgzNMjdr6wlplTWiOtnH7yBQwmPRJXbDG/WbZp9fqLRwqHSFd6aCjt4zs+n1NxF0Qve2pHi/YGqs5FYz/7twr1fbsVh5VEq43ZeaBYHQ/u5KV79pCUclz+gQ4eU9od5kgnhCrD8e2SSUqiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoyW81ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F3AC433C7
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710436285;
	bh=Wl8oRXyjCuCOSOrW6xLOXOdzQT0r12vbUmEOMLgrCmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZoyW81ja2+ixt3ILUb5Fdsok9A9lzZNGAL0n2BLsUZslbyvfqWEYfV9cfTkosCWiF
	 fhdhLSpm8dwN0ny6b8h13zuGy9ObC6PSVid5RdDF/BGDkzTpnHgEVhiWpeTElpNzEC
	 MJtzY41bt2bHjiinIEpiOLg4c2XkzpZrdnW0m3jDNvrIrdIHF0ZGp0fxxK6bXXXVS0
	 +cBuP8D35sqjgEaKXnNOYwo5yp5HBfRzp+4vlMWMxYCSroEImrAEdfXnS39b83W+gG
	 2Lfeld0KyGOdBnQx8ekGM1VHX2+CG0frjuerDsM/OspYDs4ShQ4/oLKJLbPkjBfjx/
	 u3qcgxNVfVnSg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d485886545so764691fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 10:11:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YymajKlsySeAzlURw9dPKHnKnntXUdZugMlRtO1hsOyQcrI4Lpr
	xWYaahOTv3Pb0yA1zgXXihZkV1aU7PCnPgbS2huf1QDbefeyVqCjmQqpW6Z2u+1KVfzcCL/1uZJ
	CwCWBmNQUZcDcwSWlM4wx5qeXq2M=
X-Google-Smtp-Source: AGHT+IF1ML7M4TZLOnDV6dRzLLa1aWO2/YLavmR/d18eC7uOK0Uv+5WDzQEFOIkEIATnTClVvD2w7yduSzz5VydaKDA=
X-Received: by 2002:a2e:9849:0:b0:2d4:6c1c:46d with SMTP id
 e9-20020a2e9849000000b002d46c1c046dmr465548ljj.31.1710436283762; Thu, 14 Mar
 2024 10:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
In-Reply-To: <ad7fa3eaa14b93b96cd09dae3657eb825d96d696.1710409033.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Mar 2024 17:10:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4CT=Jbusvo39pCjd6Xk7QFQ-zF79kqCMfGSkHERufqSQ@mail.gmail.com>
Message-ID: <CAL3q7H4CT=Jbusvo39pCjd6Xk7QFQ-zF79kqCMfGSkHERufqSQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs: scrub: fix incorrectly reported
 logical/physical address
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Scrub is not reporting the correct logical/physical address, it can be
> verified by the following script:
>
>  # mkfs.btrfs -f $dev1
>  # mount $dev1 $mnt
>  # xfs_io -f -c "pwrite -S 0xaa 0 128k" $mnt/file1
>  # umount $mnt
>  # xfs_io -f -c "pwrite -S 0xff 13647872 4k" $dev1
>  # mount $dev1 $mnt
>  # btrfs scrub start -fB $mnt
>  # umount $mnt
>
> Note above 13647872 is the physical address for logical 13631488 + 4K.
>
> Scrub would report the following error:
>
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
631488 on dev /dev/mapper/test-scratch1 physical 13631488
>  BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /=
dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, l=
ength 4096, links 1 (path: file1)
>
> On the other hand, "btrfs check --check-data-csum" is reporting the
> correct logical/physical address:
>
>  Checking filesystem on /dev/test/scratch1
>  UUID: db2eb621-b09d-4f24-8199-da17dc7b3201
>  [5/7] checking csums against data
>  mirror 1 bytenr 13647872 csum 0x13fec125 expected csum 0x656bd64e
>  ERROR: errors found in csum tree
>
> [CAUSE]
> In the function scrub_stripe_report_errors(), we always use the
> stripe->logical and its physical address to print the error message, not
> taking the sector number into consideration at all.
>
> [FIX]
> Fix the error reporting function by calculating logical/physical with
> the sector number.
>
> Now the scrub report is correct:
>
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
647872 on dev /dev/mapper/test-scratch1 physical 13647872
>  BTRFS warning (device dm-2): checksum error at logical 13647872 on dev /=
dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset 1638=
4, length 4096, links 1 (path: file1)
>
> Fixes: 0096580713ff ("btrfs: scrub: introduce error reporting functionali=
ty for scrub_stripe")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, just one minor and optional comment below.

> ---
>  fs/btrfs/scrub.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index fa25004ab04e..119e98797b21 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -870,7 +870,7 @@ static void scrub_stripe_report_errors(struct scrub_c=
tx *sctx,
>                                       DEFAULT_RATELIMIT_BURST);
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>         struct btrfs_device *dev =3D NULL;
> -       u64 physical =3D 0;
> +       u64 stripe_physical =3D stripe->physical;
>         int nr_data_sectors =3D 0;
>         int nr_meta_sectors =3D 0;
>         int nr_nodatacsum_sectors =3D 0;
> @@ -903,13 +903,17 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                  */
>                 if (ret < 0)
>                         goto skip;
> -               physical =3D bioc->stripes[stripe_index].physical;
> +               stripe_physical =3D bioc->stripes[stripe_index].physical;
>                 dev =3D bioc->stripes[stripe_index].dev;
>                 btrfs_put_bioc(bioc);
>         }
>
>  skip:
>         for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, stripe=
->nr_sectors) {
> +               u64 logical =3D stripe->logical +
> +                             (sector_nr << fs_info->sectorsize_bits);
> +               u64 physical =3D stripe_physical +
> +                             (sector_nr << fs_info->sectorsize_bits);

These could be made const to make it clear they're not supposed to change.

Thanks.

>                 bool repaired =3D false;
>
>                 if (stripe->sectors[sector_nr].is_metadata) {
> @@ -938,12 +942,12 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                         if (dev) {
>                                 btrfs_err_rl_in_rcu(fs_info,
>                         "fixed up error at logical %llu on dev %s physica=
l %llu",
> -                                           stripe->logical, btrfs_dev_na=
me(dev),
> +                                           logical, btrfs_dev_name(dev),
>                                             physical);
>                         } else {
>                                 btrfs_err_rl_in_rcu(fs_info,
>                         "fixed up error at logical %llu on mirror %u",
> -                                           stripe->logical, stripe->mirr=
or_num);
> +                                           logical, stripe->mirror_num);
>                         }
>                         continue;
>                 }
> @@ -952,26 +956,26 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                 if (dev) {
>                         btrfs_err_rl_in_rcu(fs_info,
>         "unable to fixup (regular) error at logical %llu on dev %s physic=
al %llu",
> -                                           stripe->logical, btrfs_dev_na=
me(dev),
> +                                           logical, btrfs_dev_name(dev),
>                                             physical);
>                 } else {
>                         btrfs_err_rl_in_rcu(fs_info,
>         "unable to fixup (regular) error at logical %llu on mirror %u",
> -                                           stripe->logical, stripe->mirr=
or_num);
> +                                           logical, stripe->mirror_num);
>                 }
>
>                 if (test_bit(sector_nr, &stripe->io_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
>                                 scrub_print_common_warning("i/o error", d=
ev, false,
> -                                                    stripe->logical, phy=
sical);
> +                                                    logical, physical);
>                 if (test_bit(sector_nr, &stripe->csum_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
>                                 scrub_print_common_warning("checksum erro=
r", dev, false,
> -                                                    stripe->logical, phy=
sical);
> +                                                    logical, physical);
>                 if (test_bit(sector_nr, &stripe->meta_error_bitmap))
>                         if (__ratelimit(&rs) && dev)
>                                 scrub_print_common_warning("header error"=
, dev, false,
> -                                                    stripe->logical, phy=
sical);
> +                                                    logical, physical);
>         }
>
>         spin_lock(&sctx->stat_lock);
> --
> 2.44.0
>
>

