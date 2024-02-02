Return-Path: <linux-btrfs+bounces-2075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A98847236
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772471F2751E
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFB145356;
	Fri,  2 Feb 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOjEznbj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9417E102;
	Fri,  2 Feb 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885508; cv=none; b=WwmBp2FSLzqLzgm+oUJgrZ6YluXuMPCSSj//dVboh2YlaqFqLfbsXMR61wVTRWc+n06pPS83oOvjm53ptk32ActuXlmiR13D++yxd8ldAJKc5NZ5l31AXYbuAQhlBk/+wXSXlQRzK5FgVsOI8XS6gk+mlUSRn80raYh0lLfBMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885508; c=relaxed/simple;
	bh=zUhS/GQ8PfrAlJYNfh9JUV5LTVagX+UohjWX8XP81Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ8bPGoJf7Set2rYFOI85GbPwL3Mfj/xRj7URS2iLnWdyIlnjuCwqaAa3ZcVuFK7aw/FHFLtq9YcNNyMIktZFSh2iqi/l+Ks/oksUXdvmKJttKG41oON7fK5Abt3t9RYRQNXJI5+qKTcyQUNLC63D4FVnu6Mkhx6dyWNermQBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOjEznbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF3C43394;
	Fri,  2 Feb 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706885508;
	bh=zUhS/GQ8PfrAlJYNfh9JUV5LTVagX+UohjWX8XP81Bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gOjEznbjczG1MU6MtZn2BhbrnOkm9j8li20D86KUpy6XIB7nbmHGvz4OZlLI9tj8h
	 C50dl9VtfOpcFzuTOk++2AVn3mIRWPKazTp0CY8vlG0dxMxcimwDTrvcQSE7MweyPS
	 3BOiJo3/GLE7B/jH++5DAIZyBJOq5wrgZgi8MAo0iju9pmIMcIH/mhoffnUQFRVxfw
	 ZIU66TvtCeaquKNVNlfL+foxXGQ6a+gsY+W33cfKXTAePorYO6magXCDaJc6QmVInj
	 IVkVxiiYacULtQvOg3yZPjcI4NcclyBEX5waZ0Qj/jVhqmGNTkdne3PaAQrGEKsF77
	 YxRw/IHy8AEVw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26f73732c5so337595866b.3;
        Fri, 02 Feb 2024 06:51:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yw0VjbCXyopU5qm32mJQyfVTnBhFoPH+YLLY3DvQsPyf5Y+5jhY
	Ig6//Q0+02t12ZxadGicAL0xGdRvEGzpDI7EEiTgRe6axAejvf3i3gUiKxftrxKkcPcBSWZRldX
	00k5erODdEu8ihxVS6wwI8aRsAeI=
X-Google-Smtp-Source: AGHT+IFLOWsjZ5xZhJ8fP4Ew9IYBfAXbeGFrejW+f2u8JKX+/ZKIvqieI7WN9UD4+klEaAIxWzidtom7mWohmORU3e0=
X-Received: by 2002:a17:906:118e:b0:a35:a1dc:8920 with SMTP id
 n14-20020a170906118e00b00a35a1dc8920mr3728098eja.45.1706885506428; Fri, 02
 Feb 2024 06:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
 <20240202131120.q35fe45cmu5e3dqz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240202131120.q35fe45cmu5e3dqz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 Feb 2024 14:51:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>
Message-ID: <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove btrfs/303
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>, kernel-team@fb.com, 
	fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:11=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Tue, Jan 23, 2024 at 11:56:59AM -0800, Boris Burkov wrote:
> > This test was reproducing a bug triggered by creating a subvolume qgrou=
p
> > before creating the subvolume itself with a snapshot.
> >
> > The kernel patch:
> > btrfs: forbid creating subvol qgroups
> >
> > explicitly prevents that and makes it fail with EINVAL. I could "fix"
> > this test by expecting the EINVAL message in the output, but at that
> > point it would simply be a test that creating a subvolume and
> > snapshotting it works with qgroups, which is adequately tested by other
> > tests which focus on accurately measuring shared/exclusive usage in
> > various snapshot/reflink scenarios. To avoid confusion, I think it is
> > best to simply delete this test.
> >
> > Signed-off-by: Boris Burkov
> > ---
>
> Just a reminder, this's a test deletion. To avoid test coverage decrease,
> I'd like to give it more time to get more reviewing of btrfs list. If no
> one has any concern, I'll merge it :)

It's fine, it's the right thing to do.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> >  tests/btrfs/303     | 77 ---------------------------------------------
> >  tests/btrfs/303.out |  2 --
> >  2 files changed, 79 deletions(-)
> >  delete mode 100755 tests/btrfs/303
> >  delete mode 100644 tests/btrfs/303.out
> >
> > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > deleted file mode 100755
> > index 410460af5..000000000
> > --- a/tests/btrfs/303
> > +++ /dev/null
> > @@ -1,77 +0,0 @@
> > -#! /bin/bash
> > -# SPDX-License-Identifier: GPL-2.0
> > -# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > -#
> > -# FS QA Test 303
> > -#
> > -# A regression test to make sure snapshot creation won't cause transac=
tion
> > -# abort if there is already an existing qgroup.
> > -#
> > -. ./common/preamble
> > -_begin_fstest auto quick snapshot subvol qgroup
> > -
> > -. ./common/filter
> > -
> > -_supported_fs btrfs
> > -_require_scratch
> > -
> > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > -     "btrfs: do not abort transaction if there is already an existing =
qgroup"
> > -
> > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > -_scratch_mount
> > -
> > -# Create the first subvolume and get its id.
> > -# This subvolume id should not change no matter if there is an existin=
g
> > -# qgroup for it.
> > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.ful=
l
> > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > -     "$SCRATCH_MNT/snapshot">> $seqres.full
> > -
> > -init_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > -
> > -if [ -z "$init_subvolid" ]; then
> > -     _fail "Unable to get the subvolid of the first snapshot"
> > -fi
> > -
> > -echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> > -
> > -_scratch_unmount
> > -
> > -# Re-create the fs, as btrfs won't reuse the subvolume id.
> > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> > -_scratch_mount
> > -
> > -$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> > -_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> > -
> > -# Create a qgroup for the first subvolume, this would make the later
> > -# subvolume creation to find an existing qgroup, and abort transaction=
.
> > -$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $s=
eqres.full
> > -
> > -# Now create the first snapshot, which should have the same subvolid n=
o matter
> > -# if the quota is enabled.
> > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.ful=
l
> > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > -     "$SCRATCH_MNT/snapshot" >> $seqres.full
> > -
> > -# Either the snapshot create failed and transaction is aborted thus no
> > -# snapshot here, or we should be able to create the snapshot.
> > -new_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > -
> > -echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> > -
> > -if [ -z "$new_subvolid" ]; then
> > -     _fail "Unable to get the subvolid of the first snapshot"
> > -fi
> > -
> > -# Make sure the subvolumeid for the first snapshot didn't change.
> > -if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> > -     _fail "Subvolumeid for the first snapshot changed, has ${new_subv=
olid} expect ${init_subvolid}"
> > -fi
> > -
> > -echo "Silence is golden"
> > -
> > -# success, all done
> > -status=3D0
> > -exit
> > diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> > deleted file mode 100644
> > index d48808e60..000000000
> > --- a/tests/btrfs/303.out
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -QA output created by 303
> > -Silence is golden
> > --
> > 2.43.0
> >
> >
>
>

