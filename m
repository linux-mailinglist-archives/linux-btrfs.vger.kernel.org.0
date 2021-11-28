Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377E146074F
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352780AbhK1QAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 11:00:55 -0500
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:49479 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbhK1P6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 10:58:54 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0933813-0.000950221-0.905668;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.M-hW5Qg_1638114935;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-hW5Qg_1638114935)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 28 Nov 2021 23:55:35 +0800
Date:   Sun, 28 Nov 2021 23:55:35 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v6] btrfs: Add new test for setting the chunk size.
Message-ID: <YaOmdyoosHntNc5R@desktop>
References: <20211124211230.410473-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124211230.410473-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:12:30PM -0800, Stefan Roesch wrote:
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
>  common/rc           |  29 ++++-
>  tests/btrfs/251     | 287 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/251.out |  11 ++
>  3 files changed, 323 insertions(+), 4 deletions(-)
>  create mode 100755 tests/btrfs/251
>  create mode 100644 tests/btrfs/251.out
> 
> diff --git a/common/rc b/common/rc
> index 0a30a842..9522ba2e 100644
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
> @@ -4436,10 +4443,17 @@ _set_fs_sysfs_attr()
>  	local content="$*"
>  
>  	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
> -		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
> +	 	_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"

What is this change? Seems it adds a space between the first two tabs,
and causes git am to complain about whitespace damange.

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
> index 00000000..b5c4b623
> --- /dev/null
> +++ b/tests/btrfs/251
> @@ -0,0 +1,287 @@
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
> +test_file="${TEST_DIR}/${seq}"

Seems it's not used in the test?

> +seq=`basename $0`
> +seqres="${RESULT_DIR}/${seq}"
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f "$test_file"

Then there's no need to remove it in cleanup

> +}
> +
> +# Parse a size string which is in the format "XX.XXMib".
> +#
> +# Parameters:
> +#   - (IN)    Block group type (Data, Metadata, System)
> +#   - (INOUT) Variable to store block group size in MB
> +#
> +parse_size_string() {
> +	local SIZE=$(echo "$1" | $AWK_PROG 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')
> +        eval $2="${SIZE%.*}"

The above "eval" line uses spaces as indentions not tab.

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
> +}
> +
> +. ./common/filter
> +_supported_fs btrfs
> +_require_test
> +_require_scratch
> +_require_btrfs_fs_sysfs

Looks like we could drop this require, as _require_fs_sysfs below
ensures this requirement must be met.

> +
> +# Delete log file if it exists.
> +rm -f "${seqres}.full"
> +
> +# Make filesystem.
> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1

Any reason we need a 10G filesystem? Some comments would be good.

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
> +fi

I don't think we need this check. We could just remove the
"2 > /dev/null" part from the above _set_fs_sysfs_attr and it will print
error message and break golden image on error.

Thanks,
Eryu

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
> index 00000000..bb7b45d8
> --- /dev/null
> +++ b/tests/btrfs/251.out
> @@ -0,0 +1,11 @@
> +QA output created by 248
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
> -- 
> 2.30.2
