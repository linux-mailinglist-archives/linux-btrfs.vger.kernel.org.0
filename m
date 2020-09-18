Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CD726E9D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRAPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 20:15:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAPa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 20:15:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I0EFN4105658;
        Fri, 18 Sep 2020 00:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Z/FSSNcJ9ts3DS/BWgrDEeObN+AoWCUbFAYk/ATBzWM=;
 b=O9YrmXG1te6AZBY6AXouPAJbuA7uWeeaUX6pZbicJjKhGat9GzUhUbjTNNzzlIKf30H5
 A46KN6pYI78hGbGBgSo7bHvBWX1ps+hx8e4Lwk9Bmduxe2MC40sywhzcNzyX6jRE68Vo
 Pw+EERyqWUi2UTkdyA3/glFB0Q9S53vyB8kB+ZQW9nhnTfFDyv7fFFFeL6mVS7UbcLwC
 e96CMtzMChxiT4M9qRL1R9b1UcR5iOU8ilE2Uh5jTXWosz04tskc7FJgSzBDhN1KQ/LW
 pDygSDs3slVMjCjSshBDtzADbgKtHfPWwuzWmidNIDmm+BFAWoN76EU7GXvpvvdVCqY9 ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrrcctm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 00:15:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08I0A6nv104616;
        Fri, 18 Sep 2020 00:15:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33khpnur3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 00:15:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08I0FRvF028261;
        Fri, 18 Sep 2020 00:15:27 GMT
Received: from [10.191.36.170] (/10.191.36.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 00:15:26 +0000
Subject: Re: [PATCH] btrfs: remove stale test for alien devices
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f4606506-78a1-4771-96cd-6bc28e6a7074@oracle.com>
Date:   Fri, 18 Sep 2020 08:15:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=2
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180000
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


The fix is not too far. It got stuck whether to use EUCLEAN or not.
Its better to fix the fix rather than killing the messenger in this case.



Thanks, Anand

On 17/9/20 10:13 pm, Johannes Thumshirn wrote:
> btrfs/198 is supposed to be a test for the patch
> "btrfs: remove identified alien device in open_fs_devices" but this patch
> was never merged in btrfs.
> 
> Remove the test from fstests as it is constantly failing.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   tests/btrfs/198   | 77 -----------------------------------------------
>   tests/btrfs/group |  1 -
>   2 files changed, 78 deletions(-)
>   delete mode 100755 tests/btrfs/198
> 
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> deleted file mode 100755
> index 2df075e27134..000000000000
> --- a/tests/btrfs/198
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2019 Oracle.  All Rights Reserved.
> -#
> -# FS QA Test 198
> -#
> -# Test stale and alien non-btrfs device in the fs devices list.
> -#  Bug fixed in:
> -#    btrfs: remove identified alien device in open_fs_devices
> -#
> -seq=`basename $0`
> -seqres=$RESULT_DIR/$seq
> -echo "QA output created by $seq"
> -
> -here=`pwd`
> -tmp=/tmp/$$
> -status=1	# failure is the default!
> -trap "_cleanup; exit \$status" 0 1 2 3 15
> -
> -_cleanup()
> -{
> -	cd /
> -	rm -f $tmp.*
> -}
> -
> -# get standard environment, filters and checks
> -. ./common/rc
> -. ./common/filter
> -. ./common/filter.btrfs
> -
> -# remove previous $seqres.full before test
> -rm -f $seqres.full
> -
> -# real QA test starts here
> -_supported_fs btrfs
> -_supported_os Linux
> -_require_command "$WIPEFS_PROG" wipefs
> -_require_scratch
> -_require_scratch_dev_pool 4
> -
> -workout()
> -{
> -	raid=$1
> -	device_nr=$2
> -
> -	echo $raid
> -	_scratch_dev_pool_get $device_nr
> -
> -	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
> -							_fail "mkfs failed"
> -
> -	# Make device_1 a free btrfs device for the raid created above by
> -	# clearing its superblock
> -
> -	# don't test with the first device as auto fs check (_check_scratch_fs)
> -	# picks the first device
> -	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> -	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
> -
> -	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> -	_mount -o degraded $device_2 $SCRATCH_MNT
> -	# Check if missing device is reported as in the 196.out
> -	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> -						_filter_btrfs_filesystem_show
> -
> -	_scratch_unmount
> -	_scratch_dev_pool_put
> -}
> -
> -workout "raid1" "2"
> -workout "raid5" "3"
> -workout "raid6" "4"
> -workout "raid10" "4"
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 1b5fa695a9f7..d5330cd85cd5 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -199,7 +199,6 @@
>   195 auto volume balance
>   196 auto metadata log volume
>   197 auto quick volume
> -198 auto quick volume
>   199 auto quick trim
>   200 auto quick send clone
>   201 auto quick punch log
> 
