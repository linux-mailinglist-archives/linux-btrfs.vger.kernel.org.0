Return-Path: <linux-btrfs+bounces-7495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B2D95F1B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977B21C20C15
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7B1714B4;
	Mon, 26 Aug 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH9PuAP5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5C328A0;
	Mon, 26 Aug 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676355; cv=none; b=KyA+vkl1AQgV0X4bfO+m6GismwbFdjq+I/eI4XU44pwJAlFx4HHS+rs7/mjhvIMrIiBqwq+QtDCPYevet4gMKLbjKOaHtuFiebctg8VebvYtRWTKeLDJB2eievCMXvSLygE8440+lgm/lORtvGvrkJeN2uzluusgFQZhP6gepF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676355; c=relaxed/simple;
	bh=Qexn//9f5LtbgqRGo+XtTfOpbrFOizOPZfWa5irj+yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TP8aVC8b4f7KIPCS+3JfxkV9jLGZUXurgdt5/xFrHCJRrhTUF6mZWWpabcP96vPvrzwP/wTjQN92phSYOcvXi0MA3xgq2hWQ7xeRGFGtx5vBMU8zsOg3jXNxGTsngstc1bC4LwTjRqjSpp5llR0vEmYpxwNwCN3mVBl9ajyFOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH9PuAP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A2C581A3;
	Mon, 26 Aug 2024 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676355;
	bh=Qexn//9f5LtbgqRGo+XtTfOpbrFOizOPZfWa5irj+yg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OH9PuAP5/9M6MhVvuWCM9JiWuynj5XUmE/d9IFuGl0PI/DZS65xpuZL2z+3fzvHnT
	 x6L/sgs/hvXlw46hTJ6FV0Y4ErfymYrN64nvkO2V8T4kTFVx+z0KuV/A1SVrbgf3z8
	 ZstOckDWob31cjvdsKVzEKprL9i+L7ifduh4iH2og6j2AmvBhXNMnZP56GUUyy6qwf
	 u1rmwoDLqU5HMgAMsPk9d48PgOKph9AfuKT5Kz0LrhackjT8EurHdT7t3Z7+ySsznt
	 yiGkcgzQLv+uv0byM1ULos7Fqh3bAyUFYwBvDvk8ViKgXTCrgheF5r2jfVZ5I7WJ8u
	 UyYuLM3DIKRRg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso4611515a12.3;
        Mon, 26 Aug 2024 05:45:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcdUrwbhscpYyVnYp4Hs3b2OGkhDrKkW1Euu33/FyVOVT+gfGPL6wcsbNXN7dLU6aWCkcvNwsJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91dIuYmtBzLlbIBeCilfZrx2j712TibMXLF7otbxYdxlSD/9a
	s40GcnOfw6kDQz2henlw/z8kZNx8vZU4gpeXY75nIvPvSvbje0nUT5Q84b/IaUn8gzQVA7UuSEE
	sZDsrkz0QKpOjM5IhVIOd4LWC0ZI=
X-Google-Smtp-Source: AGHT+IGQjlESHihEKEfKcgnPc8WMjNd3pOHmfWWetfkw/q7SAZdgtnJMnofjCr7WDpz7/49ffsnWTO2tC6lGyAmxwz4=
X-Received: by 2002:a17:907:c0e:b0:a7d:a031:7bb2 with SMTP id
 a640c23a62f3a-a86a5305129mr612395466b.40.1724676353791; Mon, 26 Aug 2024
 05:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824103021.264856-1-wqu@suse.com> <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Aug 2024 13:45:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Th0MjT_34883pHoDX1cs4EM2a2dh_Vb2aRFdEBJqGQA@mail.gmail.com>
Message-ID: <CAL3q7H7Th0MjT_34883pHoDX1cs4EM2a2dh_Vb2aRFdEBJqGQA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: a new test case to verify a
 use-after-free bug
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:14=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Sat, Aug 24, 2024 at 11:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > There is a use-after-free bug triggered very randomly by btrfs/125.
> >
> > If KASAN is enabled it can be triggered on certain setup.
> > Or it can lead to crash.
> >
> > [CAUSE]
> > The test case btrfs/125 is using RAID5 for metadata, which has a known
> > RMW problem if the there is some corruption on-disk.
> >
> > RMW will use the corrupted contents to generate a new parity, losing th=
e
> > final chance to rebuild the contents.
> >
> > This is specific to metadata, as for data we have extra data checksum,
> > but the metadata has extra problems like possible deadlock due to the
> > extra metadata read/recovery needed to search the extent tree.
> >
> > And we know this problem for a while but without a better solution othe=
r
> > than avoid using RAID56 for metadata:
> >
> > >   Metadata
> > >       Do not use raid5 nor raid6 for metadata. Use raid1 or raid1c3
> > >       respectively.
> >
> > Combined with the above csum tree corruption, since RAID5 is stripe
> > based, btrfs needs to split its read bios according to stripe boundary.
> > And after a split, do a csum tree lookup for the expected csum.
>
> This is way too much unrelated stuff.
> The problem may have been triggered sporadically by btrfs/125, but
> there's no need to go into details on raid5 problems in btrfs.
> Even because the use-after-free bug can be triggered without raid5,
> just using raid0 like in the test case introduced by this patch.
>
> >
> > But if that csum lookup failed, in the error path btrfs doesn't handle
> > the split bios properly and lead to double freeing of the original bio
> > (the one containing the bio vectors).
> >
> > [NEW TEST CASE]
> > Unlike the original btrfs/125, which is very random and picky to
> > reproduce, introduce a new test case to verify the specific behavior by=
:
> >
> > - Create a btrfs with enough csum leaves
> >   To bump the csum tree level, use the minimal nodesize possible (4K).
> >   Writing 32M data which needs at least 8 leaves for data checksum
> >
> > - Find the last csum tree leave and corrupt it
> >
> > - Read the data many times until we trigger the bug or exit gracefully
> >   With an x86_64 VM (which is never able to trigger btrfs/125 failure)
> >   with KASAN enabled, it can trigger the KASAN report in just 4
> >   iterations (the default iteration number is 32).
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v2:
> > - Fix the wrong commit hash
> >   The proper fix is not yet merged, the old hash is a place holder
> >   copied from another test case but forgot to remove.
> >
> > - Minor wording update
> >
> > - Add to "dangerous" group
> > ---
> >  tests/btrfs/319     | 84 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/319.out |  2 ++
> >  2 files changed, 86 insertions(+)
> >  create mode 100755 tests/btrfs/319
> >  create mode 100644 tests/btrfs/319.out
> >
> > diff --git a/tests/btrfs/319 b/tests/btrfs/319
> > new file mode 100755
> > index 00000000..4be2b50b
> > --- /dev/null
> > +++ b/tests/btrfs/319
>
> There's already a btrfs/319 test case in for-next btw. This needs to
> be renumbered.
>
> > @@ -0,0 +1,84 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 319
> > +#
> > +# Make sure data csum lookup failure will not lead to double bio freei=
ng
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick dangerous
>
> Missing the "raid" group.
>
> > +
> > +_require_scratch

Also this is not needed, because below we do a call to:
_require_scratch_nocheck

Finally the subject could be more specific like for example:

"btrfs: test reading data with a corrupted checksum tree leaf"

Since the test serves to check there are no use-after-free, crashes,
deadlocks, etc, when reading data which has its checksums in a
corrupted csum tree block.

Thanks.

> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +       "btrfs: fix a use-after-free bug when hitting errors inside btr=
fs_submit_chunk()"
> > +
> > +# The final fs will have a corrupted csum tree, which will never pass =
fsck
> > +_require_scratch_nocheck
> > +_require_scratch_dev_pool 2
> > +
> > +# Use RAID0 for data to get bio splitted according to stripe boundary.
> > +# This is required to trigger the bug.
> > +_check_btrfs_raid_type raid0
> > +
> > +# This test goes 4K sectorsize and 4K nodesize, so that we easily crea=
te
> > +# higher level of csum tree.
> > +_require_btrfs_support_sectorsize 4096
> > +
> > +# The bug itself has a race window, run this many times to ensure trig=
gering.
> > +# On an x86_64 VM with KASAN enabled, normally it is triggered before =
the 10th run.
> > +runtime=3D32
>
> This is a confusing name because it actually means iterations in the
> for loop below, and not a time duration.
> I would suggest renaming it to "iterations" for example, or just get
> rid of it since it's only used in the for loop's condition.
>
> > +
> > +_scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >> $seqres.full 2>=
&1
> > +# This test requires data checksum to trigger the bug.
> > +_scratch_mount -o datasum,datacow
> > +
> > +# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M=
 data
> > +# will need 32K data checksum at minimal, which is at least 8 leaves.
> > +_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> > +sync
>
> What's this sync for?
> We just do a unmount right after it, which makes it pointless and confusi=
ng.
>
> > +_scratch_unmount
> > +
> > +# Search for the last leaf of the csum tree, that will be the target t=
o destroy.
> > +$BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_DEV >> $seqres.ful=
l
>
> Please use the full command name: inspect -> inspect-internal
>
> > +target_bytenr=3D$($BTRFS_UTIL_PROG inspect dump-tree -t csum $SCRATCH_=
DEV | grep "leaf.*flags" | sort | tail -n1 | cut -f2 -d\ )
>
> Same here.
>
> Also, missing at the top a:
>
> _require_btrfs_command inspect-internal dump-tree
>
> Also we're passing the symbolic name "csum" to -t, which not all
> versions of btrfs-progs support.
> The support was added in btrfs-progs 4.5 (commit
> 69874af7b81519e40db9d92efa6beebee4220c63).
>
> > +
> > +if [ -z "$target_bytenr" ]; then
> > +       _fail "unable to locate the last csum tree leave"
>
> leave -> leaf
>
> > +fi
> > +
> > +echo "bytenr of csum tree leave to corrupt: $target_bytenr" >> $seqres=
.full
>
> leave -> leaf
>
> > +
> > +# Corrupt that csum tree block.
> > +physical=3D$(_btrfs_get_physical "$target_bytenr" 1)
> > +dev=3D$(_btrfs_get_device_path "$target_bytenr" 1)
> > +
> > +echo "physical bytenr: $physical" >> $seqres.full
> > +echo "physical device: $dev" >> $seqres.full
> > +
> > +_pwrite_byte 0x00 "$physical" 4 "$dev" > /dev/null
> > +
> > +for (( i =3D 0; i < $runtime; i++ )); do
> > +       echo "=3D=3D=3D run $i/$runtime =3D=3D=3D" >> $seqres.full
> > +       _scratch_mount -o ro
> > +       # Since the data is on RAID0, read bios will be split at the st=
ripe
> > +       # (64K sized) boundary. If csum lookup failed due to corrupted =
csum
> > +       # tree, there is a race window that can lead to double bio free=
ing
> > +       # (triggering KASAN at least).
> > +       cat "$SCRATCH_MNT/foobar" &> /dev/null
> > +       _scratch_unmount
> > +
> > +       # Manually check the dmesg for "BUG", and do not call _check_dm=
esg()
> > +       # as it will clear 'check_dmesg' file and skips the final check=
 after
> > +       # the test.
> > +       # For now just focus on the "BUG:" line from KASAN.
> > +       if _check_dmesg_for "BUG" ; then
> > +               _fail "Critical error(s) found in dmesg"
> > +       fi
>
> Why do the check manually? The check script calls _check_dmesg when a
> test finishes and if it finds 'BUG:' there, it will make the test
> fail.
> So there's no need to do the unmount and call _check_dmesg_for.
>
> Thanks.
>
> > +done
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> > new file mode 100644
> > index 00000000..d40c929a
> > --- /dev/null
> > +++ b/tests/btrfs/319.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 319
> > +Silence is golden
> > --
> > 2.46.0
> >
> >

