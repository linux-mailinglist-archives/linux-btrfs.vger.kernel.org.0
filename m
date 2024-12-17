Return-Path: <linux-btrfs+bounces-10496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB09F5174
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E86169F3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24A1F75A6;
	Tue, 17 Dec 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdgugKGg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F814A0A3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454567; cv=none; b=PE7XwQ/NNJY5BSgE4ImysxOcQj/TUm63UdnU5S78P/SYI+hA9Wh4UqoPfWHq1nIjGjk/3M3JKxYKGMu69OdF4Tk9EcSGrpg01H4lwSM56WzDD6BAKvc/bVqRrJtQAaa5JeE9+dxiIY8h865h0ZnFYF55+T2sgPFZ3YzT2GRFGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454567; c=relaxed/simple;
	bh=vlG105bPhMGkxe/E4AMn32GreZoQkZ/0aqRCfkrLAbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NElLafG9ubDJ1xut/piIiR9JghCu3Ec1PksQWESuFstnOphnVDeKddKPNTnhMBRk1e/t4vCTshOaqXZnHd2ZmA7guix1q8qbQY0ILDRvPHWZM3OtwTfs74eyKEu7QuFQyzXssxoDsZuQHA23IyXSPZWW4d/PTHvo6XXy2+e6+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdgugKGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08524C4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454567;
	bh=vlG105bPhMGkxe/E4AMn32GreZoQkZ/0aqRCfkrLAbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZdgugKGgV3SlTcV8PIh+/CV+OaGN13/7beefq+EULuCjXB7+8b6YXEgd5uyQvNtwl
	 f07tXvZ4FXTHU801iIeR3TKgU7H557+N9xAstz1y4XKbBCbZSN8I5DumapVFfxRgqK
	 /Src1D/U+RjdDgQcG/wpwudjRXS+xnskObU8CBX4qHtQbtztGANJSYK4VgVGqsRf1o
	 5tTCVe1fr5WeLvDv+9eVdZqg9bDTI9svjDCUUcuqURc2r0aO7+dgXj9p9MQaBEU4j9
	 AKOtuF62xPpJIGWU6Nzv9kC0Hf45Bhd/f+WtG1xY/O/tVLYyvROKCW1L+gWBv7/WAK
	 7yHv7ZO85X5WA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so7882380a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:56:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzA3VAau8a62xuB/2K716EvfwavK8X9wzQkl8DNJ5Se19W0t6qi
	bEyhM+O7wVaVvI86CEy53aoZNG7UEZ4nhAW0bvj8y7dkBL5ZCrPa23vbqRja/dMbujC/iRwsHL7
	01Fu712Ole+Jcxak5I1/0ZQfRvd8=
X-Google-Smtp-Source: AGHT+IEVF0mt0by1RAFmz4RZ5nRteyIysm3QOPxq28W3uhLqcjZnaiy1cvblL2W+SB/ke3iYPfEJNJdpTWpnj0MezRI=
X-Received: by 2002:a17:906:4c9:b0:aa6:89b9:e9c6 with SMTP id
 a640c23a62f3a-aab77909e3emr1416457266b.21.1734454565606; Tue, 17 Dec 2024
 08:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <9ca5d0de8c4ebd1e6267f1fbae9238753d14cf50.1733989299.git.jth@kernel.org>
In-Reply-To: <9ca5d0de8c4ebd1e6267f1fbae9238753d14cf50.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:55:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5AerAb-7t+=LsOksynFp2RfpVcQRsSW+kX6AyFmUHfmw@mail.gmail.com>
Message-ID: <CAL3q7H5AerAb-7t+=LsOksynFp2RfpVcQRsSW+kX6AyFmUHfmw@mail.gmail.com>
Subject: Re: [PATCH 13/14] btrfs: selftests: add test for punching a hole into
 3 RAID stripe-extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:56=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Missing a change log.

> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 183 ++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 37b87ccb5858..8d74e95a8a75 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -31,6 +31,188 @@ static struct btrfs_device *btrfs_device_by_devid(str=
uct btrfs_fs_devices *fs_de
>         return NULL;
>  }
>
> +/*
> + * Test creating a range of three extents and then punch a hole in the m=
iddle,
> + * deleting all of the middle extents and partially deleting the "book e=
nds"
> + */
> +static int test_punch_hole_3extents(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { 0 };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical1 =3D SZ_1M;
> +       u64 len1 =3D SZ_1M;
> +       u64 logical2 =3D logical1 + len1;
> +       u64 len2 =3D SZ_1M;
> +       u64 logical3 =3D logical2 + len2;
> +       u64 len3 =3D SZ_1M;
> +       u64 hole_start =3D logical1 + SZ_256K;
> +       u64 hole_len =3D SZ_2M;
> +       int ret;
> +
> +       bioc =3D alloc_btrfs_io_context(fs_info, logical1, RST_TEST_NUM_D=
EVICES);
> +       if (!bioc) {
> +               test_std_err(TEST_ALLOC_IO_CONTEXT);
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       io_stripe.dev =3D btrfs_device_by_devid(fs_info->fs_devices, 0);
> +
> +       /* prepare for the test, 1st create 3 x 1M extents */

Our preferred style is to capitalize the first word and end with punctuatio=
n.
Same goes for 2 other comments below.

Other than that and the empty changelog, it looks good.

So at least after adding a changelog:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       bioc->map_type =3D map_type;
> +       bioc->size =3D len1;
> +
> +       for (int i =3D 0; i < RST_TEST_NUM_DEVICES; i++) {
> +               struct btrfs_io_stripe *stripe =3D &bioc->stripes[i];
> +
> +               stripe->dev =3D btrfs_device_by_devid(fs_info->fs_devices=
, i);
> +               if (!stripe->dev) {
> +                       test_err("cannot find device with devid %d", i);
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               stripe->physical =3D logical1 + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("inserting RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       bioc->logical =3D logical2;
> +       bioc->size =3D len2;
> +       for (int i =3D 0; i < RST_TEST_NUM_DEVICES; i++) {
> +               struct btrfs_io_stripe *stripe =3D &bioc->stripes[i];
> +
> +               stripe->dev =3D btrfs_device_by_devid(fs_info->fs_devices=
, i);
> +               if (!stripe->dev) {
> +                       test_err("cannot find device with devid %d", i);
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               stripe->physical =3D logical2 + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("inserting RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       bioc->logical =3D logical3;
> +       bioc->size =3D len3;
> +       for (int i =3D 0; i < RST_TEST_NUM_DEVICES; i++) {
> +               struct btrfs_io_stripe *stripe =3D &bioc->stripes[i];
> +
> +               stripe->dev =3D btrfs_device_by_devid(fs_info->fs_devices=
, i);
> +               if (!stripe->dev) {
> +                       test_err("cannot find device with devid %d", i);
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +
> +               stripe->physical =3D logical3 + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("inserting RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       /*
> +        * Delete a range starting at logical1 + 256K and 2M in length. E=
xtent
> +        * 1 is truncated to 256k length, extent 2 is completely dropped =
and
> +        * extent 3 is moved 256K to the right.
> +        */
> +       ret =3D btrfs_delete_raid_extent(trans, hole_start, hole_len);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        hole_start, hole_start + hole_len);
> +               goto out;
> +       }
> +
> +       /* get the first extent and check its size */
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical1, &len1, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed",
> +                        logical1, logical1 + len1);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical1) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical1, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len1 !=3D SZ_256K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_256K, len1);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* get the second extent and check it's absent */
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical2, &len2, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               test_err("lookup of RAID extent [%llu, %llu] succeeded sh=
ould fail",
> +                        logical2, logical2 + len2);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* get the third extent and check its size */
> +       logical3 +=3D SZ_256K;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical3, &len3, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed",
> +                        logical3, logical3 + len3);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical3) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical3 + SZ_256K, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len3 !=3D SZ_1M - SZ_256K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_1M - SZ_256K, len3);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical1, len1);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        logical1, logical1 + len1);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical3, len3);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        logical1, logical1 + len1);
> +               goto out;
> +       }
> +
> +out:
> +       btrfs_put_bioc(bioc);
> +       return ret;
> +}
> +
>  /* Test punching a hole into a single RAID stripe-extent. */
>  static int test_punch_hole(struct btrfs_trans_handle *trans)
>  {
> @@ -745,6 +927,7 @@ static const test_func_t tests[] =3D {
>         test_front_delete,
>         test_front_delete_prev_item,
>         test_punch_hole,
> +       test_punch_hole_3extents,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> --
> 2.43.0
>
>

