Return-Path: <linux-btrfs+bounces-3869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46394896DFB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA04A281D05
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB8142E7C;
	Wed,  3 Apr 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug9PMAPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F11420C4
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143260; cv=none; b=ERwd5Hw/RYVxuxvGZsB/Y4BqVpspnx+vbgThpJJqXbdmLeXDYMi+/uKBcUTI0cMR6qnBHNLrQaoOJUfeSqdRRvBnTQFGq2FessvQpxBCzAyLq36LgMEaM2fd30l6WaN2VXRZa5jRVyi+/P8ytgMS70Whz733lRRo0/wVnLRxKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143260; c=relaxed/simple;
	bh=SxuRDEE43AmdGAHjZ75XhPtG49iOqobU9JdG396+J6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTY+YMvZuQwonYyjYp2SilM/0PLJl0o02Omsk03UJgTWyj1NDAixSUisi/O9nJc62Ept2x3f6AMazbsmK/w1hIml+E/8TjzxotitLl2rtG4cbApER+PSE/nGSPYcaNbbEovc7D8aqrxfaqtqU/Oa7EebcF3DdpMuSTDrLSvl4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug9PMAPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712143257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KREh2dqyEacrAl+2F5FOzFyXaUiu2kZA6fO1nkDtqNU=;
	b=Ug9PMAPCLfKf1Dkq/XYeA+MXqKxWtAOi2FD5vywqVql88fhnyVviijY6u3F9mgEZa/mu0t
	5CiJhZWsJ1YpPYSna++wB7X9h8LBkDI/2e8lnRlxQSbvaaSyHYdvcPI6n8hTRmvsbaG9vS
	vNGFhu5LcIbmQwB8TqjtnraqSrHxiDM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-GzIh6IZEN1y-4ygRm1PFkQ-1; Wed, 03 Apr 2024 07:20:56 -0400
X-MC-Unique: GzIh6IZEN1y-4ygRm1PFkQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dbddee3694so518910a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 04:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712143255; x=1712748055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KREh2dqyEacrAl+2F5FOzFyXaUiu2kZA6fO1nkDtqNU=;
        b=sU2CPOm5aWkc+wNm9wavHjG9ckVGmqWO8q4jWfHBgUi9a6H7xfNsuhbqJbuoCVl0z2
         kh1LFPvcDodCaYOqf9Ntpt4wpBj6kbTFehr96l9vnWnZdRE7Td66PpHo3H1RNvO/c9CZ
         EPC/vT7vkRshmt7+GcyKDcOpe6jZ9gctMYk7RB1lWOlepuJ9vjaynJVtPFEMSJC5Jxqe
         kPqCDWNZqFrPOtYSsLmIWAQv35JOO4NOzYasSW5r7ZDttEoRibty+94UiQtGETYSr8Rl
         lVTXgXgXxAprDK3PnUpBFk1EmghlC5vrBJWimDEyHkq88THsZ24dbaEwF1dWH02lwAvg
         jfQw==
X-Gm-Message-State: AOJu0Yzxa+MEZq3eDO3VQzNQrvPsOJTK8hrSNScwtGlzYiQbx4osQrEo
	x6MA05UkynfMdWbrnrW4nC9ny6M6J3NM0xXQQhyDTzfYBSFg+zUfQcrNZM3c42Vl9cyra1q3ZFh
	ZzIuR0IeWVjX0tfR4zAYuLcKE8S61CCLD8N8nVepqxV8RB+49QI+2p3SWAI06IFJlP+yOBt3Pxg
	==
X-Received: by 2002:a17:902:ea09:b0:1e2:8f1d:6f98 with SMTP id s9-20020a170902ea0900b001e28f1d6f98mr2224685plg.31.1712143254771;
        Wed, 03 Apr 2024 04:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaOEmBmMO4HQwCpLtzg464+JVCd3k1I2apvUuiFMsuclmBoHgJPn7rIicEfuJxTiAyZe4Ffw==
X-Received: by 2002:a17:902:ea09:b0:1e2:8f1d:6f98 with SMTP id s9-20020a170902ea0900b001e28f1d6f98mr2224661plg.31.1712143254239;
        Wed, 03 Apr 2024 04:20:54 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001e088a9e2bcsm12931736plt.292.2024.04.03.04.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:20:53 -0700 (PDT)
Date: Wed, 3 Apr 2024 19:20:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: new test for devt change between mounts
Message-ID: <20240403112049.awm3kvsl2zeukjvr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ab39a4385d586a0b82dafdec73f625cf434fe026.1710184289.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab39a4385d586a0b82dafdec73f625cf434fe026.1710184289.git.boris@bur.io>

On Mon, Mar 11, 2024 at 12:13:44PM -0700, Boris Burkov wrote:
> It is possible to confuse the btrfs device cache (fs_devices) by
> starting with a multi-device filesystem, then removing and re-adding a
> device in a way which changes its dev_t while the filesystem is
> unmounted. After this procedure, if we remount, then we are in a funny
> state where struct btrfs_device's "devt" field does not match the bd_dev
> of the "bdev" field. I would say this is bad enough, as we have violated
> a pretty clear invariant.
> 
> But for style points, we can then remove the extra device from the fs,
> making it a single device fs, which enables the "temp_fsid" feature,
> which permits multiple separate mounts of different devices with the
> same fsid. Since btrfs is confused and *thinks* there are different
> devices (based on device->devt), it allows a second redundant mount of
> the same device (not a bind mount!). This then allows us to corrupt the
> original mount by doing stuff to the one that should be a bind mount.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v4:
> - add tempfsid group
> - remove fail check on mount command
> - btrfs/311 -> btrfs/318
> - add fixed_by annotation
> v3:
> - fstests convention improvements (helpers, output, comments, etc...)
> v2:
> - fix numerous fundamental issues, v1 wasn't really ready
> 
>  common/config       |   1 +
>  tests/btrfs/318     | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/318.out |   2 +
>  3 files changed, 111 insertions(+)
>  create mode 100755 tests/btrfs/318
>  create mode 100644 tests/btrfs/318.out
> 
> diff --git a/common/config b/common/config
> index 2a1434bb1..d8a4508f4 100644
> --- a/common/config
> +++ b/common/config
> @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
>  export GZIP_PROG="$(type -P gzip)"
>  export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
>  export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> +export PARTED_PROG="$(type -P parted)"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/btrfs/318 b/tests/btrfs/318
> new file mode 100755
> index 000000000..796f09d13
> --- /dev/null
> +++ b/tests/btrfs/318
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> +#
> +# FS QA Test 318
> +#
> +# Test an edge case of multi device volume management in btrfs.
> +# If a device changes devt between mounts of a multi device fs, we can trick
> +# btrfs into mounting the same device twice fully (not as a bind mount). From
> +# there, it is trivial to induce corruption.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume scrub tempfsid
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: validate device maj:min during open"
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_command "$PARTED_PROG" parted
> +_require_batched_discard "$TEST_DIR"
> +
> +_cleanup() {
> +	cd /
> +	$UMOUNT_PROG $MNT
> +	$UMOUNT_PROG $BIND
> +	losetup -d $DEV0
> +	losetup -d $DEV1
> +	losetup -d $DEV2
> +	rm $IMG0
> +	rm $IMG1
> +	rm $IMG2

losetup -d $DEV0 $DEV1 $DEV2
rm -f $IMG0 $IMG1 $IMG2

> +}
> +
> +IMG0=$TEST_DIR/$$.img0
> +IMG1=$TEST_DIR/$$.img1
> +IMG2=$TEST_DIR/$$.img2
> +truncate -s 1G $IMG0
> +truncate -s 1G $IMG1
> +truncate -s 1G $IMG2
> +DEV0=$(losetup -f $IMG0 --show)
> +DEV1=$(losetup -f $IMG1 --show)
> +DEV2=$(losetup -f $IMG2 --show)

_create_loop_device ?



> +D0P1=$DEV0"p1"
> +D1P1=$DEV1"p1"
> +MNT=$TEST_DIR/mnt
> +BIND=$TEST_DIR/bind

Not sure if these two directories will be taken, better to remove
them at first. And use "$seq" (or others) to be a prefix or suffix,
e.g.

  $TEST_DIR/mnt-${seq}

Others look good to me.

Thanks,
Zorro


> +
> +# Setup partition table with one partition on each device.
> +$PARTED_PROG $DEV0 'mktable gpt' --script
> +$PARTED_PROG $DEV1 'mktable gpt' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +
> +# mkfs with two devices to avoid clearing devices on close
> +# single raid to allow removing DEV2.
> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 || _fail "failed to mkfs.btrfs"
> +
> +# Cycle mount the two device fs to populate both devices into the
> +# stale device cache.
> +mkdir -p $MNT
> +_mount $D0P1 $MNT
> +$UMOUNT_PROG $MNT
> +
> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
> +$PARTED_PROG $DEV0 'rm 1' --script
> +$PARTED_PROG $DEV1 'rm 1' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +
> +# Mount with mismatched dev_t!
> +_mount $D0P1 $MNT
> +
> +# Remove the extra device to bring temp-fsid back in the fray.
> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> +
> +# Create the would be bind mount.
> +mkdir -p $BIND
> +_mount $D0P1 $BIND
> +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
> +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
> +# If they're different, we are in trouble.
> +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
> +
> +# Now really prove it by corrupting the first mount with the second.
> +for i in $(seq 20); do
> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
> +done
> +for i in $(seq 20); do
> +	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&1
> +done
> +
> +# sync so that we really write the large file data out to the shared device
> +sync
> +
> +# now delete from one view of the shared device
> +find $BIND -type f -delete
> +# sync so that fstrim definitely has deleted data to trim
> +sync
> +# This should blow up both mounts, if the writes somehow didn't overlap at all.
> +$FSTRIM_PROG $BIND
> +# drop caches to improve the odds we read from the corrupted device while scrubbing.
> +echo 3 > /proc/sys/vm/drop_caches
> +$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/318.out b/tests/btrfs/318.out
> new file mode 100644
> index 000000000..2798c4ba7
> --- /dev/null
> +++ b/tests/btrfs/318.out
> @@ -0,0 +1,2 @@
> +QA output created by 318
> +Error summary:    no errors found
> -- 
> 2.43.0
> 
> 


