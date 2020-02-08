Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B56156388
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2020 10:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBHJHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 04:07:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41650 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgBHJHL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Feb 2020 04:07:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 01894vhT057588;
        Sat, 8 Feb 2020 09:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fBlNkLj7F+aOk6tLBCyoaTh6Qi9ABDfmT1WVlXD+6nI=;
 b=Fnhdvo66F1OC6YqZPeftn1WxuvHSyTQ1974gMitfCI2Z9RbFXFVRMVtJhgFbICFXTzc6
 I2BcTISCJTGclD3TVY7RE1j+02Ty/K8VgO0wpoeJ+SBBG7OD2RIk0N8kWoHnBrx8neM/
 ZRYb42+BZP+AxKbUS3WBnAPGanza4oBGMHNqRXKq0hNy7AssPvPvcixXPyHjgTWo9Qwd
 uSMb/umCeDpqrtMqGQ7lv8R71P0jjqqMbEH9xVm5zVYpKdCTRzfgi1CSmgOwDR5MeHpQ
 9O4tKi3t8ZPCd+d72Vs0h4+4AFoLdVY6+NvXlLvmaNM1Jc15OHYIZSlb4CZXHb67siu9 mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y1nms0f10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Feb 2020 09:07:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 01894k01122625;
        Sat, 8 Feb 2020 09:07:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y1k1snc6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Feb 2020 09:07:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01897323008508;
        Sat, 8 Feb 2020 09:07:03 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Feb 2020 01:07:03 -0800
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
 <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
Date:   Sat, 8 Feb 2020 17:06:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002080076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9524 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002080076
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/8/20 7:28 AM, Qu Wenruo wrote:
> 
> 
> On 2020/2/7 下午11:59, Anand Jain wrote:
>>
>>
>> On 7/2/20 8:15 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/2/7 下午8:01, Anand Jain wrote:
>>>> On some systems btrfs/179 fails as the check finds that there is
>>>> difference in the qgroup counts.
>>>>
>>>> By the async nature of qgroup tree scan, the latest qgroup counts at the
>>>> time of umount might not be upto date,
>>>
>>> Yes, so far so good.
>>>
>>>> if it isn't then the check will
>>>> report the difference in count. The difference in qgroup counts are
>>>> anyway
>>>> updated in the following mount, so it is not a real issue that this test
>>>> case is trying to verify.
>>>
>>> No problem either.
>>>
>>>> So make sure the qgroup counts are updated
>>>> before unmount happens and make the check happy.
>>>
>>> But the solution doesn't look correct to me.
>>>
>>> We should either make btrfs-check to handle such half-dropped case
>>> better,
>>
>>   Check is ok. The count as check counts matches with the count after the
>> mount. So what is recorded in the qgroup is not upto date.
> 
> Nope. Qgroup records what's in commit tree. For unmounted fs, there is
> no difference in commit tree and current tree.
> 
> Thus the qgroup scan in btrfs-progs is different from kernel.
> Please go check how the btrfs-progs code to see how the difference comes.
> 
>>
>>> or find a way to wait for all subvolume drop to be finished in
>>> test case.
>>
>> Yes this is one way. Just wait for few seconds will do, test passes. Do
>> you know any better way?
> 
> I didn't remember when, but it looks like `btrfs fi sync` used to wait
> for snapshot drop.
> But not now. If we have a way to wait for cleaner to finish, we can
> solve it pretty easily.

A sleep at the end of the test case also makes it count consistent.
As the intention of the test case is to test for the hang, so sleep 5
at the end of the test case is reasonable.

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> Papering the test by rescan is not a good idea at all.
>>> If one day we really hit some qgroup accounting problem, this papering
>>> way could hugely reduce the coverage.
>>>
>>
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>    tests/btrfs/179 | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/tests/btrfs/179 b/tests/btrfs/179
>>>> index 4a24ea419a7e..74e91841eaa6 100755
>>>> --- a/tests/btrfs/179
>>>> +++ b/tests/btrfs/179
>>>> @@ -109,6 +109,14 @@ wait $snapshot_pid
>>>>    kill $delete_pid
>>>>    wait $delete_pid
>>>>    +# By the async nature of qgroup tree scan, the latest qgroup
>>>> counts at the time
>>>> +# of umount might not be upto date, if it isn't then the check will
>>>> report the
>>>> +# difference in count. The difference in qgroup counts are anyway
>>>> updated in the
>>>> +# following mount, so it is not a real issue that this test case is
>>>> trying to
>>>> +# verify. So make sure the qgroup counts are updated before unmount
>>>> happens.
>>>> +
>>>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>>>> +
>>>>    # success, all done
>>>>    echo "Silence is golden"
>>>>   
>>>
> 
