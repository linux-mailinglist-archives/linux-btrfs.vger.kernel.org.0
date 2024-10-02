Return-Path: <linux-btrfs+bounces-8434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40A98DB44
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D64028152E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EA1D1513;
	Wed,  2 Oct 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIfHjxmR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BB1D0493;
	Wed,  2 Oct 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879084; cv=none; b=Q/AA0WZhtNBXZTFAQKMZBLDSFLtdVVHoSNNtKLJyRZKqmbCnyf664sZMztuTfY6JVTdfNUkIQHdpJiMUyjmqL9W7XRjYOzXlN/8mnh3e/pNK19aL3bABQTQdAA/Cw8idoaW1VpYqqcjIgV/oIalXwqWgPnjzNlBp+M90WEYk8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879084; c=relaxed/simple;
	bh=c2tIfCdvQh+KyTrQuYeRbHUeqd85yk7WgZPjuOgQ+k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwcrTDpB9fmat+eRDInmp0ttPXdvRTuFQu9tLZcB879cHhQLqWUXMQ7WPbT56E9aGCc5oNePLVzEixMFg9gcZuNluYFBhxirHn4ug8iWoT2OJzbq0IYat0EmdQd+xpoxZuilDPDE6/rPrNMcZKLVhqVRzBKwyY6LpnbVOcl1Kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIfHjxmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE22BC4CEC5;
	Wed,  2 Oct 2024 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727879083;
	bh=c2tIfCdvQh+KyTrQuYeRbHUeqd85yk7WgZPjuOgQ+k8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RIfHjxmRdFCJ/v7dy3Y9VHGuKM00tUZkOf02HDT9aexVVg2Vobce0AgKxndBEKooD
	 1+SrwoqFHvXfxxO2XVxJUQRKBXeJ/HMe8gDTnggBo1D4PorgEKcgda8/jqAETwL8JY
	 xd3GdTFYAPKOYYvloGWaOSUKtVBLQhDEM9YdyXigmOSsQj56apY9/a6Sac/vIbuZOq
	 bd0/v0Ab43TnlHmwVNngUbopU+e/XcO+UzdTVeyFzCD9HfaEnti8GswBZUccX0XwSO
	 61HmhvzKc+AUNxyTvSHbtxD4uLt3hfp5Ohf8eFsoJ5rN9gMVHCJrNv99i+M7bQOXLh
	 JQaFgwiITlDDQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d56155f51so858368566b.2;
        Wed, 02 Oct 2024 07:24:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV458KWZsDrc22BZs2gMg1b26MwX5eiVEF4z80IT6JVvXHFWDdTAZhf37c3dnkZ5GJq+dCDAs0IoS3QYxuc@vger.kernel.org, AJvYcCVbIaY9vBZLFlLKKQme2444eQ4AQkdInUX8B/WZXLm7HwfzZBryBCqE1G0Rg+o8of4kWVBbhW7lt6l16g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSi3PYyOzRzWdHftkLK9cPkcIxxC2zFBnpgJ5r8RiGe720S2iu
	G3m8VyLclNnsxDgWgS6j3+f7q/EjsEYqATxdgZy2cCquAG6c7VqJpnd0f2/RmHbGyd3DhbDtOdF
	IYABCKSTMWoRxrCmp5UzdoSfvoJk=
X-Google-Smtp-Source: AGHT+IHSWDGJfMX1rm+YyyUT0ZBNVYVDKHIGtYmPvrO7OSpkH8vuoE+bLiqlb1nNHecU1Epn4xbOGuD8MaIRiPpdzKA=
X-Received: by 2002:a17:907:9493:b0:a8d:345e:a0ba with SMTP id
 a640c23a62f3a-a98f8241443mr297231566b.15.1727879082149; Wed, 02 Oct 2024
 07:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002101200.14543-1-jth@kernel.org>
In-Reply-To: <20241002101200.14543-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 2 Oct 2024 15:24:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5mRqf9hP-boXj7Tgd6SLYsUEyAboHzB7ZEw4vsgHLX8g@mail.gmail.com>
Message-ID: <CAL3q7H5mRqf9hP-boXj7Tgd6SLYsUEyAboHzB7ZEw4vsgHLX8g@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: tests: add selftests for RAID stripe-tree
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:12=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Add first stash of very basic self tests for the RAID stripe-tree.
>
> More test cases will follow exercising the tree.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v2:
> * Fix update test-case
> * Remove local btrfs_device variables (Filipe)
> * Add prints to see where a test-case failed (Filipe)
>
> Link to v2:
> https://lore.kernel.org/linux-btrfs/20241001065451.2378-1-jth@kernel.org
>
> Changes to v1:
> * Fix build errors with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=3Dn
> * Document expectations from the test cases
>
> Link to v1:
> https://lore.kernel.org/linux-btrfs/20240930104054.12290-1-jth@kernel.org
>
>  fs/btrfs/Makefile                       |   3 +-
>  fs/btrfs/raid-stripe-tree.c             |   5 +-
>  fs/btrfs/raid-stripe-tree.h             |   5 +
>  fs/btrfs/tests/btrfs-tests.c            |   3 +
>  fs/btrfs/tests/btrfs-tests.h            |   1 +
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 315 ++++++++++++++++++++++++
>  fs/btrfs/volumes.c                      |   6 +-
>  fs/btrfs/volumes.h                      |   5 +
>  8 files changed, 337 insertions(+), 6 deletions(-)
>  create mode 100644 fs/btrfs/tests/raid-stripe-tree-tests.c
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 87617f2968bc..3cfc440c636c 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -43,4 +43,5 @@ btrfs-$(CONFIG_FS_VERITY) +=3D verity.o
>  btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) +=3D tests/free-space-tests.o =
\
>         tests/extent-buffer-tests.o tests/btrfs-tests.o \
>         tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o =
\
> -       tests/free-space-tree-tests.o tests/extent-map-tests.o
> +       tests/free-space-tree-tests.o tests/extent-map-tests.o \
> +       tests/raid-stripe-tree-tests.o
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 4c859b550f6c..b7787a8e4af2 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -108,8 +108,9 @@ static int update_raid_extent_item(struct btrfs_trans=
_handle *trans,
>         return ret;
>  }
>
> -static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans=
,
> -                                       struct btrfs_io_context *bioc)
> +EXPORT_FOR_TESTS
> +int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
> +                                struct btrfs_io_context *bioc)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
>         struct btrfs_key stripe_key;
> diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
> index 1ac1c21aac2f..541836421778 100644
> --- a/fs/btrfs/raid-stripe-tree.h
> +++ b/fs/btrfs/raid-stripe-tree.h
> @@ -28,6 +28,11 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info =
*fs_info,
>  int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
>                              struct btrfs_ordered_extent *ordered_extent)=
;
>
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> +int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
> +                                struct btrfs_io_context *bioc);
> +#endif
> +
>  static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *f=
s_info,
>                                                  u64 map_type)
>  {
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index ce50847e1e01..18e1ab4a0914 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -291,6 +291,9 @@ int btrfs_run_sanity_tests(void)
>                         ret =3D btrfs_test_free_space_tree(sectorsize, no=
desize);
>                         if (ret)
>                                 goto out;
> +                       ret =3D btrfs_test_raid_stripe_tree(sectorsize, n=
odesize);
> +                       if (ret)
> +                               goto out;
>                 }
>         }
>         ret =3D btrfs_test_extent_map();
> diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
> index dc2f2ab15fa5..61bcadaf2036 100644
> --- a/fs/btrfs/tests/btrfs-tests.h
> +++ b/fs/btrfs/tests/btrfs-tests.h
> @@ -37,6 +37,7 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize);
>  int btrfs_test_inodes(u32 sectorsize, u32 nodesize);
>  int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
>  int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
> +int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
>  int btrfs_test_extent_map(void);
>  struct inode *btrfs_new_test_inode(void);
>  struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sector=
size);
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> new file mode 100644
> index 000000000000..94f3cd9d2661
> --- /dev/null
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/sizes.h>
> +#include "../fs.h"
> +#include "../disk-io.h"
> +#include "../transaction.h"
> +#include "../volumes.h"
> +#include "../raid-stripe-tree.h"
> +#include "btrfs-tests.h"
> +
> +#define RST_TEST_NUM_DEVICES   2
> +#define RST_TEST_RAID1_TYPE    (BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GRO=
UP_RAID1)
> +
> +typedef int (*test_func_t)(struct btrfs_trans_handle *trans);
> +
> +static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_device=
s *fs_devices,
> +                                                 u64 devid)
> +{
> +       struct btrfs_device *dev;
> +
> +       list_for_each_entry(dev, &fs_devices->devices, dev_list) {
> +               if (dev->devid =3D=3D devid)
> +                       return dev;
> +       }
> +
> +       return NULL;
> +}
> +
> +/*
> + * Test a 64k RST write on a 2 disk RAID1 at a logical address of 1M and=
 then
> + * overwrite the whole range giving it new physical address at an offset=
 of 1G.
> + * The intent of this test is to exercise the 'update_raid_extent_item()=
'
> + * function called be btrfs_insert_one_raid_extent().
> + */
> +static int test_create_update_delete(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical =3D SZ_1M;
> +       u64 len =3D SZ_64K;
> +       int ret;
> +
> +       bioc =3D alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DE=
VICES);
> +       if (!bioc) {
> +               test_err("failed to allocate a btrfs_io_context");
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
> +               test_err("lookup for RAID extent [%llu, %llu] failed", lo=
gical,
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
> +       if (len !=3D SZ_64K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_64K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
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
> +               stripe->physical =3D SZ_1G + logical + i * SZ_1G;
> +       }
> +
> +       ret =3D btrfs_insert_one_raid_extent(trans, bioc);
> +       if (ret) {
> +               test_err("updating RAID extent failed: %d", ret);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0,
> +                                          &io_stripe);
> +       if (ret) {
> +               test_err("lookup for RAID extent [%llu, %llu] failed", lo=
gical,
> +                        logical + len);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical + SZ_1G) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical + SZ_1G, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len !=3D SZ_64K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_64K, len);
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
> +/*
> + * Test a simple 64k RST write on a 2 disk RAID1 at a logical address of=
 1M.
> + * The "physical" copy on device 0 is at 1M, on device 1 it is at 1G+1M.
> + */
> +static int test_simple_create_delete(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical =3D SZ_1M;
> +       u64 len =3D SZ_64K;
> +       int ret;
> +
> +       bioc =3D alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DE=
VICES);
> +       if (!bioc) {
> +               test_err("failed to allocate a btrfs_io_context");
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       bioc->map_type =3D map_type;
> +       bioc->size =3D SZ_64K;
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
> +       if (ret)  {
> +               test_err("lookup for RAID extent [%llu, %llu] failed", lo=
gical,
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
> +       if (len !=3D SZ_64K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_64K, len);
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
> +test_func_t tests[] =3D {
> +       test_simple_create_delete,
> +       test_create_update_delete,
> +};
> +
> +static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> +{
> +       struct btrfs_trans_handle trans;
> +       struct btrfs_fs_info *fs_info;
> +       struct btrfs_root *root =3D NULL;
> +       int ret;
> +
> +       fs_info =3D btrfs_alloc_dummy_fs_info(sectorsize, nodesize);
> +       if (!fs_info) {
> +               test_std_err(TEST_ALLOC_FS_INFO);
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       root =3D btrfs_alloc_dummy_root(fs_info);
> +       if (IS_ERR(root)) {
> +               test_std_err(TEST_ALLOC_ROOT);
> +               ret =3D PTR_ERR(root);
> +               goto out;
> +       }
> +       btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> +               BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
> +       root->root_key.objectid =3D BTRFS_RAID_STRIPE_TREE_OBJECTID;
> +       root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
> +       root->root_key.offset =3D 0;
> +       fs_info->stripe_root =3D root;
> +       root->fs_info->tree_root =3D root;
> +
> +       root->node =3D alloc_test_extent_buffer(root->fs_info, nodesize);
> +       if (IS_ERR(root->node)) {
> +               test_std_err(TEST_ALLOC_EXTENT_BUFFER);
> +               ret =3D PTR_ERR(root->node);
> +               goto out;
> +       }
> +       btrfs_set_header_level(root->node, 0);
> +       btrfs_set_header_nritems(root->node, 0);
> +       root->alloc_bytenr +=3D 2 * nodesize;
> +
> +       for (int i =3D 0; i < RST_TEST_NUM_DEVICES; i++) {
> +               struct btrfs_device *dev;
> +
> +               dev =3D btrfs_alloc_dummy_device(fs_info);

Still missing the error check, it can fail with ERR_PTR(-ENOMEM).

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +               dev->devid =3D i;
> +       }
> +
> +       btrfs_init_dummy_trans(&trans, root->fs_info);
> +       ret =3D test(&trans);
> +       if (ret)
> +               goto out;
> +
> +out:
> +       btrfs_free_dummy_root(root);
> +       btrfs_free_dummy_fs_info(fs_info);
> +
> +       return ret;
> +}
> +
> +int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize)
> +{
> +       int ret =3D 0;
> +
> +       test_msg("running RAID stripe-tree tests");
> +       for (int i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +               ret =3D run_test(tests[i], sectorsize, nodesize);
> +               if (ret) {
> +                       test_err("test-case %ps failed with %d\n", tests[=
i], ret);
> +                       goto out;
> +               }
> +       }
> +
> +out:
> +       return ret;
> +}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9a0fcebf34da..35c4d151b5b0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6022,9 +6022,9 @@ static int find_live_mirror(struct btrfs_fs_info *f=
s_info,
>         return preferred_mirror;
>  }
>
> -static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_i=
nfo *fs_info,
> -                                                      u64 logical,
> -                                                      u16 total_stripes)
> +EXPORT_FOR_TESTS
> +struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs=
_info,
> +                                               u64 logical, u16 total_st=
ripes)
>  {
>         struct btrfs_io_context *bioc;
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 26e35fc1c8fd..3ebb3c2732b0 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -840,4 +840,9 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_i=
nfo, u64 logical);
>  bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
>  const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
>
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> +struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs=
_info,
> +                                               u64 logical, u16 total_st=
ripes);
> +#endif
> +
>  #endif
> --
> 2.43.0
>
>

