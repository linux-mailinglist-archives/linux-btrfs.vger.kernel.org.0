Return-Path: <linux-btrfs+bounces-18509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F617C28111
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5354A1891F34
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D6723D29A;
	Sat,  1 Nov 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTtGQaRZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aP1Qe/7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59681DFE22
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007883; cv=none; b=OSrZuLPIL2WKYqkNKXHMfV0yu5ZTxClBxUEvIoEcGrlAGY2jnMa7EjiCn8+3fzZ0IK7HzV89FjejUuIHoq89yHqnfVmGYR42eYAveZBVLwZFfpGzgGIr0nv6pnvZ0rmn3lehqkX+Tpe6ZFgu9iTJBKu29a6NwCB4UPIY2cCAWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007883; c=relaxed/simple;
	bh=5xrtme0M35LHb7Ravpc/2oqNOBSqV33UC7vg9B2GkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izBgw7Rqvqb/MgYxReKts655khyA1Ulah6P5now8RRTfAMIZCx/++nOFwN0fVUDEuNHnV4LXRbQX+I1HSQbhZvuDdojRT51xCgnH+Hvvu+8ktduZeYNuBuqmMnZ7MJv4zCoIwEJe2Yw+nnvV09GqellV4GRGnYn85E+MKi1uKhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTtGQaRZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aP1Qe/7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762007880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
	b=HTtGQaRZYzyLm+zXrc+ynlq93O+tgCSduBWLKPka5eEzM6tXBo5VOVQTBY1ra3a+G79Xzk
	dQ6rqutKvwF0iEpT/5LVnjamL0k8A5hzpKUnHiyKNaKhM27wb5G2dH4BBcyl/PB24ILJjO
	p4Yvx4YM1wMbdS7dTixyiEEeKaJfZBw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-FTm2aBhTMsCzrQhZIIuWfw-1; Sat, 01 Nov 2025 10:37:57 -0400
X-MC-Unique: FTm2aBhTMsCzrQhZIIuWfw-1
X-Mimecast-MFC-AGG-ID: FTm2aBhTMsCzrQhZIIuWfw_1762007876
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55735710f0so5439729a12.2
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Nov 2025 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762007876; x=1762612676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
        b=aP1Qe/7Q3LISBP5WR54L+baUzi6fl7/mUohZnGsc4WMy/p0jywB2/gQ2bCrMLGYBrZ
         5khTXrpcncgjhlx8ZcaLoqkEykPvh+QHOd5Sd/VAfDWg+Ew8EYB/MmxXQpjXwgrzBuCu
         wfb8hazXLxdpgiFk8GlqhkpgeG/7iURx7h2gnuUSOT13r7RtH4SwO4FeNHcVlW+LClmV
         8pbnq0a9i2zdICrsywto3CUm+6FpjrUV35fqP7UJ0Lvv7KEpI6RckcW/UqufN+PhMOYk
         SQCRgMrVFu85vb7USNAi4r/hJtjdnNYkUKKSnBITdnrP4yWs88qQWSEQrcNUCaisEJvH
         Hnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007876; x=1762612676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
        b=afRBcNKPBqt707gba+feB9MhVGoyooxsjmaGzwUbaSkCxoiiyLLVsVATyeU8XiyyLm
         CfjMaRo4l98KZrPMGqlBZ2cJEiM4zYHzFx2VeOnMSnnum7BzaeyQuxeA8n8LLrXa7XyF
         LKcRY2SspIMV6/HVicBQvA1Z9Sg1vF5gPAZKPXXJR904FZWmi5/m5DQR2iFX15qEKV31
         QK9MKXraWC7T29YccQ4ZU/B+gaNtqVHnM9fWFiuRISi+Bl3AN4we65nw5k3K6UcGBIzi
         OqAKUu+EXVYKihu0GGR11VA36iWfD8jTOrzEXCXC40Q7vY3nUR+PFdKtRePeItsekdMT
         Y99Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+P+RmJTwBd/R7MRh+ntrI23OnW6i6TVU3TWbkNrncrbu2bVTE8HJipibINMvSqor+ZpV1wXIxzR7JWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XKBgbBc2WKpUcyHfmah6LdDrOsIUaYSaTtaZE0i4Bbzi4EWa
	cU2pb32SndLjcDe1R/N9f+qzJUqo4kAbb/KExWiCAqAbpgRITAXIMTJVn0uvWSzogoqGt2XdcFw
	jHJLwsUUsyqo3LS0ouMtyoRVpVwRI5dBaVxmw0+3w8DOpYZrvsgT9xr5hunjeTs47
X-Gm-Gg: ASbGnctiqCepdfiz0iChLxiHvCaHecUFiyz6+YiO8WHcklGF4w6mNoQH+zPT/fOEwGI
	bs3hMXheuQqonIawDgjthEtT3ooJcdc68L2iqukVTEBXVc9tZDufyu+3MSFmSJaqJVBiEV5XAjj
	WTOaI99/Yb2WkqKD/3x54kEX4TeDF8BIEr0oECZrNt1D6xavXw1NxVezldABwQEdqVietyX4gY5
	xzVb+2A+BLs1v09QQova+JL1JstEw5YkRUmePKwC1x9ogH84JZirPlROCYntObCr/YZCvsSlyVf
	hr3Nr+xNxotVXoFM5pfgjU1eiM4Jhjr30McDJWlI1QSKIcFGpM1tRli9K3Z2/cbXmaoZi2pI3fp
	qrC3Z4UY+kZv+gdequI8q0e5E9GTAFkcgibBmg74=
X-Received: by 2002:a05:6a20:431e:b0:33b:4747:a258 with SMTP id adf61e73a8af0-348cc8e36c8mr10262098637.46.1762007875865;
        Sat, 01 Nov 2025 07:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bramBp29coOQwB1J5tkWmqu1MB/4bEq06symZeYDhvMyDSCCWzUIWyD9PIId0tf8vL8GtQ==
X-Received: by 2002:a05:6a20:431e:b0:33b:4747:a258 with SMTP id adf61e73a8af0-348cc8e36c8mr10262078637.46.1762007875378;
        Sat, 01 Nov 2025 07:37:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d9261c1fsm5428119b3a.30.2025.11.01.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:37:54 -0700 (PDT)
Date: Sat, 1 Nov 2025 22:37:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test a scenario of dir fsync after adding a
 link to a subdir
Message-ID: <20251101143637.oiapisxxxl2q3qzk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <92f178d04f74f9281b97d67bdf402e7a5e3baec9.1761752457.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f178d04f74f9281b97d67bdf402e7a5e3baec9.1761752457.git.fdmanana@suse.com>

On Wed, Oct 29, 2025 at 03:46:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we add a new directory to the root directory, change a file
> in the root directory, fsync the file, add a hard link for the file inside
> the new directory and then fsync the root directory, after a power failure
> the root directory has the entry for the new directory.
> 
> This is a regression test for the following btrfs patch:
> 
>  "btrfs: do not update last_log_commit when logging inode due to a new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/780     | 73 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/780.out | 10 ++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/780
>  create mode 100644 tests/generic/780.out
> 
> diff --git a/tests/generic/780 b/tests/generic/780
> new file mode 100755
> index 00000000..d4977b06
> --- /dev/null
> +++ b/tests/generic/780
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 780
> +#
> +# Test that if we add a new directory to the root directory, change a file in
> +# the root directory, fsync the file, add a hard link for the file inside the
> +# new directory and then fsync the root directory, after a power failure the
> +# root directory has the entry for the new directory.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: do not update last_log_commit when logging inode due to a new name"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test file.
> +touch $SCRATCH_MNT/foo
> +
> +# Make sure it's durably persisted.
> +_scratch_sync
> +
> +# Create a test directory in the root dir.
> +mkdir $SCRATCH_MNT/dir
> +
> +# Write some data to the file and fsync it.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 64K" \
> +	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Add a hard link for our file inside the test directory.
> +# On btrfs this causes updating the file's inode and both parent
> +# directories in the log tree (in memory only).
> +ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir/bar
> +
> +# Fsync the root directory.
> +# We expect it to persist the entry for directory "dir".
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# The directory "dir" should be present as well as file "foo".
> +# Filter the 'lost+found' that only exists in some filesystems like ext4.
> +echo "Root content:"
> +ls -1 $SCRATCH_MNT | grep -v 'lost+found'
> +
> +# Also check file "foo" has the expected data.
> +echo "File data:"
> +_hexdump $SCRATCH_MNT/foo
> +
> +_unmount_flakey
> +
> +_exit 0
> diff --git a/tests/generic/780.out b/tests/generic/780.out
> new file mode 100644
> index 00000000..3be43734
> --- /dev/null
> +++ b/tests/generic/780.out
> @@ -0,0 +1,10 @@
> +QA output created by 780
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Root content:
> +dir
> +foo
> +File data:
> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
> +*
> +010000
> -- 
> 2.47.2
> 
> 


