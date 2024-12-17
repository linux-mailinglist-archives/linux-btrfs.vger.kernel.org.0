Return-Path: <linux-btrfs+bounces-10495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 710239F5161
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6296B7A179B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D411F6676;
	Tue, 17 Dec 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIy1oOAN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AB156F20
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454244; cv=none; b=Ff6WXs77PtL29H+77GCdLNbTW2RdXQ5TzHyPzwEcvfeSXzOxQNpNTbGOs+dhfZRPEmwBQsCpXki0o9jaFMaZXRLte+z8TfCfQoe7hkpKg17oxSws6JkCMVpHxc9t233EmJi3S8Ny2E5XiFm6lFO66KksxhfWa6JI+W8I9DS111w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454244; c=relaxed/simple;
	bh=AZNwxBJnfukBYsHU1LeWAZpt59iLSKms6hebZJdCbqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0qHB1wOw7h5SdYvubxYkfg6J7vyRTt1fdbrR6BPtVJnsr7soRiFFys/89zZ5GK1dE02LaNXsw+MDVBycva3rmDmEFhJh4eE4k6QwzO7Zfn0wekf0xYHxaVILrN7po16jKXcz5rzxgQpGRt+R6zEsXJ4MGLGtcL6te9fStoY8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIy1oOAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32769C4CED7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454244;
	bh=AZNwxBJnfukBYsHU1LeWAZpt59iLSKms6hebZJdCbqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dIy1oOANKWDGXnTm0uCCoed/ULCEl242A6fLtRFch8W3UOs0r6xXyTuDHzfOnbPks
	 VQIfI7+CMZFFyEDyCdadfGKqtdVaTTRvR0rx45t6lOhCZ8fTF+j3MfBgmZLDKMVp7S
	 CmKXCAFxuOivn3KFn9wvjObzLPv08qvaXFqnfjqxU97rQuWzkpsajJWdxvejXnHFtA
	 +ltar+rQjdh8sZMDc+L12zDcaoPbQf2bQM6RHEfewprz/y4ksLPQy9Qd91bBrlHftQ
	 COzxrTRXZgsFLCLBvrK786kl2SfVt5FC7u+Psn0DrxOHovNVI0qbWnvcaZbKWTqMY/
	 8MSD34ePqJC/g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aabbb507998so463395766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:50:44 -0800 (PST)
X-Gm-Message-State: AOJu0YwmSbH86iFZW4EMcZymhqxeURZzrRCgvW+Nln0nhA4m+IDu/lXe
	5zk7ovObYHVK5VUCnxrQ5AAn8YvOHwgPvsMkgzKH6Qbxonicx5TcxZdDBEpOra3saNmat7E4oKP
	MlboL2OuU8j/UaLzxwnRXW2WHjho=
X-Google-Smtp-Source: AGHT+IH4f78aunILMZ1ssTMz1zWuohtFN971/DJODYjd6qLb/mbW0S1z7HEwcroG0ym6OukT/DaIOfQwrUZVTTKUUM8=
X-Received: by 2002:a17:907:3f95:b0:aa6:8e72:e50b with SMTP id
 a640c23a62f3a-aabf1c92c14mr2916166b.56.1734454242760; Tue, 17 Dec 2024
 08:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <48a5cfb4c94de62c961f36d0a6ff9c9c24902116.1733989299.git.jth@kernel.org>
In-Reply-To: <48a5cfb4c94de62c961f36d0a6ff9c9c24902116.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:50:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H509-+tyaobkiMR04Bu89a+81BHGYqC0tkjev9p-jvbtw@mail.gmail.com>
Message-ID: <CAL3q7H509-+tyaobkiMR04Bu89a+81BHGYqC0tkjev9p-jvbtw@mail.gmail.com>
Subject: Re: [PATCH 12/14] btrfs: selftests: add selftest for punching holes
 into the RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:06=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Add a selftest for punching a hole into a RAID stripe extent. The test
> create an 1M extent and punches a 64k bytes long hole at offset of 32k fr=
om
> the start of the extent.
>
> Afterwards it verifies the start and length of both resulting new extents
> "left" and "right" as well as the absence of the hole.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 133 ++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index a815fc5c4dd3..37b87ccb5858 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -31,6 +31,138 @@ static struct btrfs_device *btrfs_device_by_devid(str=
uct btrfs_fs_devices *fs_de
>         return NULL;
>  }
>
> +/* Test punching a hole into a single RAID stripe-extent. */
> +static int test_punch_hole(struct btrfs_trans_handle *trans)
> +{
> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +       struct btrfs_io_context *bioc;
> +       struct btrfs_io_stripe io_stripe =3D { 0 };
> +       u64 map_type =3D RST_TEST_RAID1_TYPE;
> +       u64 logical1 =3D SZ_1M;
> +       u64 hole_start =3D logical1 + SZ_32K;
> +       u64 hole_len =3D SZ_64K;
> +       u64 logical2 =3D hole_start + hole_len;
> +       u64 len =3D SZ_1M;
> +       u64 len1 =3D SZ_32K;
> +       u64 len2 =3D len - len1 - hole_len;
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
> +       if (len !=3D SZ_1M) {
> +               test_err("invalid stripe length, expected %llu got %llu",
> +                        (u64)SZ_1M, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, hole_start, hole_len);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        hole_start, hole_start + hole_len);
> +               goto out;
> +       }
> +
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
> +       if (len1 !=3D SZ_32K) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_32K, len1);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical2, &len2, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical2,
> +                        logical2 + len2);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical2) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical2, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }

Should we also check that len2 remains with a value of len - len1 - hole_le=
n?

Otherwise it looks fine, thanks.

> +
> +       /* Check for the absence of the hole. */
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, hole_start, &hole_l=
en,
> +                                          map_type, 0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               ret =3D -EINVAL;
> +               test_err("lookup of RAID extent [%llu, %llu] succeeded, s=
hould fail",
> +                        hole_start, hole_start + SZ_64K);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical1, len1);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical2, len2);
> +out:
> +       btrfs_put_bioc(bioc);
> +       return ret;
> +}
> +
>  /*
>   * Test a 1M RST write that spans two adjecent RST items on disk and the=
n
>   * delete a portion starting in the first item and spanning into the sec=
ond
> @@ -612,6 +744,7 @@ static const test_func_t tests[] =3D {
>         test_tail_delete,
>         test_front_delete,
>         test_front_delete_prev_item,
> +       test_punch_hole,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> --
> 2.43.0
>
>

