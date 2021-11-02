Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB74432E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhKBQjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhKBQir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:38:47 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4184C0797B3
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 09:21:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g25so12625811qvf.13
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qr0HeY6l/fHrMy8kwvdN3XaZCeB1tyY0JBWY1jj1GjM=;
        b=lwD3xAW/xwfS3K5MeL+E/ASQ1Hu8v+SaJJ+UtrzsHB5OQsLPPftp6Ug3IwDeo3LRkz
         My9XWahpz0NactttARIfFMlJpLzn9V85Ec2QPCyBRnrQxdJn+djz02+C5agetM1THaTh
         v+CGf5vaA/izzPXbsry1ajyE2x2wa2+RMwk8RuHwxiOLN0VVDgzqtYf5u5HukSrTgTjr
         DWjZv576jtdUWlZfaYzR36wWsZpd45o1youRN5kl3oltrjL1Cs1NS42DINRy4oF8ZLe1
         luwkGVUdMaEIrOHba51ac6P8wCOsCu3YUTVOOdkTf7XO6EwtS7LBTDZNLThunDw4NUKk
         Gs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qr0HeY6l/fHrMy8kwvdN3XaZCeB1tyY0JBWY1jj1GjM=;
        b=ZFQx8kpACi4NUKDFvWuxTQnfldy/oRAkgd2M/KP7eGqhrZcb1FG3HRhhIwWfnI/1WV
         5KTADBHsPhagISsuDZKs0/2FNSxgyvIuKnEm0I60j+6/c0rZu08t3rWSEqezi6xHhG9q
         ZsDgjScx05tZdxZ8TyZugRvIyc9THa0AZep/45wEa3IRTY5RslEI1I2uFCd9QOSJyr9K
         O10S8e4fAF2x2jsymVFAIw97Sk/jEZMm+EBq9rHEkVPxhdklTkpTanOsBN0F8LwYvpPV
         JU6kTm4gbYyRLll4vczL54uyqeDQequJFVugsYy9VNyUBE6V1hIn21kUn2mT9JPNR52u
         bFdw==
X-Gm-Message-State: AOAM531OL4gOCqSpIvpLW5mSr3G+4xE9afZcTGcptRtl+dxnDh9N1YHw
        J4OpIgSzerAHsnZ4/MrmkM5xfQ==
X-Google-Smtp-Source: ABdhPJxyTRwvoVvgePffldbPqIM+DHPWo8B9BoIRifCppljwRpRj1TCncLkkmECh49VoHiGC8fcj3A==
X-Received: by 2002:ad4:5f4c:: with SMTP id p12mr20339802qvg.11.1635870086654;
        Tue, 02 Nov 2021 09:21:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y9sm13469584qko.74.2021.11.02.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:21:26 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:21:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: Add new test for setting the chunk size.
Message-ID: <YYFlhQ+t8tQlCtaW@localhost.localdomain>
References: <20211029184245.3623973-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029184245.3623973-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 29, 2021 at 11:42:45AM -0700, Stefan Roesch wrote:
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
> ---
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
>  tests/btrfs/248     | 284 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/248.out |  12 ++
>  3 files changed, 369 insertions(+)
>  create mode 100755 tests/btrfs/248
>  create mode 100644 tests/btrfs/248.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac880bdd..759a0054 100644
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
> +	echo "$content" > /sys/fs/btrfs/${uuid}/${attr} 2>&1
> +	if [ $? -ne 0 ]; then
> +		_log_err "_set_btrfs_sysfs_attr cannot write ${attr}"
> +	fi
> +}
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
> +  	if [[ ! -e  /sys/fs/btrfs/${uuid}/${attr} ]]; then
> +			_notrun "Btrfs does not support sysfs $attr"
> +	fi

indention is off here.

> +}
> +
> diff --git a/tests/btrfs/248 b/tests/btrfs/248
> new file mode 100755
> index 00000000..ae7e8039
> --- /dev/null
> +++ b/tests/btrfs/248
> @@ -0,0 +1,284 @@
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
> +	btrfs fi show ${SCRATCH_MNT} --mbytes | grep devid >> $seqres.full
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
> +_scratch_mkfs_sized $((10 * 1024 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +# Get UUID of device.
> +UUID="$(findmnt -n -o UUID ${SCRATCH_MNT})"
> +echo "UUID = ${UUID}" >> ${seqres}.full
> +

Don't forget to delete this when you switch to using the helper below.

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
> +SECOND_DATA_CHUNK_SIZE_READ_B=$(cat /sys/fs/btrfs/${UUID}/allocation/data/chunk_size)
> +SECOND_METADATA_CHUNK_SIZE_READ_B=$(cat /sys/fs/btrfs/${UUID}/allocation/metadata/chunk_size)
> +

Should this be _get_btrfs_sysfs_attr?

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
> +	if [ $((FREE_SPACE_MB%THIRD_DATA_CHUNK_SIZE_MB)) -ne 0 ]; then
> +	       break
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
> +_set_btrfs_sysfs_attr ${SCRATCH_MNT} allocation/system/force_chunk_alloc 1 2>&1

You want the error to go to /dev/null, and then check $?.

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
> diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
> new file mode 100644
> index 00000000..cac054a6
> --- /dev/null
> +++ b/tests/btrfs/248.out
> @@ -0,0 +1,12 @@
> +QA output created by 248
> +Capture default chunk sizes.
> +First allocation.
> +Second allocation.
> +Calculate request size so last memory allocation cannot be completely fullfilled.
> +Third allocation.
> +Force allocation of system block type must fail.
> +_set_btrfs_sysfs_attr cannot write allocation/system/force_chunk_alloc
> +(see /root/xfstests/results//btrfs/248.full for details)

Testing failure here you generally want to 2>&1 /dev/null and then test for
failure and print that out, because the absolute path of results will be
different between configurations.  Thanks,

Josef
