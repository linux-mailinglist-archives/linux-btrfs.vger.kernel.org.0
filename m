Return-Path: <linux-btrfs+bounces-2278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6884F500
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4858D1F27E6A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A6631A93;
	Fri,  9 Feb 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubpnEC5x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE22E644;
	Fri,  9 Feb 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480239; cv=none; b=BUjokvnqdrVCNk3qkKJoRwpK8nD3mD1lWCkjKOgLbFCz+nd7QfXKAAv0apYJo9Wv9wFLFdLlGNEmNoWSdlEfZKNL9FmlGkbSlNj4P7mXaA3K8zzvt6KkUbaeLcMlBBwEeH2rishaT7k9MX8H73ZkBnecRRRODSyOA0U7Ot4TKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480239; c=relaxed/simple;
	bh=OI2YP8ZiUtciMlouFAe6xGmzB0pYKMZ70d9pOF8ad/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQNMucWywblVPBBwW0iVPmtUCzowBrZeLg1rIBfUDn2j7n9Jy79bhIL1OT3wPGuTHspGPvrMTH9Vztzm9AMvh3CrNm+zIkyoaaLdwfLAksFNzMjDggOad94iwd9WOvOa+qUKXGtojAOrM7OEH+zY3+gz82G0gnoiVQfwDbGXNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubpnEC5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE2FC43390;
	Fri,  9 Feb 2024 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707480238;
	bh=OI2YP8ZiUtciMlouFAe6xGmzB0pYKMZ70d9pOF8ad/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubpnEC5xo9KxVmWJTtT7+sfn5KcfFe479MZhnptEJzhSksp07s4CtKPKwE1qvDEU5
	 uV5TbDNnrsPrMp5LgKRRnmLEDPczHF0w4PLwvDylzKXiPkUbuYThy3mhX3uTXBa5BV
	 XuLEIkGKT3IGQRletz5Fm24MaUfbOfsq+QjRt5JBPUs8JE/2aae/7hgmub+TzUikCd
	 7MDp9ok1XLDRtExmjDZLZ7neajAnQjY5Er4KErWz175Rv7Ts4MRvnnPEx4ewnTejt5
	 AAJvOhHYmRl/lzjf8Anq5Fwm8l4Jo0vG2pQrOgzPW/Yp0hH79lKXd4JdX3WkfGjZIZ
	 dN9+N8RHE1Scg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3c00c98d32so39733466b.3;
        Fri, 09 Feb 2024 04:03:58 -0800 (PST)
X-Gm-Message-State: AOJu0YyuZqHQ8dgJUnQIR1IUeNX0gDiEaaJLSHlV9H+gFOBhtfWk2Ho/
	akGuaiHrwnOxW77r3zutLFt0wg/BBTLZoo9UaOvamjVgIqyhJ8f733TNr6AlkRP/RD2AuQjnGg5
	Ty1pH+W2JIcWJ3QRrxPTS5hPWA8E=
X-Google-Smtp-Source: AGHT+IHg+DgbEBRj1ZeBg2CJTi2XtC/KBpCxX8LUTYQ9jYYlECa9vtcBgoKx4/utVO7asyTsQRzupniteTRgE+9DmLw=
X-Received: by 2002:a17:906:fb85:b0:a37:2c8f:6cb5 with SMTP id
 lr5-20020a170906fb8500b00a372c8f6cb5mr1095407ejb.42.1707480237163; Fri, 09
 Feb 2024 04:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209115057.1918103-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20240209115057.1918103-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Feb 2024 12:03:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6N-4vF-Sp+755_scxAZRvtT+Xkf_KCPoRuxBD6g9OYGQ@mail.gmail.com>
Message-ID: <CAL3q7H6N-4vF-Sp+755_scxAZRvtT+Xkf_KCPoRuxBD6g9OYGQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: check conversion of zoned fileystems
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
	Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:51=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Recently we had a bug where a zoned filesystem could be converted to a
> higher data redundancy profile than supported.
>
> Add a test-case to check the conversion on zoned filesystems.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/310     | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out | 31 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
>
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..5a9664d1
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corperation.  All Rights Reserved.

Typo here, "Corperation".

> +#
> +# FS QA Test 310
> +#
> +# Test that btrfs convert can ony be run to convert to supported profile=
s on a
> +# zoned filesystem
> +#
> +. ./common/preamble
> +_begin_fstest volume raid convert


> +
> +_fixed_by_kernel_commit XXXXXXXXXX \
> +       "btrfs: zoned: don't skip block group profile checks on conv zone=
s"
> +
> +. common/filter
> +. common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +
> +_filter_convert()
> +{
> +       _filter_scratch | \
> +       sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out o=
f X chunks/g"
> +}
> +
> +_filter_add()
> +{
> +       _filter_scratch | _filter_scratch_pool | \
> +       sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting d=
evice zones SCRATCH_DEV (XXX/g"
> +
> +}
> +
> +devs=3D( $SCRATCH_DEV_POOL )
> +
> +# Create and mount single device FS
> +_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null
> +_scratch_mount
> +
> +# Convert FS to metadata/system DUP
> +$BTRFS_UTIL_PROG balance start -f -mconvert=3Ddup -sconvert=3Ddup $SCRAT=
CH_MNT 2>&1 | _filter_convert
> +
> +# Convert FS to data DUP, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=3Ddup $SCRATCH_MNT 2>&1 | _filt=
er_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID1, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=3Draid1 $SCRATCH_MNT 2>&1 | _fi=
lter_convert
> +
> +# Convert FS to data RAID0, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=3Draid0 $SCRATCH_MNT 2>&1 | _fi=
lter_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID5, must fail
> +$BTRFS_UTIL_PROG balance start -f -dconvert=3Draid5 $SCRATCH_MNT 2>&1 | =
_filter_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_add
> +
> +# Convert FS to data RAID10, must fail
> +$BTRFS_UTIL_PROG balance start -dconvert=3Draid10 $SCRATCH_MNT 2>&1 | _f=
ilter_convert
> +
> +# Convert FS to data RAID6, must fail
> +$BTRFS_UTIL_PROG balance start -f -dconvert=3Draid6 $SCRATCH_MNT 2>&1 | =
_filter_convert
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 00000000..f1e44af6
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,31 @@
> +QA output created by 310
> +Done, had to relocate X out of X chunks
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +WARNING:
> +
> +       RAID5/6 support has known problems and is strongly discouraged
> +       to be used besides testing or evaluation. It is recommended that
> +       you use one of the other RAID profiles.
> +       Safety timeout skipped due to --force

Btw, instead of relying on all these lines staying the same across
btrfs-progs releases,
we could rely only on the first line only, the one with the error
message or success indication, by piping into a "| head -1".

But anyway, minor things.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +WARNING:
> +
> +       RAID5/6 support has known problems and is strongly discouraged
> +       to be used besides testing or evaluation. It is recommended that
> +       you use one of the other RAID profiles.
> +       Safety timeout skipped due to --force
> +
> --
> 2.35.3
>
>

