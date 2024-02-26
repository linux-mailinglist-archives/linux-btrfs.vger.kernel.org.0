Return-Path: <linux-btrfs+bounces-2797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A471286746D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C38B1F23C3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9165FEFA;
	Mon, 26 Feb 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUD1HkmC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6835FBB4;
	Mon, 26 Feb 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949370; cv=none; b=seb/R7+zC0L9WB+akbnzpIfzfDb6paWG73CdQIk1ud0/xA3tVUq2Wk4QgrfRxkRYLd+n+kGTIn96X84x4M+mHN509NrjD6NOGBbWAmd0Mtk6TRYymisxV9E8jnC6JDY2/mW3sTqWH/3nlrN2PtYZN1AFfYXW4Mmp+AAFvfGCn6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949370; c=relaxed/simple;
	bh=r1dOSpyrpt8ryIjZBgEF/Bd46GKKnYlmhxdjia/BQ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsKRhfCsCS/XXcu2+Th2CKM/P8I2EgMZrBVK86ZbiC9JjflwZJgMASMBthv+O0+zR/e59rPneH533YBGa5eHp1ZT5BqBQPSLGajgpgTme8Tcq+5Ele5d8nyzmbhRw7Svlo3TOrsD8dDkF2RLRCvpRIMKvlVDJ1tcBTJyu1G0Sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUD1HkmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4491C433F1;
	Mon, 26 Feb 2024 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949369;
	bh=r1dOSpyrpt8ryIjZBgEF/Bd46GKKnYlmhxdjia/BQ+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oUD1HkmCXtr+3LjtNJ13oeWldf6B/uxRxZpRC8NHqcppfLlwdJJLrUBQeKKxkLJqp
	 UsiwChkkRnBJTdwbPLWqFvdEH7jTEzcC63mb9wUqr/n4KorJ5DkbcJVBVRKF23N2bW
	 SxAi6TbyVhLd3Dq/73F2vnpkXv+FryGh7yPAejf3AHQvrHMVM8UXf+DMsv/eIJT221
	 QAijshCpeBzPlzRSMvN3H5Sa414P1sz8JoIRy+evc7ssKVa0U3MNpHo8+i8o8eoim/
	 VUiTkMiyUWg6xODZutqN2OQ+Xbg/eQVPjIzbh+Z8jtfWBUOmwHBdMKHXf7z26+aGCw
	 7ksvmTxPCNVeg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e4765c86eso354918066b.0;
        Mon, 26 Feb 2024 04:09:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+fJWs3uTB2AGRzXDJBqXkVVdyND2oKlPQxpvdbKajyocvDXslVavdCi7A4UN79qVvtAKyzfD8844Q5DuddQRUg461BzneMX3N6KE=
X-Gm-Message-State: AOJu0YyKmVrfkydB9AmWsveQRUYmI6PLnDxBUy0M0xBukiSqcqayDotk
	0rbG+/PomfY6jI+JuMhEqk/iNB6g/dj3ZvKqYSY+9yY3Ej9wrvxvqoI1t7/1jtCWAvVyCRZMORW
	YNOPSxWsdsOgeQusYuT+Xa2oPCSs=
X-Google-Smtp-Source: AGHT+IFSdtDhWsZIWhgkHk5tsmbwTUWzFFRo9Ga5lFCRRXGSfY7iwr+2cHk9aZpXoDcl7wtiSnjdPnEplihw/f/cHCc=
X-Received: by 2002:a17:906:4bd4:b0:a3e:f496:7b50 with SMTP id
 x20-20020a1709064bd400b00a3ef4967b50mr4115393ejv.64.1708949368280; Mon, 26
 Feb 2024 04:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <faeda97208d0a2ecca94490b35a4dc8e98e7fdc6.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <faeda97208d0a2ecca94490b35a4dc8e98e7fdc6.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 12:08:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H45T0+BHQqDwOTjWhWeG=yStY+x6EsznRrrdeGAE9qzng@mail.gmail.com>
Message-ID: <CAL3q7H45T0+BHQqDwOTjWhWeG=yStY+x6EsznRrrdeGAE9qzng@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] btrfs: test tempfsid with device add, seed, and balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Make sure that basic functions such as seeding and device add fail,
> while balance runs successfully with tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
>  Comment updated.
>  Add balance group.
>  Drop prerequisite checks.
>  Use error (from subvol create) in the golden output instead of calling _=
fail.
>
> v2:
>  Remove unnecessary function.
>  Add clone group
>  use $UMOUNT_PROG
>  Let _cp_reflink fail on the stdout.
>
>  tests/btrfs/315     | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/315.out | 10 ++++++
>  2 files changed, 88 insertions(+)
>  create mode 100755 tests/btrfs/315
>  create mode 100644 tests/btrfs/315.out
>
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> new file mode 100755
> index 000000000000..696e26fe339c
> --- /dev/null
> +++ b/tests/btrfs/315
> @@ -0,0 +1,78 @@
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
> +_require_btrfs_sysfs_fsid

Same as in the previous test case. This requirement is not needed, the
sysfs fsid path is not used anywhere in this test, likely copy-pasted
from previous test cases in this patchset.

Thanks.

> +_require_scratch_dev_pool 3
> +_require_btrfs_fs_feature temp_fsid
> +
> +_scratch_dev_pool_get 3
> +
> +# mount point for the tempfsid device
> +tempfsid_mnt=3D$TEST_DIR/$seq/tempfsid_mnt
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
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test=
_dir
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
> index 000000000000..56301f9f069e
> --- /dev/null
> +++ b/tests/btrfs/315.out
> @@ -0,0 +1,10 @@
> +QA output created by 315
> +---- seed_device_must_fail ----
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exis=
ts.
> +---- device_add_must_fail ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
> +Balance must be successful
> +Done, had to relocate 3 out of 3 chunks
> --
> 2.39.3
>

