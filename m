Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152931927E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 19:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBKSr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 13:47:56 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:55364 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhBKSrv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:47:51 -0500
Received: from venice.bhome ([78.12.25.19])
        by smtp-17.iol.local with ESMTPA
        id AGzUlzLo5lChfAGzUlG9zm; Thu, 11 Feb 2021 19:47:00 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613069220; bh=9OjgXshb5YfAnmWR1XrmjimUFXTNXP1q7oRIHlwRbcE=;
        h=From;
        b=e/1POflytIzWNlTfpipIvo/6o2dE3oEvGWUQ48ZnyGXYSWMambf+fNjLAHNb3FM0y
         Y+OVBHvNZDGRuC6ymWJWMd8o5jltIA7Y35euBrJPopOKnzLdqLr5AACB7nbaQuH49t
         YXpv1y8U8LDDD9PNiNxv6vHJi16/cVlF1+VDoS26KixuT7mdkaz4IW90zBoAqyJHEB
         Dy89SLUVZOfMtnzkxMGBuCJIT8gxwa+DSkj4fNehW0dZNxwGU4an6A6+wK/JqX0i/f
         3dLyty4mMy7cTukh/5LdxXOtVj3aIku2bq1TP/YyWZA85sBIHzGNpLBqfBhitOB8Gp
         RTJyOszU+eQhg==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60257ba4 cx=a_exe
 a=cZ/q60u+NbBn6HfapJxCHg==:117 a=cZ/q60u+NbBn6HfapJxCHg==:17
 a=IkcTkHD0fZMA:10 a=ghJLoWAcZwzOweymRikA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/5] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-2-kreijack@libero.it>
 <29e32334-8c76-35d0-f756-723688f6e927@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <b39dcabb-43fd-2709-de07-2ed53525c972@libero.it>
Date:   Thu, 11 Feb 2021 19:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <29e32334-8c76-35d0-f756-723688f6e927@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPcwADMEDQvCQ/JNo/EbrseCWlOAhdZwSrHRnpdVheOyQTn4Ckj44LHw5qqtEtj38CbwVj4Rmg3Jn4W3DkM8HJWOrLc5mxC+fNe/e3CNVg8k1EP7n5xs
 PELErfxENAobnPqyft+ZmzA0JPAgCQGJCtthP/O7SQjKnmClmj7vIo1Vni7fb1VtbGf5yZH7csDGeVouA5f4pG8NtMeVJhKAV/qJBCl8WeOvB16DcMsWfAEV
 DmIqgXi1mXCdKiIDN6YMHm4e/0sMBcwp6QpopR8UNTctfVUP124hNrvwDk4wbp9X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/21 5:08 PM, Josef Bacik wrote:
> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> This ioctl is a base for returning / setting information from / to  the
>> fields of the btrfs_dev_item object.
>>
>> For now only the "type" field is returned / set.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
[...]
>> +    /* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
>> +    if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
>> +        return -EPERM;
>> +
>> +    trans = btrfs_start_transaction(root, 0);
> 
> This needs to be 1, we're updating an item.

Ok

[...]
>> + * Up to 2020/05/11 the only properties that can be read/write is the 'type'
>> + * one.
>> + */
>> +struct btrfs_ioctl_dev_properties {
>> +    __u64    devid;
>> +    __u64    properties;
>> +    __u64    type;
>> +    __u32    dev_group;
>> +    __u8    seek_speed;
>> +    __u8    bandwidth;
>> +
>> +    /*
>> +     * for future expansion
>> +     */
>> +    __u8    unused1[2];
>> +    __u64    unused2[4];
>> +};
>> +
> 
> I think we're padding out to 1k for new stuff like this?  We can never have too much room for expansion.  Thanks,
Ok, in the next iteration this will be expanded up to 1kB

> 
> Josef

Ciao
Goffredo

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
