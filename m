Return-Path: <linux-btrfs+bounces-2430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7D856395
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296551C20ADB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043612DDB4;
	Thu, 15 Feb 2024 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUP0fnfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35B12CDA9;
	Thu, 15 Feb 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001235; cv=none; b=I13vqrOvwYJJwgC5ry2qyOyTCVixlTEUuvl0ELngiKQjkPRJfTPUu9JNRmAa8EHaEQyj1iqx7WvACnV4nijRUyGiogPWfNFe/Vw4vL7/GO0zLL8ekdUm952zhxjuJENk0Nr4NnG4oXXMPk6pF2jhh7zQUxLiWVLGJVBM9wPRQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001235; c=relaxed/simple;
	bh=kWsf3AHkPo8QTvKNqKBWPYXqhRH0IAXV9J3HpMX+nDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWlBzIASnw4VkCmatmFVgzrhWn5Jo88Pzkq4g75kjvO4l1QVd+7PdyRb49++C72vxxwqD37LD83ON9OwIaSviwZvx1lILFGzvryehbCCQdTlO+joAVmi6y8AMOhgbUxHHsWzRUhe2oAkjsJDPNPDwn3QFfcVy2N9LmsGkPwrhi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUP0fnfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4575C433F1;
	Thu, 15 Feb 2024 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708001234;
	bh=kWsf3AHkPo8QTvKNqKBWPYXqhRH0IAXV9J3HpMX+nDk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUP0fnfdZDlXLJe3npUCoVVqyVsjsh8ko0+jnmBttMjYMwQkohwptPW+9ZVUjcgtH
	 V51piuk//3JKCos66z30lHgBdM8nsBT7QP5RTehJ8F+zLAGB/o9eyqwTHiIOuJJsLH
	 hp+XSDhJ97Nf3R2k2wni1OOX57sesqEfQC0NhBSKqCV+R+YPpo1kZuQT98X2vLG46S
	 5NqGNRhEDvtXHyeAdg5MtzaN+x1eqa3+X5HrM/keJcHl3DXt60S5lIe3azdqNjIgxu
	 ar7jZ0a7tJ7T03Ia86TJTfuSiWdJoaja5aG5OiKcOq7Ut/GS6lkuf3G3X7VV6jsiZE
	 kg+zvgCkhFG8w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso994023e87.0;
        Thu, 15 Feb 2024 04:47:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVS3HXvbmi0qrJIm8g8gADUomnNDgpsE8kvzTv6VjcdCXuiID1QyIwKj1neeowzMNMhXFF6Nc/WErq+gsxfXJk9xoibZORsAsm7NU0=
X-Gm-Message-State: AOJu0Ywsv1WhOAS+HUvp0IOsKWyMx6+8RjiBpRe0PFOsn1HlgfxEuLU5
	vs5gQVoXK8XST2mDib1bGI3skTgeIz3Ol+RbvusRgJ2Pn94dawPWWxcb8QzBXhJZgCTNyePnpaZ
	hUSrvH0oqkwrhPdJqH46KqYPwTBY=
X-Google-Smtp-Source: AGHT+IFbK33SJ2iGgg8cbzNNvlOQvRo74c3/m52SrRxrvn8svgCxnO6wYbfcyeV+upnA+h7CkXLEx4s1ax6RhQWWlSM=
X-Received: by 2002:a05:6512:e98:b0:511:ac21:57db with SMTP id
 bi24-20020a0565120e9800b00511ac2157dbmr1529577lfb.0.1708001233101; Thu, 15
 Feb 2024 04:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <d59e5946ce2bbdb5dd954e715b15b9e834b88493.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <d59e5946ce2bbdb5dd954e715b15b9e834b88493.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:46:36 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6=+HgSk6upxbTFM6M3Y3aynNeq-3Pp5-FtZU-0EB+kqw@mail.gmail.com>
Message-ID: <CAL3q7H6=+HgSk6upxbTFM6M3Y3aynNeq-3Pp5-FtZU-0EB+kqw@mail.gmail.com>
Subject: Re: [PATCH 10/12] btrfs: verify tempfsid clones using mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:36=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Create appearing to be a clone using the mkfs.btrfs option and test if
> the tempfsid is active.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/313     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/313.out | 16 +++++++++++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/btrfs/313
>  create mode 100644 tests/btrfs/313.out
>
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> new file mode 100755
> index 000000000000..45811320e596
> --- /dev/null
> +++ b/tests/btrfs/313
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 313
> +#
> +# Functional test for the tempfsid, clone devices created using the mkfs=
 option.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick tempfsid

clone group as well, it uses reflinks.

> +
> +_cleanup()
> +{
> +       cd /
> +       umount $mnt1 > /dev/null 2>&1

$UMOUNT_PROG

> +       rm -r -f $tmp.*
> +       rm -r -f $mnt1
> +}
> +
> +. ./common/filter.btrfs
> +. ./common/reflink
> +
> +_supported_fs btrfs
> +_require_cp_reflink
> +_require_btrfs_sysfs_fsid
> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_mkfs_uuid_option
> +
> +_scratch_dev_pool_get 2
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +clone_uuids_verify_tempfsid()
> +{
> +       echo ---- $FUNCNAME ----
> +       mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> +
> +       echo Mounting original device
> +       _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> +       check_fsid ${SCRATCH_DEV_NAME[0]}
> +
> +       echo Mounting cloned device
> +       _mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
> +                               _fail "mount failed, tempfsid didn't work=
"
> +       check_fsid ${SCRATCH_DEV_NAME[1]}
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                               _filter_x=
fs_io
> +       echo cp reflink must fail
> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar > $tmp.cp.out 2>&1
> +       ret=3D$?
> +       cat $tmp.cp.out | _filter_testdir_and_scratch
> +       if [ $ret -ne 1 ]; then
> +               _fail "reflink failed to fail"
> +       fi

Same comment as in a previous patch.

So much complexity to check if a reflink fails...

All this could be accomplished with a single line:

_cp_reflink $SCRATCH_MNT/foo $mnt1/bar

And then have the golden output expect an error message. That's the
most standard and prefered way to do things in fstests.
No need to redirect stdout and stderr to a temporary file, check
return value, check the temporary file, etc...


> +}
> +
> +clone_uuids_verify_tempfsid

Really, why have all the test code inside a function that is called only on=
ce?
Get rid of the function...

Thanks.

> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
> new file mode 100644
> index 000000000000..7a089d2c29c5
> --- /dev/null
> +++ b/tests/btrfs/313.out
> @@ -0,0 +1,16 @@
> +QA output created by 313
> +---- clone_uuids_verify_tempfsid ----
> +Mounting original device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> +Mounting cloned device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             TEMPFSID
> +Tempfsid status:       1
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp reflink must fail
> +cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Inva=
lid cross-device link
> --
> 2.39.3
>
>

