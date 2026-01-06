Return-Path: <linux-btrfs+bounces-20154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D3CF8509
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D2130A131A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B540E30FF06;
	Tue,  6 Jan 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFxlXZnu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077921CC51
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702182; cv=none; b=J2JxBNlKKKgp5eNIjjSlDKGWTqtiP+6JMTjf1ekBJhJijEmKWg3DTgx3hRffzgJNaYCtU1Bqeia5puWKdMbK6/B1dHhFeYc4itSvXEldmPjwAwx8kMQ7KtdxRRrhwrvFUikEW9moq7sSSRBjETSt3j64xMSWvFYb5wSbl5LDpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702182; c=relaxed/simple;
	bh=VXcLMidZ+5a2ktvnUyI1Ow5ey96YO0nR9cGfyTzbi6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIpD7ooWBU5UZkY8qHtkDU7sf6EAu9TVu9G3fN4/A0VF9pjEMH8mHxSMAbA35688HwsBqUadOALVWU/PqvKSMRgY03489W5kg84JxfOrIBMzx837Yu5w3nOTtcyA/9dy5lRWmdyEaNKDbqVqgPRw7l7F/oqetFeBu8EC7ZFef8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFxlXZnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCCAC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702181;
	bh=VXcLMidZ+5a2ktvnUyI1Ow5ey96YO0nR9cGfyTzbi6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SFxlXZnu2c4OmDdb0Z2kN1+6q5QtutTUES2MjFF61AKtlZcKF+naeZSSWIio7AIw2
	 bW0PnR4QnzAZvUyY5ynNlc6uUPyhDNy63TKSGFS1T4t6fNhU/f2f66XB6K30YLYzDE
	 MFQYlUj/IHjOSQldj+85rky2njoNQVzx/oozO/SAiabEe+aOx3JIQAzYuFeCZDC6Gg
	 k/0g9K19n7+1F+cNVI1TyEzxZGEX22oB+XoMQKUryDgkk7rAYEaG4FJagVgUT2ZmcI
	 k+VwJWsF5xh13VxV0Je4290E7PyNzVHGD5m1ZXNGlS/fVdCJrc8s5rEpJHjUkTBDjY
	 AWx3qz3PRaFhQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so4566045a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 04:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQFcRBSPegqMDzF7VT0BDFlV6RnW7RxxQ9UegMxDCRMZ4wpGVFB3MR03gzw96B/P5XTaDP/CCykR0qDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjNA+CcexZUeKWKBWJ+LGS5ptH0f6S581iXji5AnI1aCHf+2y
	Aaa074O/z26JSwZAnftGF8AD1T3uLPYOQKbS5YX8+XfN/JsbG3O3SceekVqqb36Rc38vXqrvDx2
	JMYw6YJbw7AliW3mULisVFWjkEJ7J1wo=
X-Google-Smtp-Source: AGHT+IHgxXbGF7KrOpAZiCtlo0UbQfnxpDuMV+dUsaXXxCvbHlNFhbxWk+N/v2sgO9wf5LMPodjuG4lrLIrYQNpuklU=
X-Received: by 2002:a17:907:2da9:b0:b80:811d:20ba with SMTP id
 a640c23a62f3a-b84298dbbbamr264931766b.14.1767702180316; Tue, 06 Jan 2026
 04:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cb8fdeec6e3bf977682d1074bf3e7ba1719b98c.1765466812.git.fdmanana@suse.com>
 <CAL3q7H7AY2iC+Z8LEv8+TawbuXJdwoXei_0d+NEccVYE5Wu3PA@mail.gmail.com> <20260106115316.jzdtch6zmdo7w5hb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20260106115316.jzdtch6zmdo7w5hb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 Jan 2026 12:22:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4FBxrU6zHLgquFv2yhM-ArWONGdvq9sk8hNcKQNhr8fw@mail.gmail.com>
X-Gm-Features: AQt7F2ooTBez4SOfb96qDrq5DdbbfXplcCNmkD8N5MA3ezwJgKrABqPlPcGW03c
Message-ID: <CAL3q7H4FBxrU6zHLgquFv2yhM-ArWONGdvq9sk8hNcKQNhr8fw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test power failure after fsync and rename
 exchanging directories
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Zorro Lang <zlang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:53=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 04:22:28PM +0000, Filipe Manana wrote:
> > On Thu, Dec 11, 2025 at 3:42=E2=80=AFPM <fdmanana@kernel.org> wrote:
> > >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test renaming one directory over another one that has a subvolume ins=
ide
> > > it and fsync a file in the other directory that was previously rename=
d.
> > > We want to verify that after a power failure we are able to mount the
> > > filesystem and it has the correct content (all renames visible).
> > >
> > > This exercises a bug fixed by the following kernel patch:
> > >
> > >   "btrfs: always detect conflicting inodes when logging inode refs"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Ping.
> >
> > Zorro, this missed the last update.
>
> Hi Filipe, Happey new year :) I just backed from holiday, so hurried to

Happy new year! Thanks.

> merge some patches with enough RVB. This patch hasn't been reviewed,
> especially it conflicted with another patchset (refer to below review poi=
nts),
> so I decided to deal with it in next release. Sorry for the delaying ...

Ok, so this patch was sent before that patchset was merged...
I'll rebase and resend, thanks.

>
> >
> >
> > > ---
> > >  tests/btrfs/340     | 75 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/btrfs/340.out | 15 +++++++++
> > >  2 files changed, 90 insertions(+)
> > >  create mode 100755 tests/btrfs/340
> > >  create mode 100644 tests/btrfs/340.out
> > >
> > > diff --git a/tests/btrfs/340 b/tests/btrfs/340
> > > new file mode 100755
> > > index 00000000..d52893ae
> > > --- /dev/null
> > > +++ b/tests/btrfs/340
> > > @@ -0,0 +1,75 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 340
> > > +#
> > > +# Test renaming one directory over another one that has a subvolume =
inside it
> > > +# and fsync a file in the other directory that was previously rename=
d. We want
> > > +# to verify that after a power failure we are able to mount the file=
system and
> > > +# it has the correct content (all renames visible).
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick subvol rename log
> > > +
> > > +_cleanup()
> > > +{
> > > +       _cleanup_flakey
> > > +       cd /
> > > +       rm -r -f $tmp.*
> > > +}
> > > +
> > > +. ./common/filter
> > > +. ./common/dmflakey
> > > +. ./common/renameat2
> > > +
> > > +_require_scratch
> > > +_require_dm_target flakey
> > > +_require_renameat2 exchange
> > > +
> > > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +       "btrfs: always detect conflicting inodes when logging inode r=
efs"
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > > +_require_metadata_journaling $SCRATCH_DEV
> > > +_init_flakey
> > > +_mount_flakey
>
> The _mount_flakey and _unmount_flakey have been removed by:
>
>   commit eb2ad950ea90d8d8d861f8beac138d6a19f0f819
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Thu Dec 18 08:29:59 2025 +0100
>
>       dmflakey: override SCRATCH_DEV in _init_flakey
>
> > > +
> > > +# Create our test directories, one with a file inside, another with =
a subvolume
> > > +# that is not empty (has one file).
> > > +mkdir $SCRATCH_MNT/dir1
> > > +echo -n > $SCRATCH_MNT/dir1/foo
> > > +
> > > +mkdir $SCRATCH_MNT/dir2
> > > +_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
> > > +echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
> > > +
> > > +_scratch_sync
> > > +
> > > +# Rename file foo so that its inode's last_unlink_trans is updated t=
o the
> > > +# current transaction.
> > > +mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
> > > +
> > > +# Rename exchange dir1 with dir2.
> > > +$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
> > > +
> > > +# Fsync file bar, we just renamed from foo.
> > > +# Until the kernel fix mentioned above, it would result in logging d=
ir2 without
> > > +# logging dir1, causing log replay to attempt to remove the inode fo=
r dir1 since
> > > +# the inode for dir2 has the same name in the same parent directory.=
 Not only
> > > +# this was not correct, since we did not delete the directory, but i=
t would also
> > > +# result in a log replay failure (and therefore mount failure) becau=
se we would
> > > +# be attempting to delete a directory with a non-empty subvolume ins=
ide it.
> > > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
> > > +
> > > +# Simulate a power failure and then mount again the filesystem to re=
play the
> > > +# journal/log. We should be able to replay the log tree and mount su=
ccessfully.
> > > +_flakey_drop_and_remount
> > > +
> > > +echo -e "Filesystem contents after power failure:\n"
> > > +ls -1R $SCRATCH_MNT | _filter_scratch
> > > +
> > > +_unmount_flakey
>
> The _cleanup_flakey in your _cleanup contains the _unmount $SCRATCH_MNT, =
so if
> you don't need "double umount", I think we can remove this line directly.
>
> Others looks good to me, please rebase to v2026.01.05 in v2, then I'll re=
view
> and merge your v2 into patches-in-queue, then push it in next release :)
>
> Thanks,
> Zorro
>
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
> > > new file mode 100644
> > > index 00000000..7745c639
> > > --- /dev/null
> > > +++ b/tests/btrfs/340.out
> > > @@ -0,0 +1,15 @@
> > > +QA output created by 340
> > > +Filesystem contents after power failure:
> > > +
> > > +SCRATCH_MNT:
> > > +dir1
> > > +dir2
> > > +
> > > +SCRATCH_MNT/dir1:
> > > +subvol
> > > +
> > > +SCRATCH_MNT/dir1/subvol:
> > > +subvol_file
> > > +
> > > +SCRATCH_MNT/dir2:
> > > +bar
> > > --
> > > 2.47.2
> > >
> > >
> >
>

