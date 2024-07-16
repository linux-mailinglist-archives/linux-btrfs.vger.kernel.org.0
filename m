Return-Path: <linux-btrfs+bounces-6499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7193256D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A852EB22513
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2019DF9A;
	Tue, 16 Jul 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjYYTst4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29E19922C;
	Tue, 16 Jul 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128614; cv=none; b=i9ewiFKG7NBomvv2y2ydFyjlOALAj95nOWhD9JI+yn4hSI2G2bmzHTFwKhoNenFhrt3xeXjjuyfEBfp5CeecP5/0pSIbSov3rzt6hc6Yiz0OOwipN1LavsGEPKi82SGMT2zjawBTKfkXKRkB4nspDA6XQeZGF1U6nCsKsx3myqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128614; c=relaxed/simple;
	bh=huhWb1UgXZmySLJpPk9Zbw3ZmONotkUwehPlRxFBW0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ookgL9KXNrVKgjmMDzYrDvy0HPdSFg+cMVzIY6+0KqXmIvL+cqEzv9pr7CQCJgO/k/e4rfKiy7rI/0vblXutbEfnQbcn9PHwI46K8OrUmD/i6fd9goGlSsTOqHJda0AdpKhv/jSbTj/lf/e0N7fSn/cTAoa9jtvEYbFZ97p0/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjYYTst4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15899C4AF0D;
	Tue, 16 Jul 2024 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128614;
	bh=huhWb1UgXZmySLJpPk9Zbw3ZmONotkUwehPlRxFBW0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZjYYTst4GSdF0QGAgCx9tpbtuHNeh0IfY1mJZDuBfhgpCWh4+b1JZyStJDPd1L8Jg
	 ThjjRCmAsTl2RC44JNQ43qnbUSjUpL9qNSDQ6WyEOJOXBWAOE4SIZ2WFCnbFC7e0xn
	 bnv9jdzkhNuMNI9YD09VK6lIwk54OaD7+ocXYyDkh/pMTK+NnZME5f3A/Tx1owdTVr
	 HLbJeKR4kSOhotqCRLCnvocee/f7+5sd43/u0j3ErZnmwNwFGTWncX0/uMutYoP6ep
	 uwadiIgnvjn37Gv9P+ycbuwQSxXgu+ntKgVPA73vKmxNJM6QTqNgsDLNDdIaVM86mn
	 IpSDquE5CtH7A==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77e7420697so701957966b.1;
        Tue, 16 Jul 2024 04:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUYfXwLP4YMS0RIsVuom/2r4/9s5VsYe+N47TlKaGrB9amGUM/gHHQ4VRwnBPH7mIVprpkaEwjYk6ByOlZj7zAT/Y2bpCMhv7d4gM=
X-Gm-Message-State: AOJu0YzEdeNHhGwfIkQHTPEGXq6qvTZhm8czDF/K+mSSlMJvJNHlbKmy
	TA/P4J82c9FIKAUaQaxcJYU0/Z/gYHRQB9T44rFCtrZ0GweF+fYTMIQmwEfAOSINCoFZ+SOK0S3
	Q1UvM/muheo4p8EYt+roXZ9Lt4hk=
X-Google-Smtp-Source: AGHT+IHtHBM6g+LtjmVj4GtwsZbMIbJESm5ChtNQ1Xd2z9Q2nP2DIqWFqwZTtxjRppKiJjM+BWte+fR76V67MT8KtXE=
X-Received: by 2002:a17:906:154e:b0:a77:cd4f:e4ed with SMTP id
 a640c23a62f3a-a79eaa5e807mr108298466b.63.1721128612610; Tue, 16 Jul 2024
 04:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <330b0c61a77f01bd2aa57e9b500145178a2d751a.1721124764.git.fdmanana@suse.com>
 <5100e656-c2bf-4492-8d55-7c22710e661f@gmx.com>
In-Reply-To: <5100e656-c2bf-4492-8d55-7c22710e661f@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Jul 2024 12:16:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4fk4F7je-ZCL8LGRinOqRmqqBVX_eFE9TRUnPBYaMp7A@mail.gmail.com>
Message-ID: <CAL3q7H4fk4F7je-ZCL8LGRinOqRmqqBVX_eFE9TRUnPBYaMp7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test a compressed send stream scenario that
 triggered a read corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:11=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/7/16 19:44, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test a scenario of a compressed send stream that triggered a bug in the
> > extent map merging code introduced in the merge window for 6.11.
> >
> > The commit that introduced the bug is on its way to Linus' tree and its
> > subject is:
> >
> >     "btrfs: introduce new members for extent_map"
> >
> > The corresponding fix was submitted to the btrfs mailing list, with the
> > subject:
> >
> >    "btrfs: fix corrupt read due to bad offset of a compressed extent ma=
p"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/312     | 115 +++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/btrfs/312.out |   7 +++
> >   2 files changed, 122 insertions(+)
> >   create mode 100755 tests/btrfs/312
> >   create mode 100644 tests/btrfs/312.out
> >
> > diff --git a/tests/btrfs/312 b/tests/btrfs/312
> > new file mode 100755
> > index 00000000..ebecadc6
> > --- /dev/null
> > +++ b/tests/btrfs/312
> > @@ -0,0 +1,115 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 312
> > +#
> > +# Test a scenario of a compressed send stream that triggered a bug in =
the extent
> > +# map merging code introduced in the merge window for 6.11.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send compress
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $tmp.*
> > +     rm -fr $send_files_dir
> > +}
> > +
> > +. ./common/filter
> > +
> > +_require_btrfs_send_version 2
> > +_require_test
> > +_require_scratch
> > +
> > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > +     "btrfs: fix corrupt read due to bad offset of a compressed extent=
 map"
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +first_stream=3D"$send_files_dir/1.send"
> > +second_stream=3D"$send_files_dir/2.send"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> > +_scratch_mount -o compress
> > +
> > +# Create a compressed extent for the range [108K, 144K[. Since it's a
> > +# non-aligned start offset, the first 3K of the extent are filled with=
 zeroes.
> > +# The i_size is set to 141K.
> > +$XFS_IO_PROG -f -c "pwrite -S 0xab 111K 30K" $SCRATCH_MNT/foo >> $seqr=
es.full
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1=
 >> $seqres.full
> > +
> > +# Overwrite a part of the extent we created before.
> > +# This will make the send stream include an encoded write (compressed)=
 for the
> > +# file range [120K, 128K[.
> > +$XFS_IO_PROG -c "pwrite -S 0xcd 120K 8K" $SCRATCH_MNT/foo >> $seqres.f=
ull
> > +
> > +# Now do write after those extents and leaving a hole in between.
> > +# This results in expanding the last block of the extent we first crea=
ted, that
> > +# is, in filling with zeroes the file range [141K, 144K[ (3072 bytes),=
 which
> > +# belongs to the block in the range [140K, 144K[.
> > +#
> > +# When the destination filesystem receives from the send stream a writ=
e for that
> > +# range ([140K, 144K[) it does a btrfs_get_extent() call to find the e=
xtent map
> > +# containing the offset 140K. There's no loaded extent map covering th=
at range
> > +# so it will lookg at the subvolume tree to find a file extent item co=
vering the
> > +# range and then finds the file extent item covering the range [108K, =
144K[ which
> > +# corresponds to the first extent written to the file, before snapshot=
ing.
> > +#
> > +# Note that at this point in time the destination filesystem processed=
 an encoded
> > +# write for the range [120K, 128K[, which created a compressed extent =
map for
> > +# that range and a corresponding ordered extent, which has not yet com=
pleted when
> > +# it received the write command for the [140K, 144K[ range, so the cor=
responding
> > +# file extent item is not yet in the subvolume tree - that only happen=
s when the
> > +# ordered extent completes, at btrfs_finish_one_ordered().
> > +#
> > +# So having found a file extent item for the range [108K, 144K[ where =
140K falls
> > +# into, it tries to add a compressed extent map for that range to the =
inode's
> > +# extent map tree with a call to btrfs_add_extent_mapping() done at
> > +# btrfs_get_extent(). That finds there's a loaded overlapping extent m=
ap for the
> > +# range [120K, 128K[ (the extent from the previous encoded write) and =
then calls
> > +# into merge_extent_mapping().
> > +#
> > +# The merging ended adjusting the extent map we attempted to insert, c=
overing
> > +# the range [108K, 144K[, to cover instead the range [128K, 144K[ (len=
gth 16K)
> > +# instead, since there's an existing extent map for the range [120K, 1=
28K[ and
> > +# we are looking for a range starting at 140K (and ending at 144K). Ho=
wever it
> > +# didn't adjust the extent map's offset from 0 to 20K, resulting in fu=
ture reads
> > +# reading the incorrect range from the underlying extent (108K to 124K=
, 16K of
> > +# length, instead of the 128K to 144K range).
> > +#
> > +# Note that for the incorrect extent map, and therefore read corruptio=
n, to
> > +# happen, we depend on specific timings - the ordered extent for the e=
ncoded
> > +# write for the range [120K, 128K[ must not complete before the destin=
ation
> > +# of the send stream receives the write command for the range [140K, 1=
44K[.
> > +#
>
> Considering it's timing related, do we need multiple runs to make sure
> we can hit it?

We run fstests continuously, so there's not much point in that.

>
> And I'm not sure if fstests is the best place to put all those detailed
> info.

Why not?
I like it there, it explains in detail the problem and without any of
that, anyone reading the test will be puzzled about those specific
write ranges, ordering, etc.

> The _fixed_by_kernel_commit line looks enough to me.

Looking at the changelog of the kernel commit doesn't explain
everything, because this here is a specific context.
That's why I left all those comments explaining everything.


>
> Thanks,
> Qu
>
> > +$XFS_IO_PROG -c "pwrite -S 0xef 160K 4K" $SCRATCH_MNT/foo >> $seqres.f=
ull
> > +
> > +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2=
 >> $seqres.full
> > +
> > +echo "Checksums in the original filesystem:"
> > +echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
> > +echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
> > +
> > +$BTRFS_UTIL_PROG send --compressed-data -q -f $first_stream $SCRATCH_M=
NT/snap1
> > +$BTRFS_UTIL_PROG send --compressed-data -q -f $second_stream \
> > +              -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
> > +
> > +_scratch_unmount
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> > +_scratch_mount
> > +
> > +$BTRFS_UTIL_PROG receive -q -f $first_stream $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG receive -q -f $second_stream $SCRATCH_MNT
> > +
> > +echo "Checksums in the new filesystem:"
> > +echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
> > +echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> > new file mode 100644
> > index 00000000..75f1f4cc
> > --- /dev/null
> > +++ b/tests/btrfs/312.out
> > @@ -0,0 +1,7 @@
> > +QA output created by 312
> > +Checksums in the original filesystem:
> > +e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
> > +4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo
> > +Checksums in the new filesystem:
> > +e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
> > +4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo

