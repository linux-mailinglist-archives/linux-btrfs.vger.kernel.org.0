Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000F61F7FE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiKGPyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 10:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKGPyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 10:54:15 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B807C39B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:54:13 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13ae8117023so13103482fac.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtcEQASsLnYO4FIot12b8jjQMtdQICzjrsUCP55F4us=;
        b=MyB9DbemPI50zxaCzaRkaOsn6HMpiOTIaI6yTnCqn9Po35EmZs3Ay1yKwCTNRwQuqt
         cvI+kiZPJE8/Xr+5sm+X/yRrARVynyB3l5f9B42emCSiGYQJgQ7jsqEKjZjxyyaYOlcK
         m/PTaZ1lsbkJE1L1ScFZCGannr+FHHdKX90dAJNDB8rbpRQx7Bf9CIgIYArdn4+Tfid4
         4mm64t1tkdz2ZZpuSg8k4ywkkLiER3cH2cqVecvIoSrk6oyNUetVc9nDIAeQCPdVuA1X
         jR7bMm2GMhjkPDVn2MPJoBTuoQTBVmQeIY6sNwirz8cHxZc0aLeoAQMB/+z1hK+aPypl
         E7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtcEQASsLnYO4FIot12b8jjQMtdQICzjrsUCP55F4us=;
        b=tF6+545+P73tsMwysaxc6zqtZCUjzTzsG4EMg2fQWA8ac3Ra9emNERC0z2VI7jDVav
         0ml0getU8bgA7B6uadnBjg3bVAupyNa3XZZVOBIiSVX/vnVGpYV3bpOR/WiXJi6mLMlh
         Fw/EZyeW73tXpJ+Lgyy8f5wnKkT0IV+QfRSu1B3SHbhyiJkzJgyyt7mEBzklPyOvz58k
         19Gk35fEanbchmmhYBV9+yx6TVKn3xaVArsI3FwxiwSp/EkNhxXarRtMZcEsBizRNxgO
         xqayjVcbmw+sC6akoVuGGDWpEvmDz20fIiqq4fPJWcPO/tUX/+DdXWIwF+VN8/7/ykX1
         q5kQ==
X-Gm-Message-State: ACrzQf2C1C+70v2jMMz6QXiPAhj5DQ7DTWHN1wsNKC5gyVBYOQsE6BZi
        aPYeF8QCSw0awCRVOKZow/F5h1pdAFH4SoPfRgwXegbw
X-Google-Smtp-Source: AMsMyM6zC9bLXox0WftNJHJSx4mJjbTiMItDqwnR3U7ZatOIdjGlPGCeSBGpDuKcbkALybzWI/VGnvsJnS4bk5tbVVc=
X-Received: by 2002:a05:6870:c105:b0:12c:8f0c:e23c with SMTP id
 f5-20020a056870c10500b0012c8f0ce23cmr29465629oad.42.1667836452926; Mon, 07
 Nov 2022 07:54:12 -0800 (PST)
MIME-Version: 1.0
References: <1667745304-11470-1-git-send-email-zhanglikernel@gmail.com> <b748d106-4a20-0c33-8e87-dfa6de0b281a@gmx.com>
In-Reply-To: <b748d106-4a20-0c33-8e87-dfa6de0b281a@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Mon, 7 Nov 2022 23:54:01 +0800
Message-ID: <CAAa-AG=KicjfqUr4Ck4fXw3y2o8DXzz0s2YCMovnF5VESYOmdQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: fix failed to detect checksum error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
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

Yes, I agree.
Would begin to work on it

Thanks,
Li

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 06:57=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/11/6 22:35, Li Zhang wrote:
> > [bug]
> > Scrub fails to detect checksum errors
> > To reproduce the problem:
> >
> > $ truncate -s 250M loop_dev1
> > $ truncate -s 250M loop_dev2
> > $ losetup /dev/loop1 loop_dev1
> > $ losetup /dev/loop2 loop_dev2
> > $ mkfs.btrfs -mraid1 -draid1 /dev/loop1 /dev/loop2 -f
> > $ mount /dev/loop1 /mnt/
> > $ cp ~/btrfs/btrfs-progs/mkfs/main.c /mnt/
> >
> > $ vim -b loop_dev1
> >
> > ....
> >           free(label);
> >           free(source_dir);
> >           exit(1);
> > success:
> >           exit(0);
> > }zhangli
> >
> > ....
> >
> > $ sudo btrfs scrub start /mnt/
> > fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scru=
b.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
> > scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=
=3D9894)
> >
> > $ sudo btrfs scrub status /mnt/
> > UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
> > Scrub started:    Sun Nov  6 21:51:50 2022
> > Status:           finished
> > Duration:         0:00:00
> > Total to scrub:   392.00KiB
> > Rate:             0.00B/s
> > Error summary:    no errors found
> >
> > [reason]
> > Because scrub only checks the first sector (scrub_sector) of
> > the sblock (scrub_block), it does not check other sectors.
>
> That's caused by commit 786672e9e1a3 ("btrfs: scrub: use larger block
> size for data extent scrub"), which enlarged data scrub extent size
> (previously always sectorsize, thus there will only be one sector per
> scrub_block, thus it always works before that commit).
>
> I'd prefer a revert before we have better fix.
>
> >
> > [implementation]
> > 1. Move the set sector (scrub_sector) csum from scrub_extent
> > to scrub_sectors, since each sector has an independent checksum.
> > 2. In the scrub_checksum_data function, check all
> > sectors in the sblock.
> > 3. In the scrub_setup_recheck_block function,
> > use sector_index to set the sector csum.
> >
> > [test]
> > The test method is the same as the problem reproduction.
> > Can detect checksum errors and fix checksum errors
> > Below is the scrub output.
> >
> > $ sudo btrfs scrub start /mnt/
> > fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scru=
b.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
> > scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=
=3D11089)
> > $ sudo btrfs scrub status /mnt/WARNING: errors detected during scrubbin=
g, corrected
> >
> > UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
> > Scrub started:    Sun Nov  6 22:15:02 2022
> > Status:           finished
> > Duration:         0:00:00
> > Total to scrub:   392.00KiB
> > Rate:             0.00B/s
> > Error summary:    csum=3D1
> >    Corrected:      1
> >    Uncorrectable:  0
> >    Unverified:     0
> >
> > Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> > ---
> > Issue: 537
> >
> >   fs/btrfs/scrub.c | 58 ++++++++++++++++++++++++++++-------------------=
---------
> >   1 file changed, 29 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index f260c53..56ee600 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -404,7 +404,7 @@ static int scrub_write_sector_to_dev_replace(struct=
 scrub_block *sblock,
> >   static void scrub_parity_put(struct scrub_parity *sparity);
> >   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len=
,
> >                        u64 physical, struct btrfs_device *dev, u64 flag=
s,
> > -                      u64 gen, int mirror_num, u8 *csum,
> > +                      u64 gen, int mirror_num,
> >                        u64 physical_for_dev_replace);
> >   static void scrub_bio_end_io(struct bio *bio);
> >   static void scrub_bio_end_io_worker(struct work_struct *work);
> > @@ -420,6 +420,8 @@ static int scrub_add_sector_to_wr_bio(struct scrub_=
ctx *sctx,
> >   static void scrub_wr_bio_end_io(struct bio *bio);
> >   static void scrub_wr_bio_end_io_worker(struct work_struct *work);
> >   static void scrub_put_ctx(struct scrub_ctx *sctx);
> > +static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *cs=
um);
> > +
>
> I don't think this is the way to go, since we can have a extent up to
> STRIPE_LEN, going csum search again and again is not the proper way to go=
.
>
> We need a function to grab a batch of csum in just one go.
>
> >
> >   static inline int scrub_is_page_on_raid56(struct scrub_sector *sector=
)
> >   {
> > @@ -1516,7 +1518,7 @@ static int scrub_setup_recheck_block(struct scrub=
_block *original_sblock,
> >                       sector->have_csum =3D have_csum;
> >                       if (have_csum)
> >                               memcpy(sector->csum,
> > -                                    original_sblock->sectors[0]->csum,
> > +                                    original_sblock->sectors[sector_in=
dex]->csum,
> >                                      sctx->fs_info->csum_size);
> >
> >                       scrub_stripe_index_and_offset(logical,
> > @@ -1984,21 +1986,22 @@ static int scrub_checksum_data(struct scrub_blo=
ck *sblock)
> >       u8 csum[BTRFS_CSUM_SIZE];
> >       struct scrub_sector *sector;
> >       char *kaddr;
> > +     int i;
> >
> >       BUG_ON(sblock->sector_count < 1);
> > -     sector =3D sblock->sectors[0];
> > -     if (!sector->have_csum)
> > -             return 0;
> > -
> > -     kaddr =3D scrub_sector_get_kaddr(sector);
> >
> >       shash->tfm =3D fs_info->csum_shash;
> >       crypto_shash_init(shash);
> > +     for (i =3D 0; i < sblock->sector_count; i++) {
> > +             sector =3D sblock->sectors[i];
> > +             if (!sector->have_csum)
> > +                     continue;
> >
> > -     crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> > -
> > -     if (memcmp(csum, sector->csum, fs_info->csum_size))
> > -             sblock->checksum_error =3D 1;
> > +             kaddr =3D scrub_sector_get_kaddr(sector);
> > +             crypto_shash_digest(shash, kaddr, fs_info->sectorsize, cs=
um);
> > +             if (memcmp(csum, sector->csum, fs_info->csum_size))
> > +                     sblock->checksum_error =3D 1;
>
> That would only increase checksum error by 1, but we may have multiple
> corruptions in that extent.
>
> This hotfix is going to screw up scrub error reporting.
>
> Thanks,
> Qu
> > +     }
> >       return sblock->checksum_error;
> >   }
> >
> > @@ -2400,12 +2403,14 @@ static void scrub_missing_raid56_pages(struct s=
crub_block *sblock)
> >
> >   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len=
,
> >                      u64 physical, struct btrfs_device *dev, u64 flags,
> > -                    u64 gen, int mirror_num, u8 *csum,
> > +                    u64 gen, int mirror_num,
> >                      u64 physical_for_dev_replace)
> >   {
> >       struct scrub_block *sblock;
> >       const u32 sectorsize =3D sctx->fs_info->sectorsize;
> >       int index;
> > +     u8 csum[BTRFS_CSUM_SIZE];
> > +     int have_csum;
> >
> >       sblock =3D alloc_scrub_block(sctx, dev, logical, physical,
> >                                  physical_for_dev_replace, mirror_num);
> > @@ -2424,7 +2429,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, =
u64 logical, u32 len,
> >                * more memory for PAGE_SIZE > sectorsize case.
> >                */
> >               u32 l =3D min(sectorsize, len);
> > -
> >               sector =3D alloc_scrub_sector(sblock, logical, GFP_KERNEL=
);
> >               if (!sector) {
> >                       spin_lock(&sctx->stat_lock);
> > @@ -2435,11 +2439,16 @@ static int scrub_sectors(struct scrub_ctx *sctx=
, u64 logical, u32 len,
> >               }
> >               sector->flags =3D flags;
> >               sector->generation =3D gen;
> > -             if (csum) {
> > -                     sector->have_csum =3D 1;
> > -                     memcpy(sector->csum, csum, sctx->fs_info->csum_si=
ze);
> > -             } else {
> > -                     sector->have_csum =3D 0;
> > +             if (flags & BTRFS_EXTENT_FLAG_DATA) {
> > +                     /* push csums to sbio */
> > +                     have_csum =3D scrub_find_csum(sctx, logical, csum=
);
> > +                     if (have_csum =3D=3D 0) {
> > +                             ++sctx->stat.no_csum;
> > +                             sector->have_csum =3D 0;
> > +                     } else {
> > +                             sector->have_csum =3D 1;
> > +                             memcpy(sector->csum, csum, sctx->fs_info-=
>csum_size);
> > +                     }
> >               }
> >               len -=3D l;
> >               logical +=3D l;
> > @@ -2669,7 +2678,6 @@ static int scrub_extent(struct scrub_ctx *sctx, s=
truct map_lookup *map,
> >       u64 src_physical =3D physical;
> >       int src_mirror =3D mirror_num;
> >       int ret;
> > -     u8 csum[BTRFS_CSUM_SIZE];
> >       u32 blocksize;
> >
> >       /*
> > @@ -2715,17 +2723,9 @@ static int scrub_extent(struct scrub_ctx *sctx, =
struct map_lookup *map,
> >                                    &src_dev, &src_mirror);
> >       while (len) {
> >               u32 l =3D min(len, blocksize);
> > -             int have_csum =3D 0;
> > -
> > -             if (flags & BTRFS_EXTENT_FLAG_DATA) {
> > -                     /* push csums to sbio */
> > -                     have_csum =3D scrub_find_csum(sctx, logical, csum=
);
> > -                     if (have_csum =3D=3D 0)
> > -                             ++sctx->stat.no_csum;
> > -             }
> >               ret =3D scrub_sectors(sctx, logical, l, src_physical, src=
_dev,
> >                                   flags, gen, src_mirror,
> > -                                 have_csum ? csum : NULL, physical);
> > +                                 physical);
> >               if (ret)
> >                       return ret;
> >               len -=3D l;
> > @@ -4155,7 +4155,7 @@ static noinline_for_stack int scrub_supers(struct=
 scrub_ctx *sctx,
> >
> >               ret =3D scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE=
, bytenr,
> >                                   scrub_dev, BTRFS_EXTENT_FLAG_SUPER, g=
en, i,
> > -                                 NULL, bytenr);
> > +                                 bytenr);
> >               if (ret)
> >                       return ret;
> >       }
