Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26185458427
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Nov 2021 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbhKUOqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Nov 2021 09:46:42 -0500
Received: from out20-37.mail.aliyun.com ([115.124.20.37]:52252 "EHLO
        out20-37.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhKUOql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Nov 2021 09:46:41 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0839433-0.000930811-0.915126;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Lwf5Vvq_1637505814;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lwf5Vvq_1637505814)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sun, 21 Nov 2021 22:43:34 +0800
Date:   Sun, 21 Nov 2021 22:43:34 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: Add new test for setting the chunk size.
Message-ID: <YZpbFu9UZp6LyFks@desktop>
References: <20211102212329.3708782-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102212329.3708782-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 02:23:29PM -0700, Stefan Roesch wrote:
> Summary:
> 
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

Sorry for the late review.. I noticed some other minor issues below.

> ---
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
>  common/btrfs        |  73 ++++++++++++
>  tests/btrfs/049     | 280 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  11 ++
>  3 files changed, 364 insertions(+)
>  create mode 100755 tests/btrfs/049
>  create mode 100644 tests/btrfs/049.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac880bdd..d6a7585d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -445,3 +445,76 @@ _scratch_btrfs_is_zoned()
>  	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
>  	return 1
>  }
> +
> +# Print the content of /sys/fs/btrfs/$UUID/$ATTR
> +#
> +# All arguments are necessary, and in this order:
> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
> +#
> +# Usage example:
> +#   _get_btrfs_sysfs_attr /mnt/scratch allocation/data/stripe_size
> +_get_btrfs_sysfs_attr()
> +{
> +	local mnt=$1
> +	local attr=$2
> +
> +	if [ ! -e "$mnt" -o -z "$attr" ];then
> +		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
> +	fi
> +
> +	local uuid=$(findmnt -n -o UUID ${mnt})
> +	cat /sys/fs/btrfs/${uuid}/${attr}
> +}
> +
> +# Write "content" into /sys/fs/btrfs/$UUID/$ATTR
> +#
> +# All arguments are necessary, and in this order:
> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
> +#  - content: the content of $attr
> +#
> +# Usage example:
> +#   _set_btrfs_sysfs_attr /mnt/scratch allocation/data/chunk_size
> +_set_btrfs_sysfs_attr()
> +{
> +	local mnt=$1
> +	shift
> +	local attr=$1
> +	shift
> +	local content="$*"
> +
> +	if [ ! -e "$mnt" -o -z "$attr" -o -z "$content" ];then
> +		_fail "Usage: _set_btrfs_sysfs_attr <mounted_directory> <attr> <content>"
> +	fi
> +
> +	local uuid=$(findmnt -n -o UUID ${mnt})
> +	echo "$content" > /sys/fs/btrfs/${uuid}/${attr} 2>/dev/null
> +	if [ $? -ne 0 ]; then
> +		_dump_err "_set_btrfs_sysfs_attr cannot write ${attr}"
> +	fi
> +}

It seems that above two functions are almost identical to the generic
counter parts in common/rc, the only difference is _[gs]et_sysfs_attr()
takes device as first arg and uses the short dev name not filesystem
UUID.

So I'm wondering if it's possible to extend _[gs]et_sysfs_attr() to
support btrfs as well, i.e. we sill pass device as the first arg, and
find uuid by dev if $FSTYP is btrfs, e.g.

	local dname
	case "$FSTYP" in
	btrfs)
		dname=$(findmnt -n -o UUID ${dev}) ;;
	*)
		dname=$(_short_dev $dev) ;;
	esac

> +
> +# Verify if the sysfs entry in /sys/fs/btrfs/$UUID/$ATTR exists
> +#
> +# All arguments are necessary, and in this order:
> +#  - mnt: mount point name, e.g. $SCRATCH_MNT
> +#  - attr: path name under /sys/fs/btrfs/$uuid/$attr
> +#
> +# Usage example:
> +#   _require_btrfs_sysfs_attr /mnt/scratch allocation/data/chunk_size
> +_require_btrfs_sysfs_attr()
> +{
> +	local mnt=$1
> +	local attr=$2
> +
> +	if [ ! -e "$mnt" -o -z "$attr" ];then
> +		_fail "Usage: _get_btrfs_sysfs_attr <mounted_directory> <attr>"
> +	fi
> +
> +	local uuid=$(findmnt -n -o UUID ${mnt})
> +	if [[ ! -e  /sys/fs/btrfs/${uuid}/${attr} ]]; then
> +		_notrun "Btrfs does not support sysfs $attr"
> +	fi
> +}

I think this could be done by extending _require_fs_sysfs() in the same
way.

> +
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 00000000..780636ae
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,280 @@
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

Local functions don't need the leading underscore, the same applies to
other local functions in this test (except _cleanup).

> +	local SIZE=$(echo "$1" | awk 'match($0, /([0-9.]+)/) { print substr($0, RSTART, RLENGTH) }')

Use $AWK_PROG instead of bare awk.

> +        eval $2="${SIZE%.*}"
> +}
> +
> +# Determine the size of the device in MB.
> +#
> +# Parameters:
> +#   - (INOUT) Variable to store device size in MB
> +#
> +_device_size() {
> +	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full

Use $BTRFS_UTIL_PROG instead of bare 'btrfs', also please use full
subcommand instead of abbr. like 'fi'.

> +	local SIZE=$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
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
> +	local SIZE=$(btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid)
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
> +	local SIZE_STRING=$(btrfs filesystem df ${SCRATCH_MNT} -m | grep  "$1" | awk '{print $3}')
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
> +_require_scratch_size $((10 * 1024 * 1024)) #kB

_scratch_mkfs_sized() will check for the required size and _notrun if
dev is too small, so there's no need to call above _require rule.

> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# Check if there is sufficient sysfs support.
> +_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size
> +_require_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc
> +
> +# Get free space.
> +_free_space  FREE_SPACE_MB
> +_device_size DEVICE_SIZE_MB
> +
> +echo "free space = ${FREE_SPACE_MB}MB" >> ${seqres}.full
> +
> +# Get chunk sizes.
> +echo "Capture default chunk sizes."
> +FIRST_DATA_CHUNK_SIZE_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size)
> +FIRST_METADATA_CHUNK_SIZE_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size)
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
> +_alloc_size "Data"     DATA_SIZE_START_MB
> +_alloc_size "Metadata" METADATA_SIZE_START_MB
> +
> +echo "Block group Data alloc size     = ${DATA_SIZE_START_MB}MB"     >> $seqres.full
> +echo "Block group Metadata alloc size = ${METADATA_SIZE_START_MB}MB" >> $seqres.full
> +
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc 1
> +
> +_alloc_size "Data"     FIRST_DATA_SIZE_MB
> +_alloc_size "Metadata" FIRST_METADATA_SIZE_MB
> +
> +echo "First block group Data alloc size     = ${FIRST_DATA_SIZE_MB}MB"     >> ${seqres}.full
> +echo "First block group Metadata alloc size = ${FIRST_METADATA_SIZE_MB}MB" >> ${seqres}.full
> +
> +_free_space FREE_SPACE_AFTER
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
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size ${SECOND_DATA_CHUNK_SIZE_B}
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size ${SECOND_METADATA_CHUNK_SIZE_B}
> +
> +SECOND_DATA_CHUNK_SIZE_READ_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size)
> +SECOND_METADATA_CHUNK_SIZE_READ_B=$(_get_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/chunk_size)
> +
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
> +echo "Allocated data chunk" >> $seqres.full
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/metadata/force_chunk_alloc 1
> +echo "Allocated metadata chunk" >> $seqres.full
> +
> +_alloc_size "Data"     SECOND_DATA_SIZE_MB
> +_alloc_size "Metadata" SECOND_METADATA_SIZE_MB
> +_alloc_size "System"   SECOND_SYSTEM_SIZE_MB
> +
> +echo "Calculate request size so last memory allocation cannot be completely fullfilled."
> +_free_space FREE_SPACE_MB
> +
> +# Find request size whose space allocation cannot be completely fullfilled.
> +THIRD_DATA_CHUNK_SIZE_MB=$(expr 256)
> +until [ ${THIRD_DATA_CHUNK_SIZE_MB} -gt $(expr 7 \* 1024) ]
> +do

Please unify the code style as

until [ ... ]; do
	<do something>
done

> +	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
> +	       break
> +        fi

Mixed space and tab as indention above?

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
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/chunk_size ${THIRD_DATA_CHUNK_SIZE_B}
> +
> +_free_space FREE_SPACE_MB
> +while [ $FREE_SPACE_MB -gt $THIRD_DATA_CHUNK_SIZE_MB ]
> +do
> +	_alloc_size "Data" THIRD_DATA_SIZE_MB
> +	_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/data/force_chunk_alloc 1
> +
> +	_free_space FREE_SPACE_MB
> +done
> +
> +_alloc_size "Data" FOURTH_DATA_SIZE_MB
> +
> +#
> +# Force chunk allocation of system block tyep must fail.
> +#
> +echo "Force allocation of system block type must fail."
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/force_chunk_alloc 1 2>/dev/null
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
> +	_fail "tInitial data allocation not correct."

No need to call _fail, we could just echo this message and it will break
the golden image and fail the test. Also, dumping the expected and
actual value to stdout may help debug failure.

The same applies to other _fail calls below as well.

Thanks,
Eryu

> +fi
> +
> +if [[ $(expr ${FIRST_METADATA_CHUNK_SIZE_MB} + ${METADATA_SIZE_START_MB}) -ne ${FIRST_METADATA_SIZE_MB} ]]; then
> +	_fail "Initial metadata allocation not correct."
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
> +	_fail "Value written to allocation/data/chunk_size and read value are different."
> +fi
> +
> +if [[ ${SECOND_METADATA_CHUNK_SIZE_B} -ne ${SECOND_METADATA_CHUNK_SIZE_READ_B} ]]; then
> +	_fail "Value written to allocation/metadata/chunk_size and read value are different."
> +fi
> +
> +if [[ $(expr ${SECOND_DATA_CHUNK_SIZE_MB} + ${FIRST_DATA_SIZE_MB}) -ne ${SECOND_DATA_SIZE_MB} ]]; then
> +	_fail "Data allocation after chunk size change not correct."
> +fi
> +
> +if [[ $(expr ${SECOND_METADATA_CHUNK_SIZE_MB} + ${FIRST_METADATA_SIZE_MB}) -ne ${SECOND_METADATA_SIZE_MB} ]]; then
> +	_fail "Metadata allocation after chunk size change not correct."
> +fi
> +
> +#
> +# Verification of third allocation.
> +#
> +echo "Verify third allocation."
> +if [[ ${FREE_SPACE_MB} -gt ${THIRD_DATA_CHUNK_SIZE_MB} ]]; then
> +	_fail "Free space after allocating over memlimit is too high."
> +fi
> +
> +# The + 1 is required as 1MB is always kept as free space.
> +if [[ $(expr ${THIRD_DATA_CHUNK_SIZE_MB} + ${THIRD_DATA_SIZE_MB} + 1) -le $(expr ${FOURTH_DATA_SIZE_MB}) ]]; then
> +	_fail "Allocation until out of memory: last memory allocation size is not correct."
> +fi
> +
> +status=0
> +exit
> +
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> new file mode 100644
> index 00000000..ae99d6f0
> --- /dev/null
> +++ b/tests/btrfs/049.out
> @@ -0,0 +1,11 @@
> +QA output created by 049
> +Capture default chunk sizes.
> +First allocation.
> +Second allocation.
> +Calculate request size so last memory allocation cannot be completely fullfilled.
> +Third allocation.
> +Force allocation of system block type must fail.
> +_set_btrfs_sysfs_attr cannot write allocation/system/force_chunk_alloc
> +Verify first allocation.
> +Verify second allocation.
> +Verify third allocation.
> -- 
> 2.30.2
