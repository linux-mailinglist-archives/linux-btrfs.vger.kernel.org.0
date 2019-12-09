Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4738116E85
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 15:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLIOFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 09:05:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLIOFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 09:05:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so7277163pfm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2gB5LVX1UyOzXsVFooUpblQvAKuEUg7z5T/7IlbD80M=;
        b=bZVz9ikh5O3ua+ZYtbj+XBLlGUOiRvze5Qbt3g2+vuzptvbpUVTpWUne6dJm7vb7y2
         Nnk0FHtDrnpkU5nbUpwQoDgWKM1JWKr4EiOtz1vm45UcPXkeckXBrZLLbQmiUWXYRBcV
         9HpiYgwYfgxzcqiBuCWpK6XareMj61zJEeBrZlIivAB7FqbnikXX9iMP8uzh9K2FWqJJ
         LjNFD+l5fbuyoGEI+2uctrXAW8eA1fR6bN9HQibm+xmweI4f83WT2CWYAZL9ihUqiCqN
         5POmEEhHCDeae1ISVO4tfOq9HfrbHAFC88fbAbH/1ZG7UgsFU/5/a5w6zjTjKfB2wv13
         6maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2gB5LVX1UyOzXsVFooUpblQvAKuEUg7z5T/7IlbD80M=;
        b=Nya4HV9k5r8Y7eT3+mJ1cy48Xb4W359NpfHcMSCTDBzCgpwCAq6qP8w+clLhXV7rt4
         UIn/NRkMDHziQLZd4dD6LAN+KnkST650n0vV7uu60aTcM2zKHeuoA9CaiQt0eYbkLhV7
         8Oq/Owd9siMj6bhstalhFeyPPC2SUiCbC99b66dPn2hQms58ryPs0afjq8Tnhw7OED1B
         NDPQx/5oPzOJXLFdqW+rhdni91gFK2cSbvfGrmoPFrHk69K73J+i+IcbmbYBy4AN6dKg
         +1r1OSAVqZR87aXJWBJUCjQSWKQODWvrc2crPgVweFF0Os9ucsBmVA2eZ1lYi428JwMm
         vqRg==
X-Gm-Message-State: APjAAAWhBRjUFGaIMKoh4WxNWkihGaIwCSWrltmAqZZG56N3XdYDwQvE
        OmhZaD2a3+ZUE/quyWTRmUuXYl4u
X-Google-Smtp-Source: APXvYqyzZLlb3wSE45Az/X6xVwiUXzSazaCVoJYstp8zAQdFRNYaILfr6FY0btSBYM5q0GAwD3yLeg==
X-Received: by 2002:a65:6815:: with SMTP id l21mr18230311pgt.283.1575900347755;
        Mon, 09 Dec 2019 06:05:47 -0800 (PST)
Received: from [192.168.1.145] ([39.109.145.141])
        by smtp.gmail.com with ESMTPSA id m27sm27383678pff.179.2019.12.09.06.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:05:46 -0800 (PST)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
 <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
Message-ID: <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
Date:   Mon, 9 Dec 2019 22:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/6/19 9:49 PM, Anand Jain wrote:
> 
> 
> On 5/12/19 11:14 PM, David Sterba wrote:
>> On Thu, Dec 05, 2019 at 10:38:15PM +0800, Anand Jain wrote:
>>>> So the values copy the device state macros, that's probably ok.
>>>    Yep.
>>
>> Although, sysfs files should print one value per file, which makes sense
>> in many cases, so eg. missing should exist separately too for quick
>> checks for the most common device states. The dev_state reflects the
>> internal state and is likely useful only for debugging.
>>
> 
>   I agree. Its better to create an individual attribute for each of the
>   device states. For instance..
> 
>     under the 'UUID/devinfo/<devid>' kobject
>     attributes will be:
>       missing
>       in_fs_metadata
>       replace_target
> 
>    cat missing
>     0
>    cat in_fs_metadata
>     1
> 
>    ..etc
> 
>   which seems to be more or less standard for block devices.
> 
>   Will fix it in v2.

This is fixed in v2.


> 
>>>>> +static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
>>>>> +                      struct kobj_attribute *a, char *buf)
>>>>> +{
>>>>> +    struct btrfs_device *device = container_of(kobj, struct 
>>>>> btrfs_device,
>>>>> +                           devid_kobj);
>>>>> +
>>>>> +    btrfs_dev_state_to_str(device, buf, PAGE_SIZE);
>>>>
>>>> The device access is unprotected, you need at least RCU but that still
>>>> does not prevent from the device being freed by deletion.
>>>
>>>    We need RCU let me fix. Device being deleted is fine, there
>>>    is nothing to lose, another directory lookup will show that
>>>    UUID/devinfo/<devid> is gone is the device is deleted.
>>
>> The device can be gone from the list but the sysfs files can still
>> exist.
>>
>>      CPU1                                   CPU2
>>
>> btrfs_rm_device
>>                                          open file
>>    btrfs_sysfs_rm_device_link
>>      btrfs_free_device
>>        kfree(device)
>>                                          call read, access freed device
>>
> 
>    I completely missed the sysfs synchronization with device delete.
>    As in the other email discussion, I think a new rwlock shall suffice.
>    And as its lock is only between device delete and sysfs so it shall
>    be light weight without affecting the other device_list_mutex holders.

  Looked into this further, actually we don't need any lock here
  the device delete thread which calls kobject_put() makes sure
  sysfs read is closed. So an existing sysfs read thread will have
  to complete before device free.


       CPU1                                   CPU2

  btrfs_rm_device
                                           open file
     btrfs_sysfs_rm_device_link
                                           call read, access freed device
       sysfs waits for the open file
       to close.
       btrfs_free_device
         kfree(device)


Thanks
Anand


> Thanks,
> Anand
> 
>>>> The
>>>> device_list_mutex is quite heavy and allowing a DoS by repeatedly
>>>> reading the file contents is not something we want to allow.
>>>>
>>>
>>>     Yes we don't have to use device_list_mutex here, as its read,
>>>     a refresh/re-read will refresh the dev_state.
>>
>> The point is not to synchronize the device state values but the device
>> object itself.
> 
> 
> 

