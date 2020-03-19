Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4132318C214
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 22:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCSVJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 17:09:44 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:38713 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgCSVJn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 17:09:43 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-32.iol.local with ESMTPA
        id F2Q7jNHyNa1lLF2Q7jnHJg; Thu, 19 Mar 2020 22:09:40 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584652180; bh=nB/ZWL/zKFq1ZILPv6hbLwHc0CXaydNrUx25EvB90Og=;
        h=From;
        b=fy3Jn1ggK1uk1Sgl4rcdiAIkvaOQwloiVo+yYGychUtXlgekgh3lYJjhqFTFs46NA
         oaf/McucUPLmWT6dMHSF+EXXPRi+6XLxGCozWuqBBL8Y58Z7+FBb9+hAoI7grGEzNH
         IWCxM/3JoEZsQ9LuxkvTH13XxLWqqEP1PteTzkwStNypEVJ7HmCp20iSAv0ZJROu45
         H3yXeGGCnn5zUVm30Ldv2E2Axgt4P1VU1YHvyp0UlJPMGkmUeIgN3P4G+yTjnAcVuh
         EKdV32G2oYQ2rt91AOpcEC56jP121R96YD6HLbXTgwj26ECl5t/oQj2J2LKVLSObTC
         ahizfowvCbU1g==
X-CNFS-Analysis: v=2.3 cv=IOJ89TnG c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=F0g-YP2QzlFsH_K13GYA:9
 a=qlx1Y0SffcSBXFsO:21 a=ZHI5yrzk5xzKKoRi:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <88960b6d-88dd-a1cd-05d5-46bf94f53230@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <a9d95ded-7563-0a0d-f9f4-914bce343661@libero.it>
Date:   Thu, 19 Mar 2020 22:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <88960b6d-88dd-a1cd-05d5-46bf94f53230@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfImruLL+yw1fPJa/BVu1asU7bHBM+ODN3/QYplJqZ2x4YvTfoCHutpLAzLvtjmxSRyH3XUzA19oARga1m465nJ1Yi/NJ9KpXBPPKor2ot58GCrtQ/72T
 ZVtojJHh7/WWtvfb51SWXv90pmIur7GWzH06g6BGMVq4LQujSQDpxOPo7xCQFzZyt8YEO1RXYdLZN1AWp7jNaeFE9Y1dZqOBqr5I0GxRR0gXu8JBrz6wxC4s
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/20 9:59 PM, Josef Bacik wrote:
> On 3/19/20 4:39 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Add a new ioctl to get info about chunk without requiring the root
>> privileges. This allow to a non root user to know how the space of the
>> filesystem is allocated.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/ioctl.c           | 211 +++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/btrfs.h |  38 +++++++
>>   2 files changed, 249 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 40b729dce91c..b3296a479bf6 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -2234,6 +2234,215 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
>>       return ret;
>>   }
>> +/*
>> + * Return:
>> + *    1        -> copied all data, possible further data
>> + *    0        -> copied all data, no further data
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
[...]
>> +
>> +static noinline int btrfs_ioctl_get_chunk_info(struct file *file,
>> +                           void __user *argp)
>> +{
>> +    struct btrfs_ioctl_chunk_info arg;
>> +    struct inode *inode;
>> +    int ret;
>> +    size_t buf_size;
>> +    u64 data_offset;
>> +    const size_t buf_limit = SZ_16M;
>> +
>> +
>> +    data_offset = sizeof(struct btrfs_ioctl_chunk_info);
> 
> I think I'm missing something, but since we have a single btrfs_chunk_info_stripe at the end, this will point to the next slot, so we're just copying in starting at slot 1, not slot 0, because you pass in argp + data_offset below.  This looks wonky to me, thanks,

I think that you are confunsing  "struct btrfs_ioctl_chunk_info" with "struct btrfs_chunk_info". Only the second one has the single "struct btrfs_chunk_info_stripe" at the end. May be ?



> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
