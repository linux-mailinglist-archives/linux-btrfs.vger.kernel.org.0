Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE512E4D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 11:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgABKMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 05:12:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgABKMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 05:12:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002ABB55130677;
        Thu, 2 Jan 2020 10:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=+fbmfCvC9fryVZVfvMikjtCBN/nxFN1UlH40mf3EiX4=;
 b=fYfEODNqklJsy4xLG2/BU6POQe6FSDriJIcf2wm53tttHJCLLOAw6nXUZmZUwkcmUH2u
 YX33p7xDGiuek6ARPsvocQCUGulXr/WsHezHec8RrWNqHDH/5M/jz+helYt/FdYfozU0
 nLpE15sQ6n6z2Ar593WtBdeqUYXV6i+C/ffRIPWVX32hCLOl4aW0T6e33+yOCl2cDLJI
 A/Ut8USQSPm/UUefqOPFCOGbe+1UVWMJ9rDtUsWC0q/f88ZYCQdrE9K6Lui21UYh3NTG
 lLd90GJcqDUiUlW3RJpvz1olYKQmYkIO9O6ciLuDlc5r3SAkCw01wEfDYywRYkApN8hC 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2x5ypqpjxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 10:12:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 002A9atd039281;
        Thu, 2 Jan 2020 10:12:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2x7meeqdev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jan 2020 10:12:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 002ACQ3P008004;
        Thu, 2 Jan 2020 10:12:26 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 02:12:26 -0800
Subject: Re: [PATCH 1/3] btrfs: add readmirror type framework
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
 <1576818365-20286-2-git-send-email-anand.jain@oracle.com>
 <697fabec-d060-b7eb-8f56-25fb8db052a6@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <15bbc61d-6606-ab1b-0b4d-c62f59c36ee6@oracle.com>
Date:   Thu, 2 Jan 2020 18:12:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <697fabec-d060-b7eb-8f56-25fb8db052a6@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9487 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001020092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/20/19 10:44 PM, Josef Bacik wrote:
> On 12/20/19 12:06 AM, Anand Jain wrote:
>> As of now we use %pid method to read stripped mirrored data. So
>> application's process id determines the stripe id to be read. This type
>> of routing typically helps in a system with many small independent
>> applications tying to read random data. On the other hand the %pid
>> based read IO distribution policy is inefficient if there is a single
>> application trying to read large data and the overall disk bandwidth
>> remains under utilized.
>>
>> So this patch introduces a framework where we could add more readmirror
>> policies, such as routing the IO based on device's waitqueue or manual
>> when we have a read-preferred device or a policy based on the target
>> storage caching.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 16 +++++++++++++++-
>>   fs/btrfs/volumes.h |  8 ++++++++
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c95e47aa84f8..0c6caae29248 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct 
>> btrfs_fs_devices *fs_devices,
>>       fs_devices->opened = 1;
>>       fs_devices->latest_bdev = latest_dev->bdev;
>>       fs_devices->total_rw_bytes = 0;
>> +    /* Set the default readmirror policy */
>> +    atomic_set(&fs_devices->readmirror, BTRFS_READMIRROR_DEFAULT);
> There's no reason for this to be atomic, it's just a behavior change, if 
> you really want to be super safe use READ_ONCE/WRITE_ONCE and have 
> readmirror be your enum.  Thanks,

  Agreed fs_devices::readmirror doesn't have to be atmoic_t. Fixed this
  to declare it as u8 in v2.

Thanks, Anand


> Josef

