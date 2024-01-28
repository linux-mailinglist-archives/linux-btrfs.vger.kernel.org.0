Return-Path: <linux-btrfs+bounces-1859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B3783F616
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809F1B21CE8
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jan 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBBC24B41;
	Sun, 28 Jan 2024 15:24:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007923769;
	Sun, 28 Jan 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706455473; cv=none; b=uUmxu2IgDDJGzRX+bk7zjDm4565UWZhJSB2yKQpbBWFlLX7wf0xlcA91VEgYmiiXhLqwwcW8uhSDHxcwfj5Y5pP9wYF0NhhZx7kfl+vkN3d6TfDIPJ841+pFG4Le8kwjoDcEYszT8bRBcui/fJlnqeeiOHd6ZR6YfX25TcSeYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706455473; c=relaxed/simple;
	bh=1WGm2ryBsFzTy1OtbF6IzWgVoBRA/DRTu0IwIswlh1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSxIcnNWC629brXQRDmI7AZXtJdWaQrmUTHEXtxbRuqMwtM75hgM6Q3QjA3/dMyvm3YVhJgoM1GcyzAKL62Yr+Yi4BRZ6jE51RVDc9fcJzi7vwwP38PiD/XZITAQUu2XCKALAQcq7uNjfEsmzelpei1nGguIe2YIQgn2IMbC8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf591b5db7so9911691fa.2;
        Sun, 28 Jan 2024 07:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706455468; x=1707060268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvQgc2hckMBbQq/LS42Nr9eJB3W5hc9pzJsp+VDP858=;
        b=rTLYzBai8pzI14plTsM0U+ijvYwhTBbIBI1jc6KL20g2h1g0It667S11vMrjbi7nyq
         39hHgcdbalFvAMh8LvMfeS+95jADRz/iEce7ZVGYZk5folY2p5duO7FW8KKUjm5UIUed
         gsU5mB3zVVOoIrUPXRThJfiuvCxqRyOAdjb0I32i56VOfTOZHHS33HiMUX1gkVc26sYP
         47mr604mj9CGQpTAVbNEzFLigvqUsSPUXqC5lyEeWnSy1BBixF7lz5KPrJ9HizRGe8u/
         NGU75LUdBtwBG3A34bNKudzhYU6qCO+K9/4wRtuo9TGwgHMHlvgLKCRj6/kah6ahtiOV
         0tSg==
X-Gm-Message-State: AOJu0YyQAHgvxRm1RNj23oGl0AxsEw1x1V1SEJ0S7aEGr7UHRKqVMl9d
	jYk0AqF2F+cgl+dcnQGkD7HGCU/el+n04fCuyqozM0Key8oTj4mUqT6SPVEtAxFO0A==
X-Google-Smtp-Source: AGHT+IFZektNP/hAhP9tWYFN9Ht13aayFcBKG4LL4MTx/LMJyEgE43fWuEO32D12MN1Ac8Sie/QseQ==
X-Received: by 2002:a2e:3a12:0:b0:2cd:9959:53a0 with SMTP id h18-20020a2e3a12000000b002cd995953a0mr2296211lja.1.1706455468133;
        Sun, 28 Jan 2024 07:24:28 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d11-20020a056402516b00b00559cb738c1bsm2818148ede.4.2024.01.28.07.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 07:24:27 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ef011e934so348877a12.3;
        Sun, 28 Jan 2024 07:24:27 -0800 (PST)
X-Received: by 2002:aa7:d1c5:0:b0:55e:ae9c:b673 with SMTP id
 g5-20020aa7d1c5000000b0055eae9cb673mr1622596edp.41.1706455467684; Sun, 28 Jan
 2024 07:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127204417.11880-1-wqu@suse.com>
In-Reply-To: <20240127204417.11880-1-wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 28 Jan 2024 15:23:51 +0000
X-Gmail-Original-Message-ID: <CAEg-Je-KvRra=Vtn9i0NaLZAGQCt40LaJAHywznKZXStBFRKbw@mail.gmail.com>
Message-ID: <CAEg-Je-KvRra=Vtn9i0NaLZAGQCt40LaJAHywznKZXStBFRKbw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: verify the read behavior of compressed
 inline extent
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 8:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a report about reading a zstd compressed inline file extent
> would lead to either a VM_BUG_ON() crash, or lead to incorrect file
> content.
>
> [CAUSE]
> The root cause is a incorrect memcpy_to_page() call, which uses
> incorrect page offset, and can lead to either the VM_BUG_ON() as we may
> write beyond the page boundary, or writes into the incorrect offset of
> the page.
>
> [TEST CASE]
> The test case would:
>
> - Mount with the specified compress algorithm
> - Create a 4K file
> - Verify the 4K file is all inlined and compressed
> - Verify the content of the initial write
> - Cycle mount to drop all the page cache
> - Verify the content of the file again
> - Unmount and fsck the fs
>
> This workload would be applied to all supported compression algorithms.
> And it can catch the problem correctly by triggering VM_BUG_ON(), as our
> workload would result decompressed extent size to be 4K, and would
> trigger the VM_BUG_ON() 100%.
> And with the revert or the new fix, the test case can pass safely.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/310     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  2 ++
>  2 files changed, 85 insertions(+)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
> ---
> Changelog:
> v2:
> - Add a comment on why a "sync" is needed
> - Update the failure case comment
>   The specific design of the inline extent size is ensured to trigger
>   VM_BUG_ON(), thus remove the data corruption case.
>
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 00000000..507485a4
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Make sure reading on an compressed inline extent is behaving correctly
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +# This test require inlined compressed extents creation, and all the wri=
tes
> +# are designed for 4K sector size.
> +_require_btrfs_inline_extents_creation
> +_require_btrfs_support_sectorsize 4096
> +
> +_fixed_by_kernel_commit e01a83e12604 \
> +       "Revert \"btrfs: zstd: fix and simplify the inline extent decompr=
ession\""
> +

I assume that this will be updated once we land a fixed commit? We
should ensure we keep track of those things...

> +# The correct md5 for the correct 4K file filled with "0xcd"
> +md5sum_correct=3D"5fed275e7617a806f94c173746a2a723"
> +
> +workload()
> +{
> +       local algo=3D"$1"
> +
> +       echo "=3D=3D=3D Testing compression algorithm ${algo} =3D=3D=3D" =
>> $seqres.full
> +       _scratch_mkfs >> $seqres.full
> +       _scratch_mount -o compress=3D${algo}
> +
> +       _pwrite_byte 0xcd 0 4k "$SCRATCH_MNT/inline_file" > /dev/null
> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +       echo "after initial write, md5sum=3D${result}" >> $seqres.full
> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> +               _fail "initial write results incorrect content for \"$alg=
o\""
> +       fi
> +       # Writeback data to get correct fiemap result, or we got FIEMAP_D=
EALLOC
> +       # without compression/inline flags.
> +       sync
> +
> +       $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/inline_file | tail -n 1 =
> $tmp.fiemap
> +       cat $tmp.fiemap >> $seqres.full
> +       # Make sure we got an inlined compressed file extent.
> +       # 0x200 means inlined, 0x100 means not block aligned, 0x8 means e=
ncoded
> +       # (compressed in this case), and 0x1 means the last extent.
> +       if ! grep -q "0x309" $tmp.fiemap; then
> +               rm -f -- $tmp.fiemap
> +               _notrun "No compressed inline extent created, maybe subpa=
ge?"
> +       fi
> +       rm -f -- $tmp.fiemap
> +
> +       # Unmount to clear the page cache.
> +       _scratch_cycle_mount
> +
> +       # For v6.8-rc1 without the revert or the newer fix, this would
> +       # lead to VM_BUG_ON() thus crash
> +       result=3D$(_md5_checksum "$SCRATCH_MNT/inline_file")
> +       echo "after cycle mount, md5sum=3D${result}" >> $seqres.full
> +       if [ "$result" !=3D "$md5sum_correct" ]; then
> +               _fail "read for compressed inline extent failed for \"$al=
go\""
> +       fi
> +       _scratch_unmount
> +       _check_scratch_fs
> +}
> +
> +algo_list=3D($(_btrfs_compression_algos))
> +for algo in ${algo_list[@]}; do
> +       workload $algo
> +done
> +
> +echo "Silence is golden"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 00000000..7b9eaf78
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,2 @@
> +QA output created by 310
> +Silence is golden
> --
> 2.42.0
>
>

Otherwise, LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

