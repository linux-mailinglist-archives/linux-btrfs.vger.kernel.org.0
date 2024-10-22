Return-Path: <linux-btrfs+bounces-9066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D441C9AB039
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902F82840E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BC19F42C;
	Tue, 22 Oct 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khznxzWR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331A16A92E
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605494; cv=none; b=j/y2N0LI844fvpu/03SbOY0zIUoXJVX+7wp+5L1cI6faTANlP4Y3WgKudBjutgaDqgchCvuWLYFH6zvccrBLSgFwA/R2fBMKo9PLKmPJaR/H621QPxoyc8JfvpqnFSQm4TKv+++wGyKdnUwEH7sGgl+zd64fEbv7jppo1pqF5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605494; c=relaxed/simple;
	bh=aWb1OSpbjW6WIkBjic/zZznJ7soboLOqeP+QazIOCQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj7dUExZLlw0a0eZRg0U9B7Eu6SmdtfDOQ7TXrnvBPsnEjQ+FxcPIjAI5tUVfWAfWlE/B8DJ+6rziNF/FFeY7yD6bpaLSam4vgA+jNIzjlmiogJR4LELBsMb4MkdwhukRERb8tZJnf2+FRVBNlVhdNdNz7gGf4zC9/IpUgJ/Uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khznxzWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE27C4CEC3
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605494;
	bh=aWb1OSpbjW6WIkBjic/zZznJ7soboLOqeP+QazIOCQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=khznxzWRPzRPSddy5msTyUYQnV1Krrx3qWSnhHwc1HC5+cKPOQqWqKWghFdbG8+Du
	 5ATkXtZqPXOwsk0EZRqTfekaHPGXdZyy4/Lozs+4v4VmDj6lLeM0nGvyFRWqI52gos
	 JkARrJaILiijeK8eKkO7T8LOPjD6WR39d316oev7z9DWS1IqfiBmLLsg1XiOVAw7Xi
	 JN07r0jf6TxSyT4dD5sVu1G46izOAMQWBKlS6NhkoDApI9PFmY8OKK/F4OySK4FA43
	 LoFDBD59DZlIrX15fvdrPmP/Xu+V8+ZQBD7jG9rKiKDpCo0AVlbCsEqSP9c7bWjGLf
	 GKrn/Kuy6PmKA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99cc265e0aso840243566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 06:58:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjmkoZvbuLQ+6W6GGKp45jm2jX1P0uymPGS0Vi2f55F8UBTfKL
	PNc3o8Tzzr5MzIrY5GhVyX0/BfMUhgdSPp8KoMAAqF3DMo/inkOWOm0Ta0Pf/XRLOghACOHu6Cm
	OHh7Ct3H6nBHl5CKeNflrjv0FTpo=
X-Google-Smtp-Source: AGHT+IG4GDrxrTsuliRkBpTByyfa1tEjypjTuKXM+ET/SNOkcKXLYu2ifnZ5+4QdckoYQkXoPR+R1Kdi01gu7bEUbBM=
X-Received: by 2002:a17:906:f592:b0:a99:ff43:ca8f with SMTP id
 a640c23a62f3a-a9a6995d6camr1381386866b.10.1729605492882; Tue, 22 Oct 2024
 06:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017090411.25336-1-jth@kernel.org> <20241017090411.25336-3-jth@kernel.org>
In-Reply-To: <20241017090411.25336-3-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Oct 2024 14:57:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Ksy02JEmzd+LwM1oxE1Ok6GT2r0vCEZ5WiBW9wfMwuQ@mail.gmail.com>
Message-ID: <CAL3q7H5Ksy02JEmzd+LwM1oxE1Ok6GT2r0vCEZ5WiBW9wfMwuQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] btrfs: implement self-tests for partial RAID
 srtipe-tree delete
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:09=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Implement self-tests for partial deletion of RAID stripe-tree entries.
>
> These two new tests cover both the deletion of the front of a RAID
> stripe-tree stripe extent as well as truncation of an item to make it
> smaller.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 223 ++++++++++++++++++++++++
>  1 file changed, 223 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index b8013ab13c43..5f1f1342b291 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -29,6 +29,227 @@ static struct btrfs_device *btrfs_device_by_devid(str=
uct btrfs_fs_devices *fs_de
>         return NULL;
>  }
>
> +/*
> + * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and=
 then
> + * delete the 1st 32K, making the new start address 1M+32K.
> + */
> +static int test_front_delete(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { 0 };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical =3D SZ_1M;
> +       u64 len =3D SZ_64K;
> +       int ret;
> +
> +       bioc =3D alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DE=
VICES);
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
> +               stripe->physical =3D logical + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("inserting RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0,
> +                                          &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical,
> +                        logical + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical) {
> +               test_err("invalid physical address, expected %llu got %ll=
u",
> +                        logical, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_64K) {
> +               test_err("invalid stripe length, expected %llu got %llu",
> +                        (u64)SZ_64K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical, SZ_32K);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed", logi=
cal,
> +                        logical + SZ_32K);
> +               goto out;
> +       }
> +
> +       len =3D SZ_32K;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical + SZ_32K, &=
len,
> +                                          map_type, 0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed",
> +                        logical + SZ_32K, logical + SZ_32K + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical + SZ_32K) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical + SZ_32K, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_32K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_32K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0,
> +                                          &io_stripe);
> +       if (!ret) {
> +               ret =3D -EINVAL;
> +               test_err("lookup of RAID extent [%llu, %llu] succeeded, s=
hould fail",
> +                        logical, logical + SZ_32K);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K)=
;
> + out:

Missies a:    btrfs_put_bioc(bioc);

The rest looks good, and with that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       return ret;
> +}
> +
> +/*
> + * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and=
 then
> + * truncate the stripe extent down to 32K.
> + */
> +static int test_tail_delete(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { 0 };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical =3D SZ_1M;
> +       u64 len =3D SZ_64K;
> +       int ret;
> +
> +       bioc =3D alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DE=
VICES);
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
> +               stripe->physical =3D logical + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("inserting RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       io_stripe.dev =3D btrfs_device_by_devid(fs_info->fs_devices, 0);
> +       if (!io_stripe.dev) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0,
> +                                          &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical,
> +                        logical + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical) {
> +               test_err("invalid physical address, expected %llu got %ll=
u",
> +                        logical, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_64K) {
> +               test_err("invalid stripe length, expected %llu got %llu",
> +                        (u64)SZ_64K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K)=
;
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        logical + SZ_32K, logical + SZ_64K);
> +               goto out;
> +       }
> +
> +       len =3D SZ_32K;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical,
> +                        logical + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_32K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_32K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical, len);
> +       if (ret)
> +               test_err("deleting RAID extent [%llu, %llu] failed", logi=
cal,
> +                        logical + len);
> +
> +out:
> +       btrfs_put_bioc(bioc);
> +       return ret;
> +}
> +
>  /*
>   * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and=
 then
>   * overwrite the whole range giving it new physical address at an offset=
 of 1G.
> @@ -235,6 +456,8 @@ static int test_simple_create_delete(struct btrfs_tra=
ns_handle *trans)
>  static const test_func_t tests[] =3D {
>         test_simple_create_delete,
>         test_create_update_delete,
> +       test_tail_delete,
> +       test_front_delete,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> --
> 2.43.0
>
>

