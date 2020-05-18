Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9821D75E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgERLHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 07:07:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgERLHd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 07:07:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IB20BF017095;
        Mon, 18 May 2020 11:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=gDilr1Uva/lInygk/UMmBJaA5JV5zr9tTr3dvbggRoU=;
 b=fk0XzPtJ0YVQyzlw2RneZOrpGlr2JX9R29JsF3kB/EjaeoAMBpr4GGHwr309Gs982hei
 xpmVMqD359++izLxLUS3ZmU/TLfBPmIz+p6jIrBHg0Yfd4lkwgRdRBWvGQLuyi0o8MTe
 WtrRmRF9+xqw5vZYuljV3JK/f8HRN2jphH3iRHZKVElkX30bN3aH/o4tSbGVWVUK68LK
 r3HG3EgBwRMu42Ed8r59rc87mZvnbqoICv2M4FOTANiv+eq94wzYhhSkpBWepfItBTKM
 5gd/GKxLqjfi5Oy6V01WA0K7iIEVpfuUZ9p7pOxVkEj464qWHj/GPS4/iizyshBDQqNI UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3128tn617x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 11:07:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IB32l2181114;
        Mon, 18 May 2020 11:07:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 312sxq4b9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 11:07:26 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04IB7P0I022143;
        Mon, 18 May 2020 11:07:25 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 04:07:25 -0700
Subject: Re: [PATCH] btrfs: fix lockdep warning chunk_mutex vs
 device_list_mutex
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
 <20200513194659.34493-1-anand.jain@oracle.com>
 <20200515174047.GN18421@twin.jikos.cz>
 <4fa7f041-5816-1d94-1148-780b10e705af@oracle.com>
Message-ID: <d30c0e44-6425-fb7b-efe2-28db6f36cdea@oracle.com>
Date:   Mon, 18 May 2020 19:07:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4fa7f041-5816-1d94-1148-780b10e705af@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/5/20 11:43 am, Anand Jain wrote:
> On 16/5/20 1:40 am, David Sterba wrote:
>> On Thu, May 14, 2020 at 03:46:59AM +0800, Anand Jain wrote:
>>> A full list of tests just started.
>>>
>>>   fs/btrfs/volumes.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 60ab41c12e50..ebc8565d0f73 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -984,7 +984,6 @@ static struct btrfs_fs_devices 
>>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>       if (IS_ERR(fs_devices))
>>>           return fs_devices;
>>
>> So now here's the device_list_mutex taken by a caller but inside
>> clone_fs_devices there's
>>
>>     fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>
>> just before this line and it does a GFP_KERNEL allocation.
> 
> Oh right the allocations. Its not just about the other locks
> as I thought before.
> 
> There are two ways to fix.
>    Use GFP_NOFS
>     I am not yet sure if it not possible. There were some previous
>     work on the GFP flags. I need to review them. or,
>    Move the allocation outside the locks.
> 
>   Looking into both of these choices.
> 


Nack. On this patch.

In general GFP_KERNEL is preferred over GFP_NOFS. For example.

--------
6165572c btrfs: use GFP_KERNEL in btrfs_init_dev_replace_tgtdev
cc8385b5 btrfs: preallocate radix tree node for readahead
78f2c9e6 btrfs: device add and remove: use GFP_KERNEL
--------

And there are quite a lot of GFP_KERNEL allocation along the
path leading to clone_fs_devices().


Thanks, Anand

> Thanks, Anand
> 
>> This could
>> deadlock through the allocator trying to flush data and then superblock
>> write locking the device_list_mutex again.
>>
>>> -    mutex_lock(&orig->device_list_mutex);
>>>       fs_devices->total_devices = orig->total_devices;
>>>       list_for_each_entry(orig_dev, &orig->devices, dev_list) {
> 
