Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9120C6A2A40
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 15:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjBYOFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Feb 2023 09:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBYOFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Feb 2023 09:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8881B6
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677333897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQzCDhzDCbh7Xtv8hLDPUgBic6iX9oUnxAx86clXe14=;
        b=BqkNwyGS9MDVsHwvgopBI+QBXzLWKJ2zPlrcM/NkqwWqoRK8YXBrcnIK9t7G1qspensEyn
        nOE+DjTvSMyrQ3mYDeI1z+4b+Wm6nOgueCVDq1DTchWoDZ9J+YTzG7UmcJKgTh7EAXay1Q
        ndyWBGkGzPsx0noPWikov9Nq2lLLGGw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-svY43fWzPfOLCHn52lb68w-1; Sat, 25 Feb 2023 09:04:55 -0500
X-MC-Unique: svY43fWzPfOLCHn52lb68w-1
Received: by mail-pg1-f199.google.com with SMTP id s187-20020a635ec4000000b00502f5c8f5eeso466299pgb.14
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Feb 2023 06:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQzCDhzDCbh7Xtv8hLDPUgBic6iX9oUnxAx86clXe14=;
        b=QwdAaIF0ZiosHSWxIQMISijCn0xdPx4izC2QveMd7sR534RaLT+d6xJL7RgHhYkMe4
         W3nbf4mA9YIajQaP/wBxL4gwbEr5c1/zuhJYoA5vkE608vGl4nKIkXN5gOkABSZzg51P
         ITwRUYNv99cZrkgTTWQ07nHgMDn4BQE2HWLpRhc+Zyix1t19toevZ/box/+AUJ1Tih44
         sdkCHiIVGBKksBAKjXZrLXo07oj/Qmy4uAT1UW1K9d5tGSQ9rg3PQ45LpduX+8qbcXB2
         wXWz7j/95aRMdFU1G+bVUxyhuchokLk/hQGi/ABycr5oiIbJQzxdXefU8BLcR85Ch3Ky
         ATYg==
X-Gm-Message-State: AO0yUKWEoyhSnDzzOUwCllWOAm0OyHYfV7FkJr8hilg7v6fSpk+MEiUG
        iMWLdPdOxWqJ6MvBYRocWrWeV7OQzd9xYlR78ESNqD4mOGfc8vOpAIHJdDPtzzuWyOOeC9Yc1Kz
        /c1x5k93/4pxVvWiMbDi6D3Q=
X-Received: by 2002:a05:6a20:1590:b0:c6:d37c:2a62 with SMTP id h16-20020a056a20159000b000c6d37c2a62mr14375033pzj.11.1677333894403;
        Sat, 25 Feb 2023 06:04:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/TXbdc67gcwusU5+PhJEEnVs+eclIQCCyC8rpqt4ekgzrnq3J74e8AuA0cTQaorxxohd2xnw==
X-Received: by 2002:a05:6a20:1590:b0:c6:d37c:2a62 with SMTP id h16-20020a056a20159000b000c6d37c2a62mr14375000pzj.11.1677333893862;
        Sat, 25 Feb 2023 06:04:53 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b00593adee79efsm1261231pfd.55.2023.02.25.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 06:04:53 -0800 (PST)
Date:   Sat, 25 Feb 2023 22:04:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case for NODATASUM dev-replace
Message-ID: <20230225140449.zg2raqkqyz374mmj@zlang-mailbox>
References: <20230223051049.30086-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223051049.30086-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 01:10:49PM +0800, Qu Wenruo wrote:
> During my development on dev-replace, I made a mistake in RAID56
> dev-replace code where it can lead to NODATASUM corruption.
> Thankfully such corruption didn't reach upstream.
> 
> Inspired by such incident, here comes a new test case for btrfs
> dev-replace, the new case would:
> 
> - Populate the filesystem with nodatasum mount option
> 
> - Run fssum to record the contents
>   Since the test case only cares about data contents, here we don't
>   include metadata like uid/gid/timestamp.
> 
> - Wipe one device
> 
> - Mount the fs with the missing device
> 
> - Verify the contents is still correct
> 
> - Replace the missing device
> 
> - Verify the contents is still correct again
>   Before the verification, drop all cache to make sure the 2nd
>   verification is reading from the disks.
> 
> For current kernels, the test case should pass as expected.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

There's not review points from btrfs list, and this case looks good to me,
and I didn't find any problems on this case by a simple test [1]. So I'd
like to merge this btrfs specific case directly.

Reviewed-by: Zorro Lang <zlang@redhat.com>

[1]
# ./check -s pooldev btrfs/286
SECTION       -- pooldev
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.2.0-rc8-mainline+ #6 SMP PREEMPT_DYNAMIC Wed Feb 15 14:16:45 CST 2023
MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev1 /mnt/scratch

btrfs/286        41s
Ran: btrfs/286
Passed all 1 tests

SECTION       -- pooldev
=========================
Ran: btrfs/286
Passed all 1 tests

>  tests/btrfs/286     | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/286.out |  2 ++
>  2 files changed, 80 insertions(+)
>  create mode 100755 tests/btrfs/286
>  create mode 100644 tests/btrfs/286.out
> 
> diff --git a/tests/btrfs/286 b/tests/btrfs/286
> new file mode 100755
> index 00000000..fb805256
> --- /dev/null
> +++ b/tests/btrfs/286
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 286
> +#
> +# Make sure btrfs dev-replace on missing device won't cause data corruption
> +# for NODATASUM data.
> +#
> +. ./common/preamble
> +_begin_fstest auto replace
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_command "$WIPEFS_PROG" wipefs
> +_btrfs_get_profile_configs replace-missing
> +_require_fssum
> +_require_scratch_dev_pool 5
> +_scratch_dev_pool_get 4
> +_spare_dev_get
> +
> +workload()
> +{
> +	local profile=$1
> +	local victim="$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')"
> +
> +	echo "=== Profile: $profile ===" >> $seqres.full
> +	rm -f $tmp.fssum
> +	_scratch_pool_mkfs "$profile" >> $seqres.full 2>&1
> +
> +	# Use nodatasum mount option, so all data won't have checksum.
> +	_scratch_mount -o nodatasum
> +
> +	$FSSTRESS_PROG -p 10 -n 200 -d $SCRATCH_MNT > /dev/null 2>&1
> +	sync
> +
> +	# Generate fssum for later verification, here we only care
> +	# about the file contents, thus we don't bother metadata at all.
> +	$FSSUM_PROG -n -d -f -w $tmp.fssum $SCRATCH_MNT
> +	_scratch_unmount
> +
> +	# Wipe devid 2
> +	$WIPEFS_PROG -a $victim >> $seqres.full 2>&1
> +
> +	# Mount the fs with the victim device missing
> +	_scratch_mount -o degraded,nodatasum
> +
> +	# Verify no data corruption first.
> +	echo "=== Verify the contents before replace ===" >> $seqres.full
> +	$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	# Replace the missing device
> +	$BTRFS_UTIL_PROG replace start -Bf 2 $SPARE_DEV $SCRATCH_MNT >> $seqres.full
> +
> +	# Drop all cache to make sure later read are all from the disks
> +	echo 3 > /proc/sys/vm/drop_caches
> +
> +	# Re-check the file contents
> +	echo "=== Verify the contents after replace ===" >> $seqres.full
> +	$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	_scratch_unmount
> +}
> +
> +for t in "${_btrfs_profile_configs[@]}"; do
> +	workload "$t"
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/286.out b/tests/btrfs/286.out
> new file mode 100644
> index 00000000..35c48006
> --- /dev/null
> +++ b/tests/btrfs/286.out
> @@ -0,0 +1,2 @@
> +QA output created by 286
> +Silence is golden
> -- 
> 2.39.0
> 

