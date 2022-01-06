Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF848607E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 07:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiAFGNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 01:13:12 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:60424 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAFGNM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 01:13:12 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id D2EAB6C00898;
        Thu,  6 Jan 2022 08:13:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1641449590; bh=DZKoqdRysdcFwonU8Uz03tlrRh8bxjcDucu0BJghQQA=;
        h=References:From:To:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date;
        b=Lb0uyKCQjN+QL50CcKWBuYNmLenL8Tx/elTUAkBEqswTX8G84oBZmWBPoKv8U+/wk
         WL+moiFQbsuS/6/weD8jsyOXYhNXQ/2I6ET6XPE8fDVTxmJIREweOFVutQdzvHnCir
         QN8rOAfCodXkzG9chxBQ/FD1saeoeD8kwsj2WyOE=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id C34BB6C00895;
        Thu,  6 Jan 2022 08:13:10 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id XaEnxANdoSSb; Thu,  6 Jan 2022 08:13:10 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 4DC0D6C00894;
        Thu,  6 Jan 2022 08:13:10 +0200 (EET)
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
 <20220104185611.GX28560@twin.jikos.cz>
 <4210807a-c727-19be-9f72-797f0e1897f2@oracle.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
Date:   Thu, 06 Jan 2022 14:05:21 +0800
In-reply-to: <4210807a-c727-19be-9f72-797f0e1897f2@oracle.com>
Message-ID: <mtk9o0ia.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m7upSaUCpygHhXwK+CAc3rDRIWO/7+uO7zh9YmGeYRSOFeEgMUhi0nGhwUR7LszsX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 05 Jan 2022 at 19:31, Anand Jain <anand.jain@oracle.com> 
wrote:

> On 05/01/2022 02:56, David Sterba wrote:
>> On Sat, Dec 11, 2021 at 02:15:29AM +0800, Anand Jain wrote:
>>> Identifying and removing the stale device from the fs_uuids 
>>> list is done
>>> by the function btrfs_free_stale_devices().
>>> btrfs_free_stale_devices() in turn depends on the function
>>> device_path_matched() to check if the device repeats in more 
>>> than one
>>> btrfs_device structure.
>>>
>>> The matching of the device happens by its path, the device 
>>> path. However,
>>> when dm mapper is in use, the dm device paths are nothing but 
>>> a link to
>>> the actual block device, which leads to the 
>>> device_path_matched() failing
>>> to match.
>>>
>>> Fix this by matching the dev_t as provided by lookup_bdev() 
>>> instead of
>>> plain strcmp() the device paths.
>>>
>>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>
>>> v2: Fix
>>>       sparse: warning: incorrect type in argument 1 (different 
>>>       address spaces)
>>>       For using device->name->str
>>>
>>>      Fix Josef suggestion to pass dev_t instead of device-path 
>>>      in the
>>>       patch 2/2.
>>>
>>>   fs/btrfs/volumes.c | 41 
>>>   ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 1b02c03a882c..559fdb0c4a0e 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char 
>>> *device_path, fmode_t flags, void *holder,
>>>   	return ret;
>>>   }
>>>   -static bool device_path_matched(const char *path, struct 
>>>   btrfs_device
>>> *device)
>>> +/*
>>> + * Check if the device in the 'path' matches with the device 
>>> in the given
>>> + * struct btrfs_device '*device'.
>>> + * Returns:
>>> + *	0	If it is the same device.
>>> + *	1	If it is not the same device.
>>> + *	-errno	For error.
>>> + */
>>> +static int device_matched(struct btrfs_device *device, const 
>>> char *path)
>>>   {
>>> -	int found;
>>> +	char *device_name;
>>> +	dev_t dev_old;
>>> +	dev_t dev_new;
>>> +	int ret;
>>> +
>>> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
>>> +	if (!device_name)
>>> +		return -ENOMEM;
>>>     	rcu_read_lock();
>>> -	found = strcmp(rcu_str_deref(device->name), path);
>>> +	ret = sprintf(device_name, "%s", 
>>> rcu_str_deref(device->name));
>> I wonder if the temporary allocation could be avoided, as it's 
>> the
>> exactly same path of the device, so it could be passed to 
>> lookup_bdev.
>
>  Yeah, I tried but to no avail. Unless I drop the rcu read lock 
>  and
>  use the str directly as below.
>
>  lookup_bdev(device->name->str, &dev_old);
>
>  We do skip rcu access for device->name at a few locations.
>
>  Also, pls note lookup_bdev() can't be called within 
>  rcu_read_lock(),
>  (calling sleep function warning).
>

Got it. And another evil and dirty solution is that open code the 
logic in
the only user btrfs_free_stale_devices(). Do the memory allocation 
and
lookup_bdev(path) before the big big loop so we won't be disturbed
error handling and save some times of lookup_bdev ;)

--
Su
>
>>>   	rcu_read_unlock();
>>> +	if (!ret) {
>>> +		kfree(device_name);
>>> +		return -EINVAL;
>>> +	}
>>>   -	return found == 0;
>>> +	ret = lookup_bdev(device_name, &dev_old);
>>> +	kfree(device_name);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = lookup_bdev(path, &dev_new);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (dev_old == dev_new)
>>> +		return 0;
>>> +
>>> +	return 1;
>>>   }
>>>     /*
>>> @@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const 
>>> char *path,
>>>   				continue;
>>>   			if (path && !device->name)
>>>   				continue;
>>> -			if (path && !device_path_matched(path, 
>>> device))
>>> +			if (path && device_matched(device, path) 
>>> != 0)
>> You've changed the fuction to return errors but it's not 
>> checked,
>> besides the memory allocation failure, the lookup functions 
>> could fail
>> for various reasons so I don't think it's safe to ignore the 
>> errors.
>
> IMO there isn't much that the parent function should do even if 
> the
> device_matched() returns an error for the reasons you stated.
>
> Mainly because btrfs_free_stale_devices() OR 
> btrfs_forget_devices()
> is used as a cleanup ops in the primary task functions such as
> btrfs_scan_one_device() and btrfs_init_new_device(). Even if we 
> don't
> remove the stale there is no harm.
>
> Further btrfs_forget_devices() is called from 
> btrfs_control_ioctl()
> which is a userland call for forget devices. So as we traverse 
> the
> device list, if a device lookup fails IMO, it is ok to skip to 
> the next
> device in the list and return the status of the device match.
>
> Even more, IMO we should save the dev_t in the struct 
> btrfs_device,
> upon which the device_matched() will go away altogether. This 
> change
> is outside of the bug that we intended to fix here. I will clean 
> that
> up separately.
>
> Thanks, Anand
>
>>>   				continue;
>>>   			if (fs_devices->opened) {
>>>   				/* for an already deleted device 
>>>   return 0 */
>>> -- 2.33.1
