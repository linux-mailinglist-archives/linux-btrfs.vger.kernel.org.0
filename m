Return-Path: <linux-btrfs+bounces-2918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05886C856
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1997F1C21030
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF77C6DE;
	Thu, 29 Feb 2024 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOpZgSuj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A617C6DF;
	Thu, 29 Feb 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207127; cv=none; b=nJwnmldDOPt5SlgYUwI5J0iUUYguWIfFjIkPajdbZDHjksyTjvDEIqqMC3AzCIeF5ThrfTdoc87mdtJiL1YH18b5SM2bXZRHVUJLm3ADJYypgLe+3G0ai8+kE+//gduZYSvD6cPHAyRyKZs00NMRHYCDBRnG0RDAe1KG1nEAhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207127; c=relaxed/simple;
	bh=BwGxvTIC5QfyAHuNmavEUlUkmJvI9bEW1N2gwc6Wxtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIJZOH+7KXyzTzGjMkJDnRpyYcLHaTThHqMjwb63pMFwCnrAdRlurNa+3zD8BP5x4kuEbZ9d21HTDMovKnSWXPxktIXvTWnpI+wRRBRHx7MZZDPmVFPc3E0OSaL4Q9F83aMiESlR/yj8IqBqUzsXHtv4WhryD1sSMrO2XYQjYmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOpZgSuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3707C43390;
	Thu, 29 Feb 2024 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207126;
	bh=BwGxvTIC5QfyAHuNmavEUlUkmJvI9bEW1N2gwc6Wxtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dOpZgSujJQ+dOuaRf3n4anNtRFm5chUAcAhNnyc7BAMnQk4MZE9rlexIqsN4mxaqn
	 0IOzELg9p68qLKXjjXqcyYqQXmKDnmFhR4PcR98oeGfaow508TASWxaRYbD25A1IQl
	 j21pvJgFwiJ8CW6GHApqjzjw5lZAiyvY/emCQUejaI04IOxWSDw3YeL2rXkd3NeBfw
	 XJ3v/ot09Uofj40cwDZFlb+0GtLxmyQNMaCKWq1cKJoz0xoSsQEmN4QO24CTmBLxuD
	 AiZt+KRG/pFhyFo7HN9NaSwFpK7kGqw3J++VxHVhC9A+jeDP2PrEfxca1xsuwozS/S
	 sbjQxyYN/FMCA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso1043471a12.2;
        Thu, 29 Feb 2024 03:45:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9iQl3GoIY20GKNOzynQwZJG6dj7BgW07wVmSOvI6g2BR3OyVlvgjzR5hoHrk+2W1CgxKS6WjxPZouNSUR053m5//mI1Ykbsybt5I=
X-Gm-Message-State: AOJu0Yw6V6sKouY1K8c+F7zYeYxeDCnyla0vuxwhxmS/wcTnT6hYrX2T
	x4sWLQNUkbL5qCgZ9UEFOlgoNUFiardEbQTdYmkYEsY0J4dPe2H0Qo5Dec5YrD1bpbOkmQMHSxR
	HBUIdeDXg0JU9UFfJQJP4aWoV5ac=
X-Google-Smtp-Source: AGHT+IFIlZ+110Y14vIyDA3oT2S+t3yiHoZJMWfNlGjDGIspH7vaAGC5HO4Lk1wsaFi901SXGLzc5qSSuEsLx2aoX5I=
X-Received: by 2002:a17:906:495a:b0:a3f:384a:73ab with SMTP id
 f26-20020a170906495a00b00a3f384a73abmr1209686ejt.71.1709207124463; Thu, 29
 Feb 2024 03:45:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709162170.git.anand.jain@oracle.com> <f5c5894f51e8d19f292f5fb7df3976e397c8e4eb.1709162170.git.anand.jain@oracle.com>
In-Reply-To: <f5c5894f51e8d19f292f5fb7df3976e397c8e4eb.1709162170.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 11:44:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5BAVoMMqwqwQC5bqq_f9i7fzZ8Xb7Caps_+hpRVY7G0w@mail.gmail.com>
Message-ID: <CAL3q7H5BAVoMMqwqwQC5bqq_f9i7fzZ8Xb7Caps_+hpRVY7G0w@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] btrfs: test tempfsid with device add, seed, and balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:51=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Make sure that basic functions such as seeding and device add fail,
> while balance runs successfully with tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  tests/btrfs/315     | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/315.out | 10 +++++
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/315
>  create mode 100644 tests/btrfs/315.out
>
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> new file mode 100755
> index 000000000000..7e5c74df4316
> --- /dev/null
> +++ b/tests/btrfs/315
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 315
> +#
> +# Verify if the seed and device add to a tempfsid filesystem fails
> +# and balance devices is successful.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume seed balance tempfsid
> +
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
> +       rm -r -f $tmp.*
> +       rm -r -f $tempfsid_mnt
> +}
> +
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +_require_btrfs_fs_feature temp_fsid
> +
> +_scratch_dev_pool_get 3
> +
> +# mount point for the tempfsid device
> +tempfsid_mnt=3D$TEST_DIR/$seq/tempfsid_mnt
> +
> +_filter_mount_error()
> +{
> +       # There are two different errors that occur at the output when
> +       # mounting fails; as shown below, pick out the common part. And,
> +       # remove the dmesg line.
> +
> +       # mount: <mnt-point>: mount(2) system call failed: File exists.
> +
> +       # mount: <mnt-point>: fsconfig system call failed: File exists.
> +       # dmesg(1) may have more information after failed mount system ca=
ll.
> +
> +       grep -v dmesg | _filter_test_dir | sed -e "s/mount(2)\|fsconfig//=
g"
> +}
> +
> +seed_device_must_fail()
> +{
> +       echo ---- $FUNCNAME ----
> +
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +
> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
> +
> +       _scratch_mount 2>&1 | _filter_scratch
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_moun=
t_error
> +}
> +
> +device_add_must_fail()
> +{
> +       echo ---- $FUNCNAME ----
> +
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +       _scratch_mount
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                       _filter_xfs_io
> +
> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>=
&1 | \
> +               grep -v "Performing full device TRIM" | _filter_scratch_p=
ool
> +
> +       echo Balance must be successful
> +       _run_btrfs_balance_start ${tempfsid_mnt}
> +}
> +
> +mkdir -p $tempfsid_mnt
> +
> +seed_device_must_fail
> +
> +_scratch_unmount
> +_cleanup
> +mkdir -p $tempfsid_mnt
> +
> +device_add_must_fail
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> new file mode 100644
> index 000000000000..3ea7a35ab040
> --- /dev/null
> +++ b/tests/btrfs/315.out
> @@ -0,0 +1,10 @@
> +QA output created by 315
> +---- seed_device_must_fail ----
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> +mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +---- device_add_must_fail ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
> +Balance must be successful
> +Done, had to relocate 3 out of 3 chunks
> --
> 2.39.3
>

