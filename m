Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1C46E9F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhLIObs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhLIObr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 09:31:47 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E4C061746
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 06:28:14 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id jo22so5193772qvb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Dec 2021 06:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2cJURmw2o8HxE5GvcaCxNIkoB26ytpoNVDW6Wccjri8=;
        b=sXswu+09IIqc/5o9BGM/MwwJYYvcYeQJjhwjCMcq3QvoyIqes424pRWbXUWXe6OPzX
         hB9AZrT+g00b6YrA9VA0kisnMX4pbRLxiKzMmOaJrLxC7aLNZrT1HiqgDbutWqySR6op
         Y3XB4T6P1068nMQ4pOhSxkYCKGTHncqVnqJaFEi7ZLJG5CsoYnLc+FuiaxKQDNvj25sz
         JneRHDxRAriwq6D8hTbMintB0IpUbRxURWOPzEkZ9pSl3gd9ilLgzvlx6hJ08ZQVuHaB
         BjQ9Jy1A5+NU661NcqsMh7tXkkg2sgadsqc3mdSnJatcOwFgKvJwK8a7lQoFZ6qHiCzR
         Urtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2cJURmw2o8HxE5GvcaCxNIkoB26ytpoNVDW6Wccjri8=;
        b=DX8vvQD3BZ6pQTdH8ugIftbLojOU80nZvxC2tytXEwObOzTSGzm3+u6bf+CGb1nmya
         MEH5bTZgJsXl0ZR+xcxj1kXj6a/f41La6HqVWphjEDfARjQyvhiAuhawkqVjg2k8h7XJ
         A5G76yC1tFqq+j3H0MzqioeMr8hq2fyHSjkjOZC1HoUD3YFYLS1T0IPNj9cCh2I8yt0P
         A26sldIpepWFURqINOFAYqaPH/RYvT+8xn/Np+ASyckRA8SXKLYNVWTqjmw992EKN5u1
         ozohMUm05hTIWccNVHQYdgdSHC9ZASTfNOgUNkA1rg7HBHKdbVcgcoMYJAnsbgqMVCnt
         hfmw==
X-Gm-Message-State: AOAM530GyT4UhfK8TTVEWil0LHOsM8/IFeE+AJh5a/ME+ggFHcchXF8L
        vuLWv3eq/HaHclTgKuqW6gMskQ==
X-Google-Smtp-Source: ABdhPJw5RFGLCuIjojQz6RKP+rQspc2aFnI6kRPxam6LDlFJJCO3ttou6hZfAuHiIAtExmIYFPQAqQ==
X-Received: by 2002:ad4:4027:: with SMTP id q7mr16377245qvp.117.1639060093046;
        Thu, 09 Dec 2021 06:28:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm2846005qkr.126.2021.12.09.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 06:28:12 -0800 (PST)
Date:   Thu, 9 Dec 2021 09:28:11 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/254: test cleaning up of the stale device
Message-ID: <YbISe4E9/Yr8OGFH@localhost.localdomain>
References: <c1c22a67c90f1b0b94ea3f99d6d6fd4a4d5d5473.1638953165.git.anand.jain@oracle.com>
 <YbDGIWHVD4cmdZz0@localhost.localdomain>
 <5864b5a8-7572-1f43-b217-761bb6e4bfce@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5864b5a8-7572-1f43-b217-761bb6e4bfce@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 02:41:22PM +0800, Anand Jain wrote:
> On 08/12/2021 22:50, Josef Bacik wrote:
> > On Wed, Dec 08, 2021 at 10:07:46PM +0800, Anand Jain wrote:
> > > Recreating a new filesystem or adding a device to a mounted the filesystem
> > > should remove the device entries under its previous fsid even when
> > > confused with different device paths to the same device.
> > > 
> > > Fixed by the kernel patch (in the ml):
> > >    btrfs: harden identification of the stale device
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   tests/btrfs/254     | 110 ++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/254.out |   6 +++
> > >   2 files changed, 116 insertions(+)
> > >   create mode 100755 tests/btrfs/254
> > >   create mode 100644 tests/btrfs/254.out
> > > 
> > > diff --git a/tests/btrfs/254 b/tests/btrfs/254
> > > new file mode 100755
> > > index 000000000000..6c3414f73d15
> > > --- /dev/null
> > > +++ b/tests/btrfs/254
> > > @@ -0,0 +1,110 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021 Anand Jain. All Rights Reserved.
> > > +# Copyright (c) 2021 Oracle. All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 254
> > > +#
> > > +# Test if the kernel can free the stale device entries.
> > > +#
> > 
> > Can you include the patch name here as well, it makes it easier when I'm
> > rebasing our staging branch to figure out if I need to disable a new test for
> > our overnight runs.
> 
>  Ok. I will include.
> 
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +# Override the default cleanup function.
> > > +node=$seq-test
> > > +cleanup_dmdev()
> > > +{
> > > +	_dmsetup_remove $node
> > > +}
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	rm -rf $seq_mnt > /dev/null 2>&1
> > > +	cleanup_dmdev
> > > +}
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/filter.btrfs
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_require_scratch_dev_pool 3
> > > +_require_block_device $SCRATCH_DEV
> > > +_require_dm_target linear
> > > +_require_btrfs_forget_or_module_loadable
> > > +_require_scratch_nocheck
> > > +_require_command "$WIPEFS_PROG" wipefs
> > > +
> > > +_scratch_dev_pool_get 3
> > > +
> > > +setup_dmdev()
> > > +{
> > > +	# Some small size.
> > > +	size=$((1024 * 1024 * 1024))
> > > +	size_in_sector=$((size / 512))
> > > +
> > > +	table="0 $size_in_sector linear $SCRATCH_DEV 0"
> > > +	_dmsetup_create $node --table "$table" || \
> > > +		_fail "setup dm device failed"
> > > +}
> > > +
> > > +# Use a known it is much easier to debug.
> > > +uuid="--uuid 12345678-1234-1234-1234-123456789abc"
> > > +lvdev=/dev/mapper/$node
> > > +
> > > +seq_mnt=$TEST_DIR/$seq.mnt
> > > +mkdir -p $seq_mnt
> > > +
> > > +test_forget()
> > > +{
> > > +	setup_dmdev
> > > +	dmdev=$(realpath $lvdev)
> > > +
> > > +	_mkfs_dev $uuid $dmdev
> > > +
> > > +	# Check if we can un-scan using the mapper device path.
> > > +	$BTRFS_UTIL_PROG device scan --forget $lvdev
> > > +
> > > +	# Cleanup
> > > +	$WIPEFS_PROG -a $lvdev > /dev/null 2>&1
> > > +	$BTRFS_UTIL_PROG device scan --forget
> > > +
> > > +	cleanup_dmdev
> > > +}
> > > +
> > > +test_add_device()
> > > +{
> > > +	setup_dmdev
> > > +	dmdev=$(realpath $lvdev)
> > > +	scratch_dev2=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> > > +	scratch_dev3=$(echo $SCRATCH_DEV_POOL | awk '{print $3}')
> > > +
> > > +	_mkfs_dev $scratch_dev3
> > > +	_mount $scratch_dev3 $seq_mnt
> > > +
> > > +	_mkfs_dev $uuid -draid1 -mraid1 $dmdev $scratch_dev2
> > > +
> > > +	# Add device should free the device under $uuid in the kernel.
> > > +	$BTRFS_UTIL_PROG device add -f $lvdev $seq_mnt
> > > +
> > 
> > You need to redirect this to /dev/null, otherwise we get the TRIM message with
> > newer btrfs-progs.
> > 
> 
>   Ok.
> 
> 
> > > +	_mount -o degraded $scratch_dev2 $SCRATCH_MNT
> > > +
> > > +	# Check if the missing device is shown.
> > > +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> > > +					_filter_btrfs_filesystem_show
> > > +
> > > +	$UMOUNT_PROG $seq_mnt
> > > +	_scratch_unmount
> > > +	cleanup_dmdev
> > > +}
> > > +
> > > +test_forget
> > > +test_add_device
> > > +
> > > +_scratch_dev_pool_put
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/254.out b/tests/btrfs/254.out
> > > new file mode 100644
> > > index 000000000000..20819cf5140c
> > > --- /dev/null
> > > +++ b/tests/btrfs/254.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 254
> > > +Label: none  uuid: <UUID>
> > > +	Total devices <NUM> FS bytes used <SIZE>
> > > +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> > > +	*** Some devices missing
> > 
> > I ran this on a box without your fix and I got this failure
> > 
> > [root@xfstests2 xfstests-dev]# cat /xfstests-dev/results//kdave/btrfs/254.out.bad
> > QA output created by 254
> 
> > ERROR: cannot unregister device '/dev/mapper/254-test': No such file or directory
> 
>  Without the fix the error is expected.
> 
> > Label: none  uuid: <UUID>
> >          Total devices <NUM> FS bytes used <SIZE>
> >          devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> >          *** Some devices missing
> > 
> > Is this what you're expecting?
> 
>  Hmm, no. Without the fix, we shouldn't see the missing here.
> 
> > I was expecting to not see the "*** Some devices
> > missing" part as well, but I guess that's the racier part?
> 
>  Right. I am guessing race with udev auto scan?
> 

Yeah that's what I'm assuming, since the original problem I had was transient, I
just want to make sure that's what I'm seeing and not that the test isn't quite
right.  As long as it fails we're good, but it makes me nervous when the
expectected output matches the failure case so I wanted to double check.

> > It does fail properly without the patch and pass with your patch, so as long as
> > this is what you expect to see then I'm good with this part.  Thanks,
> 
>  Yeah, we shouldn't see missing device _without_ the fix.
>  Could you please share your xfstests config?
> 

Yup, its the following, I was using -s btrfs_normal

[btrfs_normal]
TEST_DIR=/mnt/test
TEST_DEV=/dev/mapper/vg0-lv0
SCRATCH_DEV_POOL="/dev/mapper/vg0-lv9 /dev/mapper/vg0-lv8 /dev/mapper/vg0-lv7 /dev/mapper/vg0-lv6 /dev/mapper/vg0-lv5 /dev/mapper/vg0-lv4 /dev/mapper/vg0-lv3 /dev/mapper/vg0-lv2 /dev/mapper/vg0-lv1 "
SCRATCH_MNT=/mnt/scratch
LOGWRITES_DEV=/dev/mapper/vg0-lv10
PERF_CONFIGNAME=jbacik
MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"
MOUNT_OPTIONS="-o discard=async"

[btrfs_compression]
MOUNT_OPTIONS="-o compress=zstd,discard=async"
MKFS_OPTIONS="-K -O ^no-holes -R ^free-space-tree"

Weirdly compression would pass sometimes without the fix applied, so using -s
btrfs_compression.  IDK why, clearly this is a weird problem and depends on udev
timing, but maybe take another look?  Thanks,

Josef
