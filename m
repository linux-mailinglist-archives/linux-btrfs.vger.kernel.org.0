Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873116730CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 05:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjASE4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Jan 2023 23:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjASEzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Jan 2023 23:55:31 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808047080
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 20:46:59 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t7-20020a05683014c700b006864760b1caso625218otq.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jan 2023 20:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAgJbabPP5pugIP78d9wtyoXpq7ikX5KT39ij1uK1wk=;
        b=mmGBu9wSntAexOJpj4garPSP7mbWS+AtunHwtDFtDF7BMFFesPn0xpYuThBnT/YA7z
         1BwOQBBFcVKXgj8MHS3S75LLtAzVXvbrIoZR7VQ+lAlt41hi9y6qgqcL+W/H2FsQtDaI
         oech+UZsNC+irHkoFOuH801RbE/o1vb9ScLgh/laaAWZY25X1lFgd89b5vqUNcWG6lrl
         U35fjvoC9mb0Jsgl429wBx10CwH9KG4N//bpRZ8rj809Kvk0my1cnfg/6juKdWjAmlKF
         ZZBIyB97dkEN2OG5BuoDSlvUpZdnJZVMtF3UJ1U7D6vygCKssmUeGP8+3zxr3jyuTq+D
         v8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAgJbabPP5pugIP78d9wtyoXpq7ikX5KT39ij1uK1wk=;
        b=2PdduseCC9pBamvkAHEGc6kYeapmEgSlzfXA6Efb0EkqDvFeT95xLa5nniX/GicS8W
         jKdHV9wC7mFhLdLFIkTVdKXbt5NpY07/cxP1S793JVtN8Ocwt6BJMox2WsnC7CCXb5Ka
         DMIei6WqBaHOjwVb6W1oO3Bd9fpqZdHeRZXaHIfvY8SqoloLgC779sqWHGqeyhaz/S3u
         WJdtoKIOh2NowymlDf71WPvmmPvxGboxHA8et/rBxSLoM7eEHqI2vaRjeHlN38zko/uU
         368dpHnrLi8+IUG1ElLS+jrz1wvXHVVBnrSJPiHNo+WYpqmW/+9IWOCMo8/rryHrh64u
         /+FQ==
X-Gm-Message-State: AFqh2koiNk2cIMdQ7ojeFEWJzQ2KcHDp1MmlGtn6qHMUNCFgpA69F2pT
        C1HlL6XasI/MAqvhWV4797zkWobrMR1+gRqXohVCrADWzSZEGA==
X-Google-Smtp-Source: AMrXdXs1f711+N77KQuRVT2v607GlnqceXo3ljT7gP6GmwyhnMlB3ad5IIrxs9yMAQqncyA2MhEeumLttp8rq2qVvTU=
X-Received: by 2002:a9d:6a98:0:b0:686:4f61:d660 with SMTP id
 l24-20020a9d6a98000000b006864f61d660mr401415otq.144.1674103618156; Wed, 18
 Jan 2023 20:46:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673851704.git.wqu@suse.com> <8bae193cad8c35dc1b861af03d66b202c5bf8ead.1673851704.git.wqu@suse.com>
In-Reply-To: <8bae193cad8c35dc1b861af03d66b202c5bf8ead.1673851704.git.wqu@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Thu, 19 Jan 2023 12:46:47 +0800
Message-ID: <CAAa-AGkqVTk7bOGpTmp+yr1S=mZ2Zw5vYQ0kR9sK73JwJx24fg@mail.gmail.com>
Subject: Re: [PATCH 03/11] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <wqu@suse.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8816=E6=97=A5=E5=91=
=A8=E4=B8=80 15:06=E5=86=99=E9=81=93=EF=BC=9A
>
> There is really no need to go through the super complex scrub_sectors()
> to just handle super blocks.
>
> This patch will introduce a dedicated function (less than 50 lines) to
> handle super block scrubing.
>
> This new function will introduce a behavior change, instead of using the
> complex but concurrent scrub_bio system, here we just go
> submit-and-wait.
>
> There is really not much sense to care the performance of super block
> scrubbing. It only has 3 super blocks at most, and they are all scattered
> around the devices already.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 288d7e2a6cdf..e554a9904d2a 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4143,18 +4143,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>         return ret;
>  }
>
> +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *=
dev,
> +                          struct page *page, u64 physical, u64 generatio=
n)
> +{
> +       struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> +       struct bio_vec bvec;
> +       struct bio bio;
> +       struct btrfs_super_block *sb =3D page_address(page);
> +       int ret;
> +
> +       bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> +       bio.bi_iter.bi_sector =3D physical >> SECTOR_SHIFT;
> +       bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> +       ret =3D submit_bio_wait(&bio);
> +       bio_uninit(&bio);
> +
> +       if (ret < 0)
> +               return ret;
> +       ret =3D btrfs_check_super_csum(fs_info, sb);
> +       if (ret !=3D 0) {
> +               btrfs_err_rl(fs_info,
> +                       "super block at physical %llu devid %llu has bad =
csum",
> +                       physical, dev->devid);
> +               return -EIO;
> +       }
> +       if (btrfs_super_generation(sb) !=3D generation) {
> +               btrfs_err_rl(fs_info,
> +"super block at physical %llu devid %llu has bad generation, has %llu ex=
pect %llu",
> +                            physical, dev->devid,
> +                            btrfs_super_generation(sb), generation);
> +               return -EUCLEAN;
> +       }
> +
> +       ret =3D btrfs_validate_super(fs_info, sb, -1);
> +       return ret;
> +}
> +
>  static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>                                            struct btrfs_device *scrub_dev=
)
>  {
>         int     i;
>         u64     bytenr;
>         u64     gen;
> -       int     ret;
> +       int     ret =3D 0;
> +       struct page *page;
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>
>         if (BTRFS_FS_ERROR(fs_info))
>                 return -EROFS;
>
> +       page =3D alloc_page(GFP_KERNEL);

Does this page need to be freed?


> +       if (!page)
> +               return -ENOMEM;
> +
>         /* Seed devices of a new filesystem has their own generation. */
>         if (scrub_dev->fs_devices !=3D fs_info->fs_devices)
>                 gen =3D scrub_dev->generation;
> @@ -4169,15 +4210,11 @@ static noinline_for_stack int scrub_supers(struct=
 scrub_ctx *sctx,
>                 if (!btrfs_check_super_location(scrub_dev, bytenr))
>                         continue;
>
> -               ret =3D scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE=
, bytenr,
> -                                   scrub_dev, BTRFS_EXTENT_FLAG_SUPER, g=
en, i,
> -                                   NULL, bytenr);
> +               ret =3D scrub_one_super(sctx, scrub_dev, page, bytenr, ge=
n);
>                 if (ret)
> -                       return ret;
> +                       break;
>         }
> -       wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) =
=3D=3D 0);
> -
> -       return 0;
> +       return ret;
>  }
>
>  static void scrub_workers_put(struct btrfs_fs_info *fs_info)
> --
> 2.39.0
>

thanks
Li
