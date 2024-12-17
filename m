Return-Path: <linux-btrfs+bounces-10497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F69F5180
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3416E7A4E5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD171F75BC;
	Tue, 17 Dec 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCI3MhML"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D21F8679
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454822; cv=none; b=Wi2EvTyaBmVhnx0Q4PVHNDITUPjtGA6IOlVRkXqhbe1O5ors5+RF5gufLF5Oq19T0vGZZQCTqb0YxTU+RA3zDZx3dbGGfSiZrjy8OpGjIUWpiDTMBovPczyASwFrq4sYcTzbhvACDYBmEsYFXvHFx5JAqdZrHW3dCTqDab0F/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454822; c=relaxed/simple;
	bh=Hov7tCYT+U5jIYihHbbFuggf78VgtT77Jhz9G9B4p8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPaxTUa1r/NbkllSJDTJt10UGqy9X1Nb6QY7gv7myAtiGp1UKMMVxfy/LgIY7cx2Z9/zfryta1QNcmOJ5cbpYqdVnivwnSlbcelvsZC2xRgSO2e0UgSAa8SEaCzBzKxcC9a3rt6NxCci206GjJ+GDrPIQAnuR6OgSVcje0kMIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCI3MhML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95588C4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454821;
	bh=Hov7tCYT+U5jIYihHbbFuggf78VgtT77Jhz9G9B4p8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hCI3MhMLCmXKkc6+SC56dJ33oBotF5jm3Dqq5rHHizL0YkIyWmo1CfD6C1Zkl/bk0
	 U5EuDIq/YRyB6x3b7WakHPcpFuR/agPqBtMyFBST0QFZoC8AB5LFt1x5Vi0WQnkpSf
	 ejqrdqjg7J9f35CCldYabFc6FHIdTkNFSBDOIcT9Dyqengyxi9AVVkoHyoPWfREgc4
	 5odgdlVepe4o1SK4Zkf3XYp2CidtOYrUwDtVA4cB+4uRqkW5bllK5283RI2yepxZQN
	 4P41OFefUq7G7R4z9HltL+wIUC1J3Wde7/C3y8sryYMWwRIGUU+XG7ry7dfB9i10z7
	 ri5xrhBDcL1vg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso790324766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 09:00:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyhOXzSnxAGFz5LtiLFdAjvJYb2qjAAvlXB3EJE0B85GDxvpnt0
	gMTOuH5Q+eEkIEK5QsGDk4GDYavQmRAMOEIjjfO1x6KEFqw6a/gSPQF5MV3KpX/BO2idkJ4c/Zp
	qnZBb7a+FY4VNzGUxfoY2Sibf0a0=
X-Google-Smtp-Source: AGHT+IFBl+CNEycWeAJGGrtw7aPqY+kzgQQ7DrKhA+B/Gs941fmffuxrenUP9M+qNx9kn9+Qaj0L+Mfm5uxAXuxABKY=
X-Received: by 2002:a17:907:3e1d:b0:aa6:800a:1292 with SMTP id
 a640c23a62f3a-aab779ab53dmr1807057866b.25.1734454820102; Tue, 17 Dec 2024
 09:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <8b38b12a3a1f3ead232143bbab1829ecff3b570f.1733989299.git.jth@kernel.org>
In-Reply-To: <8b38b12a3a1f3ead232143bbab1829ecff3b570f.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:59:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ESbzAq8vXok-i0B_iwhbM0gJOWug34f8OLa8vK_gvRg@mail.gmail.com>
Message-ID: <CAL3q7H7ESbzAq8vXok-i0B_iwhbM0gJOWug34f8OLa8vK_gvRg@mail.gmail.com>
Subject: Re: [PATCH 14/14] btrfs: selftests: add a selftest for deleting two
 out of three extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:57=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Add a selftest creating three extents and then deleting two out of the
> three extents.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 8d74e95a8a75..29c45f75941f 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -213,6 +213,149 @@ static int test_punch_hole_3extents(struct btrfs_tr=
ans_handle *trans)
>         return ret;
>  }
>
> +static int test_delete_two_extents(struct btrfs_trans_handle *trans)
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

Same thing about the comment style as before (sorry).

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
> +        * Delete a range starting at logical1 and 2M in length. Extents =
1 and 2
> +        * are is dropped and extent 3 is kept as is.

Extra "is" after "are".

Otherwise it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> +        */
> +       ret =3D btrfs_delete_raid_extent(trans, logical1, len1 + len2);
> +       if (ret) {
> +               test_err("deleting RAID extent [%llu, %llu] failed",
> +                        logical1, logical1 + len1 + len2);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical1, &len1, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               test_err("lookup of RAID extent [%llu, %llu] suceeded, sh=
ould fail\n",
> +                        logical1, len1);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical2, &len2, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               test_err("lookup of RAID extent [%llu, %llu] suceeded, sh=
ould fail\n",
> +                        logical2, len2);
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical3, &len3, ma=
p_type,
> +                                          0, &io_stripe);
> +       if (ret) {
> +               test_err("lookup of RAID extent [%llu, %llu] failed\n",
> +                        logical3, len3);
> +               goto out;
> +       }
> +
> +       if (io_stripe.physical !=3D logical3) {
> +               test_err("invalid physical address, expected %llu, got %l=
lu",
> +                        logical3, io_stripe.physical);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (len3 !=3D SZ_1M) {
> +               test_err("invalid stripe length, expected %llu, got %llu"=
,
> +                        (u64)SZ_1M, len3);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       ret =3D btrfs_delete_raid_extent(trans, logical3, len3);
> +out:
> +       btrfs_put_bioc(bioc);
> +       return ret;
> +}
> +
>  /* Test punching a hole into a single RAID stripe-extent. */
>  static int test_punch_hole(struct btrfs_trans_handle *trans)
>  {
> @@ -928,6 +1071,7 @@ static const test_func_t tests[] =3D {
>         test_front_delete_prev_item,
>         test_punch_hole,
>         test_punch_hole_3extents,
> +       test_delete_two_extents,
>  };
>
>  static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
> --
> 2.43.0
>
>

