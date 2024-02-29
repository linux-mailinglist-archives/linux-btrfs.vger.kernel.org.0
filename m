Return-Path: <linux-btrfs+bounces-2914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7499986C831
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055EA1F260D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96B7C0B0;
	Thu, 29 Feb 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrZK57nG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530417C0BE;
	Thu, 29 Feb 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206822; cv=none; b=iJWqb4ISL3YFByd5zyzd0hp7FvVgeXnsl/nNjJBS+koR3rxZH1jpEvPtdmFR4OF568hCMoQvX1fk7OLFN1jFUTV3O9eUVJdD2wAZJQ56huvM3Yl+tB5QwOiXW4XeWfeAJ5FJW/vDmZUWtRuxVXQMmP+twhGgc4RpiFXWc3ilHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206822; c=relaxed/simple;
	bh=h22fpUGoeHfkK4cKpUV5W4h0ZN5ecAy91mgTV+Y4isw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CimsWWqwvv/iz2+2hR8AkWSAbpMCoNKwGlJ0JBc+Pg/ZwR3n+ibtocNJiuFVVEvrmZvShWPSYmmuwlQUNet3a/3AD/SADO71OSZTXSrK9kd8YurF0s+i9LxgUO6NPKjob7j7/jm58G17VbwMzQoJmZ9Rdk0IhX3a0gqxzXMXUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrZK57nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA89C433A6;
	Thu, 29 Feb 2024 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709206821;
	bh=h22fpUGoeHfkK4cKpUV5W4h0ZN5ecAy91mgTV+Y4isw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mrZK57nGdNHejH0G9Iz+Zb7Uv7czeF/oTRdYrqj/gwXC/+fMlGhrUhV/nf0XkyzvQ
	 Kz8fAB3YvIvhVQd4kYgRO5RPX42k28JLbvAoWjqDdTdZWLBnUzRaGsFx+6PxWqsrLm
	 fa5N+/gSJpbB+xmEld1vsm7bgE7U291EQSGwktR2c7BzQa80mOYf2dFHhnI7QtC75l
	 nV93CUnb3SAtoIPM0GeoF600kc4oRgrE1z570K9JclfO+mcg9w2Ub4eJOZQLitU9Ud
	 TCCQ2Jx2jYdijhq1FCgONFAgucCtHVEWK9sncAqM16a40yEslMFJ07w9IptASy81AX
	 /QUDQts2toKGQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a43f922b2c5so104564966b.3;
        Thu, 29 Feb 2024 03:40:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVW0iP4wPwdUDJH1YO1NuaOEYUA8vRF/k6e99ILKuE+SYUIzDeaP589IzBg+2CNky8BdGLK+sTab75R8eSnWLiN8UolUMNmXdX4GOs=
X-Gm-Message-State: AOJu0Ywt2/LFCj5e5pECUm6lA41WV1IpwSxwL1KmZDLmlIRIwdVWyYOs
	sjOEt/82W9uqGxTriIm7XpySmyACQaMN3MjFeelWEh5EkaONS6dK5H2EiEkyNEDiULyhCHZymOi
	IxgGoe0V7dHp1Kgno10ILP6E8bZI=
X-Google-Smtp-Source: AGHT+IFDeQOl2q0ukTXHFttYv+3pIOY+qTJBHHBeUKyRjVDsCe3CEoju1AV8wLH9RNMkwrw+OFFvZSkSpBCSSsKIK8M=
X-Received: by 2002:a17:906:6b85:b0:a43:1940:c7f8 with SMTP id
 l5-20020a1709066b8500b00a431940c7f8mr1321415ejr.31.1709206820328; Thu, 29 Feb
 2024 03:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709162170.git.anand.jain@oracle.com> <377e9a27befd2d4b7f771f082ffafe57876d7cce.1709162170.git.anand.jain@oracle.com>
In-Reply-To: <377e9a27befd2d4b7f771f082ffafe57876d7cce.1709162170.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 11:39:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6K2nZnX3oWyWwLf0OKFa1c=JgMPi4yqKqhYidA_ZRLjA@mail.gmail.com>
Message-ID: <CAL3q7H6K2nZnX3oWyWwLf0OKFa1c=JgMPi4yqKqhYidA_ZRLjA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] btrfs: check if cloned device mounts with tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:50=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> If another device with the same fsid and uuid would mount then verify if
> it mounts with a temporary fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/312     | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out | 19 +++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/312
>  create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 000000000000..eedcf11a2308
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 312
> +#
> +# On a clone a device check to see if tempfsid is activated.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone tempfsid
> +
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
> +       rm -r -f $tmp.*
> +       rm -r -f $mnt1
> +}
> +
> +. ./common/filter.btrfs
> +. ./common/reflink
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +_require_btrfs_fs_feature temp_fsid
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +create_cloned_devices()
> +{
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       echo -n Creating cloned device...
> +       _mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
> +
> +       _mount $dev1 $SCRATCH_MNT
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                               _filter_x=
fs_io
> +       $UMOUNT_PROG $SCRATCH_MNT
> +       # device dump of $dev1 to $dev2
> +       dd if=3D$dev1 of=3D$dev2 bs=3D300M count=3D1 conv=3Dfsync status=
=3Dnone || \
> +                                                       _fail "dd failed:=
 $?"
> +       echo done
> +}
> +
> +mount_cloned_device()
> +{
> +       echo ---- $FUNCNAME ----
> +       create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1=
]}
> +
> +       echo Mounting original device
> +       _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                               _filter_x=
fs_io
> +       check_fsid ${SCRATCH_DEV_NAME[0]}
> +
> +       echo Mounting cloned device
> +       _mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
> +                               _fail "mount failed, tempfsid didn't work=
"
> +
> +       echo cp reflink must fail
> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
> +                                               _filter_testdir_and_scrat=
ch
> +
> +       check_fsid ${SCRATCH_DEV_NAME[1]}
> +}
> +
> +mount_cloned_device

I believe I have commented this before, or maybe it was another test
that did the same, but there's no point
in placing the test code in a function if it's only called once and
the test only exercises this scenario.
It's unnecessary indentation...

But, I won't make you send yet another patch version for that.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> new file mode 100644
> index 000000000000..b7de6ce3cc6e
> --- /dev/null
> +++ b/tests/btrfs/312.out
> @@ -0,0 +1,19 @@
> +QA output created by 312
> +---- mount_cloned_device ----
> +Creating cloned device...wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +done
> +Mounting original device
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> +Mounting cloned device
> +cp reflink must fail
> +cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Inva=
lid cross-device link
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             TEMPFSID
> +Tempfsid status:       1
> --
> 2.39.3
>

