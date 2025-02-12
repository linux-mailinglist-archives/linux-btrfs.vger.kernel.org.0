Return-Path: <linux-btrfs+bounces-11399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B318A325F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91B9168C94
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2B20C49F;
	Wed, 12 Feb 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO4vA6hg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF41F866A;
	Wed, 12 Feb 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363946; cv=none; b=lKmAn7Fvh6pyAsx4AM3QqgqdF8PaoF6lNuTKJLKd2+//AXMZzR26N3QY/2xFUqSXJdUTAgD8AUTffdKFBy2362ae9nN8MZJAOwpRQ3SjJ8Le/fJP7JGUwmrbHSxpK+JpL4i8Dxp7+OMCSTZHuWTCkVXvsducTflhIKhfkw6Ydtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363946; c=relaxed/simple;
	bh=TMH03mVO1LgGQpSvz+fm9X8QqEKkfc2wd7NWu3F77pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j99SigCg3UT27D9QUTosz+rh0m2RyVe+MqxiC0tAQFihVLa0Td6ycUYB8ZXp0gdWLWqZS5HC7HyXsHAokKtui/RzFRgBt8DPlX2qOLcS3RmVSbfwgv3C05IUFzwihtKSYBIjk+neIeGIx2HemWxLQcgUlyVuZ9gJI0EelH17Big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO4vA6hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37E1C4CEE6;
	Wed, 12 Feb 2025 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739363945;
	bh=TMH03mVO1LgGQpSvz+fm9X8QqEKkfc2wd7NWu3F77pU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QO4vA6hgVyQ2Og7oRqO1gnNT3MVwz1pMhDE+09c9hlCJBvRRNqYebfiJ6yaKP4e8c
	 h1MpP9M2JErtqU1BYWjc5lakA7VTv//1e055QQfXaySVCbjHP0L3L07TEBUJg63Fx6
	 GR2BFwB6osaz2jIDBVYrfCdCYh+7n44ywJf32V0cZ4pXrkFyUaWuFMT+GD0M3gpFNS
	 zDQPhcQWZZdXMlrpeJl9eIa9jaEokuz7sOEh6XLFgeogu7U9uQwlozxpTQPVzNs29+
	 rH4C2b6suE7gKU/s2Ng+iTu7LsCx8+hPQFnpkR4KbnOvyHPLEvGnfnvBBqZHjyE5Gf
	 bacaNj5qF4tiw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so9110004a12.3;
        Wed, 12 Feb 2025 04:39:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU21PatjOJ8Z2quK8CBxDty0Qja/KyxhICR/ZjgGAv5S/5pk/idrc0uLiI3rGBqUAaazlq4prtn/1pNQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9pbsbWIsbOZ3simMe+NMbUD9wDaSIziUuBPDJdxvennkZQvN
	X11VdpgtC5NtvMTAB0+kkblPJS+pW6y49k2BAglp6b7JUwbvlX2n1WfKWKtc95pl68eUUW3mySV
	hZrWeCsxqPZAJS4WDfoScgp4EF9w=
X-Google-Smtp-Source: AGHT+IEoMowSXjK8cIUTFa565FORpkSPMe6g6hsZFrILpO0R0tdSJf9fqM9k4Qy25y1fMvk6RovoF99A5uw1nSUT5A4=
X-Received: by 2002:a17:907:3fa7:b0:ab7:f221:f7a0 with SMTP id
 a640c23a62f3a-ab7f3473737mr251670266b.46.1739363944197; Wed, 12 Feb 2025
 04:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <20250212015310.ifnjdxj53jbsy2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250212015310.ifnjdxj53jbsy2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 12 Feb 2025 12:38:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6wzKJCBR0qbGsTEiCH1PV977+XLC+Atr4kMfhd5nXAVQ@mail.gmail.com>
X-Gm-Features: AWEUYZn4NNHeEmExHPAWTPd8IXqnSPmfC3oVw_lpfHRMkwVUF-Fsz9haoM0rLcM
Message-ID: <CAL3q7H6wzKJCBR0qbGsTEiCH1PV977+XLC+Atr4kMfhd5nXAVQ@mail.gmail.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:53=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > It's odd when a test fails on a filesystem and a specific fix is sugges=
ted
> > for another filesystem. Some generic tests are suggesting filesystem
> > specific fixes without checking if the running filesystem matches, so
> > update them.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/365 | 10 ++++++----
> >  tests/generic/366 |  2 +-
> >  tests/generic/367 |  2 +-
> >  tests/generic/623 |  2 +-
> >  tests/generic/631 |  2 +-
> >  tests/generic/646 |  2 +-
> >  tests/generic/649 |  2 +-
> >  tests/generic/695 |  2 +-
> >  tests/generic/700 |  4 ++--
> >  tests/generic/701 |  2 +-
> >  tests/generic/702 |  2 +-
> >  tests/generic/704 |  4 +++-
> >  tests/generic/707 |  4 ++--
> >  13 files changed, 22 insertions(+), 18 deletions(-)
> >
> > diff --git a/tests/generic/365 b/tests/generic/365
> > index 1f6a618a..1bca848a 100755
> > --- a/tests/generic/365
> > +++ b/tests/generic/365
> > @@ -9,10 +9,12 @@
> >  . ./common/preamble
> >  _begin_fstest auto rmap fsmap
> >
> > -_fixed_by_kernel_commit 68415b349f3f \
> > -     "xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > -_fixed_by_kernel_commit ca6448aed4f1 \
> > -     "xfs: Fix missing interval for missing_owner in xfs fsmap"
> > +if [ "$FSTYP" =3D "xfs" ]; then
> > +     _fixed_by_kernel_commit 68415b349f3f \
> > +             "xfs: Fix the owner setting issue for rmap query in xfs f=
smap"
> > +     _fixed_by_kernel_commit ca6448aed4f1 \
> > +             "xfs: Fix missing interval for missing_owner in xfs fsmap=
"
> > +fi
> >
> >  . ./common/filter
> >
> > diff --git a/tests/generic/366 b/tests/generic/366
> > index b322bcca..b2c2e607 100755
> > --- a/tests/generic/366
> > +++ b/tests/generic/366
> > @@ -23,7 +23,7 @@ _require_scratch
> >  _require_odirect 512 # see fio job1 config below
> >  _require_aio
> >
> > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> >       "btrfs: avoid deadlock when reading a partial uptodate folio"
> >
> >  iterations=3D$((32 * LOAD_FACTOR))
> > diff --git a/tests/generic/367 b/tests/generic/367
> > index 7cf90695..ed371a02 100755
> > --- a/tests/generic/367
> > +++ b/tests/generic/367
> > @@ -17,7 +17,7 @@
> >
> >  _begin_fstest ioctl quick
> >
> > -_fixed_by_kernel_commit 2a492ff66673 \
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
> >       "xfs: Check for delayed allocations before setting extsize"
> >
> >  _require_scratch_extsize
> > diff --git a/tests/generic/623 b/tests/generic/623
> > index 6487ccb8..9f41b5cc 100755
> > --- a/tests/generic/623
> > +++ b/tests/generic/623
> > @@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown
> >
> >  . ./common/filter
> >
> > -_fixed_by_kernel_commit e4826691cc7e \
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit e4826691cc7e \
> >       "xfs: restore shutdown check in mapped write fault path"
> >
> >  _require_scratch_nocheck
> > diff --git a/tests/generic/631 b/tests/generic/631
> > index 8e2cf9c6..c38ab771 100755
> > --- a/tests/generic/631
> > +++ b/tests/generic/631
> > @@ -41,7 +41,7 @@ _require_attrs trusted
> >  _exclude_fs overlay
> >  _require_extra_fs overlay
> >
> > -_fixed_by_kernel_commit 6da1b4b1ab36 \
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
> >       "xfs: fix an ABBA deadlock in xfs_rename"
> >
> >  _scratch_mkfs >> $seqres.full
> > diff --git a/tests/generic/646 b/tests/generic/646
> > index dc73aeb3..b3b0ab0a 100755
> > --- a/tests/generic/646
> > +++ b/tests/generic/646
> > @@ -14,7 +14,7 @@
> >  . ./common/preamble
> >  _begin_fstest auto quick recoveryloop shutdown
> >
> > -_fixed_by_kernel_commit 50d25484bebe \
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 50d25484bebe \
> >       "xfs: sync lazy sb accounting on quiesce of read-only mounts"
> >
> >  _require_scratch
> > diff --git a/tests/generic/649 b/tests/generic/649
> > index a33b13ea..58ef96a8 100755
> > --- a/tests/generic/649
> > +++ b/tests/generic/649
> > @@ -31,7 +31,7 @@ _cleanup()
> >
> >
> >  # Modify as appropriate.
> > -_fixed_by_kernel_commit 72a048c1056a \
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 72a048c1056a \
> >       "xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
> >
> >  _require_cp_reflink
> > diff --git a/tests/generic/695 b/tests/generic/695
> > index df81fdb7..694f4245 100755
> > --- a/tests/generic/695
> > +++ b/tests/generic/695
> > @@ -25,7 +25,7 @@ _cleanup()
> >  . ./common/dmflakey
> >  . ./common/punch
> >
> > -_fixed_by_kernel_commit e6e3dec6c3c288 \
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit e6e3dec6c3c288 \
> >          "btrfs: update generation of hole file extent item when mergin=
g holes"
> >  _require_scratch
> >  _require_dm_target flakey
> > diff --git a/tests/generic/700 b/tests/generic/700
> > index 052cfbd6..7f84df9d 100755
> > --- a/tests/generic/700
> > +++ b/tests/generic/700
> > @@ -19,8 +19,8 @@ _require_scratch
> >  _require_attrs
> >  _require_renameat2 whiteout
> >
> > -_fixed_by_kernel_commit 70b589a37e1a \
> > -     xfs: add selinux labels to whiteout inodes
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 70b589a37e1a \
> > +     "xfs: add selinux labels to whiteout inodes"
> >
> >  get_selinux_label()
> >  {
> > diff --git a/tests/generic/701 b/tests/generic/701
> > index 527bba34..806cc65d 100755
> > --- a/tests/generic/701
> > +++ b/tests/generic/701
> > @@ -22,7 +22,7 @@ _cleanup()
> >       rm -r -f $tmp.* $junk_dir
> >  }
> >
> > -_fixed_by_kernel_commit 92fba084b79e \
> > +[ "$FSTYP" =3D "exfat" ] && _fixed_by_kernel_commit 92fba084b79e \
> >       "exfat: fix i_blocks for files truncated over 4 GiB"
> >
> >  _require_test
> > diff --git a/tests/generic/702 b/tests/generic/702
> > index a506e07d..ae47eb27 100755
> > --- a/tests/generic/702
> > +++ b/tests/generic/702
> > @@ -14,7 +14,7 @@ _begin_fstest auto quick clone fiemap
> >  . ./common/filter
> >  . ./common/reflink
> >
> > -_fixed_by_kernel_commit ac3c0d36a2a2f7 \
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit ac3c0d36a2a2f7 \
> >       "btrfs: make fiemap more efficient and accurate reporting extent =
sharedness"
> >
> >  _require_scratch_reflink
> > diff --git a/tests/generic/704 b/tests/generic/704
> > index f452f9e9..f2360c42 100755
> > --- a/tests/generic/704
> > +++ b/tests/generic/704
> > @@ -21,7 +21,9 @@ _cleanup()
> >  # Import common functions.
> >  . ./common/scsi_debug
> >
> > -_fixed_by_kernel_commit 7c71ee78031c "xfs: allow logical-sector sized =
O_DIRECT"
> > +[ "$FSTYP" =3D "xfs" ] && _fixed_by_kernel_commit 7c71ee78031c \
> > +     "xfs: allow logical-sector sized O_DIRECT"
> > +
> >  _require_scsi_debug
> >  # If TEST_DEV is block device, make sure current fs is a localfs which=
 can be
> >  # written on scsi_debug device
> > diff --git a/tests/generic/707 b/tests/generic/707
> > index 3d8fac4b..23864038 100755
> > --- a/tests/generic/707
> > +++ b/tests/generic/707
> > @@ -13,9 +13,9 @@ _begin_fstest auto
> >
> >  _require_scratch
> >
> > -_fixed_by_kernel_commit f950fd052913 \
> > +[ "$FSTYP" =3D "udf" ] && _fixed_by_kernel_commit f950fd052913 \
> >       "udf: Protect rename against modification of moved directory"
> > -_fixed_by_kernel_commit 0813299c586b \
> > +[ "$FSTYP" =3D "ext4" ] && _fixed_by_kernel_commit 0813299c586b \
>
> I'm wondering if it's a "ext4 only" bug, or it might can be [[ "$FSTYP" =
=3D~ ext[0-9]+ ]] ?

Not sure either, but other generic test cases do that, so it's
probably best to do it like that.
Do you want a new patch version with that change or can you change it yours=
elf?

Thanks.

> Others looks good to me.
>
> Thanks,
> Zorro
>
> >       "ext4: Fix possible corruption when moving a directory"
> >
> >  _scratch_mkfs >>$seqres.full 2>&1
> > --
> > 2.45.2
> >
> >
>

