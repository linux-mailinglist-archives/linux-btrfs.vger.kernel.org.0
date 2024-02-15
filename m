Return-Path: <linux-btrfs+bounces-2427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A114856347
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AE2283FD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8912CDAC;
	Thu, 15 Feb 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhAxA3xF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974912C7E9;
	Thu, 15 Feb 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000465; cv=none; b=IvdI0PuiQkYDMGvqLCVz0PRyrqk3vYQ4zyee0pFq+SLpxhQX5L45jj2hwWw6UP04k9gqmQXErPZciUocz0ICd2W9Glvh1vL5q7JHbVpSpqimpaRu/MgX1hMIQRtXwq9GN0SqkkRvQjZ1AcFVJ2y8jaaD9ZntLR/na1ORXBJ96RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000465; c=relaxed/simple;
	bh=ucHEhBeiHSYzxMwZQQN1dygieiOSGNNnYp1SGoBGXTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOuzlYbUtvao7O/CkkTzSsTonSWeyhOH6zQMgskDJDzqmFF2OUTwcr0Yu01lgf31lvslEZGqKA9j/KWX55lsyGzJF83d+rVhb9Yj/mngk2aYF9ThlFL/QHiObvr/v7EvKHM7gaCWlPFcpswYpuuzcUsicReJtpHKnoPENb1SP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhAxA3xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEEDC43394;
	Thu, 15 Feb 2024 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708000465;
	bh=ucHEhBeiHSYzxMwZQQN1dygieiOSGNNnYp1SGoBGXTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RhAxA3xFszANt8xxiUvp2QlFcGgFWz9LjZZaxR594bTfp9MGSOd6MdQ+RUJmI/odO
	 HLnIhgt2vSb9MwjmOC+Lgnal9aYb7T+4lEYNs4uWqJxo0BaI9UbpklcyD0LT3z5jEL
	 bb9dgNd/rf0wYay3GXek7fG4wU4JdvKktL12PaHS8HuZ/B3ohi4iaHPWxQuMher06C
	 G9C8mYW/4lDBL+STz6d0yffSP+HpLxEmjvBoEI5YKzrzc+RkT0LdwOAysf7Hrq0xnW
	 CvK4P00b+lvi+2nyYxgnugTANPV45Gwdqo+uzxTbGlPagmQ6lDum9nDYyxi12d87e0
	 PTArlpbsH9Z3g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51147d0abd1so917387e87.1;
        Thu, 15 Feb 2024 04:34:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1G28M7RMZP/0g8rw/wl8iRtDrLhkuZlQzHkvpyNtVg++dMZWsa/3SQHUQGUxgYs2NLCBPDV75/hACFw/tiC3v1IG6eX4o19hdiEE=
X-Gm-Message-State: AOJu0YzLx8WcnQfy1z1wtK82Bt9FBNwmyg9LGQ4yPQcTg7TvE+WRiNRO
	WWBERNd2jEK1w85xzdAXb66CEZ9z9+sDM/hXnq4Iu/NEGb7lWEj68q1NxU04jLs5aK3Xsz+YbVr
	ZrcvwUA/84CeHo+mTStAn/Mlx+rQ=
X-Google-Smtp-Source: AGHT+IEOjOZGq7WB2zSMauQdhO3Vc/TyK/yHC0Kja5gCp4Aa2d3p9qMMw86F1CFOO3cooYNZUc52laF6Syva9MlPE3o=
X-Received: by 2002:a05:6512:11eb:b0:511:8bb1:fa6e with SMTP id
 p11-20020a05651211eb00b005118bb1fa6emr1042105lfs.22.1708000463316; Thu, 15
 Feb 2024 04:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <7b0f9a055c331aba64405adf60f616c5922c90a5.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <7b0f9a055c331aba64405adf60f616c5922c90a5.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:33:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H55q2C2-+9k1EcEuYTwwhfhm2-ewgfor6=iAaegv5JSvQ@mail.gmail.com>
Message-ID: <CAL3q7H55q2C2-+9k1EcEuYTwwhfhm2-ewgfor6=iAaegv5JSvQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] btrfs: check if cloned device mounts with tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> If another device with the same fsid and uuid would mount then verify if
> it mounts with a temporary fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/312     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out | 19 +++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100755 tests/btrfs/312
>  create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 000000000000..782490b1c62f
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,67 @@
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

Also add the 'clone' group, as it uses reflinks.

> +
> +_cleanup()
> +{
> +       cd /
> +       umount $mnt1 > /dev/null 2>&1

Use $UMOUNT_PROG.

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
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 2
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
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
> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar > $tmp.cp.out 2>&1
> +       ret=3D$?
> +       cat $tmp.cp.out | _filter_testdir_and_scratch
> +       if [ $ret -ne 1 ]; then
> +               _fail "reflink failed to fail"
> +       fi

Such complexity to check if a reflink fails...

All this could be accomplished with a single line:

_cp_reflink $SCRATCH_MNT/foo $mnt1/bar

And then have the golden output expect an error message. That's the
most standard and prefered way to do things in fstests.
No need to redirect stdout and stderr to a temporary file, check
return value, check the temporary file, etc...

> +
> +       check_fsid ${SCRATCH_DEV_NAME[1]}
> +}
> +
> +mount_cloned_device

Really, why have all the test code inside a function that is called only on=
ce?
Get rid of the function...

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
>

