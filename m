Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64711A507
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 08:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLKHYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 02:24:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKHYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 02:24:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB7OGkK130647;
        Wed, 11 Dec 2019 07:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=yllTQpKGwKQENzZajlnZSX/T9lS3CgOM/zZ41CAQtAA=;
 b=JbtF1oykK78uWtEqguPVY03PthkSw0y/OP7a36EQ3w9l/zZJN5PDoypBVw9dXKkQi2v2
 d2UZgAI88hV4Q4ih5g+eS4gogCddxKObTZKzwUg0ppbYZ/Zj5Fg4VFQmuqZHR7QwjEiq
 qDTPdQ4nnFNEIUIlnSg0B6Y8jPYdCZFMVgRoxYz1dzYfH3BA9FKcmsWA5KuCzdm173AF
 18uYgDADqzs0tPByqq4eRPHnY0B6K3mv5yEAePz/Tc5ypdLZSeArQv/CBI/CiMHZF+f4
 v2/x+UomS5x1FHWsrmplGDseTu0cP7XhLxkD6+1WtrRoQ8WSdKK0Cl7YxWTgw3v6H3iL 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wrw4n7n0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 07:24:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB7OLMm196127;
        Wed, 11 Dec 2019 07:24:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wtqdu3yah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 07:24:30 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBB7NLJM030462;
        Wed, 11 Dec 2019 07:23:21 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 23:23:20 -0800
Subject: Re: [PATCHi RFC] fstest: btrfs/158 fix miss-aligned stripe and device
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
References: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
 <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
 <b89463c5-9f0d-b262-0198-2750e0b2aabc@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6025418e-25ce-19f9-3c53-6b094609098c@oracle.com>
Date:   Wed, 11 Dec 2019 15:23:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b89463c5-9f0d-b262-0198-2750e0b2aabc@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/11/19 3:08 PM, Qu Wenruo wrote:
> 
> 
> On 2019/12/11 下午2:08, Anand Jain wrote:
>> We changed the order of the allocation on the devices, and
>> so the test cases which are hard coded to find specific stripe
>> on the specific device gets failed. So fix it with the new layout.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Qu, Right we need to fix the dev in the test case as well.
>>      I saw your patches bit late. Here is what I had.. you may
>>      use it. So I am marking this patch as RFC.
> 
> I am crafting a better solution, to handle both behavior (and even
> future behavior), by getting both devid and physical offset.

  Yep helper function using either,
    devid and btrfs fi show
    or
    uuid  and blkid

  would dynamically find the right device.

  I am ok with either.

> And I tend to remove the fail_make_request requirement from some tests,
> and direct read with multiple try should be enough to trigger repair for
> test btrfs/142 and btrfs/143.
> 

> In fact, I don't believe your current fix is good enough to handle both
> old and new mkfs.btrfs.

  It was designed to handle only forward compatible.

Thanks, Anand

> So we need to investigate more for raid repair test cases to make them
> future proof.
> 
> Thanks,
> Qu
>> Thanks.
>>
>>   tests/btrfs/158     | 10 +++++-----
>>   tests/btrfs/158.out |  4 ++--
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/btrfs/158 b/tests/btrfs/158
>> index 603e8bea9b7e..7f2066384f55 100755
>> --- a/tests/btrfs/158
>> +++ b/tests/btrfs/158
>> @@ -76,14 +76,14 @@ _scratch_unmount
>>   
>>   stripe_0=`get_physical_stripe0`
>>   stripe_1=`get_physical_stripe1`
>> -dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
>> -dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
>> +dev1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
>> +dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
>>   
>>   # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
>> -echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
>> +echo "step 2......simulate bitrot at offset $stripe_0 of device_1($dev1) and offset $stripe_1 of device_2($dev2)" >>$seqres.full
>>   
>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev1 | _filter_xfs_io
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev2 | _filter_xfs_io
>>   
>>   # step 3: scrub filesystem to repair the bitrot
>>   echo "step 3......repair the bitrot" >> $seqres.full
>> diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
>> index 1f5ad3f76917..5cdaeb238c62 100644
>> --- a/tests/btrfs/158.out
>> +++ b/tests/btrfs/158.out
>> @@ -1,9 +1,9 @@
>>   QA output created by 158
>>   wrote 131072/131072 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes at offset 9437184
>> +wrote 65536/65536 bytes at offset 22020096
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes at offset 9437184
>> +wrote 65536/65536 bytes at offset 1048576
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>>   *
>>
> 
