Return-Path: <linux-btrfs+bounces-5005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E218C6463
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AA81C217AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9F5A4CD;
	Wed, 15 May 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBH8twmj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423264EB20
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767185; cv=none; b=Adgcx83NTBOsV7sXtqyAICnlNu640Zj7ecADoKvHbemfst8yAp1GMpJVsPP3c0ZM7aCrJxoGr8t+/96oD9N2b1CB+JtKQvMfIKU7YTTcg4asusE34fVjx06fmRAS7dDIYNWpq8IawKPu75BauuSTONk3SptM34JcmiW41oI211g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767185; c=relaxed/simple;
	bh=NTyDp3IH9FfeB3JFs55RWq9jxAKNbu20+0mmSg5xo0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRKbSh5lfjaDmHdlmKu/TRIBsf2efeuBwYjU1RzWqKtRt/QOiCZISscoZoahLBso34GmBBixAdWaDkHI3cRgDzfhXcshhB6cz2KCRVZd20NqrVyCotu0Yzv8Hy4YAwjQJiba9BsvWkH32UYbqJbti90qqvYv64lL51meK3F1jJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBH8twmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCBAC116B1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715767184;
	bh=NTyDp3IH9FfeB3JFs55RWq9jxAKNbu20+0mmSg5xo0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBH8twmjWHeYefNadQG7moPpWJh11DGWB5EOwdMS6fz49vY4buIyweYsvn/6XOVY2
	 k3Q6dE262T1cJZH6dpO/3xfHoK+rZI1xmf//susMluIELQ3Ct3OpQHBayysQcNoAr3
	 Qx6rB9CzN1ljnhmBjgiUTP1/8tbXXKpLdOTHeUsdOD3PHK4ozPu7Zt4fDlOLM+a0gG
	 c8t2AxfIqShwVY9rdlPzYx8gSNSrswqQCAHTbwaqHq+2sCIDq50+5QoEhcfDVIev7V
	 ITzjSYkjz2hE6jJ/gzKwvxkaS98TNUmrxL2bt9qeE/hA1IAgg432PanOb7AZnGd4gs
	 HpUEyHIU7xvlg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-574d1a1c36aso1507115a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 02:59:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHvLjdrF+Yjf0feAkB2HrCTQdxF8FEdyqEfgGsH6XHTGOKbu1P
	S166O2r4Fs0nRsPBMclz49raQf4/5wTdhepdonz0bKunsDLLCafJC0XW4Shm5tiGwu6eSuLFfN3
	SwpqtOgQFSYpawJ0kACCvJMmQ87U=
X-Google-Smtp-Source: AGHT+IFWHOmpM1JdPsbLHGtGEq/PvfYR+qzFXrCgzbxOvWmnOxDloYWOsnu6k4j9eMcUUchtj0+/srB3G+xUsnCwD7I=
X-Received: by 2002:a17:906:6882:b0:a5a:76e2:c2a8 with SMTP id
 a640c23a62f3a-a5a76e2c306mr440941466b.23.1715767183346; Wed, 15 May 2024
 02:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
In-Reply-To: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 15 May 2024 10:59:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4X5pah5hyMXBK4kJ+ZTPbi=-_FnGU4=Pun9Uqfp4YMcg@mail.gmail.com>
Message-ID: <CAL3q7H4X5pah5hyMXBK4kJ+ZTPbi=-_FnGU4=Pun9Uqfp4YMcg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: raid56: do extra dumping for CONFIG_BTRFS_ASSERT
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 4:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There are several hard-to-hit ASSERT()s hit inside raid56.
> Unfortunately the ASSERT() expression is a little complex, and except
> the ASSERT(), there is nothing to provide any clue.
>
> Considering if race is involved, it's pretty hard to reproduce.
> Meanwhile sometimes the dump of the rbio structure can provide some
> pretty good clues, it's worthy to do the extra multi-line dump for
> btrfs raid56 related code.
>
> The dump looks like this:
>
>  BTRFS critical (device dm-3): bioc logical=3D4598530048 full_stripe=3D45=
98530048 size=3D0 map_type=3D0x81 mirror=3D0 replace_nr_stripes=3D0 replace=
_stripe_src=3D-1 num_stripes=3D5
>  BTRFS critical (device dm-3):     nr=3D0 devid=3D1 physical=3D1166147584
>  BTRFS critical (device dm-3):     nr=3D1 devid=3D2 physical=3D1145176064
>  BTRFS critical (device dm-3):     nr=3D2 devid=3D4 physical=3D1145176064
>  BTRFS critical (device dm-3):     nr=3D3 devid=3D5 physical=3D1145176064
>  BTRFS critical (device dm-3):     nr=3D4 devid=3D3 physical=3D1145176064
>  BTRFS critical (device dm-3): rbio flags=3D0x0 nr_sectors=3D80 nr_data=
=3D4 real_stripes=3D5 stripe_nsectors=3D16 scrubp=3D0 dbitmap=3D0x0
>  BTRFS critical (device dm-3): logical=3D4598530048
>  assertion failed: orig_logical >=3D full_stripe_start && orig_logical + =
orig_len <=3D full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/b=
trfs/raid56.c:1702
>  ------------[ cut here ]------------
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c | 113 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 100 insertions(+), 13 deletions(-)
> ---
> Changelog:
> v2:
> - Move btrfs_dump_bioc() to raid56.c and remove the "btrfs_" prefix.
> - Use parentheses to protect macro parameters
> - Add back the accidentally removed assert on @sector_nr inside
>   rbio_add_io_sector()
> - Use btrfs_crit() to output the error messages
>   For the rare case where rbio->bioc is not yet set, use NULL for
>   fs_info which is supported for a long time.
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 6f4a9cfeea44..7444faa4b165 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -40,6 +40,88 @@
>
>  #define BTRFS_STRIPE_HASH_TABLE_BITS                           11
>
> +static void dump_bioc(struct btrfs_fs_info *fs_info,

fs_info can also be const.

> +                     const struct btrfs_io_context *bioc)
> +{
> +       if (unlikely(!bioc)) {
> +               btrfs_crit(fs_info, "bioc=3DNULL");
> +               return;
> +       }
> +       btrfs_crit(fs_info,
> +               "bioc logical=3D%llu full_stripe=3D%llu size=3D%llu map_t=
ype=3D0x%llx mirror=3D%u replace_nr_stripes=3D%u replace_stripe_src=3D%d nu=
m_stripes=3D%u",
> +               bioc->logical, bioc->full_stripe_logical, bioc->size,
> +               bioc->map_type, bioc->mirror_num, bioc->replace_nr_stripe=
s,
> +               bioc->replace_stripe_src, bioc->num_stripes);
> +       for (int i =3D 0; i < bioc->num_stripes; i++) {
> +               btrfs_crit(fs_info,
> +                       "    nr=3D%d devid=3D%llu physical=3D%llu",
> +                       i, bioc->stripes[i].dev->devid,
> +                       bioc->stripes[i].physical);
> +       }
> +}
> +
> +static void btrfs_dump_rbio(struct btrfs_fs_info *fs_info,

Same here.

Anyway, these are minor things, you don't need to send another patch
version, you can amend that (if you want to) when committing the patch
to for-next.

So:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +                           const struct btrfs_raid_bio *rbio)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
> +               return;
> +
> +       dump_bioc(fs_info, rbio->bioc);
> +       btrfs_crit(fs_info,
> +"rbio flags=3D0x%lx nr_sectors=3D%u nr_data=3D%u real_stripes=3D%u strip=
e_nsectors=3D%u scrubp=3D%u dbitmap=3D0x%lx",
> +               rbio->flags, rbio->nr_sectors, rbio->nr_data,
> +               rbio->real_stripes, rbio->stripe_nsectors,
> +               rbio->scrubp, rbio->dbitmap);
> +}
> +
> +#define ASSERT_RBIO(expr, rbio)                                         =
       \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               struct btrfs_fs_info *fs_info =3D (rbio)->bioc ?         =
 \
> +                                       (rbio)->bioc->fs_info : NULL;   \
> +                                                                       \
> +               btrfs_dump_rbio(fs_info, (rbio));                       \
> +       }                                                               \
> +       ASSERT((expr));                                                 \
> +})
> +
> +#define ASSERT_RBIO_STRIPE(expr, rbio, stripe_nr)                      \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               struct btrfs_fs_info *fs_info =3D (rbio)->bioc ?         =
 \
> +                                       (rbio)->bioc->fs_info : NULL;   \
> +                                                                       \
> +               btrfs_dump_rbio(fs_info, (rbio));                       \
> +               btrfs_crit(fs_info, "stripe_nr=3D%d", (stripe_nr));      =
 \
> +       }                                                               \
> +       ASSERT((expr));                                                 \
> +})
> +
> +#define ASSERT_RBIO_SECTOR(expr, rbio, sector_nr)                      \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               struct btrfs_fs_info *fs_info =3D (rbio)->bioc ?         =
 \
> +                                       (rbio)->bioc->fs_info : NULL;   \
> +                                                                       \
> +               btrfs_dump_rbio(fs_info, (rbio));                       \
> +               btrfs_crit(fs_info, "sector_nr=3D%d", (sector_nr));      =
 \
> +       }                                                               \
> +       ASSERT((expr));                                                 \
> +})
> +
> +#define ASSERT_RBIO_LOGICAL(expr, rbio, logical)                       \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               struct btrfs_fs_info *fs_info =3D (rbio)->bioc ?         =
 \
> +                                       (rbio)->bioc->fs_info : NULL;   \
> +                                                                       \
> +               btrfs_dump_rbio(fs_info, (rbio));                       \
> +               btrfs_crit(fs_info, "logical=3D%llu", (logical));        =
 \
> +       }                                                               \
> +       ASSERT((expr));                                                 \
> +})
> +
> +
>  /* Used by the raid56 code to lock stripes for read/modify/write */
>  struct btrfs_stripe_hash {
>         struct list_head hash_list;
> @@ -593,8 +675,8 @@ static unsigned int rbio_stripe_sector_index(const st=
ruct btrfs_raid_bio *rbio,
>                                              unsigned int stripe_nr,
>                                              unsigned int sector_nr)
>  {
> -       ASSERT(stripe_nr < rbio->real_stripes);
> -       ASSERT(sector_nr < rbio->stripe_nsectors);
> +       ASSERT_RBIO_STRIPE(stripe_nr < rbio->real_stripes, rbio, stripe_n=
r);
> +       ASSERT_RBIO_SECTOR(sector_nr < rbio->stripe_nsectors, rbio, secto=
r_nr);
>
>         return stripe_nr * rbio->stripe_nsectors + sector_nr;
>  }
> @@ -874,8 +956,10 @@ static struct sector_ptr *sector_in_rbio(struct btrf=
s_raid_bio *rbio,
>         struct sector_ptr *sector;
>         int index;
>
> -       ASSERT(stripe_nr >=3D 0 && stripe_nr < rbio->real_stripes);
> -       ASSERT(sector_nr >=3D 0 && sector_nr < rbio->stripe_nsectors);
> +       ASSERT_RBIO_STRIPE(stripe_nr >=3D 0 && stripe_nr < rbio->real_str=
ipes,
> +                          rbio, stripe_nr);
> +       ASSERT_RBIO_SECTOR(sector_nr >=3D 0 && sector_nr < rbio->stripe_n=
sectors,
> +                          rbio, sector_nr);
>
>         index =3D stripe_nr * rbio->stripe_nsectors + sector_nr;
>         ASSERT(index >=3D 0 && index < rbio->nr_sectors);
> @@ -1058,8 +1142,10 @@ static int rbio_add_io_sector(struct btrfs_raid_bi=
o *rbio,
>          * thus it can be larger than rbio->real_stripe.
>          * So here we check against bioc->num_stripes, not rbio->real_str=
ipes.
>          */
> -       ASSERT(stripe_nr >=3D 0 && stripe_nr < rbio->bioc->num_stripes);
> -       ASSERT(sector_nr >=3D 0 && sector_nr < rbio->stripe_nsectors);
> +       ASSERT_RBIO_STRIPE(stripe_nr >=3D 0 && stripe_nr < rbio->bioc->nu=
m_stripes,
> +                          rbio, stripe_nr);
> +       ASSERT_RBIO_SECTOR(sector_nr >=3D 0 && sector_nr < rbio->stripe_n=
sectors,
> +                          rbio, sector_nr);
>         ASSERT(sector->page);
>
>         stripe =3D &rbio->bioc->stripes[stripe_nr];
> @@ -1198,14 +1284,14 @@ static void assert_rbio(struct btrfs_raid_bio *rb=
io)
>          * At least two stripes (2 disks RAID5), and since real_stripes i=
s U8,
>          * we won't go beyond 256 disks anyway.
>          */
> -       ASSERT(rbio->real_stripes >=3D 2);
> -       ASSERT(rbio->nr_data > 0);
> +       ASSERT_RBIO(rbio->real_stripes >=3D 2, rbio);
> +       ASSERT_RBIO(rbio->nr_data > 0, rbio);
>
>         /*
>          * This is another check to make sure nr data stripes is smaller
>          * than total stripes.
>          */
> -       ASSERT(rbio->nr_data < rbio->real_stripes);
> +       ASSERT_RBIO(rbio->nr_data < rbio->real_stripes, rbio);
>  }
>
>  /* Generate PQ for one vertical stripe. */
> @@ -1642,9 +1728,10 @@ static void rbio_add_bio(struct btrfs_raid_bio *rb=
io, struct bio *orig_bio)
>         const u32 sectorsize =3D fs_info->sectorsize;
>         u64 cur_logical;
>
> -       ASSERT(orig_logical >=3D full_stripe_start &&
> +       ASSERT_RBIO_LOGICAL(orig_logical >=3D full_stripe_start &&
>                orig_logical + orig_len <=3D full_stripe_start +
> -              rbio->nr_data * BTRFS_STRIPE_LEN);
> +              rbio->nr_data * BTRFS_STRIPE_LEN,
> +              rbio, orig_logical);
>
>         bio_list_add(&rbio->bio_list, orig_bio);
>         rbio->bio_list_bytes +=3D orig_bio->bi_iter.bi_size;
> @@ -2390,7 +2477,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rb=
io(struct bio *bio,
>                         break;
>                 }
>         }
> -       ASSERT(i < rbio->real_stripes);
> +       ASSERT_RBIO_STRIPE(i < rbio->real_stripes, rbio, i);
>
>         bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
>         return rbio;
> @@ -2556,7 +2643,7 @@ static int finish_parity_scrub(struct btrfs_raid_bi=
o *rbio)
>          * Replace is running and our parity stripe needs to be duplicate=
d to
>          * the target device.  Check we have a valid source stripe number=
.
>          */
> -       ASSERT(rbio->bioc->replace_stripe_src >=3D 0);
> +       ASSERT_RBIO(rbio->bioc->replace_stripe_src >=3D 0, rbio);
>         for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
>                 struct sector_ptr *sector;
>
> --
> 2.45.0
>
>

