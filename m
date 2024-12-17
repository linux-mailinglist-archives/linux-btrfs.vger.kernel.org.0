Return-Path: <linux-btrfs+bounces-10493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C69F5151
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9F8163EE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A71D2B11;
	Tue, 17 Dec 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Ubu6xc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED45142E77
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453843; cv=none; b=nrFXD1I+bTh0hZgSdOa7fRhUozqQcoZh1CmKe35JZ7nYnc0GRw+SekzFyANEFAnvUZJbx+Ob2w6vaouzguUiNaKk9wox2/FlHjVJi+kya+W/FMw5vodhqFgT3/0rHr2Qy6dEXChDV63aMtpBgxiR/VXt0VAfcG4JiU+8LUzdp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453843; c=relaxed/simple;
	bh=za6KIJN1izyLayGEUrCKyb7hMme9SqHr9G1fPKEs+8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUph3EGlTY3x1OWoYLSYEpiur6PKBxwTDVo/GZdj/9ReHB5AuZGeHWca1KlkcfQzes35DI6o9a9ywkSUi1kcVRvCfWoRPP1eJHQAzhTaMw7sMLw99r6RnmkdGoWaDlx1V//Mw7DX+vhsXT9Wr4YhwidFTCwajfXhZWWjs7VEPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Ubu6xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E04C4CEDF
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453842;
	bh=za6KIJN1izyLayGEUrCKyb7hMme9SqHr9G1fPKEs+8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y8Ubu6xcjpdem2vlGb4ZafVTiwk/6d56c/W2iigOriAdO8wCbPl7moWtiRgDHyFUw
	 VZyRp4gIZonwxvuo7WN/ylQkkziCKvej7MngSIKYXrUnpQQDYK6F09hio3yhkeBHl4
	 Vrm9oYI+hHEewS33XQnVmvw3jifZhoPf1YxINxlyQPihllpxo9entUZpyOdAr3ZGD6
	 2Y7Q41eGnKehlooGAmBbyGZel8eN6n8CFkS5hiT/hywzRHMDjhQYhQikxjzoTAwCQG
	 joUroxGnutFb4bqTN2iOhuegG0pfZMXTsBEMxQFjbnaditQy6CMGDf5PxziLS+dXQS
	 0TsRS8nQOoBWA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so9571307a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:44:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwymAfhj7wm3bSXtvoU1LKJbL7gXyl6HrfShr+RnISn64xVNTTC
	Ru5XRsCzkGcEJzCThSnpcFYDf02lfGgZdAkiz1vMnSDNN9/XzciC6TAbF97Ev8H9dj2t5xL+Lte
	Crp3JYQx+MwwNKPn4HawXscrIvjo=
X-Google-Smtp-Source: AGHT+IGH8IRhXSxDQBeC2liPxH1SIxXOpm5uXF+OJ/9clJfkHt/Fwc8KZmF57+/T0w16INichUIFt9Reua+OraYOuk0=
X-Received: by 2002:a17:906:30d0:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-aabdaf8f365mr416225066b.4.1734453841138; Tue, 17 Dec 2024
 08:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <3f5da94fb0a98e09556468efdfff1cd7f71495c5.1733989299.git.jth@kernel.org>
In-Reply-To: <3f5da94fb0a98e09556468efdfff1cd7f71495c5.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:43:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4_7av1sg+8vU6G95WEAuwizMFxj4gqCPs6FPaXW0WHiA@mail.gmail.com>
Message-ID: <CAL3q7H4_7av1sg+8vU6G95WEAuwizMFxj4gqCPs6FPaXW0WHiA@mail.gmail.com>
Subject: Re: [PATCH 11/14] btrfs: selftests: test RAID stripe-tree deletion
 spanning two items
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
> Add a selftest for RAID stripe-tree deletion with a delete range spanning
> two items, so that we're punching a hole into two adjacent RAID stripe
> extents truncating the first and "moving" the second to the right.
>
> The following diagram illustrates the operation:
>
>  |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
>  |-----  keep  -----|--- drop ---|-----  keep  ----|
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 12f3dbb23a64..a815fc5c4dd3 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -31,6 +31,149 @@ static struct btrfs_device *btrfs_device_by_devid(str=
uct btrfs_fs_devices *fs_de
>         return NULL;
>  }
>
> +/*
> + * Test a 1M RST write that spans two adjecent RST items on disk and the=
n
> + * delete a portion starting in the first item and spanning into the sec=
ond
> + * item. This is similar to test_front_delete(), but spanning multiple i=
tems.
> + */
> +static int test_front_delete_prev_item(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { 0 };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical1 =3D SZ_1M;
> +       u64 logical2 =3D SZ_2M;
> +       u64 len =3D SZ_1M;
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
> +       bioc->map_type =3D map_type;
> +       bioc->size =3D len;
> +
> +       /* insert RAID extent 1. */
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
> +       /* Insert RAID extent 2, directly adjacent to it. */
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
> +       ret =3D btrfs_delete_raid_extent(trans, logical1 + SZ_512K, SZ_1M=
);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        logical1 + SZ_512K, (u64)SZ_1M);
> +               goto out;
> +       }
> +
> +       /* Verify item 1 is truncated to 512K. */
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical1, &len, map=
_type, 0,
> +                                          &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical1,
> +                        logical1 + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical1) {
> +               test_err("invalid physical address, expected %llu got %ll=
u",
> +                        logical1, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_512K) {
> +               test_err("invalid stripe length, expected %llu got %llu",
> +                        (u64)SZ_512K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Verify item 2's start is moved by 512K. */
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical2 + SZ_512K,=
 &len,
> +                                          map_type, 0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed",
> +                        logical2 + SZ_512K, logical2 + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical2 + SZ_512K) {
> +               test_err("invalid physical address, expected %llu got %ll=
u",
> +                        logical2 + SZ_512K, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_512K) {
> +               test_err("invalid stripe length, expected %llu got %llu",
> +                        (u64)SZ_512K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Verify there's a hole at [1M+512K, 2M+512K] */
> +       len =3D SZ_1M;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical1 + SZ_512K,=
 &len,
> +                                          map_type, 0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               test_err("lookup of RAID [%llu, %llu] succeeded, should f=
ail",
> +                        logical1 + SZ_512K, logical1 + SZ_512K + len);
> +               goto out;
> +       }
> +
> +       /* Clean up after us. */
> +       ret =3D btrfs_delete_raid_extent(trans, logical1, SZ_512K);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical2 + SZ_512K, SZ_51=
2K);
> +
> +out:
> +       btrfs_put_bioc(bioc);
> +       return ret;
> +}
> +
>  /*
>   * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and=
 then
>   * delete the 1st 32K, making the new start address 1M+32K.
> @@ -468,6 +611,7 @@ static const test_func_t tests[] =3D {
>         test_create_update_delete,
>         test_tail_delete,
>         test_front_delete,
> +       test_front_delete_prev_item,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> --
> 2.43.0
>
>

