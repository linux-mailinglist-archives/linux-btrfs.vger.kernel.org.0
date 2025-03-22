Return-Path: <linux-btrfs+bounces-12501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D5A6CC6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F27175B35
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085E23535D;
	Sat, 22 Mar 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQRQDNRY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FD175A5;
	Sat, 22 Mar 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676052; cv=none; b=O1lRN96t9EFAug+ATFxtj4rZUxKQieZ6rSyRCE2JzhTDpq+ZkPR2lU53J+48fxOn3IlaXq6Qp2MshDCQVXYioH07tZX4daEH6P2f/Rt8gNXF+zmTmh3SHrDFTbjllObXRWY8+v3JE3MjF3u7ZIHSRA6lpuMT0YsdMAtKx3WTvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676052; c=relaxed/simple;
	bh=UfUFWsJ5jBjhbf4MCsH0L52QhkLYbES12tT77c+TWpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJcxyTZ2kfQKESq5gWbU+Z+vG776jzNdI9mOUZ7mZk+Ft+h0qEVSOzpdpBYnRgxzIjRnfV8GdjGv6c89+cVa0czBbZXJOezJtuMGkmqovi3K0+QeQsM4Oj8o0qpZAUk+AbIVHQqVf0LImK5JZaOAwfAEAL9Vl5sVolsVXQCPdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQRQDNRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8A7C4CEDD;
	Sat, 22 Mar 2025 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742676052;
	bh=UfUFWsJ5jBjhbf4MCsH0L52QhkLYbES12tT77c+TWpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MQRQDNRYpCuXuWrjNNgjPx8Y/B7b7hsvGKWgR81XGd6e/LIxJjUbE36uGxmaG8u4a
	 gBogoPzMAYeHF1EgCzSSzruCoOOL3Vlj91HA46yTifxUtayBnQLzsl+YQNN3xOjnm4
	 /Ga4Y+Ip+OUlU87q2qkwWZwZAL8OMar3DXnEwOciMMHVoFXjeQnM8AOvn7QDwEVtcA
	 CNghflcASmA1dit44jNVZvdP4Jwk1f8uS5AmsOacHQE01PG9HOTVQcI2ejWIatrch6
	 bWujwKLcEyJbMf3IrKeDpnjpYe7H1Oz2qAHYMWmQXhzP5HH/ghE3AicuDIustlg8yk
	 loBFTFvEd+I0g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25d2b2354so524828966b.1;
        Sat, 22 Mar 2025 13:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5UxKo/F4peSlmkAmi0wgioR26kPyEYRB9nyixyx1y9VI/xCtUUGuue7ZQ46G2j/zkB/vtQkFYRFnEYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5I70jYR20QT1EjVmI/wK+Yl4omtWn+Zp022Ux1z1fXeLlbwHB
	lZL44jayizFtXfSgR1axGS35F/FGIc3IaDDZvCQACxqazp0H647FXcxZwZgTw+b1ize0By+sYrD
	g+wupbgxFBevxZkgRMGxmZMguZ88=
X-Google-Smtp-Source: AGHT+IE9OH+yRKES+Z45S1HEQptfW5/+3DsTjDt7S3ee1kfwsY8VOVB1g2L4kWKUVRhMluaeV5BQ2+Oui7pckwYaEeI=
X-Received: by 2002:a17:907:9482:b0:ac3:10e3:7fa5 with SMTP id
 a640c23a62f3a-ac3f20f51cbmr661144566b.21.1742676050590; Sat, 22 Mar 2025
 13:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
 <CAPjX3Fc4J=OnzrG9b8K=nbtLJjP38N_QFy6AQrxpEsv8bzvSnw@mail.gmail.com>
In-Reply-To: <CAPjX3Fc4J=OnzrG9b8K=nbtLJjP38N_QFy6AQrxpEsv8bzvSnw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 22 Mar 2025 20:40:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6oCfDv8MQ5tBQovS319BF20z-7+qsXTteOC+5Hf34ZAw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq2_1yDnxywvk39w0oIV4Kgsv27YHuXeVG1NU-NVXua63y1BaREfjxkGBU
Message-ID: <CAL3q7H6oCfDv8MQ5tBQovS319BF20z-7+qsXTteOC+5Hf34ZAw@mail.gmail.com>
Subject: Re: [PATCH] generic: test fsync of file with no more hard links
To: Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 11:22=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Fri, 21 Mar 2025 at 12:10, <fdmanana@kernel.org> wrote:
> >
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
> > +       if [ ! -z $XFS_IO_PID ]; then
> > +               kill $XFS_IO_PID > /dev/null 2>&1
> > +               wait $XFS_IO_PID > /dev/null 2>&1
> > +       fi
> > +       _cleanup_flakey
> > +       cd /
> > +       rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/dmflakey
> > +
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +       "btrfs: fix fsync of files with no hard links not persisting de=
letion"
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
>
> After creating the pipe you can "exec 3<>$SCRATCH_MNT/fifo" (and
> eventually unlink) ...

Yes, I'm aware of exec.
Have used it in other tests written years ago, like btrfs/168,
btrfs/233, and others.

>
> > +
> > +tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.fu=
ll &
>
> ... and then simply "$XFS_IO_PROG $SCRATCH_MNT/foo <&3 >>$seqres.full &"

That's arguably more cryptic and not so easy to read.

The approach I chose was exactly due to being a lot simpler to read
and less cryptic.

The goal is to make the test as easy to read as possible, and not to
show off technical skills with bash.

>
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
>
> No need for the quotes. But won't hurt either if that's more readable for=
 you.

Yes, I'm aware they're not needed. I like to use them however, for the
syntax highlighting I get with my editor.

>
> Moreover with the above you can also "echo fsync >&3".

Yes.
Again, I prefer the much more straightforward to read approach of
explicitly redirecting to the fifo.

Thanks.

>
> > +
> > +# Terminate the xfs_io process so that we can unmount.
> > +echo "quit" > $SCRATCH_MNT/fifo
>
> ...
>
> > +wait $XFS_IO_PID
> > +unset XFS_IO_PID
> > +
> > +# Simulate a power failure and then mount again the filesystem to repl=
ay the
> > +# journal/log.
> > +_flakey_drop_and_remount
> > +
> > +# We don't expect the file to exist anymore, since it was fsynced when=
 it had no
> > +# more hard links.
> > +[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> > +
> > +_unmount_flakey
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/764.out b/tests/generic/764.out
> > new file mode 100644
> > index 00000000..bb58e5b8
> > --- /dev/null
> > +++ b/tests/generic/764.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 764
> > +Silence is golden
> > --
> > 2.45.2
> >
> >

