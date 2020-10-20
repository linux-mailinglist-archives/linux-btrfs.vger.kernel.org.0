Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E292C293B57
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405922AbgJTMVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:21:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49132 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405916AbgJTMVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:21:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KC93iq094672;
        Tue, 20 Oct 2020 12:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HAeJQOKFnRexZEqFN2KwPP1tlTyqDjjae1cNalCLusg=;
 b=UHyjEg96womFxA3ACnHihL5UWa0Qn/Qu8io8hWktwx/ETCjCYOJnkvFDR/snlaQZ3wvd
 AicVHQYIRYUNUbB535RlDv4Tu1uXJ6PcYsuBKG+g7WcHd41UJIW/4jXxMsxwOZNoT9CF
 vLvChbrg17NYIUEDnBg91qMRqg2lsALNWklwK3wSj9xdE9R88sCXQ720EfFRZBfk2t91
 /bkxPbmcKP5MuqBLPW2vYdq+mH5W3XeVsH4qqQ1it1eHpp3AOnyry4wOUGcV9rRVccqq
 u/CpFZQTmDgjpWan0ik3a1HeOBhRoqF9yh4xeOyRGoGCbukyQFSxe9pim6mIWCBcX2XN iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 347p4atq1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 12:21:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCA2M2141338;
        Tue, 20 Oct 2020 12:21:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 348a6n35gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 12:21:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09KCL4rr026307;
        Tue, 20 Oct 2020 12:21:05 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 05:21:04 -0700
Subject: Re: [PATCH 2/2] btrfs/163: replace sprout instead of seed
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <cover.1599233551.git.anand.jain@oracle.com>
 <2378cbf0ec6f649de7269a756b652f0b7a6619b3.1599233551.git.anand.jain@oracle.com>
 <CAL3q7H5kmY5pGqXpWF6gycVOuf-9GqtWXgqJrDPcDGe=0W=Jaw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <593e4df2-fa81-841b-a63f-4f0086709960@oracle.com>
Date:   Tue, 20 Oct 2020 20:20:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5kmY5pGqXpWF6gycVOuf-9GqtWXgqJrDPcDGe=0W=Jaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=1 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200085
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/10/20 11:49 pm, Filipe Manana wrote:
> On Sat, Sep 5, 2020 at 12:25 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Make this test case inline with the kernel patch [1] changes
>> [1] btrfs: fix replace of seed device
> 
> Same comment as in the previous patch. Now that this is in Linus'
> tree, it would be good to mention the commit id too.

  Added in v3.

>>
>> So use the sprout device as the replace target instead of the seed device..
>> This change is compatible with the older kernels.
>>
>> While at this, this patch also fixes a typo fix as well.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/163     | 21 ++++++++++++++++-----
>>   tests/btrfs/163.out |  5 ++++-
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/btrfs/163 b/tests/btrfs/163
>> index 24c725afb6b9..354d88502d47 100755
>> --- a/tests/btrfs/163
>> +++ b/tests/btrfs/163
>> @@ -4,11 +4,15 @@
>>   #
>>   # FS QA Test 163
>>   #
>> -# Test case to verify that a seed device can be replaced
>> +# Test case to verify that a sprouted device can be replaced
>>   #  Create a seed device
>>   #  Create a sprout device
>>   #  Remount RW
>> -#  Run device replace on the seed device
>> +#  Run device replace on the sprout device
>> +#
>> +# Depends on the kernel patch
>> +#   btrfs: fail replace of seed device
>> +
>>   seq=`basename $0`
>>   seqres=$RESULT_DIR/$seq
>>   echo "QA output created by $seq"
>> @@ -39,6 +43,7 @@ _supported_fs btrfs
>>   _supported_os Linux
>>   _require_command "$BTRFS_TUNE_PROG" btrfstune
>>   _require_scratch_dev_pool 3
>> +_require_btrfs_forget_or_module_loadable
>>
>>   _scratch_dev_pool_get 3
>>
>> @@ -52,7 +57,7 @@ create_seed()
>>          run_check _mount $dev_seed $SCRATCH_MNT
>>          $XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
>>                  /dev/null
>> -       echo -- gloden --
>> +       echo -- golden --
>>          od -x $SCRATCH_MNT/foobar
>>          _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>>          _scratch_unmount
>> @@ -64,22 +69,28 @@ add_sprout()
>>   {
>>          _run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
>>          _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>> +       _mount -o remount,rw $dev_sprout $SCRATCH_MNT
>> +       $XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
>> +               /dev/null
> 
> Same comment as for the other patch.
> Why the direct IO? The test passes with buffered IO as well.
> If there's a reason for direct IO, it should be mentioned in a comment
> and _require_odirect added above.
> 

  Yes. No need of the directio here. Thanks.

>>   }
>>
>>   replace_seed()
>>   {
>> -       _run_btrfs_util_prog replace start -fB $dev_seed $dev_replace_tgt $SCRATCH_MNT
>> +       _run_btrfs_util_prog replace start -fB $dev_sprout $dev_replace_tgt $SCRATCH_MNT
> 
> So now the function should be renamed from replace_seed() to
> replace_sprout() as well. Shouldn't it?
> 

  Good catch will fix the function name.

> Other than that, it looks good and it works as expected.
> 

  All comments are fixed in v3.


Thanks, Anand

> Thanks.
> 
>>          _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>>          _scratch_unmount
>> -       run_check _mount $dev_replace_tgt $SCRATCH_MNT
>> +       _btrfs_forget_or_module_reload
>> +       run_check _mount -o device=$dev_seed $dev_replace_tgt $SCRATCH_MNT
>>          echo -- sprout --
>>          od -x $SCRATCH_MNT/foobar
>> +       od -x $SCRATCH_MNT/foobar2
>>          _scratch_unmount
>>
>>   }
>>
>>   seed_is_mountable()
>>   {
>> +       _btrfs_forget_or_module_reload
>>          run_check _mount $dev_seed $SCRATCH_MNT
>>          _run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>>          _scratch_unmount
>> diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
>> index 91f6f5b6f48a..351ef7b040b2 100644
>> --- a/tests/btrfs/163.out
>> +++ b/tests/btrfs/163.out
>> @@ -1,5 +1,5 @@
>>   QA output created by 163
>> --- gloden --
>> +-- golden --
>>   0000000 abab abab abab abab abab abab abab abab
>>   *
>>   20000000
>> @@ -7,3 +7,6 @@ QA output created by 163
>>   0000000 abab abab abab abab abab abab abab abab
>>   *
>>   20000000
>> +0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
>> +*
>> +20000000
>> --
>> 2.25.1
>>
> 
> 

