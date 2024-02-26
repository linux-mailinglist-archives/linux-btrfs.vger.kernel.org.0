Return-Path: <linux-btrfs+bounces-2792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4A8673FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC151C241EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85215A7B6;
	Mon, 26 Feb 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d99t1R78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66831F933;
	Mon, 26 Feb 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948597; cv=none; b=Zadr4OJL74AdH3f7eZR1BGhHqOL3cRD7/h4i+lgD5L9blmLIjc7Ccgqm47huX2r9r3kIhwD49OTxRzVRYUobsjG6p7BAUf06QJVv/uAr0t/KZzWJNPqZhX1ZzWyDg5XwKsAePCrr4vkkImmV21rAaBG5hP6ggVSlvSltOJHkJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948597; c=relaxed/simple;
	bh=P/w0uzS+Mc5xel7YQd5k3UwfmsgGcW9mE9f3j6nAMCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXM8t4ebRrE+pahkR76SCzjERuhXuBLm9oalsJdS1UJTRQp3BP93/mcKW2yveLROiVzeeS27B2gWEwqggAYNK3bf8cjTpuhbfL8dVozr9jxouQE+qtWZopHCnUYDgmazqjQWxVkIotLAstiPm5kil4PZRaiXgjaJbIQOPVXBSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d99t1R78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65370C433F1;
	Mon, 26 Feb 2024 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948596;
	bh=P/w0uzS+Mc5xel7YQd5k3UwfmsgGcW9mE9f3j6nAMCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d99t1R782R7G1em+AQe/wU5ypRaOce1GHHVrPz1Lp69QAyJGlKUkjR2i76GuA4mn/
	 P0HKSu6CpPxCZ4VF5/KzNVvxb0BfJnyZcVygCv0fpNwIj2e+lS0TKsOPWQZnds/OHm
	 qpr78Uzcf05spCrzUnuK8zUEnqVEDCC1s4WbO/gxtgVV41PLsVJL9rlq+BnhD1GE4Y
	 C5UF61feL7QRH5b8IhMfHE3U7tSLJ3O8gRclxcFkD86iPuw5TFXe+BL94jqXoKP4bP
	 FEHM7f9wF4miagNh9/Pf1ibLNmmawie+AO0BMwllvz0BQGMlP13StCTvkbCq7Madur
	 WgdSQrgwz4JSw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a437a2a46b1so48776466b.2;
        Mon, 26 Feb 2024 03:56:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/PUOdXBNl/8AQE0noh/RJVmqRalGFbXjgAUGjcvfXSIGxMxyHgVoe/Sj9CaTSPsl4+funZKcJ12RVdQes000pzFybbZwdYnC+RHo=
X-Gm-Message-State: AOJu0YyyUOa2FQskMErXHBgkrI0n0uYzjoyhN7wY3OMMWBP82ImZidw4
	NLpwYicnALClINnhYxIPCZkDnju5lNhpJKD0J8Pxt1RUxRURnUSxmyyzwgnmdJoOx3ohHUtpHml
	T2wO23YL+Gr7S8raYF6hDE76NGB4=
X-Google-Smtp-Source: AGHT+IElC0ADKYN5fOEOfPRL2KxFxrtPf+Jzt55EAEVB6u1cFf0jhu7ReCkeClPDTlbH2J47bs+RlCQY7slyaNlJEH4=
X-Received: by 2002:a17:906:c28d:b0:a3f:c115:3ac8 with SMTP id
 r13-20020a170906c28d00b00a3fc1153ac8mr4543820ejz.43.1708948594757; Mon, 26
 Feb 2024 03:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <efb3d493d6ff44dbf87645669d4d363b0b83ecc3.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <efb3d493d6ff44dbf87645669d4d363b0b83ecc3.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 11:55:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5n1DuR0uzfRGedGL7U6EDeJzyFpWuJeLeHLTG6ZZTTXQ@mail.gmail.com>
Message-ID: <CAL3q7H5n1DuR0uzfRGedGL7U6EDeJzyFpWuJeLeHLTG6ZZTTXQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] btrfs: check if cloned device mounts with tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> If another device with the same fsid and uuid would mount then verify if
> it mounts with a temporary fsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
> add clone group
> fix use $UMOUNT_PROG
> remove (_require_btrfs_command inspect-internal dump-super)
> v2:
> Bring create_cloned_devices() into the testcase.
> Just use _cp_reflink output to match with golden output.
>
>  tests/btrfs/312     | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out | 19 ++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100755 tests/btrfs/312
>  create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 000000000000..90ca7a30d3e2
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,84 @@
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
> +_require_btrfs_sysfs_fsid

This requirement should be inside the check_fsid() helper, as pointed befor=
e.

> +_require_btrfs_fs_feature temp_fsid
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

Now that the function is not generic, in common/btrfs, and used only
once in this test, this check doesn't make that much sense anymore.

> +
> +       echo -n Creating cloned device...

Wondering why the -n here, makes the golden output a bit weird.

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

Unused variable.

Thanks.

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

