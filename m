Return-Path: <linux-btrfs+bounces-3073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA853875409
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD901F21154
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3F12F5B3;
	Thu,  7 Mar 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHm6/X92"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852C12F5BD;
	Thu,  7 Mar 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828192; cv=none; b=pBlpug+bsmX8azriafWExpe5fm+QcjMlou5zeaygPI569wPFcEkHtitEihMXE9YZgzA5tGnd4lD91cnqCs7v1Li35lcbobxbFyf6T08zk624xXAGEvPgFxvF0upBnc8+WD9oHhYHIg2LX8/zUDD4lzzV0DjjReni6LiO/7l5NTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828192; c=relaxed/simple;
	bh=ho8kcMItudlcG8ERvSd9aKUXbUK47ysghjecl6BJrko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUdDaGv26+YzXLAgxiBWhYVUvw3WU/omipQNR5Ip98HC2L0ayo1cQiagp9Lizl0/VvgZ55l0ekxUuUwl5c0meaSXnLUVVLuwEe0Cr/8PhY+2LhUulHrUWaEFo55Ks0oFC04nFBV8cd3HnubeBZU8PnNVjPKVpwddL/4agQpkc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHm6/X92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39969C433C7;
	Thu,  7 Mar 2024 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709828192;
	bh=ho8kcMItudlcG8ERvSd9aKUXbUK47ysghjecl6BJrko=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FHm6/X92iXclsIexm8GWmuXkX2HGZq5sD6VobKoOp5Pu3I/1Rp1xT/Wvx9Hw0BOQ7
	 Hp9Bs3V1OPS+U5llHSLAn4tM4HH8PJqM++I7NVCQ3300aW8fA+/HgZ543xo7AvURui
	 k2NBvR9h7/4eFD/aDY4dRsVxID4jeAchTa08GHLQpRLAX+gW511396YZFiB+yGzpm0
	 lZwWJEix7pwaaIwJZoLAwQF3CpE8k4ai7y5KYycRh8KOEAYk+KV6b8iysscGiyldH2
	 Om5xxVzUN+h4GWnJaNy7F4x/7evTG6dMaogsJ/lgFwbFV1hYmXAKHugbsq+5NhKpwI
	 EbbRmVaVtUGjg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso1274469a12.2;
        Thu, 07 Mar 2024 08:16:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWef5jXEpsZC6zceV3Eak4wknz/UHR6SDtMWmTp27ge3ucBw0cqvi8dgu8ewCAKaz+/cdbI7yquoqSLXNPSBgqugjwt93JWW4dmeDQ=
X-Gm-Message-State: AOJu0Yx/50RIffkpKcPGCjrYjodJpqmc8WDVAi1lZKGjKLR0dZdMluaO
	EJB2UvQQbJRnsE7jkGvxMP5qI5VUaoztae16jCJioUPOZ2kQ0OnGRJjwVSsqat62/ycch3NHGB6
	lXl1IrQPbaeXqPxofWkhKwdnftEs=
X-Google-Smtp-Source: AGHT+IGpFribLSb3L4pR8vZTfuM24IdRyw0AdNPW98L7i32fzobxSnmO9N1C92PgEQiI91Nem++XlO5HaT4OeggbB8E=
X-Received: by 2002:a17:906:e08d:b0:a44:731c:bace with SMTP id
 gh13-20020a170906e08d00b00a44731cbacemr13560992ejb.35.1709828190540; Thu, 07
 Mar 2024 08:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709806478.git.anand.jain@oracle.com> <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
In-Reply-To: <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 7 Mar 2024 16:15:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com>
Message-ID: <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:51=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> When a flakey device is configured, we have access to both the physical
> device and the DM flaky device. Ensure that when the flakey device is
> configured, the physical device mount fails.

Does it need to be flakey? Can't it be any other DM type?
The way it's phrased, gives the idea that somehow this is all flakey specif=
ic.

Just be clear and mention any DM on top of the device.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/318     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/318.out |  3 +++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/btrfs/318
>  create mode 100644 tests/btrfs/318.out
>
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> new file mode 100755
> index 000000000000..015950fbd93c
> --- /dev/null
> +++ b/tests/btrfs/318
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 318
> +#
> +# Create multiple device nodes with the same device try mount
> +#
> +. ./common/preamble
> +_begin_fstest auto volume tempfsid

Also 'quick' group.

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       umount $extra_mnt &> /dev/null
> +       rm -rf $extra_mnt &> /dev/null
> +       _unmount_flakey
> +       _cleanup_flakey
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch
> +_require_dm_target flakey
> +
> +_scratch_mkfs >> $seqres.full
> +_init_flakey
> +
> +_mount_flakey
> +extra_mnt=3D$TEST_DIR/extra_mnt
> +rm -rf $extra_mnt
> +mkdir -p $extra_mnt
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | _filter_testdir_and_scratch
> +
> +_flakey_drop_and_remount

Why? Please add a comment.

Either this is a leftover from copy-paste from other tests, that
exercise fsync and power failure, or the goal is to do an unmount
followed by a mount and check that the mount succeeds.
If it's the latter case, then it's confusing to use
_flakey_drop_and_remount, because that drops writes, unmounts, allows
writes again and then mounts - i.e. we don't want to simulate power
loss by silently dropping writes.
Just call _unmount_flakey and _mount_flakey and add a comment
mentioning why we are doing it.

Finally, a link to the report that motivated this, due to a bug in a
patch that ended not being sent to Linus, would be useful:

https://lore.kernel.org/linux-btrfs/CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=3D35N4O=
BrbJB61rK0mt2w@mail.gmail.com/

I'm also not convinced that we need this test, because the bug could
be reliably reproduced by running all existing tests or just a subset
of the tests as I reported there.

Thanks.

> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
> new file mode 100644
> index 000000000000..5cdbea8c4b2a
> --- /dev/null
> +++ b/tests/btrfs/318.out
> @@ -0,0 +1,3 @@
> +QA output created by 318
> +mount: TEST_DIR/extra_mnt: wrong fs type, bad option, bad superblock on =
SCRATCH_DEV, missing codepage or helper program, or other error.
> +       dmesg(1) may have more information after failed mount system call=
.
> --
> 2.39.3
>
>

