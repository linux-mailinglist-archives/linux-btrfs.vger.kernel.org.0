Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED23418BFA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCSSuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 14:50:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36751 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSSuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 14:50:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so4284723qko.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoro3RQ0NH1PWjVf5Voxl9ATmDMM6d9BArmqUEGS9w8=;
        b=m2XqyvxLKNgRZ0HDvvkR7ZpoEf5QmvVxA4J7nkzP9JaEZ6GiXX6Ni9L7ozGdcs1OTc
         6LhhxCH03hcjXsnB2dZAPts5x1NHbcZoSNz09rZLYASc4HBd5tzCbaUD8ig72oQaRoNn
         11MRyP8Oazn9uiKfgg4WplRtGBBoVwtbn/8T1Ibzj6H14zrBOZ2aAt+wM+3ethN8IG/Y
         6pi+gggRwWANntGOmHnrFFXnLzlLcl27a8+JN5YIZiKCV7BaThfoZBHt513a6d9uCksR
         yHJE/NjsPZdZGJ8uYFwNgqoI+Avmgn+145Z6/L26rZor/Iz56qbsAxfrtnG33sCntnlN
         YLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoro3RQ0NH1PWjVf5Voxl9ATmDMM6d9BArmqUEGS9w8=;
        b=KP5oqjIxhXJyLR/6atUYt+FU3PrzwHJwoP3/a0ZoXSK0/PfWd6AEGupMjOWs8V5Vsr
         bnM9iUYAE3DwlvvRaNjc4YB1BR7DicW/jbrqn0n78IBpLbHJS2UA186TEB6XLMbzuG1V
         xq91zfQDl/Beyea8vKlMHrp0J03psB4pJLFSgRMlSbnU0rB+3YFQPE5DV5QhJ0t+qEHj
         M50KJvWL8yQB2dBykagRg6TLJaBH5d2Gtkm5cN7HLHTVcoFvsvW51FTgT4NRXl7oQvfI
         mD0o7u06YsZBTPAafvypH9eINzMs1jzzH+1yfwNcPcHD2ZbI05DzIMZMpwzyVcguiDXe
         xKkQ==
X-Gm-Message-State: ANhLgQ2UeDJYO6Y124hPqyAz0GwTkkFAgXHAasHZORQwYktisFd7+bzr
        qhv+Z8WaDKc9v69cQcdgYSorYFbloGM=
X-Google-Smtp-Source: ADFU+vtJ99ikEUEiZy0+EHg8Xv5SHio+ScAMjZKWIXKMwHE3bjnLV8cNX5dVli/r8u21QraxbBkvaQ==
X-Received: by 2002:a05:620a:12a3:: with SMTP id x3mr4576239qki.367.1584643848038;
        Thu, 19 Mar 2020 11:50:48 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r3sm2211897qkd.3.2020.03.19.11.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 11:50:47 -0700 (PDT)
Subject: Re: [PATCH RFC v2] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org
References: <20200319180527.4266-1-kreijack@libero.it>
 <20200319180527.4266-2-kreijack@libero.it>
 <07b8103c-bae1-5baf-8892-94d289cef4ab@toxicpanda.com>
 <baef0390-9a9d-7fba-3a6d-378083f0d83a@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5efe5d08-b1bb-674b-eb7e-97586efaf744@toxicpanda.com>
Date:   Thu, 19 Mar 2020 14:50:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <baef0390-9a9d-7fba-3a6d-378083f0d83a@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 2:44 PM, Goffredo Baroncelli wrote:
> Hi Josef,
> 
> On 3/19/20 7:15 PM, Josef Bacik wrote:
>> On 3/19/20 2:05 PM, Goffredo Baroncelli wrote:
>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>
>>> Add a new ioctl to get info about chunk without requiring the root privileges.
>>> This allow to a non root user to know how the space of the filesystem is
>>> allocated.
>>>
>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>> ---
>>>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>>>   include/uapi/linux/btrfs.h |  38 +++++++
>>>   2 files changed, 249 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index 40b729dce91c..e9231d597422 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct 
>>> file *file,
>>>       return ret;
>>>   }
>>> +/*
>>> + * Return:
>>> + *    0        -> copied all data, possible further data
>>> + *    1        -> copied all data, no further data
>>> + *    -EAGAIN        -> not enough space, restart it
>>> + *    -EFAULT        -> the user passed an invalid address/size pair
>>> + */
>>> +static noinline int copy_chunk_info(struct btrfs_path *path,
>>> +                   char __user *ubuf,
>>> +                   size_t buf_size,
>>> +                   u64 *used_buf,
>>> +                   int *num_found,
>>> +                   u64 *offset)
>>> +{
>>> +    struct extent_buffer *leaf;
>>> +    unsigned long item_off;
>>> +    unsigned long item_len;
>>> +    int nritems;
>>> +    int i;
>>> +    int slot;
>>> +    struct btrfs_key key;
>>> +
>>> +    leaf = path->nodes[0];
>>> +    slot = path->slots[0];
>>> +    nritems = btrfs_header_nritems(leaf);
>>> +
>>> +    for (i = slot; i < nritems; i++) {
>>> +        u64 destsize;
>>> +        struct btrfs_chunk_info ci;
>>> +        struct btrfs_chunk chunk;
>>> +        int j, chunk_size;
>>> +
>>> +        item_off = btrfs_item_ptr_offset(leaf, i);
>>> +        item_len = btrfs_item_size_nr(leaf, i);
>>> +
>>> +        btrfs_item_key_to_cpu(leaf, &key, i);
>>> +        /*
>>> +         * we are not interested in other items type
>>> +         */
>>> +        if (key.type != BTRFS_CHUNK_ITEM_KEY)
>>> +            return 1;
>>> +
>>
>> We'll leak this to user space, this should probably be handled differently 
>> right?  Thanks,
> 
> Likely I am missing something obvious, but I can't understand what can be leaked 
> and why. Could you be so kindly to elaborate your answer ?
> Many thanks
> 

we return 1 here

+               ret = copy_chunk_info(path, ubuf, buf_size,
+                                     &used_buf, items_count, offset);
+
+               btrfs_release_path(path);
+               if (ret)
+                       break;

this bit breaks and we return ret

+       ret = search_chunk_info(inode, &arg.offset, &arg.items_count,
+                       argp + data_offset, buf_size - data_offset);
+
+       if (copy_to_user(argp, &arg, data_offset))
+               return -EFAULT;
+
+       return ret;

and we return ret here.  So we'd return 1 to userspace.  Thanks,

Josef
