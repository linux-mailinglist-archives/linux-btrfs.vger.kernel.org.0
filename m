Return-Path: <linux-btrfs+bounces-8518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A973298F6E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 21:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01F0B22655
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5FF1AB6ED;
	Thu,  3 Oct 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="cVAxsIoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBv9ztbc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95A38DE0;
	Thu,  3 Oct 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982915; cv=none; b=FvJdJ4Jpe76z/Crb6bCzl6sMfDuHdRnbM5P9VTFU+OTIjOKja7ImwYUzBwpewdvg9H2ofhjfvlNRF+AxTEmwPngrQD+K/EmSgiYqThaplD/WEmIQDGH4gWz8fwYkthWpzfgvN8EU7vKtOkdPQcTuubj9PReqq8tY2JXY8LM7RMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982915; c=relaxed/simple;
	bh=gprhaAfRLX23AC0athsL5N8eHyPnGvBa/jSxZtpXM0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBV+/4uHUuEX9Kpi+kg1oR62y57UNws+MK5d5oKlYFpIfIcslPR+3PDRB43BZ3Xo86vqGsqtMV34Rn8X9H5xKj3JmxDqDj5b/PNFhhZxaaccfGEni2eufZAY+X+G6w2T89Z3DaXRxsFL9VRBqDgcjK3kGXDREUxjKiPO3ycXLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=cVAxsIoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBv9ztbc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11D0111400C9;
	Thu,  3 Oct 2024 15:15:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 03 Oct 2024 15:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727982912; x=1728069312; bh=tV0lDiO1RJ
	0VvqU94T/ZjPsf+GxfS+Dqd6Z+BWlsIpc=; b=cVAxsIoTlMyLeiOAuqGLHXEy5p
	/9p3jDH+kE2HepVuAoPMwbDjhuf+Dvw1auusdHda05fcdax1mGGKhdVIcNCpWfvz
	ArL0buhaALk1tdojnaiM8EcL6qnrue9ffMRzDanTfuKJL8j/f6NNV+kOvUkNbPH3
	vb6Ix3mzAvYiy+uPThjNMwUnPza4klYMninZezi51RiMyufiLq7R0PvcHxApkS9+
	L9vIg1TPIb19HIeD7GnZGtFxh/sCLNq1NxgZH2aUOgRCT28rGRqRiGGrK//znvq6
	uR7EwYTONiDZy4XMH/s0kGKiqjCFKIzIS2yYz9JZ99R+48Ub4tZVYPHM7Lqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727982912; x=1728069312; bh=tV0lDiO1RJ0VvqU94T/ZjPsf+Gxf
	S+Dqd6Z+BWlsIpc=; b=pBv9ztbc963oYYcMqBm6qtPuFu6aE/C+9N9lfjpWqjLr
	IKJqNQ8/GvskF+DyC0xVbI2pmgwrcSio5S8XyinXylNv6QQEw/AWjrsQvLM+sc5n
	ZfwOFI9Amn4TlKQTHhYrRrHsgyIT5KV5qeWU/PFQkgngGNikoeQbef1FeOUBlntv
	ko5WCqBmQLWa7xtfUwfbzoAf9rwMGbgbodClBfu/UscudpC2n7dSut3BX+EZO+RK
	F80absnP91nCnAAB9p+adN0u9PzEmdbYQC4IpJRrcsl6FgHIm5q8BFZIDEPHII9H
	wDV6Mhabb/ygQzSoB3wLmcJ8A4XD6MKAsYyBt6eODQ==
X-ME-Sender: <xms:P-3-ZodV0OF0WcBqnjRZ23BiHSNb42G8KRsqInSzWhONMouX9RqgTA>
    <xme:P-3-ZqPQ9YR4RB0PvpzWlE7Mk52e0erhwBDFOCMKw79iWo7BFJ2NXDoWC6rODA8MR
    pOTmfzxVEQB6Ru0n6g>
X-ME-Received: <xmr:P-3-ZpifwB0QcenZeK9RvqzVFWAkQIihreo1UdZ7b4Lve1iEKRgdn9HcSpsXeaVq_i6matiCsfWs1G8AayPfczemBbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    fhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P-3-Zt_vae_CGXZO1mrrLi1aDEaz4dN6OVV9JlGrvFq3PkvxVTMXlg>
    <xmx:P-3-ZktAdd3E2E3ztS3VqG37UiTkDT-pgCeJwz6Eva1_BJOX1Em2Gg>
    <xmx:P-3-ZkFeunL1yq0ODkJJFKf8H-kvF1ObsW5B0JR62YffkM6K14TFyQ>
    <xmx:P-3-ZjMZkv4y21Yn7Em9mV1G4y12wacxxmqrYZjFMAZ0JGLYX4dAcA>
    <xmx:QO3-ZgLrnW7rdlRyk35zgJwyXufSGevoXGqjG6DMsDe1BiCxQqwdL7ei>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 15:15:11 -0400 (EDT)
Date: Thu, 3 Oct 2024 12:15:08 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Message-ID: <20241003191508.GA435178@zen.localdomain>
References: <20240929235038.24497-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929235038.24497-1-wqu@suse.com>

On Mon, Sep 30, 2024 at 09:20:38AM +0930, Qu Wenruo wrote:
> [FALSE ALERTS]
> If the system has a page size larger than 4K, and the fs block size
> matches the page size, test case generic/563 will fail:
> 
>     --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>     +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
>     @@ -3,7 +3,8 @@
>      read is in range
>      write is in range
>      write -> read/write
>     -read is in range
>     +read has value of 8388608
>     +read is NOT in range -33792 .. 33792
>      write is in range
>     ...
> 
> Both Ext4 and btrfs fail with 64K block size and 64K page size
> 
> [CAUSE]
> The test case writes the 8MiB file using the default block size xfs_io
> pwrite, which is 4KiB.
> 
> Since the fs block size is 64K, such 4KiB write is unaligned inside a
> block, causing the fs to read out the full page.
> 
> Thus the pwrite will cause the fs to read out every page, resulting the
> above 8MiB+ read value.
> 
> [FIX]
> Fix the test case by using the fs block size to avoid such unaligned
> buffered write.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The rationale and change look good to me. I also tested it on my system
with blocksize=pagesize=4k, though I don't have access to one with a 64k
page size for the more interesting confirmation.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  tests/generic/563 | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index 0a8129a6..e8db8acf 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -94,6 +94,8 @@ sminor=$((0x`stat -L -c %T $LOOP_DEV`))
>  _mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
>  _mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
>  
> +blksize=$(_get_block_size "$SCRATCH_MNT")
> +
>  drop_io_cgroup=
>  grep -q -w io $cgdir/cgroup.subtree_control || drop_io_cgroup=1
>  
> @@ -103,7 +105,7 @@ echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>  echo "read/write"
>  reset
>  switch_cg $cgdir/$seq-cg
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
>  	$SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> @@ -114,9 +116,9 @@ check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>  echo "write -> read/write"
>  reset
>  switch_cg $cgdir/$seq-cg
> -$XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir/$seq-cg-2
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> @@ -134,7 +136,7 @@ reset
>  switch_cg $cgdir/$seq-cg
>  $XFS_IO_PROG -c "pread 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
>  switch_cg $cgdir/$seq-cg-2
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
>  	>> $seqres.full 2>&1
>  switch_cg $cgdir
>  $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -- 
> 2.46.0
> 

