Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB40F18C0F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 21:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCSUDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 16:03:06 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:53658 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgCSUDF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 16:03:05 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 16:03:04 EDT
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id F1FmjMokSa1lLF1Fmjn0A5; Thu, 19 Mar 2020 20:54:54 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1584647694; bh=rq3NyhbGyHT5EsKDs/TKxlk/Z3sEArfiG4o+iBtGCFE=;
        h=From;
        b=ZP9XpLq7cNBn1FDQR0KAWF9V64REw9qjKfiGbcjZsS91iN2eVkUGz9p0rOJRJ38QF
         hZ9LOj2L+6O3EKd49xIZWF0zTyoq2Rg5EkY25VhAKLffhy/QoszTw60XH6MQAIqCpV
         yTV7AL3SAM/d1grilpwFtKErweGkkMPF4NN2sjk/bRUSVq/3IzP5kp+6/Tf79ZA/fz
         2PScyL5oHiRn1e6K4waNgsqZ17ftyIINa7VuJGN9v7zqyNhMHnCtcAJNajLgSF389Z
         K9wwgh/7d0R2cJD/2AwA9y1uGvxbb+KYNVP5aB1cBi7I3BSda+nU+QXHkwOV3Tvtgx
         1QO7qJ8clph6A==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=9nAILHoIlc5t56OExrwA:9
 a=N8zUKh_Qyy9kX79e:21 a=vHMWM28cgbhlxPgr:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH RFC v2] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200319180527.4266-1-kreijack@libero.it>
 <20200319180527.4266-2-kreijack@libero.it>
 <07b8103c-bae1-5baf-8892-94d289cef4ab@toxicpanda.com>
 <baef0390-9a9d-7fba-3a6d-378083f0d83a@libero.it>
 <5efe5d08-b1bb-674b-eb7e-97586efaf744@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <78dab278-2d61-031c-146e-ae1deb16d62e@inwind.it>
Date:   Thu, 19 Mar 2020 20:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5efe5d08-b1bb-674b-eb7e-97586efaf744@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCGMOGY2iR/WDfNBosDDPb0gYdfcJMR5O/VC15gxnLOYqz1XlBRwkTpRmH/1KUz+/OOpv4RqmN4PwbwKnTqriuLjQeAg5/0Ibkgwc/4ixAbHhuBK0LCR
 xqwxfu0Fm4oqqnfVBOCd8BRb5ArRxzw7a4JvwJWM0YM3jiXtQtvFG9RhdzJuG/Xuzt77TCyDrbnfqxoFhYDGxatdP510iW7mhHw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 7:50 PM, Josef Bacik wrote:
> On 3/19/20 2:44 PM, Goffredo Baroncelli wrote:
>> Hi Josef,
>>
>> On 3/19/20 7:15 PM, Josef Bacik wrote:
>>> On 3/19/20 2:05 PM, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>
>>>> Add a new ioctl to get info about chunk without requiring the root privileges.
>>>> This allow to a non root user to know how the space of the filesystem is
>>>> allocated.
>>>>
>>>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>>>> ---
>>>>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>>>>   include/uapi/linux/btrfs.h |  38 +++++++
>>>>   2 files changed, 249 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index 40b729dce91c..e9231d597422 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
>>>>       return ret;
>>>>   }
>>>> +/*
>>>> + * Return:
>>>> + *    0        -> copied all data, possible further data
>>>> + *    1        -> copied all data, no further data
>>>> + *    -EAGAIN        -> not enough space, restart it
>>>> + *    -EFAULT        -> the user passed an invalid address/size pair
>>>> + */
>>>> +static noinline int copy_chunk_info(struct btrfs_path *path,
>>>> +                   char __user *ubuf,
>>>> +                   size_t buf_size,
>>>> +                   u64 *used_buf,
>>>> +                   int *num_found,
>>>> +                   u64 *offset)
>>>> +{
>>>> +    struct extent_buffer *leaf;
>>>> +    unsigned long item_off;
>>>> +    unsigned long item_len;
>>>> +    int nritems;
>>>> +    int i;
>>>> +    int slot;
>>>> +    struct btrfs_key key;
>>>> +
>>>> +    leaf = path->nodes[0];
>>>> +    slot = path->slots[0];
>>>> +    nritems = btrfs_header_nritems(leaf);
>>>> +
>>>> +    for (i = slot; i < nritems; i++) {
>>>> +        u64 destsize;
>>>> +        struct btrfs_chunk_info ci;
>>>> +        struct btrfs_chunk chunk;
>>>> +        int j, chunk_size;
>>>> +
>>>> +        item_off = btrfs_item_ptr_offset(leaf, i);
>>>> +        item_len = btrfs_item_size_nr(leaf, i);
>>>> +
>>>> +        btrfs_item_key_to_cpu(leaf, &key, i);
>>>> +        /*
>>>> +         * we are not interested in other items type
>>>> +         */
>>>> +        if (key.type != BTRFS_CHUNK_ITEM_KEY)
>>>> +            return 1;
>>>> +
>>>
>>> We'll leak this to user space, this should probably be handled differently right?  Thanks,
>>
>> Likely I am missing something obvious, but I can't understand what can be leaked and why. Could you be so kindly to elaborate your answer ?
>> Many thanks
>>
> 
> we return 1 here
> 
> +               ret = copy_chunk_info(path, ubuf, buf_size,
> +                                     &used_buf, items_count, offset);
> +
> +               btrfs_release_path(path);
> +               if (ret)
> +                       break;
> 
> this bit breaks and we return ret
> 
> +       ret = search_chunk_info(inode, &arg.offset, &arg.items_count,
> +                       argp + data_offset, buf_size - data_offset);
> +
> +       if (copy_to_user(argp, &arg, data_offset))
> +               return -EFAULT;
> +
> +       return ret;
> 
> and we return ret here.  So we'd return 1 to userspace.  Thanks,
> 
> Josef

Good catch !
Thanks for the review. I updated the patch and now I am testing it.

BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
