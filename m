Return-Path: <linux-btrfs+bounces-18336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FCC09F5B
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 21:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1F3B22F3
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F02FE58A;
	Sat, 25 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrWHVxEi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085852E1F01
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761421235; cv=none; b=hYGZoMjj5yGNIITIJUzpFaGSjFk7jB5RpymPdfUmsjg87K1LBjXdUmhEZyNeMI5KOFHtEwvxJpxIDv40n9HZO7oXqix3MUKcWuPsKqkG3SBl4k/q8dx7juK94yLVAmzhr64pFdSnL3MloUX9thJO9vHqHB8ssh5gkPsneBrFKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761421235; c=relaxed/simple;
	bh=d21JXLFTr0JMClT3cTO06af1EoTHek0okUpiXPBhI+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPuq1+AWNWIVpOa4vnnteyDHHrLDbz1ZOU6rb4wLSxiRdo4Wz0bj2ua0YCS76dKEwd7DwI1le4BB8qMveJb0P9JjZCkUR9P2EPvPGixlfQIer2HUnlVAmdLLl2YCGUWJXnPta5mEQVVy161dwU+6z2Ey9W1DAmG2XxDfoa0i57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrWHVxEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC23C4CEFF
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 19:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761421234;
	bh=d21JXLFTr0JMClT3cTO06af1EoTHek0okUpiXPBhI+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GrWHVxEiHXyGgbi2Ioc06Q999Xb7gyIQmluceu609tq8x/NmLKwSpCloqu1QuiFAE
	 17IPoNxOHkMrfqV+tmikyfEKj9/1vkxI5jc0yHi/394IndMXRZwKLWBfz53eKEVlmU
	 QLoEpgoAN+kLtdBRbJMgGqsXY+iLh94FzI5XsvOoFUUsmmHdYSGJSgjgdVvWWmDNI3
	 mTaafvl5PsapBta1c3AghPzW+CYRQlpsl0LbDxrq/gYllAw6Ed60BfnsxZTGg9MKQU
	 GtYnhWyeR6dp4Q6/cyrsAzG0NunVbA4uphUNADFHlzCtYIhHi91/uJG/Td+njTpBDW
	 rRAblp5ShjrvQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d6984a5baso432636266b.3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 12:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPsO/FsmUhzvj2GjSfuudqR9XAr/64T8E/0Z06wSWaOb3oIliLC7ZV/v4eElSXF0dhnC1pU4TuKmAI6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8Yxoftev/agk95lc1hGW4vHx409pOfxFbEbYhoF0FjBm6BVm
	DiPZvEt6+xlRsrpPdi4zCGWAUQS5NkD3fdu8LrC3ztJCHiCcK2pgWBKooGw4UzG61sUG7YzBR+H
	0B/1e10HnxtKMISQ+0YKbaeaoMPNdAak=
X-Google-Smtp-Source: AGHT+IHtN9EXE7QCzMp3RjoeIKxVjTGT5O86kAcBXbxKA5O3NiAEOx35I5hWMrgScmfXIW67vuo1BCSr8GXUAv5Ll+M=
X-Received: by 2002:a17:907:1b11:b0:b5c:66ce:bfe6 with SMTP id
 a640c23a62f3a-b6474b348bemr4201967866b.55.1761421233277; Sat, 25 Oct 2025
 12:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
 <bb46518c-9836-4bd2-8142-fbb8c859fd3f@suse.com>
In-Reply-To: <bb46518c-9836-4bd2-8142-fbb8c859fd3f@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 25 Oct 2025 20:39:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4bcqMZEu_QSQVETQWPzkBCSpi2cKEAbfcpHPcPG=Wc0A@mail.gmail.com>
X-Gm-Features: AWmQ_blbiKtZ0-YE6_W4fktYFfOqH-5U11f_yEyY-skoMLrNmCv53w8nSJ2niFI
Message-ID: <CAL3q7H4bcqMZEu_QSQVETQWPzkBCSpi2cKEAbfcpHPcPG=Wc0A@mail.gmail.com>
Subject: Re: [PATCH] generic: test fsync of directory after renaming new symlink
To: Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 11:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/24 22:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we fsync a directory that has a new symlink, then rename t=
he
> > symlink and fsync again the directory, after a power failure the symlin=
k
> > exists with the new name and not the old one.
> >
> > This is to exercise a bug in btrfs where we ended up not persisting the
> > new name of the symlink. That is fixed by a kernel patch that has the
> > following subject:
> >
> >   "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new n=
ame"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/generic/779     | 60 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/generic/779.out |  2 ++
> >   2 files changed, 62 insertions(+)
> >   create mode 100755 tests/generic/779
> >   create mode 100644 tests/generic/779.out
> >
> > diff --git a/tests/generic/779 b/tests/generic/779
> > new file mode 100755
> > index 00000000..40d1a86c
> > --- /dev/null
> > +++ b/tests/generic/779
> > @@ -0,0 +1,60 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> > +#
> > +# FS QA Test 779
> > +#
> > +# Test that if we fsync a directory that has a new symlink, then renam=
e the
> > +# symlink and fsync again the directory, after a power failure the sym=
link
> > +# exists with the new name and not the old one.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick log
> > +
> > +_cleanup()
> > +{
> > +     _cleanup_flakey
> > +     cd /
> > +     rm -r -f $tmp.*
> > +}
> > +
> > +. ./common/dmflakey
> > +
> > +_require_scratch
> > +_require_symlinks
> > +_require_dm_target flakey
> > +
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging n=
ew name"
> > +
> > +rm -f $seqres.full
>
> Looks like a rouge command?

It was copied from some other test.
A few tests have this, but it doesn't seem to be needed (anymore at least).

I'll let Zerro remove the line when he picks this.

>
>
> Otherwise looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_require_metadata_journaling $SCRATCH_DEV
> > +_init_flakey
> > +_mount_flakey
> > +
> > +# Create our test dir and add a symlink inside it.
> > +mkdir $SCRATCH_MNT/dir
> > +ln -s foobar $SCRATCH_MNT/dir/old-slink
> > +
> > +# Fsync the test dir, should persist the symlink.
> > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> > +
> > +# Rename the symlink and fsync the directory. It should persist the ne=
w symlink
> > +# name.
> > +mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
> > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> > +
> > +# Simulate a power failure and then mount again the filesystem to repl=
ay the
> > +# journal/log.
> > +_flakey_drop_and_remount
> > +
> > +# Check that the symlink exists with the new name and has the correct =
content.
> > +[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not f=
ound"
> > +echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
> > +
> > +_unmount_flakey
> > +
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/generic/779.out b/tests/generic/779.out
> > new file mode 100644
> > index 00000000..c595cd01
> > --- /dev/null
> > +++ b/tests/generic/779.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 779
> > +symlink content: foobar
>

