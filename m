Return-Path: <linux-btrfs+bounces-570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE580395B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24581F211AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561392D05D;
	Mon,  4 Dec 2023 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiuze3qT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A42C87D;
	Mon,  4 Dec 2023 15:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB986C433C9;
	Mon,  4 Dec 2023 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701705566;
	bh=wUvaW2WBFFWOm+BjvuRxx5B6h8PwUfRkrKqvoO+S1Ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iiuze3qTJqY0ZTaLDWQUIF2NRGmLmhT5cPqKSOBEdoxD8APLf12zSaLU4i9VMMfx/
	 AsFWl3mLBrBPFTvCH8sjW5WCx+wYnZ/LjsuCRgl3LJY9Cuc1J0ZK2Q7np7ffWTdyvp
	 c3X7Nv7q/CrHH8EhPoZ1yaJNboPu0+W8LmV93MgYFMbUVpFSAae18KwvAZxv2OGBc6
	 PJgmCCiIuajRmwBelE80Vr1cGWsRdGBuk05rKbN/FbheErA8T/rRiBueScNgDoaTHX
	 0f7JJs8ciHfzV+Zpmb3tCKGeC/R8chOXuK3E7wxHPamJV+Wu6o7L6SN+CzxPhOejcp
	 1Yt9eC0AxAlOg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1a496a73ceso417364466b.2;
        Mon, 04 Dec 2023 07:59:26 -0800 (PST)
X-Gm-Message-State: AOJu0Ywib7KYMQ6Y3r1LQZqsGiyEGU8UI9Crc0G91Xo/3ju2AeRCP0NW
	4z0jIH1NJMobF9OsKgli6NBrvkBFiKBg0iGmr3I=
X-Google-Smtp-Source: AGHT+IFZikvRXz7xJe/MSqAj5aHRG2tIGIeVIfp1iKGY6Wd/BXEaxjGWkA6LP0xDBbcEyHZhWF6L2QwTmsD2sla07JM=
X-Received: by 2002:a17:906:710f:b0:a19:a19b:78cb with SMTP id
 x15-20020a170906710f00b00a19a19b78cbmr3199252ejj.142.1701705565302; Mon, 04
 Dec 2023 07:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com> <20231204-btrfs-raid-v1-1-b254eb1bcff8@wdc.com>
In-Reply-To: <20231204-btrfs-raid-v1-1-b254eb1bcff8@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 4 Dec 2023 15:58:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4hHiOpN9v1DnKeU166yp2p78Hy+_g4VZ6k9G9CM83a9g@mail.gmail.com>
Message-ID: <CAL3q7H4hHiOpN9v1DnKeU166yp2p78Hy+_g4VZ6k9G9CM83a9g@mail.gmail.com>
Subject: Re: [PATCH 1/7] btrfs: add fstest for stripe-tree metadata with 4k write
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 1:25=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Test a simple 4k write on all RAID profiles currently supported with the
> raid-stripe-tree.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/302     | 55 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  tests/btrfs/302.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 113 insertions(+)
>
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> new file mode 100755
> index 000000000000..1d6693beff4c
> --- /dev/null
> +++ b/tests/btrfs/302
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
> +#
> +# FS QA Test 302
> +#
> +# Test on-disk layout of RAID Stripe Tree Metadata

All the tests in the patchset have this exact same description.
Can we get a more specific description for each one?

> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid remount volume raid-stripe-tree
> +
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_test

The test device is not used, this is not needed.

> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_mkfs_feature "raid-stripe-tree"
> +_require_scratch_dev_pool 4
> +_require_xfs_io_command "pwrite"
> +_require_xfs_io_command "fsync"

This can be skipped, the checks for the pwrite and fsync commands.
We never check for those as all xfs_io versions should have those, as
they belong to the most basic and universally available commands.

> +_require_btrfs_fs_feature "raid_stripe_tree"
> +
> +test_4k_write()
> +{
> +       profile=3D$1
> +       ndevs=3D$2

These variables should be made local.

All these comments also apply to all the other tests introduced in the patc=
hset.

Thanks.

> +
> +       _scratch_dev_pool_get $ndevs
> +
> +       echo "=3D=3D=3D=3D Testing $profile =3D=3D=3D=3D"
> +       _scratch_pool_mkfs -d $profile -m $profile
> +       _scratch_mount
> +
> +       $XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_i=
o
> +
> +       _scratch_cycle_mount
> +       md5sum "$SCRATCH_MNT/foo" | _filter_scratch
> +
> +       _scratch_unmount
> +
> +       $BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRAT=
CH_DEV_POOL |\
> +               _filter_btrfs_version |  _filter_stripe_tree
> +
> +       _scratch_dev_pool_put
> +}
> +
> +echo "=3D Test basic 4k write =3D"
> +test_4k_write raid0 2
> +test_4k_write raid1 2
> +test_4k_write raid10 4
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
> new file mode 100644
> index 000000000000..149630e69501
> --- /dev/null
> +++ b/tests/btrfs/302.out
> @@ -0,0 +1,58 @@
> +QA output created by 302
> +=3D Test basic 4k write =3D
> +=3D=3D=3D=3D Testing raid0 =3D=3D=3D=3D
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_T=
REE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> +                       encoding: RAID0
> +                       stripe 0 devid 1 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
> +=3D=3D=3D=3D Testing raid1 =3D=3D=3D=3D
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_T=
REE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> +                       encoding: RAID1
> +                       stripe 0 devid 1 physical XXXXXXXXX
> +                       stripe 1 devid 2 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
> +=3D=3D=3D=3D Testing raid10 =3D=3D=3D=3D
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo
> +
> +raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
> +leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_T=
REE
> +leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
> +checksum stored <CHECKSUM>
> +checksum calced <CHECKSUM>
> +fs uuid <UUID>
> +chunk uuid <UUID>
> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> +                       encoding: RAID10
> +                       stripe 0 devid 1 physical XXXXXXXXX
> +                       stripe 1 devid 2 physical XXXXXXXXX
> +total bytes XXXXXXXX
> +bytes used XXXXXX
> +uuid <UUID>
>
> --
> 2.43.0
>
>

