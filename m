Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535A9FC4DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 11:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNK6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 05:58:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNK6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 05:58:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAsMoq097520;
        Thu, 14 Nov 2019 10:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=gTEEvlY9JpSb50zxUGhPDgcYco3DZmQDT5Er0/YqL/w=;
 b=Hm2+JOyCDNfURJWGs5Fx3mlLwvEITcoSzK8otyGHheQlqy7GzfwE2Gj61jcVCXbG2oD1
 /maaH5qsH0LqMkLdDAUKMQBJui++UC/wCCBsTI3NmthvHWs3dwDXMqI0W2V6Fwz0CgGG
 aM66T7Gj0v8MmM5s4mIkR242AZpTVG1A64zox8Cy3XomXUE9wBE2DjMGwuFVWzeQY/nJ
 8HvyN+aRA+dZtc1zPLwMDgEhCBLk7kRvPyJ6+F9+vVBm/sk6cxtggXj2iIni1B2nC1kD
 9VuW49R/j7+Bd5KFCfRvRUbBuuGiSXilbZgtIVXK9OC+9dyFkyKOrwemipjCcXElLbNH Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2w5mvu2egj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 10:57:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEAsGtj061104;
        Thu, 14 Nov 2019 10:57:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w8v35gkk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 10:57:04 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAEAv3Gs003049;
        Thu, 14 Nov 2019 10:57:03 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 02:57:03 -0800
Subject: Re: [PATCH v2 2/7] btrfs: handle device allocation failure in
 btrfs_close_one_device()
To:     Johannes Thumshirn <jthumshirn@suse.de>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
 <20191113102728.8835-3-jthumshirn@suse.de>
 <20191113145859.GB3001@twin.jikos.cz>
 <4a86d0f6-94cb-24a7-05d1-5297673ac248@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9fb09a95-ec34-0a45-8f4b-97a6467a2c81@oracle.com>
Date:   Thu, 14 Nov 2019 18:56:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4a86d0f6-94cb-24a7-05d1-5297673ac248@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/11/19 4:48 PM, Johannes Thumshirn wrote:
> On 13/11/2019 15:58, David Sterba wrote:
>> On Wed, Nov 13, 2019 at 11:27:23AM +0100, Johannes Thumshirn wrote:
>>> In btrfs_close_one_device() we're allocating a new device and if this
>>> fails we BUG().
>>>
>>> Move the allocation to the top of the function and return an error in case
>>> it failed.
>>>
>>> The BUG_ON() is temporarily moved to close_fs_devices(), the caller of
>>> btrfs_close_one_device() as further work is pending to untangle this.
>>>
>>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>>> ---
>>>   fs/btrfs/volumes.c | 27 +++++++++++++++++++++------
>>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 5ee26e7fca32..0a2a73907563 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1061,12 +1061,17 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>>>   	blkdev_put(device->bdev, device->mode);
>>>   }
>>>   
>>> -static void btrfs_close_one_device(struct btrfs_device *device)
>>> +static int btrfs_close_one_device(struct btrfs_device *device)
>>>   {
>>>   	struct btrfs_fs_devices *fs_devices = device->fs_devices;
>>>   	struct btrfs_device *new_device;
>>>   	struct rcu_string *name;
>>>   
>>> +	new_device = btrfs_alloc_device(NULL, &device->devid,
>>> +					device->uuid);
>>> +	if (IS_ERR(new_device))
>>> +		goto err_close_device;
>>> +
>>>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>>>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
>>>   		list_del_init(&device->dev_alloc_list);
>>> @@ -1080,10 +1085,6 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>>   	if (device->bdev)
>>>   		fs_devices->open_devices--;
>>>   
>>> -	new_device = btrfs_alloc_device(NULL, &device->devid,
>>> -					device->uuid);
>>> -	BUG_ON(IS_ERR(new_device)); /* -ENOMEM */
>>> -
>>>   	/* Safe because we are under uuid_mutex */
>>>   	if (device->name) {
>>>   		name = rcu_string_strdup(device->name->str, GFP_NOFS);
>>> @@ -1096,18 +1097,32 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>>   
>>>   	synchronize_rcu();
>>>   	btrfs_free_device(device);
>>> +
>>> +	return 0;
>>> +
>>> +err_close_device:
>>> +	btrfs_close_bdev(device);
>>> +	if (device->bdev) {
>>> +		fs_devices->open_devices--;
>>> +		btrfs_sysfs_rm_device_link(fs_devices, device);
>>> +		device->bdev = NULL;
>>> +	}
>>
>> I don't understand this part: the 'device' pointer is from the argument,
>> so the device we want to delete from the list and for that all the state
>> bit tests, bdev close, list replace rcu and synchronize_rcu should
>> happen -- in case we have a newly allocated new_device.
>>
>> What I don't understand how the short version after label
>> err_close_device: is correct. The device is still left in the list but
>> with NULL bdev but rw_devices, missing_devices is untouched.
>>
>> That a device closing needs to allocate memory for a new device instead
>> of reinitializing it again is stupid but with the simplified device
>> closing I'm not sure the state is well defined.
> 
> As we couldn't allocate memory to remove the device from the list, we
> have to keep it in the list (technically even leaking some memory here).
> 
> What we definitively need to do is clear the ->bdev pointer, otherwise
> we'll trip over a NULL-pointer in open_fs_devices().
> 
> open_fs_devices() will traverse the list and call
> btrfs_open_one_device() this will fail as device->bdev is (still) set
> thus latest_dev is NULL and then this 'fs_devices->latest_bdev =
> latest_dev->bdev;' will blow up.
> 
> If you have a better solution I'm all ears. This is what I came up with
> to tackle the problem of half initialized devices.
> 
> One thing we could do though is call btrfs_free_stale_devices() in the
> error case.
> 
> Byte,
> 	Johannes
> 

Johannes,

   Thanks for attempting to fix this.

   I wrote comments about this unoptimized code here [1]

   [1]
    ML email therad
     'invalid opcode in close_fs_devices'

 
https://groups.google.com/forum/#!msg/syzkaller-bugs/eSgcqygYaXE/6wuz-0jMCwAJ

   You may want to review.

   Yes David is correct why a closed device will still remain in the
   dev_alloc_list even after the close here in this patch.

Thanks, Anand
