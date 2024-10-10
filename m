Return-Path: <linux-btrfs+bounces-8773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2529997D87
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 08:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22961C22792
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F831A304A;
	Thu, 10 Oct 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf93+2vz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DD19307F;
	Thu, 10 Oct 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542630; cv=none; b=hKEWlrlDwbwsDSCWTHrcddSujFDkVtLP5pRgNeJARwz2IQjCvBNK1FN34WgF15nVVkwKucZyIhtAmrcx0DsL+9rdD3lb38T8d/xF/9gBp/5OkjofQe3k7D6YiuWyWeseIvbBWDv2MStUiBgrrXfK7K166MWlQtqKiz1wWuonz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542630; c=relaxed/simple;
	bh=61gM+yGsOYWH+IzqrDLzQOpEiL3Q33eHHD/whXPJaB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvmx8yriCQiHrkdG358pG23sb1sG4PxDhFJNj7itRRUE1xag/bMrpKjy6+yxt4DQKhwnxraClaTd4WgXFDVw/dc2+5VKAAxSh1r/Yd7MHkw72h6Z1fv1oqTb5wlJCrGAP8xrixorfxZC5mLTz7GqCOjCKTqJQFlGX5Z1hd55qPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf93+2vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A395BC4CEC5;
	Thu, 10 Oct 2024 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728542629;
	bh=61gM+yGsOYWH+IzqrDLzQOpEiL3Q33eHHD/whXPJaB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qf93+2vzRxZ0w9nTSz7DcuUGm4fMjQWgaJQS+KOl0s5M80xy6PHcdhRpV6TRn8lG3
	 UwaXKD/qfYJn14i4Gq7JbIA08dfFkp4gQcoAA825K00Fc3VagxaQ5PZDjOUYJ3Kqxx
	 M6WZ9QLF9q8e4pfpcwFKOFdo0Mt0rZ0F6FmnhtzAEo+mPpIRxfX/5vFBqPy5Q8TkTZ
	 7r8lBlKxHL36rCVGif2NwH4JnYppWjQog8HgNyyduwzZjJjnIy9iIVMjmaAOVGlg8c
	 4aEbpSOfc9djXLKlWsctr2FO/dLL8Y8fkwG8qi3yJVEJHY08DDsoPeA7pjIxR0XRKE
	 erxXDeVF30SQQ==
Date: Thu, 10 Oct 2024 14:43:45 +0800
From: Zorro Lang <zlang@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Message-ID: <20241010064345.pmbkywzlun2cfx46@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240929235038.24497-1-wqu@suse.com>
 <4b176046-f0f2-4b76-ae03-08c6394baa9a@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b176046-f0f2-4b76-ae03-08c6394baa9a@suse.com>

On Wed, Oct 09, 2024 at 07:58:19PM +1030, Qu Wenruo wrote:
> Hi Zorro,
> 
> Mind to merge this fix?
> 
> It got 2 reviews and at least one verification on 64K page systems.

Sure, it'll be merged in next release. Thanks for fix this large block size
test error. More filesystems support bigger blocksize, e.g. xfs supports
blocksize > pagesize. It's great to fix more errors like that :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> 在 2024/9/30 09:20, Qu Wenruo 写道:
> > [FALSE ALERTS]
> > If the system has a page size larger than 4K, and the fs block size
> > matches the page size, test case generic/563 will fail:
> > 
> >      --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
> >      +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
> >      @@ -3,7 +3,8 @@
> >       read is in range
> >       write is in range
> >       write -> read/write
> >      -read is in range
> >      +read has value of 8388608
> >      +read is NOT in range -33792 .. 33792
> >       write is in range
> >      ...
> > 
> > Both Ext4 and btrfs fail with 64K block size and 64K page size
> > 
> > [CAUSE]
> > The test case writes the 8MiB file using the default block size xfs_io
> > pwrite, which is 4KiB.
> > 
> > Since the fs block size is 64K, such 4KiB write is unaligned inside a
> > block, causing the fs to read out the full page.
> > 
> > Thus the pwrite will cause the fs to read out every page, resulting the
> > above 8MiB+ read value.
> > 
> > [FIX]
> > Fix the test case by using the fs block size to avoid such unaligned
> > buffered write.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   tests/generic/563 | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/generic/563 b/tests/generic/563
> > index 0a8129a6..e8db8acf 100755
> > --- a/tests/generic/563
> > +++ b/tests/generic/563
> > @@ -94,6 +94,8 @@ sminor=$((0x`stat -L -c %T $LOOP_DEV`))
> >   _mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
> >   _mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
> > +blksize=$(_get_block_size "$SCRATCH_MNT")
> > +
> >   drop_io_cgroup=
> >   grep -q -w io $cgdir/cgroup.subtree_control || drop_io_cgroup=1
> > @@ -103,7 +105,7 @@ echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> >   echo "read/write"
> >   reset
> >   switch_cg $cgdir/$seq-cg
> > -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> > +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
> >   	$SCRATCH_MNT/file >> $seqres.full 2>&1
> >   switch_cg $cgdir
> >   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > @@ -114,9 +116,9 @@ check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> >   echo "write -> read/write"
> >   reset
> >   switch_cg $cgdir/$seq-cg
> > -$XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> > +$XFS_IO_PROG -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >   switch_cg $cgdir/$seq-cg-2
> > -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
> >   	>> $seqres.full 2>&1
> >   switch_cg $cgdir
> >   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> > @@ -134,7 +136,7 @@ reset
> >   switch_cg $cgdir/$seq-cg
> >   $XFS_IO_PROG -c "pread 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> >   switch_cg $cgdir/$seq-cg-2
> > -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> > +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
> >   	>> $seqres.full 2>&1
> >   switch_cg $cgdir
> >   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> 
> 

