Return-Path: <linux-btrfs+bounces-9102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2119AD32E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 19:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E23285569
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE31CF299;
	Wed, 23 Oct 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goy4bZ1K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8E13D896
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705588; cv=none; b=oJZzR+zpnjjxWqiG9RfJk3Hk9UttezMpu77W3TObVDH0qe4J2Z+/OrNIpQKG4vQN/au70+uAlp7RAWBl2QnMxQXh+nm+LcSkzeGqTBpQwvFibbAiVcJVvockfNaoY60UX0pBu59tb/+2jyPgSCZRYW+yg3aYeRFqnP5nkPIBJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705588; c=relaxed/simple;
	bh=zqm870NF1rQwMrsZtS2cOzxlHYGTErz5v22e+82mHoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+gXaZriD0llDTXmGgwRV/QlmyrmSVayXGs2n/3+U9p1rvWXKNWOjuNA1zGNcRE3YlR4pmLcM4hFRrFQQZscgSiaA60rlNNksF0NJ+8NOlWQCIyRTmmwoH2uEqf4lyQf1Na9G4clNjsf5eK9wBw5A4c34oDqu6/KboYJh2GP3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goy4bZ1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C86FC4AF09
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729705588;
	bh=zqm870NF1rQwMrsZtS2cOzxlHYGTErz5v22e+82mHoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=goy4bZ1KvohfxUyP5qo4xe4PkEzBNniS6DTtBpegIxX27FVArNS9seUBkvev7dIb3
	 6zfxLuQsmp30CYhvrSg1NhA0I2p7FGnUYWX03Zd1iB4DJnwIyI2rZnF7FeelxRqVdT
	 LYBWUvEKBJZls7W4ld0yAnY76iQ4KrT1mJD1gF/A8TmrrgQ5CMuPJDYEoiYpZZPGld
	 hQKj669aTnJz9oID7t89rGZcuqZ8yOscbfjNoByfGONScvvZROCuM79n8EiXGNerqZ
	 GSgKFmUlse+2dmOUj2RcgXBi/8Z33D49b3vfkSAft/6HlEOFPY7X0UJ8e6Jx6OKcNu
	 maRKf66GFdGlA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c94b0b466cso46554a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 10:46:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YybPrPyGEsNwLBKjMRWJ9hdppE3ujueYBGCuvXgqLFz2NdySNk+
	bAaVg2bOjJC0wikL35/E2Y4n2xa+JrO+he+KVkAxJMiqGBIoUFz2tJ39XIzSvTWEnsBRVzCkHsz
	grRjybuj2dsc+w7230Pqr9059rZs=
X-Google-Smtp-Source: AGHT+IEffxHpBUrvRP8sujxp8Le2WmOyqYYmB/qZPbwajyBSjCC1gmn5yq8qadONWQTSukmKdJoZQbq2OzK7QsMejB8=
X-Received: by 2002:a17:906:dc92:b0:a99:f28f:687 with SMTP id
 a640c23a62f3a-a9abf92df5fmr303151366b.40.1729705586702; Wed, 23 Oct 2024
 10:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023132518.19830-1-jth@kernel.org> <20241023132518.19830-3-jth@kernel.org>
In-Reply-To: <20241023132518.19830-3-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Oct 2024 18:45:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7houfrJjOOnmpA6T4xQDa-y1AqsA1AKBQZuOV4ygUVMA@mail.gmail.com>
Message-ID: <CAL3q7H7houfrJjOOnmpA6T4xQDa-y1AqsA1AKBQZuOV4ygUVMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] btrfs: implement self-tests for partial RAID
 srtipe-tree delete
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:25=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
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
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 224 ++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index b8013ab13c43..3e6932de5623 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -29,6 +29,228 @@ static struct btrfs_device *btrfs_device_by_devid(str=
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
> +       btrfs_put_bioc(bioc);
> + out:

The btrfs_put_bioc(bioc) call needs to be put under the 'out' label,
otherwise we will leak it in case an error happens.
It is correct in the next test function, but not in this one.

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
> @@ -235,6 +457,8 @@ static int test_simple_create_delete(struct btrfs_tra=
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

