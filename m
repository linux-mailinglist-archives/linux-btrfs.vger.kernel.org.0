Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94627806C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIYGTF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 02:19:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:44062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIYGTF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601014743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=QcfBxk9I3Q2Dr7+GDRE1CbEDBObvgyx/EolCZej08co=;
        b=ZtuSXkU8yJivVej99lWQ2ACRAhv/VhCVNPO4TxPyGxcIy+d7LgHv0gdIA9NHXQnO1IdObv
        GIBMYmiLXEvz2iBD/GxX0yPrjwCgNlpn0mzWIBmaSzRetl2gIxuxl+TZ69cO3kE/7RmBAW
        CeN/kXrBUfL9tlYMol2GixGO/7wzVhg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10DC7AB91;
        Fri, 25 Sep 2020 06:19:03 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
 <bed38208-67ff-ac66-187e-7e8ad91e1968@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7c8399b-e410-8748-d1f3-f8603a8980ae@suse.com>
Date:   Fri, 25 Sep 2020 09:19:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bed38208-67ff-ac66-187e-7e8ad91e1968@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.09.20 г. 7:17 ч., Anand Jain wrote:
> 
> 
> On 24/9/20 7:48 pm, Nikolay Borisov wrote:
>>
>>
>> On 24.09.20 г. 13:11 ч., Anand Jain wrote:
>>> btrfs_device::disk_total_bytes is set even for a seed device (the
>>> comment is wrong).
>>>
>>> The function fill_device_from_item() does the job of reading it from the
>>> item and updating btrfs_device::disk_total_bytes. So both the missing
>>> device and the seed devices do have their disk_total_bytes updated.
>>>
>>> So this patch removes the check dev->disk_total_bytes == 0 in the
>>> function verify_one_dev_extent()
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/volumes.c | 15 ---------------
>>>   1 file changed, 15 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 7f43ed88fffc..9be40eece8ed 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -7578,21 +7578,6 @@ static int verify_one_dev_extent(struct
>>> btrfs_fs_info *fs_info,
>>>           goto out;
>>>       }
>>>   -    /* It's possible this device is a dummy for seed device */
>>> -    if (dev->disk_total_bytes == 0) {
>>> -        struct btrfs_fs_devices *devs;
>>> -
>>> -        devs = list_first_entry(&fs_info->fs_devices->seed_list,
>>> -                    struct btrfs_fs_devices, seed_list);
>>> -        dev = btrfs_find_device(devs, devid, NULL, NULL, false);
>>> -        if (!dev) {
>>> -            btrfs_err(fs_info, "failed to find seed devid %llu",
>>> -                  devid);
>>> -            ret = -EUCLEAN;
>>> -            goto out;
>>> -        }
>>> -    }
>>
>> The commit which introduced this check states that the device with a
>> disk_total_bytes = 0 occurs from clone_fs_devices called from open_seed.
>> It seems the check is legit and your changelog doesn't account for that
>> if it's safe you should provide description why is that.
> 
> yes the commit 1b3922a8bc74 (btrfs: Use real device structure to verify
> dev extent) introduced it. In Qu's analysis, it is unclear why the
> total_disk_bytes was 0.
> 
> Theoretically, all devices (including missing and seed) marked with the
> BTRFS_DEV_STATE_IN_FS_METADATA flag gets the total_disk_bytes updated at
> fill_device_from_item().
> 
> open_ctree()
>  btrfs_read_chunk_tree()
>   read_one_dev()
>    open_seed_device() 

This function returns the cloned fs_devices whose devices are not
initialized. Later, in read_one_dev the 'device' is acquired from
fs_info->fs_devices, not from the returned fs_devices :

device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
                           fs_uuid, true);

And finally fill_device_from_item(leaf, dev_item, device); is called for
the device which was found from fs_info->fs_devices and not from the
returned 'fs_devices' from :

fs_devices = open_seed_devices(fs_info, fs_uuid);

What this means is that struct btrfs_device of devices in
fs_info->seed_list is never fully initialized.

>    fill_device_from_item()
> 
> Even if verify_one_dev_extent() reports total_disk_bytes == 0, then IMO
> its a bug to be fixed somewhere else and not in verify_one_dev_extent()
> as it's just a messenger. It is never expected that a total_disk_bytes
> shall be zero.

I agree, however this would involve fixing clone_fs_devices to properly
initialize struct btrfs_device. I'm in favor of removing special casing.

Looking closer into verify_one_dev_extent I see that the device is
referenced from fs_info->fs_devices :

dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);

And indeed, it seems that all devices of fs_info->fs_devices are
initialized as per your above explanation. So yeah, your patch is
codewise correct but the changelog is wrong:

disk_total_bytes is never set for seed devices (seed devices are after
all housed in fs_info->seed_list which as I explained above doesn't
fully initialize btrfs_devices)

A better changelog would document following invariants:

1. Seed devices don't have their disktotal bytes initialized

2. In spite of (1), verify_dev_one_extent is never called for such
devices so it's fine because devices anchored at fs_info->fs_devices are
always properly initialized.


<snip>
