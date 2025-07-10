Return-Path: <linux-btrfs+bounces-15413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9DDAFFAE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 09:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3F41885CFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D141289371;
	Thu, 10 Jul 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QV2C4aEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E41288C18
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132581; cv=none; b=urzLN3mnm0fQ58xdQE7tMJ3RpE+Akx/DMdfkia6fsMxgocg1z80uw93Apn5Or7SMcuEToXT+1AcGPZo/1MpnSe2tOqSU4neCorOpYmhkjjLoRAQJkjOLDFyXOsnde6WS+Vzu5CPKii0pcCeLNpMHKbKHF5T4EKRqA2twfhWOlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132581; c=relaxed/simple;
	bh=R8EipCxdU3PVl0tdLEk0mFFad9Gdcz9No/wiCW3k7/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFWOHukRV9dElCkVAmS07ACJuGGuRdoU5r/ascseF/S5feBTsOYdpxV7/jJTN8TOMTI2Pwp4CYa0KC5e/nhUE4aC+tBFEBlDKu5hi79hR+qEv3zapAuL9SpVcEzRynO56paR+PfdIwAzjekPqo+RdE74zRB88cogslZ56vw+bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QV2C4aEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752132578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fepGkfCQMKLcAnWI7GqA+ecbi4ubuIxZYETmUVYEd94=;
	b=QV2C4aEbQjobzsJRD/t9mqxM7FXzkOetsPGBfr5rUJKiPsxvw3guIQj4gd6lHTzNZFNZaJ
	I43ntKphDNSUe5HPHqmuLFTJ/tlVMIzHKq+Q1CEKB2o2eSOurdaKxkCct7TQRiAnY1NgQ8
	nFa5zbXvPGhU6Q06dRCWThVSBV7ZHu8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-x5qwUIANNEWSnaNulzllQQ-1; Thu, 10 Jul 2025 03:29:34 -0400
X-MC-Unique: x5qwUIANNEWSnaNulzllQQ-1
X-Mimecast-MFC-AGG-ID: x5qwUIANNEWSnaNulzllQQ_1752132574
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2369261224bso8135795ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 00:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752132574; x=1752737374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fepGkfCQMKLcAnWI7GqA+ecbi4ubuIxZYETmUVYEd94=;
        b=IgdIhpf1M0w6dE4jix4XBR3POGYcuYtldW1+FTgiESLzUtlfscCigkt3D6h2V9kWjY
         xaMlP6p/05aWDpSyIrgSN/K5c1fdeRpN0q9lANKUhM3pC1SXntJU1bPODnOu9/ZpB1cv
         MKQNZYmw0OM+Bn2TnBtH9E/9Je2/l2gFzqojDjuiNpD9wFnwJzglkxvemgJL5XMAZ2XN
         L3hywNGBYfZ/W8Wyyc68XrK5cE+awp8KNvRPX0InC2GR5awqWTx5JiN0G+laDBOX1HNT
         ZopBz3GQ828oqYBnnxkUQUvW1pzqaH9z9XWb+qZvGFmdNqiOaae5RuNq9Lyfm1wT4hut
         e3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXQKPp7IOtEAkGP9Zxi0f7LlVCZlUonXKySJN6sE7/IGu4tNlsYV/ZTVZVoCuquMr6SCjUKmZxagSj8Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjpNwk6nahYNNEYIu8lbwNec/b1E0P3g/RPSkXbHMXvVtPosa
	cYQk+tVkiZs4r9FDWhQeQR0HtRc6E+1OHcpR64fYbhviRwCyXPdD0xWqlnPobyVwqL6zFfEgF3D
	ltJK+vMiehjo30SOO7lP5w5yKNbaxr9SxWzDglSGUdEH4lbFOhuGJE2J1M0WVPdru
X-Gm-Gg: ASbGncuDQTnvvCl1/7Fpsfyog5UL0Osi2buiTv5H87HXuz8tyYj8o+MXq2QIrJZ5RN5
	WF8Ht35pKKJ4Qj7eYYPi/XKWa4UOqzJKmNCiI4IY6RzEdccnhBkAjUwBiYHxVgeQ72pJ1Qe0IZb
	2aVMIUcXAu0MdLFQlufjrfIX4JEaZMpaGPGkAMOcmaFmcAaEeFXKjdmdwfIrRF1RMmLmVZvpHXC
	/lmce8kYTDbNLjdusbCvCmlzBucwAJinBxGIaq3UWL196mp78ZZDi8avrbC1+5kx53+XgwcyNwg
	5WgLy4iSkGsMeacbEEggtmGzMByBMUJTGjdOitzQk4b14KwBkEmflA7FOncB+nU=
X-Received: by 2002:a17:903:2445:b0:234:c549:da10 with SMTP id d9443c01a7336-23de4895596mr24082915ad.47.1752132573850;
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKYKaiXyhmhsXDpt36xy6hcE+/2REseEbAF6LNznJ+WbhqMKbD4EV9+KnuZDFxJ/w7JT4tuQ==
X-Received: by 2002:a17:903:2445:b0:234:c549:da10 with SMTP id d9443c01a7336-23de4895596mr24082665ad.47.1752132573501;
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm12218015ad.189.2025.07.10.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:29:33 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:29:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>

On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
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
>  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/211.out |  6 +++++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/211
>  create mode 100644 tests/generic/211.out
> 
> diff --git a/tests/generic/211 b/tests/generic/211
> new file mode 100755
> index 00000000..c77508fe
> --- /dev/null
> +++ b/tests/generic/211
> @@ -0,0 +1,58 @@
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
> +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> +	_fail "mkfs failed"

_scratch_mkfs_sized calls _notrun if it fails:

  _scratch_mkfs_sized()
  {
        _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
  }

So you can let it _notrun:
_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1

or you'd like to _fail:

_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
	 _fail "mkfs failed"

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
> +# Now fill all the remaining space with data.
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1

As this's a generic test case, I'm wondering if the common/populate:_fill_fs()
helps?

Thanks,
Zorro

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


