Return-Path: <linux-btrfs+bounces-12374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B7A67143
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 11:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5096E17DA27
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74162080E9;
	Tue, 18 Mar 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyIhWWwD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B8207E0D;
	Tue, 18 Mar 2025 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293702; cv=none; b=StCsJtB6f8vHU8JMP6XhAkV2HrYBErXaWqpLGqikd6BFP4gtnRnK5iFL1n0+Qhlfn7oX2jQBzSxtcre6dalyw+TwezN7LHL6dr51hLL8Wfn4xAv2kUbGkp45HERE6eMuQkGY0mvZEgektYeexcv7i1Zm9hV2ICHNqrdD2ZiTV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293702; c=relaxed/simple;
	bh=8FM+w0uKEg4GlCykw8p30Aen1+985h5jBOFnbcJDI88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsgDVH0283/skSxVtW9G1MQ+rLm+BvzvOnMwcowntfc8hxqcpPG9CDPhDLuDeWih0iYHpLpy5AgOQ8RoJiUpznvJFPxuvCVA/ty3FopJdVLJqFKIbMRpZg65huNdIP/hKnWaMHxBuXUQZOGjm8g5sQW7OBjieplc1k1TohASRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyIhWWwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8AEC4CEDD;
	Tue, 18 Mar 2025 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742293701;
	bh=8FM+w0uKEg4GlCykw8p30Aen1+985h5jBOFnbcJDI88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CyIhWWwD4VcTQ483yib3pnVTHBLXLs+JSlLwatg9E5yUR111toRzvaG/xs3YeVeq5
	 Ix/pgwmwuFlsi0E1CNulKicosVcbPpqQQNRhh65edboexnREqPbv9nB3eKHb1EBKWe
	 XC7rza/nmyqHKQNGuBnFPC1JEgIHTcJT75KEp5bizf6irdlGA3lWKnidE8cGgLLnwK
	 ykBZBTr57JIWX+7puGqq1PW1M3jNL7WlAjIWpyYx+MMkuk1av+MiM8EofIYA7h9edJ
	 trb61ArW92W+EBJQJ2mnO3ueAg/e3KOVT2n3m/qAYLBQ8iFabKD903m16+iD8PnUsN
	 ukaMZ3BC95rww==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so783920666b.1;
        Tue, 18 Mar 2025 03:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWevUL6q4lmcWD5azEKJ2YzZK/WKkP3Cs9099CUhZn89E1RLNwEfcEPuciHEWKVjG3APWnWsPtxSruIvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSdiID3sOhA+zPCmxq92K6OtfFgzQFMRpeJnk9zta2MY93kWm
	WlLDliuJKF4qwkE/yAfNALDKAz4L6Ly/jTV2XEY/rbPXFgRikpXGfPNAw2r9iU8bOxx/s2RzYlV
	7jxLYiGha14DDzawxdG9/kL8HIUI=
X-Google-Smtp-Source: AGHT+IH+2CcAdomNLVKzNSaZpeBihIK+5sBbMcLHe6lfTzD9+5dsqbeqx4VVQW4qDs+sNDbyaHLOOYzxm19zKtOe5t4=
X-Received: by 2002:a17:907:bb4c:b0:ac3:3e40:e183 with SMTP id
 a640c23a62f3a-ac38d366f4cmr315466166b.3.1742293699656; Tue, 18 Mar 2025
 03:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
In-Reply-To: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Mar 2025 10:27:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7aoYKhQG6V_MgvxVvNhE9mdEnEYgv3b1A10wyz0Zkr_Q@mail.gmail.com>
X-Gm-Features: AQ5f1JptjL8znoZEvcYYNBrswmPCO2lewKg3jxKDGA63crgezEm73COjNLQ3x_E
Message-ID: <CAL3q7H7aoYKhQG6V_MgvxVvNhE9mdEnEYgv3b1A10wyz0Zkr_Q@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
To: Johannes Thumshirn <jth@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 3:05=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
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
> ---
>  tests/btrfs/329     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/329.out |  3 +++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
>
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..441be133e230
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# what am I here for?

Missing description here.

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
> +_scratch_mkfs >> $seqres.full 2>&1

|| _fail "mkfs failed"

That's what we do nowadays.

> +_scratch_mount
> +
> +# Write some data to the FS to dirty it
> +dd if=3D/dev/zero of=3D$SCRATCH_MNT/test bs=3D128k count=3D1024 >> $seqr=
es.full 2>&1

Is there any reason to use dd?

A simple:

$XFS_IO_PROG -f "pwrite 0 128M" $SCRATCH_MNT/test

would do it and it's easier to read (don't have to do the
multiplication to figure out it's 128M of data).

Also, why redirect both stdout and stderr to the .full file?
We want to detect errors and fail with a golden output mismatch rather
than silently ignore errors, so at least don't redirect stderr.
I see this pattern done everywhere in the test case, effectively
ignoring errors.


> +
> +# Add device two to the FS
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT >> $seqres.full 2>&1

Same here.

> +
> +# Move write pointers of all empty zones by 4k to simulate write pointer
> +# mismatch.
> +# 'blkzone report' reports the zone numbers in sectors so we need to con=
vert
> +# it to bytes first. Afterwards we need to convert it to 4k blocks for d=
d.
> +zones=3D$($BLKZONE_PROG report ${devs[1]} | $AWK_PROG '/em/ { print $2 }=
' |\
> +       sed 's/,//')
> +for zone in $zones;
> +do
> +       zone=3D$(($zone / 8))
> +       dd if=3D/dev/zero of=3D${devs[1]} seek=3D$zone bs=3D4k oflag=3Ddi=
rect \
> +               count=3D1 >> $seqres.full 2>&1

Same here.

$XFS_IO_PROG can also be used.
And since this is using odirect, we should have a _require_odirect above.


> +done
> +
> +# expected to fail
> +$BTRFS_UTIL_PROG balance start -mconvert=3Draid1 $SCRATCH_MNT \
> +       >> $seqres.full 2>&1

Expected to fail, but the test is not checking if it fails at all - if
it doesn't fail it doesn't detect it all.
So don't redirect stderr and include stderr output in the golden output fil=
e.

> +
> +_scratch_unmount
> +
> +$MOUNT_PROG -t btrfs -odegraded ${devs[0]} $SCRATCH_MNT
> +
> +$BTRFS_UTIL_PROG device remove --force missing $SCRATCH_MNT >> $seqres.f=
ull 2>&1
> +$BTRFS_UTIL_PROG balance start --full-balance $SCRATCH_MNT >> $seqres.fu=
ll 2>&1

Same here, ignoring failures.

> +
> +# Check that both System and Metadata are back to the DUP profile
> +$BTRFS_UTIL_PROG filesystem df /mnt/scratch/ |\

Please replace /mnt/scratch/ with $SCRATCH_MNT, otherwise the test
will not work on setups with a different scratch mount point (like
mine).

Thanks.

> +       grep -o -e "System, DUP" -e "Metadata, DUP"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
> new file mode 100644
> index 000000000000..eab11130981d
> --- /dev/null
> +++ b/tests/btrfs/329.out
> @@ -0,0 +1,3 @@
> +QA output created by 329
> +System, DUP
> +Metadata, DUP
> --
> 2.43.0
>
>

