Return-Path: <linux-btrfs+bounces-10492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C069F5112
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904AB169066
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3291F75A7;
	Tue, 17 Dec 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKR7J8T/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4714A609
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453104; cv=none; b=DH62dIkJXqq+1m2ULxGFBNJuL82lG30vKwOBorEUBH/rWOVjU13RflZzKvpckDVynhMbVVBfP6EeVPJHCShK/nLb+K6Hi6f3zgf6g0jzt9QzVdlm0HRzVTP7a5Trh7HfmY1AUyOZAYvwM09OXK1jFKlWdgLCovbW3JCyp5lDJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453104; c=relaxed/simple;
	bh=VlAPAJ7JnQwWVZHE31WC57hWqinWlADmutKPl6Ys6RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRObpoZZZZtu6kuUpLMq45TMEjifTX7dPQvRKeUaqWO1BPATnQTQKrgl5UKlDcLhLLwpmJ2/ufuVsVf4IsGRDeoa7F/OVftvrb1A1RwauIf+sWY1xtUqzEBaQj2NRl/JOujP92093F/ze3Dd9yonV6zhPlEmn60bzXN6kMIFhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKR7J8T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31385C4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453104;
	bh=VlAPAJ7JnQwWVZHE31WC57hWqinWlADmutKPl6Ys6RI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EKR7J8T/3c1dLOg5CPVxhJAoKfPOo5HiUYe9BldsbHn3edf47Mrow0wm7lzjmCwMi
	 INSl9cOCMW4cUGFduX6txUgVMq2DuwdEjrRVnG8pvrO9IhifruwyEfJowQuhnETr4R
	 Vo2t58x2joM/tHVjc1awViXSdPX+3hQK45QjVrEEaHjE4Kdsewte8cdodJdKznHuQC
	 ixhGA0oVJ0NA/2yeYmNrtOgs8/pRLZzedxhZN6ckIta4mbekCFeUPkqKzPMTBcIxoN
	 52txCXVAXVn0baUGaQtCxxxjZUZcNzNJ35gBKWyK5lwa1sz0CGd0kZ3Ypzg4FfBBQq
	 tIZ9xyMe+VWgA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso761654766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:31:44 -0800 (PST)
X-Gm-Message-State: AOJu0YzjsSZYHcqF36D/R6TW4ipyvsTC4PCeuhR5ww0kvpMmodDthrsq
	O87B9TkHIseGmsY+AD94KL62m1L19chVZViEfSY2YMYpkqsLJf+bcLXXrJt+NhTXYypqvegUw99
	Olfj+uz/1b8r2jIwzrg4930B1ou4=
X-Google-Smtp-Source: AGHT+IH1zQD/gpNr9sx5i3YOnAhqKtsbcaLEMl7ZBDHv/m0ppVbcaFBlea4dcEaHCd/GEh7msa21KIpeSRjlX78Qy9g=
X-Received: by 2002:a05:6402:4584:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d63c318beemr38655305a12.8.1734453102714; Tue, 17 Dec 2024
 08:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733989299.git.jth@kernel.org> <9cabbac863682a0da549d04d37e785a11a9b51c0.1733989299.git.jth@kernel.org>
In-Reply-To: <9cabbac863682a0da549d04d37e785a11a9b51c0.1733989299.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 16:31:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7CiHcbPvTzsA7hoocj1tD4xLQMoSunfEDOQjDjTkc2UQ@mail.gmail.com>
Message-ID: <CAL3q7H7CiHcbPvTzsA7hoocj1tD4xLQMoSunfEDOQjDjTkc2UQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] btrfs: selftests: don't split RAID extents in half
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
> The selftests for partially deleting the start or tail of RAID
> stripe-extents split these extents in half.
>
> This can hide errors in the calculation, so don't split the RAID
> stripe-extents in half but delete the first or last 16K of the 64K
> extents.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 44 ++++++++++++++++---------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/rai=
d-stripe-tree-tests.c
> index 19f6147a38a5..12f3dbb23a64 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -14,6 +14,8 @@
>  #define RST_TEST_NUM_DEVICES   (2)
>  #define RST_TEST_RAID1_TYPE    (BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GRO=
UP_RAID1)
>
> +#define SZ_48K (SZ_32K + SZ_16K)
> +
>  typedef int (*test_func_t)(struct btrfs_trans_handle *trans);
>
>  static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_device=
s *fs_devices,
> @@ -94,32 +96,32 @@ static int test_front_delete(struct btrfs_trans_handl=
e *trans)
>                 goto out;
>         }
>
> -       ret =3D btrfs_delete_raid_extent(trans, logical, SZ_32K);
> +       ret =3D btrfs_delete_raid_extent(trans, logical, SZ_16K);
>         if (ret) {
>                 test_err("deleting RAID extent [%llu, %llu] failed", logi=
cal,
> -                        logical + SZ_32K);
> +                        logical + SZ_16K);
>                 goto out;
>         }
>
> -       len =3D SZ_32K;
> -       ret =3D btrfs_get_raid_extent_offset(fs_info, logical + SZ_32K, &=
len,
> +       len -=3D SZ_16K;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical + SZ_16K, &=
len,
>                                            map_type, 0, &io_stripe);
>         if (ret) {
>                 test_err("lookup of RAID extent [%llu, %llu] failed",
> -                        logical + SZ_32K, logical + SZ_32K + len);
> +                        logical + SZ_16K, logical + SZ_64K);
>                 goto out;
>         }
>
> -       if (io_stripe.physical !=3D logical + SZ_32K) {
> +       if (io_stripe.physical !=3D logical + SZ_16K) {
>                 test_err("invalid physical address, expected %llu, got %l=
lu",
> -                        logical + SZ_32K, io_stripe.physical);
> +                        logical + SZ_16K, io_stripe.physical);
>                 ret =3D -EINVAL;
>                 goto out;
>         }
>
> -       if (len !=3D SZ_32K) {
> +       if (len !=3D SZ_48K) {
>                 test_err("invalid stripe length, expected %llu, got %llu"=
,
> -                        (u64)SZ_32K, len);
> +                        (u64)SZ_48K, len);
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> @@ -128,11 +130,11 @@ static int test_front_delete(struct btrfs_trans_han=
dle *trans)
>         if (ret !=3D -ENODATA) {
>                 ret =3D -EINVAL;
>                 test_err("lookup of RAID extent [%llu, %llu] succeeded, s=
hould fail",
> -                        logical, logical + SZ_32K);
> +                        logical, logical + SZ_16K);
>                 goto out;
>         }
>
> -       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K)=
;
> +       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_16K, SZ_48K)=
;
>  out:
>         btrfs_put_bioc(bioc);
>         return ret;
> @@ -209,14 +211,14 @@ static int test_tail_delete(struct btrfs_trans_hand=
le *trans)
>                 goto out;
>         }
>
> -       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K)=
;
> +       ret =3D btrfs_delete_raid_extent(trans, logical + SZ_48K, SZ_16K)=
;
>         if (ret) {
>                 test_err("deleting RAID extent [%llu, %llu] failed",
> -                        logical + SZ_32K, logical + SZ_64K);
> +                        logical + SZ_48K, logical + SZ_64K);
>                 goto out;
>         }
>
> -       len =3D SZ_32K;
> +       len =3D SZ_48K;
>         ret =3D btrfs_get_raid_extent_offset(fs_info, logical, &len, map_=
type, 0, &io_stripe);
>         if (ret) {
>                 test_err("lookup of RAID extent [%llu, %llu] failed", log=
ical,
> @@ -231,9 +233,19 @@ static int test_tail_delete(struct btrfs_trans_handl=
e *trans)
>                 goto out;
>         }
>
> -       if (len !=3D SZ_32K) {
> +       if (len !=3D SZ_48K) {
>                 test_err("invalid stripe length, expected %llu, got %llu"=
,
> -                        (u64)SZ_32K, len);
> +                        (u64)SZ_48K, len);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       len =3D SZ_16K;
> +       ret =3D btrfs_get_raid_extent_offset(fs_info, logical + SZ_48K, &=
len,
> +                                          map_type, 0, &io_stripe);
> +       if (ret !=3D -ENODATA) {
> +               test_err("lookup of RAID extent [%llu, %llu] succeeded sh=
ould fail",
> +                        logical + SZ_48K, logical + SZ_64K);
>                 ret =3D -EINVAL;
>                 goto out;
>         }
> --
> 2.43.0
>
>

