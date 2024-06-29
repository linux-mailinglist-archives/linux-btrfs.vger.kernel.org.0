Return-Path: <linux-btrfs+bounces-6051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89C91CC2E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2024 12:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BC41F22455
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jun 2024 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586AE4502B;
	Sat, 29 Jun 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcLhw2Zp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CA2262B;
	Sat, 29 Jun 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719658276; cv=none; b=C95rHJfXdTZ0R2gzEY18p+3w72SEMziPFoLCTKyA4pO1lnE0J/Iz2KHcv/AfhqMPl+U7PX84QZnq/uh8b05SxrWy9DQaFfmEYIfxTmmzwEQb+FQ7rtiwMsJVhIt38LdMmzAyPaugx2HLS2CXoQHlFZugLOsmWG6rCbMCWVd55CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719658276; c=relaxed/simple;
	bh=p/wmaTJoHs1BsEu/GBT6r7pZpb4RPxYcmbCyuVf0yh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWU4PXFMZxdo5xFw25g5lKwzz1TFcDPvmmKIlWWRPlBCBSAbj7lZdw5a4QUVaQGgvnKdxub4Tb4Xx2VyUbb4c/l2+eiDPqngKOLt4vpcc3s6bgcNrzni+9D1v4/WTJAvagEdDhhbS/3L8WjgIAl60vyRbOP7Yv2vjEYAp1yqJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcLhw2Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE47CC2BBFC;
	Sat, 29 Jun 2024 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719658276;
	bh=p/wmaTJoHs1BsEu/GBT6r7pZpb4RPxYcmbCyuVf0yh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pcLhw2Zp+tnz8g/Wzpm5/ee0ytcOQUw4b5ianw08GyVIfIEj3LBZx9Vh6IencN7pr
	 Jf0Gkemol1Igsr8/6f+MAr0xM0YI8Z4AEyhj50H3c9Er1/LdEgedw5BiSSj3obaxPr
	 mb+MwG7oWM7yQgHCNm7NeefZ03UktCDzCnf6SMsahGK0FZxyB8QnIbrAd2yCL2u722
	 EgjEu3RKqdfZZjqxUljzDQ1vnBP0/9R6RzG+WOMFSnOjPhbsLvkbIV6hSfiyAsGPJg
	 kzJ2lw4q4rOvhTb0bDGhHI9qtusPQlO8nfSPulR+JTMAbanvIlTwHeBHY56vg061SO
	 RbVdlA1PRLyGw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so169833066b.2;
        Sat, 29 Jun 2024 03:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbSF68uRPs7rgVRYwpI+i4glM7HjL+zvKWJ1qf5N6zE1UWJRycax2QpHB6LERxdO4Wm/Kp8ynPLoUDFPCnP6fRZwQVyeDO3g==
X-Gm-Message-State: AOJu0YxB3DZsoBo0/91Kuw02akfUOfGQab4fH9ky1GJowfM42OUpc0sd
	YzdiOy+j/eHGcVhk438k7fZy1cEuBUiZRADhpnWp1JsalY811n8gn+NxwAbag+JTaOZ0Mu+NrDS
	PMCxVLpXIMh/lbZzBBUnQIZeBRXU=
X-Google-Smtp-Source: AGHT+IE5bQwYvjUrn5DqjWhfe4Il/+jrCI/KyytOiGuDV3SutRFI86QfNgXVyT2mAEOUEs16DT8ggA5j/BO8jo5HLZo=
X-Received: by 2002:a17:907:6088:b0:a6f:b5ff:a6fd with SMTP id
 a640c23a62f3a-a75142d87e6mr63016266b.12.1719658274526; Sat, 29 Jun 2024
 03:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627094722.24192-1-jth@kernel.org>
In-Reply-To: <20240627094722.24192-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 29 Jun 2024 11:50:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5coRxND9EwUkzOyLSp2cLKWirbEueiuATegytfBChRaQ@mail.gmail.com>
Message-ID: <CAL3q7H5coRxND9EwUkzOyLSp2cLKWirbEueiuATegytfBChRaQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: update golden output of RST test cases
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>, 
	Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:47=E2=80=AFAM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Update the golden output of the RAID stripe tree test cases after the
> on-disk format and print format changes.

Better to mention here that the on-disk format changes happened:

1) For btrfs-progs 6.9.1, with commit 7c549b5f7cc0 ("btrfs-progs:
remove raid stripe encoding";

2) For the kernel, with the patch "btrfs: remove raid-stripe-tree
encoding field from stripe_extent", which is not yet in Linus' tree;

And that we don't need to ensure compatibility with different
btrfs-progs and kernel versions because it's an experimental feature,
subject to changes until stabilized.

Other than that it looks good, it makes the tests pass with the
for-next btrfs kernel branch and btrfs-progs 6.9.1+.

Thanks.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/304.out |  9 +++------
>  tests/btrfs/305.out | 24 ++++++++----------------
>  tests/btrfs/306.out | 18 ++++++------------
>  tests/btrfs/307.out | 15 +++++----------
>  tests/btrfs/308.out | 39 +++++++++++++--------------------------
>  5 files changed, 35 insertions(+), 70 deletions(-)
>
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> index 39f56f32274d..97ec27455b01 100644
> --- a/tests/btrfs/304.out
> +++ b/tests/btrfs/304.out
> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
> index 7090626c3036..02642c904b1e 100644
> --- a/tests/btrfs/305.out
> +++ b/tests/btrfs/305.out
> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
> index 25065674c77b..954567db7623 100644
> --- a/tests/btrfs/306.out
> +++ b/tests/btrfs/306.out
> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
> index 2815d17d7f03..e2f1d3d84a68 100644
> --- a/tests/btrfs/307.out
> +++ b/tests/btrfs/307.out
> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
>  total bytes XXXXXXXX
> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
> index 23b31dd32959..75e010d54252 100644
> --- a/tests/btrfs/308.out
> +++ b/tests/btrfs/308.out
> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>                         stripe 0 devid 2 physical XXXXXXXXX
> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
> -                       encoding: RAID0
> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>                         stripe 0 devid 1 physical XXXXXXXXX
>  total bytes XXXXXXXX
>  bytes used XXXXXX
> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID1
> +       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>  checksum calced <CHECKSUM>
>  fs uuid <UUID>
>  chunk uuid <UUID>
> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>                         stripe 0 devid 3 physical XXXXXXXXX
>                         stripe 1 devid 4 physical XXXXXXXXX
> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -                       encoding: RAID10
> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>                         stripe 0 devid 1 physical XXXXXXXXX
>                         stripe 1 devid 2 physical XXXXXXXXX
>  total bytes XXXXXXXX
> --
> 2.43.0
>
>

