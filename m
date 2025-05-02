Return-Path: <linux-btrfs+bounces-13607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE74AA6E7E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B80A1BC0181
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C126233149;
	Fri,  2 May 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK1i0LB4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4452309BD
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179591; cv=none; b=GqbuBN8QUvuFoYlzxGSA46D67qw6aS6OMe32Q5poTo1P4X+NkkU99wYJkSjR2wVY9mYjTOF/2mWIS5lcZ3+NwsQ3X+Vml7josJcr3PEV2oniuufG1nSPYFpHf2vZJALLUREst/yqVvwuVpibIEZh5jeVsFfen3Wc/Tgb5FH4hiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179591; c=relaxed/simple;
	bh=+RWsAEijmgsuTecMAp1aKdmoI0nfGEj5Ap3DIByd3JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgvCs5N1TBKTVw+mpvD8tB3wJshbGCcNPsZ9mP0tLsdDRzC773S9jWFXIl+Agt4ESFSJS51RwBBO9RRMm6351E3aRVD8tvXHXrDM6nzgS84uWn95/4RiYd3gMz0p5F+w1ygduhoCWRDWkSx0P0/fsXY6GzNwYRc6YEa1QjO6JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK1i0LB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F571C4CEED
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746179591;
	bh=+RWsAEijmgsuTecMAp1aKdmoI0nfGEj5Ap3DIByd3JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XK1i0LB41G75hDhuJVxTFX0nybWDVCEmbD80xOE1pe1taAX9zhIBmrrdfBjr6B4Ua
	 OyrMNrEbrZXSqIC3Ze1mpzDSfEPDP2dWoZ0oulxhkk/0JtpaNjZc4QbvWa+4fOvgXZ
	 bduWOt973kyLXBvocHrHM/AeG6BBrZwshf3qiG354IYnI3VMLeL/f+8irjTXxgELaU
	 ftfMOSnmNEBX4SHhINHUDicjmmWONrb40imeXZvs/DsFskPLXzKlzjoXNzDCHAjxfs
	 V/UbjBylC13YsgI051Wjpnikm8o5XQsu8gQCkS7734GRybX6ASFVUKpEkJn1+SaVaH
	 fNPLlG3ma7Z+g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so3131918a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 02:53:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrQs6KfquhPinuktDlnyUvihCd5LuOj3yBEdeXL2mhg+sX6AM8
	ByCSLk/y/GhvZDnJ4YALALUoSYL3s1ABixKtA7RWKI5EftR4vUha/U4TOeCnfH9EeC/bx8I7Kq9
	ApCJZih+HATIXCh0KufrzH5NLOXo=
X-Google-Smtp-Source: AGHT+IEP89fBQ90Y2lq3iBdQmQx6IXFhMYwM3FONBir02JZgp7YHPp3f/PgR0Uf+6ODIH6RwKUTVMjQfgN/DI5InH3I=
X-Received: by 2002:a17:907:940c:b0:ac2:6910:a12f with SMTP id
 a640c23a62f3a-ad17af4cbefmr233870966b.46.1746179589611; Fri, 02 May 2025
 02:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f9b59b90bc077095842003add7020fc9475f5f0.1746055699.git.wqu@suse.com>
In-Reply-To: <1f9b59b90bc077095842003add7020fc9475f5f0.1746055699.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 May 2025 10:52:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7g-nZnpf5DyNfhvixk_kE8rxYnmCjqd5io0CpXrb8t=w@mail.gmail.com>
X-Gm-Features: ATxdqUEc14ps5ei32UfPx-TWIublvLn7-djRh0ptoIOXAHrOq-Q9vKu5ahMQI0Q
Message-ID: <CAL3q7H7g-nZnpf5DyNfhvixk_kE8rxYnmCjqd5io0CpXrb8t=w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: update device stats when an error is detected
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 12:29=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since the migration to the new scrub_stripe interface, scrub no longer
> updates the device stats when hitting an error, no matter if it's a read
> or checksum mismatch error. E.g:
>
>  BTRFS info (device dm-2): scrub: started on devid 1
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
631488 on dev /dev/mapper/test-scratch1 physical 13631488
>  BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /=
dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, l=
ength 4096, links 1 (path: file)
>  BTRFS error (device dm-2): unable to fixup (regular) error at logical 13=
631488 on dev /dev/mapper/test-scratch1 physical 13631488
>  BTRFS warning (device dm-2): checksum error at logical 13631488 on dev /=
dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0, l=
ength 4096, links 1 (path: file)
>  BTRFS info (device dm-2): scrub: finished on devid 1 with status: 0
>
> Note there is no line showing the device stats error update.
>
> [CAUSE]
> In the migration to the new scrub_stripe interface, we no longer call
> btrfs_dev_stat_inc_and_print() anymore.
>
> [FIX]
> - Introduce a new bitmap for metadata generation errors
>   * A new bitmap
>     @meta_gen_error_bitmap is introduced to record which blocks have
>     metadata generation mismatch errors.
>
>   * A new counter for that bitmap
>     @init_nr_meta_gen_errors, is also introduced to store the number of
>     generation mismatch errors are found during the initial read.
>
>     This is for the error reporting at scrub_stripe_report_errors().
>
>   * New dedicated error message for unrepaired generation mismatches
>
>   * Update @meta_gen_error_bitmap if a transis mismatch is hit
>
> - Add btrfs_dev_stat_inc_and_print() calls to the following call sites
>   * scrub_stripe_report_errors()
>   * scrub_write_endio()
>     This is only for the write errors.
>
> This means there is a minor behavior change:
>
> - The timing of device stats error message
>   Since we concentrate the error messages at
>   scrub_stripe_report_errors(), the device stats error messages will all
>   show up in one go, after the detailed scrub error messages:
>
>    BTRFS error (device dm-2): unable to fixup (regular) error at logical =
13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>    BTRFS warning (device dm-2): checksum error at logical 13631488 on dev=
 /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0,=
 length 4096, links 1 (path: file)
>    BTRFS error (device dm-2): unable to fixup (regular) error at logical =
13631488 on dev /dev/mapper/test-scratch1 physical 13631488
>    BTRFS warning (device dm-2): checksum error at logical 13631488 on dev=
 /dev/mapper/test-scratch1, physical 13631488, root 5, inode 257, offset 0,=
 length 4096, links 1 (path: file)
>    BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, =
rd 0, flush 0, corrupt 1, gen 0
>    BTRFS error (device dm-2): bdev /dev/mapper/test-scratch1 errs: wr 0, =
rd 0, flush 0, corrupt 2, gen 0
>
> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub=
_stripe infrastructure")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 5d6166fd917e..212066734b88 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -153,12 +153,14 @@ struct scrub_stripe {
>         unsigned int init_nr_io_errors;
>         unsigned int init_nr_csum_errors;
>         unsigned int init_nr_meta_errors;
> +       unsigned int init_nr_meta_gen_errors;
>
>         /*
>          * The following error bitmaps are all for the current status.
>          * Every time we submit a new read, these bitmaps may be updated.
>          *
> -        * error_bitmap =3D io_error_bitmap | csum_error_bitmap | meta_er=
ror_bitmap;
> +        * error_bitmap =3D io_error_bitmap | csum_error_bitmap | meta_er=
ror_bitmap |

Line length here is at 83,  for comments we keep it up to 80, so
better reformat this by moving "meta_error_bitmap |" into the next
line.

> +        *                meta_generation_bitmap;
>          *
>          * IO and csum errors can happen for both metadata and data.
>          */
> @@ -166,6 +168,7 @@ struct scrub_stripe {
>         unsigned long io_error_bitmap;
>         unsigned long csum_error_bitmap;
>         unsigned long meta_error_bitmap;
> +       unsigned long meta_gen_error_bitmap;
>
>         /* For writeback (repair or replace) error reporting. */
>         unsigned long write_error_bitmap;
> @@ -662,7 +665,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>         }
>         if (stripe->sectors[sector_nr].generation !=3D
>             btrfs_stack_header_generation(header)) {
> -               bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors=
_per_tree);
> +               bitmap_set(&stripe->meta_gen_error_bitmap, sector_nr, sec=
tors_per_tree);
>                 bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_=
tree);
>                 btrfs_warn_rl(fs_info,
>                 "tree block %llu mirror %u has bad generation, has %llu w=
ant %llu",
> @@ -674,6 +677,7 @@ static void scrub_verify_one_metadata(struct scrub_st=
ripe *stripe, int sector_nr
>         bitmap_clear(&stripe->error_bitmap, sector_nr, sectors_per_tree);
>         bitmap_clear(&stripe->csum_error_bitmap, sector_nr, sectors_per_t=
ree);
>         bitmap_clear(&stripe->meta_error_bitmap, sector_nr, sectors_per_t=
ree);
> +       bitmap_clear(&stripe->meta_gen_error_bitmap, sector_nr, sectors_p=
er_tree);
>  }
>
>  static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sec=
tor_nr)
> @@ -971,8 +975,22 @@ static void scrub_stripe_report_errors(struct scrub_=
ctx *sctx,
>                         if (__ratelimit(&rs) && dev)
>                                 scrub_print_common_warning("header error"=
, dev, false,
>                                                      stripe->logical, phy=
sical);
> +               if (test_bit(sector_nr, &stripe->meta_gen_error_bitmap))
> +                       if (__ratelimit(&rs) && dev)
> +                               scrub_print_common_warning("generation er=
ror", dev, false,
> +                                                    stripe->logical, phy=
sical);
>         }
>
> +       /* Update the device stats. */
> +       for (int i =3D 0; i < stripe->init_nr_io_errors; i++)
> +               btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
READ_ERRS);
> +       for (int i =3D 0; i < stripe->init_nr_csum_errors; i++)
> +               btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
CORRUPTION_ERRS);
> +       /* Generation mismatch error is based on each metadata, not each =
block. */
> +       for (int i =3D 0; i < stripe->init_nr_meta_gen_errors;
> +            i +=3D fs_info->nodesize >> fs_info->sectorsize_bits)

Adding parenthesis around the shift operation would make it easier to read:

i +=3D (fs_info->nodesize >> fs_info->sectorsize_bits)

We generally do this as it's not a trivial operator precedence rule
everyone has in mind and removes any doubts.


> +               btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
GENERATION_ERRS);
> +
>         spin_lock(&sctx->stat_lock);
>         sctx->stat.data_extents_scrubbed +=3D stripe->nr_data_extents;
>         sctx->stat.tree_extents_scrubbed +=3D stripe->nr_meta_extents;
> @@ -981,7 +999,8 @@ static void scrub_stripe_report_errors(struct scrub_c=
tx *sctx,
>         sctx->stat.no_csum +=3D nr_nodatacsum_sectors;
>         sctx->stat.read_errors +=3D stripe->init_nr_io_errors;
>         sctx->stat.csum_errors +=3D stripe->init_nr_csum_errors;
> -       sctx->stat.verify_errors +=3D stripe->init_nr_meta_errors;
> +       sctx->stat.verify_errors +=3D stripe->init_nr_meta_errors +
> +                                   stripe->init_nr_meta_gen_errors;
>         sctx->stat.uncorrectable_errors +=3D
>                 bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
>         sctx->stat.corrected_errors +=3D nr_repaired_sectors;
> @@ -1027,6 +1046,8 @@ static void scrub_stripe_read_repair_worker(struct =
work_struct *work)
>                                                     stripe->nr_sectors);
>         stripe->init_nr_meta_errors =3D bitmap_weight(&stripe->meta_error=
_bitmap,
>                                                     stripe->nr_sectors);
> +       stripe->init_nr_meta_gen_errors =3D bitmap_weight(&stripe->meta_g=
en_error_bitmap,
> +                                                       stripe->nr_sector=
s);
>
>         if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
>                 goto out;
> @@ -1141,6 +1162,9 @@ static void scrub_write_endio(struct btrfs_bio *bbi=
o)
>                 bitmap_set(&stripe->write_error_bitmap, sector_nr,
>                            bio_size >> fs_info->sectorsize_bits);
>                 spin_unlock_irqrestore(&stripe->write_error_lock, flags);
> +               for (int i =3D 0; i < bio_size >> fs_info->sectorsize_bit=
s; i++)

Similar here:

i < (bio_size >> fs_info->sectorsize_bits)

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +                       btrfs_dev_stat_inc_and_print(stripe->dev,
> +                                                    BTRFS_DEV_STAT_WRITE=
_ERRS);
>         }
>         bio_put(&bbio->bio);
>
> @@ -1502,10 +1526,12 @@ static void scrub_stripe_reset_bitmaps(struct scr=
ub_stripe *stripe)
>         stripe->init_nr_io_errors =3D 0;
>         stripe->init_nr_csum_errors =3D 0;
>         stripe->init_nr_meta_errors =3D 0;
> +       stripe->init_nr_meta_gen_errors =3D 0;
>         stripe->error_bitmap =3D 0;
>         stripe->io_error_bitmap =3D 0;
>         stripe->csum_error_bitmap =3D 0;
>         stripe->meta_error_bitmap =3D 0;
> +       stripe->meta_gen_error_bitmap =3D 0;
>  }
>
>  /*
> --
> 2.49.0
>
>

