Return-Path: <linux-btrfs+bounces-13608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB7AA6ED3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC85D1C00698
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB622F75D;
	Fri,  2 May 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad5J/XJ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AD320F
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180149; cv=none; b=Gxfctmf/lVDBQmYK7umu9dfxdbtnJIcsAgUTTl8c5J7cMWv7wpzo4Y6VOoE8oxPLPLxS7G3IUlxBOajO7rPumHgK++uJPWrbQoW2gBV+UuepGsJXfcIbzxIX9WaKJgjzqdrtM3GjBIYDuDqVUCmKTBf529L5E2fldMCxqn+jruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180149; c=relaxed/simple;
	bh=wdTOB2+KyFQMX7G4VqZx5uxiX7q555vZ9unNMt5bYoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY0cqGdUiX8Psy9Cq2HL1xb64XUbv/KGHO3wfK3wjQsiLkbqK/TQFvKdwNmDlwVAC6eDLJcp4FhVawy+iNHwObpDL2MIqQ7PwlL1v3NoaHpB36pyxH8Yg0F2Hs/19sAcj6IWWxYokH04UG9L3CgL8HX7khIcvCznNBuI0ASkfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad5J/XJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20837C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746180149;
	bh=wdTOB2+KyFQMX7G4VqZx5uxiX7q555vZ9unNMt5bYoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ad5J/XJ7p0oCkgl2bVD3+V5X5bqVUoOoDu/V+b+2uhLoWIS++Uvk7Njh85I8HBfnl
	 Y/Lf8zqjNXpnpmj6FhsWIrGwEwv0A65y8IB8uN8I3oelzwrHIeH0OXuaCKf8pgnTzs
	 oI4MNCcUkARt04SWPUdbycZyrbkx4/3Q/EHwBcELGlIktwstDTrQlIv9TlV7h4Jwo5
	 5qkbKa1LH+/feQ2WhTjh/odLDrB6kpBRnZJjV88ACyZzDZ71fd1QUncwRjYvBofySb
	 fcklwSwz1G5JXnwZ+OwYDPlg69mAUhwcUbX7pVweNf7VTnHdLo1udmv5q02fHPmUna
	 3RdpTzjyimsVA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb615228a4so547543166b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 03:02:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXXS0ecn4xOxf4bH/G0et0tcHDRWe9bLjX8IH/u0xnE7uDZ5Ml
	JkcFFBBfdXf/LIbY0REkAIZ7OQJJT9KdtUaPma3IPCDwP2BC6T6UjZEdbtLlLeCaJVS8l2b1v4d
	Dz9lAS9PfAXXVZE4J038yPz3zZl8=
X-Google-Smtp-Source: AGHT+IHre9ku00FQDqzlXNUDcNDAith0OXt+2aI3TEEwNeBb+BNUlg6yZeiQ2EV/iUGqRUgk0hDGWGGfDtomKPIMGAE=
X-Received: by 2002:a17:906:9c8b:b0:ace:dc05:b186 with SMTP id
 a640c23a62f3a-ad17af344f5mr157666766b.21.1746180147583; Fri, 02 May 2025
 03:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <142a1de91d82b12c583f3d18efcdd92529a1d664.1746144642.git.wqu@suse.com>
In-Reply-To: <142a1de91d82b12c583f3d18efcdd92529a1d664.1746144642.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 May 2025 11:01:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5XGobun4seZ5u-D0udVhHALEMgeQ7V7bJFPvkR3Gmb7g@mail.gmail.com>
X-Gm-Features: ATxdqUGiTAJkPbIMOCvpzfBEFzQxDcBYzODCMNlHYfSEu88LXOpkWcJp5Zv_xGg
Message-ID: <CAL3q7H5XGobun4seZ5u-D0udVhHALEMgeQ7V7bJFPvkR3Gmb7g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: move error reporting members to stack
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 1:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently the following members of scrub_stripe are only utilized for
> error reporting:
>
> - init_error_bitmap
> - init_nr_io_errors
> - init_nr_csum_errors
> - init_nr_meta_errors
> - init_nr_meta_gen_errors
>
> There is no need to put all those members into scrub_stripe, which takes
> 24 bytes for each stripe, and we have 128 stripes for each device.
>
> Instead introduce a structure, scrub_error_records, and move all above
> members into that structure.
>
> And allocate such structure from stack inside
> scrub_stripe_read_repair_worker().
> Since that function is called from a workqueue context, we have more
> than enough stack space for just 24 bytes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This relies on a previous patch fixing scrub device stats update:
>   https://lore.kernel.org/linux-btrfs/1f9b59b90bc077095842003add7020fc947=
5f5f0.1746055699.git.wqu@suse.com/T/#u
> ---
>  fs/btrfs/scrub.c | 82 +++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 42 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 212066734b88..4ac615143e72 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -141,20 +141,6 @@ struct scrub_stripe {
>         /* Indicate which sectors are covered by extent items. */
>         unsigned long extent_sector_bitmap;
>
> -       /*
> -        * The errors hit during the initial read of the stripe.
> -        *
> -        * Would be utilized for error reporting and repair.
> -        *
> -        * The remaining init_nr_* records the number of errors hit, only=
 used
> -        * by error reporting.
> -        */
> -       unsigned long init_error_bitmap;
> -       unsigned int init_nr_io_errors;
> -       unsigned int init_nr_csum_errors;
> -       unsigned int init_nr_meta_errors;
> -       unsigned int init_nr_meta_gen_errors;
> -
>         /*
>          * The following error bitmaps are all for the current status.
>          * Every time we submit a new read, these bitmaps may be updated.
> @@ -231,6 +217,21 @@ struct scrub_warning {
>         struct btrfs_device     *dev;
>  };
>
> +/* Various members that are only for error reporting. */

The comment is superfluous, the name of the structure makes it
perfectly clear it's used for error tracking/reporting.

> +struct scrub_error_records {
> +       /*
> +        * Bitmap recording which blocks hit errors (IO/csum/...) during
> +        * the initial read.
> +        */
> +       unsigned long init_error_bitmap;
> +
> +       /* How many errors hit for each type (IO, csum, metadata). */

Same here.

> +       unsigned int init_nr_io_errors;
> +       unsigned int init_nr_csum_errors;
> +       unsigned int init_nr_meta_errors;
> +       unsigned int init_nr_meta_gen_errors;

I know it was already like this before, but the 'init_' prefix in the
names doesn't add any value, they could fo away.

Anyway the patch looks fine to me, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +};
> +
>  static void release_scrub_stripe(struct scrub_stripe *stripe)
>  {
>         if (!stripe)
> @@ -867,7 +868,8 @@ static void scrub_stripe_submit_repair_read(struct sc=
rub_stripe *stripe,
>  }
>
>  static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
> -                                      struct scrub_stripe *stripe)
> +                                      struct scrub_stripe *stripe,
> +                                      const struct scrub_error_records *=
errors)
>  {
>         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
> @@ -889,7 +891,7 @@ static void scrub_stripe_report_errors(struct scrub_c=
tx *sctx,
>          * Although our scrub_stripe infrastructure is mostly based on bt=
rfs_submit_bio()
>          * thus no need for dev/physical, error reporting still needs dev=
 and physical.
>          */
> -       if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors)=
) {
> +       if (!bitmap_empty(&errors->init_error_bitmap, stripe->nr_sectors)=
) {
>                 u64 mapped_len =3D fs_info->sectorsize;
>                 struct btrfs_io_context *bioc =3D NULL;
>                 int stripe_index =3D stripe->mirror_num - 1;
> @@ -923,14 +925,14 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>                                 nr_nodatacsum_sectors++;
>                 }
>
> -               if (test_bit(sector_nr, &stripe->init_error_bitmap) &&
> +               if (test_bit(sector_nr, &errors->init_error_bitmap) &&
>                     !test_bit(sector_nr, &stripe->error_bitmap)) {
>                         nr_repaired_sectors++;
>                         repaired =3D true;
>                 }
>
>                 /* Good sector from the beginning, nothing need to be don=
e. */
> -               if (!test_bit(sector_nr, &stripe->init_error_bitmap))
> +               if (!test_bit(sector_nr, &errors->init_error_bitmap))
>                         continue;
>
>                 /*
> @@ -982,12 +984,12 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>         }
>
>         /* Update the device stats. */
> -       for (int i =3D 0; i < stripe->init_nr_io_errors; i++)
> +       for (int i =3D 0; i < errors->init_nr_io_errors; i++)
>                 btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
READ_ERRS);
> -       for (int i =3D 0; i < stripe->init_nr_csum_errors; i++)
> +       for (int i =3D 0; i < errors->init_nr_csum_errors; i++)
>                 btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
CORRUPTION_ERRS);
>         /* Generation mismatch error is based on each metadata, not each =
block. */
> -       for (int i =3D 0; i < stripe->init_nr_meta_gen_errors;
> +       for (int i =3D 0; i < errors->init_nr_meta_gen_errors;
>              i +=3D fs_info->nodesize >> fs_info->sectorsize_bits)
>                 btrfs_dev_stat_inc_and_print(stripe->dev, BTRFS_DEV_STAT_=
GENERATION_ERRS);
>
> @@ -997,10 +999,10 @@ static void scrub_stripe_report_errors(struct scrub=
_ctx *sctx,
>         sctx->stat.data_bytes_scrubbed +=3D nr_data_sectors << fs_info->s=
ectorsize_bits;
>         sctx->stat.tree_bytes_scrubbed +=3D nr_meta_sectors << fs_info->s=
ectorsize_bits;
>         sctx->stat.no_csum +=3D nr_nodatacsum_sectors;
> -       sctx->stat.read_errors +=3D stripe->init_nr_io_errors;
> -       sctx->stat.csum_errors +=3D stripe->init_nr_csum_errors;
> -       sctx->stat.verify_errors +=3D stripe->init_nr_meta_errors +
> -                                   stripe->init_nr_meta_gen_errors;
> +       sctx->stat.read_errors +=3D errors->init_nr_io_errors;
> +       sctx->stat.csum_errors +=3D errors->init_nr_csum_errors;
> +       sctx->stat.verify_errors +=3D errors->init_nr_meta_errors +
> +                                   errors->init_nr_meta_gen_errors;
>         sctx->stat.uncorrectable_errors +=3D
>                 bitmap_weight(&stripe->error_bitmap, stripe->nr_sectors);
>         sctx->stat.corrected_errors +=3D nr_repaired_sectors;
> @@ -1028,6 +1030,7 @@ static void scrub_stripe_read_repair_worker(struct =
work_struct *work)
>         struct scrub_stripe *stripe =3D container_of(work, struct scrub_s=
tripe, work);
>         struct scrub_ctx *sctx =3D stripe->sctx;
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> +       struct scrub_error_records errors =3D { 0 };
>         int num_copies =3D btrfs_num_copies(fs_info, stripe->bg->start,
>                                           stripe->bg->length);
>         unsigned long repaired;
> @@ -1039,17 +1042,17 @@ static void scrub_stripe_read_repair_worker(struc=
t work_struct *work)
>         wait_scrub_stripe_io(stripe);
>         scrub_verify_one_stripe(stripe, stripe->extent_sector_bitmap);
>         /* Save the initial failed bitmap for later repair and report usa=
ge. */
> -       stripe->init_error_bitmap =3D stripe->error_bitmap;
> -       stripe->init_nr_io_errors =3D bitmap_weight(&stripe->io_error_bit=
map,
> -                                                 stripe->nr_sectors);
> -       stripe->init_nr_csum_errors =3D bitmap_weight(&stripe->csum_error=
_bitmap,
> -                                                   stripe->nr_sectors);
> -       stripe->init_nr_meta_errors =3D bitmap_weight(&stripe->meta_error=
_bitmap,
> -                                                   stripe->nr_sectors);
> -       stripe->init_nr_meta_gen_errors =3D bitmap_weight(&stripe->meta_g=
en_error_bitmap,
> -                                                       stripe->nr_sector=
s);
> +       errors.init_error_bitmap =3D stripe->error_bitmap;
> +       errors.init_nr_io_errors =3D bitmap_weight(&stripe->io_error_bitm=
ap,
> +                                                stripe->nr_sectors);
> +       errors.init_nr_csum_errors =3D bitmap_weight(&stripe->csum_error_=
bitmap,
> +                                                  stripe->nr_sectors);
> +       errors.init_nr_meta_errors =3D bitmap_weight(&stripe->meta_error_=
bitmap,
> +                                                  stripe->nr_sectors);
> +       errors.init_nr_meta_errors =3D bitmap_weight(&stripe->meta_gen_er=
ror_bitmap,
> +                                                  stripe->nr_sectors);
>
> -       if (bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sectors))
> +       if (bitmap_empty(&errors.init_error_bitmap, stripe->nr_sectors))
>                 goto out;
>
>         /*
> @@ -1099,7 +1102,7 @@ static void scrub_stripe_read_repair_worker(struct =
work_struct *work)
>          * Submit the repaired sectors.  For zoned case, we cannot do rep=
air
>          * in-place, but queue the bg to be relocated.
>          */
> -       bitmap_andnot(&repaired, &stripe->init_error_bitmap, &stripe->err=
or_bitmap,
> +       bitmap_andnot(&repaired, &errors.init_error_bitmap, &stripe->erro=
r_bitmap,
>                       stripe->nr_sectors);
>         if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sector=
s)) {
>                 if (btrfs_is_zoned(fs_info)) {
> @@ -1110,7 +1113,7 @@ static void scrub_stripe_read_repair_worker(struct =
work_struct *work)
>                 }
>         }
>
> -       scrub_stripe_report_errors(sctx, stripe);
> +       scrub_stripe_report_errors(sctx, stripe, &errors);
>         set_bit(SCRUB_STRIPE_FLAG_REPAIR_DONE, &stripe->state);
>         wake_up(&stripe->repair_wait);
>  }
> @@ -1522,11 +1525,6 @@ static void fill_one_extent_info(struct btrfs_fs_i=
nfo *fs_info,
>  static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
>  {
>         stripe->extent_sector_bitmap =3D 0;
> -       stripe->init_error_bitmap =3D 0;
> -       stripe->init_nr_io_errors =3D 0;
> -       stripe->init_nr_csum_errors =3D 0;
> -       stripe->init_nr_meta_errors =3D 0;
> -       stripe->init_nr_meta_gen_errors =3D 0;
>         stripe->error_bitmap =3D 0;
>         stripe->io_error_bitmap =3D 0;
>         stripe->csum_error_bitmap =3D 0;
> --
> 2.49.0
>
>

