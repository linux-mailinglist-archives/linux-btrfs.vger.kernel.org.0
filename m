Return-Path: <linux-btrfs+bounces-653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C96805AEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063841C2129C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367FB692A5;
	Tue,  5 Dec 2023 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2RHd8mV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7269280;
	Tue,  5 Dec 2023 17:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F408CC433CA;
	Tue,  5 Dec 2023 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796354;
	bh=rlO4lkoCXGkMera4lmhIUIcIjy9QH55qBibOPis3qTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a2RHd8mVoTQ2i9/82HAuWPr5dmO7VjglSKdh+w6gV9Xkgq7ALWt17vrzhe2i2dD6C
	 JFxPMdvbyuuLf3ujRNnQZYv5VJunijLYLxNRqrGZyCEdeEQZ/ayxwKX1MTW9fixhpZ
	 CDuYrEPlYcag8mr6hB/dx+z/EUPd0iqGOp9tGwnA6C/sw71995a73ToLFFlr3y9Qbd
	 B1SiaK4zV8JRQntlvIYuRmhRwPIxKyGovz446/NwsLUDa0kVEubEp/drDh6LsT4KpR
	 9A3x5VHgnO7FqIurvWSMi0sRBhW1VXUQfR7fHyXgIhGembH0F2m1mdzhuUMTjiZ+lX
	 14fqpbbsQDeDw==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so7582027a12.3;
        Tue, 05 Dec 2023 09:12:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yww+bHvyQqlwEMozL8oJOoppR3X5RcNL9QW2qEhTOzy9RQY0PEX
	IHV7lwEEhVm9T9GNgttYC8SA8pjhio/J08QN79Y=
X-Google-Smtp-Source: AGHT+IEllBrCx3Xd2WGAGdqO6gqS6+tZrb24MmPH8yzeJ30/U95zv+SFnul5aRN6jc3EzuBjL7+MSuZRYpKS9WpAeIk=
X-Received: by 2002:a17:906:dc05:b0:a1c:2eb:3839 with SMTP id
 yy5-20020a170906dc0500b00a1c02eb3839mr980577ejb.67.1701796352314; Tue, 05 Dec
 2023 09:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com> <20231205-btrfs-raid-v2-3-25f80eea345b@wdc.com>
In-Reply-To: <20231205-btrfs-raid-v2-3-25f80eea345b@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Dec 2023 17:11:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
Message-ID: <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with 4k write
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, 
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 12:45=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Test a simple 4k write on all RAID profiles currently supported with the
> raid-stripe-tree.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/302     | 53 +++++++++++++++++++++++++++++++++++++++++++++++=
+
>  tests/btrfs/302.out | 58 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++

Btw, tests 302 and 303 already exist, you need to refresh your local repo.

So I tried this locally, renaming the test from 302 to 304, and it
fails on current misc-next and btrfs-progs 6.6.2:

root 17:08:09 /home/fdmanana/git/hub/xfstests > ./check btrfs/304
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.7.0-rc3-btrfs-next-143+ #1 SMP
PREEMPT_DYNAMIC Mon Dec  4 11:01:37 WET 2023
MKFS_OPTIONS  -- /dev/sdb
MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

btrfs/304       - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad)
    --- tests/btrfs/304.out 2023-12-05 17:08:16.096135003 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad
2023-12-05 17:08:18.700218463 +0000
    @@ -5,16 +5,6 @@
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo

    -raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
    -leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE=
_TREE
    -leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
    -checksum stored <CHECKSUM>
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/304.out
/home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad'  to see
the entire diff)
Ran: btrfs/304
Failures: btrfs/304
Failed 1 of 1 tests

root 17:08:18 /home/fdmanana/git/hub/xfstests > diff -u
/home/fdmanana/git/hub/xfstests/tests/btrfs/304.out
/home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad
--- /home/fdmanana/git/hub/xfstests/tests/btrfs/304.out 2023-12-05
17:08:16.096135003 +0000
+++ /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad
2023-12-05 17:08:18.700218463 +0000
@@ -5,16 +5,6 @@
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo

-raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
-leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TRE=
E
-leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
-fs uuid <UUID>
-chunk uuid <UUID>
- item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
- encoding: RAID0
- stripe 0 devid 1 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
 uuid <UUID>
@@ -23,17 +13,6 @@
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo

-raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
-leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TRE=
E
-leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
-fs uuid <UUID>
-chunk uuid <UUID>
- item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
- encoding: RAID1
- stripe 0 devid 1 physical XXXXXXXXX
- stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
 uuid <UUID>
@@ -42,17 +21,6 @@
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 5fed275e7617a806f94c173746a2a723  SCRATCH_MNT/foo

-raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
-leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TRE=
E
-leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
-checksum stored <CHECKSUM>
-checksum calced <CHECKSUM>
-fs uuid <UUID>
-chunk uuid <UUID>
- item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
- encoding: RAID10
- stripe 0 devid 1 physical XXXXXXXXX
- stripe 1 devid 2 physical XXXXXXXXX
 total bytes XXXXXXXX
 bytes used XXXXXX
-uuid <UUID>
\ No newline at end of file
+uuid <UUID>
root 17:08:34 /home/fdmanana/git/hub/xfstests >


Any ideias?

Thanks.


>  2 files changed, 111 insertions(+)
>
> diff --git a/tests/btrfs/302 b/tests/btrfs/302
> new file mode 100755
> index 000000000000..5d32ca8ba92f
> --- /dev/null
> +++ b/tests/btrfs/302
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
> +#
> +# FS QA Test 302
> +#
> +# Test on-disk layout of RAID Stripe Tree Metadata writing 4k to a new f=
ile on
> +# a pristine file system.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid remount volume raid-stripe-tree
> +
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_mkfs_feature "raid-stripe-tree"
> +_require_scratch_dev_pool 4
> +_require_btrfs_fs_feature "raid_stripe_tree"
> +
> +test_4k_write()
> +{
> +       local profile=3D$1
> +       local ndevs=3D$2
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

