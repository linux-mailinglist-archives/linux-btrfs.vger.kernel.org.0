Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F89847A0C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 15:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhLSOCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 09:02:33 -0500
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:57975 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhLSOCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 09:02:33 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436549|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0276295-0.00761075-0.96476;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.MJa-Hox_1639922550;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MJa-Hox_1639922550)
          by smtp.aliyun-inc.com(10.147.41.158);
          Sun, 19 Dec 2021 22:02:31 +0800
Date:   Sun, 19 Dec 2021 22:02:30 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [PATCH v2] btrfs/254: test cleaning up of the stale device
Message-ID: <Yb87dkizAxoqC+1c@desktop>
References: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61c0bd3a345d8cb64f1117da58c63c2cd08a8a2c.1639156699.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 11, 2021 at 02:14:41AM +0800, Anand Jain wrote:
> Recreating a new filesystem or adding a device to a mounted the filesystem
> should remove the device entries under its previous fsid even when
> confused with different device paths to the same device.
> 
> Fixed by the kernel patch (in the ml):
>   btrfs: harden identification of the stale device
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I was testing with v5.16-rc2 kernel, which should not contain the kernel
fix, but test still passed for me, I was testing with three loop devices
as SCRATCH_DEV_POOL, and all default mkfs & mount options

SECTION       -- btrfs                         
RECREATING    -- btrfs on /dev/mapper/testvg-lv1                                                                                         
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 fedoravm 5.16.0-rc2 #22 SMP PREEMPT Mon Nov 29 00:54:26 CST 2021
MKFS_OPTIONS  -- /dev/loop0                    
MOUNT_OPTIONS -- /dev/loop0 /mnt/scratch                      
                                                                    
btrfs/254 5s ...  5s
Ran: btrfs/254                                         
Passed all 1 tests

Anything wrong with my setup?

And if tested with lv devices as SCRATCH_DEV_POOL

SCRATCH_DEV_POOL="/dev/mapper/testvg-lv2 /dev/mapper/testvg-lv3 /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5 /dev/mapper/testvg-lv6"

I got the following test failure

 QA output created by 254
+ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory
 Label: none  uuid: <UUID>
        Total devices <NUM> FS bytes used <SIZE>
        devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV

Maybe we should use _require_scratch_nolvm as well?

> ---
> v2: Add kernel patch title in the test case
>     Redirect device add output to /dev/null (avoids tirm message)
>     Use the lv path for mkfs and the dm path for the device add
>      so that now path used in udev scan should match with what
>      we already have in the kernel memory.
> 
> -       _mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
> +       _mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
>  
>         # Add device should free the device under $uuid in the kernel.
> -       $BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt > /dev/null 2>&1
> +       $BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
> 
> 
>  tests/btrfs/254     | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/254.out |   6 +++
>  2 files changed, 119 insertions(+)
>  create mode 100755 tests/btrfs/254
>  create mode 100644 tests/btrfs/254.out
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> new file mode 100755
> index 000000000000..b70b9d165897
> --- /dev/null
> +++ b/tests/btrfs/254
> @@ -0,0 +1,113 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
> +# Copyright (c) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test No. 254
> +#
> +# Test if the kernel can free the stale device entries.
> +#
> +# Tests bug fixed by the kernel patch:
> +#	btrfs: harden identification of the stale device
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +node=$seq-test
> +cleanup_dmdev()
> +{
> +	_dmsetup_remove $node
> +}
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -rf $seq_mnt > /dev/null 2>&1
> +	cleanup_dmdev

Should wipefs in cleanup as well, otherwise test fails with non-unique
UUID

-Label: none  uuid: <UUID>                                                                                                                                                                                                                                                        
-       Total devices <NUM> FS bytes used <SIZE>                                                                                                                                                                                                                                  
-       devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
-       *** Some devices missing                                                                                                         
+ERROR: non-unique UUID: 12345678-1234-1234-1234-123456789abc
+btrfs-progs v5.4 
+See http://btrfs.wiki.kernel.org for more information.

Thanks,
Eryu

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +_require_block_device $SCRATCH_DEV
> +_require_dm_target linear
> +_require_btrfs_forget_or_module_loadable
> +_require_scratch_nocheck
> +_require_command "$WIPEFS_PROG" wipefs
> +
> +_scratch_dev_pool_get 3
> +
> +setup_dmdev()
> +{
> +	# Some small size.
> +	size=$((1024 * 1024 * 1024))
> +	size_in_sector=$((size / 512))
> +
> +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
> +	_dmsetup_create $node --table "$table" || \
> +		_fail "setup dm device failed"
> +}
> +
> +# Use a known it is much easier to debug.
> +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
> +lvdev=/dev/mapper/$node
> +
> +seq_mnt=$TEST_DIR/$seq.mnt
> +mkdir -p $seq_mnt
> +
> +test_forget()
> +{
> +	setup_dmdev
> +	dmdev=$(realpath $lvdev)
> +
> +	_mkfs_dev $uuid $dmdev
> +
> +	# Check if we can un-scan using the mapper device path.
> +	$BTRFS_UTIL_PROG device scan --forget $lvdev
> +
> +	# Cleanup
> +	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
> +	$BTRFS_UTIL_PROG device scan --forget
> +
> +	cleanup_dmdev
> +}
> +
> +test_add_device()
> +{
> +	setup_dmdev
> +	dmdev=$(realpath $lvdev)
> +	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
> +
> +	_mkfs_dev $scratch_dev3
> +	_mount $scratch_dev3 $seq_mnt
> +
> +	_mkfs_dev $uuid -draid1 -mraid1 $lvdev $scratch_dev2
> +
> +	# Add device should free the device under $uuid in the kernel.
> +	$BTRFS_UTIL_PROG device add -f $dmdev $seq_mnt > /dev/null 2>&1
> +
> +	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
> +
> +	# Check if the missing device is shown.
> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> +					_filter_btrfs_filesystem_show
> +
> +	$UMOUNT_PROG $seq_mnt
> +	_scratch_unmount
> +	cleanup_dmdev
> +}
> +
> +test_forget
> +test_add_device
> +
> +_scratch_dev_pool_put
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
> new file mode 100644
> index 000000000000..20819cf5140c
> --- /dev/null
> +++ b/tests/btrfs/254.out
> @@ -0,0 +1,6 @@
> +QA output created by 254
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +	*** Some devices missing
> +
> -- 
> 2.27.0
