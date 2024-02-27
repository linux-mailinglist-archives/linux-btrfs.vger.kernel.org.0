Return-Path: <linux-btrfs+bounces-2840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A586916F
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 14:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C41F29B83
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A3B13B281;
	Tue, 27 Feb 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXBxpKDd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88C1EB25
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039553; cv=none; b=GfzFZ9btbfkVC45xJtt3OgZ6XRx5RbcjAwxkfWR4EZhs4PbhJvPeOwkDLra1g077wl77ImGymyYz3tikYMRxArHh582mLZ6zRcxz7LUhWMLoeSF3HU4UaSXBFryg1yGnioEhZeH4fTow96MRYr5IVjWbNNfSMWN6V0bg/SXyFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039553; c=relaxed/simple;
	bh=bIPdvg+UuXBoha7GoXLPqyt49LgbAAd8mx33ApAJuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHdy+tu/WYe6/M6KeBuqy/k0vKfMyxmmQOpN+079Q5SnIWfEPrFiH2UWA7uwgX7iETNOV+ZySzDryiO9wcbug/8W3wBOwy/dYoMCLX98bM5AO6zIFp11zaeEgNSS3ZB/yE4nFbPisdrufk9KHodLF+UjuOpLw5jvlPZUm5l+8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HXBxpKDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709039550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OKqmPSh/37mZU0ZdzSlxg5+yizg6CX4lNnCMMmD3N4=;
	b=HXBxpKDdC2mqkGt5ouSHxqXfy/QT13mgRsRhYtmFvGJZHuke+Gnt1u+Afem2L/qwIICg1S
	onACt1VmBzgK6f9VX+8rDgxvvu0Ge62oHLNp1AERI0jJGHTQVSvqqRbw8LEavfCc4mhKmo
	BmgwnPUka817mE4gIgIOJ3+CRHJ/ruE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KVHHp9PXNjWRY58noWB2Sw-1; Tue, 27 Feb 2024 08:12:29 -0500
X-MC-Unique: KVHHp9PXNjWRY58noWB2Sw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c66a69ec8eso3264783a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 05:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039548; x=1709644348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OKqmPSh/37mZU0ZdzSlxg5+yizg6CX4lNnCMMmD3N4=;
        b=ZXJ1FcZrjg/ju6p4RwvRso/kZwAuFPEV8pjgBE/2028z4xhEa6lyE+CYPAC51ee14g
         vZmHewlRtiZXuONuXnk9KAelCQORAzc5XQX+nzJnYHpaW6FZ60RKaw0Z1vDqCTiWUns9
         wYZEZmWj0R2F7B0exYFRuDumzlX76Os18fpXa4Oi4kPtX72gprFqTq/H8n3ef2OTMw4Y
         HJlux0Q5DsYpNqcpnFWImEis3lWujIV990BEw1kdVj++ADeJ3PBkE3OUHFUX3OuEUysZ
         A+7EpmpMw2r6kAT0SB5GwEL86B8VPvDE9jXgXZvBlf9ndTdTttfko+MpOvfftBnR9FpQ
         I9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV0pta5aqZx84QrdAHVUvlX2SADo07eoMkryYJGLOYblWYyKo1hZH3Q8vZJ9c50WO/9psGBvew8quK7+a6ieazH1BU8bzzqgqYW1rc=
X-Gm-Message-State: AOJu0YwO6hjW3xG7Lyuh05NHLe+TQtDMIov79iJ5A7SUgw4gQqBUaZ70
	XAfaZ78nckymquvFACeP/w5zIXDqSjYEVgC5oAkUNOYJGH/n/lhHc775gWrMLbG0s2C628Id/Us
	KvyVAQQgbCpjWAiG4SOdzBmDEUS5zlG31u3FcTZf5ttv6mT5PAQ3Qw7Dfgk3/
X-Received: by 2002:a05:6a21:2d8c:b0:1a0:d240:c77d with SMTP id ty12-20020a056a212d8c00b001a0d240c77dmr2113111pzb.17.1709039548189;
        Tue, 27 Feb 2024 05:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtU2Ij5dNEbdxnNpv6yoTwy62ox0er1qhHOXSZkYUJRQQZOWaknwnJiS9l/fjz4r7TV9+5Aw==
X-Received: by 2002:a05:6a21:2d8c:b0:1a0:d240:c77d with SMTP id ty12-20020a056a212d8c00b001a0d240c77dmr2113103pzb.17.1709039547922;
        Tue, 27 Feb 2024 05:12:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k62-20020a632441000000b005dc3fc53f19sm5793896pgk.7.2024.02.27.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:12:27 -0800 (PST)
Date: Tue, 27 Feb 2024 21:12:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, fdmanana@suse.com
Subject: Re: [PATCH v3 3/3] fstests: btrfs: check conversion of zoned
 fileystems
Message-ID: <20240227131223.ghlqtl5oyylhs6ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>

On Thu, Feb 15, 2024 at 03:47:06AM -0800, Johannes Thumshirn wrote:
> Recently we had a bug where a zoned filesystem could be converted to a
> higher data redundancy profile than supported.
> 
> Add a test-case to check the conversion on zoned filesystems.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out | 12 ++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000000..c39f60168f8a
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Test that btrfs convert can ony be run to convert to supported profiles on a
> +# zoned filesystem
> +#
> +. ./common/preamble
> +_begin_fstest volume raid convert

Don't you want to add it in "auto" group, to be a default test?

> +
> +_fixed_by_kernel_commit XXXXXXXXXX \
> +	"btrfs: zoned: don't skip block group profile checks on conv zones"
> +
> +. common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_require_zoned_device "$SCRATCH_DEV"

OK, looks like don't need to check each devices of SCRATCH_DEV_POOL at here :)

> +
> +devs=( $SCRATCH_DEV_POOL )
> +
> +# Create and mount single device FS
> +_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null

Mkfs with specific options might fail, so better to _fail if mkfs return non-zero,
and better to output the message into .full file, to know what's wrong.

Thanks,
Zorro

> +_scratch_mount
> +
> +# Convert FS to metadata/system DUP
> +_run_btrfs_balance_start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert
> +
> +# Convert FS to data DUP, must fail
> +_run_btrfs_balance_start -dconvert=dup $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID1, must fail
> +_run_btrfs_balance_start -dconvert=raid1 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Convert FS to data RAID0, must fail
> +_run_btrfs_balance_start -dconvert=raid0 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID5, must fail
> +_run_btrfs_balance_start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID10, must fail
> +_run_btrfs_balance_start -dconvert=raid10 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Convert FS to data RAID6, must fail
> +_run_btrfs_balance_start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 000000000000..bc06b29ecf10
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,12 @@
> +QA output created by 310
> +Done, had to relocate X out of X chunks
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> 
> -- 
> 2.43.0
> 


