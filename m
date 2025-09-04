Return-Path: <linux-btrfs+bounces-16621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BADB43C61
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 15:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0520A1BC077C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443F2FF649;
	Thu,  4 Sep 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pavqM5uI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDA2FF64F
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990858; cv=none; b=tuEXDl6DciFiRbosiETYIrE0OPMO4AxjNqurLKg5ua6mOxdIU286MUHd6LnxUTh27+5ig80jnJByNkpaYX/nwQlcavWTTNWOCfumGmU1AoMs24cpFzuDgh7XZ91+FRTuh1VKnGShl3gwxjyU+t/td+oJCXJKYZV0lcnU7vQzU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990858; c=relaxed/simple;
	bh=Tmgaw4i0Yd4nWUFJu9joP03HPkAuLpfqflf1bi5GjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB03RhE/ZJ9gfb6xlVsXx0o9zQhrSz23ZleBJfqVtbseK99M1hnGbYsOAfDpdfDzIECkvl2KIIZwEMwHJH27vRmBPhCuDPRcELbzsPsC/QfotO6bh1/WPDdVmUkoiqQiKa1UCChyOr7c5nC9JikWylZ1CFRghO9z9wGhmOJBpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pavqM5uI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 584D0lug019785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 09:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756990849; bh=uR/MGN8yFgfE1t/K21wdgS0m0nWB6QMulCRtGqp8wMw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pavqM5uIeO+Kd24WXUyCs0emWw1bn9YJsGsq8iO22XNEjfWaQwvJOAJORbDCYqX/P
	 qssZWjlZ1TrNGBT8l8K/ay0758IfcvsNaiQGyKvJwIfLczRaEueeCSZibnCdbO3Jbh
	 UQW+C8KDe6TlZTtorZH3NWC+0GB26zR1xYjycWEp9ESGO3E2ltL1qaAN1d4R11esGE
	 JIi/NMK5Wrf2R1Y1Frl3v1pIT+cERL+03xEpFi1KP9o4ohNIM9JoxK85Tk7VpHIF8A
	 u5DjvaZ0GHTDnTxESXyj6A5nSMVN8gzN4kWF+JdXRYDZoC+sJ1NvVm4Z7SoFS7K98f
	 izlp6PnetPRww==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 88C5E2E00D6; Thu, 04 Sep 2025 09:00:47 -0400 (EDT)
Date: Thu, 4 Sep 2025 09:00:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/228: do not rely on the bash core
 dump output
Message-ID: <20250904130047.GB3267668@mit.edu>
References: <20250904061944.105518-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904061944.105518-1-wqu@suse.com>

On Thu, Sep 04, 2025 at 03:49:44PM +0930, Qu Wenruo wrote:
> [BUG]
> With bash 5.3.x, the test case generic/228 will always fail with the
> following golden output mismatch:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PREEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
> MKFS_OPTIONS  -- /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> generic/228 1s ... - output mismatch (see /home/adam/xfstests/results//generic/228.out.bad)
>     --- tests/generic/228.out	2025-09-04 15:15:08.965000000 +0930
>     +++ /home/adam/xfstests/results//generic/228.out.bad	2025-09-04 15:16:05.627457599 +0930
>     @@ -1,6 +1,6 @@
>      QA output created by 228
>      File size limit is now set to 100 MB.
>      Let us try to preallocate 101 MB. This should fail.
>     -File size limit exceeded
>     +File size limit exceeded   $XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch
>      Let us now try to preallocate 50 MB. This should succeed.
>      Test over.
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/228.out /home/adam/xfstests/results//generic/228.out.bad'  to see the entire diff)
> Ran: generic/228
> Failures: generic/228
> Failed 1 of 1 tests
> 
> [CAUSE]
> The "File size limit exceeded" line is never from xfs_io, but the
> coredump from bash itself.
> 
> And with latest 5.3.x bash, it added extra dump during such core dump
> handling (even if we have explicitly skipped the coredump).
> 
> [FIX]
> Instead of relying on bash to do the coredump, which is unreliable
> between different bash versions as I have shown above, ignore the
> SIGXFSZ signal so that xfs_io will do the error output, which is more
> reliable than bash.
> 
> And since we do not need to bother the coredump behavior, remove all the
> cleanup and preparation for coredump.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Makes sense, thanks for testing against the latest bash!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

