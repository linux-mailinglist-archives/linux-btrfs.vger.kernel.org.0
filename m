Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEE627038
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiKMPhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 10:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMPh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 10:37:29 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8AADEF9
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 07:37:27 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h132so9285122oif.2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pX3pMgU5JWN47p05KWJ0hvPHMbAkgCpuNWevslmbIA=;
        b=V+n9jGj8/MCRDE1IOK76hxnO+0kjOnoK6IeY09JDeA97NYJJumaGd19X2bX1bKwk/b
         8JJXgcegbAT7yp4xsupu2DwFvKla+0r4ODjEqb8Nmak+bCHnJvAJveUJ3QzoZA8bNnSf
         U4I2IZJBxtN5epIjDsNP7wrwWJQzeVHiF9vYLYwDgWUqzrLDku26vpOBDgBpZq5sNAue
         VhjzIDs0kDI7ZITTq9mpV++J8fHa0hpS1oUCadO4Llc8ATXX5K0KwXPPux8l9HlCyWmI
         6YIPknygHQfV5pcT80/EIsMRtb2xFCGnzBDp3TGjcCgPMGt/OdLQBdmkDwLPgJ9C3sNi
         p/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pX3pMgU5JWN47p05KWJ0hvPHMbAkgCpuNWevslmbIA=;
        b=xUkONfDV4c4drFlEf4ltyf+b9g8g1KRKCACiYhnVNrZgqmRhkIhMeH0ZqP+IQCNwLA
         awfWoXCP+S+rrEarNlzHemnxIQBxzkvT5d+tUFYhnOr+b/tLTuHA1j6wz+T5ADaDXrcP
         WUPTo6K0to/7EYXsH1K14ey3yb6GQ9zjPsTEbobFRIfqz2NfzdsSpBvCTL6GtWkBEAzn
         f3bRj9k+eSvu61UMEIEKNeMXpBpJCPo3qBA1FKb5ZYSXns2xAbollK9jxCGUCxeROR6I
         bAU5e6ZZDonKNehpyp7VLY8S/Sqipv1qCbJzaRQa/dMiUJPKcPdjg8YZ7W1S0cy/UzZs
         H1nA==
X-Gm-Message-State: ANoB5pntdtbY9PSZq7mrCNhHqwjlVv3KDlMh7qNC/ilLegZb5U9VFoFW
        3Hkgt/waUDPbgJJSlADCDSrfNF3lVGKi8sepNvjVF9J7rEPflA==
X-Google-Smtp-Source: AA0mqf7+9bq2QUyJV3pQ7z+rFWj8H68I8L/LlO7iAvFDCQFeJrzvMVXuwr70bzmUaLCMfGKJZpBUfA+atcu851A9Vhs=
X-Received: by 2002:a05:6808:241:b0:359:c6de:916a with SMTP id
 m1-20020a056808024100b00359c6de916amr4191081oie.42.1668353846374; Sun, 13 Nov
 2022 07:37:26 -0800 (PST)
MIME-Version: 1.0
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
In-Reply-To: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 13 Nov 2022 23:37:14 +0800
Message-ID: <CAAa-AGnz2QpnpLGurkRB3eKjkasPRgJnQsD1yvSJ0B8qO8caRQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range scrub
To:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000060239a05ed5be61c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000060239a05ed5be61c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is my test script.

Li Zhang <zhanglikernel@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8813=E6=
=97=A5=E5=91=A8=E6=97=A5 23:36=E5=86=99=E9=81=93=EF=BC=9A
>
> [implement]
> 1. Add the member checksum_error to the scrub_sector,
> which indicates the checksum error of the sector
>
> 2. Use scrub_find_btrfs_ordered_sum to find the desired
> btrfs_ordered_sum containing address logic, in
> scrub_sectors_for_parity and scrub_sectors, call
> Scrub_find_btrfs_ordered_sum finds the
> btrfs_ordered_sum containing the current logical address, and
> Calculate the exact checksum later.
>
> 3. In the scrub_checksum_data function,
> we should check all sectors in the scrub_block.
>
> 4. The job of the scrub_handle_errored_block
> function is to count the number of error and
> repair sectors if they can be repaired.
>
> The function enters the wrong scrub_block, and
> the overall process is as follows
>
> 1) Check the scrub_block again, check again if the error is gone.
>
> 2) Check the corresponding mirror scrub_block, if there is no error,
> Fix bad sblocks with mirror scrub_block.
>
> 3) If no error-free scrub_block is found, repair it sector by sector.
>
> One difficulty with this function is rechecking the scrub_block.
>
> Imagine this situation, if a sector is checked the first time
> without errors, butthe recheck returns an error. What should
> we do, this patch only fixes the bug that the sector first
> appeared (As in the case where the scrub_block
> contains only one scrub_sector).
>
> Another reason to only handle the first error is,
> If the device goes bad, the recheck function will report more and
> more errors,if we want to deal with the errors in the recheck,
> you need to recheck again and again, which may lead to
> Stuck in scrub_handle_errored_block for a long time.
>
> So rechecked bug reports will only be corrected in the
> next scrub.
>
> [test]
> I designed two test scripts based on the fstest project,
> the output is the same as the case where the scrub_block
> contains only one scrub sector,
>
> 1. There are two situations in raid1,
> raid1c3 and raid1c4. If an error occurs in
> different sectors of the sblock, the error can be corrected.
>
> An error is uncorrectable if all errors occur in the same
> scrub_sector in the scrub_block.
>
> 2. For raid6, if more than 2 stripts are damaged and the error
> cannot be repaired, a batch read error will also be reported.
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  fs/btrfs/scrub.c | 385 ++++++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 210 insertions(+), 175 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 196c4c6..5ca9f43 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -72,6 +72,7 @@ struct scrub_sector {
>         atomic_t                refs;
>         unsigned int            have_csum:1;
>         unsigned int            io_error:1;
> +       unsigned int            checksum_error:1;
>         u8                      csum[BTRFS_CSUM_SIZE];
>
>         struct scrub_recover    *recover;
> @@ -252,6 +253,7 @@ static void detach_scrub_page_private(struct page *pa=
ge)
>  #endif
>  }
>
> +
>  static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
>                                              struct btrfs_device *dev,
>                                              u64 logical, u64 physical,
> @@ -404,7 +406,7 @@ static int scrub_write_sector_to_dev_replace(struct s=
crub_block *sblock,
>  static void scrub_parity_put(struct scrub_parity *sparity);
>  static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>                          u64 physical, struct btrfs_device *dev, u64 flag=
s,
> -                        u64 gen, int mirror_num, u8 *csum,
> +                        u64 gen, int mirror_num,
>                          u64 physical_for_dev_replace);
>  static void scrub_bio_end_io(struct bio *bio);
>  static void scrub_bio_end_io_worker(struct work_struct *work);
> @@ -420,6 +422,10 @@ static int scrub_add_sector_to_wr_bio(struct scrub_c=
tx *sctx,
>  static void scrub_wr_bio_end_io(struct bio *bio);
>  static void scrub_wr_bio_end_io_worker(struct work_struct *work);
>  static void scrub_put_ctx(struct scrub_ctx *sctx);
> +static int scrub_find_btrfs_ordered_sum(struct scrub_ctx *sctx, u64 logi=
cal,
> +                                       struct btrfs_ordered_sum **order_=
sum);
> +static int scrub_get_sblock_checksum_error(struct scrub_block *sblock);
> +
>
>  static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
>  {
> @@ -991,19 +997,18 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>         struct btrfs_fs_info *fs_info;
>         u64 logical;
>         unsigned int failed_mirror_index;
> -       unsigned int is_metadata;
> -       unsigned int have_csum;
>         /* One scrub_block for each mirror */
>         struct scrub_block *sblocks_for_recheck[BTRFS_MAX_MIRRORS] =3D { =
0 };
>         struct scrub_block *sblock_bad;
>         int ret;
>         int mirror_index;
>         int sector_num;
> -       int success;
>         bool full_stripe_locked;
>         unsigned int nofs_flag;
>         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>                                       DEFAULT_RATELIMIT_BURST);
> +       int correct_error =3D 0;
> +       int uncorrect_error =3D 0;
>
>         BUG_ON(sblock_to_check->sector_count < 1);
>         fs_info =3D sctx->fs_info;
> @@ -1023,9 +1028,6 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>         logical =3D sblock_to_check->logical;
>         ASSERT(sblock_to_check->mirror_num);
>         failed_mirror_index =3D sblock_to_check->mirror_num - 1;
> -       is_metadata =3D !(sblock_to_check->sectors[0]->flags &
> -                       BTRFS_EXTENT_FLAG_DATA);
> -       have_csum =3D sblock_to_check->sectors[0]->have_csum;
>
>         if (!sctx->is_dev_replace && btrfs_repair_one_zone(fs_info, logic=
al))
>                 return 0;
> @@ -1054,7 +1056,8 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>                 if (ret =3D=3D -ENOMEM)
>                         sctx->stat.malloc_errors++;
>                 sctx->stat.read_errors++;
> -               sctx->stat.uncorrectable_errors++;
> +               sctx->stat.uncorrectable_errors +=3D scrub_get_sblock_che=
cksum_error(sblock_to_check);
> +               sctx->stat.uncorrectable_errors +=3D sblock_to_check->hea=
der_error;
>                 spin_unlock(&sctx->stat_lock);
>                 return ret;
>         }
> @@ -1104,7 +1107,10 @@ static int scrub_handle_errored_block(struct scrub=
_block *sblock_to_check)
>                         spin_lock(&sctx->stat_lock);
>                         sctx->stat.malloc_errors++;
>                         sctx->stat.read_errors++;
> -                       sctx->stat.uncorrectable_errors++;
> +                       sctx->stat.uncorrectable_errors +=3D
> +                               scrub_get_sblock_checksum_error(sblock_to=
_check);
> +                       sctx->stat.uncorrectable_errors +=3D
> +                               sblock_to_check->header_error;
>                         spin_unlock(&sctx->stat_lock);
>                         btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_=
READ_ERRS);
>                         goto out;
> @@ -1116,7 +1122,8 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>         if (ret) {
>                 spin_lock(&sctx->stat_lock);
>                 sctx->stat.read_errors++;
> -               sctx->stat.uncorrectable_errors++;
> +               sctx->stat.uncorrectable_errors +=3D scrub_get_sblock_che=
cksum_error(sblock_to_check);
> +               sctx->stat.uncorrectable_errors +=3D sblock_to_check->hea=
der_error;
>                 spin_unlock(&sctx->stat_lock);
>                 btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERR=
S);
>                 goto out;
> @@ -1138,7 +1145,8 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>                  * the cause)
>                  */
>                 spin_lock(&sctx->stat_lock);
> -               sctx->stat.unverified_errors++;
> +               sctx->stat.unverified_errors +=3D scrub_get_sblock_checks=
um_error(sblock_to_check);
> +               sctx->stat.unverified_errors +=3D sblock_to_check->header=
_error;
>                 sblock_to_check->data_corrected =3D 1;
>                 spin_unlock(&sctx->stat_lock);
>
> @@ -1147,22 +1155,7 @@ static int scrub_handle_errored_block(struct scrub=
_block *sblock_to_check)
>                 goto out;
>         }
>
> -       if (!sblock_bad->no_io_error_seen) {
> -               spin_lock(&sctx->stat_lock);
> -               sctx->stat.read_errors++;
> -               spin_unlock(&sctx->stat_lock);
> -               if (__ratelimit(&rs))
> -                       scrub_print_warning("i/o error", sblock_to_check)=
;
> -               btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_READ_ERR=
S);
> -       } else if (sblock_bad->checksum_error) {
> -               spin_lock(&sctx->stat_lock);
> -               sctx->stat.csum_errors++;
> -               spin_unlock(&sctx->stat_lock);
> -               if (__ratelimit(&rs))
> -                       scrub_print_warning("checksum error", sblock_to_c=
heck);
> -               btrfs_dev_stat_inc_and_print(dev,
> -                                            BTRFS_DEV_STAT_CORRUPTION_ER=
RS);
> -       } else if (sblock_bad->header_error) {
> +       if (sblock_to_check->header_error && sblock_bad->header_error) {
>                 spin_lock(&sctx->stat_lock);
>                 sctx->stat.verify_errors++;
>                 spin_unlock(&sctx->stat_lock);
> @@ -1175,8 +1168,48 @@ static int scrub_handle_errored_block(struct scrub=
_block *sblock_to_check)
>                 else
>                         btrfs_dev_stat_inc_and_print(dev,
>                                 BTRFS_DEV_STAT_CORRUPTION_ERRS);
> +       } else if (sblock_to_check->header_error && !sblock_bad->header_e=
rror) {
> +               spin_lock(&sctx->stat_lock);
> +               sctx->stat.unverified_errors++;
> +               spin_unlock(&sctx->stat_lock);
> +       } else if (!sblock_to_check->header_error && sblock_bad->header_e=
rror) {
> +               sblock_bad->header_error =3D 0;
> +       } else {
> +               for (sector_num =3D 0; sector_num < sblock_bad->sector_co=
unt; sector_num++) {
> +                       struct scrub_sector *bad_sector =3D sblock_bad->s=
ectors[sector_num];
> +                       struct scrub_sector *check_sector =3D sblock_to_c=
heck->sectors[sector_num];
> +
> +                       if (bad_sector->io_error || check_sector->io_erro=
r) {
> +                               spin_lock(&sctx->stat_lock);
> +                               sctx->stat.read_errors++;
> +                               spin_unlock(&sctx->stat_lock);
> +                               if (__ratelimit(&rs))
> +                                       scrub_print_warning("i/o error", =
sblock_to_check);
> +                               btrfs_dev_stat_inc_and_print(dev, BTRFS_D=
EV_STAT_READ_ERRS);
> +                       } else if (check_sector->checksum_error && bad_se=
ctor->checksum_error) {
> +                               spin_lock(&sctx->stat_lock);
> +                               sctx->stat.csum_errors++;
> +                               spin_unlock(&sctx->stat_lock);
> +                               if (__ratelimit(&rs))
> +                                       scrub_print_warning("checksum err=
or", sblock_to_check);
> +                               btrfs_dev_stat_inc_and_print(dev,
> +                                                       BTRFS_DEV_STAT_CO=
RRUPTION_ERRS);
> +
> +                       } else if (check_sector->checksum_error && !bad_s=
ector->checksum_error) {
> +                               spin_lock(&sctx->stat_lock);
> +                               sctx->stat.unverified_errors++;
> +                               spin_unlock(&sctx->stat_lock);
> +                       } else if (!check_sector->checksum_error && bad_s=
ector->checksum_error) {
> +                               struct scrub_sector *temp_sector =3D sblo=
ck_bad->sectors[sector_num];
> +
> +                               sblock_bad->sectors[sector_num]
> +                                       =3D sblock_to_check->sectors[sect=
or_num];
> +                               sblock_to_check->sectors[sector_num] =3D =
temp_sector;
> +                       }
> +               }
>         }
>
> +
>         if (sctx->readonly) {
>                 ASSERT(!sctx->is_dev_replace);
>                 goto out;
> @@ -1233,18 +1266,23 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>                     sblock_other->no_io_error_seen) {
>                         if (sctx->is_dev_replace) {
>                                 scrub_write_block_to_dev_replace(sblock_o=
ther);
> -                               goto corrected_error;
> +                               correct_error +=3D scrub_get_sblock_check=
sum_error(sblock_bad);
> +                               correct_error +=3D sblock_bad->header_err=
or;
> +                               goto error_summary;
>                         } else {
>                                 ret =3D scrub_repair_block_from_good_copy=
(
>                                                 sblock_bad, sblock_other)=
;
> -                               if (!ret)
> -                                       goto corrected_error;
> +                               if (!ret) {
> +                                       correct_error +=3D
> +                                               scrub_get_sblock_checksum=
_error(sblock_bad);
> +                                       correct_error +=3D sblock_bad->he=
ader_error;
> +                                       goto error_summary;
> +                               }
>                         }
>                 }
>         }
>
> -       if (sblock_bad->no_io_error_seen && !sctx->is_dev_replace)
> -               goto did_not_correct_error;
> +
>
>         /*
>          * In case of I/O errors in the area that is supposed to be
> @@ -1270,17 +1308,16 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>          * mirror, even if other 512 byte sectors in the same sectorsize
>          * area are unreadable.
>          */
> -       success =3D 1;
>         for (sector_num =3D 0; sector_num < sblock_bad->sector_count;
>              sector_num++) {
>                 struct scrub_sector *sector_bad =3D sblock_bad->sectors[s=
ector_num];
>                 struct scrub_block *sblock_other =3D NULL;
>
>                 /* Skip no-io-error sectors in scrub */
> -               if (!sector_bad->io_error && !sctx->is_dev_replace)
> +               if (!(sector_bad->io_error || sector_bad->checksum_error)=
 && !sctx->is_dev_replace)
>                         continue;
>
> -               if (scrub_is_page_on_raid56(sblock_bad->sectors[0])) {
> +               if (scrub_is_page_on_raid56(sector_bad)) {
>                         /*
>                          * In case of dev replace, if raid56 rebuild proc=
ess
>                          * didn't work out correct data, then copy the co=
ntent
> @@ -1289,6 +1326,7 @@ static int scrub_handle_errored_block(struct scrub_=
block *sblock_to_check)
>                          * sblock_for_recheck array to target device.
>                          */
>                         sblock_other =3D NULL;
> +                       uncorrect_error++;
>                 } else if (sector_bad->io_error) {
>                         /* Try to find no-io-error sector in mirrors */
>                         for (mirror_index =3D 0;
> @@ -1302,7 +1340,21 @@ static int scrub_handle_errored_block(struct scrub=
_block *sblock_to_check)
>                                 }
>                         }
>                         if (!sblock_other)
> -                               success =3D 0;
> +                               uncorrect_error++;
> +               } else if (sector_bad->checksum_error) {
> +                       for (mirror_index =3D 0;
> +                            mirror_index < BTRFS_MAX_MIRRORS &&
> +                            sblocks_for_recheck[mirror_index]->sector_co=
unt > 0;
> +                            mirror_index++) {
> +                               if (!sblocks_for_recheck[mirror_index]->s=
ectors[sector_num]->io_error &&
> +                                       !sblocks_for_recheck[mirror_index=
]->sectors[sector_num]->checksum_error) {
> +                                       sblock_other =3D sblocks_for_rech=
eck[mirror_index];
> +                                       break;
> +                               }
> +                       }
> +                       if (!sblock_other) {
> +                               uncorrect_error++;
> +                       }
>                 }
>
>                 if (sctx->is_dev_replace) {
> @@ -1319,56 +1371,28 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
>                                                               sector_num)=
 !=3D 0) {
>                                 atomic64_inc(
>                                         &fs_info->dev_replace.num_write_e=
rrors);
> -                               success =3D 0;
>                         }
>                 } else if (sblock_other) {
>                         ret =3D scrub_repair_sector_from_good_copy(sblock=
_bad,
>                                                                  sblock_o=
ther,
>                                                                  sector_n=
um, 0);
> -                       if (0 =3D=3D ret)
> +                       if (0 =3D=3D ret && sector_bad->io_error) {
> +                               correct_error++;
>                                 sector_bad->io_error =3D 0;
> -                       else
> -                               success =3D 0;
> +                       } else if (0 =3D=3D ret && sector_bad->checksum_e=
rror) {
> +                               correct_error++;
> +                               sector_bad->checksum_error =3D 0;
> +                       } else {
> +                               uncorrect_error++;
> +                       }
>                 }
>         }
>
> -       if (success && !sctx->is_dev_replace) {
> -               if (is_metadata || have_csum) {
> -                       /*
> -                        * need to verify the checksum now that all
> -                        * sectors on disk are repaired (the write
> -                        * request for data to be repaired is on its way)=
.
> -                        * Just be lazy and use scrub_recheck_block()
> -                        * which re-reads the data before the checksum
> -                        * is verified, but most likely the data comes ou=
t
> -                        * of the page cache.
> -                        */
> -                       scrub_recheck_block(fs_info, sblock_bad, 1);
> -                       if (!sblock_bad->header_error &&
> -                           !sblock_bad->checksum_error &&
> -                           sblock_bad->no_io_error_seen)
> -                               goto corrected_error;
> -                       else
> -                               goto did_not_correct_error;
> -               } else {
> -corrected_error:
> -                       spin_lock(&sctx->stat_lock);
> -                       sctx->stat.corrected_errors++;
> -                       sblock_to_check->data_corrected =3D 1;
> -                       spin_unlock(&sctx->stat_lock);
> -                       btrfs_err_rl_in_rcu(fs_info,
> -                               "fixed up error at logical %llu on dev %s=
",
> -                               logical, rcu_str_deref(dev->name));
> -               }
> -       } else {
> -did_not_correct_error:
> -               spin_lock(&sctx->stat_lock);
> -               sctx->stat.uncorrectable_errors++;
> -               spin_unlock(&sctx->stat_lock);
> -               btrfs_err_rl_in_rcu(fs_info,
> -                       "unable to fixup (regular) error at logical %llu =
on dev %s",
> -                       logical, rcu_str_deref(dev->name));
> -       }
> +error_summary:
> +       spin_lock(&sctx->stat_lock);
> +       sctx->stat.uncorrectable_errors +=3D uncorrect_error;
> +       sctx->stat.corrected_errors +=3D correct_error;
> +       spin_unlock(&sctx->stat_lock);
>
>  out:
>         for (mirror_index =3D 0; mirror_index < BTRFS_MAX_MIRRORS; mirror=
_index++) {
> @@ -1513,10 +1537,10 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
>                         }
>                         sector->flags =3D flags;
>                         sector->generation =3D generation;
> -                       sector->have_csum =3D have_csum;
> +                       sector->have_csum =3D original_sblock->sectors[se=
ctor_index]->have_csum;
>                         if (have_csum)
>                                 memcpy(sector->csum,
> -                                      original_sblock->sectors[0]->csum,
> +                                      original_sblock->sectors[sector_in=
dex]->csum,
>                                        sctx->fs_info->csum_size);
>
>                         scrub_stripe_index_and_offset(logical,
> @@ -1688,11 +1712,15 @@ static int scrub_repair_block_from_good_copy(stru=
ct scrub_block *sblock_bad,
>
>         for (i =3D 0; i < sblock_bad->sector_count; i++) {
>                 int ret_sub;
> -
> -               ret_sub =3D scrub_repair_sector_from_good_copy(sblock_bad=
,
> +               if (sblock_bad->sectors[i]->checksum_error =3D=3D 1
> +                       && sblock_good->sectors[i]->checksum_error =3D=3D=
 0){
> +                       ret_sub =3D scrub_repair_sector_from_good_copy(sb=
lock_bad,
>                                                              sblock_good,=
 i, 1);
> -               if (ret_sub)
> -                       ret =3D ret_sub;
> +                       if (ret_sub)
> +                               ret =3D ret_sub;
> +               } else if (sblock_bad->sectors[i]->checksum_error =3D=3D =
1) {
> +                       ret =3D 1;
> +               }
>         }
>
>         return ret;
> @@ -1984,22 +2012,46 @@ static int scrub_checksum_data(struct scrub_block=
 *sblock)
>         u8 csum[BTRFS_CSUM_SIZE];
>         struct scrub_sector *sector;
>         char *kaddr;
> +       int i;
> +       int io_error =3D 0;
>
>         BUG_ON(sblock->sector_count < 1);
> -       sector =3D sblock->sectors[0];
> -       if (!sector->have_csum)
> -               return 0;
> -
> -       kaddr =3D scrub_sector_get_kaddr(sector);
>
>         shash->tfm =3D fs_info->csum_shash;
>         crypto_shash_init(shash);
> +       for (i =3D 0; i < sblock->sector_count; i++) {
> +               sector =3D sblock->sectors[i];
> +               if (sector->io_error =3D=3D 1) {
> +                       io_error =3D 1;
> +                       continue;
> +               }
> +               if (!sector->have_csum)
> +                       continue;
>
> -       crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> +               kaddr =3D scrub_sector_get_kaddr(sector);
> +               crypto_shash_digest(shash, kaddr, fs_info->sectorsize, cs=
um);
> +               if (memcmp(csum, sector->csum, fs_info->csum_size)) {
> +                       sector->checksum_error =3D 1;
> +                       sblock->checksum_error =3D 1;
> +               } else {
> +                       sector->checksum_error =3D 0;
> +               }
> +       }
> +       return sblock->checksum_error | io_error;
> +}
>
> -       if (memcmp(csum, sector->csum, fs_info->csum_size))
> -               sblock->checksum_error =3D 1;
> -       return sblock->checksum_error;
> +static int scrub_get_sblock_checksum_error(struct scrub_block *sblock)
> +{
> +       int count =3D 0;
> +       int i;
> +
> +       if (sblock =3D=3D NULL)
> +               return count;
> +       for (i =3D 0; i < sblock->sector_count; i++) {
> +               if (sblock->sectors[i]->checksum_error =3D=3D 1)
> +                       count++;
> +       }
> +       return count;
>  }
>
>  static int scrub_checksum_tree_block(struct scrub_block *sblock)
> @@ -2062,8 +2114,12 @@ static int scrub_checksum_tree_block(struct scrub_=
block *sblock)
>         }
>
>         crypto_shash_final(shash, calculated_csum);
> -       if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_siz=
e))
> +       if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_siz=
e)) {
> +               sblock->sectors[0]->checksum_error =3D 1;
>                 sblock->checksum_error =3D 1;
> +       } else {
> +               sblock->sectors[0]->checksum_error =3D 0;
> +       }
>
>         return sblock->header_error || sblock->checksum_error;
>  }
> @@ -2400,12 +2456,14 @@ static void scrub_missing_raid56_pages(struct scr=
ub_block *sblock)
>
>  static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>                        u64 physical, struct btrfs_device *dev, u64 flags,
> -                      u64 gen, int mirror_num, u8 *csum,
> +                      u64 gen, int mirror_num,
>                        u64 physical_for_dev_replace)
>  {
>         struct scrub_block *sblock;
>         const u32 sectorsize =3D sctx->fs_info->sectorsize;
>         int index;
> +       int have_csum;
> +       struct btrfs_ordered_sum *order_sum =3D NULL;
>
>         sblock =3D alloc_scrub_block(sctx, dev, logical, physical,
>                                    physical_for_dev_replace, mirror_num);
> @@ -2415,7 +2473,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>                 spin_unlock(&sctx->stat_lock);
>                 return -ENOMEM;
>         }
> -
>         for (index =3D 0; len > 0; index++) {
>                 struct scrub_sector *sector;
>                 /*
> @@ -2424,7 +2481,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u6=
4 logical, u32 len,
>                  * more memory for PAGE_SIZE > sectorsize case.
>                  */
>                 u32 l =3D min(sectorsize, len);
> -
>                 sector =3D alloc_scrub_sector(sblock, logical, GFP_KERNEL=
);
>                 if (!sector) {
>                         spin_lock(&sctx->stat_lock);
> @@ -2435,11 +2491,25 @@ static int scrub_sectors(struct scrub_ctx *sctx, =
u64 logical, u32 len,
>                 }
>                 sector->flags =3D flags;
>                 sector->generation =3D gen;
> -               if (csum) {
> -                       sector->have_csum =3D 1;
> -                       memcpy(sector->csum, csum, sctx->fs_info->csum_si=
ze);
> -               } else {
> -                       sector->have_csum =3D 0;
> +               if (flags & BTRFS_EXTENT_FLAG_DATA) {
> +                       if (order_sum =3D=3D NULL ||
> +                               (order_sum->bytenr + order_sum->len <=3D =
logical)) {
> +                               order_sum =3D NULL;
> +                               have_csum =3D scrub_find_btrfs_ordered_su=
m(sctx, logical, &order_sum);
> +                       }
> +                       if (have_csum =3D=3D 0) {
> +                               ++sctx->stat.no_csum;
> +                               sector->have_csum =3D 0;
> +                       } else {
> +                               int order_csum_index;
> +
> +                               sector->have_csum =3D 1;
> +                               order_csum_index =3D (logical-order_sum->=
bytenr)
> +                                       >> sctx->fs_info->sectorsize_bits=
;
> +                               memcpy(sector->csum,
> +                                       order_sum->sums + order_csum_inde=
x * sctx->fs_info->csum_size,
> +                                       sctx->fs_info->csum_size);
> +                       }
>                 }
>                 len -=3D l;
>                 logical +=3D l;
> @@ -2571,7 +2641,8 @@ static void scrub_block_complete(struct scrub_block=
 *sblock)
>  {
>         int corrupted =3D 0;
>
> -       if (!sblock->no_io_error_seen) {
> +       if (!sblock->no_io_error_seen && !(sblock->sector_count > 0
> +               && (sblock->sectors[0]->flags & BTRFS_EXTENT_FLAG_DATA)))=
 {
>                 corrupted =3D 1;
>                 scrub_handle_errored_block(sblock);
>         } else {
> @@ -2597,61 +2668,30 @@ static void scrub_block_complete(struct scrub_blo=
ck *sblock)
>         }
>  }
>
> -static void drop_csum_range(struct scrub_ctx *sctx, struct btrfs_ordered=
_sum *sum)
> -{
> -       sctx->stat.csum_discards +=3D sum->len >> sctx->fs_info->sectorsi=
ze_bits;
> -       list_del(&sum->list);
> -       kfree(sum);
> -}
> -
>  /*
> - * Find the desired csum for range [logical, logical + sectorsize), and =
store
> - * the csum into @csum.
> + * Find the desired btrfs_ordered_sum contain address logical, and store
> + * the result into @order_sum.
>   *
>   * The search source is sctx->csum_list, which is a pre-populated list
> - * storing bytenr ordered csum ranges.  We're responsible to cleanup any=
 range
> - * that is before @logical.
> + * storing bytenr ordered csum ranges.
>   *
> - * Return 0 if there is no csum for the range.
> - * Return 1 if there is csum for the range and copied to @csum.
> + * Return 0 if there is no btrfs_ordered_sum contain the address logical=
.
> + * Return 1 if there is btrfs_order_sum contain the address logincal and=
 copied to @order_sum.
>   */
> -static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum=
)
> +static int scrub_find_btrfs_ordered_sum(struct scrub_ctx *sctx, u64 logi=
cal,
> +                                       struct btrfs_ordered_sum **order_=
sum)
>  {
>         bool found =3D false;
> +       struct btrfs_ordered_sum *sum;
>
> -       while (!list_empty(&sctx->csum_list)) {
> -               struct btrfs_ordered_sum *sum =3D NULL;
> -               unsigned long index;
> -               unsigned long num_sectors;
> -
> -               sum =3D list_first_entry(&sctx->csum_list,
> -                                      struct btrfs_ordered_sum, list);
> -               /* The current csum range is beyond our range, no csum fo=
und */
> +       list_for_each_entry(sum, &sctx->csum_list, list) {
> +               /* no btrfs_ordered_sum found */
>                 if (sum->bytenr > logical)
>                         break;
> -
> -               /*
> -                * The current sum is before our bytenr, since scrub is a=
lways
> -                * done in bytenr order, the csum will never be used anym=
ore,
> -                * clean it up so that later calls won't bother with the =
range,
> -                * and continue search the next range.
> -                */
> -               if (sum->bytenr + sum->len <=3D logical) {
> -                       drop_csum_range(sctx, sum);
> +               if (sum->bytenr + sum->len <=3D logical)
>                         continue;
> -               }
> -
> -               /* Now the csum range covers our bytenr, copy the csum */
>                 found =3D true;
> -               index =3D (logical - sum->bytenr) >> sctx->fs_info->secto=
rsize_bits;
> -               num_sectors =3D sum->len >> sctx->fs_info->sectorsize_bit=
s;
> -
> -               memcpy(csum, sum->sums + index * sctx->fs_info->csum_size=
,
> -                      sctx->fs_info->csum_size);
> -
> -               /* Cleanup the range if we're at the end of the csum rang=
e */
> -               if (index =3D=3D num_sectors - 1)
> -                       drop_csum_range(sctx, sum);
> +               *order_sum =3D sum;
>                 break;
>         }
>         if (!found)
> @@ -2669,7 +2709,6 @@ static int scrub_extent(struct scrub_ctx *sctx, str=
uct map_lookup *map,
>         u64 src_physical =3D physical;
>         int src_mirror =3D mirror_num;
>         int ret;
> -       u8 csum[BTRFS_CSUM_SIZE];
>         u32 blocksize;
>
>         if (flags & BTRFS_EXTENT_FLAG_DATA) {
> @@ -2685,7 +2724,7 @@ static int scrub_extent(struct scrub_ctx *sctx, str=
uct map_lookup *map,
>                 if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>                         blocksize =3D map->stripe_len;
>                 else
> -                       blocksize =3D sctx->fs_info->nodesize;
> +                       blocksize =3D BTRFS_STRIPE_LEN;
>                 spin_lock(&sctx->stat_lock);
>                 sctx->stat.tree_extents_scrubbed++;
>                 sctx->stat.tree_bytes_scrubbed +=3D len;
> @@ -2709,17 +2748,9 @@ static int scrub_extent(struct scrub_ctx *sctx, st=
ruct map_lookup *map,
>                                      &src_dev, &src_mirror);
>         while (len) {
>                 u32 l =3D min(len, blocksize);
> -               int have_csum =3D 0;
> -
> -               if (flags & BTRFS_EXTENT_FLAG_DATA) {
> -                       /* push csums to sbio */
> -                       have_csum =3D scrub_find_csum(sctx, logical, csum=
);
> -                       if (have_csum =3D=3D 0)
> -                               ++sctx->stat.no_csum;
> -               }
>                 ret =3D scrub_sectors(sctx, logical, l, src_physical, src=
_dev,
>                                     flags, gen, src_mirror,
> -                                   have_csum ? csum : NULL, physical);
> +                                   physical);
>                 if (ret)
>                         return ret;
>                 len -=3D l;
> @@ -2733,12 +2764,14 @@ static int scrub_extent(struct scrub_ctx *sctx, s=
truct map_lookup *map,
>  static int scrub_sectors_for_parity(struct scrub_parity *sparity,
>                                   u64 logical, u32 len,
>                                   u64 physical, struct btrfs_device *dev,
> -                                 u64 flags, u64 gen, int mirror_num, u8 =
*csum)
> +                                 u64 flags, u64 gen, int mirror_num)
>  {
>         struct scrub_ctx *sctx =3D sparity->sctx;
>         struct scrub_block *sblock;
>         const u32 sectorsize =3D sctx->fs_info->sectorsize;
>         int index;
> +       struct btrfs_ordered_sum *order_sum =3D NULL;
> +       int have_csum;
>
>         ASSERT(IS_ALIGNED(len, sectorsize));
>
> @@ -2770,11 +2803,24 @@ static int scrub_sectors_for_parity(struct scrub_=
parity *sparity,
>                 list_add_tail(&sector->list, &sparity->sectors_list);
>                 sector->flags =3D flags;
>                 sector->generation =3D gen;
> -               if (csum) {
> -                       sector->have_csum =3D 1;
> -                       memcpy(sector->csum, csum, sctx->fs_info->csum_si=
ze);
> -               } else {
> -                       sector->have_csum =3D 0;
> +               if (flags & BTRFS_EXTENT_FLAG_DATA) {
> +                       if (order_sum =3D=3D NULL
> +                               || (order_sum->bytenr + order_sum->len <=
=3D logical)) {
> +                               order_sum =3D NULL;
> +                               have_csum =3D scrub_find_btrfs_ordered_su=
m(sctx, logical, &order_sum);
> +                       }
> +                       if (have_csum =3D=3D 0) {
> +                               sector->have_csum =3D 0;
> +                       } else {
> +                               int order_csum_index;
> +
> +                               sector->have_csum =3D 1;
> +                               order_csum_index =3D (logical-order_sum->=
bytenr)
> +                                       >> sctx->fs_info->sectorsize_bits=
;
> +                               memcpy(sector->csum,
> +                                       order_sum->sums + order_csum_inde=
x * sctx->fs_info->csum_size,
> +                                       sctx->fs_info->csum_size);
> +                       }
>                 }
>
>                 /* Iterate over the stripe range in sectorsize steps */
> @@ -2807,7 +2853,6 @@ static int scrub_extent_for_parity(struct scrub_par=
ity *sparity,
>  {
>         struct scrub_ctx *sctx =3D sparity->sctx;
>         int ret;
> -       u8 csum[BTRFS_CSUM_SIZE];
>         u32 blocksize;
>
>         if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
> @@ -2826,20 +2871,10 @@ static int scrub_extent_for_parity(struct scrub_p=
arity *sparity,
>
>         while (len) {
>                 u32 l =3D min(len, blocksize);
> -               int have_csum =3D 0;
> -
> -               if (flags & BTRFS_EXTENT_FLAG_DATA) {
> -                       /* push csums to sbio */
> -                       have_csum =3D scrub_find_csum(sctx, logical, csum=
);
> -                       if (have_csum =3D=3D 0)
> -                               goto skip;
> -               }
>                 ret =3D scrub_sectors_for_parity(sparity, logical, l, phy=
sical, dev,
> -                                            flags, gen, mirror_num,
> -                                            have_csum ? csum : NULL);
> +                                            flags, gen, mirror_num);
>                 if (ret)
>                         return ret;
> -skip:
>                 len -=3D l;
>                 logical +=3D l;
>                 physical +=3D l;
> @@ -4148,7 +4183,7 @@ static noinline_for_stack int scrub_supers(struct s=
crub_ctx *sctx,
>
>                 ret =3D scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE=
, bytenr,
>                                     scrub_dev, BTRFS_EXTENT_FLAG_SUPER, g=
en, i,
> -                                   NULL, bytenr);
> +                                   bytenr);
>                 if (ret)
>                         return ret;
>         }
> --
> 1.8.3.1
>

--00000000000060239a05ed5be61c
Content-Type: application/octet-stream; name=raid1test
Content-Disposition: attachment; filename=raid1test
Content-Transfer-Encoding: base64
Content-ID: <f_lafismvk0>
X-Attachment-Id: f_lafismvk0

IyEgL2Jpbi9iYXNoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIyBDb3B5cmln
aHQgKGMpIDIwMjIgWU9VUiBOQU1FIEhFUkUuICBBbGwgUmlnaHRzIFJlc2VydmVkLgojCiMgRlMg
UUEgVGVzdCAyNzgtc2NydWIKIwojIHdoYXQgYW0gSSBoZXJlIGZvcj8KIwouIC4vY29tbW9uL3By
ZWFtYmxlCl9iZWdpbl9mc3Rlc3QgYXV0byBxdWljayBzY3J1YgoKLiAuL2NvbW1vbi9maWx0ZXIK
Cl9zdXBwb3J0ZWRfZnMgYnRyZnMKX3JlcXVpcmVfc2NyYXRjaF9kZXZfcG9vbCA0CgpfcmVxdWly
ZV9idHJmc19zdXBwb3J0X3NlY3RvcnNpemUgNDA5NgoKX3JlcXVpcmVfbm9uX3pvbmVkX2Rldmlj
ZSAiJHtTQ1JBVENIX0RFVn0iCgojIHJlYWwgUUEgdGVzdCBzdGFydHMgaGVyZQoKIyBNb2RpZnkg
YXMgYXBwcm9wcmlhdGUuCmRlY2xhcmUgLWEgVEVTVF9WRUNUT1JTX1dJVEhNSVJST1I9KAoiMjpy
YWlkMTpyYWlkMSIKIjM6cmFpZDFjMzpyYWlkMWMzIgoiNDpyYWlkMWM0OnJhaWQxYzQiCikKCnJ1
bl9jb3JyZWN0X3Rlc3RjYXNlKCkgewoJSUZTPSc6JyByZWFkIC1yYSBhcmdzIDw8PCAkMQoJbnVt
X2Rpc2tzPSR7YXJnc1swXX0KCW1ldGFkYXRhX3R5cGU9JHthcmdzWzFdfQoJZGF0YV90eXBlPSR7
YXJnc1syXX0KCV9zY3JhdGNoX2Rldl9wb29sX2dldCAkbnVtX2Rpc2tzCglfc2NyYXRjaF9wb29s
X21rZnMgIi1tJG1ldGFkYXRhX3R5cGUgLWQkZGF0YV90eXBlIC1zIDRrIiA+PiAkc2VxcmVzLmZ1
bGwgMj4mMQoJX3NjcmF0Y2hfbW91bnQKCSMgQ3JlYXRlIGEgZGF0YSBleHRlbnQgd2l0aCAyIHNl
Y3RvcnMKCSRYRlNfSU9fUFJPRyAtZmMgInB3cml0ZSAtUyAweGFhIDAgOGsiICRTQ1JBVENIX01O
VC9mb29iYXIgPj4gJHNlcXJlcy5mdWxsIDI+JjEKCXN5bmMKCWZpcnN0X2xvZ2ljYWw9JChfYnRy
ZnNfZ2V0X2ZpcnN0X2xvZ2ljYWwgJFNDUkFUQ0hfTU5UL2Zvb2JhcikKCWVjaG8gImxvZ2ljYWwg
b2YgdGhlIGZpcnN0IHNlY3RvcjogJGZpcnN0X2xvZ2ljYWwiID4+ICRzZXFyZXMuZnVsbAoJc2Vj
b25kX2xvZ2ljYWw9JCgoICRmaXJzdF9sb2dpY2FsICsgNDA5NiApKQoJZWNobyAibG9naWNhbCBv
ZiB0aGUgc2Vjb25kIHNlY3RvcjogJHNlY29uZF9sb2dpY2FsIiA+PiAkc2VxcmVzLmZ1bGwKCWZp
cnN0X3BoeXNpY2FsPSQoX2J0cmZzX2dldF9waHlzaWNhbCAkZmlyc3RfbG9naWNhbCAyKQoJZWNo
byAicGh5c2ljYWwgb2YgdGhlIHNlY29uZCBzZWN0b3I6ICRmaXJzdF9waHlzaWNhbCIgPj4gJHNl
cXJlcy5mdWxsCglzZWNvbmRfcGh5c2ljYWw9JChfYnRyZnNfZ2V0X3BoeXNpY2FsICRzZWNvbmRf
bG9naWNhbCAxKQoJZWNobyAicGh5c2ljYWwgb2YgdGhlIHNlY29uZCBzZWN0b3I6ICRzZWNvbmRf
cGh5c2ljYWwiID4+ICRzZXFyZXMuZnVsbAoJc2Vjb25kX2Rldj0kKF9idHJmc19nZXRfZGV2aWNl
X3BhdGggJHNlY29uZF9sb2dpY2FsIDEpCglmaXJzdF9kZXY9JChfYnRyZnNfZ2V0X2RldmljZV9w
YXRoICRmaXJzdF9sb2dpY2FsIDIpCgllY2hvICRmaXJzdF9kZXY+PiRzZXFyZXMuZnVsbAoJZWNo
byAkc2Vjb25kX2Rldj4+JHNlcXJlcy5mdWxsCglfc2NyYXRjaF91bm1vdW50CgkkWEZTX0lPX1BS
T0cgLWMgInB3cml0ZSAtUyAweDAwICRzZWNvbmRfcGh5c2ljYWwgNGsiICRzZWNvbmRfZGV2ID4+
ICRzZXFyZXMuZnVsbAoJJFhGU19JT19QUk9HIC1jICJwd3JpdGUgLVMgMHgwMCAkZmlyc3RfcGh5
c2ljYWwgNGsiICRmaXJzdF9kZXYgPj4gJHNlcXJlcy5mdWxsCglfc2NyYXRjaF9tb3VudAoJJEJU
UkZTX1VUSUxfUFJPRyBzY3J1YiBzdGFydCAtQiAkU0NSQVRDSF9NTlQgJj4gJHRtcC5vdXRwdXQK
CWNhdCAkdG1wLm91dHB1dCA+PiAkc2VxcmVzLmZ1bGwKCV9zY3JhdGNoX3VubW91bnQKCWdyZXAg
IkNvcnJlY3RlZDoiICR0bXAub3V0cHV0IHwgZ3JlcCAiMiIgPj4gJHNlcXJlcy5mdWxsCglpZiAh
IGdyZXAgLXEgImNzdW09MiIgJHRtcC5vdXRwdXQgOyB0aGVuCgkgICAgIGVjaG8gIlNjcnViIGZh
aWxlZCB0byBkZXRlY3QgY29ycnVwdGlvbiIKCWZpCglpZiAgISBncmVwIC1xICJDb3JyZWN0ZWQ6
LioyIiAkdG1wLm91dHB1dCA7IHRoZW4KCSAgICAgZWNobyAiU2NydWIgZmFpbGVkIHRvIGNvcnJl
Y3QgY29ycnVwdGlvbiIKCWZpCglfc2NyYXRjaF9kZXZfcG9vbF9wdXQKfQoKcnVuX3VuY29ycmVj
dF90ZXN0Y2FzZSgpIHsKCUlGUz0nOicgcmVhZCAtcmEgYXJncyA8PDwgJDEKCW51bV9kaXNrcz0k
e2FyZ3NbMF19CgltZXRhZGF0YV90eXBlPSR7YXJnc1sxXX0KCWRhdGFfdHlwZT0ke2FyZ3NbMl19
Cglfc2NyYXRjaF9kZXZfcG9vbF9nZXQgJG51bV9kaXNrcwoJX3NjcmF0Y2hfcG9vbF9ta2ZzICIt
bSRtZXRhZGF0YV90eXBlIC1kJGRhdGFfdHlwZSAtcyA0ayIgPj4gJHNlcXJlcy5mdWxsIDI+JjEK
CV9zY3JhdGNoX21vdW50CgkjIENyZWF0ZSBhIGRhdGEgZXh0ZW50IHdpdGggMiBzZWN0b3JzCgkk
WEZTX0lPX1BST0cgLWZjICJwd3JpdGUgLVMgMHhhYSAwIDhrIiAkU0NSQVRDSF9NTlQvZm9vYmFy
ID4+ICRzZXFyZXMuZnVsbCAyPiYxCglzeW5jCglmaXJzdF9sb2dpY2FsPSQoX2J0cmZzX2dldF9m
aXJzdF9sb2dpY2FsICRTQ1JBVENIX01OVC9mb29iYXIpCgllY2hvICJsb2dpY2FsIG9mIHRoZSBm
aXJzdCBzZWN0b3I6ICRmaXJzdF9sb2dpY2FsIiA+PiAkc2VxcmVzLmZ1bGwKCXNlY29uZF9sb2dp
Y2FsPSQoKCAkZmlyc3RfbG9naWNhbCArIDQwOTYgKSkKCWVjaG8gImxvZ2ljYWwgb2YgdGhlIHNl
Y29uZCBzZWN0b3I6ICRzZWNvbmRfbG9naWNhbCIgPj4gJHNlcXJlcy5mdWxsCglkaXNrX251bT1g
ZXhwciAwKyRudW1fZGlza3NgCglmb3IgKChpPTA7IGk8JGRpc2tfbnVtOyBpICsrKSkKCWRvCgkJ
cGh5c2ljYWw9JChfYnRyZnNfZ2V0X3BoeXNpY2FsICRzZWNvbmRfbG9naWNhbCAkWyRpKzFdKQoJ
CWVjaG8gInBoeXNpY2FsIG9mIHRoZSBzZWNvbmQgc2VjdG9yOiAkcGh5c2ljYWwiID4+ICRzZXFy
ZXMuZnVsbAoJCWRldj0kKF9idHJmc19nZXRfZGV2aWNlX3BhdGggJHNlY29uZF9sb2dpY2FsICRb
JGkrMV0pCgkJZWNobyAkZGV2Pj4kc2VxcmVzLmZ1bGwKCQlfc2NyYXRjaF91bm1vdW50CgkJJFhG
U19JT19QUk9HIC1jICJwd3JpdGUgLVMgMHgwMCAkcGh5c2ljYWwgNGsiICRkZXYgPj4gJHNlcXJl
cy5mdWxsCgkJX3NjcmF0Y2hfbW91bnQKCWRvbmUKCSRCVFJGU19VVElMX1BST0cgc2NydWIgc3Rh
cnQgLUIgJFNDUkFUQ0hfTU5UICY+ICR0bXAub3V0cHV0CgljYXQgJHRtcC5vdXRwdXQgPj4gJHNl
cXJlcy5mdWxsCglfc2NyYXRjaF91bm1vdW50CglpZiAhIGdyZXAgLXEgImNzdW09JG51bV9kaXNr
cyIgJHRtcC5vdXRwdXQgOyB0aGVuCgkgICAgIGVjaG8gIlNjcnViIGZhaWxlZCB0byBkZXRlY3Qg
Y29ycnVwdGlvbiIKCWZpCglpZiAgISBncmVwIC1xICJVbmNvcnJlY3RhYmxlOi4qJG51bV9kaXNr
cyIgJHRtcC5vdXRwdXQgOyB0aGVuCgkgICAgIGVjaG8gIlNjcnViIGZhaWxlZCBvbiB1bmNvcnJl
Y3QgY29ycnVwdGlvbiIKCWZpCglfc2NyYXRjaF9kZXZfcG9vbF9wdXQKfQoKI2NvcnJlY3RhYmxl
IGNoZWNrc3VtIGVycm9yIHJhaWQxCmZvciBpIGluICIke1RFU1RfVkVDVE9SU19XSVRITUlSUk9S
W0BdfSI7IGRvCglydW5fY29ycmVjdF90ZXN0Y2FzZSAkaQpkb25lCgojdW5jb3JyZWN0YWJsZSBj
aGVja3N1bSBlcnJvciByYWlkMQpmb3IgaSBpbiAiJHtURVNUX1ZFQ1RPUlNfV0lUSE1JUlJPUltA
XX0iOyBkbwoJcnVuX3VuY29ycmVjdF90ZXN0Y2FzZSAkaQpkb25lCgplY2hvICJTaWxlbmNlIGlz
IGdvbGRlbiIKc3RhdHVzPTAKZXhpdAoK
--00000000000060239a05ed5be61c
Content-Type: application/octet-stream; name=raid6test
Content-Disposition: attachment; filename=raid6test
Content-Transfer-Encoding: base64
Content-ID: <f_lafismw31>
X-Attachment-Id: f_lafismw31

IyEgL2Jpbi9iYXNoCiMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIyBDb3B5cmln
aHQgKGMpIDIwMTcgT3JhY2xlLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4KIwojIEZTIFFBIFRlc3Qg
MTU4CiMKIyBUaGUgdGVzdCBjYXNlIGlzIGNoZWNrIGlmIHNjcnViIGlzIGFibGUgZml4IHJhaWQ2
IGRhdGEgY29ycnVwdGlvbiwKIyBpZS4gaWYgdGhlcmUgaXMgZGF0YSBjb3JydXB0aW9uIG9uIHR3
byBkaXNrcyBpbiB0aGUgc2FtZSBob3Jpem9udGFsCiMgc3RyaXBlLCBlLmcuICBkdWUgdG8gYml0
cm90LgojCiMgVGhlIGtlcm5lbCBmaXhlcyBhcmUKIwlCdHJmczogbWFrZSByYWlkNiByZWJ1aWxk
IHJldHJ5IG1vcmUKIwlCdHJmczogZml4IHNjcnViIHRvIHJlcGFpciByYWlkNiBjb3JydXB0aW9u
CiMKLiAuL2NvbW1vbi9wcmVhbWJsZQpfYmVnaW5fZnN0ZXN0IGF1dG8gcXVpY2sgcmFpZCBzY3J1
YgoKIyBJbXBvcnQgY29tbW9uIGZ1bmN0aW9ucy4KLiAuL2NvbW1vbi9maWx0ZXIKCiMgcmVhbCBR
QSB0ZXN0IHN0YXJ0cyBoZXJlCgojIE1vZGlmeSBhcyBhcHByb3ByaWF0ZS4KX3N1cHBvcnRlZF9m
cyBidHJmcwpfcmVxdWlyZV9zY3JhdGNoX2Rldl9wb29sIDQKX3JlcXVpcmVfYnRyZnNfY29tbWFu
ZCBpbnNwZWN0LWludGVybmFsIGR1bXAtdHJlZQpfcmVxdWlyZV9idHJmc19mc19mZWF0dXJlIHJh
aWQ1NgoKZ2V0X3BoeXNpY2FsKCkKewoJbG9jYWwgc3RyaXBlPSQxCgkkQlRSRlNfVVRJTF9QUk9H
IGluc3BlY3QtaW50ZXJuYWwgZHVtcC10cmVlIC10IDMgJFNDUkFUQ0hfREVWIHwgXAoJCWdyZXAg
IiBEQVRBXHxSQUlENiIgLUEgMTAgfCBcCgkJJEFXS19QUk9HICIoXCQxIH4gL3N0cmlwZS8gJiYg
XCQzIH4gL2RldmlkLyAmJiBcJDIgfiAvJHN0cmlwZS8pIHsgcHJpbnQgXCQ2IH0iCn0KCmdldF9k
ZXZpZCgpCnsKCWxvY2FsIHN0cmlwZT0kMQoJJEJUUkZTX1VUSUxfUFJPRyBpbnNwZWN0LWludGVy
bmFsIGR1bXAtdHJlZSAtdCAzICRTQ1JBVENIX0RFViB8IFwKCQlncmVwICIgREFUQVx8UkFJRDYi
IC1BIDEwIHwgXAoJCSRBV0tfUFJPRyAiKFwkMSB+IC9zdHJpcGUvICYmIFwkMyB+IC9kZXZpZC8g
JiYgXCQyIH4gLyRzdHJpcGUvKSB7IHByaW50IFwkNCB9Igp9CgpnZXRfZGV2aWNlX3BhdGgoKQp7
Cglsb2NhbCBkZXZpZD0kMQoJZWNobyAiJFNDUkFUQ0hfREVWX1BPT0wiIHwgJEFXS19QUk9HICJ7
cHJpbnQgXCQkZGV2aWR9Igp9Cgpfc2NyYXRjaF9kZXZfcG9vbF9nZXQgNAojIHN0ZXAgMTogY3Jl
YXRlIGEgcmFpZDYgYnRyZnMgYW5kIGNyZWF0ZSBhIDEyOEsgZmlsZQplY2hvICJzdGVwIDEuLi4u
Li5ta2ZzLmJ0cmZzIiA+PiRzZXFyZXMuZnVsbAoKX2NoZWNrX21pbmltYWxfZnNfc2l6ZSAkKCgg
MTAyNCAqIDEwMjQgKiAxMDI0ICkpCm1rZnNfb3B0cz0iLWQgcmFpZDYgLWIgMUciCl9zY3JhdGNo
X3Bvb2xfbWtmcyAkbWtmc19vcHRzID4+JHNlcXJlcy5mdWxsIDI+JjEKCiMgbWFrZSBzdXJlIGRh
dGEgaXMgd3JpdHRlbiB0byB0aGUgc3RhcnQgcG9zaXRpb24gb2YgdGhlIGRhdGEgY2h1bmsKX3Nj
cmF0Y2hfbW91bnQgJChfYnRyZnNfbm9fdjFfY2FjaGVfb3B0KQoKIyBbMCw2NEspIGlzIHdyaXR0
ZW4gdG8gc3RyaXBlIDAgYW5kIFs2NEssIDEyOEspIGlzIHdyaXR0ZW4gdG8gc3RyaXBlIDEKJFhG
U19JT19QUk9HIC1mIC1kIC1jICJwd3JpdGUgLVMgMHhhYSAwIDEyOEsiIC1jICJmc3luYyIgXAoJ
IiRTQ1JBVENIX01OVC9mb29iYXIiICA+PiAkc2VxcmVzLmZ1bGwKCl9zY3JhdGNoX3VubW91bnQK
CnBoeTA9JChnZXRfcGh5c2ljYWwgMCkKZGV2aWQwPSQoZ2V0X2RldmlkIDApCmRldnBhdGgwPSQo
Z2V0X2RldmljZV9wYXRoICRkZXZpZDApCnBoeTE9JChnZXRfcGh5c2ljYWwgMSkKZGV2aWQxPSQo
Z2V0X2RldmlkIDEpCmRldnBhdGgxPSQoZ2V0X2RldmljZV9wYXRoICRkZXZpZDEpCnBoeTI9JChn
ZXRfcGh5c2ljYWwgMikKZGV2aWQyPSQoZ2V0X2RldmlkIDIpCmRldnBhdGgyPSQoZ2V0X2Rldmlj
ZV9wYXRoICRkZXZpZDIpCgojIHN0ZXAgMjogY29ycnVwdCB0aGUgMXN0IGFuZCAybmQgc3RyaXBl
IChzdHJpcGUgMCBhbmQgMSkKZWNobyAic3RlcCAyLi4uLi4uc2ltdWxhdGUgYml0cm90IGF0OiIg
Pj4kc2VxcmVzLmZ1bGwKZWNobyAiICAgICAgLi4uLi4uc3RyaXBlICMwOiBkZXZpZCAkZGV2aWQw
IGRldnBhdGggJGRldnBhdGgwIHBoeSAkcGh5MCIgXAoJPj4kc2VxcmVzLmZ1bGwKZWNobyAiICAg
ICAgLi4uLi4uc3RyaXBlICMxOiBkZXZpZCAkZGV2aWQxIGRldnBhdGggJGRldnBhdGgxIHBoeSAk
cGh5MSIgXAoJPj4kc2VxcmVzLmZ1bGwKZWNobyAiICAgICAgLi4uLi4uc3RyaXBlICMyOiBkZXZp
ZCAkZGV2aWQyIGRldnBhdGggJGRldnBhdGgyIHBoeSAkcGh5MiIgXAoJPj4kc2VxcmVzLmZ1bGwK
CiRYRlNfSU9fUFJPRyAtZiAtZCAtYyAicHdyaXRlIC1TIDB4YmIgJHBoeTAgNjRLIiAkZGV2cGF0
aDAgPiAvZGV2L251bGwKJFhGU19JT19QUk9HIC1mIC1kIC1jICJwd3JpdGUgLVMgMHhiYiAkcGh5
MSA2NEsiICRkZXZwYXRoMSA+IC9kZXYvbnVsbAokWEZTX0lPX1BST0cgLWYgLWQgLWMgInB3cml0
ZSAtUyAweGJiICRwaHkyIDY0SyIgJGRldnBhdGgyID4gL2Rldi9udWxsCgojIHN0ZXAgMzogc2Ny
dWIgZmlsZXN5c3RlbSB0byByZXBhaXIgdGhlIGJpdHJvdAplY2hvICJzdGVwIDMuLi4uLi5yZXBh
aXIgdGhlIGJpdHJvdCIgPj4gJHNlcXJlcy5mdWxsCl9zY3JhdGNoX21vdW50ICQoX2J0cmZzX25v
X3YxX2NhY2hlX29wdCkKCiRCVFJGU19VVElMX1BST0cgc2NydWIgc3RhcnQgLUIgJFNDUkFUQ0hf
TU5UID4gJHRtcC5vdXRwdXQgMj4mMQpjYXQgJHRtcC5vdXRwdXQgPj4gJHNlcXJlcy5mdWxsCgpp
ZiAhIGdyZXAgLXEgImNzdW09OTYiICR0bXAub3V0cHV0IDsgdGhlbgoJZWNobyAiU2NydWIgZmFp
bGVkIHRvIGRldGVjdCBjb3JydXB0aW9uIgpmaQoKaWYgISBncmVwIC1xICJyZWFkPTMyIiAkdG1w
Lm91dHB1dCA7IHRoZW4KCWVjaG8gIlNjcnViIGZhaWxlZCB0byBkZXRlY3QgY29ycnVwdGlvbiIK
ZmkKCmlmICAhIGdyZXAgLXEgIlVuY29ycmVjdGFibGU6LioxMjgiICR0bXAub3V0cHV0IDsgdGhl
bgoJZWNobyAiU2NydWIgZmFpbGVkIG9uIHVuY29ycmVjdCBjb3JydXB0aW9uIgpmaQoKX3NjcmF0
Y2hfZGV2X3Bvb2xfcHV0CgojIHN1Y2Nlc3MsIGFsbCBkb25lCmVjaG8gIlNpbGVuY2UgaXMgZ29s
ZGVuIgpzdGF0dXM9MApleGl0Cg==
--00000000000060239a05ed5be61c--
