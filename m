Return-Path: <linux-btrfs+bounces-10871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF17A07C6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D19188C53E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7B21D5B2;
	Thu,  9 Jan 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIyxUIwC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD414F98;
	Thu,  9 Jan 2025 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437867; cv=none; b=QOQmxypHhZQsBIINoJj/94KiWCEf6hPveaDLAw0AJ9CMFeLqDd/EJbpStbUjfU7kpNbr+6N2ecNKPzaPbH8XOEOL1QcX0V5ko9XftggwT1N4lUmTv/gHYXTyDIaI35rzhSI1T3uxCTkHRRKRejAM+AF0L4oravua+b+ODYCzwzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437867; c=relaxed/simple;
	bh=XFSgsv5defVWXZQ+ePbtNPQJygDmJivgcMBtRlttyZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnAXs1lJNDvxVdyR1C9njBMVgodioXxnq5au/V5lVnlZ5P82oy7jum3zPw9DOaYq4Sfi+JEq64PXY2VYX7GAGd1IJqO5UnhpzqH5bDAP+esWsaGE0VbemqDptqVYYhq1TGIsMNpdCwj0UMldEMArXr0GoHmFfzpv7/mZ0/9iueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIyxUIwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F14C4CED6;
	Thu,  9 Jan 2025 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437866;
	bh=XFSgsv5defVWXZQ+ePbtNPQJygDmJivgcMBtRlttyZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dIyxUIwCi/gewwcFQTUS1TMUDGAxKqcGfyXwHYwZFitOyjBokA2NpKYGNGiv4iDgP
	 gnjd8peuf28S38opM3itvz4eonuaDf/1N5OoOS5/zxeg6BsGn220BsXKYKmsyx4jiZ
	 WmxjDUxfKRDG0nRbUIxCluCuJv+yT8SDj1U1r9FOBNs2whqYTTZogDRs7/7rAuaf0a
	 oJmNHEQMsX8Zw9Nmf3dQIqtRk8DrVeHdVK85aWYj9khdC83ihlUkZykfaXjM0u1cCA
	 Qc1iyvbpA+e7NN2ipE1xbcsoPJnXCjcEuEaM5LNn6Tz0WQ1oyRUujfVDnD9MOw52rW
	 1Mpwaw4g038ow==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeef97ff02so189134266b.1;
        Thu, 09 Jan 2025 07:51:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQmdxaYRT43JfDApJfIJTie6iZigjmuyOVzLFZwED1/FY5l/+bacq4h8ydVN6cHFicdd3JEtSFdZcWraba@vger.kernel.org, AJvYcCXryrXM7wPFvMUPhpspPylfJg75mVve9fwwxVQeVf9zRWK/bVANGmMAx9Ke8r4TNuZBMAg02esXoQfImw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3whhOmLODd+c4V5I+FRJ4EH6vIqFqn69ENPYMiqsashma6eYf
	qTFQJh+EPdzBZ/Z4u8w7UiCFe5VXEOhwqZUKeP7x5TSoVpFrboeEHoBls7pq+RvyS1eIHIotOab
	BBGlvGiE9/mX8+1cWaYd1ZqxQe8Y=
X-Google-Smtp-Source: AGHT+IEs+/o+o6X1y7rDhV2qrsMCoRbF8KxWCgfi9zEXFzyyuzeTwqRASl/SHtAOrz9zjIYAgJ+BLi3Id0OtGayqWzI=
X-Received: by 2002:a17:907:94cb:b0:aa6:9332:7fa7 with SMTP id
 a640c23a62f3a-ab2abc9f4f1mr550525366b.54.1736437865014; Thu, 09 Jan 2025
 07:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-12-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-12-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 15:50:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H45TzikkAm41eiLaqZKiSmoiXGQwOKbqvjDpcwm7a_e9Q@mail.gmail.com>
X-Gm-Features: AbW1kvag3j4J3ZqEBes93_1B23i5Ga8Q-OwmCnsaQj-0vvjB5p2DMAD3i0_yk3I
Message-ID: <CAL3q7H45TzikkAm41eiLaqZKiSmoiXGQwOKbqvjDpcwm7a_e9Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] btrfs: selftests: add selftest for punching
 holes into the RAID stripe extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:51=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 140 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 140 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index a815fc5c4dd32e9b10844ad6df34f418c2e88ce7..c7e44e944f5ecc37ffb937237=
cb81fefbafbaf9a 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -31,6 +31,145 @@ static struct btrfs_device *btrfs_device_by_devid(str=
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
> +
> +       if (len2 !=3D len - len1 - hole_len) {
> +               test_err("invalid length, expected %llu, got %llu",
> +                        len - len1 - hole_len, len2);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
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
> @@ -612,6 +751,7 @@ static const test_func_t tests[] =3D {
>         test_tail_delete,
>         test_front_delete,
>         test_front_delete_prev_item,
> +       test_punch_hole,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
>
> --
> 2.43.0
>
>

