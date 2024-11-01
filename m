Return-Path: <linux-btrfs+bounces-9294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D209B8D61
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720881F232A9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7C157E88;
	Fri,  1 Nov 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1TuU1qr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097E4087C;
	Fri,  1 Nov 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451553; cv=none; b=aHl2sNsgUmeBhpqDsDTHdN1SMYt9YFL08MbJPQnRxLow7cg6jjj3u6mZ4kdm+CmILRvPRclL76eGcVmnvgVno0giLl91hSFfuS036b15jN3r7fADihZu/kqWgqckUI0SWrRlGS5HkRLQs4hEbQFftYWqHlbqLw7bptXbj+7/JR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451553; c=relaxed/simple;
	bh=H+5V0XY3aMrrKPNq8QFPPGwjf6XQduVmsMfl2J3R5dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBpWqQkNbMYaJnOwSQ7Ua/lopkgA7odc6r12oD03cNM7HpjnXXPAGHRKbuFuo/gU++4oAXZ86y2g2Y6xBJmv6kGnhv6AVtB4y+k9vb9CYE2Pbfa3Lb6ivL4eH895v44VkezmNgzKkZzat2r9lkto7DaIee+H9tHsGEmn9m5jwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1TuU1qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D786C4CECD;
	Fri,  1 Nov 2024 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730451552;
	bh=H+5V0XY3aMrrKPNq8QFPPGwjf6XQduVmsMfl2J3R5dQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1TuU1qr+1RlfeFx2pCXcMMFXFZjg+LuD0LGIxxivJ4ARlXieQ9KiWbxuKTcHhISs
	 X+vQg1AWLspS0T+osLsGpPrJtxGZtEl1C+bRqgCf1MqRAp1aM4iKizQUOlxZRllIqm
	 LVydl9kLJI6ByQZ8jq4wrqlomty6SoLvlbBOZQtzPMYv2QhtGdb8Y7lmI6wcyz0pVz
	 T4ylFH4aUTFRmnrPVWSPb1wPChWapr9tDUGDPqpr4AvGgAgVEaPwY0tRemYrCm7Us1
	 QAUuW6huaFQ+mf6/wAGUfIdd24t5b6q+Nq9HkBe52jNCk8IUa5A1zqJZAq6WX/eo7E
	 zO2FFPYMs3exw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f629a7aaso282342266b.1;
        Fri, 01 Nov 2024 01:59:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmp29rPAnWznv690mK8eQAux5C3JcaFbcfy7rFUpf1BXdPyVOjAe8Xmm7Zjch5k/OsWgQRmKgy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VDHAfanagAkNMSo0yd0m6nY/DUzV2oRy86pi/n4eJB3ncDjD
	9dYfg8jXUQKao/J9o9INNJXBR72/G0QF67u7aIfK/nx2IUoSn7qbU9KDMYzs3nw4RpGT0iQFQWd
	Q9uTfh4IWPTX52xO3S7o68Qjm/M4=
X-Google-Smtp-Source: AGHT+IHJ1oUHtoPVuaY6EmoXI7hOT3mUWXQBECr0xCxhJkaCQ4G+Q3Uls+9g58GCpzcZysvwjtcCQtXPs6aZ9bfJSEc=
X-Received: by 2002:a17:907:3f9f:b0:a99:ee26:f416 with SMTP id
 a640c23a62f3a-a9e653323f2mr252531766b.14.1730451551007; Fri, 01 Nov 2024
 01:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101050743.113687-1-wqu@suse.com>
In-Reply-To: <20241101050743.113687-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 1 Nov 2024 08:58:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5rxudiGOee=7cVqX9vjiVsigkxmbV4hBL97Goy8pFVeA@mail.gmail.com>
Message-ID: <CAL3q7H5rxudiGOee=7cVqX9vjiVsigkxmbV4hBL97Goy8pFVeA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: a new test case to verify mount behavior with
 background remounting
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 5:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When there is a process in the background remounting a btrfs, switching
> between RO/RW, then another process try to mount another subvolume of
> the same btrfs read-only, we can hit a race causing the RW mount to fail
> with -EBUSY:
>
> [CAUSE]
> During the btrfs mount, to support mounting different subvolumes with
> different RO/RW flags, we have a small hack during the mount:
>
>   Retry with matching RO flags if the initial mount fail with -EBUSY.
>
> The problem is, during that retry we do not hold any super block lock
> (s_umount), this meanings there can be a remount process changing the RO
> flags of the original fs super block.
>
> If so, we can have an EBUSY error during retry.
> And this time we treat any failure as an error, without any retry and
> cause the above EBUSY mount failure.
>
> [FIX]
> The fix is already sent to the mailing list.
> The fix is to allow btrfs to have different RO flag between super block
> and mount point during mount, and if the RO flag mismatch, reconfigure
> the fs to RW with s_umount hold, so that there will be no race.
>
> [TEST CASE]
> The test case will create two processes:
>
> - Remounting an existing subvolume mount point
>   Switching between RO and RW
>
> - Mounting another subvolume RW
>   After a successful mount, unmount and retry.
>
> This is enough to trigger the -EBUSY error in less than 5 seconds.
> To be extra safe, the test case will run for 10 seconds at least, and
> follow TIME_FACTOR for extra loads.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/325.out |  2 ++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/btrfs/325
>  create mode 100644 tests/btrfs/325.out
>
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..d0713b39
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 325
> +#
> +# Test that mounting a subvolume read-write will success, with another
> +# subvolume being remounted RO/RW at background
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount remount
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix mount failure due to remount races"
> +
> +_cleanup()
> +{
> +       cd /
> +       umount "$subv1_mount" &> /dev/null
> +       umount "$subv2_mount" &> /dev/null

$UMOUNT_PROG

> +       rm -rf -- "$subv1_mount" &> /dev/null
> +       rm -rf -- "$subv2_mount" &> /dev/null
> +}
> +
> +# For the extra mount points
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
> +_scratch_unmount
> +
> +subv1_mount=3D"$TEST_DIR/subvol1_mount"
> +subv2_mount=3D"$TEST_DIR/subvol2_mount"
> +mkdir -p "$subv1_mount"
> +mkdir -p "$subv2_mount"
> +
> +# Subv1 remount workload, mount the subv1 and switching it between
> +# RO and RW.
> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=3Dsubvol1
> +while _mount -o remount,ro "$subv1_mount"; do
> +       mount -o remount,rw "$subv1_mount"

_mount here too.

> +done &
> +subv1_pid=3D$!
> +
> +# Subv2 rw mount workload
> +# For unpatched kernel, this will fail with -EBUSY.
> +#
> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
> +# then reconfigure the fs to RW.
> +#
> +# But such retry has no super blocl lock hold, thus if another remount

blocl -> block

> +# process has already remounted the fs RW, the attempt will fail and
> +# return -EBUSY.
> +#
> +# Patched kernel will allow the superblock and mount point RO flags
> +# to differ, and then hold the s_umount to reconfigure the superblock
> +# to RW, preventing any possible race.
> +while _mount "$SCRATCH_DEV" "$subv2_mount "-o subvol=3Dsubvol2; do
> +       umount "$subv2_mount";

$UMOUNT_PROG

> +done &
> +subv2_pid=3D$!

We should have the _cleanup function kill and wait for $subv1_pid and
$subv2_pid in case the test is interrupted, something like:

kill $subv1_pid $subv2_pid &> /dev/null
wait $subv1_pid $subv2_pid &> /dev/null

> +
> +sleep $(( 10 * $TIME_FACTOR ))
> +
> +kill $subv1_pid
> +kill $subv2_pid

Add a 'wait' here, to make sure the umounts below don't fail in case
the subvolumes are mounted.

> +umount "$subv1_mount" &> /dev/null
> +umount "$subv2_mount" &> /dev/null

$UMOUNT_PROG

> +rm -rf -- "$subv1_mount" &> /dev/null
> +rm -rf -- "$subv2_mount" &> /dev/null


Also, why these "&> /dev/null" redirections?
If we have the 'wait', the umounts should succeed and the rm -fr
shouldn't fail - in fact it's useful to test that they don't fail,
that the umounts were successful in case the subvolumes were mounted.

Thanks.

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> new file mode 100644
> index 00000000..cf13795c
> --- /dev/null
> +++ b/tests/btrfs/325.out
> @@ -0,0 +1,2 @@
> +QA output created by 325
> +Silence is golden
> --
> 2.46.0
>
>

