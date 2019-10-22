Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B2E0096
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfJVJW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:22:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbfJVJW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:22:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9JU7E185939;
        Tue, 22 Oct 2019 09:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=r0On3Ng2/07J8MJK3pTZtz/lINk5i2yndF7Vfb19QHg=;
 b=adqNGilVASeQjfU3K1QwjV2oWt6Lj5F0mYKE7TdcT1236qRj34GegdkL4p3TR2EWTQqd
 43gHoCtIbAxYhkvIgsRBjKEgzaWuEoSW1kwqvh/MCm7QeesruuzbPXFjJaIinnWZ9WbL
 YXMEITHk+7JBshvIzpbDeDtgWEntG7PuViD0oicJyaFWzOEumfe4heGrohCa/E9J3QmU
 K1XV2oSxxV9aMoImr4HgafU/f600CrTCP/iLky/pWHMOQCfQ2C4dPdU7v5ko1SU9xv7N
 Z5LIJyBluRrP7MM7CGi4vikIWjFOxBvdCmmV5btX8jq8lJCM8hON+jOPHY7tT88Jw2ZV eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vqswtdee9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:22:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M936ZM014773;
        Tue, 22 Oct 2019 09:22:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vsx2qc8au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:22:54 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9M9MrZB011890;
        Tue, 22 Oct 2019 09:22:53 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 09:22:53 +0000
Subject: Re: [PATCH 2/2] fstest: btrfs/197: test for alien devices
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20191007094101.784-1-anand.jain@oracle.com>
 <20191007094101.784-2-anand.jain@oracle.com> <20191018091344.GL2622@desktop>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <007fb279-9dec-a5f1-d69d-8f0eade4b8fa@oracle.com>
Date:   Tue, 22 Oct 2019 17:23:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018091344.GL2622@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/18/19 5:13 PM, Eryu Guan wrote:
> On Mon, Oct 07, 2019 at 05:41:01PM +0800, Anand Jain wrote:
>> Test if btrfs.ko sucessfully identifies and reports the missing device,
>> if the missed device contians no btrfs magic string.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/197     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/197.out | 25 +++++++++++++++++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 105 insertions(+)
>>   create mode 100755 tests/btrfs/197
>>   create mode 100644 tests/btrfs/197.out
>>
>> diff --git a/tests/btrfs/197 b/tests/btrfs/197
>> new file mode 100755
>> index 000000000000..82e1a299ca43
>> --- /dev/null
>> +++ b/tests/btrfs/197
>> @@ -0,0 +1,79 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 197
>> +#
>> +# Test stale and alien device in the fs devices list.
>> +# Similar to the testcase btrfs/196 except that here the alien device no more
>> +# contains the btrfs superblock.
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/filter.btrfs
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_command "$WIPEFS_PROG" wipefs
>> +_require_scratch
>> +_require_scratch_dev_pool 4
>> +
>> +workout()
>> +{
>> +	raid=$1
>> +	device_nr=$2
>> +
>> +	echo $raid
>> +	_scratch_dev_pool_get $device_nr
>> +
>> +	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>> +							_fail "mkfs failed"
>> +
>> +	# Make device_1 an alien btrfs device for the raid created above by
>> +	# adding it to the $TEST_DIR
> 
> Stale comments above.

  updated in v2.

> Otherwise looks fine to me.
> 
>> +
>> +	# don't test with the first device as auto fs check (_check_scratch_fs)
>> +	# picks the first device
>> +	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
> 
> If creating a new btrfs works for btrfs/196, I wonder if we could merge
> the two tests into one test, firstly create a new fs & degraded mount,
> then wipefs & degraded mount.

  Its better if they are separate. The workout is already looping for
  different raids. Per experiences from btrfs/011 it gets harder to
  debug with testing different cases in one test case. Can I keep them
  separate?

  V2 is being sent out in a while.

Thanks, Anand

> Thanks,
> Eryu
> 
>> +
>> +	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +	_mount -o degraded $device_2 $SCRATCH_MNT
>> +	# Check if missing device is reported as in the 196.out
>> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>> +						_filter_btrfs_filesystem_show
>> +
>> +	_scratch_unmount
>> +	_scratch_dev_pool_put
>> +}
>> +
>> +workout "raid1" "2"
>> +workout "raid5" "3"
>> +workout "raid6" "4"
>> +workout "raid10" "4"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/197.out b/tests/btrfs/197.out
>> new file mode 100644
>> index 000000000000..79237b854b5a
>> --- /dev/null
>> +++ b/tests/btrfs/197.out
>> @@ -0,0 +1,25 @@
>> +QA output created by 197
>> +raid1
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
>> +
>> +raid5
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
>> +
>> +raid6
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
>> +
>> +raid10
>> +Label: none  uuid: <UUID>
>> +	Total devices <NUM> FS bytes used <SIZE>
>> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>> +	*** Some devices missing
>> +
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index c86ea2516397..f2eac5c20712 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -199,3 +199,4 @@
>>   194 auto volume
>>   195 auto volume
>>   196 auto quick volume
>> +197 auto quick volume
>> -- 
>> 1.8.3.1
>>
