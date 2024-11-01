Return-Path: <linux-btrfs+bounces-9298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B244A9B9162
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 13:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C0D1C211D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED981E481;
	Fri,  1 Nov 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+P9uZ5e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC51DA53
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Nov 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465730; cv=none; b=jXuICKikhrWTJaGyYVfG747aftITN9LxA3eaVLdzEow8id1yFiePCjWw2RN3o9RFcQoLwx3y9N9eJW+bNn9LsXzbC9aMo5xvHNXJyqHwP1K4pCJr9akBLGhBLzecB5h4L7CQ7bhd1ZSprXLNcRK+WX1FbYfsFotrckDkicvO71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465730; c=relaxed/simple;
	bh=Og60fUewID3JqGXkxO99b3SLmd2b4aUZa7Vdu4YG1z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy4piS9pe400DBwHbf9EO6+yRUytNRQcXzmRAaIGwSeeDVPwmgMs/nVlHBgKIS9MS6Zw2iYoKfkFzBcvgfzPF/Mc6bty6HtW5GvE50ORgvkh/SPhTMHvrbHT9hq2QCxR9IDsgMJ8lfy4NbjRKNzzIGBEZgubPb5SQkxoqGn1HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+P9uZ5e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730465725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rzMZQyyhDyJEGUdNq6pWu+UwjVQehzNGlGjlXEGffE=;
	b=C+P9uZ5ejh1XyTYRR3K5519ZuX1AsktloXlhqnNFFQnNEqF0wP3Md5u0dI0nJT9xoRdNkb
	Dw6M49MzGPvLOsN+8taMK5b9K9UXT/U3l6CW7ZWzUTbkacWKApj8TSr0IYrGBVRG7dI9ph
	S79NL/Ya0jUNSbTxpXfsT+r2g8E1zmM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-E_m4EdVhM9GlM0xDKComtQ-1; Fri, 01 Nov 2024 08:55:24 -0400
X-MC-Unique: E_m4EdVhM9GlM0xDKComtQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e4fa3eaafso2279590b3a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Nov 2024 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730465723; x=1731070523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rzMZQyyhDyJEGUdNq6pWu+UwjVQehzNGlGjlXEGffE=;
        b=Jm7VdMTLxg31tuxAhE45xBcZ0hgb2aGZUCgdd6Fu60oeBQhcgEeDgCr+SrgWNsS43d
         twO/fhm3LSbrYWqIS1+2cYzZQTemtDWFyoVBvVdQoyauwju4auEG7VFL0DxF2bC+r9wc
         pHH/Ea9aFnsMqp6oTEq+ZO2GqwpRozH/7zX1j18jOCfgqdYeAGgll3JHJlizltr4Rchu
         OfkjQiDSIh9aGmWome4qPm0iKxB/pNu1dg+O+dtVFrPs5/fAGyno5ynMMCVBWyIL/Jcv
         zWJg77O5OuWMNw27r6rZZOh0jUz1tbniKJTZwyndJGx7wSjSovFGJGh7XxYav6zdA3cu
         wnIw==
X-Gm-Message-State: AOJu0YzbPpFZgZheAmhednEeXbMC3bFYkAb/wsAFgZjEqOFILTfZv7xD
	HcmJ/TnNSp8DadjjwTUGF6aT441nkJxl5btgPfEO90+zhACR2usIiyp5YTgndn3RlmHnoVl++yI
	IbIKPaxglwr46cEFrh/kZRfGVBf1EjSUJcUACkM2b95CDXGN+AD8I/tEXCgGb
X-Received: by 2002:a05:6a00:1797:b0:71e:3eed:95c9 with SMTP id d2e1a72fcca58-720c99b6257mr4800871b3a.22.1730465722963;
        Fri, 01 Nov 2024 05:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPTD6w6ecP2Sh/66+1BJZGUJWw3/GbMVycPHtDhBagdlpC63+4HN7Rg/ZW9xAayfI5ifZG6Q==
X-Received: by 2002:a05:6a00:1797:b0:71e:3eed:95c9 with SMTP id d2e1a72fcca58-720c99b6257mr4800842b3a.22.1730465722489;
        Fri, 01 Nov 2024 05:55:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c7ef1sm2537527b3a.103.2024.11.01.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 05:55:22 -0700 (PDT)
Date: Fri, 1 Nov 2024 20:55:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: a new test case to verify mount behavior with
 background remounting
Message-ID: <20241101125517.kb7akqvi5tae3wor@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241101102956.174733-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101102956.174733-1-wqu@suse.com>

On Fri, Nov 01, 2024 at 08:59:56PM +1030, Qu Wenruo wrote:
> [BUG]
> When there is a process in the background remounting a btrfs, switching
> between RO/RW, then another process try to mount another subvolume of
> the same btrfs read-only, we can hit a race causing the RW mount to fail
> with -EBUSY:
> 
> [CAUSE]
> During the btrfs mount, to support mounting different subvolumes with
> different RO/RW flags, we have a small hack during the mount:
> 
>   Retry with matching RO flags if the initial mount fail with -EBUSY.
> 
> The problem is, during that retry we do not hold any super block lock
> (s_umount), this meanings there can be a remount process changing the RO
> flags of the original fs super block.
> 
> If so, we can have an EBUSY error during retry.
> And this time we treat any failure as an error, without any retry and
> cause the above EBUSY mount failure.
> 
> [FIX]
> The fix is already sent to the mailing list.
> The fix is to allow btrfs to have different RO flag between super block
> and mount point during mount, and if the RO flag mismatch, reconfigure
> the fs to RW with s_umount hold, so that there will be no race.
> 
> [TEST CASE]
> The test case will create two processes:
> 
> - Remounting an existing subvolume mount point
>   Switching between RO and RW
> 
> - Mounting another subvolume RW
>   After a successful mount, unmount and retry.
> 
> This is enough to trigger the -EBUSY error in less than 5 seconds.
> To be extra safe, the test case will run for 10 seconds at least, and
> follow TIME_FACTOR for extra loads.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Better signal handling for both remount and mount workload
>   Need to do the extra handling for both workload
> 
> - Wait for any child process to exit before cleanup
> 
> - Keep the stderr of the final rm command
> 
> - Keep the stderr of the unmount of $subv1_mount
>   Which should always be mounted.
> 
> - Use "$UMOUNT_PROG" instead of direct "umount"
> 
> - Use "_mount" instead of direct "mount"
> 
> - Fix a typo of "block"
> ---

Thanks for this new case. A few of picky review points below :)

>  tests/btrfs/325     | 99 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/325.out |  2 +
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/325
>  create mode 100644 tests/btrfs/325.out
> 
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..ffa10c61
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,99 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 325
> +#
> +# Test that mounting a subvolume read-write will success, with another
> +# subvolume being remounted RO/RW at background
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount remount
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix mount failure due to remount races"
> +
> +_cleanup()
> +{
> +	cd /

rm -r -f $tmp.*

> +	kill "$remount_pid" "$mount_pid" &> /dev/null

With below "unset" (see below), we can:

[ -n "$mount_pid" ] && kill $mount_pid
[ -n "$remount_pid" ] && kill $remount_pid

> +	wait &> /dev/null

Just curious, what can cause "wait" command print something?

> +	$UMOUNT_PROG "$subv1_mount" &> /dev/null
> +	$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +	rm -rf -- "$subv1_mount" &> /dev/null
> +	rm -rf -- "$subv2_mount" &> /dev/null

rm "-f" prints nothing, so

rm -rf -- "$subv1_mount" "$subv2_mount"

> +}
> +
> +# For the extra mount points
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full

Hmm... I wondering what'll happen, if remove these two lines then run this test
on other filesystems :)

> +_scratch_unmount
> +
> +subv1_mount="$TEST_DIR/subvol1_mount"
> +subv2_mount="$TEST_DIR/subvol2_mount"

Better to try to remove them at first. We can't make sure these names never
be existed in $TEST_DIR.

> +mkdir -p "$subv1_mount"
> +mkdir -p "$subv2_mount"
> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=subvol1
> +
> +# Subv1 remount workload, mount the subv1 and switching it between
> +# RO and RW.
> +remount_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	while true; do
> +		_mount -o remount,ro "$subv1_mount"
> +		_mount -o remount,rw "$subv1_mount"
> +	done
> +}
> +
> +remount_workload &
> +remount_pid=$!
> +
> +# Subv2 rw mount workload
> +# For unpatched kernel, this will fail with -EBUSY.
> +#
> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
> +# then reconfigure the fs to RW.
> +#
> +# But such retry has no super block lock hold, thus if another remount
> +# process has already remounted the fs RW, the attempt will fail and
> +# return -EBUSY.
> +#
> +# Patched kernel will allow the superblock and mount point RO flags
> +# to differ, and then hold the s_umount to reconfigure the super block
> +# to RW, preventing any possible race.
> +mount_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	while true; do
> +		_mount "$SCRATCH_DEV" "$subv2_mount"
> +		$UMOUNT_PROG "$subv2_mount"
> +	done
> +}
> +
> +mount_workload &
> +mount_pid=$!
> +
> +sleep $(( 10 * $TIME_FACTOR ))
> +
> +kill "$remount_pid" "$mount_pid"
> +wait

unset remount_pid mount_pid

to avoid later kill (in _cleanup) kill other processes.

> +
> +# subv1 is always mounted, thus the umount should not fail.
> +$UMOUNT_PROG "$subv1_mount"
> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +
> +rm -rf -- "$subv1_mount" "$subv2_mount"

Do this in _cleanup (as above), so this line can be removed if it's not a
necessary test step of this case.

Others look good to me.

Thanks,
Zorro

> +
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> new file mode 100644
> index 00000000..cf13795c
> --- /dev/null
> +++ b/tests/btrfs/325.out
> @@ -0,0 +1,2 @@
> +QA output created by 325
> +Silence is golden
> -- 
> 2.46.0
> 
> 


