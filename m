Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4788631927F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhBKSr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 13:47:58 -0500
Received: from smtp-17.italiaonline.it ([213.209.10.17]:45101 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229679AbhBKSrw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:47:52 -0500
Received: from venice.bhome ([78.12.25.19])
        by smtp-17.iol.local with ESMTPA
        id AGzPlzLmjlChfAGzPlG9yX; Thu, 11 Feb 2021 19:46:56 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1613069216; bh=CMV2p9VxQa8MUOzB9jkwF++eAlOlH8C/UaBnS1SFwBk=;
        h=From;
        b=WUA7OYFzv6of+dHgtSC5Blc6Bc0X1kLBwtw8IjhALsdhlwfoCSWw4yNChbPNKeLve
         9GnBxi7hxBUabvCjq45FuGFe+7kw2ysUE9gvPY+67pDIw6cHsvUIaA20n+iiGDxG6k
         U8oJFo+On/IOCCCuCs6mX2fu6SBXoa0Mb9TphryqJ8HSCQPvFBdypYZ6v3xFdxerYB
         UrgWbW7FcX3EhUX054GJUMGGfA174FQLvgh21Tb63O/tHvxQPiCIbs96iCV4Kq+xTf
         TATqCvSJc7tkS+V1SH4DlxEzKrMCKTkxPCq06RUz57X6T75JtLX1ol0cZOYI7SrPo2
         yXNaaGcAu1k8Q==
X-CNFS-Analysis: v=2.4 cv=S6McfKgP c=1 sm=1 tr=0 ts=60257ba0 cx=a_exe
 a=cZ/q60u+NbBn6HfapJxCHg==:117 a=cZ/q60u+NbBn6HfapJxCHg==:17
 a=IkcTkHD0fZMA:10 a=w-2WzCQpt14Tbe6Q6ZAA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 5/5] btrfs: add allocator_hint mode
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20210201212820.64381-1-kreijack@libero.it>
 <20210201212820.64381-6-kreijack@libero.it>
 <e1610b05-433c-cd17-759a-743ed3abdf7d@toxicpanda.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <60c5fd45-4488-734a-d4de-de1a121055ef@libero.it>
Date:   Thu, 11 Feb 2021 19:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e1610b05-433c-cd17-759a-743ed3abdf7d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJsBeX9LN0f3atg+lGZKqHbMJfx48QDeQ61hS3pecX+oi71HIc4yXLCTIpxVcRm8diSSE7bxB4+XYdKtBFRucYhVa4yK/Tx09KcPboQLhuPCcM0XrmmP
 8ehkZOhJNJmTSpczpiQniT+LE0VwedWk3v6QQTxazVb+kCM2L0AodKHFCRToqpzuOnBsenxDxkL3abi68Dsl0qSvvAnQClgNsEl8wFglU2OvJtLeP1A8CgHn
 qCDqfJgq5zOFcFRGRk5Qnp38sa/gyUEvL7wgcsr5rIQcXtPmNhqfeLNyXwOYFgS+
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/10/21 5:12 PM, Josef Bacik wrote:
> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
[...]
>> +    int hint;
>> +
>> +    static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
>> +        [BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
>> +        [BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
>> +        [BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 1,
>> +        [BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 2
>> +        /* the other values are set to 0 */
>> +    };
> 
> This can be made global, up with the btrfs_raid_array definitions.

I moved this in the beginning, outside the functions. It still "static", so no global.
> 
[...]

>>       /*
>>        * now sort the devices by hole size / available space
>>        */
>>       sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>            btrfs_cmp_device_info, NULL);
>> +    /*
>> +     * select the minimum set of disks grouped by hint that
>> +     * can host the chunk
>> +     */
>> +    ndevs = 0;
>> +    while (ndevs < ctl->ndevs) {
>> +        hint = devices_info[ndevs++].alloc_hint;
>> +        while (devices_info[ndevs].alloc_hint == hint &&
>> +               ndevs < ctl->ndevs)
>> +                ndevs++;
>> +        if (ndevs >= ctl->devs_min)
>> +            break;
>> +    }
> 
> Can we just adjust btrfs_cmp_device_info to take the hint info into account? Thanks,

Unfortunately No. btrfs_cmp_device_info is used to sort the disks list.
Instead this piece of code *limits* the available number of disks to a disks set
sufficient to host the new chunk.

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
