Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486EB46634A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 13:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357758AbhLBMPf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 07:15:35 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46647 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346637AbhLBMP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 07:15:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UzBDorp_1638447125;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UzBDorp_1638447125)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 20:12:05 +0800
Date:   Thu, 2 Dec 2021 20:12:05 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v7] btrfs: Add new test for setting the chunk size.
Message-ID: <20211202121205.GB60846@e18g06458.et15sqa>
References: <20211129195016.1874324-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129195016.1874324-1-shr@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 11:50:16AM -0800, Stefan Roesch wrote:
> Add new testcase for testing the new btrfs sysfs knob to change the
> chunk size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
> type>/chunk_size.
> 
> The test case implements three different cases:
> - Test allocation with the default chunk size
> - Test allocation after increasing the chunk size
> - Test allocation when the free space is smaller than the chunk size.
> 
> Note: this test needs to force the allocation of space. It uses the
> /sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.
> 
> Testing:
> The test has been run with volumes of different sizes.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> V7: - fixed whitespace issues
>     - removed test_file variable (no longer needed)
>     - removed _require_btrfs_fs_sysfs (check for filesystem attributes
>       is sufficient)
>     - Added comment for 10G requirement
> V6: - renamed test case from 248 to 251
>     - use _require_fs_sysfs
>     - use device name in _get_fs_sysfs_attr and _set_fs_sysfs_attr
> V5: - Modify _get_fs_sysfs_attr and _set_fs_sysfs_attr to support btrfs
>     - Use _get_fs_sysfs_attr and _set_fs_sysfs_attr
>     - Remove _get_btrfs_sysfs_attr and _set_btrfs_fsysfs_attr
>     - Rename local functions to not use "_"
>     - use $AWK_PROG and $BTRFS_UTIL_PROG
>     - remove call to _require_scratch_size
>     - fixes for coding convention
>     - replace fail calls with echo
> V4: - fixed indentation in common/btrfs
>     - Removed UUID code, which is no longer necessary (provided
>       by helper function)
>     - Used new helper _get_btrfs_sysfs_attr
>     - Direct output to /dev/null
> V3: - removed tests for system block type.
>     - added failure case for system block type.
>     - renamed stripe_size to chunk_size
> V2: - added new functions to common/btrfs and use them in the new test
>       - _require_btrfs_sysfs_attr - Make sure btrfs supports a sysfs
>         setting
>       - _get_btrfs_sysfs_attr - Read sysfs value
>       - _set_btrfs_sysfs_attr - Write sysfs value
>     - create file system of required size with _scratch_mkfs_sized
>     - use shortened error message
>     - Remove last logging message
> ---
>  common/rc           |  27 ++++-
>  tests/btrfs/251     | 285 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/251.out |  11 ++
>  3 files changed, 320 insertions(+), 3 deletions(-)
>  create mode 100755 tests/btrfs/251
>  create mode 100644 tests/btrfs/251.out
> 
> diff --git a/common/rc b/common/rc
> index 0a30a842..bdd29b06 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4401,7 +4401,14 @@ run_fsx()
>  _require_fs_sysfs()
>  {
>  	local attr=$1
> -	local dname=$(_short_dev $TEST_DEV)
> +	local dname
> +
> +	case "$FSTYP" in
> +	btrfs)
> +		dname=$(findmnt -n -o UUID $TEST_DEV) ;;
> +	*)
> +		dname=$(_short_dev $TEST_DEV) ;;
> +	esac
>  
>  	if [ -z "$attr" -o -z "$dname" ];then
>  		_fail "Usage: _require_fs_sysfs <sysfs_attr_path>"
> @@ -4439,7 +4446,14 @@ _set_fs_sysfs_attr()
>  		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
>  	fi
>  
> -	local dname=$(_short_dev $dev)
> +	local dname
> +	case "$FSTYP" in
> +	btrfs)
> +		dname=$(findmnt -n -o UUID ${dev}) ;;
> +	*)
> +		dname=$(_short_dev $dev) ;;
> +	esac
> +
>  	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
>  }
>  
> @@ -4460,7 +4474,14 @@ _get_fs_sysfs_attr()
>  		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
>  	fi
>  
> -	local dname=$(_short_dev $dev)
> +	local dname
> +	case "$FSTYP" in
> +	btrfs)
> +		dname=$(findmnt -n -o UUID ${dev}) ;;
> +	*)
> +		dname=$(_short_dev $dev) ;;
> +	esac
> +
>  	cat /sys/fs/${FSTYP}/${dname}/${attr}
>  }
>  
> diff --git a/tests/btrfs/251 b/tests/btrfs/251
> new file mode 100755
> index 00000000..11925f5b
> --- /dev/null
> +++ b/tests/btrfs/251
> @@ -0,0 +1,285 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 250
> +#
> +# Test the new /sys/fs/btrfs/<uuid>/allocation/<block-type>/chunk_size
> +# setting. This setting allows the admin to change the chunk size
> +# setting for the next allocation.
> +#
> +# Test 1:
> +#   Allocate storage for all three block types (data, metadata and system)
> +#   with the default chunk size.
> +#
> +# Test 2:
> +#   Set a new chunk size to double the default size and allocate space
> +#   for all new block types with the new chunk size.
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
> +seq=`basename $0`
> +seqres="${RESULT_DIR}/${seq}"
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +}

Seems there's no need to override the default cleanup function, we could
just remove this _cleanup defination.

> +
> +# Parse a size string which is in the format "XX.XXMib".
> +#
> +# Parameters:
> +#   - (IN)    Block group type (Data, Metadata, System)
> +#   - (INOUT) Variable to store block group size in MB
> +#
> +parse_size_string() {
> +	local SIZE=$(echo "$1" | $AWK_PROG 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
> +	eval $2="${SIZE%.*}"
> +}
> +
> +# Determine the size of the device in MB.
> +#
> +# Parameters:
> +#   - (INOUT) Variable to store device size in MB
> +#
> +device_size() {
> +	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
> +	local SIZE=$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes | grep devid)
> +	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
> +	eval $1=${SIZE_ALLOC%.*}
> +}
> +
> +# Determine the free space of a block group in MB.
> +#
> +# Parameters:
> +#   - (INOUT) Variable to store free space in MB
> +#
> +free_space() {
> +	local SIZE=$($BTRFS_UTIL_PROG filesystem show ${SCRATCH_MNT} --mbytes | grep devid)
> +	parse_size_string $(echo "${SIZE}" | awk '{print $4}') SIZE_ALLOC
> +	parse_size_string $(echo "${SIZE}" | awk '{print $6}') SIZE_USED
> +	eval $1=$(expr ${SIZE_ALLOC} - ${SIZE_USED})
> +}
> +
> +# Determine how much space in MB has been allocated to a block group.
> +#
> +# Parameters:
> +#   - (IN)    Block group type (Data, Metadata, System)
> +#   - (INOUT) Variable to store block group size in MB
> +#
> +alloc_size() {
> +	local SIZE_STRING=$($BTRFS_UTIL_PROG filesystem df ${SCRATCH_MNT} -m | grep  "$1" | awk '{print $3}')
> +	parse_size_string ${SIZE_STRING} BLOCK_GROUP_SIZE
> +        eval $2="${BLOCK_GROUP_SIZE}"

Above line uses space as indentions, not tab.

> +}
> +
> +. ./common/filter
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +
> +# Delete log file if it exists.
> +rm -f "${seqres}.full"
> +
> +# Make filesystem. 10GB is needed to have sufficient space for testing
> +# block types and chunk sizes.

Hmm, it's still not clear to me why is 10G needed, this comment just
says we need 10G but not why.

> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# Check if there is sufficient sysfs support.
> +_require_fs_sysfs allocation/metadata/chunk_size
> +_require_fs_sysfs allocation/metadata/force_chunk_alloc
> +
> +# Get free space.
> +free_space  FREE_SPACE_MB
> +device_size DEVICE_SIZE_MB
> +
> +echo "free space = ${FREE_SPACE_MB}MB" >> ${seqres}.full
> +
> +# If device is a symbolic link, get block device.
> +SCRATCH_BDEV=${SCRATCH_DEV}
> +if [[ -h ${SCRATCH_DEV} ]]; then
> +	SCRATCH_BDEV=$(readlink -f $SCRATCH_DEV)
> +fi

There's a helper to do this, i.e.

SCRATCH_BDEV=$(_read_dev $SCRATCH_DEV)

> +
> +# Get chunk sizes.
> +echo "Capture default chunk sizes."
> +FIRST_DATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
> +FIRST_METADATA_CHUNK_SIZE_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
> +
> +echo "Orig Data chunk size    = ${FIRST_DATA_CHUNK_SIZE_B}"     >> ${seqres}.full
> +echo "Orig Metaata chunk size = ${FIRST_METADATA_CHUNK_SIZE_B}" >> ${seqres}.full
> +
> +INIT_ALLOC_SIZE_MB=$(expr \( ${FIRST_DATA_CHUNK_SIZE_B} + ${FIRST_METADATA_CHUNK_SIZE_B} \) / 1024 / 1024)
> +echo "Allocation size for initial allocation = ${INIT_ALLOC_SIZE_MB}MB" >> $seqres.full
> +
> +#
> +# Do first allocation with the default chunk sizes for the different block
> +# types.
> +#
> +echo "First allocation."
> +alloc_size "Data"     DATA_SIZE_START_MB
> +alloc_size "Metadata" METADATA_SIZE_START_MB
> +
> +echo "Block group Data alloc size     = ${DATA_SIZE_START_MB}MB"     >> $seqres.full
> +echo "Block group Metadata alloc size = ${METADATA_SIZE_START_MB}MB" >> $seqres.full
> +
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc 1
> +
> +alloc_size "Data"     FIRST_DATA_SIZE_MB
> +alloc_size "Metadata" FIRST_METADATA_SIZE_MB
> +
> +echo "First block group Data alloc size     = ${FIRST_DATA_SIZE_MB}MB"     >> ${seqres}.full
> +echo "First block group Metadata alloc size = ${FIRST_METADATA_SIZE_MB}MB" >> ${seqres}.full
> +
> +free_space FREE_SPACE_AFTER
> +echo "Free space after first allocation = ${FREE_SPACE_AFTER}MB" >> ${seqres}.full
> +
> +#
> +# Do allocation with the doubled chunk sizes for the different block types.
> +#
> +echo "Second allocation."
> +SECOND_DATA_CHUNK_SIZE_B=$(expr ${FIRST_DATA_CHUNK_SIZE_B} \* 2)
> +SECOND_METADATA_CHUNK_SIZE_B=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} \* 2)
> +
> +echo "Second block group Data calc alloc size     = ${SECOND_DATA_CHUNK_SIZE_B}"     >> $seqres.full
> +echo "Second block group Metadata calc alloc size = ${SECOND_METADATA_CHUNK_SIZE_B}" >> $seqres.full
> +
> +# Stripe size is limited to 10% of device size.
> +if [[ ${SECOND_DATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 \* 1024 \* 1024 / 100) ]]; then
> +	SECOND_DATA_CHUNK_SIZE_B=$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1024 \* 1024)
> +fi
> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -gt $(expr ${DEVICE_SIZE_MB} \* 10 \* 1024 \* 1024 / 100) ]]; then
> +	SECOND_METADATA_CHUNK_SIZE_B=$(expr ${DEVICE_SIZE_MB} \* 10 / 100 \* 1024 \* 1024)
> +fi
> +
> +echo "Second block group Data alloc size     = ${SECOND_DATA_CHUNK_SIZE_B}"     >> $seqres.full
> +echo "Second block group Metadata alloc size = ${SECOND_METADATA_CHUNK_SIZE_B}" >> $seqres.full
> +
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${SECOND_DATA_CHUNK_SIZE_B}
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size ${SECOND_METADATA_CHUNK_SIZE_B}
> +
> +SECOND_DATA_CHUNK_SIZE_READ_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size)
> +SECOND_METADATA_CHUNK_SIZE_READ_B=$(_get_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/chunk_size)
> +
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
> +echo "Allocated data chunk" >> $seqres.full
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/metadata/force_chunk_alloc 1
> +echo "Allocated metadata chunk" >> $seqres.full
> +
> +alloc_size "Data"     SECOND_DATA_SIZE_MB
> +alloc_size "Metadata" SECOND_METADATA_SIZE_MB
> +alloc_size "System"   SECOND_SYSTEM_SIZE_MB
> +
> +echo "Calculate request size so last memory allocation cannot be completely fullfilled."
> +free_space FREE_SPACE_MB
> +
> +# Find request size whose space allocation cannot be completely fullfilled.
> +THIRD_DATA_CHUNK_SIZE_MB=$(expr 256)
> +until [ ${THIRD_DATA_CHUNK_SIZE_MB} -gt $(expr 7 \* 1024) ]; do
> +	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
> +		break
> +        fi

Use tab as indention in above line.

> +	THIRD_DATA_CHUNK_SIZE_MB=$((THIRD_DATA_CHUNK_SIZE_MB+256))
> +done
> +
> +if [[ ${THIRD_DATA_CHUNK_SIZE_MB} -eq $(expr 7 \* 1024) ]]; then
> +	_fail "Cannot find allocation size for partial block allocation."
> +fi
> +
> +THIRD_DATA_CHUNK_SIZE_B=$(expr ${THIRD_DATA_CHUNK_SIZE_MB} \* 1024 \* 1024)
> +echo "Allocation size in mb    = ${THIRD_DATA_CHUNK_SIZE_MB}" >> ${seqres}.full
> +echo "Allocation size in bytes = ${THIRD_DATA_CHUNK_SIZE_B}"  >> ${seqres}.full
> +
> +#
> +# Do allocation until free space is exhausted.
> +#
> +echo "Third allocation."
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/chunk_size ${THIRD_DATA_CHUNK_SIZE_B}
> +
> +free_space FREE_SPACE_MB
> +while [ $FREE_SPACE_MB -gt $THIRD_DATA_CHUNK_SIZE_MB ]
> +do
> +	alloc_size "Data" THIRD_DATA_SIZE_MB
> +	_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/data/force_chunk_alloc 1
> +
> +	free_space FREE_SPACE_MB
> +done
> +
> +alloc_size "Data" FOURTH_DATA_SIZE_MB
> +
> +#
> +# Force chunk allocation of system block type must fail.
> +#
> +echo "Force allocation of system block type must fail."
> +_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
> +if [ $? -ne 0 ]; then
> +	_dump_err "_set_fs_sysfs_attr cannot write allocation/system/force_chunk_alloc"

Why _dump_err here? I think a bare echo should do the work. _dump_err is
mainly used in test harness to save error msg so the report
infrastructure knows the failure reason from the test harness' point of
view. Perhaps we should name it as __dump_err.

Otherwise test looks good to me now. Thanks for all the revisions!

Thanks,
Eryu

> +fi
> +
> +#
> +# Verification of initial allocation.
> +#
> +echo "Verify first allocation."
> +FIRST_DATA_CHUNK_SIZE_MB=$(expr ${FIRST_DATA_CHUNK_SIZE_B} / 1024 / 1024)
> +FIRST_METADATA_CHUNK_SIZE_MB=$(expr ${FIRST_METADATA_CHUNK_SIZE_B} / 1024 / 1024)
> +
> +# if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne $(expr ${FIRST_DATA_SIZE_MB}) ]]; then
> +if [[ $(expr ${FIRST_DATA_CHUNK_SIZE_MB} + ${DATA_SIZE_START_MB}) -ne ${FIRST_DATA_SIZE_MB} ]]; then
> +	echo "tInitial data allocation not correct."
> +fi
> +
> +if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
> +	echo "Initial metadata allocation not correct."
> +fi
> +
> +#
> +# Verification of second allocation.
> +#
> +echo "Verify second allocation."
> +SECOND_DATA_CHUNK_SIZE_MB=$(expr ${SECOND_DATA_CHUNK_SIZE_B} / 1024 / 1024)
> +SECOND_METADATA_CHUNK_SIZE_MB=$(expr ${SECOND_METADATA_CHUNK_SIZE_B} / 1024 / 1024)
> +
> +if [[ ${SECOND_DATA_CHUNK_SIZE_B} -ne ${SECOND_DATA_CHUNK_SIZE_READ_B} ]]; then
> +	echo "Value written to allocation/data/chunk_size and read value are different."
> +fi
> +
> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -ne ${SECOND_METADATA_CHUNK_SIZE_READ_B} ]]; then
> +	echo "Value written to allocation/metadata/chunk_size and read value are different."
> +fi
> +
> +if [[ $(expr ${SECOND_DATA_CHUNK_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne ${SECOND_DATA_SIZE_MB} ]]; then
> +	echo "Data allocation after chunk size change not correct."
> +fi
> +
> +if [[ $(expr ${SECOND_METADATA_CHUNK_SIZE_MB} + ${FIRST_METADATA_SIZE_MB}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
> +	echo "Metadata allocation after chunk size change not correct."
> +fi
> +
> +#
> +# Verification of third allocation.
> +#
> +echo "Verify third allocation."
> +if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_CHUNK_SIZE_MB} ]]; then
> +	echo "Free space after allocating over memlimit is too high."
> +fi
> +
> +# The + 1 is required as 1MB is always kept as free space.
> +if [[ $(expr ${THIRD_DATA_CHUNK_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
> +	echo "Allocation until out of memory: last memory allocation size is not correct."
> +fi
> +
> +status=0
> +exit
> +
> diff --git a/tests/btrfs/251.out b/tests/btrfs/251.out
> new file mode 100644
> index 00000000..f5e16ee8
> --- /dev/null
> +++ b/tests/btrfs/251.out
> @@ -0,0 +1,11 @@
> +QA output created by 251
> +Capture default chunk sizes.
> +First allocation.
> +Second allocation.
> +Calculate request size so last memory allocation cannot be completely fullfilled.
> +Third allocation.
> +Force allocation of system block type must fail.
> +_set_fs_sysfs_attr cannot write allocation/system/force_chunk_alloc
> +Verify first allocation.
> +Verify second allocation.
> +Verify third allocation.
> 
> base-commit: 9f8f0e4d5ae00990bac05fbd69a882255bf7bf9f
> -- 
> 2.30.2
