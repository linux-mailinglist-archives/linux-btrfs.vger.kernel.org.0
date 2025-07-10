Return-Path: <linux-btrfs+bounces-15429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A94B00B44
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167D57A3AC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92532F4339;
	Thu, 10 Jul 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GenJNDrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CC2EF2BE
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171892; cv=none; b=vDWX4JHhaPK5muFeZ2NCdXuqG0lEhb3kNyACbGLHM9OOLS9yGXfmZJH5qK0Ls8xgG0+Fy9gy+UBZQr71dqsYhLCJTRn0OcHX9GE/mo+652cn/vINsxGUHZOflza9sqLE//jfKUSPUVgI2iLgqdXgr/D8H+DpulN9YzoUIS/C/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171892; c=relaxed/simple;
	bh=DsLFrnVRMMGITPWlfPZ7uoPR3BKg+NFVQGD0v7R7470=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP+RlzMeCwqTcaqSiNY+5uwWa3P9gGgNDFZSHLt5kkSN6c7TpefwUwDLo5cp8HxEZv01bVyMMZqvxABvcpUG++dIHb+3fS21VVJfcXOQi4c3nWGL8uJKpHTG6KGcyvTGoGzGs25YNWmIwSDsVEp/Aiq6Ke+8f4Nr/TzjGphm80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GenJNDrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752171889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwiVPBdUJC6rkc4PHGcJB16mH+q+WGUbV8g0rByGz94=;
	b=GenJNDrYXWHe8Z3KxyZ1QoA8H4RQLIKzv6A93V/9dITqskgsjbfaZ3QOF9/CggXy5Oh7/D
	MUMzVVDDNjOjaswq/kTXFhRkQX6LtjzikZURHRYVAnPmHgLAsRbWTqlTseZSNdAJ4PKdss
	09XtPUZg3OmQ5g9MrLriZzbz8rPqFHY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-NMk4MZVMP6OJbKGG6o0a7g-1; Thu, 10 Jul 2025 14:24:47 -0400
X-MC-Unique: NMk4MZVMP6OJbKGG6o0a7g-1
X-Mimecast-MFC-AGG-ID: NMk4MZVMP6OJbKGG6o0a7g_1752171886
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso1796373a91.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 11:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171885; x=1752776685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwiVPBdUJC6rkc4PHGcJB16mH+q+WGUbV8g0rByGz94=;
        b=h8x2UM6L1bEONjExpvylv8zng7U3locozmm6ZAKe3sSfx6EaNYj+BE94lkyCrkCfsF
         maF1JrYXPS+29KzhUagHEZyZPq6TR95Vq6QGuQo9EVeetPDtt3CWixqAX0xUlfQB/a4d
         LAgs9Tcet/QndLxUgGm7t8ZhImtn/XvjSMVW495bAMWFSyfJ4+pzsxkyVIBH9UmyY7Fj
         k3FtNW8t1kkm8TedqCCgNNJn/h5bU6YUiOA5y/ZsgivkivNE3FwXmgXk2rv17KOgHq18
         nkxytMJeKoce9EfaQiHacLpbugPHyng++C/39AnyIIVXAGH7tLTgD2qtWyfw6D5yYD1r
         HcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvUqgXA+PKQYOP5jBYykz6tztS4z3x52HwO8nFbquf8HmGCG3v0hMs/wh2maG2gBKRWbgMk54a5i9MXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Om5hNt39FJsXwiZ10yr6iiqNuaK2V5Nhjga8ZMVNnkfuR1ff
	BIJirxoT05kyCn+Xw25zijHjTSqJ5G3evxgJtKSzjjnuBOKin9QRYGn8roq79Eyr3+1SRtx5L7d
	UOINC+2ZV1uT8oAkGs599vDzWckFchCta4SN92k7mrBR64L+PqXZIAwtJOckuBR7z6dWtut00
X-Gm-Gg: ASbGnct6ljgoVJImf7R46Zt20Zs7f5YkbaZoFQpgmUvWCEcpxLkrWDZJjlyCjWqaFfl
	qD0jmEJvtR0hvFdZuAzxBRTxwpQV5thAXW0/+j7G3UMr4nsDoVQ59+6WtAzrx9NNhdtuNmvLMy7
	KT+4+UON1SzXgdHNRcz4N+KgPAGtblNz4MDLqdOewgTyALE6D588rH3mYXTw7ifGpSkrvtmWVMe
	1PacQQ5EOrRonhPDRmQX71tn+GJgcym8HKKQUKRnO2xppENfxiXjwL2CNo1SIVL6mWP8D5ZyBnE
	D/tS7ei+hBsnUGA/S2kUFn0qwZffDm88RhRm9nLB8SikX+UhXjAi7IRAUIj//NM=
X-Received: by 2002:a17:902:cf07:b0:235:15f3:ef16 with SMTP id d9443c01a7336-23dede3a35emr2879495ad.13.1752171885444;
        Thu, 10 Jul 2025 11:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaRwJekOrZ+hET/XMGZtYgxaB4ddoI3su+l3xYpS2kd1XXWZ0iTNVDqIn8mL7YMiHwMAQbqg==
X-Received: by 2002:a17:902:cf07:b0:235:15f3:ef16 with SMTP id d9443c01a7336-23dede3a35emr2879275ad.13.1752171885006;
        Thu, 10 Jul 2025 11:24:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe581a16sm2852217a12.28.2025.07.10.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:24:44 -0700 (PDT)
Date: Fri, 11 Jul 2025 02:24:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710182440.jnqs36ukx4j4okxr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>

On Thu, Jul 10, 2025 at 06:03:43PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that overwriting a file with mmap when the filesystem has no more
> space available for data allocation works. The motivation here is to check
> that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> 
> This currently fails with btrfs but it's fixed by a kernel patch that has
> the subject:
> 
>    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use _try_scratch_mkfs_sized;
>     Use _get_file_block_size instead of _get_block_size;
>     Add a more detailed comment about why dd is used to fill the fs.

Thanks Filipe, it's going to be merged into patches-in-queue branch, and
will be push in next fstests release (this weekend hopefully)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/211     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/211.out |  6 +++++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/generic/211
>  create mode 100644 tests/generic/211.out
> 
> diff --git a/tests/generic/211 b/tests/generic/211
> new file mode 100755
> index 00000000..e87d1e01
> --- /dev/null
> +++ b/tests/generic/211
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 211
> +#
> +# Test that overwriting a file with mmap when the filesystem has no more space
> +# available for data allocation works. The motivation here is to check that
> +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw mmap
> +
> +. ./common/filter
> +
> +_require_scratch
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> +
> +# Use a 512M fs so that it's fast to fill it with data but not too small such
> +# that on btrfs it results in a fs with mixed block groups - we want to have
> +# dedicated block groups for data and metadata, so that after filling all the
> +# data block groups we can do a NOCOW write with mmap (if we have enough free
> +# metadata space available).
> +fs_size=$(_small_fs_size_mb 512)
> +_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> +	_fail "mkfs failed"
> +_scratch_mount
> +
> +touch $SCRATCH_MNT/foobar
> +
> +# Set the file to NOCOW mode on btrfs, which must be done while the file is
> +# empty, otherwise it fails.
> +if [ $FSTYP == "btrfs" ]; then
> +	_require_chattr C
> +	$CHATTR_PROG +C $SCRATCH_MNT/foobar
> +fi
> +
> +# Add initial data to the file we will later overwrite with mmap.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now fill all the remaining space with data. We use dd because we want to fill
> +# only data space in btrfs - creating files with __populate_fill_fs() would also
> +# fill metadata space. We want to exhaust data space on btrfs but still have
> +# metadata space available, as metadata is always COWed on btrfs, so that the
> +# mmap writes below succeed (metadata space available but no more data space
> +# available).
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
> +
> +# Overwrite the file with a mmap write. Should succeed.
> +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> +	     -c "mwrite -S 0xcd 0 1M" \
> +	     -c "munmap"              \
> +	     $SCRATCH_MNT/foobar
> +
> +# Cycle mount and dump the file's content. We expect to see the new data.
> +_scratch_cycle_mount
> +_hexdump $SCRATCH_MNT/foobar
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/211.out b/tests/generic/211.out
> new file mode 100644
> index 00000000..71cdf0f8
> --- /dev/null
> +++ b/tests/generic/211.out
> @@ -0,0 +1,6 @@
> +QA output created by 211
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +100000
> -- 
> 2.47.2
> 
> 


