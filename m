Return-Path: <linux-btrfs+bounces-7492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5D95F121
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64731C2222D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFF43178;
	Mon, 26 Aug 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC050nGU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4716377F0B;
	Mon, 26 Aug 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674533; cv=none; b=TR00DMiRdiWAh3+vbW1fWPbc6KlLlXO7BBCK9UElYRKatsttvsz7vRL4LS5HpvtxQeMT8AhHQ69cBX0gbUYsLWfbiJDsGvou/QZ656AOmvpDLNP1UGsEE/AudmNVAxevn5Eu6tiCxMnFMZ59GC9U/1oxn7PvJA0V+FTIBeIQgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674533; c=relaxed/simple;
	bh=WCxBUeMzkgQnoO3Ph/wAY9cNfq/IRxDOE2ahkWKhQ4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj6pHToETvStkrDQJQXdAgLEVhwpg8MN6ow/oFRCi7h1pfezRmmNELlnElDd9tme9hvAtoOT8EfeZH8P938G+QMwKZfJcMpq+1QJvZDE5Of85ZP+KaK+V9xlkXP3QQNL0awhVa89Pz7l4RBfOk5c7lMXDqj68C1UWOQ5t/kmGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC050nGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC90DC568CD;
	Mon, 26 Aug 2024 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724674532;
	bh=WCxBUeMzkgQnoO3Ph/wAY9cNfq/IRxDOE2ahkWKhQ4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qC050nGUJh7CBu5TgTZb8WAnD3Q2ZJKwts4N9mXa4tMPkF1zmahv9QMFG11dwX41E
	 On/q6xpVykwukiqcW2bIO/grT1A6q5zJnQh+G5vhwhyCH2CqYNXk8CrIzEzfwP301g
	 VPqX7kmuKsX+ZlnV+SmmE1Fn5gsCAoX6YCBK75KyKhM5IYdu2qr08HVwd0zfdME5Dr
	 5Ggq3JFf3MUVccRDQF1n3eQZOD6RMZSD7JAfGjANMiHJo5VrEirJBGDNrHBBC5IIpl
	 VnL7uFvHJabb5mPbWeuetxDDjhCL8MCkl45YcrfFzlerjWTuxOSWcIloaHt8+ZkzFJ
	 RsfYOX8waG1pw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5392611a12.0;
        Mon, 26 Aug 2024 05:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqsWWk1cd6cQfjn2SRdMcDy8ePYt/8BxXZYBBlXlWBR4QXdVSc7+BAtmoKj2J9LHVET+8uD6No@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEYN1+DvLlliT8+wfmNH1sNQainawaTA+T5X7FwGu30havsb9
	aNqBbOPsLqviIFE4agB5bCvUMGfjO133DO3JLnjr2vIWADA/h1XtA2+xZr2T8qj4rec1BAirv6a
	Z4HEo4+IgMEdLNIuTpI9iOWKiEQY=
X-Google-Smtp-Source: AGHT+IEnq7Xc76B95OSQtLExiA9eZf57tWCqEaLoXdhHp2f1IeQ/co6ZoJZ63nX2OQM0tOhC2be6BNqiLaWuwWfQTQs=
X-Received: by 2002:a17:907:9816:b0:a7a:83f8:cfd5 with SMTP id
 a640c23a62f3a-a86a52b6592mr638212266b.18.1724674531399; Mon, 26 Aug 2024
 05:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824103021.264856-1-wqu@suse.com>
In-Reply-To: <20240824103021.264856-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Aug 2024 13:14:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
Message-ID: <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: a new test case to verify a
 use-after-free bug
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 11:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a use-after-free bug triggered very randomly by btrfs/125.
>
> If KASAN is enabled it can be triggered on certain setup.
> Or it can lead to crash.
>
> [CAUSE]
> The test case btrfs/125 is using RAID5 for metadata, which has a known
> RMW problem if the there is some corruption on-disk.
>
> RMW will use the corrupted contents to generate a new parity, losing the
> final chance to rebuild the contents.
>
> This is specific to metadata, as for data we have extra data checksum,
> but the metadata has extra problems like possible deadlock due to the
> extra metadata read/recovery needed to search the extent tree.
>
> And we know this problem for a while but without a better solution other
> than avoid using RAID56 for metadata:
>
> >   Metadata
> >       Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
> >       respectively.
>
> Combined with the above csum tree corruption, since RAID5 is stripe
> based, btrfs needs to split its read bios according to stripe boundary.
> And after a split, do a csum tree lookup for the expected csum.

This is way too much unrelated stuff.
The problem may have been triggered sporadically by btrfs/125, but
there's no need to go into details on raid5 problems in btrfs.
Even because the use-after-free bug can be triggered without raid5,
just using raid0 like in the test case introduced by this patch.

>
> But if that csum lookup failed, in the error path btrfs doesn't handle
> the split bios properly and lead to double freeing of the original bio
> (the one containing the bio vectors).
>
> [NEW TEST CASE]
> Unlike the original btrfs/125, which is very random and picky to
> reproduce, introduce a new test case to verify the specific behavior by:
>
> - Create a btrfs with enough csum leaves
>   To bump the csum tree level, use the minimal nodesize possible (4K).
>   Writing 32M data which needs at least 8 leaves for data checksum
>
> - Find the last csum tree leave and corrupt it
>
> - Read the data many times until we trigger the bug or exit gracefully
>   With an x86_64 VM (which is never able to trigger btrfs/125 failure)
>   with KASAN enabled, it can trigger the KASAN report in just 4
>   iterations (the default iteration number is 32).
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the wrong commit hash
>   The proper fix is not yet merged, the old hash is a place holder
>   copied from another test case but forgot to remove.
>
> - Minor wording update
>
> - Add to "dangerous" group
> ---
>  tests/btrfs/319     | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/319.out |  2 ++
>  2 files changed, 86 insertions(+)
>  create mode 100755 tests/btrfs/319
>  create mode 100644 tests/btrfs/319.out
>
> diff --git a/tests/btrfs/319 b/tests/btrfs/319
> new file mode 100755
> index 00000000..4be2b50b
> --- /dev/null
> +++ b/tests/btrfs/319

There's already a btrfs/319 test case in for-next btw. This needs to
be renumbered.

> @@ -0,0 +1,84 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 319
> +#
> +# Make sure data csum lookup failure will not lead to double bio freeing
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dangerous

Missing the "raid" group.

> +
> +_require_scratch
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix a use-after-free bug when hitting errors inside btrfs=
_submit_chunk()"
> +
> +# The final fs will have a corrupted csum tree, which will never pass fs=
ck
> +_require_scratch_nocheck
> +_require_scratch_dev_pool 2
> +
> +# Use RAID0 for data to get bio splitted according to stripe boundary.
> +# This is required to trigger the bug.
> +_check_btrfs_raid_type raid0
> +
> +# This test goes 4K sectorsize and 4K nodesize, so that we easily create
> +# higher level of csum tree.
> +_require_btrfs_support_sectorsize 4096
> +
> +# The bug itself has a race window, run this many times to ensure trigge=
ring.
> +# On an x86_64 VM with KASAN enabled, normally it is triggered before th=
e 10th run.
> +runtime=3D32

This is a confusing name because it actually means iterations in the
for loop below, and not a time duration.
I would suggest renaming it to "iterations" for example, or just get
rid of it since it's only used in the for loop's condition.

> +
> +_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>&1
> +# This test requires data checksum to trigger the bug.
> +_scratch_mount -o datasum,datacow
> +
> +# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M d=
ata
> +# will need 32K data checksum at minimal, which is at least 8 leaves.
> +_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> +sync

What's this sync for?
We just do a unmount right after it, which makes it pointless and confusing=
.

> +_scratch_unmount
> +
> +# Search for the last leaf of the csum tree, that will be the target to =
destroy.
> +$BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV >> $seqres.full

Please use the full command name: inspect -> inspect-internal

> +target_bytenr=3D$($BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DE=
V | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )

Same here.

Also, missing at the top a:

_require_btrfs_command inspect-internal dump-tree

Also we're passing the symbolic name "csum" to -t, which not all
versions of btrfs-progs support.
The support was added in btrfs-progs 4.5 (commit
69874af7b81519e40db9d92efa6beebee4220c63).

> +
> +if [ -z "$target_bytenr" ]; then
> +       _fail "unable to locate the last csum tree leave"

leave -> leaf

> +fi
> +
> +echo "bytenr of csum tree leave to corrupt: $target_bytenr" >> $seqres.f=
ull

leave -> leaf

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
> +for (( i =3D 0; i < $runtime; i++ )); do
> +       echo "=3D=3D=3D run $i/$runtime =3D=3D=3D" >> $seqres.full
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
> +       # Manually check the dmesg for "BUG", and do not call _check_dmes=
g()
> +       # as it will clear 'check_dmesg' file and skips the final check a=
fter
> +       # the test.
> +       # For now just focus on the "BUG:" line from KASAN.
> +       if _check_dmesg_for "BUG" ; then
> +               _fail "Critical error(s) found in dmesg"
> +       fi

Why do the check manually? The check script calls _check_dmesg when a
test finishes and if it finds 'BUG:' there, it will make the test
fail.
So there's no need to do the unmount and call _check_dmesg_for.

Thanks.

> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> new file mode 100644
> index 00000000..d40c929a
> --- /dev/null
> +++ b/tests/btrfs/319.out
> @@ -0,0 +1,2 @@
> +QA output created by 319
> +Silence is golden
> --
> 2.46.0
>
>

