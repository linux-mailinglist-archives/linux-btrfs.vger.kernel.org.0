Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D495F13A227
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 08:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgANHbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 02:31:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANHbX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 02:31:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 075E6AC7D;
        Tue, 14 Jan 2020 07:31:21 +0000 (UTC)
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
To:     Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
 <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <69a2bb9d-76ed-d273-4ee6-105a0bc2d85b@suse.com>
Date:   Tue, 14 Jan 2020 09:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.01.20 г. 9:21 ч., Anand Jain wrote:
> 
> 
> On 14/1/20 2:54 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/1/14 下午2:09, Anand Jain wrote:
>>> The first argument to btrfs_printk() wrappers such as
>>> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some
>>> context like scan and assembling of the volumes there isn't fs_info yet,
>>> so those code generally don't use the btrfs_printk() wrappers and it
>>> could could still use NULL but then it would become hard to distinguish
>>> whether fs_info is NULL for genuine reason or a bug.
>>>
>>> So introduce a define NO_FS_INFO to be used instead of NULL so that we
>>> know the code where fs_info isn't initialized and also we have a
>>> consistent logging functions. Thanks.
>>
>> I'm not sure why this is needed.
>>
>> Could you give me an example in which NULL is not clear enough?
>>
> 
> The first argument in btrfs_info_in_rcu() can be NULL like for example..
> btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..
> 
>    BTRFS info (device <unknown>):
> 
>  Lets say due to some bug local copy of the variable fs_info wasn't
> initialized then we end up printing the same unknown <unknown>.

This is wrong if the local copy variable is not initialized then it will
get random value from stack which will likely crash during deref because
it will most certainly not be NULL.

> 
>   So in the context of device_list_add() as there is no fs_info
> genuinely and be different from unknown we use
> btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..
> 
>  BTRFS info (device ...):
> 
> Thanks, Anand
> 
> 
>> Thanks,
>> Qu
>>
>>>
>>> Suggested-by: David Sterba <dsterba@suse.com>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/ctree.h |  5 +++++
>>>   fs/btrfs/super.c | 14 +++++++++++---
>>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 569931dd0ce5..625c7eee3d0f 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -110,6 +110,11 @@ struct btrfs_ref;
>>>   #define BTRFS_STAT_CURR        0
>>>   #define BTRFS_STAT_PREV        1
>>>   +/*
>>> + * Used when we know that fs_info is not yet initialized.
>>> + */
>>> +#define    NO_FS_INFO    ((void *)0x1)
>>> +
>>>   /*
>>>    * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
>>>    */
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index a906315efd19..5bd8a889fed0 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct
>>> btrfs_fs_info *fs_info, const char *fmt, .
>>>       vaf.fmt = fmt;
>>>       vaf.va = &args;
>>>   -    if (__ratelimit(ratelimit))
>>> -        printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> -            fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
>>> +    if (__ratelimit(ratelimit)) {
>>> +        if (fs_info == NULL)
>>> +            printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +                "<unknown>", &vaf);
>>> +        else if (fs_info == NO_FS_INFO)
>>> +            printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +                "...", &vaf);
>>> +        else
>>> +            printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>>> +                fs_info->sb->s_id, &vaf);
>>> +    }
>>>         va_end(args);
>>>   }
>>>
>>
