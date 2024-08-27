Return-Path: <linux-btrfs+bounces-7548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEAF960730
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AA6B2435C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5521A01D3;
	Tue, 27 Aug 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spTWnpe9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6F19FA9F;
	Tue, 27 Aug 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753482; cv=none; b=YTf0fSPjhu9gBmNy/0Eyy512NmgYaWg4WEtYpoIe384uCW4qMuJJPIQ/O15K+FaBWCVLPKhD24Oe7pn+MangkSyKKIJPuwAKo8MHAbtRlR1K8FINLrcZ9mGovSaw+BbVL7pUXaAmIbjwRsK14GS2Aqzw60w28IZEFzo2jA5NZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753482; c=relaxed/simple;
	bh=ath6OFH61Xr/w25A3v8QAofa3f0OvBqt0rgzsZhicUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5HMiaVheEIVQzH3Fqujt6IWC2xtP+4I49JuflTQRyHe6TgsNxeUsZYw84b0kNAJaGdAltW48XF+0E6GOFJtkF8b+/niX9WWM7AFqPp+KmuKTEzESNi9tNJVFiwbIM9iJosuOI3OeI4iC9wcU0tly5LgOlWxcO+ENNITzhCnXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spTWnpe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A3CC8B7AA;
	Tue, 27 Aug 2024 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724753481;
	bh=ath6OFH61Xr/w25A3v8QAofa3f0OvBqt0rgzsZhicUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=spTWnpe9kIA6xNBdbRXyG0MV+4fvVHwwids/kRJdIZVWqiYVc4OUlDdNekvxs5frT
	 mN1X7Sz37PadhTcsatym0DdWIsShxEjAu3N5YHyiIOZ9357oveGinpZgDvygb5Nbx8
	 c9ow/OXbmTVHsfpRsSDuw//Du8/uT/DQwK3bTkWmAOoAd5EZoMoQSwLci20Pf947pP
	 K1cjVmvP/55xXFMesnr9XA0iVDoaKeOcCi6I8Q4UKyydl5lSrtDLw2xs//27Vh6ARe
	 KaI4DqdA56R3qsC7vHpcFGcPAJHh/9QDwukGRb0rUZFSUd5JUSF9aSjWIH0F/+2gxW
	 dPMdTKywVVedA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86859e2fc0so657104566b.3;
        Tue, 27 Aug 2024 03:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZkvQMQ2CHs4c+Ju9koT0XPjzMUGIMdHC2uYBPPontRzdR8gI9ena+w/DxUylBF+0tUgVpETF3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxycf3VO6cjehSzU7CuHDqIt0m640t30LYJSIYb0nf/NNMi898
	Mm3LarD4NcwRWvTZIrYDXpzJJWDVCvzDo0PZb9+FIYJAiDA+CZQr4wswaoQR5KXoTtnUhOmYUg3
	0+lJxW6Wers7xOzdgoGNqDw6+3G8=
X-Google-Smtp-Source: AGHT+IFjmq72qIk0t8isx3YSqzQ+/tBYblxHuyACj+9S6cGVpsXkqZV9HrjHk5ptsL7pauOsgP3WI63owpRdKx9+NSQ=
X-Received: by 2002:a17:907:7da4:b0:a7a:bece:6222 with SMTP id
 a640c23a62f3a-a86e397e681mr144464566b.10.1724753479833; Tue, 27 Aug 2024
 03:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b0c008b1b05a9fd24b751e174da37bd769637ff.1724717443.git.wqu@suse.com>
In-Reply-To: <1b0c008b1b05a9fd24b751e174da37bd769637ff.1724717443.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 Aug 2024 11:10:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5h3RbhrTG0+UUtQ-0=uyeDefM4x_EFrqtq1uopu2b-DQ@mail.gmail.com>
Message-ID: <CAL3q7H5h3RbhrTG0+UUtQ-0=uyeDefM4x_EFrqtq1uopu2b-DQ@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs: test reading data with a corrupted
 checksum tree leaf
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a bug report that, KASAN get triggered when:
>
> - A read bio needs to be split
>   This can happen for profiles with stripes, including
>   RAID0/RAID10/RAID5/RAID6.
>
> - An error happens before submitting the new split bio
>   This includes:
>   * chunk map lookup failure
>   * data csum lookup failure
>
> Then during the error path of btrfs_submit_chunk(), the original bio is
> fully freed before submitted range has a chance to call its endio
> function, resulting a use-after-free bug.
>
> [NEW TEST CASE]
> Introduce a new test case to verify the specific behavior by:
>
> - Create a btrfs with enough csum leaves with data RAID0 profile
>   To bump the csum tree level, use the minimal nodesize possible (4K).
>   Writing 32M data which needs at least 8 leaves for data checksum
>
>   RAID0 profile ensures the data read bios will get split.
>
> - Find the last csum tree leave and corrupt it
>
> - Read the data many times until we trigger the bug or exit gracefully
>   With an x86_64 VM with KASAN enabled, it can trigger the KASAN report i=
n
>   just 4 iterations (the default iteration number is 32).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Fine now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
> Changelog:
> v3:
> - Remove the unrelated btrfs/125 references
>   There is nothing specific to RAID56, it's just a coincident that
>   btrfs/125 leads us to the bug.
>   Since we have a more comprehensive understanding of the bug, there is
>   no need to mention it at all.
>
> - More grammar fixes
> - Use proper _check_btrfs_raid_type() to verify raid0 support
> - Update the title to be more specific about the test case
> - Renumber to btrfs/321 to avoid conflicts with an new test case
> - Remove unnecessary 'sync' which is followed by unmount
> - Use full subcommand name "inspect-internal"
> - Explain why we want to fail early if hitting the bug
> - Remove unnecessary `_require_scratch` which is duplicated to
>   `_require_scratch_nocheck`
>
> v2:
> - Fix the wrong commit hash
>   The proper fix is not yet merged, the old hash is a place holder
>   copied from another test case but forgot to remove.
>
> - Minor wording update
>
> - Add to "dangerous" group
> ---
>  tests/btrfs/321     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/321.out |  2 ++
>  2 files changed, 85 insertions(+)
>  create mode 100755 tests/btrfs/321
>  create mode 100644 tests/btrfs/321.out
>
> diff --git a/tests/btrfs/321 b/tests/btrfs/321
> new file mode 100755
> index 000000000000..e30199daa0d0
> --- /dev/null
> +++ b/tests/btrfs/321
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 321
> +#
> +# Make sure there are no use-after-free, crashes, deadlocks etc, when re=
ading data
> +# which has its data checksums in a corrupted csum tree block.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick raid dangerous
> +
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 2
> +
> +# Use RAID0 for data to get bio split according to stripe boundary.
> +# This is required to trigger the bug.
> +_require_btrfs_raid_type raid0
> +
> +# This test goes 4K sectorsize and 4K nodesize, so that we easily create
> +# higher level of csum tree.
> +_require_btrfs_support_sectorsize 4096
> +_require_btrfs_command inspect-internal dump-tree
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix a use-after-free bug when hitting errors inside btrfs=
_submit_chunk()"
> +
> +# The bug itself has a race window, run this many times to ensure trigge=
ring.
> +# On an x86_64 VM with KASAN enabled, normally it is triggered before th=
e 10th run.
> +iterations=3D32
> +
> +_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
> +# This test requires data checksum to trigger the bug.
> +_scratch_mount -o datasum,datacow
> +
> +# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M d=
ata
> +# will need 32K data checksum at minimal, which is at least 8 leaves.
> +_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> +_scratch_unmount
> +
> +
> +# Search for the last leaf of the csum tree, that will be the target to =
destroy.
> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRATCH_DEV >> $seqres=
.full
> +target_bytenr=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 7 $SCRA=
TCH_DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
> +
> +if [ -z "$target_bytenr" ]; then
> +       _fail "unable to locate the last csum tree leaf"
> +fi
> +
> +echo "bytenr of csum tree leaf to corrupt: $target_bytenr" >> $seqres.fu=
ll
> +
> +# Corrupt that csum tree block.
> +physical=3D$(_btrfs_get_physical "$target_bytenr" 1)
> +dev=3D$(_btrfs_get_device_path "$target_bytenr" 1)
> +
> +echo "physical bytenr: $physical" >> $seqres.full
> +echo "physical device: $dev" >> $seqres.full
> +
> +_pwrite_byte 0x00 "$physical" 4 "$dev" > /dev/null
> +
> +for (( i =3D 0; i < $iterations; i++ )); do
> +       echo "=3D=3D=3D run $i/$iterations =3D=3D=3D" >> $seqres.full
> +       _scratch_mount -o ro
> +       # Since the data is on RAID0, read bios will be split at the stri=
pe
> +       # (64K sized) boundary. If csum lookup failed due to corrupted cs=
um
> +       # tree, there is a race window that can lead to double bio freein=
g
> +       # (triggering KASAN at least).
> +       cat "$SCRATCH_MNT/foobar" &> /dev/null
> +       _scratch_unmount
> +
> +       # Instead of relying on the final _check_dmesg() to find errors,
> +       # error out immediately if KASAN is triggered.
> +       # As non-triggering runs will generate quite some error messages,
> +       # making investigation much harder.
> +       if _check_dmesg_for "BUG" ; then
> +               _fail "Critical error(s) found in dmesg"
> +       fi
> +done
> +
> +echo "Silence is golden"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/321.out b/tests/btrfs/321.out
> new file mode 100644
> index 000000000000..290a5eb31312
> --- /dev/null
> +++ b/tests/btrfs/321.out
> @@ -0,0 +1,2 @@
> +QA output created by 321
> +Silence is golden
> --
> 2.46.0
>
>

