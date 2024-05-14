Return-Path: <linux-btrfs+bounces-4963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429F38C5456
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620FB284E4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804D762C1;
	Tue, 14 May 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1u9lvAO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462482D60A
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687131; cv=none; b=NCo12W/5a7U/vGeqOdlMiADT0NU0XLfVh05G4l2vazAdGdNgCEA1uH9CdXlLmKcHlITPAoB61pUkMr736vuPzwiBlPCckw/pID1kjf6AF9iqFuDyYyyo+f4RcCdBXElUXS1Gaxha2+26KaAqzWKura/KTQObm2iWZ4803Xs3Eys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687131; c=relaxed/simple;
	bh=u/BFs6jD45+lTOplZjLDemDla82NRpRuBJgOUBfPHiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTzD02hDFvFEfNuFmB29ojBkPNlMxTVRt0DKx6nA+9LltX1jzUl2N6QKAtg4WK/l9vDe0KJ5uz1vC0tYCorgV1X3uWpuEA993A+Ra2tRKGISPH12AKJPk0OEsMCCCQzhrZKoiwfiNXzFSrjH5bELdJXF9baWChvO0F4MHd5MABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1u9lvAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D6DC2BD10
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715687131;
	bh=u/BFs6jD45+lTOplZjLDemDla82NRpRuBJgOUBfPHiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1u9lvAODSZdePJVVwduXVsm0z+WtlXwv9G1GJjw6/es79EgJE9pjFW1IAYBODF7J
	 s3JYkIu20vSXrun2vCxonGsmhlrOuOjF1+aJtvgFeg6FDRSH7FY2ICJzWo0O2BEFhH
	 plwwjA/dkwEMUpfBf1JHta8NwkKaX7QV+2XXukUU91ckZ0Ki/rq1UY8FRxKDZC8QoN
	 qi86iVaYGAdmOg1GNZAym0PPrmbt5sUTteC9q6PA1LQf9UTwErWKnI8bMeMszOa+VU
	 cFriHNoP/We/xQ3DJWZQ8LMi3unGD2GbfM5yTDdeubHqqcqThCThv6g6i8zyBSDoUX
	 m5eJyrnf8cC4A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a88339780so17944666b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 04:45:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9sBR+8SxN39r7iatXvJpc77ZrZWA3ES2LTQd/tUjDIcOrzJ7j
	ivTjXEZAKVoo7pX8KKy2pX3ineF/1kgOFtZcSLL45Rhj0q1tbrF+Gwf8FbllppKDVNNWOosGOcd
	Z25w03Lx3vHFsyMO6HYKZB0BhyD0=
X-Google-Smtp-Source: AGHT+IGqWmvBQ8Sn8uI0fCLgca4tUabNKc0yM/jgTqWPujTjTIb2fla0ktNq1GaA/a+ev5Ie38n6Jn70+2w03ZJzBcg=
X-Received: by 2002:a17:906:4a95:b0:a59:cb29:3fb2 with SMTP id
 a640c23a62f3a-a5a2d66a354mr857432966b.57.1715687129513; Tue, 14 May 2024
 04:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <096e0e552749093231fae4f2f6eb450eb9e0d465.1715678510.git.wqu@suse.com>
In-Reply-To: <096e0e552749093231fae4f2f6eb450eb9e0d465.1715678510.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 14 May 2024 12:44:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6u_oDDqdrEFJJTHkoAxojtH_q42ny2-DqkjYs0CkF3Fw@mail.gmail.com>
Message-ID: <CAL3q7H6u_oDDqdrEFJJTHkoAxojtH_q42ny2-DqkjYs0CkF3Fw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: raid56: do extra dumping for CONFIG_BTRFS_ASSERT
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:35=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
>  bioc logical=3D298917888 full_stripe=3D298844160 size=3D0 map_type=3D0x1=
01 mirror=3D4 replace_nr_stripes=3D0 replace_stripe_src=3D-1 num_stripes=3D=
4
>      nr=3D0 devid=3D1 physical=3D22020096
>      nr=3D1 devid=3D2 physical=3D1048576
>      nr=3D2 devid=3D3 physical=3D277872640
>      nr=3D3 devid=3D4 physical=3D277872640
>  rbio flags=3D0x0 nr_sectors=3D64 nr_data=3D2 real_stripes=3D4 stripe_nse=
ctors=3D16 scrubp=3D0 dbitmap=3D0x0
>  logical=3D298917888
>  assertion failed: orig_logical >=3D full_stripe_start && orig_logical + =
orig_len <=3D full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/b=
trfs/raid56.c:1702
>  ------------[ cut here ]------------
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/raid56.c  | 77 ++++++++++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h | 20 ++++++++++++
>  2 files changed, 84 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 6f4a9cfeea44..b8fffac7cd24 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -40,6 +40,54 @@
>
>  #define BTRFS_STRIPE_HASH_TABLE_BITS                           11
>
> +static void btrfs_dump_rbio(const struct btrfs_raid_bio *rbio)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
> +               return;
> +
> +       btrfs_dump_bioc(rbio->bioc);
> +       pr_info(

You can use btrfs_err() or btrfs_crit() here for a more standardized messag=
e.
Also I don't think info level is appropriate, either error or critical
seem the right choice to me.

Remember that CONFIG_BTRFS_ASSERT is also set for some non-debug
kernel configs like SUSE kernels, and it may be useful to know from
which fs the problem came for example.

The fs_info is accessible through rbio->bioc->fs_info.
And even if rbio->bioc is NULL (and btrfs_dump_bioc() checks for
that), you can still pass a NULL fs_info to those helpers.

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
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr)))       \
> +               btrfs_dump_rbio(rbio);                                  \

As a good practice, there should be parenthesis around rbio too
because we're inside a macro, that is:

btrfs_dump_rbio((rbio));

> +       ASSERT(expr);                                                   \

Same here.

> +})
> +
> +#define ASSERT_RBIO_STRIPE(expr, rbio, stripe_nr)                      \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               btrfs_dump_rbio(rbio);                                  \

Same here.

> +               pr_info("stripe_nr=3D%d", stripe_nr);                    =
 \

Same here for stripe_nr.

> +       }                                                               \
> +       ASSERT(expr);                                                   \

Same here.

> +})
> +
> +#define ASSERT_RBIO_SECTOR(expr, rbio, sector_nr)                      \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               btrfs_dump_rbio(rbio);                                  \
> +               pr_info("sector_nr=3D%d", sector_nr);                    =
 \

Same here.

> +       }                                                               \
> +       ASSERT(expr);                                                   \

Same here.

> +})
> +
> +#define ASSERT_RBIO_LOGICAL(expr, rbio, logical)                       \
> +({                                                                     \
> +       if (IS_ENABLED(CONFIG_BTRFS_ASSERT) && unlikely(!(expr))) {     \
> +               btrfs_dump_rbio(rbio);                                  \
> +               pr_info("logical=3D%llu", logical);                      =
 \

Same here (rbio and logical).

> +       }                                                               \
> +       ASSERT(expr);                                                   \

Same here.

> +})
> +
> +
>  /* Used by the raid56 code to lock stripes for read/modify/write */
>  struct btrfs_stripe_hash {
>         struct list_head hash_list;
> @@ -593,8 +641,8 @@ static unsigned int rbio_stripe_sector_index(const st=
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
> @@ -874,8 +922,10 @@ static struct sector_ptr *sector_in_rbio(struct btrf=
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
> @@ -1058,8 +1108,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio=
 *rbio,
>          * thus it can be larger than rbio->real_stripe.
>          * So here we check against bioc->num_stripes, not rbio->real_str=
ipes.
>          */
> -       ASSERT(stripe_nr >=3D 0 && stripe_nr < rbio->bioc->num_stripes);
> -       ASSERT(sector_nr >=3D 0 && sector_nr < rbio->stripe_nsectors);
> +       ASSERT_RBIO_STRIPE(stripe_nr >=3D 0 && stripe_nr < rbio->bioc->nu=
m_stripes,
> +                          rbio, stripe_nr);

Why was the second assertion removed?
There's no replacement for the one checking sector_nr.

>         ASSERT(sector->page);
>
>         stripe =3D &rbio->bioc->stripes[stripe_nr];
> @@ -1198,14 +1248,14 @@ static void assert_rbio(struct btrfs_raid_bio *rb=
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
> @@ -1642,9 +1692,10 @@ static void rbio_add_bio(struct btrfs_raid_bio *rb=
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
> @@ -2390,7 +2441,7 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rb=
io(struct bio *bio,
>                         break;
>                 }
>         }
> -       ASSERT(i < rbio->real_stripes);
> +       ASSERT_RBIO_STRIPE(i < rbio->real_stripes, rbio, i);
>
>         bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
>         return rbio;
> @@ -2556,7 +2607,7 @@ static int finish_parity_scrub(struct btrfs_raid_bi=
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
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 66e6fc481ecd..1373721f8e53 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -554,6 +554,26 @@ struct btrfs_io_context {
>         struct btrfs_io_stripe stripes[];
>  };
>
> +static inline void btrfs_dump_bioc(const struct btrfs_io_context *bioc)
> +{
> +       if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
> +               return;

The caller already checked this.

> +
> +       if (unlikely(!bioc)) {
> +               pr_err("bioc=3DNULL\n");
> +               return;
> +       }
> +       pr_info("bioc logical=3D%llu full_stripe=3D%llu size=3D%llu map_t=
ype=3D0x%llx mirror=3D%u replace_nr_stripes=3D%u replace_stripe_src=3D%d nu=
m_stripes=3D%u\n",

Same here as pointed out before, could use btrfs_err() or btrfs_crit().

Also since this is only used inside raid56.c, it could be placed there.

Thanks.

> +               bioc->logical, bioc->full_stripe_logical, bioc->size,
> +               bioc->map_type, bioc->mirror_num, bioc->replace_nr_stripe=
s,
> +               bioc->replace_stripe_src, bioc->num_stripes);
> +       for (int i =3D 0; i < bioc->num_stripes; i++) {
> +               pr_info("    nr=3D%d devid=3D%llu physical=3D%llu\n",
> +                       i, bioc->stripes[i].dev->devid,
> +                       bioc->stripes[i].physical);
> +       }
> +}
> +
>  struct btrfs_device_info {
>         struct btrfs_device *dev;
>         u64 dev_offset;
> --
> 2.45.0
>
>

