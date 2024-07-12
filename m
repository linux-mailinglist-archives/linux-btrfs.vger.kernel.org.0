Return-Path: <linux-btrfs+bounces-6429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB6930062
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C64D1C226A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E3178378;
	Fri, 12 Jul 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkyXuhoP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B87176FC5;
	Fri, 12 Jul 2024 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808063; cv=none; b=HPKzxPDfs/KMJoq9V/zdiQKphFSB33JS/7YW4GqScYDogFg6eV3fU6cywCrpbCn90CpW/8zhVbsMm2W6OSghBRe9SoLLT5kz6BZhpKfLIRABDSXTJxzQVulX036ALypwVgj1HG95Y/Nk6L84pG/PWgdIC+OzZcraAQS1/UdaNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808063; c=relaxed/simple;
	bh=higUfH+lRNr1o1/VeR3pllv4hyaBqtUag+nr8QJVj8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWQe6dBsbpAOSxgFFedELtzqS3VbRoPag4y6KtEVl38q3GxnfEKCCeou0Fn1MN2w3+7iViHQe92U76lf4NcO+5q/WU2RfEexCAGjD9jGsdDru4LnHn4D+M6V5+ftoPprwwH89RTZXv1Ft/S4D5g4DORW3osiCbLaU21CMEbhNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkyXuhoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94044C4AF09;
	Fri, 12 Jul 2024 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720808062;
	bh=higUfH+lRNr1o1/VeR3pllv4hyaBqtUag+nr8QJVj8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TkyXuhoPN3ZDYAFsAnHpxtJ0+441AD7yMavrVgt2NMAqGVQ1pmmTmU2qXht1gaFH/
	 vGI8faiIkaKIheH38sjks8BGGOc4uwiYLfN0xfR20JPP6nzn/BMZ3enW1SfyKd28Vc
	 BynZdi3p5lnT6Aj5yzzvEISeu2c51NQ/x65xsUhWP95ds1Kw7qTH2xLzeqPaBLL1LA
	 QIu7GsFYDsIbKHdp6uo9So70nsPM7ujnvxRlXW0ODWj06/DyvBBtT4vQ/t1xG8AHQl
	 kJVh+o4HmsEMQRXV4YNmGYxC/fKlqc/nOXlP1dntb2fKSYFqTrlOXDW0Hy9lX/LvaN
	 Ko2atFY8h6Chg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea5765e75so2735438e87.0;
        Fri, 12 Jul 2024 11:14:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2eDeBH6egnVDrsL66VvHA1P2k/0oCMafYqamuZX9UrepN2il28dZN8+eWyB34F+BrYnCrajklk5thntT1KxY04kMYSMXQuQ==
X-Gm-Message-State: AOJu0YxlgIrX2Bv29GcBSWZVHUSyZDRunjWv6MuC6xRP3Xq3b+ZmNtGC
	THxBpVQo7GUzzepyXY7ZqggnY3QtGjfv1OAJ+85Ardsx4QXBBb1VYbOqEQenF7pnPHorNkgDQtQ
	NwxTLps8vFtFWi21e7lTkCN3OFmM=
X-Google-Smtp-Source: AGHT+IFIahKHwEr3b763wKGnlHvz4LQOxpS+JnV2N7SAFE6iKoecjOR/CITKHDDEB5a9PzCKgRvIQuOZBV5tc3rS4zw=
X-Received: by 2002:a19:384d:0:b0:52c:825e:3b1c with SMTP id
 2adb3069b0e04-52eb9997b71mr6091745e87.26.1720808060875; Fri, 12 Jul 2024
 11:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
 <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>
 <20240712172534.GA3471480@zen.localdomain> <CAL3q7H6Z7HE5EZ+1gLz5NRYbG2UR0N1Edn+j1Mqu3eu=X2tVwg@mail.gmail.com>
 <20240712180106.GA3472046@zen.localdomain>
In-Reply-To: <20240712180106.GA3472046@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jul 2024 19:13:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6hZcP-Bx=UCEqgX3qjPhPB1DS0=CohxC339ys0D-vm6w@mail.gmail.com>
Message-ID: <CAL3q7H6hZcP-Bx=UCEqgX3qjPhPB1DS0=CohxC339ys0D-vm6w@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:02=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Jul 12, 2024 at 06:33:59PM +0100, Filipe Manana wrote:
> > On Fri, Jul 12, 2024 at 6:26=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > On Fri, Jul 12, 2024 at 05:56:15PM +0100, Filipe Manana wrote:
> > > > On Fri, Jul 12, 2024 at 4:53=E2=80=AFPM Boris Burkov <boris@bur.io>=
 wrote:
> > > > >
> > > > > btrfstune supports enabling simple quotas on a fleshed out filesy=
stem
> > > > > (without adding owner refs) and clearing squotas entirely from a
> > > > > filesystem that ran under squotas (clearing the incompat bit)
> > > > >
> > > > > Test that these operations work on a relatively complicated files=
ystem
> > > > > populated by fsstress while preserving fssum.
> > > > >
> > > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > > ---
> > > > >  tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  tests/btrfs/332.out |  2 ++
> > > > >  2 files changed, 71 insertions(+)
> > > > >  create mode 100755 tests/btrfs/332
> > > > >  create mode 100644 tests/btrfs/332.out
> > > > >
> > > > > diff --git a/tests/btrfs/332 b/tests/btrfs/332
> > > > > new file mode 100755
> > > > > index 000000000..d5cf32664
> > > > > --- /dev/null
> > > > > +++ b/tests/btrfs/332
> > > > > @@ -0,0 +1,69 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test No. btrfs/332
> > > > > +#
> > > > > +# Test tune enabling and removing squotas on a live filesystem
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick qgroup
> > > > > +
> > > > > +# Import common functions.
> > > > > +. ./common/filter.btrfs
> > > > > +
> > > > > +# real QA test starts here
> > > > > +_supported_fs btrfs
> > > > > +_require_scratch_enable_simple_quota
> > > > > +_require_no_compress
> > > > > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > > > > +_require_fssum
> > > > > +_require_btrfs_dump_super
> > > > > +_require_btrfs_command inspect-internal dump-tree
> > > > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quot=
a' || \
> > > > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-=
simple-quota)"
> > > > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quot=
a' || \
> > > > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-=
simple-quota)"
> > > > > +
> > > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > > > +_scratch_mount
> > > > > +
> > > > > +# do some stuff
> > > > > +d1=3D$SCRATCH_MNT/d1
> > > > > +d2=3D$SCRATCH_MNT/d2
> > > > > +mkdir $d1
> > > > > +mkdir $d2
> > > > > +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> > > > > +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > > +
> > > > > +# enable squotas
> > > > > +_scratch_unmount
> > > > > +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.f=
ull 2>&1 || \
> > > > > +       _fail "enable simple quota failed"
> > > >
> > > > Instead of doing a "|| _fail ..." everywhere, can't we simply not
> > > > redirect stderr to the .full file and instead have a golden output
> > > > mismatch in case an error happens?
> > > > Not only that makes the test shorter and easier to read, it goes al=
ong
> > > > with the most common practice in fstests.
> > > >
> > >
> > > That's what I wanted to do, since you have given me that feedback in =
the
> > > past, but unfortunately --enable-simple-quota currently spits out a l=
ine
> > > for each qgroup it creates, which we can't predict in the output, sin=
ce
> > > I don't think the fsstress run is deterministic?
> >
> > But are those messages printed to stderr?
> > As they aren't errors, I would expect them to be sent to stdout only.
> >
> > >
> > > Options I considered where:
> > > - grep -v or otherwise filter out those lines
> > > - check the failure
> > >
> > > I am happy to switch to the grep.
> >
> > If those non-error messages are sent to stderr, then I would say just
> > leave the test as it is.
>
> They get sent to stdout, and adjusting the code to just grep them out
> came out well enough, so I resent that as v3.

I see, my idea was simple, no need to grep or do anything.

Instead of :

$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full
2>&1 || _fail "enable simple quota failed"

Just doing:

$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full

So those informative messages would be ignored, and in case an error
happens, anything btrfstune prints to stderr makes the test
automatically fail due to mismatch with the golden output.

v3 does instead:

$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV | grep -v 'created
qgroup for'


>
> We crossed streams a little here, so hopefully I did a reasonable enough
> thing and the v3 looks good to you :)
>
> Thanks for your time, and sorry for the churn on this simple stuff.

No worries, thank you.

>
> >
> > Thanks.
> >
> > >
> > > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > > +_scratch_mount
> > > > > +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > > +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> > > > > +       || echo "fssum $fssum_pre does not match $fssum_post afte=
r enabling squota"
> > > > > +
> > > > > +# do some more stuff
> > > > > +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> > > > > +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > > +_scratch_unmount
> > > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > > +
> > > > > +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.f=
ull 2>&1 || \
> > > > > +       _fail "remove simple quota failed"
> > > >
> > > > Same here.
> > > >
> > > > With that fixed (if it can be done):
> > >
> > > I think here, the command does generally work how we want: silent on
> > > success, spews on failure, but I wanted it to be consistent with the
> > > enable, not have to look in different files (or stick in a tee) etc..
> > >
> > > I'll play around with it and re-send if the filtered version looks
> > > better.
> > >
> > > >
> > > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Thanks.
> > > >
> > > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep=
 'SIMPLE_QUOTA'
> > > > > +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep=
 -e 'QUOTA' -e 'QGROUP'
> > > > > +
> > > > > +_scratch_mount
> > > > > +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > > +_scratch_unmount
> > > > > +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> > > > > +       || echo "fssum $fssum_pre does not match $fssum_post afte=
r disabling squota"
> > > > > +
> > > > > +echo Silence is golden
> > > > > +status=3D0
> > > > > +exit
> > > > > diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> > > > > new file mode 100644
> > > > > index 000000000..adb316136
> > > > > --- /dev/null
> > > > > +++ b/tests/btrfs/332.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 332
> > > > > +Silence is golden
> > > > > --
> > > > > 2.45.2
> > > > >
> > > > >

