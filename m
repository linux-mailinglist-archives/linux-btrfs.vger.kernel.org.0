Return-Path: <linux-btrfs+bounces-12525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADABBA6F852
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBDF16B99B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3D255E49;
	Tue, 25 Mar 2025 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3gOBFJI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2961DF72C;
	Tue, 25 Mar 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903580; cv=none; b=lE+qJl37nx2gIjC5SOAkknnjfBn3W4llqIyTQaGdeLbT+e4xa0dMDxxD3swP5clXF1cmE69TEhBFINaZi1ZXvLJ1h1ZdLtQDppI4GBahtCDMdf2JCwvmYxGyVDIsooAYhzMs40fNk7YLloZtdfL4pxeAInsxRKeOH9dzLDaifhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903580; c=relaxed/simple;
	bh=cqaipVPHUWAt0h+YzIVLN+OzZlG66nexpQhMyYMyM/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwFJezewp755nq2On+k3SD5/q6LIa9HHoCPQ4JH4+06U6TuBJ1dsCkdZhsmjXE+Sfw3skKlnHPJVJrDLy637llpo/0dWj7LGLct84hzAlB/GjSAnF2LGc+JIGav469qokew0XcrY9+vXaDSViQCTlb6NiXJN9fEo620QztnFa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3gOBFJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2EFC4CEED;
	Tue, 25 Mar 2025 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903579;
	bh=cqaipVPHUWAt0h+YzIVLN+OzZlG66nexpQhMyYMyM/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c3gOBFJIOvrL7Xklr9bu5an9E29Pch7sqxAWUgtM9Do2enifpUV2D7kUZSaFW2gRI
	 SKmoRATwK/WJmXi5iMjQd7enIE4T2gDcUIcYlo23+KPFhFz4H8rIlIg9ONNOtKkQo9
	 UeSBHa/ckMn9iq5SzEKCuYmZQWXWASKI9d1kUp3Fsfc44xaoiApiM46c9P1dcynxDV
	 U1gdo4T95f+lSqu22W2FFTcuSFadzXA7P9z+HDRT6vzKB1QsjeD1mnqzxFVM+oBPeo
	 Hz1ykMgrqcsiY4Xfh3mJEW4u4eIUbrpHMibj5ldbGG+OIOguQ5F/oEd3KJse4ZnKpL
	 yQ1Y2jA1NvQ7w==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf3d64849dso892896266b.3;
        Tue, 25 Mar 2025 04:52:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXteQNsVnLw0ljUxZCKTSHFnB2zEWbED3MzHNSFGWZpEn5qtanaNOar6cpoCBe5dmtRtII5bA9oTCJEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyjUgAyMjml8bQP9yc6Z/XorfgB5jbkGhYG+aXC6kavcLEaqD1
	fQATLUEW9wXac1Wo3MhBf5Hxoi+NI/vBOVQFRN338MFQJEJ2H+EYj6ZmlYDH8OveKXql3NscARV
	hDS+cGKG8eQh4AsCULV79cz+QP+U=
X-Google-Smtp-Source: AGHT+IE2cGwibpYfqifnrAku1JFZOZsextAVBLRRuFXXIJ0f8Qt58Jm4cwdZ8kKB0CrVbMDlg1ucT6gnH4VPziSKu2k=
X-Received: by 2002:a17:907:bd0d:b0:abf:e7c1:b3bf with SMTP id
 a640c23a62f3a-ac3f24163f7mr1773549966b.11.1742903578031; Tue, 25 Mar 2025
 04:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
 <Z-HQypONiMW6tnYi@dread.disaster.area>
In-Reply-To: <Z-HQypONiMW6tnYi@dread.disaster.area>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Mar 2025 11:52:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5RhFAFutEVr49mk+NYVM7XB_6svWXL8XRNhqo3FxuaxQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqurRwiL8MPBGe_F0XZcd-k2j2S4GvAv3Nauru7x9Mnnj6pcYFXop4kR_4
Message-ID: <CAL3q7H5RhFAFutEVr49mk+NYVM7XB_6svWXL8XRNhqo3FxuaxQ@mail.gmail.com>
Subject: Re: [PATCH] generic: test fsync of file with no more hard links
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:38=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Mar 21, 2025 at 11:09:58AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we fsync a file that has no more hard links, power fail an=
d
> > then mount the filesystem, after the journal/log is replayed, the file
> > doesn't exists anymore.
> >
> > This exercises a bug recently found and fixed by the following patch fo=
r
> > the linux kernel:
> >
> >    btrfs: fix fsync of files with no hard links not persisting deletion
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/764     | 78 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/764.out |  2 ++
> >  2 files changed, 80 insertions(+)
> >  create mode 100755 tests/generic/764
> >  create mode 100644 tests/generic/764.out
> >
> > diff --git a/tests/generic/764 b/tests/generic/764
> > new file mode 100755
> > index 00000000..57d21095
> > --- /dev/null
> > +++ b/tests/generic/764
> > @@ -0,0 +1,78 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test 764
> > +#
> > +# Test that if we fsync a file that has no more hard links, power fail=
 and then
> > +# mount the filesystem, after the journal/log is replayed, the file do=
esn't
> > +# exists anymore.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick log
> > +
> > +_cleanup()
> > +{
> > +     if [ ! -z $XFS_IO_PID ]; then
>
>         if [ -n "$XFS_IO_PID" ]; then
>
> > +             kill $XFS_IO_PID > /dev/null 2>&1
> > +             wait $XFS_IO_PID > /dev/null 2>&1
> > +     fi
> > +     _cleanup_flakey
> > +     cd /
> > +     rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/dmflakey
> > +
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix fsync of files with no hard links not persisting dele=
tion"
> > +
> > +_require_scratch
> > +_require_dm_target flakey
> > +_require_mknod
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_mount_flakey
> > +
> > +touch $SCRATCH_MNT/foo
> > +
> > +# Commit the current transaction and persist the file.
> > +_scratch_sync
> > +
> > +# A fifo to communicate with a background xfs_io process that will fsy=
nc the
> > +# file after we deleted its hard link while it's open by xfs_io.
> > +mkfifo $SCRATCH_MNT/fifo
> > +
> > +tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.fu=
ll &
> > +XFS_IO_PID=3D$!
> > +
> > +# Give some time for the xfs_io process to open a file descriptor for =
the file.
> > +sleep 1
> > +
> > +# Now while the file is open by the xfs_io process, delete its only ha=
rd link.
> > +rm -f $SCRATCH_MNT/foo
> > +
> > +# Now that it has no more hard links, make the xfs_io process fsync it=
.
> > +echo "fsync" > $SCRATCH_MNT/fifo
> > +
> > +# Terminate the xfs_io process so that we can unmount.
> > +echo "quit" > $SCRATCH_MNT/fifo
> > +wait $XFS_IO_PID
> > +unset XFS_IO_PID
>
> So this is effectively src/multi_open_unlink.c with an added fsync
> after the unlink() call.

No, it's not just an extra fsync.

>
> Wouldn't it be better to add a "-F" option to multi_open_unlink.c to
> tell it to fsync after the unlink to src/multi_open_unlink.c, and
> then the test becomes a lot simpler

multi_open_unlink creates the files and does the unlink in the same
"transaction" - without any sync in between.

The goal here is to verify that a previously persisted file doesn't
exist after the unlink + fsync.

>
> > +# Simulate a power failure and then mount again the filesystem to repl=
ay the
> > +# journal/log.
> > +_flakey_drop_and_remount
> > +
> > +# We don't expect the file to exist anymore, since it was fsynced when=
 it had no
> > +# more hard links.
> > +[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
>
> `ls $SCRATCH_MNT` and let the golden image match fail because
> there's output when the file still exists. i.e. the ls command
> should be silent if the test passes.

We've been through this in past tests.
The reason why not using ls and match against the golden output is
because on ext4 we'll get the 'lost+found' directory, so would have to
do something like:

ls $SCRATCH_MNT/ | grep -v 'lost+found'

And maybe other filesystems may have their own similar directory but
with other names (I'm not aware of any however).
That's why it's explicitly testing if the file exists.

>
> > +_unmount_flakey
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
>
> OK, so this seems to me that the test could be written as:
>
>         src/multi_open_unlink -F -f $SCRATCH_MNT -s 0 -n 1
>         _flakey_drop_and_remount
>
>         ls $SCRATCH_MNT
>         _unmount_flakey
>
>         echo "Silence is golden"
>         status=3D0
>         exit
>
> if we add a few lines of code to add fsync support to
> src/multi_open_unlink.c...

Nop, not without a 'sync' after it creates the files too.
But that may be way too specific and add yet another flag to the program.

Thanks.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

