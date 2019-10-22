Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE52E0095
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfJVJWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 05:22:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbfJVJWv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 05:22:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M9JQos164887;
        Tue, 22 Oct 2019 09:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mS/SLkLedDo/r9lDiCdg45axH+Onqjfk6TPC7dAt+pM=;
 b=liUPdNXew58C2JcabVuJh/XQ+yipOyrn35sE0bo8jUy268MmxoOPEA/SXJHrFupA8c4A
 06dVB5FTCVA4UlNp4R1M2uewJBybkDiXdHgkm02giVIDTCI6fejRz7AdAohboQhO76Sr
 wdaBW91elahi8yTBA8BEvtU78cVl915Fy7nxMik6TSXOdrtndGvZTQeAfFeGBqVNn/dQ
 rUCGI4twv+2OBvAFYHB0XdraCnTE8zxQvH+hrVtD724hcnTDsS3yq/gmr8vqxWXVZRvX
 P0vNThEoL6YngCdq/3gUWtEu1xEN/srb/OOMplpWZZN6SyPnaoXaQWLVgtikH9Jakl6C jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qn522-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:22:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9M937Tu014987;
        Tue, 22 Oct 2019 09:22:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vsx2qc838-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 09:22:48 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9M9MlX8011796;
        Tue, 22 Oct 2019 09:22:47 GMT
Received: from [10.186.52.87] (/10.186.52.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 02:22:47 -0700
Subject: Re: [PATCH 1/2] fstest: btrfs/196: test for alien btrfs-devices
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20191007094101.784-1-anand.jain@oracle.com>
 <20191018091019.GK2622@desktop>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <81b63597-7afb-23d3-58be-1329d55dd06b@oracle.com>
Date:   Tue, 22 Oct 2019 17:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018091019.GK2622@desktop>
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



On 10/18/19 5:10 PM, Eryu Guan wrote:
> On Mon, Oct 07, 2019 at 05:41:00PM +0800, Anand Jain wrote:
>> Test if btrfs.ko sucessfully identifies and reports the missing device,
>> if the missed device contians someother btrfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/196     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/196.out | 25 +++++++++++++++++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 103 insertions(+)
>>   create mode 100755 tests/btrfs/196
>>   create mode 100644 tests/btrfs/196.out
>>
>> diff --git a/tests/btrfs/196 b/tests/btrfs/196
>> new file mode 100755
>> index 000000000000..e35cdce492e5
>> --- /dev/null
>> +++ b/tests/btrfs/196
>> @@ -0,0 +1,77 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Oracle.  All Rights Reserved.
>> +#
>> +# FS QA Test 196
>> +#
>> +# Test stale and alien btrfs-device in the fs devices list.
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
> 
> _supported_os btrfs

  Thanks fixed in v2.

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
> Instead of adding $device_1 to $TEST_DIR, does creating a new btrfs on
> $device_1 work? I'm a bit worried that changing $TEST_DIR/$TEST_DEV
> configuration would have some side effects, e.g. we add it to $TEST_DIR
> and cancle the test before removing it, the $TEST_DEV will end up in an
> unexpected state in next test run. (Though we could remove the device in
> _cleanup, this is just an example.)

  In v2 I am avoiding adding $device_1 to $TEST_DIR.
  Instead, I am using $SPARE_DEV to create a new btrfs and $device_1
  is added to it. I feel this is a better fix which shall completely
  avoid messing up the $TEST_DEV. Thanks.

>> +
>> +	# don't test with the first device as auto fs check (_check_scratch_fs)
>> +	# picks the first device
>> +	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR"
>> +
>> +	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +	_mount -o degraded $device_2 $SCRATCH_MNT
>> +	# Check if missing device is reported as in the 196.out
> 
> Test could be renumbered, no need to hardcode 196.out, just ".out file"
> would be fine.

  Oh. Thanks this is fixed in v2.

>> +	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>> +						_filter_btrfs_filesystem_show
>> +
>> +	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR"
> 
> I think we should remove $device_1 in _cleanup if it's not empty in case
> test exits unexpectly. But as mentioned above, better to avoid adding
> new device to $TEST_DIR.

  As I am not using $TEST_DIR to add the $device_1. So this won't be
  needed now.


Thanks, Anand

> Thanks,
> Eryu
> 
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
>> diff --git a/tests/btrfs/196.out b/tests/btrfs/196.out
>> new file mode 100644
>> index 000000000000..311ae9e2f46a
>> --- /dev/null
>> +++ b/tests/btrfs/196.out
>> @@ -0,0 +1,25 @@
>> +QA output created by 196
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
>> index 3ce6fa4628d8..c86ea2516397 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -198,3 +198,4 @@
>>   193 auto quick qgroup enospc limit
>>   194 auto volume
>>   195 auto volume
>> +196 auto quick volume
>> -- 
>> 1.8.3.1
>>
