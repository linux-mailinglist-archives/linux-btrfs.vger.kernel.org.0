Return-Path: <linux-btrfs+bounces-5525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD67A8FFFD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D391F27BD6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 09:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02915B995;
	Fri,  7 Jun 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl/kd4bz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111715B122;
	Fri,  7 Jun 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753467; cv=none; b=NpIfgmwBs+62IoyaaExUGhT72UE6cmhlLJC7vsnUYMmCgci4SRU5cJ9aXa9ZaA3R3FT9pQqzdP7Q690dKTMFYc8lTrWRWKTDETyCMf8jCKI09aJ/9r2JlC8mzQEbgrrJeso8qf7e3jQJ8pdswp1lvwkax3wWq8JQx28PMyJ5rY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753467; c=relaxed/simple;
	bh=/fRtzM/pn8HvE9fX07updROFVlMMmtopWHox+OO5Qx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJQ3+mb/Kp8jsE+zBE5qWFfmny7J1c8bvelN1jYxcshIT1+WYryj7/M9ZyNgevIWEeZSjAZis6dpoWVFJZg6/CbBpL7c0V8+ZHZXtprqKkM64F6CIYGV+LTTEIzkr6vVywbEYv+EBw7m1JZieJSDzjXRvQpgufGAy6xAVklcJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl/kd4bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5804C2BBFC;
	Fri,  7 Jun 2024 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717753466;
	bh=/fRtzM/pn8HvE9fX07updROFVlMMmtopWHox+OO5Qx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hl/kd4bz++rWh+kl6eX7ulwZWaAq6pnWnqpjuuz6ydgR9m6bi21tnjHeRj0MHXgSr
	 klNSllsj6Od3t8P15dH5y1tgVOX5OWppOCUREfgbB8z+u0Ibsy8WRldOWosKQcWIZW
	 Hj2K2CfsLysp+4CQYJAlZ30ZJTfLPT30eGVz1tCyjokv+bOuiqx9cR3bwF3z9g1UAK
	 1E2Ae4Ltiqxv0Xg7bR3udQZWHiyTquRUEU4JInRCvjRscxW0hoXA8NCqmBSXI+56Ij
	 dGtF4w0LZlrIxx5LdWlAUc68XTOcH7pS9uWYquHygsJr6jze8Hioxk2xeH4pxYs/DC
	 0a6UjcB403CDg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso37136766b.2;
        Fri, 07 Jun 2024 02:44:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy+7lwwCLd6Eo7gkgUWdR8hqrSzAweOlQGVdOR1/vfFbnqZ7vMH/6oG0TDTwuEi3/s2+IEnBKjQVnWsxYt3RpnHni1mA5bSytJdZ7ZMpbmVzVvM/Xx8VXz088lMoCla08M0ieI
X-Gm-Message-State: AOJu0YyiZ06RDcLBKxbBL9fhZ/HR1XxonB2uDt0gb7XuFjxSj6KUeRUS
	mfB3KIX9FkAfoO2NGNlCszI/m8+sI8WtC7RlsraGMRg3kFz2trUI6ERKrb2MdIDQHfEHjFcdU6B
	56O5klUSB84sWFuIKIvHn24jH9gs=
X-Google-Smtp-Source: AGHT+IER41il4AVGo4eqjHwIa0Rn5zuFLmXwErTicJnCreim7OWSDSw+qu7WhAAEiGzW2+HwQkIDKAa5uEC31AZbjwI=
X-Received: by 2002:a17:906:eb49:b0:a68:fafc:659 with SMTP id
 a640c23a62f3a-a6cd637e366mr121604166b.29.1717753465198; Fri, 07 Jun 2024
 02:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com> <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Jun 2024 10:43:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>
Message-ID: <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
To: Zorro Lang <zlang@redhat.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 6:12=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> > On Fri, May 24, 2024 at 9:58=E2=80=AFPM Omar Sandoval <osandov@osandov.=
com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > This is a regression test for a Btrfs bug, but there's nothing
> > > Btrfs-specific about it. Since it's a race, we just try to make the r=
ace
> > > happen in a loop and pass if it doesn't crash after all of our attemp=
ts.
> > >
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > > Changes from v1 [1]:
> > >
> > > - Added missing groups and requires.
> > > - Simplified $XFS_IO_PROG calls.
> > > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> > >   reliably.
> > > - Removed all of the file creation and dump-tree parsing since the on=
ly
> > >   file on a fresh filesystem is guaranteed to be at the end of a leaf
> > >   anyways.
> > > - Rewrote to be a generic test.
> > >
> > > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2=
cc0d0f392d.1716492850.git.osandov@osandov.com/
> > >
> > >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/generic/745.out |  2 ++
> > >  2 files changed, 46 insertions(+)
> > >  create mode 100755 tests/generic/745
> > >  create mode 100644 tests/generic/745.out
> > >
> > > diff --git a/tests/generic/745 b/tests/generic/745
> > > new file mode 100755
> > > index 00000000..925adba9
> > > --- /dev/null
> > > +++ b/tests/generic/745
> >
> > Btw, generic/745 already exists in the for-next branch (development is
> > based against that branch nowadays).
> >
> > > @@ -0,0 +1,44 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > > +#
> > > +# FS QA Test 745
> > > +#
> > > +# Repeatedly prealloc beyond i_size, set an xattr, direct write into=
 the
> > > +# prealloc while extending i_size, then fdatasync. This is a regress=
ion test
> > > +# for a Btrfs crash.
> > > +#
> > > +. ./common/preamble
> > > +. ./common/attr
> > > +_begin_fstest auto quick log preallocrw dangerous
> > > +
> > > +_supported_fs generic
> > > +_require_scratch
> > > +_require_attrs
> > > +_require_xfs_io_command falloc -k
> >
> > Since this is now a generic test and we're using direct IO, also:
> >
> > _require_odirect
> >
> > > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > > +       "btrfs: fix crash on racing fsync and size-extending write in=
to prealloc"
> >
> > Because it's now a generic test, it should be:
> >
> > [ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit ....
> >
> > Otherwise it looks good to me, so with that:
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks Filipe, merged this patch with above review points, more details r=
efer to
> "patches-in-queue" branch. Feel free to have more review points before I =
push
> to for-next :)

Btw, there's a v3 with all that addressed:

https://lore.kernel.org/fstests/8c91247dd109bb94e8df36f2812274b5de2a7183.17=
16916346.git.osandov@osandov.com/

Also, looking at patches-in-queue, the test was added twice, once as
generic/748 and once as generic/749, in two different commits.

Also, unrelated, but this commit:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dpatches-=
in-queue&id=3Db4c4ba99435aa7fd4f8a6e3c02938e357e137ec9

As a Signed-off-by tag for David Disseldorp instead of Reviewed-by.

Thanks.

>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> > > +
> > > +# -i slows down xfs_io startup and makes the race much less reliable=
.
> > > +export XFS_IO_PROG=3D"$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > +_scratch_mount
> > > +
> > > +blksz=3D$(_get_block_size "$SCRATCH_MNT")
> > > +
> > > +# On Btrfs, since this is the only file on the filesystem, its metad=
ata is at
> > > +# the end of a B-tree leaf. We want an ordered extent completion to =
add an
> > > +# extent item at the end of the leaf while we're logging prealloc ex=
tents
> > > +# beyond i_size after an xattr was set.
> > > +for ((i =3D 0; i < 5000; i++)); do
> > > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite =
-q -w 0 $blksz" "$SCRATCH_MNT/file"
> > > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT=
/file"
> > > +done
> > > +
> > > +# If it didn't crash, we're good.
> > > +
> > > +echo "Silence is golden"
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > > new file mode 100644
> > > index 00000000..fce6b7f5
> > > --- /dev/null
> > > +++ b/tests/generic/745.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 745
> > > +Silence is golden
> > > --
> > > 2.45.1
> > >
> > >
> >
>

