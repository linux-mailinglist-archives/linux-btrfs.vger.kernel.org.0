Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7B258ACE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 10:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAIyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 04:54:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38136 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIyc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 04:54:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0818s5bb012421;
        Tue, 1 Sep 2020 08:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RdzE8n7hhUbgYfbPg5WvLVd+KdxVQmfTX9dQrBRoB/k=;
 b=buJfcmySdGvpByx09KdCOJrhmJJFuftNzPv9sDkkUyIEuogqs5JQBUtxHDVlj+Nsfhxg
 cvvn42CLKUHpd2DjEIRT4x1jNY7RYXZT7T+86Njc35qIjBvE9Y8NPxfRyXL8XxjiRuHx
 uXQP3TMjQydwiHL25VePOvvl5j91E3xWYamNJrRLUcUoGN3Uc2ABprjKXkiVEUbujnC5
 93JcvUxw2GuUbgJGLi/pb15nK0fbvZx+N4OsWOBZVrxMCxBxI/muUycUBrVryQoE3INj
 8T6j65xlrDuWhuHtoYCbIKrtUFQOgbr8Adr5BOVRzM5zFeUlSvRQtVYRDl1WwsdredCP Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eym2vjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 08:54:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0818pCYx017314;
        Tue, 1 Sep 2020 08:54:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kmusg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 08:54:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0818sQVw030215;
        Tue, 1 Sep 2020 08:54:26 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 01:54:26 -0700
Subject: Re: [PATCH 05/11] btrfs: btrfs_init_devices_late: use sprout
 device_list_mutex
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <f9d69d94feeab53df416837d5e8bcc85da4df394.1598792561.git.anand.jain@oracle.com>
 <4fe0e0fe-37a8-1d36-dd97-1197b50fff4a@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <231132fb-21e8-1997-ac5f-a834cb3f199e@oracle.com>
Date:   Tue, 1 Sep 2020 16:54:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <4fe0e0fe-37a8-1d36-dd97-1197b50fff4a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=2 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31/8/20 4:37 pm, Nikolay Borisov wrote:
> 
> 
> On 30.08.20 г. 17:41 ч., Anand Jain wrote:
>> In a mounted sprout FS, all threads now are using the
>> sprout::device_list_mutex, and this is the only piece of code using
>> the seed::device_list_mutex. This patch converts to use the sprouts
>> fs_info->fs_devices->device_list_mutex.
>>
>> The same reasoning holds true here, that device delete is holding
>> the sprout::device_list_mutex.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 9921b43ef839..7639a048c6cf 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7184,16 +7184,14 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
>>   	mutex_lock(&fs_devices->device_list_mutex);
>>   	list_for_each_entry(device, &fs_devices->devices, dev_list)
>>   		device->fs_info = fs_info;
>> -	mutex_unlock(&fs_devices->device_list_mutex);
>>   
>>   	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
>> -		mutex_lock(&seed_devs->device_list_mutex);
>>   		list_for_each_entry(device, &seed_devs->devices, dev_list)
>>   			device->fs_info = fs_info;
>> -		mutex_unlock(&seed_devs->device_list_mutex);
>>   
>>   		seed_devs->fs_info = fs_info;
>>   	}
>> +	mutex_unlock(&fs_devices->device_list_mutex);
> 
> Instead of doing the looping here to set fs_info I think it makes more
> sense to move the initialization of fs_info for the seed fs_info/seed
> devices to open_seed_devices.
> 

  But that will be out of the purpose of this patch. May be in
  a different patch.

  And seed_devs->fs_info = fs_info co-exists with the
  device->fs_info = fs_info as well.


> As a matter of fact at the point where btrfs_init_devices_late is called
> btrfs_read_chunk_tree would have already been called which would have
> resulted in all present seed devices be added to fs_info::seed_list. So
> acquiring the lock here serves no purpose really.

  I tried to tests few times before. If any of the user initiated device
  operation could race with the mount thread. The ans was no. So the
  lock is not really required. But then there was mount and unmount
  racing bug, which was very strange to me. With that bug, if unmount
  wins the race, user initiated forget thread may free the devices. Now
  its fixed. So should be safe. But I am not too sure if that covers all
  the threads that could potentially race.

  So for now, its ok to consolidate the lock to
  sprout::device_list_mutex at least.

Thanks, Anand

> 
>>   }
>>   
>>   static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
>>
