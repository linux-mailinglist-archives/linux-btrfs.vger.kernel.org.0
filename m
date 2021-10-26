Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838ED43B9E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhJZSrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbhJZSrn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:47:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602EC061243
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:45:19 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b12so167593qtq.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yH2ifAVoyrdweyi+7/b8BzlgPC5Xyy8MY24JCLB3IlA=;
        b=yMwFxqjIx2irSLyejKmDZUYJEsQAvbZNR5rLwuhruFuGl6ghvwWqdbo+h97WA1m3Vd
         gZvq5q/IIT42c7DKOm0G52LcpuzwWTiBar86XIuJVoI4tUSmpMrMK13a5xzyt18Iywpc
         2AM1hiYbhKj9Z1VUinBUme+1Xjz7MpxXs/sJfq5oB8kY8l4RQf+3MN3FHzDwLWTn/FWw
         QkxEOpATLVB+t0NrchGvkRW0Utz9fBOHySiHmqnFC8S4JNb+QJ9rrRWfGasIgTWSCg56
         hcghQrd5Cqrz9I8c9zcHO/hTHcVTPBGgwuLBQvCB7V035eirmNVnGtKz+MyTfK4Q6LoT
         9OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yH2ifAVoyrdweyi+7/b8BzlgPC5Xyy8MY24JCLB3IlA=;
        b=roMbL/ISE2XFKl+adCcBD/YgBpaWHB4v0RqpZzhIdgBn8k+62ErAJ6mo0E7CGtGSW1
         uZ2+M9PjHCcMpuk4ElKAKYW5AS+wWxEcIr1UAy+DzPFUdh0Il+TlcqupsTnzN3HC58iO
         D8x8plRUvwqAQBGRBqUqZzZ+QkOV46okU6TaREDuRocRU0C+9d3MJEGtRE6dKCMI8hzN
         Cemyniylcdq4RGw5kdc26Ft3Wx4JqI03zxWZU9ZFYa0pWOWUGG4wV7hGWqZPXolF6xCQ
         55cCQRD7L9t4xqqWBbsKeIJsWlhk52x9yh2OO2VBb30ZqdUvEY6kATKd1UBYv7LsrV5U
         sdSw==
X-Gm-Message-State: AOAM5326MI+5Bi6o2I5/xOqZaeq0HQrhkXSws2dG9mEb/FCneIQQT0UQ
        ARFwX1q12i8X6EUVv3dGQNhlwA==
X-Google-Smtp-Source: ABdhPJxfMl6Z93nRVzCj0bbUv8nY+I0ltyyCcjKoeDN7+JxZDilLrPypl9BrpoVtGls4JMPXCg0XUQ==
X-Received: by 2002:ac8:57c3:: with SMTP id w3mr26417735qta.132.1635273917777;
        Tue, 26 Oct 2021 11:45:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm10628953qtt.22.2021.10.26.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:45:17 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:45:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: Add new test for setting the stripe size.
Message-ID: <YXhMvEt2ay1VK8dL@localhost.localdomain>
References: <20211026180123.843069-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026180123.843069-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 26, 2021 at 11:01:23AM -0700, Stefan Roesch wrote:
> Summary:
> 
> Add new testcase for testing the new btrfs sysfs knob to change the
> stripe size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
> type>/stripe_size.
> 
> The test case implements three different cases:
> - Test allocation with the default stripe size
> - Test allocation after increasing the stripe size
> - Test allocation when the free space is smaller than the stripe size.
> 
> Note: this test needs to force the allocation of space. It uses the
> /sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.
> 
> Testing:
> The test has been run with volumes of different sizes.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  tests/btrfs/248     | 317 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/248.out |  11 ++
>  2 files changed, 328 insertions(+)
>  create mode 100755 tests/btrfs/248
>  create mode 100644 tests/btrfs/248.out
> 
> diff --git a/tests/btrfs/248 b/tests/btrfs/248
> new file mode 100755
> index 00000000..2b6a6bc2
> --- /dev/null
> +++ b/tests/btrfs/248
> @@ -0,0 +1,317 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 250
> +#
> +# Test the new /sys/fs/btrfs/<uuid>/allocation/<block-type>/stripe_size
> +# setting. This setting allows the admin to change the stripe size
> +# setting for the next allocation.
> +#
> +# Test 1:
> +#   Allocate storage for all three block types (data, metadata and system)
> +#   with the default stripe size.
> +#
> +# Test 2:
> +#   Set a new stripe size to double the default size and allocate space
> +#   for all new block types with the new stripe size.
> +#
> +# Test 3:
> +#   Pick an allocation size that is used in a loop and make sure the last
> +#   allocation cannot be partially fullfilled.
> +#
> +# Note: Variable naming uses the following convention: if a variable name
> +#       ends in "_B" then its a byte value, if it ends in "_MB" then the
> +#       value is in megabytes.
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +test_file="${TEST_DIR}/${seq}"
> +seq=`basename $0`
> +seqres="${RESULT_DIR}/${seq}"
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f "$test_file"
> +}
> +
> +# Parse a size string which is in the format "XX.XXMib".
> +#
> +# Parameters:
> +#   - (IN)    Block group type (Data, Metadata, System)
> +#   - (INOUT) Variable to store block group size in MB
> +#
> +_parse_size_string() {
> +	local SIZE=$(echo "$1" | awk 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
> +        eval $2="${SIZE%.*}"
> +}
> +
> +# Determine the size of the device in MB.
> +#
> +# Parameters:
> +#   - (INOUT) Variable to store device size in MB
> +#
> +_device_size() {
> +	$BTRFS_UTIL_PROG fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
> +	local SIZE=$($BTRFS_UTIL_PROG fi show ${SCRATCH_MNT} --mbytes | grep devid)
> +	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
> +	eval $1=${SIZE_ALLOC%.*}
> +}
> +
> +# Determine the free space of a block group in MB.
> +#
> +# Parameters:
> +#   - (INOUT) Variable to store free space in MB
> +#
> +_free_space() {
> +	local SIZE=$($BTRFS_UTIL_PROG fi show ${SCRATCH_MNT} --mbytes | grep devid)
> +	_parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
> +	_parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
> +	eval $1=$(expr ${SIZE_ALLOC} - ${SIZE_USED})
> +}
> +
> +# Determine how much space in MB has been allocated to a block group.
> +#
> +# Parameters:
> +#   - (IN)    Block group type (Data, Metadata, System)
> +#   - (INOUT) Variable to store block group size in MB
> +#
> +_alloc_size() {
> +	local SIZE_STRING=$($BTRFS_UTIL_PROG filesystem df ${SCRATCH_MNT} -m | grep  "$1" | awk '{print $3}')
> +	_parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
> +        eval $2="${BLOCK_GROUP_SIZE}"
> +}
> +
> +. ./common/filter
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +_require_btrfs_fs_sysfs
> +
> +# Delete log file if it exists.
> +rm -f "${seqres}.full"
> +
> +# Make filesystem.
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# Get UUID of device.
> +UUID="$(findmnt -n -o UUID ${SCRATCH_MNT})"
> +echo "UUID = ${UUID}" >> ${seqres}.full
> +
> +# Check if there is sufficient sysfs support.
> +if [[ ! -e /sys/fs/btrfs/${UUID}/allocation/metadata/stripe_size ]]; then
> +	_notrun "The filesystem has no support to set the BTRFS stripe size."
> +fi

Two things, first you're doing a lot of /sys/fs/btrfs/${UUID}/whatever.  We have
a _get_fs_sysfs_attr() helper that does the right thing for device based things
like xfs or ext4.  It would be good to go ahead and add a 

_get_btrfs_sysfs_attr()
_set_btrfs_sysfs_attr()

and use a similar calling convetion, so for example

FIRST_DATA_STRIPE_SIZE=$(_get_btrfs_sysfs_attr $SCRATCH_MNT allocation/data/stripe_size)

so you can put a 

_fail "sysfs attr $whatever doesn't exist" in the helper.

Secondly if you are going to have a _notrun you should probably have a helper
for that as well, so something along the lines of

_require_btrfs_sysfs_attr allocation/metadata/stripe_size

that will check the TEST_MNT UUID to make sure the thing exists.

> +
> +if [[ ! -e /sys/fs/btrfs/${UUID}/allocation/metadata/force_chunk_alloc ]]; then
> +	_notrun "The filesystem has no support to force BTRFS allocation."
> +fi
> +
> +# Get free space.
> +_free_space  FREE_SPACE_MB
> +_device_size DEVICE_SIZE_MB
> +
> +echo "free space = ${FREE_SPACE_MB}" >> ${seqres}.full
> +
> +# Get stripe sizes.
> +echo "Capture default stripe sizes."
> +FIRST_DATA_STRIPE_SIZE_B=$(cat /sys/fs/btrfs/${UUID}/allocation/data/stripe_size)
> +FIRST_METADATA_STRIPE_SIZE_B=$(cat /sys/fs/btrfs/${UUID}/allocation/metadata/stripe_size)
> +FIRST_SYSTEM_STRIPE_SIZE_B=$(cat /sys/fs/btrfs/${UUID}/allocation/system/stripe_size)
> +
> +echo "Data stripe size    = ${FIRST_DATA_STRIPE_SIZE_B}"     >> ${seqres}.full
> +echo "Metaata stripe size = ${FIRST_METADATA_STRIPE_SIZE_B}" >> ${seqres}.full
> +echo "System stripe size  = ${FIRST_SYSTEM_STRIPE_SIZE_B}"   >> ${seqres}.full
> +
> +INIT_ALLOC_SIZE_MB=$(expr \( ${FIRST_DATA_STRIPE_SIZE_B} + ${METADATA_STRIP_SIZE} + ${FIRST_SYSTEM_STRIPE_SIZE_B} \) / 1024 / 1024)
> +echo "Allocation size for initial allocation = $INIT_ALLOC_SIZE_MB" >> $seqres.full
> +
> +# Check if there is enough free space.
> +echo "Check free space."
> +if [[ ${FREE_SPACE_MB} -lt 10000 ]]; then
> +	_notrun "The filesystem has less than 10GB free space."
> +fi

Use _require_scratch_size instead.

> +
> +if [[ $(expr ${INIT_ALLOC_SIZE_MB} \* 4) -gt ${FREE_SPACE_MB} ]]; then
> +	_notrun "The filesystem default stripe size > available free space."
> +fi
> +

Instead of doing all of this complicated math and such, require a minimum sized
file system.  Then use _scratch_mkfs_sized() to create a specific sized file
system so it'll do the thing you want.  Then you can do allocations and stuff
and simply output it as part of your golden output.  That'll drastically cut
down on the complexity of this test.

<snip>

> +echo "Verify second allocation."
> +SECOND_DATA_STRIPE_SIZE_MB=$(expr ${SECOND_DATA_STRIPE_SIZE_B} / 1024 / 1024)
> +SECOND_METADATA_STRIPE_SIZE_MB=$(expr ${SECOND_METADATA_STRIPE_SIZE_B} / 1024 / 1024)
> +SECOND_SYSTEM_STRIPE_SIZE_MB=$(expr ${SECOND_SYSTEM_STRIPE_SIZE_B} / 1024 / 1024)
> +
> +if [[ ${SECOND_DATA_STRIPE_SIZE_B} -ne ${SECOND_DATA_STRIPE_SIZE_READ_B} ]]; then
> +	_fail "Value written to /sys/fs/btrfs/<uuid>/allocation/data/stripe_size and read value are different."
> +fi
> +

Just put 

"Value written to allocation/data/stripe_size and read value are different"

no need for teh full path.

> +if [[ ${SECOND_METADATA_STRIPE_SIZE_B} -ne ${SECOND_METADATA_STRIPE_SIZE_READ_B} ]]; then
> +	_fail "Value written to /sys/fs/btrfs/<uuid>/allocation/metadata/stripe_size and read value are different."
> +fi
> +
> +if [[ ${SECOND_SYSTEM_STRIPE_SIZE_B} -ne ${SECOND_SYSTEM_STRIPE_SIZE_READ_B} ]]; then
> +	_fail "Value written to /sys/fs/btrfs/<uuid>/allocation/system/stripe_size and read value are different."
> +fi
> +
> +
> +if [[ $(expr ${SECOND_DATA_STRIPE_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne ${SECOND_DATA_SIZE_MB} ]]; then
> +	_fail "Data allocation after stripe size change not correct."
> +fi
> +
> +if [[ $(expr ${SECOND_METADATA_STRIPE_SIZE_MB} + ${FIRST_METADATA_SIZE_MB}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
> +	_fail "Metadata allocation after stripe size change not correct."
> +fi
> +
> +if [[ $(expr ${SECOND_SYSTEM_STRIPE_SIZE_MB} + ${FIRST_SYSTEM_SIZE_MB}) -ne ${SECOND_SYSTEM_SIZE_MB} ]]; then
> +	_fail "System allocation after stripe size change not correct."
> +fi
> +
> +#
> +# Verification of third allocation.
> +#
> +echo "Verify third allocation."
> +if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_STRIPE_SIZE_MB} ]]; then
> +	_fail "Free space after allocating over memlimit is too high."
> +fi
> +
> +# The + 1 is required as 1MB is always kept as free space.
> +if [[ $(expr ${THIRD_DATA_STRIPE_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
> +	_fail "Allocation until out of memory: last memory allocation size is not correct."
> +fi
> +
> +
> +# Report success.
> +echo "Silence is golden"

Don't need this bit since you have golden output.  Thanks,

Josef
