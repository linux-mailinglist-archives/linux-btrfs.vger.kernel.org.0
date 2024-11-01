Return-Path: <linux-btrfs+bounces-9297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D49B9144
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 13:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB0E283155
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DDF199E94;
	Fri,  1 Nov 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL3wz7Ph"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3897C2C9;
	Fri,  1 Nov 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465121; cv=none; b=UZX2NdZT7wkA2Fg6FjvGnpXFTsNgjFS3SmZZjd8HCg/mqwcZzsm2GBpwtkNuL2mk+GwAXf/WopGHXXwQ8DLIXjy28IbPwpmtBuJ0xrWKnLJj6h+NQV7JBZaNl3gBpQXPSEtxv+hjn6i+se6vGmGAydlN0Lg5k/72SndoLA5pcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465121; c=relaxed/simple;
	bh=SlrdKm1MWGOqwd0gEiLQtK7fpLi1RZ9N6i544u1u8Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6ryWsAoSzvYjDMR/ZhPWP9OGn4hKlejZcTJGhhwneeVEdqmMk1VW/mH+f7ErbVNWbsyt7p6EAgZUdYLvcRX0uSGRKI7kAiauHlW2VdVRcRCJNRSyNOe0JwgLsCYBLRE3iCWLSJyhh8RgdPnyApsjZSR2b+z5P/tVNR2UohuKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL3wz7Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAC1C4CECD;
	Fri,  1 Nov 2024 12:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730465121;
	bh=SlrdKm1MWGOqwd0gEiLQtK7fpLi1RZ9N6i544u1u8Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eL3wz7PhKz0K/UqF7jL2zd9g8aDGaP7qUrH+/jJz5vui4JqteJqwFR6UETvO02ka1
	 knkcoFycusEO6Mv193MoUI1phx/LX1Xjyw5Cl4Huf/uIjpmbiyFb8BFCa6qVjdvkyg
	 eT7FC0zElwOy4YKIztTWL0VR4bRAobsJyIKN51a2S8gkR6mP5Z8+am4+00iM9RCswl
	 bGm4oDV8kf/v3x4jtForvqRy81B5Y5mQntW7o1TqYFB3CQo5Lr12e778M1qu5dWNzd
	 WDy07f7F1dr0MWT4buRA8kFYH6TslwS3+cmbu5oIXinbhuLlOc64goq7OjIk/RPMrM
	 vPbcmKoBFV4qg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so2616921a12.1;
        Fri, 01 Nov 2024 05:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUJoi8cFCG3hXytofBGf/iBVu1WFiGrCJ5a4B9Jc2+O9pp3N+xHlo2hp/N143S3120FtnzDS5W@vger.kernel.org
X-Gm-Message-State: AOJu0YwYot4u9JfOUlFV3mvdT/IkNi1+gt6uxr6jqZe7395bRyr8vHjx
	K5klHXzTSMrttpnDqXR6QoHweFj7k6kfuBlfksOgOxJw4t80+W5h3dKQptkiZxs3S9fDkwrjyC6
	wqi01Qrqyg+uQWZJHg3zDA/5YOOU=
X-Google-Smtp-Source: AGHT+IHtLTVi10wIfpxHveBQ9DpCHTQ+M+cAohsscSc/BVKcx4iusPxXp5pe00u+48FGwx7J0yi7ds4PPs46PFnxVkQ=
X-Received: by 2002:a17:907:9405:b0:a9a:1792:f24 with SMTP id
 a640c23a62f3a-a9de5ee19acmr2151924266b.24.1730465119869; Fri, 01 Nov 2024
 05:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101102956.174733-1-wqu@suse.com>
In-Reply-To: <20241101102956.174733-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 1 Nov 2024 12:44:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6rXFmiNs+GWG7dPJ4p2nF15nMUjw41zcNc4XzW_iHmdg@mail.gmail.com>
Message-ID: <CAL3q7H6rXFmiNs+GWG7dPJ4p2nF15nMUjw41zcNc4XzW_iHmdg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: a new test case to verify mount behavior with
 background remounting
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good. It fails with an unpatched kernel and passes with a patched ker=
nel.
Thanks.

> ---
> Changelog:
> v2:
> - Better signal handling for both remount and mount workload
>   Need to do the extra handling for both workload
>
> - Wait for any child process to exit before cleanup
>
> - Keep the stderr of the final rm command
>
> - Keep the stderr of the unmount of $subv1_mount
>   Which should always be mounted.
>
> - Use "$UMOUNT_PROG" instead of direct "umount"
>
> - Use "_mount" instead of direct "mount"
>
> - Fix a typo of "block"
> ---
>  tests/btrfs/325     | 99 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/325.out |  2 +
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/325
>  create mode 100644 tests/btrfs/325.out
>
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..ffa10c61
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,99 @@
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
> +       kill "$remount_pid" "$mount_pid" &> /dev/null
> +       wait &> /dev/null
> +       $UMOUNT_PROG "$subv1_mount" &> /dev/null
> +       $UMOUNT_PROG "$subv2_mount" &> /dev/null
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
> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=3Dsubvol1
> +
> +# Subv1 remount workload, mount the subv1 and switching it between
> +# RO and RW.
> +remount_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +       while true; do
> +               _mount -o remount,ro "$subv1_mount"
> +               _mount -o remount,rw "$subv1_mount"
> +       done
> +}
> +
> +remount_workload &
> +remount_pid=3D$!
> +
> +# Subv2 rw mount workload
> +# For unpatched kernel, this will fail with -EBUSY.
> +#
> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
> +# then reconfigure the fs to RW.
> +#
> +# But such retry has no super block lock hold, thus if another remount
> +# process has already remounted the fs RW, the attempt will fail and
> +# return -EBUSY.
> +#
> +# Patched kernel will allow the superblock and mount point RO flags
> +# to differ, and then hold the s_umount to reconfigure the super block
> +# to RW, preventing any possible race.
> +mount_workload()
> +{
> +       trap "wait; exit" SIGTERM
> +       while true; do
> +               _mount "$SCRATCH_DEV" "$subv2_mount"
> +               $UMOUNT_PROG "$subv2_mount"
> +       done
> +}
> +
> +mount_workload &
> +mount_pid=3D$!
> +
> +sleep $(( 10 * $TIME_FACTOR ))
> +
> +kill "$remount_pid" "$mount_pid"
> +wait
> +
> +# subv1 is always mounted, thus the umount should not fail.
> +$UMOUNT_PROG "$subv1_mount"
> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +
> +rm -rf -- "$subv1_mount" "$subv2_mount"
> +
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

