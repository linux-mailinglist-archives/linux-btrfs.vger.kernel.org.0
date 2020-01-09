Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF7C135B1E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgAIOMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:12:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33536 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbgAIOMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 09:12:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so6098087qkc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2020 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uUy3CVXlC1Mvy7051CNrjhYDgxM5Vi6zMpZw1SLW5Xc=;
        b=JRnrOmMsOTf3RHv3GOGlmj+lNzFGdZq+VpCD+fI3ZYo94sBSFVgtd+RBDYHjsAp0jZ
         9foFo+jZqYELRG9bIo+xhjVv+c0JwlwZSiaKM5/JEVXTQlKP91zUQYVlgZIlj2l3sCx4
         rZ87eAWooUkWre17RbzP9JP/a1PSC1QGfOVH2lFYm+6WOxynguuU0TIjaRrSXpQ4LB7q
         ZlIRvJFHWP7MPc5AYUdnnShXL/kTzFcjb7k88/1cQV/4+v68Gu5fAvm0AcDrxx2jI/Hd
         3y+fpqS5giCViSWUlG40FVGx1BoUGAvFt7/kArJZqeYW7Vl53s8mIFvcCc7tF4Cbnmmt
         nPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUy3CVXlC1Mvy7051CNrjhYDgxM5Vi6zMpZw1SLW5Xc=;
        b=Uu0FvdnT5vAe9ktmySKs9FjhgdiP+ZmIkYdBliJHGl2eGL/oe5L/I3LMLIPsOzjitE
         c136G1fOV8c8dCmXM01aCb2ee+mOaxfrNfT8CkNdAApz05TQB9vZnnro47qn59XFGkd/
         PGjZWURjZszLCa1TQlgJhQRW4Li9nqAjNqrkwNMMUEYfUuq2EQPrU9MAk3DL4nBlJyCP
         7yA3/vABho6qOJgcYbQCXwcMI3BimcIuVBt70gJb52boKjXoLYT1uv/eEpFuHuiM1JE1
         YQS4AfvDXnckFI81WmXuwBmxJhYBjwv78b835XGwm3/pxifZLcokvsnqTi+8o3zk2FY5
         7Yrg==
X-Gm-Message-State: APjAAAU1yxp/XzZPE9+uvW8HGsjlD/tAlNg2i5Bk/vTDfJ/J7bZVMPI8
        7OehzLwD2HxkFLjZF9sKbNvdbw==
X-Google-Smtp-Source: APXvYqyr4kjtwbQz2idwkmlt//OO8hDs+Fj1gXVHlXRf+4jR1igV1KdpkHQeMYVin4BEAarCvw2YeQ==
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr9774001qka.473.1578579149375;
        Thu, 09 Jan 2020 06:12:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::9943])
        by smtp.gmail.com with ESMTPSA id u4sm3007539qkh.59.2020.01.09.06.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 06:12:28 -0800 (PST)
Subject: Re: [PATCH] btrfs: check rw_devices, not num_devices for restriping
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200108223929.2761-1-josef@toxicpanda.com>
 <9c11a3ae-e9c1-c4e5-7a0e-13b8d2ace8d0@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f3b2f9fe-a452-a501-6806-2ea4010f6660@toxicpanda.com>
Date:   Thu, 9 Jan 2020 09:12:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9c11a3ae-e9c1-c4e5-7a0e-13b8d2ace8d0@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 6:01 AM, Nikolay Borisov wrote:
> 
> 
> On 9.01.20 г. 0:39 ч., Josef Bacik wrote:
>> While running xfstests with compression on I noticed I was panicing on
>> btrfs/154.  I bisected this down to my inc_block_group_ro patches, which
>> was strange.
>>
>> What was happening is with my patches we now use btrfs_can_overcommit()
>> to see if we can flip a block group read only.  Before this would fail
>> because we weren't taking into account the usable un-allocated space for
>> allocating chunks.  With my patches we were allowed to do the balance,
>> which is technically correct.
>>
>> However this test is testing restriping with a degraded mount, something
>> that isn't working right because Anand's fix for the test was never
>> actually merged.
>>
>> So now we're trying to allocate a chunk and cannot because we want to
>> allocate a RAID1 chunk, but there's only 1 device that's available for
>> usage.  This results in an ENOSPC in one of the BUG_ON(ret) paths in
>> relocation (and a tricky path that is going to take many more patches to
>> fix.)
>>
>> But we shouldn't even be making it this far, we don't have enough
>> devices to restripe.  The problem is we're using btrfs_num_devices(),
>> which for some reason includes missing devices.  That's not actually
>> what we want, we want the rw_devices.
>>
>> Fix this by getting the rw_devices.  With this patch we're no longer
>> panicing with my other patches applied, and we're in fact erroring out
>> at the correct spot instead of at inc_block_group_ro.  The fact that
>> this was working before was just sheer dumb luck.
>>
>> Fixes: e4d8ec0f65b9 ("Btrfs: implement online profile changing")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/volumes.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 7483521a928b..ee4d440e544e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3881,7 +3881,13 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>>   		}
>>   	}
>>   
>> -	num_devices = btrfs_num_devices(fs_info);
>> +	/*
>> +	 * device replace only adjusts rw_devices when it is finishing, so take
>> +	 * the lock here to make sure we get the right value for rw_devices.
>> +	 */
>> +	down_read(&fs_info->dev_replace.rwsem);
>> +	num_devices = fs_info->fs_devices->rw_devices;
>> +	up_read(&fs_info->dev_replace.rwsem);
> 
> rw_devices is modified under a myriad of locks, to name a few:
> 
> under chunk/device_list mutex in init_new_device
> 
> under device_lsit_mutex  in
> btrfs_open_devices->open_fs_devices->btrfs_open_one_device
> 
> uuid mutex in btrfs_rm_device and also under chunk_mutex in an error
> path in the same function.
> 
> device_list_mutex in btrfs_rm_dev_replace_remove_srcdev
> 
> 
> SO you are only protecting from the replace context in this case. Is
> this sufficient?
> 

Hmm I thought the replace_remove_srcdev was under the dev_replace rwsem but it 
looks like it's only under all the other locks.  We're only worried about it 
being messed with while the file system is mounted, and it appears we're at 
least consistent with taking the chunk_mutex when modifying it while the fs is 
mounted, I'll switch it to that.  Thanks,

Josef
