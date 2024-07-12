Return-Path: <linux-btrfs+bounces-6426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E875992FFD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B911F230E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7F176ABE;
	Fri, 12 Jul 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkPBB6jL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E614369A;
	Fri, 12 Jul 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805679; cv=none; b=lwaMwAuu5bHq0Hlz6X5yEtjXCzBjEZStIkot4MYhurZNvNQkKS6/fdopQcbTXemPlo/WHy7Q4bDFBoEzSCmv9khWqvao6dUMiiFZURmU3vTTQoUDgt0ECN78m+5t7jHD7v4Um2OYVpmw6mLyGbgKilEnJjoeaVYELbnOH7TmmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805679; c=relaxed/simple;
	bh=gyONCdf5vzuI1BlAcX9QXmMPq/67/FqQm+9GPII2cto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDENK6wPyzRmpAh13ylZdFb4EnmiB7qfih7riVqWEe9bMfdeC4xpU2+LVcT1/PVw01JK7KMsL7VcB3Q8oCI8qWeyxnVk7EN1ZXsGMhTRFAJNeRhPUD4mGeMI5U0E2vsnEKTRZnnWsLFuumTIEbn4/7vPa9xgdfUba4Tx9Dzlr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkPBB6jL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F77EC4AF09;
	Fri, 12 Jul 2024 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720805678;
	bh=gyONCdf5vzuI1BlAcX9QXmMPq/67/FqQm+9GPII2cto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JkPBB6jLPgBuEITm4AZuyN/JpTsE6vTkRsnSQ/2UDhd/iYeO2gSZpNf3NJ5VHuJ+x
	 1A67zSZC3JK2Mut4M+MmXhKpbg02HZG+3ekk0JjXZ1N84gAiHo7aR12KcLvEzZhnlj
	 BGdDgECYlEBtR+cAxn0z9xpsm5dRSP+sSKUOBcj/UzaeIwniZUqepNJC//ml/03R63
	 MBPRHyQekaDn5iShruPxBvPL8gux7vay5reN9kKyqNAEMUY/Q2X8ClwADVG5Ch+gRH
	 Upuau0RsR9r41REjObdxk+IXukrjqg0vl3sqr7bUzlmdQ2hDQBKkwewOJ9aE6UEBJu
	 R0YatXw7Mk3SA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso2845615e87.2;
        Fri, 12 Jul 2024 10:34:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVirb+0fmIw/oQ+W1f1T/dNjzpNXvifY1CnuWqh3IW5NVoShKTlniI7oby3Un9V321wiiZMn4otKP2EoYng+6TmzAECQLmTSA==
X-Gm-Message-State: AOJu0YyiKXr46E49KMjyjiMceDdaFPrwFY+K07rYnj08neNwiHpEZKlp
	q5kwYNL1DtLxbZ5zlTHF2ZpeOSt7Gd6OGRpTO97h2hAr3v7B2k5ENNKkauIif7wyYlpomZD06Uc
	RG/KnKUELSLwSfArUWtTpqXDZcAw=
X-Google-Smtp-Source: AGHT+IHdW07Fpb42pzHN5x11mJ4IdMNC7kR481GUMbMMtEbieJQw4mrVBnkaHOhj8Kn1NvzHW+0HfbpWghCSqYOawA4=
X-Received: by 2002:a05:6512:2003:b0:52e:9f17:841a with SMTP id
 2adb3069b0e04-52eb9991323mr5728868e87.6.1720805676676; Fri, 12 Jul 2024
 10:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
 <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com> <20240712172534.GA3471480@zen.localdomain>
In-Reply-To: <20240712172534.GA3471480@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jul 2024 18:33:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Z7HE5EZ+1gLz5NRYbG2UR0N1Edn+j1Mqu3eu=X2tVwg@mail.gmail.com>
Message-ID: <CAL3q7H6Z7HE5EZ+1gLz5NRYbG2UR0N1Edn+j1Mqu3eu=X2tVwg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:26=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Jul 12, 2024 at 05:56:15PM +0100, Filipe Manana wrote:
> > On Fri, Jul 12, 2024 at 4:53=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > btrfstune supports enabling simple quotas on a fleshed out filesystem
> > > (without adding owner refs) and clearing squotas entirely from a
> > > filesystem that ran under squotas (clearing the incompat bit)
> > >
> > > Test that these operations work on a relatively complicated filesyste=
m
> > > populated by fsstress while preserving fssum.
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/btrfs/332.out |  2 ++
> > >  2 files changed, 71 insertions(+)
> > >  create mode 100755 tests/btrfs/332
> > >  create mode 100644 tests/btrfs/332.out
> > >
> > > diff --git a/tests/btrfs/332 b/tests/btrfs/332
> > > new file mode 100755
> > > index 000000000..d5cf32664
> > > --- /dev/null
> > > +++ b/tests/btrfs/332
> > > @@ -0,0 +1,69 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. btrfs/332
> > > +#
> > > +# Test tune enabling and removing squotas on a live filesystem
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick qgroup
> > > +
> > > +# Import common functions.
> > > +. ./common/filter.btrfs
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_require_scratch_enable_simple_quota
> > > +_require_no_compress
> > > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > > +_require_fssum
> > > +_require_btrfs_dump_super
> > > +_require_btrfs_command inspect-internal dump-tree
> > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' |=
| \
> > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-simp=
le-quota)"
> > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' |=
| \
> > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-simp=
le-quota)"
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > +_scratch_mount
> > > +
> > > +# do some stuff
> > > +d1=3D$SCRATCH_MNT/d1
> > > +d2=3D$SCRATCH_MNT/d2
> > > +mkdir $d1
> > > +mkdir $d2
> > > +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> > > +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > +
> > > +# enable squotas
> > > +_scratch_unmount
> > > +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full =
2>&1 || \
> > > +       _fail "enable simple quota failed"
> >
> > Instead of doing a "|| _fail ..." everywhere, can't we simply not
> > redirect stderr to the .full file and instead have a golden output
> > mismatch in case an error happens?
> > Not only that makes the test shorter and easier to read, it goes along
> > with the most common practice in fstests.
> >
>
> That's what I wanted to do, since you have given me that feedback in the
> past, but unfortunately --enable-simple-quota currently spits out a line
> for each qgroup it creates, which we can't predict in the output, since
> I don't think the fsstress run is deterministic?

But are those messages printed to stderr?
As they aren't errors, I would expect them to be sent to stdout only.

>
> Options I considered where:
> - grep -v or otherwise filter out those lines
> - check the failure
>
> I am happy to switch to the grep.

If those non-error messages are sent to stderr, then I would say just
leave the test as it is.

Thanks.

>
> > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > +_scratch_mount
> > > +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> > > +       || echo "fssum $fssum_pre does not match $fssum_post after en=
abling squota"
> > > +
> > > +# do some more stuff
> > > +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> > > +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > +_scratch_unmount
> > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > +
> > > +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full =
2>&1 || \
> > > +       _fail "remove simple quota failed"
> >
> > Same here.
> >
> > With that fixed (if it can be done):
>
> I think here, the command does generally work how we want: silent on
> success, spews on failure, but I wanted it to be consistent with the
> enable, not have to look in different files (or stick in a tee) etc..
>
> I'll play around with it and re-send if the filtered version looks
> better.
>
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SI=
MPLE_QUOTA'
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e =
'QUOTA' -e 'QGROUP'
> > > +
> > > +_scratch_mount
> > > +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> > > +_scratch_unmount
> > > +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> > > +       || echo "fssum $fssum_pre does not match $fssum_post after di=
sabling squota"
> > > +
> > > +echo Silence is golden
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> > > new file mode 100644
> > > index 000000000..adb316136
> > > --- /dev/null
> > > +++ b/tests/btrfs/332.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 332
> > > +Silence is golden
> > > --
> > > 2.45.2
> > >
> > >

