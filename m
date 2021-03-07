Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5077330376
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Mar 2021 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCGRzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 12:55:02 -0500
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:41344 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhCGRyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 12:54:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07491462|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0450079-0.00103639-0.953956;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JhfGnoO_1615139672;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JhfGnoO_1615139672)
          by smtp.aliyun-inc.com(10.147.41.231);
          Mon, 08 Mar 2021 01:54:32 +0800
Date:   Mon, 8 Mar 2021 01:54:32 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstest: random read fio test for read policy
Message-ID: <YEUTWFeU6yv5jfx9@desktop>
References: <746eadd73fb847050f1dc3a6c47756259c73e73d.1614005115.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746eadd73fb847050f1dc3a6c47756259c73e73d.1614005115.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 06:48:18AM -0800, Anand Jain wrote:
> This test case runs fio for raid1/10/1c3/1c4 profiles and all the
> available read policies in the system. At the end of the test case,
> a comparative summary of the result is in the $seqresfull-file.
> 
> LOAD_FACTOR parameter controls the fio scalability. For the
> LOAD_FACTOR = 1 (default), this runs fio for file size = 1G and num
> of jobs = 1, which approximately takes 65s to finish.
> 
> There are two objectives of this test case. 1. by default, with
> LOAD_FACTOR = 1, it sanity tests the read policies. And 2. Run the
> test case individually with a larger LOAD_FACTOR. For example, 10
> for the comparative study of the read policy performance.
> 
> I find tests/btrfs as the placeholder for this test case. As it
> contains many things which are btrfs specific and didn't fit well
> under perf.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I'd like to let btrfs folks to review as well, to see if this is a sane
test for btrfs.

Thanks,
Eryu

> ---
>  tests/btrfs/231     | 145 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/231.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 148 insertions(+)
>  create mode 100755 tests/btrfs/231
>  create mode 100644 tests/btrfs/231.out
> 
> diff --git a/tests/btrfs/231 b/tests/btrfs/231
> new file mode 100755
> index 000000000000..c08b5826f60a
> --- /dev/null
> +++ b/tests/btrfs/231
> @@ -0,0 +1,145 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
> +#
> +# FS QA Test 231
> +#
> +# Random read fio test for raid1(10)(c3)(c4) with available
> +# read policy.
> +# 
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +fio_config=$tmp.fio
> +fio_results=$tmp.fio_out
> +
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
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +
> +njob=$LOAD_FACTOR
> +size=$LOAD_FACTOR
> +_require_scratch_size $(($size * 2 * 1024 * 1024))
> +echo size=$size njob=$njob >> $seqres.full
> +
> +make_fio_config()
> +{
> +	#Set direct IO to true, help to avoid buffered IO so that read happens
> +	#from the devices.
> +	cat >$fio_config <<EOF
> +[global]
> +bs=64K
> +iodepth=64
> +direct=1
> +invalidate=1
> +allrandrepeat=1
> +ioengine=libaio
> +group_reporting
> +size=${size}G
> +rw=randread
> +EOF
> +}
> +#time_based
> +#runtime=5
> +
> +make_fio_config
> +for job in $(seq 0 $njob); do
> +	echo "[foo$job]" >> $fio_config
> +	echo  "filename=$SCRATCH_MNT/$job/file" >> $fio_config
> +done
> +_require_fio $fio_config
> +cat $fio_config >> $seqres.full
> +
> +work()
> +{
> + 	raid=$1
> +
> +	echo ------------- profile: $raid ---------- >> $seqres.full
> +	echo >> $seqres.full
> +	_scratch_pool_mkfs $raid >> $seqres.full 2>&1
> +	_scratch_mount
> +
> +	fsid=$($BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | grep uuid: | \
> +	     $AWK_PROG '{print $4}')
> +	readpolicy_path="/sys/fs/btrfs/$fsid/read_policy"
> +	policies=$(cat $readpolicy_path | sed 's/\[//g' | sed 's/\]//g')
> +
> +	for policy in $policies; do
> +		echo $policy > $readpolicy_path || _fail "Fail to set readpolicy"
> +		echo -n "activating readpolicy: " >> $seqres.full
> +		cat $readpolicy_path >> $seqres.full
> +		echo >> $seqres.full
> +
> +		> $fio_results
> +		$FIO_PROG --output=$fio_results $fio_config
> +		cat $fio_results >> $seqres.full
> +	done
> +
> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +_scratch_dev_pool_get 2
> +work "-m raid1 -d single"
> +
> +_scratch_dev_pool_get 2
> +work "-m raid1 -d raid1"
> +
> +_scratch_dev_pool_get 4
> +work "-m raid10 -d raid10"
> +
> +_scratch_dev_pool_get 3
> +work "-m raid1c3 -d raid1c3"
> +
> +_scratch_dev_pool_get 4
> +work "-m raid1c4 -d raid1c4"
> +
> +
> +# Now benchmark the raw device performance
> +> $fio_config
> +make_fio_config
> +_scratch_dev_pool_get 4
> +for dev in $SCRATCH_DEV_POOL; do
> +	echo "[$dev]" >> $fio_config
> +	echo  "filename=$dev" >> $fio_config
> +done
> +_require_fio $fio_config
> +cat $fio_config >> $seqres.full
> +
> +echo ------------- profile: raw disk ---------- >> $seqres.full
> +echo >> $seqres.full
> +> $fio_results
> +$FIO_PROG --output=$fio_results $fio_config
> +cat $fio_results >> $seqres.full
> +
> +echo >> $seqres.full
> +echo ===== Summary ====== >> $seqres.full
> +cat $seqres.full | egrep -A1 "Run status|Disk stats|profile:|readpolicy" >> $seqres.full
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
> new file mode 100644
> index 000000000000..a31b87a289bf
> --- /dev/null
> +++ b/tests/btrfs/231.out
> @@ -0,0 +1,2 @@
> +QA output created by 231
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a7c6598326c4..7f449d1db99e 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -233,3 +233,4 @@
>  228 auto quick volume
>  229 auto quick send clone
>  230 auto quick qgroup limit
> +231 other
> -- 
> 2.27.0
