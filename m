Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4612939FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391762AbgJTLXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 07:23:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57640 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391542AbgJTLXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 07:23:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KBJbw3003573;
        Tue, 20 Oct 2020 11:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yuNAdh+2Ur4Tq2HGcPud42wlE8y6ic/9H+x/nqJoNDk=;
 b=w1c9DSwmj6EcP3ib19G8PccP0Ni6oKxKr27bUNSMiPU+JD+rSMEpv2veQtllcLBHjSur
 2jSX/q8ozDYWaAdMKtyK7J3BtGkrF6ixqXxKtIjQOKSr5PY6xEe0KygqrAbF+Zwqz8hd
 /ebNRUwYHkqwQ1wfVercuh9GnHAUnjQPNtBNGR8YCoBHAlEDwvg1C67Jz2P7nKJv/K0I
 XliicRg7yipIksjNVmXLsH5kFXXwYAUZOuKw/W/ZbxDJoavkJzCBPVSHWeMjCQucwJAF
 mQ9BDnbYiTe1FuKh/BQiwW2IRuWPSS4NQ8QEKd8BEhNdbwi4OwJBYi6QjibUXSnAyhfx sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4atfkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 11:23:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KBJsnJ183283;
        Tue, 20 Oct 2020 11:21:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 348acqmwes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 11:21:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09KBLbuh030033;
        Tue, 20 Oct 2020 11:21:37 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 04:21:37 -0700
Subject: Re: [PATCH v2 1/2] btrfs: add a test case for btrfs seed device
 delete
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <cover.1599233551.git.anand.jain@oracle.com>
 <53f76be87a0b414d6074f358b45b40cf1419950b.1599233551.git.anand.jain@oracle.com>
 <CAL3q7H7Kkz=5gwaAyNvHoer+rYrqRPjjOL_reQay6DvQtU7HMw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3dfb9cfe-e0cf-f285-4777-4477e565fbb0@oracle.com>
Date:   Tue, 20 Oct 2020 19:21:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7Kkz=5gwaAyNvHoer+rYrqRPjjOL_reQay6DvQtU7HMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200077
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/10/20 11:45 pm, Filipe Manana wrote:
> On Sat, Sep 5, 2020 at 12:25 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> This is a regression test for the issue fixed by the kernel patch
>>     btrfs: fix put of uninitialized kobject after seed device delete
> 
> Now that the patch is in Linus' tree, we could have the commit id as well.
> Just a few comments below.
> 
>>
>> In this test case, we verify the seed device delete on a sprouted
>> filesystem.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2 drop the sysfs layout check as it breaks the test-case backward
>> compatibility.
>>
>>   tests/btrfs/219     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/219.out | 15 ++++++++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 99 insertions(+)
>>   create mode 100755 tests/btrfs/219
>>   create mode 100644 tests/btrfs/219.out
>>
>> diff --git a/tests/btrfs/219 b/tests/btrfs/219
>> new file mode 100755
>> index 000000000000..86f2a6991bd7
>> --- /dev/null
>> +++ b/tests/btrfs/219
>> @@ -0,0 +1,83 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 219
>> +#
>> +# Test for seed device-delete on a sprouted FS.
>> +# Requires kernel patch
>> +#    btrfs: fix put of uninitialized kobject after seed device delete
>> +#
>> +# Steps:
>> +#  Create a seed FS. Add a RW device to make it sprout FS and then delete
>> +#  the seed device.
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
> 
> s/generic/btrfs
> 
>> +_supported_os Linux
> 
> This should go away, _supported_os is gone now.
> 
>> +_require_test
>> +_require_scratch_dev_pool 2
>> +
>> +_scratch_dev_pool_get 2
>> +
>> +seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> 
> $AWK_PROG should be used instead.
> 
>> +
>> +_mkfs_dev $seed
>> +_mount $seed $SCRATCH_MNT
>> +
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> 
> Why the direct IO write? Why not buffered IO?
> I just tried the test, and it passes too with a buffered write (no -d).
> If there's any reason for using direct IO, it should be mentioned in a
> comment, and _require_odirect added at the top.
> 

  Ah. No there isn't any reason for using direct IO. I will take it out.



>> +_scratch_unmount
>> +$BTRFS_TUNE_PROG -S 1 $seed
>> +
>> +# Mount the seed device and add the rw device
>> +_mount -o ro $seed $SCRATCH_MNT
>> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
>> +_scratch_unmount
>> +
>> +# Now remount
>> +_mount $sprout $SCRATCH_MNT
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
> 
> Same comment here regarding the use of direct IO.
> 
>> +
>> +echo --- before delete ----
>> +od -x $SCRATCH_MNT/foo
>> +od -x $SCRATCH_MNT/bar
>> +
>> +$BTRFS_UTIL_PROG device delete $seed $SCRATCH_MNT
>> +_scratch_unmount
>> +_btrfs_forget_or_module_reload
>> +_mount $sprout $SCRATCH_MNT
>> +
>> +echo --- after delete ----
>> +od -x $SCRATCH_MNT/foo
>> +od -x $SCRATCH_MNT/bar
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
>> new file mode 100644
>> index 000000000000..d39e0d8ffafd
>> --- /dev/null
>> +++ b/tests/btrfs/219.out
>> @@ -0,0 +1,15 @@
>> +QA output created by 219
>> +--- before delete ----
>> +0000000 abab abab abab abab abab abab abab abab
>> +*
>> +4000000
>> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
>> +*
>> +4000000
>> +--- after delete ----
>> +0000000 abab abab abab abab abab abab abab abab
>> +*
>> +4000000
>> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
>> +*
>> +4000000
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 3295856d0c8c..3633fa66abe4 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -221,3 +221,4 @@
>>   216 auto quick seed
>>   217 auto quick trim dangerous
>>   218 auto quick volume
>> +219 auto quick volume seed
> 
> New tests were added in the meanwhile.
> For the next version don't forget to renumber the test to 224.
> 
> Other than those minor comments, it looks fine and it works.
> 

  Rest of the comments are accepted. I am sending v3.

Thanks, Anand

> Thanks.
> 
>> --
>> 2.25.1
>>
> 
> 

