Return-Path: <linux-btrfs+bounces-12382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA0A6776E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86BCE17D437
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031F20E703;
	Tue, 18 Mar 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHYZo6z8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8F20E6EC;
	Tue, 18 Mar 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310904; cv=none; b=poRnaSBLB4sG74teBowo50ITn5lGvQ3f5ZwgHOtBjTrs1+8sW1fFnisImI6i3Mnm5voM++TvlR6uDZerNmP+qAY/M+zIoH87Y1OCKG2fa2nmb/otk+igN8qj4xkyDUhtiF/72SSovJNZwaKIWLnSPXeKV9ic8G3rwYlybBF8DR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310904; c=relaxed/simple;
	bh=iwsIAoH8sW9n9h/dVijf9JsO8LC4GQP+Z3P3Vfx1HX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TngeqU1erIXTMIXaYArmOsdb8qCUMJKJ4xX/xRJt4kAut6J5Ytu5r8TT27PuhpUOCZveweJzCEzrK8AkH+4RSWV2Omrngh5IZF/1dAxs+b/9qXE7EBhyaO/knBZ/G0ghd5H7Y7QGJVS5nrOYvUkQNXH42ULLMny8zbGbdfi4//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHYZo6z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63BC4CEF7;
	Tue, 18 Mar 2025 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310904;
	bh=iwsIAoH8sW9n9h/dVijf9JsO8LC4GQP+Z3P3Vfx1HX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHYZo6z8tEno2nuqEy7Ikau0arXRFLWCzhmskeMXhJULh/74V2txe4U5YKsYFRmim
	 ubFNoiBnEljRxEJzEEv52cWmI5+jwGpbtZMKTfhla2TPXinxBGpsLHAUkSJffDHXdI
	 IrI0GQRWyO6yEBDnOh0x+p1OrMYzoqkCJm+bP/Z+g6JwBd+qrs4zMBs/hPDNIfnaSP
	 kfGXyhTXqUKmTEcmZf4PREuuSLnXeyZMTT9PFFtOuUP2UuAyL6lZyJ3sravHyRN7x+
	 QmA/umsKJwl6yxiQ6IxHtZhyx6K18+7X4Dw74md9hesjhKf7QxeC39x6NQlqT4wJ9A
	 14pUYuEQ+VSDA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso7166579a12.0;
        Tue, 18 Mar 2025 08:15:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEXqrEYGq9juTPklWcN4PrpdoJuCmU6Qv/hhTu4OZrGGREtcFVaOmJtoVoeOhC9c/4XF8UBwx7I5pq9kQ=@vger.kernel.org, AJvYcCVh7MBf5wFZ9TUTxDRaIxSd3h0UrjbJoqnyGgsKG7T08OGYJkDdA0ErUjzDLt7yfjhKKvWFAini@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFpAlq2aCrzAnSH4N5PocFfej9PsOaKKBG9yEKaK4EUeqfDej
	8xqS7fu6nF809M/IX6FZH29zYevEsOlRL79MUbpcjgCGyX6T0Ts5JvKZ4HJcHUTTdtqL0Ogkgvq
	+nuWVHKB1J9Uj124sQjg7j9SgYw0=
X-Google-Smtp-Source: AGHT+IH0+d45XGwR/BWMVTK3Macga04jxT38NSNCNg8Q0ck/p+oFF8A7BmDss/GNxCtQNUhB7r4wJf0nAI5pmW40Pxo=
X-Received: by 2002:a17:907:9495:b0:abe:c81a:985d with SMTP id
 a640c23a62f3a-ac3304d6112mr1498964666b.48.1742310902618; Tue, 18 Mar 2025
 08:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
In-Reply-To: <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Mar 2025 15:14:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7JKsaME+Kvtn0U+8Sc=B3M_8-dSSNcTyopA60bpa3SQQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqe92zqQV_j5JVLgZgxeUxfVm7hIspJejTFRYvfyRWzwJek-MSCeW4lU6s
Message-ID: <CAL3q7H7JKsaME+Kvtn0U+8Sc=B3M_8-dSSNcTyopA60bpa3SQQ@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
To: Johannes Thumshirn <jth@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>, 
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:17=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Recently we had a bug report about a kernel crash that happened when the
> user was converting a filesystem to use RAID1 for metadata, but for some
> reason the device's write pointers got out of sync.
>
> Test this scenario by manually injecting de-synchronized write pointer
> positions and then running conversion to a metadata RAID1 filesystem.
>
> In the testcase also repair the broken filesystem and check if both syste=
m
> and metadata block groups are back to the default 'DUP' profile
> afterwards.
>
> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=3DduVyhc9hNE+g=
u=3DB8CrgLO152uMyanR8BEA@mail.gmail.com/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

>
> ---
> Changes to v2:
> - Filter SCRATCH_MNT in golden output
> Changes to v1:
> - Add test description
> - Don't redirect stderr to $seqres.full
> - Use xfs_io instead of dd
> - Use $SCRATCH_MNT instead of hardcoded mount path
> - Check that 1st balance command actually fails as it's supposed to
> ---
>  tests/btrfs/329     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/329.out |  7 +++++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
>
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..5496866ac325
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# Regression test for a kernel crash when converting a zoned BTRFS from
> +# metadata DUP to RAID1 and one of the devices has a non 0 write pointer
> +# position in the target zone.
> +#
> +. ./common/preamble
> +_begin_fstest zone quick volume
> +
> +. ./common/filter
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: zoned: return EIO on RAID1 block group write pointer mism=
atch"
> +
> +_require_scratch_dev_pool 2
> +declare -a devs=3D"( $SCRATCH_DEV_POOL )"
> +_require_zoned_device ${devs[0]}
> +_require_zoned_device ${devs[1]}
> +_require_command "$BLKZONE_PROG" blkzone
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Write some data to the FS to dirty it
> +$XFS_IO_PROG -fc "pwrite 0 128M" $SCRATCH_MNT/test | _filter_xfs_io
> +
> +# Add device two to the FS
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full
> +
> +# Move write pointers of all empty zones by 4k to simulate write pointer
> +# mismatch.
> +zones=3D$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }=
' |\
> +       sed 's/,//')
> +for zone in $zones;
> +do
> +       # We have to ignore the output here, as a) we don't know the numb=
er of
> +       # zones that have dirtied and b) if we run over the maximal numbe=
r of
> +       # active zones, xfs_io will output errors, both we don't care.
> +       $XFS_IO_PROG -fdc "pwrite $(($zone << 9)) 4096" ${devs[1]} > /dev=
/null 2>&1
> +done
> +
> +# expected to fail
> +$BTRFS_UTIL_PROG balance start -mconvert=3Draid1 $SCRATCH_MNT 2>&1 |\
> +       _filter_scratch
> +
> +_scratch_unmount
> +
> +$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
> +
> +$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.f=
ull
> +$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.fu=
ll
> +
> +# Check that both System and Metadata are back to the DUP profile
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT |\
> +       grep -o -e "System, DUP" -e "Metadata, DUP"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
> new file mode 100644
> index 000000000000..e47a2a6ff04b
> --- /dev/null
> +++ b/tests/btrfs/329.out
> @@ -0,0 +1,7 @@
> +QA output created by 329
> +wrote 134217728/134217728 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +ERROR: error during balancing 'SCRATCH_MNT': Input/output error
> +There may be more info in syslog - try dmesg | tail
> +System, DUP
> +Metadata, DUP
> --
> 2.43.0
>
>

