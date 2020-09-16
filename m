Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504D26C344
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgIPN1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 09:27:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIPNXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 09:23:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GBp5nR040213;
        Wed, 16 Sep 2020 11:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HUlKETeBlC5R81Hx+usI+c/TnVgj8NTdQh21tfx+Aus=;
 b=OsR3wBBckD/gm6qS7NG2GEBUK4j7Vi+RkTop4s1+XKxCN8cW7Cnm+GjNP2Ct53jC6NF1
 UAJytqBKAx43Es8UJcrvcn9TnyxBb1Cb7fbNT+gg9K9CdSX1V6nISi5VV5QCULxKdNNF
 vWl4JOkHlD99JIcnhbdYhY0Qjq4DzX4QrZfkvGU1Td8OsQO4AavrKrCDt+MImFjgudiK
 wSqqk0exbwbBBrTo+8mHgeKwtVsx5HteF90ibBBGamt67xRzsrzD8vNZy1XrzDXXihCl
 Z8ne5fyNqIVdff9JPXVlCAmzFfVioEb3xA9bOeshLDJpJkTIa4WnxgyO1MNOvCpy4HMm iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9mahuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 11:51:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GBdq7J130303;
        Wed, 16 Sep 2020 11:51:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33hm32kdbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 11:51:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GBpTDK025863;
        Wed, 16 Sep 2020 11:51:29 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 11:51:29 +0000
Subject: Re: [PATCH] btrfs: add a warning to check on the leaking device close
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
 <20200916101003.GM1791@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <52013ea3-fd54-5dbd-5c4d-3c5f41fdbf93@oracle.com>
Date:   Wed, 16 Sep 2020 19:51:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200916101003.GM1791@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160089
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/9/20 6:10 pm, David Sterba wrote:
> On Mon, Sep 14, 2020 at 05:11:14PM +0800, Anand Jain wrote:
>> To help better understand the device-close leaks, add a warning if the
>> device freed is still open.
> 
> Have you seen that happen or is it just a precaution? I've checked where
> the bdev is set to NULL and all paths seem to be covered, so the warn_on
> does not harm anything just that it does not seem to be possible to hit.
> For that an assert would be better.

There is an early/unconfirmed report [1] that after the forget
sub-command a device had partition changes and the new partitions failed
to recognize by the kernel.
[1]
https://lore.kernel.org/linux-btrfs/40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com/T/#t

The mount thread can't use device_list_mutex (because of bd_mutex),
and we rely on the uuid_mutex during mount.

The forget thread used both uuid_mutex and device_list_mutex.

So there isn't race between these two.

As of now we don't know. So the warning will help to know if we are
missing something.

Thanks, Anand


> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 2d5cc644741e..c0dfc0b569e9 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -371,6 +371,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
>>   void btrfs_free_device(struct btrfs_device *device)
>>   {
>>   	WARN_ON(!list_empty(&device->post_commit_list));
>> +	WARN_ON(device->bdev);
>>   	rcu_string_free(device->name);
>>   	extent_io_tree_release(&device->alloc_state);
>>   	bio_put(device->flush_bio);
>> -- 
>> 2.25.1
