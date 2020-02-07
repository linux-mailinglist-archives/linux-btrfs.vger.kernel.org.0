Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115F0155B47
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgBGP7b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 10:59:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55998 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGP7b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 10:59:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017FYJqo131277;
        Fri, 7 Feb 2020 15:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NJynFQC+J3hZndE3Kejw6DBfNcDNvipxIcBhAOmSFnM=;
 b=RHnNux/qBG2gO1EHOu/hSGzImG2xzsMHjHxQQS7rXPJJVmGLbZVx79ctLLXndEKGiaG3
 hcyC5b6WmZRFXTnGPAO+CD3zuSotRC/BBqCGesmeknryLGEbHluPcoGs6OJEZcindWR3
 NOPUu1JPud11LC7dtiME6wSehrs4rXrxDtnY+7lSGFiwmN9k9u/AnSc7L3VdpzM9fTzd
 Ic4gLwQTeGb+jiv5eeq/vG3fZz2VIitnH04LkkVcXaTD4jyfJh0zMwv5f0FrtSsNUDEr
 gR8e4Bd28h2mExgeI6ThAjbQce8Aa3KK+Yj16LDG8om0hbUEMHkFPlm0iBPtwuwhLVS+ 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xykbpgum4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 15:59:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017FYM5U071049;
        Fri, 7 Feb 2020 15:59:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y16pqyph4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 15:59:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017FxQeT032702;
        Fri, 7 Feb 2020 15:59:26 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 07:59:25 -0800
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
Date:   Fri, 7 Feb 2020 23:59:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/2/20 8:15 PM, Qu Wenruo wrote:
> 
> 
> On 2020/2/7 下午8:01, Anand Jain wrote:
>> On some systems btrfs/179 fails as the check finds that there is
>> difference in the qgroup counts.
>>
>> By the async nature of qgroup tree scan, the latest qgroup counts at the
>> time of umount might not be upto date,
> 
> Yes, so far so good.
> 
>> if it isn't then the check will
>> report the difference in count. The difference in qgroup counts are anyway
>> updated in the following mount, so it is not a real issue that this test
>> case is trying to verify.
> 
> No problem either.
> 
>> So make sure the qgroup counts are updated
>> before unmount happens and make the check happy.
> 
> But the solution doesn't look correct to me.
> 
> We should either make btrfs-check to handle such half-dropped case
> better,

  Check is ok. The count as check counts matches with the count after 
the mount. So what is recorded in the qgroup is not upto date.

> or find a way to wait for all subvolume drop to be finished in
> test case.

Yes this is one way. Just wait for few seconds will do, test passes. Do 
you know any better way?

Thanks, Anand

> Papering the test by rescan is not a good idea at all.
> If one day we really hit some qgroup accounting problem, this papering
> way could hugely reduce the coverage.
> 


> Thanks,
> Qu
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/179 | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tests/btrfs/179 b/tests/btrfs/179
>> index 4a24ea419a7e..74e91841eaa6 100755
>> --- a/tests/btrfs/179
>> +++ b/tests/btrfs/179
>> @@ -109,6 +109,14 @@ wait $snapshot_pid
>>   kill $delete_pid
>>   wait $delete_pid
>>   
>> +# By the async nature of qgroup tree scan, the latest qgroup counts at the time
>> +# of umount might not be upto date, if it isn't then the check will report the
>> +# difference in count. The difference in qgroup counts are anyway updated in the
>> +# following mount, so it is not a real issue that this test case is trying to
>> +# verify. So make sure the qgroup counts are updated before unmount happens.
>> +
>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>> +
>>   # success, all done
>>   echo "Silence is golden"
>>   
>>
> 
