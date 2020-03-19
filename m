Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D707718BF90
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSSol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 14:44:41 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:58721 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbgCSSol (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 14:44:41 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id F09mjMNnha1lLF09mjmiEI; Thu, 19 Mar 2020 19:44:38 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584643478; bh=BrzQeUuVth0YdigYmtwZa4jbG+FefFcUgZB3SpRmRl4=;
        h=From;
        b=fTbwSYp/7UHzbDc/nGEfGOEaY89KtRDKXamUXVmYwRJ886imxCYcVAyILt6ZT0KmA
         SbBSnAfhJa7utvXDvwRdeF2agzZ7Nk3Ywl+CTWoKKZVfSli3fLvf88c70qfsHIAjWh
         +4Nrin9OY7ra9FBaK420qGzES1PsSBIynSmscJhuny2nGfpfZd+0kJIw5Xt19GIM0K
         js6HV3ceuHV+srEXv6Fl+d6/b6qGzfb0UUY/5fL/1fhTMEXDIyguFSs/bpMlihSQLH
         WjL/P0yCozujyploz0e4jI47sqSB9XQu+CUUijZxqeYuIZ7fo9RA6mCzFCphCNuFFc
         OyZcutFnoBVSQ==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=F0g-YP2QzlFsH_K13GYA:9
 a=aeghs33Uv5Xjk97t:21 a=DnEvch0qcm0SMtuT:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH RFC v2] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319180527.4266-1-kreijack@libero.it>
 <20200319180527.4266-2-kreijack@libero.it>
 <07b8103c-bae1-5baf-8892-94d289cef4ab@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <baef0390-9a9d-7fba-3a6d-378083f0d83a@libero.it>
Date:   Thu, 19 Mar 2020 19:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <07b8103c-bae1-5baf-8892-94d289cef4ab@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOUIt1xxSGOMGMbiKxf23rmXnt4s1T+FiKB76xRBlwa49Cg+WdsuIJQcqYdXR8aL+VTTkuse+9Q7eDJQYCJ2WkEGzJfBrPyMqQB/kBaQetPxF57JjebE
 2I1ZDh7FhXXIjHuNek3VyCyy94xH6VC0e4VNU+8NfgNE/7ttCVoguic0BSe6bJgLHq5m/54llbJF+HOxGJcNfBe2U7k+G821UdKiJjMhp8Z/o/5zxEhRo7p8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

On 3/19/20 7:15 PM, Josef Bacik wrote:
> On 3/19/20 2:05 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Add a new ioctl to get info about chunk without requiring the root privileges.
>> This allow to a non root user to know how the space of the filesystem is
>> allocated.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/btrfs.h |  38 +++++++
>>   2 files changed, 249 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 40b729dce91c..e9231d597422 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
>>       return ret;
>>   }
>> +/*
>> + * Return:
>> + *    0        -> copied all data, possible further data
>> + *    1        -> copied all data, no further data
>> + *    -EAGAIN        -> not enough space, restart it
>> + *    -EFAULT        -> the user passed an invalid address/size pair
>> + */
>> +static noinline int copy_chunk_info(struct btrfs_path *path,
>> +                   char __user *ubuf,
>> +                   size_t buf_size,
>> +                   u64 *used_buf,
>> +                   int *num_found,
>> +                   u64 *offset)
>> +{
>> +    struct extent_buffer *leaf;
>> +    unsigned long item_off;
>> +    unsigned long item_len;
>> +    int nritems;
>> +    int i;
>> +    int slot;
>> +    struct btrfs_key key;
>> +
>> +    leaf = path->nodes[0];
>> +    slot = path->slots[0];
>> +    nritems = btrfs_header_nritems(leaf);
>> +
>> +    for (i = slot; i < nritems; i++) {
>> +        u64 destsize;
>> +        struct btrfs_chunk_info ci;
>> +        struct btrfs_chunk chunk;
>> +        int j, chunk_size;
>> +
>> +        item_off = btrfs_item_ptr_offset(leaf, i);
>> +        item_len = btrfs_item_size_nr(leaf, i);
>> +
>> +        btrfs_item_key_to_cpu(leaf, &key, i);
>> +        /*
>> +         * we are not interested in other items type
>> +         */
>> +        if (key.type != BTRFS_CHUNK_ITEM_KEY)
>> +            return 1;
>> +
> 
> We'll leak this to user space, this should probably be handled differently right?  Thanks,

Likely I am missing something obvious, but I can't understand what can be leaked and why. Could you be so kindly to elaborate your answer ?
Many thanks

> 
> Josef

BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
