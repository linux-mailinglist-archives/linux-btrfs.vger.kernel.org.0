Return-Path: <linux-btrfs+bounces-2592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DA85C1A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAA1283441
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099C76C60;
	Tue, 20 Feb 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJyU5m9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F96D1A8;
	Tue, 20 Feb 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447537; cv=none; b=pP3VlFtS5W7gmptTdBIOd2+7y6IJ0xb0N54hT+JHzd6Ir4pvX4lK+WTwha4D4e+3+UB22qegSrfhFO1BX2Qji+WtDp9e1yRGNqksdEHlOA8uB3LvZs3HReiURRgi7zHCTgDNfYQrwCRTaitnKIzGcbTJpw+FAnei1wSGGtXeINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447537; c=relaxed/simple;
	bh=ct6nIOvbL8M7wH03UIWAUXfe/Nj9uCdY68ykTkdU/iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLgBeq3I7EtIcBJSJuXajv+ff//vXe09CLEvxBvuUnsJPUfCoWLVF4ayHWlRHXzdz+qcUPMQ0d4q/KzepwUIxbQIvFUWqRulGU4XiArIYVKE/yK1jkDKCPe3J3+yeaY99Yxl5uIPpEV/3hBmBN29wlBZaywF4P59Ru5p/pb4LHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJyU5m9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5327C43394;
	Tue, 20 Feb 2024 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708447536;
	bh=ct6nIOvbL8M7wH03UIWAUXfe/Nj9uCdY68ykTkdU/iE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cJyU5m9FfAOp2rBpdpmo3uKYrqVOEVHzoXx5vyHulG4kufgt8KWTlUG1sVSEqYXwP
	 yZeLAdFdQKualJKsYOKNpSBZ5WoFATnIDAAwt8Q7clK+wKoCsLLBu+fVfVmNXETrTY
	 EL4V377iBPWWbjNHJP9GXuMFTjQL194TOxBZ2lVleny9fK0f6ZDIhYWnSRb7RkgRuk
	 IP9ikL7In1Q8Gj9RcCkkkZEpix+IOHM3lyYOIfUCZg24wgquY/Aqa0KuXw5EcAorUl
	 zcSM+nXVgVsJqiHNtJvoG7b04opYN+OaJrIKTZogSkre1hEm1yk9OIEOVdvq7jj2TL
	 78hx0pykVk6og==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso7026544a12.0;
        Tue, 20 Feb 2024 08:45:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+2N8xBm6vA/suWEAw++5V1Z+l4QBNY6Got2bQpbBN2KJgpp37RZxOS/FtomOzUBZEW2CAm+pp7MuZuaucFxCQAks6bUhFTPDM9fc=
X-Gm-Message-State: AOJu0YytobUV11A2/CS/UoaxBRLu9s9StwvD0PjpF6wd98p/LjQaUgVS
	gdsjP29W64vGHu4fFuc8paBfRbYVi8xsvS5kW5M6KUKDlZZ01ovATr+tjlzPqwJeZgNWTKE7Aho
	ZCj+Tgl3TZJps8y6Jfb5gTIfty6M=
X-Google-Smtp-Source: AGHT+IGxJWAIucmvpfodSNr0f+k2oAISnhyOPh4htLFWOuXWrTSW6p5P4bDucY3W3hKtlDrzRmiy2TJABOMzm5PE0Eo=
X-Received: by 2002:a17:906:48c7:b0:a3f:17b:d439 with SMTP id
 d7-20020a17090648c700b00a3f017bd439mr1441397ejt.71.1708447535071; Tue, 20 Feb
 2024 08:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <a59c46c581dd2219c1aad6d7d82e1527e8a4d35d.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <a59c46c581dd2219c1aad6d7d82e1527e8a4d35d.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:44:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ngKVpTHGMEF-WyyTtt+-4fQ=BeMvuCUuRc9FNtrzwXA@mail.gmail.com>
Message-ID: <CAL3q7H5ngKVpTHGMEF-WyyTtt+-4fQ=BeMvuCUuRc9FNtrzwXA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] btrfs: check if cloned device mounts with tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> If another device with the same fsid and uuid would mount then verify if
> it mounts with a temporary fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> Bring create_cloned_devices() into the testcase.
> Just use _cp_reflink output to match with golden output.
>
>  tests/btrfs/312     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out | 19 ++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100755 tests/btrfs/312
>  create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 000000000000..6dd5811ddaa5
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 312
> +#
> +# On a clone a device check to see if tempfsid is activated.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick tempfsid

This exercises reflinks, so it should have the 'clone' group as well.

> +
> +_cleanup()
> +{
> +       cd /
> +       umount $mnt1 > /dev/null 2>&1

Same as mentioned before, use $UMOUNT_PROG

> +       rm -r -f $tmp.*
> +       rm -r -f $mnt1
> +}
> +
> +. ./common/filter.btrfs
> +. ./common/reflink
> +
> +_supported_fs btrfs
> +_require_btrfs_sysfs_fsid
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super

Instead of requiring here the inspect-internal command, it should be
inside check_fsid()

That's the pattern we usually do, common functions have the _require_*
calls, avoiding the caller test to have to know each dependency and
copy-paste it.

Other than that, it looks fine.
Thanks.

> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +create_cloned_devices()
> +{
> +       local dev1=3D$1
> +       local dev2=3D$2
> +
> +       [[ -z $dev1 || -z $dev2 ]] && \
> +               _fail "create_cloned_devices() requires two devices as ar=
guments"
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
> +       local ret
> +
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

