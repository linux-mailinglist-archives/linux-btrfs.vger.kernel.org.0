Return-Path: <linux-btrfs+bounces-6425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C292FFC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE801C216A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461DC174EFC;
	Fri, 12 Jul 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="brYmEClD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nv9boVmZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE51DFE4;
	Fri, 12 Jul 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720805195; cv=none; b=aNPXsrXK/5sHqwqN2C5zewsggj6+ZxIQK9J5Iuczi+11LX6oi8KFT3RnqHg+Tvn9fl2GK0DMKMD/v95+gtyQyDDOUY0OqpTucALOOptrj/2V7+A4NEtLDvBZraOq0yploOQ1XCJNhCyKdsF6Gy+R+57msffVSRYihLDcJS6+MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720805195; c=relaxed/simple;
	bh=CF2WLCy4uUC4pxwTPl/IJGKMPCXgDwPMn/53ZNWTK9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2WstdTikrhkeyIgoj/ZGbbK/TZtYH3NcxONoEWkgKCFpXq+83j5pxxllc3KGjVaYyCxprJgIBRHEmr2wQpKqYBtfEsJvpE5EzkZfR6vgbf56WWX3hGn0GxRb6wwZzKmVYWOr5qCbVE/mpzxGIcSeP0aHqeYMOsA60gT5sun8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=brYmEClD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nv9boVmZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C9A313819C5;
	Fri, 12 Jul 2024 13:26:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 12 Jul 2024 13:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1720805192;
	 x=1720891592; bh=tiMGIOoyhCE8rNZOLcULjx1fEvnqQNqGEKIhV6Ks9C8=; b=
	brYmEClDn6ZsULMksHd6jH3sXuixsbhJosyXvbmDZgvCDFeNfoZpCThCpJ1oVGh3
	v/5YFulcBRjXUMnU21mybEkL8eSSm6nai2k98hfvJ4fI+ZiUghALRd6YqybbRofq
	z/H+k8uO3WQdbrAvjXH6DkD62knUdmzsS6YIL9u6dnSdZz8b3o7V7EXKwiCYY5zo
	BpLKO7qhagTghdBn+sCLoriD5lH/DE1SxZleUnWqqV4IQlLE2e29zU7xQAXUUmGb
	au4ae4MFRyIHfl6AAzJFT0VH25LyXixqz0tNnTm7T9+81clEwrULuw9Pkw/PvmOO
	cVyAsoReVEf1uwdJWed4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720805192; x=
	1720891592; bh=tiMGIOoyhCE8rNZOLcULjx1fEvnqQNqGEKIhV6Ks9C8=; b=n
	v9boVmZOqyOJyxR9DF/uwVVepzgs+WGS3v9s8a0/vV8ayPPKI/GilzgVu38GLisG
	9KhR8mIw5tLWyaHj7Ivrt7JF09zyarsmoNkRc5Zo7JkAVbYCFVmAzfmESbpYkzbn
	Y83CX8fePiqeq7/s6Y23hQHijAEJjsTZM/IBsStcRSMVqtjyOGdcL+vyf7V+Okzd
	2lAGWs5RZEMomU6i9LqzHjwRtYrS7K1jBtGk8TRdzRpW9CQnJLN9FJwRM/tOvVKl
	tUgk4fQyxrXn7tXG6a2GE9uFB+SckKbxOzsIQeK6mQ7QnzdnOlEcOgoRwNFMPNoh
	yLpjsJT5CcxcxWtYlKITw==
X-ME-Sender: <xms:R2eRZkZB_y3YrDBrBbIAIFld7jwUtpUajtYvIXkfEvk6LPH4M5stgQ>
    <xme:R2eRZvbK0RKaPpyiAF3cQtWKc-ewTFkHNkyvTgF2snSMKvM6keILFOHJDPz3R021x
    lG0NI2bH1917uhGtDg>
X-ME-Received: <xmr:R2eRZu_G1OU-JA_nwKyVR7np-qSAf8dClWDgDhgPNCMqXL4BCRix44n0WKNirLFpPQsIuOZZS0skEBwx6vExEO9mKHI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:R2eRZurZivHYmcTVJV6_3QtWI5eTebaYa-VnbeBMT_-XaQWtrnrJWw>
    <xmx:R2eRZvrI4qOa5ppbzjoq0RNd0LJDP6n-Q8mDqRH18q6p6Iv7bT7q_Q>
    <xmx:R2eRZsTKfhvquwjifELsC7s1gFSxPtVLbRAwXV91MAkJTniXm8njdQ>
    <xmx:R2eRZvr-dfYCfEpOlL2OPd9hORqpF-jftTTHWkTHKxSLHoheJkKxgg>
    <xmx:SGeRZgmzpoPIClbyLn8fBilUpGBanzoCYALz4g1DJc6zzigvzytdSHT1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 13:26:31 -0400 (EDT)
Date: Fri, 12 Jul 2024 10:25:34 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add test for btrfstune squota enable/disable
Message-ID: <20240712172534.GA3471480@zen.localdomain>
References: <7339416633376271b21b1be844e1a34f8656f780.1720799383.git.boris@bur.io>
 <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6sDegx2d3336J70Nyri5oYSR6yn3KdZr+z1AqLMwaU4Q@mail.gmail.com>

On Fri, Jul 12, 2024 at 05:56:15PM +0100, Filipe Manana wrote:
> On Fri, Jul 12, 2024 at 4:53 PM Boris Burkov <boris@bur.io> wrote:
> >
> > btrfstune supports enabling simple quotas on a fleshed out filesystem
> > (without adding owner refs) and clearing squotas entirely from a
> > filesystem that ran under squotas (clearing the incompat bit)
> >
> > Test that these operations work on a relatively complicated filesystem
> > populated by fsstress while preserving fssum.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  tests/btrfs/332     | 69 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/332.out |  2 ++
> >  2 files changed, 71 insertions(+)
> >  create mode 100755 tests/btrfs/332
> >  create mode 100644 tests/btrfs/332.out
> >
> > diff --git a/tests/btrfs/332 b/tests/btrfs/332
> > new file mode 100755
> > index 000000000..d5cf32664
> > --- /dev/null
> > +++ b/tests/btrfs/332
> > @@ -0,0 +1,69 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. btrfs/332
> > +#
> > +# Test tune enabling and removing squotas on a live filesystem
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick qgroup
> > +
> > +# Import common functions.
> > +. ./common/filter.btrfs
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_scratch_enable_simple_quota
> > +_require_no_compress
> > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > +_require_fssum
> > +_require_btrfs_dump_super
> > +_require_btrfs_command inspect-internal dump-tree
> > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> > +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-quota)"
> > +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> > +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-quota)"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +# do some stuff
> > +d1=$SCRATCH_MNT/d1
> > +d2=$SCRATCH_MNT/d2
> > +mkdir $d1
> > +mkdir $d2
> > +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> > +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> > +
> > +# enable squotas
> > +_scratch_unmount
> > +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
> > +       _fail "enable simple quota failed"
> 
> Instead of doing a "|| _fail ..." everywhere, can't we simply not
> redirect stderr to the .full file and instead have a golden output
> mismatch in case an error happens?
> Not only that makes the test shorter and easier to read, it goes along
> with the most common practice in fstests.
> 

That's what I wanted to do, since you have given me that feedback in the
past, but unfortunately --enable-simple-quota currently spits out a line
for each qgroup it creates, which we can't predict in the output, since
I don't think the fsstress run is deterministic?

Options I considered where:
- grep -v or otherwise filter out those lines
- check the failure

I am happy to switch to the grep.

> > +_check_btrfs_filesystem $SCRATCH_DEV
> > +_scratch_mount
> > +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> > +[ "$fssum_pre" == "$fssum_post" ] \
> > +       || echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
> > +
> > +# do some more stuff
> > +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> > +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> > +_scratch_unmount
> > +_check_btrfs_filesystem $SCRATCH_DEV
> > +
> > +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1 || \
> > +       _fail "remove simple quota failed"
> 
> Same here.
> 
> With that fixed (if it can be done):

I think here, the command does generally work how we want: silent on
success, spews on failure, but I wanted it to be consistent with the
enable, not have to look in different files (or stick in a tee) etc..

I'll play around with it and re-send if the filtered version looks
better.

> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> > +_check_btrfs_filesystem $SCRATCH_DEV
> > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE_QUOTA'
> > +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUOTA' -e 'QGROUP'
> > +
> > +_scratch_mount
> > +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> > +_scratch_unmount
> > +[ "$fssum_pre" == "$fssum_post" ] \
> > +       || echo "fssum $fssum_pre does not match $fssum_post after disabling squota"
> > +
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> > new file mode 100644
> > index 000000000..adb316136
> > --- /dev/null
> > +++ b/tests/btrfs/332.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 332
> > +Silence is golden
> > --
> > 2.45.2
> >
> >

