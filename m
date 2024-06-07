Return-Path: <linux-btrfs+bounces-5527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2299900069
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7331F21E14
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C715B986;
	Fri,  7 Jun 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJqO0VVZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B22B2CF;
	Fri,  7 Jun 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755133; cv=none; b=hVJpEL06xmh7M9yH8E/DQPbm2Ur5w3IFAo0btaO4+oaTG3do7SZqLsd2H1OFq5z6z8cmwD6ZDJgOMsAmFEBWJYEAHoJf0Z5x5X9VBq6x3BWm2zuVqzP31T57Gx3fm05zolENOCvgFJT1RP6FpI0IqwVnyPaa0r6l3aeD/m+JY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755133; c=relaxed/simple;
	bh=CxSUEgQgn+3VB/fmy/+SlHOso09Cmp4a0GjhfE2CyMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm49epKiSxfdMvZIFR60VAiSIisqPMtax7JjxYmWH+OImecGw2aSGVQ1da0kw6F3SjfqW+lC4RK0jK5zu+PhAbZpdafQ87WWuAa7ZIXsO16oJNzb6I0EkwbSpY+4XpVGWidiST8As4/4MlQ68BTzyo9L7oNx56hI8VN2Fb8Wa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJqO0VVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216C5C4AF08;
	Fri,  7 Jun 2024 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755133;
	bh=CxSUEgQgn+3VB/fmy/+SlHOso09Cmp4a0GjhfE2CyMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MJqO0VVZCKaw+XVWgLOifjPkas4lOd0OkD+pl6Uctls4L6SrlQ8Ro1YPeYD6YbcU+
	 XchHz4nCam9S+Dg3Y2nEETrQQc2G16LfwQ7L3YiU8XZ02d3qLXAMeriAua8gAI6nh8
	 xuVsLwq+0HVS/Pbuj7LKEBZ1wK0z0an1U0e82OWv5k7Rty6pW5fhcWSpH3irJB3bjw
	 dCCU10s4WJy+6H4Efom2osSl7DibfhVNwUKyJROA8j8LGv3fzpptjoydG4sKox4frr
	 hWEqEW3q/nW/99EYN2WJEHN+gkUJuCVRHjU/1yj00fr/9Dfx32eGjHXr4FrM/apd5t
	 4hVKNJEDyjQTA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so181342766b.3;
        Fri, 07 Jun 2024 03:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX1rUYyM1C2Ebzm4v9s4H/ty+wapRilcvZLjc0bHZnuDrsUhmZFbehFWUP8OxzoKiCPz/JtAFWU04JbZIJlS9l43gF9nGVWFLZJLgsbg3FtFHWGuAE/y867s0n5mSjrOGgXAdj
X-Gm-Message-State: AOJu0Yyp28X6dxJhMhToG6T1b+ulXtJ1QbCVssAJlB7735xxO7/J6t6V
	V/PLP34Fvd1uvD9QFo4Szq1YV/Xy0Fxh3C00VDWI1VTWGROtswZ9hfeJjTedwN/GudVXTdPQ4v0
	0Z5uHJm4DBmnu7km5bOijCU+kle0=
X-Google-Smtp-Source: AGHT+IEaSS9aEZiPBAmex3Sd1fgzp5NafIqXsZbmdhVuSm+KimifNupX6bmwuCAlcILS6Yr7TA6H0EhWJxWvQVK+8vU=
X-Received: by 2002:a17:906:3c54:b0:a66:4b54:9c87 with SMTP id
 a640c23a62f3a-a6cdb9d66edmr187175166b.76.1717755131623; Fri, 07 Jun 2024
 03:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
 <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com> <20240607100422.w7k7spmyg7s6xfv4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240607100422.w7k7spmyg7s6xfv4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Jun 2024 11:11:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Un3j+BbqHc82D68R3rwmT6Y0XfpOadWxdV=DbSN-hmQ@mail.gmail.com>
Message-ID: <CAL3q7H6Un3j+BbqHc82D68R3rwmT6Y0XfpOadWxdV=DbSN-hmQ@mail.gmail.com>
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
To: Zorro Lang <zlang@redhat.com>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	David Disseldorp <ddiss@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 11:04=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Jun 07, 2024 at 10:43:47AM +0100, Filipe Manana wrote:
> > On Fri, Jun 7, 2024 at 6:12=E2=80=AFAM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> > > > On Fri, May 24, 2024 at 9:58=E2=80=AFPM Omar Sandoval <osandov@osan=
dov.com> wrote:
> > > > >
> > > > > From: Omar Sandoval <osandov@fb.com>
> > > > >
> > > > > This is a regression test for a Btrfs bug, but there's nothing
> > > > > Btrfs-specific about it. Since it's a race, we just try to make t=
he race
> > > > > happen in a loop and pass if it doesn't crash after all of our at=
tempts.
> > > > >
> > > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > > ---
> > > > > Changes from v1 [1]:
> > > > >
> > > > > - Added missing groups and requires.
> > > > > - Simplified $XFS_IO_PROG calls.
> > > > > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> > > > >   reliably.
> > > > > - Removed all of the file creation and dump-tree parsing since th=
e only
> > > > >   file on a fresh filesystem is guaranteed to be at the end of a =
leaf
> > > > >   anyways.
> > > > > - Rewrote to be a generic test.
> > > > >
> > > > > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd3=
22b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> > > > >
> > > > >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  tests/generic/745.out |  2 ++
> > > > >  2 files changed, 46 insertions(+)
> > > > >  create mode 100755 tests/generic/745
> > > > >  create mode 100644 tests/generic/745.out
> > > > >
> > > > > diff --git a/tests/generic/745 b/tests/generic/745
> > > > > new file mode 100755
> > > > > index 00000000..925adba9
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/745
> > > >
> > > > Btw, generic/745 already exists in the for-next branch (development=
 is
> > > > based against that branch nowadays).
> > > >
> > > > > @@ -0,0 +1,44 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > > > > +#
> > > > > +# FS QA Test 745
> > > > > +#
> > > > > +# Repeatedly prealloc beyond i_size, set an xattr, direct write =
into the
> > > > > +# prealloc while extending i_size, then fdatasync. This is a reg=
ression test
> > > > > +# for a Btrfs crash.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +. ./common/attr
> > > > > +_begin_fstest auto quick log preallocrw dangerous
> > > > > +
> > > > > +_supported_fs generic
> > > > > +_require_scratch
> > > > > +_require_attrs
> > > > > +_require_xfs_io_command falloc -k
> > > >
> > > > Since this is now a generic test and we're using direct IO, also:
> > > >
> > > > _require_odirect
> > > >
> > > > > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > > > > +       "btrfs: fix crash on racing fsync and size-extending writ=
e into prealloc"
> > > >
> > > > Because it's now a generic test, it should be:
> > > >
> > > > [ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit ....
> > > >
> > > > Otherwise it looks good to me, so with that:
> > > >
> > > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > >
> > > Thanks Filipe, merged this patch with above review points, more detai=
ls refer to
> > > "patches-in-queue" branch. Feel free to have more review points befor=
e I push
> > > to for-next :)
> >
> > Btw, there's a v3 with all that addressed:
> >
> > https://lore.kernel.org/fstests/8c91247dd109bb94e8df36f2812274b5de2a718=
3.1716916346.git.osandov@osandov.com/
> >
> > Also, looking at patches-in-queue, the test was added twice, once as
> > generic/748 and once as generic/749, in two different commits.
>
> Oh, I've merged this test case last week... sorry I forgot that. I'll kee=
p
> the g/748, and remove the g/749.
>
> >
> > Also, unrelated, but this commit:
> >
> > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dpatc=
hes-in-queue&id=3Db4c4ba99435aa7fd4f8a6e3c02938e357e137ec9
> >
> > As a Signed-off-by tag for David Disseldorp instead of Reviewed-by.
>
> Oh, this Signed-off-by tag is generated automatically by:
>
> https://lore.kernel.org/fstests/c9e54af5-4370-4d45-a8ed-4098b06b2629@suse=
.com/T/#m8fc24d233b2cf3a323c94c2b8039c0f043e09023
>
> if it's a mistake, I'll change it to Reviewed-by:

That I didn't notice, odd that David replied with Signed-off-by and
not Reviewed-by.
(cc'ing him)

Thanks.

>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >
> > > > Thanks.
> > > >
> > > > > +
> > > > > +# -i slows down xfs_io startup and makes the race much less reli=
able.
> > > > > +export XFS_IO_PROG=3D"$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > > > > +
> > > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > > > +_scratch_mount
> > > > > +
> > > > > +blksz=3D$(_get_block_size "$SCRATCH_MNT")
> > > > > +
> > > > > +# On Btrfs, since this is the only file on the filesystem, its m=
etadata is at
> > > > > +# the end of a B-tree leaf. We want an ordered extent completion=
 to add an
> > > > > +# extent item at the end of the leaf while we're logging preallo=
c extents
> > > > > +# beyond i_size after an xattr was set.
> > > > > +for ((i =3D 0; i < 5000; i++)); do
> > > > > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwr=
ite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> > > > > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > > > > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH=
_MNT/file"
> > > > > +done
> > > > > +
> > > > > +# If it didn't crash, we're good.
> > > > > +
> > > > > +echo "Silence is golden"
> > > > > +status=3D0
> > > > > +exit
> > > > > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > > > > new file mode 100644
> > > > > index 00000000..fce6b7f5
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/745.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 745
> > > > > +Silence is golden
> > > > > --
> > > > > 2.45.1
> > > > >
> > > > >
> > > >
> > >
> >
>

