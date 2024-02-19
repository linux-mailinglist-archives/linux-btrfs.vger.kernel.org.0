Return-Path: <linux-btrfs+bounces-2521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71085A4A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 14:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EB11F2473F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580336AE1;
	Mon, 19 Feb 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFDp3qfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC6364B8;
	Mon, 19 Feb 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349387; cv=none; b=hfZTb1sxlsL1c5mCsCjh/raPUfMwSkZEP34hAuVcsXv7sLsZdOpkcntpWDq3P8T3dR+om3/5Yu5NEc0AQr6HIoUiOW7qNbm6O36fJBeLvs7ske2q/Nh3hWC/g8rh2B8l4u6q1G/3wvCw3SGxM0HWT96rohDxJkBs5BGOlfV9Ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349387; c=relaxed/simple;
	bh=Y5UzJYRiDU28XlxmCnqX4l+H0rrTv7XK+utp1ECxtqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=babqrfYZky/WxwOjLDkdWOnN2hs+9oh8ozenujE7K7pV5A91odmkWcAPJQRH/XkEcyhzwxMZQz78Zq0vkaALrlzRiTLAKjWT9eT7EGCiTlDrz4xrjN4aoreRHLSx4ZM6P0USXPe25f8VfjHtsPwQbckhGkyQEjbRjGeQHAAoj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFDp3qfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815B4C433F1;
	Mon, 19 Feb 2024 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708349386;
	bh=Y5UzJYRiDU28XlxmCnqX4l+H0rrTv7XK+utp1ECxtqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OFDp3qfnWKtuNzHDQzKKhT3dVIP2sC0PnmaAIvrzWxaw84AE64V0rJzj6/CFtAtt1
	 EHmpKfh3TWD9Yzp0T6yg56t5a8u+3RgFtXROAUtNvKrILTgPRIt/h4lTHccEt+e0Lg
	 15C2hr+iBHMZMb6cxUI/wemUETdKl4NsDbhXwiLsdwNbCo5aJO5Zb/SoEar0DN/bfU
	 LuS0izgX+65pS2NZK1tkt8XfsnLTAVKHvLxyEK53Fxu/PT5xqm56rJnTVg0YjbvK6U
	 PohL3a0u2wPIajSW93faAnOS65nRwQ8L1H8hg8bdN7mourCDQRMc0B4phDCMW49d6N
	 OqrA2gK39GC0w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d484a58f6so560684166b.3;
        Mon, 19 Feb 2024 05:29:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6pRb8zGkVmeFnPsqxgkm0tupb1CLkbvTiDrD0zkFfRImaBLcaim5N1LRDbRxsLazYaF9d9QGYO02EIdqj9O2uftKKIQc6x5ifB1A=
X-Gm-Message-State: AOJu0YxS8vf+gHvss3Y2FY6pgMqkIYgNYc54P7kd9mpyw7JT6bDOIgM5
	Yw73eR9E74teYDsLVExd8tyj/oCvqvn2awqgqW+AD3EHgZEfe7PuhkkL57b241lZQ15FObRMR1z
	NwWYJsYUEwKVzwKdMygUw2RdNrTc=
X-Google-Smtp-Source: AGHT+IFynw0A8C1JawaUwbi351syygdwJCz/LweSRE2E4WEaW5Sn4ZUXUOAQ7h8d4kOZSIyOyBA1s7NreUsT4VZfJA0=
X-Received: by 2002:a17:906:8cf:b0:a3e:aadd:f962 with SMTP id
 o15-20020a17090608cf00b00a3eaaddf962mr1350354eje.62.1708349384838; Mon, 19
 Feb 2024 05:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
 <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com> <c754b3c6-040c-44bd-9e50-ce95f4c4c4c7@oracle.com>
In-Reply-To: <c754b3c6-040c-44bd-9e50-ce95f4c4c4c7@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 19 Feb 2024 13:29:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H45Sm1JMTHHpvBP9hB3ogOgRpq9cXyAQ9n9-oyPxdAMVQ@mail.gmail.com>
Message-ID: <CAL3q7H45Sm1JMTHHpvBP9hB3ogOgRpq9cXyAQ9n9-oyPxdAMVQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] btrfs: test tempfsid with device add, seed, and balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:18=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> On 2/15/24 18:33, Filipe Manana wrote:
> > On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.c=
om> wrote:
> >>
> >> Make sure that basic functions such as seeding and device add fail,
> >> while balance runs successfully with tempfsid.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   common/filter.btrfs |  6 ++++
> >>   tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/315.out | 11 +++++++
> >>   3 files changed, 96 insertions(+)
> >>   create mode 100755 tests/btrfs/315
> >>   create mode 100644 tests/btrfs/315.out
> >>
> >> diff --git a/common/filter.btrfs b/common/filter.btrfs
> >> index 8ab76fcb193a..d48e96c6f66b 100644
> >> --- a/common/filter.btrfs
> >> +++ b/common/filter.btrfs
> >> @@ -68,6 +68,12 @@ _filter_btrfs_device_stats()
> >>          sed -e "s/ *$NUMDEVS /<NUMDEVS> /g"
> >>   }
> >>
> >> +_filter_btrfs_device_add()
> >> +{
> >> +       _filter_scratch_pool | \
> >> +               sed -E 's/\(([0-9]+(\.[0-9]+)?)[a-zA-Z]+B\)/\(NUM\)/'
> >
> > Why do we need this new filter?
> > We are testing for a failure, where none of this is relevant except
> > filtering device names.
> >
>
> 2nd part filters out the size part as seen in the raw
> btrfs device add output below.
>
> $ btrfs device add /dev/sdb2 /btrfs
> Performing full device TRIM /dev/sdb2 (731.00MiB) ...
>
> I will add a comment.

So that means the test will fail the golden output if the device does
not support trim,
as in that case progs does not do the trim.

That line about performing TRIM must be filtered out. Replacing the
size with NUM is irrelevant.

Thanks.


>
> > The test can just filter with  _filter_scratch_pool only.
> >
> >> +}
> >> +
> >>   _filter_transaction_commit() {
> >>          sed -e "/Transaction commit: none (default)/d" \
> >>              -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolu=
me/g" \
> >> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> >> new file mode 100755
> >> index 000000000000..7ad0dfbc9c32
> >> --- /dev/null
> >> +++ b/tests/btrfs/315
> >> @@ -0,0 +1,79 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
> >> +#
> >> +# FS QA Test 315
> >> +#
> >> +# Verify if the seed and device add to a tempfsid filesystem fails.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick volume seed tempfsid
> >> +
> >> +_cleanup()
> >> +{
> >> +       cd /
> >> +       umount $tempfsid_mnt 2>/dev/null
> >
> > $UMOUNT_PROG
> >
>
> got it.
>
> >> +       rm -r -f $tmp.*
> >> +       rm -r -f $tempfsid_mnt
> >> +}
> >> +
> >> +. ./common/filter.btrfs
> >> +
> >> +_supported_fs btrfs
> >> +_require_btrfs_sysfs_fsid
> >> +_require_scratch_dev_pool 3
> >> +_require_btrfs_fs_feature temp_fsid
> >> +_require_btrfs_command inspect-internal dump-super
> >> +_require_btrfs_mkfs_uuid_option
> >> +
> >> +_scratch_dev_pool_get 3
> >> +
> >> +# mount point for the tempfsid device
> >> +tempfsid_mnt=3D$TEST_DIR/$seq/tempfsid_mnt
> >> +
> >> +seed_device_must_fail()
> >> +{
> >> +       echo ---- $FUNCNAME ----
> >> +
> >> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >> +
> >> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
> >> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
> >> +
> >> +       _scratch_mount 2>&1 | _filter_scratch
> >> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_t=
est_dir
> >> +}
> >> +
> >> +device_add_must_fail()
> >> +{
> >> +       echo ---- $FUNCNAME ----
> >> +
> >> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >> +       _scratch_mount
> >> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >> +
> >> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> >> +                                                       _filter_xfs_io
> >> +
> >> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt}=
 2>&1 |\
> >> +                                                       _filter_btrfs_=
device_add
> >
> > We are testing for failure, so no need for the new filter
> > _filter_btrfs_device_add.
> > Just filter through  _filter_scratch_pool here and nothing more.
> >
>
> As shown above, we need to filter out the size part too.
>
> Thanks, Anand
>
> > Thanks.
> >
> >> +
> >> +       echo Balance must be successful
> >> +       _run_btrfs_balance_start ${tempfsid_mnt}
> >> +}
> >> +
> >> +mkdir -p $tempfsid_mnt
> >> +
> >> +seed_device_must_fail
> >> +
> >> +_scratch_unmount
> >> +_cleanup
> >> +mkdir -p $tempfsid_mnt
> >> +
> >> +device_add_must_fail
> >> +
> >> +_scratch_dev_pool_put
> >> +
> >> +# success, all done
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> >> new file mode 100644
> >> index 000000000000..32149972beb4
> >> --- /dev/null
> >> +++ b/tests/btrfs/315.out
> >> @@ -0,0 +1,11 @@
> >> +QA output created by 315
> >> +---- seed_device_must_fail ----
> >> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-onl=
y.
> >> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File e=
xists.
> >> +---- device_add_must_fail ----
> >> +wrote 9000/9000 bytes at offset 0
> >> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
> >> +Performing full device TRIM SCRATCH_DEV (NUM) ...
> >> +Balance must be successful
> >> +Done, had to relocate 3 out of 3 chunks
> >> --
> >> 2.39.3
> >>
> >>
>

