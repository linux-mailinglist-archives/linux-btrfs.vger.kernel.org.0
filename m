Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4844F46D613
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 15:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhLHOxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhLHOxn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 09:53:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7825C0617A1
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Dec 2021 06:50:11 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id w14so2149290qkf.5
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Dec 2021 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uNoX3fEP/IMxmYMdv+lOHtwwYM6RNmuVfr/n4R24q7g=;
        b=6jhpjP+ogTftGsSSHRPtKhvT8yotpA0lKoWElupVZnL0cOGzrfAN62xna0EkL6UPWY
         LMY7AqEKKLUbUvSsdQFsWr+EKYyFkqhcu+bUIxFnPP5JSxKJ1x1+1VZkAncMtiS4MiQR
         0D4GkbIIa2ur1eM7WhgzTG/TJvq+GoUMCw0c1+cRGEfEzgNppcoxwiSfW0GWo22B6Rd8
         6IQCnWXAXgEoZ9vWw3097Dhez6dnryrhJzhsn/75+JRaVyL1rfpr+d38rkk0YQ9LxVhP
         T/wwDEe5qKRn5NNHLr8DCVXuD3v/rGQVJaBmYqD/LMa9/I4A9QXgFL3Nn7Ibx8l+TODM
         aTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNoX3fEP/IMxmYMdv+lOHtwwYM6RNmuVfr/n4R24q7g=;
        b=nVWirUnTofH6+Ae4rWzmxH/XiX3gy02T8oHmPqkDBK/O4lGWk7LbcpqKFc5jEMBuOT
         eV77nR1tj1e6Q8pkHf3V2beMUnDlfVmo/UelmUVl5v2vDvMtMB58WoM35eefKpNPLPCY
         vo3iHtK9QHDTX9eSFyn42geuOG+kfRW/RMm5MaR3Fy26kSmQaFtBH17Y71u1HPso19Y4
         CT5iOtLbUVo6lHlQ32oITjjbyjI5N+gsmqVmff3gmv3vUjdLnQTA9efSasE/+c5/IwMG
         KOWK2lqplm2Bik6q+fwnNkCyJyCu4VrwIsLVQUtmtYLedY7mSruKC4+t8XKuwzUYz2qF
         z96Q==
X-Gm-Message-State: AOAM532GkELkxgMlsp8GBTKg1SXUgO3O79MKJ4dZR1Ip/MarTcYq0g2p
        aiMyqHthvGCAZezhewiIjU4ubA==
X-Google-Smtp-Source: ABdhPJxnLgrV+8e+1OWU0u/sx5uOuWU4vnVlyW/4GKBzGBtnI1biVn/90LUOY9tYhUKMWyQXeLO+fA==
X-Received: by 2002:a05:620a:1416:: with SMTP id d22mr7013201qkj.6.1638975010919;
        Wed, 08 Dec 2021 06:50:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ay42sm1546103qkb.40.2021.12.08.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:50:10 -0800 (PST)
Date:   Wed, 8 Dec 2021 09:50:09 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/254: test cleaning up of the stale device
Message-ID: <YbDGIWHVD4cmdZz0@localhost.localdomain>
References: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 10:07:46PM +0800, Anand Jain wrote:
> Recreating a new filesystem or adding a device to a mounted the filesystem
> should remove the device entries under its previous fsid even when
> confused with different device paths to the same device.
> 
> Fixed by the kernel patch (in the ml):
>   btrfs: harden identification of the stale device
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/254     | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/254.out |   6 +++
>  2 files changed, 116 insertions(+)
>  create mode 100755 tests/btrfs/254
>  create mode 100644 tests/btrfs/254.out
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> new file mode 100755
> index 000000000000..6c3414f73d15
> --- /dev/null
> +++ b/tests/btrfs/254
> @@ -0,0 +1,110 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
> +# Copyright (c) 2021 Oracle. All Rights Reserved.
> +#
> +# FS QA Test No. 254
> +#
> +# Test if the kernel can free the stale device entries.
> +#

Can you include the patch name here as well, it makes it easier when I'm
rebasing our staging branch to figure out if I need to disable a new test for
our overnight runs.
 
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
> +	_mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
> +
> +	# Add device should free the device under $uuid in the kernel.
> +	$BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt
> +

You need to redirect this to /dev/null, otherwise we get the TRIM message with
newer btrfs-progs.

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

I ran this on a box without your fix and I got this failure

[root@xfstests2 xfstests-dev]# cat /xfstests-dev/results//kdave/btrfs/254.out.bad
QA output created by 254
ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory
Label: none  uuid: <UUID>
        Total devices <NUM> FS bytes used <SIZE>
        devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
        *** Some devices missing

Is this what you're expecting?  I was expecting to not see the "*** Some devices
missing" part as well, but I guess that's the racier part?

It does fail properly without the patch and pass with your patch, so as long as
this is what you expect to see then I'm good with this part.  Thanks,

Josef
