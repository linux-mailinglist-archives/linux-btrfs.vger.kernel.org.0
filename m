Return-Path: <linux-btrfs+bounces-9198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF86E9B41FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 06:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D01C21D72
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF720100C;
	Tue, 29 Oct 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWf6/dth"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8702200BB5
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181410; cv=none; b=c+04YPHcxLq2hMWxVdvqF3siFYstQ+6c9Jtu5LXvxgfMJakk6TGEpWTNI5e8PPKRpMav4Q4OrMOHG8WouF44vlGcmhHkc0qsm5lEHZEznANfBOTjmWoWY02DXCQAqQhuRGkfBRyMLWQ7FidAikjQT/YBwcjDuhtB5fpvYF1kLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181410; c=relaxed/simple;
	bh=YiG2mDa6lG6CzYkACr+kxjRuEZMgivigYn22ZPouyhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbFBbEFqr+a4r4b0rtFKdjvdqOM/gqX0AAUlvW5Akx4CoT9fMeBIAXdzTst9WkcNSe/8sGAbo9bl8y1FsWtwAtze1bxpn9sqbUDgGjzlj9IYDms+l5nAY9DHlnTnBpoASDP4Yxm7J61EoJEbeAN8R/mTFKWWgZY3UjzJfpWW0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWf6/dth; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JimEgNyg/QcjYbmrAbgjGEPCU6tyoQRskON0uAxULg=;
	b=YWf6/dthn5tKmL7ktxlKpUoysCo04YXBxB4XnQ8gKvHrrStE1+M+EYlqZKjtWiNDMNOqQV
	j9U/uXrm39klT4KtCYa5IYo+QXadUCyzRJOIT5GJEn3O5I2opOkoggMEFukhh91CBgMhi6
	hjCGkOyZQ/Fy6zp14yaxeyzenvWuOhI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-nHB-AUhIPT6_gG2_gsaZgA-1; Tue, 29 Oct 2024 01:56:45 -0400
X-MC-Unique: nHB-AUhIPT6_gG2_gsaZgA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-210edd8ec99so2454905ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2024 22:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181404; x=1730786204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JimEgNyg/QcjYbmrAbgjGEPCU6tyoQRskON0uAxULg=;
        b=R3/mW3MAwQgk6xscy3/IQgwisMSfWlbXxQkvX6+m31Efsqhpev3HQo8KyXFli8acB1
         kvCGo5RxYR0NAM0sa1J6dFVKTTTvLMpIR19mdU5+A8HGmO7QqwzH3QpfJ1Pq7+pBnC//
         RCZ6hy5QdOFapwt4NWDs6KHL4+9/ERiaNKzm0y8MV96NAPx+0JkCWUABVjDwAKLDUrHw
         HBzO7iL0csitCU+p/ap0vZieGtbYEfWpOpe4J081cV0oNXoM1HX0Gs1/PTXMMpQwzRaV
         gvgRuqM/xQfAfBaIHP20JD8+2IYsvo14PLcTLeTOdCrNdtK8zSpJ8Sv/2x+gcC2S5UnI
         SfFA==
X-Gm-Message-State: AOJu0Yx/n7bF3vVPWU9tWYpbmabyGEkdoXQfYoeGkOESV52150OWgb5x
	nL/WKKJ5jpV9pZ0nu27I5jjyL45TDe7hwdLTvQPFwXANrHKMGKUfJ9vTcWebHGf8bbs6inWrwQP
	oIt/g2y33QfmjSPMQGoiAR6WOjGIUi69wwV8aDfL2cAUBRF3ubUiIAMfjc6iY/X9R7lFoi2w=
X-Received: by 2002:a17:902:e751:b0:20b:db4:d913 with SMTP id d9443c01a7336-210ed3f11demr15943585ad.11.1730181403560;
        Mon, 28 Oct 2024 22:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLA7IAPR7iPmKWHmcqN3S4BagHq+bCwV+3g5vQyIfof5gqgg9aNjHESyIaX6dhRM+rPWHfeA==
X-Received: by 2002:a17:902:e751:b0:20b:db4:d913 with SMTP id d9443c01a7336-210ed3f11demr15943325ad.11.1730181403180;
        Mon, 28 Oct 2024 22:56:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf441dbsm59842985ad.34.2024.10.28.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:56:42 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:56:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/366: add a new test case to verify
 if certain fio load will hang the filesystem
Message-ID: <20241029055639.hskowarhtrowgiwe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028233525.30973-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028233525.30973-1-wqu@suse.com>

On Tue, Oct 29, 2024 at 10:05:25AM +1030, Qu Wenruo wrote:
> [BUG]
> During the development to make btrfs pass generic/563 (which needs to
> make btrfs to support partial folios), generic/095 causes hangs
> during tests.
> 
> The call trace for the hanging process looks like this:
> 
>   __switch_to+0xf8/0x168
>   __schedule+0x328/0x8a8
>   schedule+0x54/0x140
>   io_schedule+0x44/0x68
>   folio_wait_bit_common+0x198/0x3f8
>   __folio_lock+0x24/0x40
>   extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
>   btrfs_writepages+0x94/0x158 [btrfs]
>   do_writepages+0x74/0x190
>   filemap_fdatawrite_wbc+0x88/0xc8
>   __filemap_fdatawrite_range+0x6c/0xa8
>   filemap_fdatawrite_range+0x1c/0x30
>   btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
>   btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
>   __get_extent_map+0xa0/0x220 [btrfs]
>   btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
>   btrfs_read_folio+0x50/0xa0 [btrfs]
>   filemap_read_folio+0x54/0x110
>   filemap_update_page+0x2e0/0x3b8
>   filemap_get_pages+0x228/0x4d8
>   filemap_read+0x11c/0x3b8
>   btrfs_file_read_iter+0x74/0x90 [btrfs]
>   new_sync_read+0xd0/0x1d0
>   vfs_read+0x1a0/0x1f0
> 
> [CAUSE]
> The root cause is a btrfs specific behavior that during a folio read, we
> can trigger writeback of the same folio, which will try to lock the same
> folio already locked by the read process.
> 
> The fix is already sent to the mailing list:
> https://lore.kernel.org/linux-btrfs/62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com/
> 
> This problem can only happen if all the following conditions are met:
> 
> - The sector size of btrfs is smaller than page size
>   To have partial uptodate folios.
> 
> - Btrfs won't read the full folio if buffered write is block aligned
>   This is done by the not yet merged patch:
>   https://lore.kernel.org/linux-btrfs/ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com/
> 
> [TEST CASE]
> During the debugging of that generic/095 hang, I extracted a minimal
> reproducer which is much smaller and faster, although it still requires
> several runs to trigger a hang.
> 
> The test case will run the fio workload 32 times by default, which is
> more than enough to trigger the hang.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the duplicated _fixed_by_kernel_commit line
> - Fix a typo in the commit message
> - Update the comments to show the workload and how it hangs btrfs
> ---
>  tests/generic/366     | 106 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/366.out |   2 +
>  2 files changed, 108 insertions(+)
>  create mode 100755 tests/generic/366
>  create mode 100644 tests/generic/366.out
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> new file mode 100755
> index 00000000..9d31c1c8
> --- /dev/null
> +++ b/tests/generic/366
> @@ -0,0 +1,106 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 366
> +#
> +# Test if mixed direct read, direct write and buffered write on the same file will
> +# hang the filesystem.
> +#
> +# This is exposed by an incoming btrfs feature, which allows a folio to be
> +# partial uptodate if the buffered write range is block aligned but not yet
> +# full folio aligned.
> +#
> +# Such behavior makes btrfs to hang reliably under generic/095.
> +# This is the extracted minimal reproducer for 4k block size and 64K page size.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
                            ^^
                            rw

I think we can keep the "rw" group as g/095 does.

> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_odirect
> +_require_aio
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: avoid deadlock when reading a partial uptodate folio"
> +
> +iterations=$((32 * LOAD_FACTOR))
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +cat >$fio_config <<EOF
> +[global]
> +bs=8k
> +iodepth=1
> +randrepeat=1
> +size=256k
> +directory=$SCRATCH_MNT
> +numjobs=1
> +[job1]
> +ioengine=sync
> +bs=512
> +direct=1
> +rw=randread
> +filename=file1
> +[job2]
> +ioengine=libaio
> +rw=randwrite
> +direct=1
> +filename=file1
> +[job3]
> +ioengine=posixaio
> +rw=randwrite
> +filename=file1
> +EOF
> +_require_fio $fio_config
> +
> +for (( i = 0; i < $iterations; i++)); do
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +	# There's a known EIO failure to report collisions between directio and buffered
> +	# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> +	# at here.
> +	#
> +	# And for btrfs if sector size < page size, if we have a partial
> +	# uptodate folio caused by a buffered write, e.g:
> +	#
> +	#    0          16K         32K          48K         64K
> +	#    |                                   |///////////|
> +	#					     \- sector Uptodate|Dirty
> +	#
> +	# Then writeback happens and finished, but btrfs' ordered extent not
> +	# yet finished.
> +	# In that case, the folio can be released from the page cache (since
> +	# the folio is not under IO/lock).
> +	#
> +	# Then new buffered writes into the folio happened, re-dirty the folio:
> +	#   0          16K         32K          48K         64K
> +	#   |//////////|                        |///////////|
> +	#      \- sector Uptodate|Dirty              \- No sector flags
> +	#                                               extent map PINNED
> +	#                                               OE still here
> +	#
> +	# Now read is triggered on that folio.
> +	# Btrfs will need to wait for any existing ordered extents in the folio range,
> +	# that wait will also trigger writeback if the folio is dirty.
> +	# That writeback will happen for range [48K, 64K), but since the whole folio
> +	# is locked for read, writeback will also try to lock the same folio, causing
> +	# a deadlock.
> +	$FIO_PROG $fio_config --ignore_error=,EIO --output=$fio_out

Looks like this test doesn't mix DIO and buffered IO, so this EIO ignoring might not be
needed.

> +	# umount before checking dmesg in case umount triggers any WARNING or Oops
> +	_scratch_unmount
> +
> +	_check_dmesg _filter_aiodio_dmesg

This test removed mmap test part, so this dmesg filter might not be needed either ?
If so, don't need to import above "./common/filter" either.

Others looks good to me.

Thanks,
Zorro

> +
> +	echo "=== fio $i/$iterations ===" >> $seqres.full
> +	cat $fio_out >> $seqres.full
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/366.out b/tests/generic/366.out
> new file mode 100644
> index 00000000..1fe90e06
> --- /dev/null
> +++ b/tests/generic/366.out
> @@ -0,0 +1,2 @@
> +QA output created by 366
> +Silence is golden
> -- 
> 2.46.0
> 
> 


