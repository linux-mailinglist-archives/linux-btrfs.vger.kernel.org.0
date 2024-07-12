Return-Path: <linux-btrfs+bounces-6428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98841930028
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8711C212C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B79176FCF;
	Fri, 12 Jul 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KzkZxtmG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nboes/n2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DD176246;
	Fri, 12 Jul 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807327; cv=none; b=Q7f2UTn9OHJF/eSTsnLq9hN07xJjDQU3QpAho5X3pOSQIIy99vCNN67sDq/J3Mu0xOLLjROudk7gaNLNdDa+hIlB2VuXjFOwyBDwwSLKWbMUzXrkrhmOpVdI4BPd/1dnGtIJ1qMNvSxb2nydEDC3LWjFiPrwg21Slxe8QVpwKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807327; c=relaxed/simple;
	bh=h3OhtSmmmGVfmthuVfVVQ8TgaGZB1hVyhKDiozXoSNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSGlxiEt2h0Ec8trN8BelgBTGM9CG67QOyoU6FoyB9dRWvYsatLwFhBkAI8tePPOvsgca5sTAftRuvCllna3uwk9Key6XWTG4zw+SeF5gMIHHCsxkpcP/IoPc5Hm5GD4TvifiPUs7PTKWcwpec1d6Qfvlk3ngYrQWdXPEYC7KWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KzkZxtmG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nboes/n2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 645CF11403A5;
	Fri, 12 Jul 2024 14:02:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Jul 2024 14:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1720807324;
	 x=1720893724; bh=QGlTzYjpWRtKlvstgeoki7lNE0Yo6izVbbg/ZxC7nsk=; b=
	KzkZxtmG2HzBcLn1oGyu6o9c9UBx2U/JMm/JDlPNncTOEGaicLi/0+xDgSu73FN4
	BubLQNhH4ZshYhVsCrpL4S8PC0hq5sjkxMJzm6AOF0BMBdJe4kBa5RgAuCa6R+fl
	fJYCSi2Po3X9LrFwNVy4VphCac9DqHXqEv/xH/ynHW3u3Q51B1DshX5GPN3xW0FW
	ouWe6bH8An5TfGNoGoKklZ1L/xkXWU8OG4GsohBjtMiZobs1BNkrHn4lB8K/GqJ2
	sE9QX9Grj4inlUtY0GnsFHprgkzslhC/FV2QhDpdjHh+6JidxfMfNF6B1ZZ6F+I8
	eCjuoZRtI33Gn4SKazi+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720807324; x=
	1720893724; bh=QGlTzYjpWRtKlvstgeoki7lNE0Yo6izVbbg/ZxC7nsk=; b=N
	boes/n23tiBWSptx7I4XfRLRSpztBcBub8vugCVFigMQ0sZqVPIPtjyLeVi0ZN9T
	iZbRGWIOknkA7KoFLoovDp2QIjTftJggPhqkvoVopL/DVryPLjUZJjmjY2Q4EG6s
	7wwf60EqPyIf2FUDukKHHCz5ikGKGkGOpHT7XBJbBEY/P1VAe2CxXOH+hOLRnpP/
	ZJlNx4ifYAoWDxPy7o3F2g/Y1qt6OWTm1Ip1jwdZCVDsabVpdZqQJb4fLJqjPD91
	HhSBu/IHUGlifQtsHOVPZM0Zb3HOH/Z9S9pAMrBbX4BHb9qjGAhPlmX0bn72zY1S
	KyRwNJIfOKen4HIN3YBlw==
X-ME-Sender: <xms:m2-RZgowHEPB5LdXvVDYSwc7XiIkmb0C3X2smccJaYjye8LmlZq0ow>
    <xme:m2-RZmqMVyPoyFgOlE5SF2PlCA6Jfp7dAjPOiTBp2wIAtu0d_ZwLaWsYiqglIRZwn
    ikcXYejNHXBK6cazAs>
X-ME-Received: <xmr:m2-RZlNdhgmOW-MPNM2BTl4MkCg8iEEp8vNXjiKT_J2A_GOixljQHlYvBBtoaLgZe7YSKW1Z0hfKgRla71tJl05W8FY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:m2-RZn66dQ0jmchuS0jeNR8xyo0h_gqBFau5w8etrGZuUy1nSrGfcA>
    <xmx:m2-RZv5fGe0e-YTyCGTBuQzynGkj2ZKZ5nP1fHlwtU_7c7_mNCVIIg>
    <xmx:m2-RZnivGgP-nNBf2ucMTz4xP0mAuMxcuOQJlbJ9GICOrKBWZjcYgA>
    <xmx:m2-RZp4XQJFWhfH_CacWZndAb9KKUdRPHFdNWxzjVVKLXDATX2dxBw>
    <xmx:nG-RZi28tWj_pCyhnoDVIVl3TZdVkOkDDL2E1h1ZI5Fe0mvE7Hpo97Ly>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 14:02:02 -0400 (EDT)
Date: Fri, 12 Jul 2024 11:01:06 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
Message-ID: <20240712180106.GA3472046@zen.localdomain>
References: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
 <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>
 <20240712172534.GA3471480@zen.localdomain>
 <CAL3q7H6Z7HE5EZ+1gLz5NRYbG2UR0N1Edn+j1Mqu3eu=X2tVwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Z7HE5EZ+1gLz5NRYbG2UR0N1Edn+j1Mqu3eu=X2tVwg@mail.gmail.com>

On Fri, Jul 12, 2024 at 06:33:59PM +0100, Filipe Manana wrote:
> On Fri, Jul 12, 2024 at 6:26 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Fri, Jul 12, 2024 at 05:56:15PM +0100, Filipe Manana wrote:
> > > On Fri, Jul 12, 2024 at 4:53 PM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > btrfstune supports enabling simple quotas on a fleshed out filesystem
> > > > (without adding owner refs) and clearing squotas entirely from a
> > > > filesystem that ran under squotas (clearing the incompat bit)
> > > >
> > > > Test that these operations work on a relatively complicated filesystem
> > > > populated by fsstress while preserving fssum.
> > > >
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/btrfs/332.out |  2 ++
> > > >  2 files changed, 71 insertions(+)
> > > >  create mode 100755 tests/btrfs/332
> > > >  create mode 100644 tests/btrfs/332.out
> > > >
> > > > diff --git a/tests/btrfs/332 b/tests/btrfs/332
> > > > new file mode 100755
> > > > index 000000000..d5cf32664
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/332
> > > > @@ -0,0 +1,69 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test No. btrfs/332
> > > > +#
> > > > +# Test tune enabling and removing squotas on a live filesystem
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick qgroup
> > > > +
> > > > +# Import common functions.
> > > > +. ./common/filter.btrfs
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs btrfs
> > > > +_require_scratch_enable_simple_quota
> > > > +_require_no_compress
> > > > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > > > +_require_fssum
> > > > +_require_btrfs_dump_super
> > > > +_require_btrfs_command inspect-internal dump-tree
> > > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> > > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-quota)"
> > > > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> > > > +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-quota)"
> > > > +
> > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > > +_scratch_mount
> > > > +
> > > > +# do some stuff
> > > > +d1=$SCRATCH_MNT/d1
> > > > +d2=$SCRATCH_MNT/d2
> > > > +mkdir $d1
> > > > +mkdir $d2
> > > > +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> > > > +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > +
> > > > +# enable squotas
> > > > +_scratch_unmount
> > > > +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
> > > > +       _fail "enable simple quota failed"
> > >
> > > Instead of doing a "|| _fail ..." everywhere, can't we simply not
> > > redirect stderr to the .full file and instead have a golden output
> > > mismatch in case an error happens?
> > > Not only that makes the test shorter and easier to read, it goes along
> > > with the most common practice in fstests.
> > >
> >
> > That's what I wanted to do, since you have given me that feedback in the
> > past, but unfortunately --enable-simple-quota currently spits out a line
> > for each qgroup it creates, which we can't predict in the output, since
> > I don't think the fsstress run is deterministic?
> 
> But are those messages printed to stderr?
> As they aren't errors, I would expect them to be sent to stdout only.
> 
> >
> > Options I considered where:
> > - grep -v or otherwise filter out those lines
> > - check the failure
> >
> > I am happy to switch to the grep.
> 
> If those non-error messages are sent to stderr, then I would say just
> leave the test as it is.

They get sent to stdout, and adjusting the code to just grep them out
came out well enough, so I resent that as v3.

We crossed streams a little here, so hopefully I did a reasonable enough
thing and the v3 looks good to you :)

Thanks for your time, and sorry for the churn on this simple stuff.

> 
> Thanks.
> 
> >
> > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > +_scratch_mount
> > > > +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > +[ "$fssum_pre" == "$fssum_post" ] \
> > > > +       || echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
> > > > +
> > > > +# do some more stuff
> > > > +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> > > > +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > +_scratch_unmount
> > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > +
> > > > +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
> > > > +       _fail "remove simple quota failed"
> > >
> > > Same here.
> > >
> > > With that fixed (if it can be done):
> >
> > I think here, the command does generally work how we want: silent on
> > success, spews on failure, but I wanted it to be consistent with the
> > enable, not have to look in different files (or stick in a tee) etc..
> >
> > I'll play around with it and re-send if the filtered version looks
> > better.
> >
> > >
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > >
> > > Thanks.
> > >
> > > > +_check_btrfs_filesystem $SCRATCH_DEV
> > > > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE_QUOTA'
> > > > +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUOTA' -e 'QGROUP'
> > > > +
> > > > +_scratch_mount
> > > > +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> > > > +_scratch_unmount
> > > > +[ "$fssum_pre" == "$fssum_post" ] \
> > > > +       || echo "fssum $fssum_pre does not match $fssum_post after disabling squota"
> > > > +
> > > > +echo Silence is golden
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> > > > new file mode 100644
> > > > index 000000000..adb316136
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/332.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 332
> > > > +Silence is golden
> > > > --
> > > > 2.45.2
> > > >
> > > >

