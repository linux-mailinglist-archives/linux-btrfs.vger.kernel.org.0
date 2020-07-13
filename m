Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D633321D4A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMLPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 07:15:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGMLPn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 07:15:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F0AEB18C;
        Mon, 13 Jul 2020 11:15:41 +0000 (UTC)
Subject: Re: [PATCH v2] fstests: btrfs test if show_devname returns sprout
 device
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <6dcd6b3c-06a9-51a7-988b-63cb254d7749@suse.com>
 <20200713110017.66825-1-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f8d76542-f7bb-5207-267e-82dae31e49af@suse.com>
Date:   Mon, 13 Jul 2020 14:15:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713110017.66825-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.07.20 г. 14:00 ч., Anand Jain wrote:
> Test if the show_devname() returns sprout device instead of seed device.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: check for presence of needed sprout device.
> 
>  common/filter       |  8 ++++++
>  tests/btrfs/215     | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/215.out |  2 ++
>  tests/btrfs/group   |  1 +
>  4 files changed, 70 insertions(+)
>  create mode 100755 tests/btrfs/215
>  create mode 100644 tests/btrfs/215.out
> 
> diff --git a/common/filter b/common/filter
> index 2477f3860151..992783aba187 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -284,6 +284,14 @@ _filter_test_dir()
>  	    -e "s,\B$TEST_DEV,TEST_DEV,g"
>  }
>  
> +_filter_devs()
> +{
> +	local filter_devs
> +
> +	filter_devs=$(echo $1 | sed -e 's/\s\+/\\\|/g')
> +	sed -e "s,$filter_devs,SCRATCH_DEV,g"
> +}
> +
>  _filter_scratch()
>  {
>  	# SCRATCH_DEV may be a prefix of SCRATCH_MNT (e.g. /mnt, /mnt/ovl-mnt)
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> new file mode 100755
> index 000000000000..cf5e360d14b1
> --- /dev/null
> +++ b/tests/btrfs/215
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 215
> +#
> +# Test if the show_devname() returns sprout device instead of seed device.
> +#
> +# Fixed in kernel patch:
> +#   btrfs: btrfs_show_devname don't traverse into the seed fsid
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +
> +seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +_mkfs_dev $seed
> +$BTRFS_TUNE_PROG -S 1 $seed
> +_mount $seed $SCRATCH_MNT >> $seqres.full 2>&1
> +cat /proc/self/mounts | grep $seed >> $seqres.full
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +cat /proc/self/mounts | grep $sprout >> $seqres.full
> +
> +# check if the show_devname() returns the sprout device instead of seed device.
> +cat /proc/self/mounts | grep $SCRATCH_MNT | awk '{print $1}' | \
> +							_filter_devs $sprout

Why does this have to be so complicated - 4 chained program executions,
1 additional function...

dev=$(grep $SCRATCH_MOUNT /proc/mounts | awk '{printf $1}')

if [ $sprout != $dev ]; then
 _fail "Unexpected device"
fi


> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/215.out b/tests/btrfs/215.out
> new file mode 100644
> index 000000000000..ed3207851653
> --- /dev/null
> +++ b/tests/btrfs/215.out
> @@ -0,0 +1,2 @@
> +QA output created by 215
> +SCRATCH_DEV
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 505665b54d61..76c8b78d08f9 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -217,3 +217,4 @@
>  212 auto balance dangerous
>  213 auto balance dangerous
>  214 auto quick send snapshot
> +215 auto quick seed
> 
