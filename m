Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE8F3B9A16
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 02:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhGBAcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 20:32:55 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.2]:33772 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbhGBAcz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 20:32:55 -0400
X-Greylist: delayed 1372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 20:32:54 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 07DCD400D111A
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jul 2021 19:07:30 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id z6iPlLj5P7sOiz6iQlKsey; Thu, 01 Jul 2021 19:07:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=svnN5JFasnZvlP9YJJWXm87pmoStuhjLGaql0HIrOVo=; b=faV7cYtH/L8MJGUuZDDmesjSgM
        IDt6+dcpvnBhNUoxNSWWZyQhOKWY3M77VDR8OVaQ7dc4oAB3+WaDJAxfNN4NJ6n8/IP0St6LfwS/x
        34q+9P2zJdXzEQSJGopboIA9EHfJOdmgcMWj0ISLw6pGUPcMj1xEGbd1/4kIhlSydW+4BnRecfGf7
        5fZXWdC0qPgbrN74W05keFuf13qJ3cCfF9adcZVHuZWtHX51MPF8qaOuOh66SXp3Ygi42qzP7GktO
        OKLZJhJU7Huu6tfMYy7QKdccWEJD/yma0uJSjkyQFTeRlvuDCCaea2O9+IZy2K6oUFDI69569/Bjv
        C7ebCuJw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:38502 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lz6iO-001049-Nw; Thu, 01 Jul 2021 19:07:28 -0500
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
 <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <dd4346f9-bc3d-b12f-3b32-1e1ecabb5b8b@embeddedor.com>
Date:   Thu, 1 Jul 2021 19:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lz6iO-001049-Nw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:38502
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/1/21 18:59, Qu Wenruo wrote:
> 
> 
> On 2021/7/2 上午5:57, Gustavo A. R. Silva wrote:
>> On Thu, Jul 01, 2021 at 06:00:39PM +0200, David Sterba wrote:
>>> On 64K pages the size of the extent_buffer::pages array is 1 and
>>> compilation with -Warray-bounds warns due to
>>>
>>>    kaddr = page_address(eb->pages[idx + 1]);
>>>
>>> when reading byte range crossing page boundary.
>>>
>>> This does never actually overflow the array because on 64K because all
>>> the data fit in one page and bounds are checked by check_setget_bounds.
>>>
>>> To fix the reported overflow and warning add a copy of the non-crossing
>>> read/write code and put it behind a condition that's evaluated at
>>> compile time. That way only one implementation remains due to dead code
>>> elimination.
>>
>> Any chance we can use a flexible-array in struct extent_buffer instead,
>> so all the warnings are removed?
>>
>> Something like this:
>>
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 62027f551b44..b82e8b694a3b 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -94,11 +94,11 @@ struct extent_buffer {
>>
>>          struct rw_semaphore lock;
>>
>> -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>>          struct list_head release_list;
>>   #ifdef CONFIG_BTRFS_DEBUG
>>          struct list_head leak_list;
>>   #endif
>> +       struct page *pages[];
>>   };
> 
> But wouldn't that make the the size of extent_buffer structure change
> and affect the kmem cache for it?

Could you please point out the places in the code that would be
affected?

I'm trying to understand this code and see the possibility of
using a flex-array together with proper memory allocation, so
we can avoid having one-element array in extent_buffer.

Not sure at what extent this would be possible. So, any pointer
is greatly appreciate it. :)

Thanks
--
Gustavo

> 
> Thanks,
> Qu
>>
>>   /*
>>
>> which is actually what is needed in this case to silence the
>> array-bounds warnings: the replacement of the one-element array
>> with a flexible-array member[1] in struct extent_buffer.
>>
>> -- 
>> Gustavo
>>
>> [1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
>>
>>>
>>> Link: https://lore.kernel.org/lkml/20210623083901.1d49d19d@canb.auug.org.au/
>>> CC: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: David Sterba <dsterba@suse.com>
>>> ---
>>>   fs/btrfs/struct-funcs.c | 66 +++++++++++++++++++++++++----------------
>>>   1 file changed, 41 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
>>> index 8260f8bb3ff0..51204b280da8 100644
>>> --- a/fs/btrfs/struct-funcs.c
>>> +++ b/fs/btrfs/struct-funcs.c
>>> @@ -73,14 +73,18 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,        \
>>>       }                                \
>>>       token->kaddr = page_address(token->eb->pages[idx]);        \
>>>       token->offset = idx << PAGE_SHIFT;                \
>>> -    if (oip + size <= PAGE_SIZE)                    \
>>> +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
>>>           return get_unaligned_le##bits(token->kaddr + oip);    \
>>> +    } else {                            \
>>> +        if (oip + size <= PAGE_SIZE)                \
>>> +            return get_unaligned_le##bits(token->kaddr + oip); \
>>>                                       \
>>> -    memcpy(lebytes, token->kaddr + oip, part);            \
>>> -    token->kaddr = page_address(token->eb->pages[idx + 1]);        \
>>> -    token->offset = (idx + 1) << PAGE_SHIFT;            \
>>> -    memcpy(lebytes + part, token->kaddr, size - part);        \
>>> -    return get_unaligned_le##bits(lebytes);                \
>>> +        memcpy(lebytes, token->kaddr + oip, part);        \
>>> +        token->kaddr = page_address(token->eb->pages[idx + 1]);    \
>>> +        token->offset = (idx + 1) << PAGE_SHIFT;        \
>>> +        memcpy(lebytes + part, token->kaddr, size - part);    \
>>> +        return get_unaligned_le##bits(lebytes);            \
>>> +    }                                \
>>>   }                                    \
>>>   u##bits btrfs_get_##bits(const struct extent_buffer *eb,        \
>>>                const void *ptr, unsigned long off)        \
>>> @@ -94,13 +98,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,        \
>>>       u8 lebytes[sizeof(u##bits)];                    \
>>>                                       \
>>>       ASSERT(check_setget_bounds(eb, ptr, off, size));        \
>>> -    if (oip + size <= PAGE_SIZE)                    \
>>> +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
>>>           return get_unaligned_le##bits(kaddr + oip);        \
>>> +    } else {                            \
>>> +        if (oip + size <= PAGE_SIZE)                \
>>> +            return get_unaligned_le##bits(kaddr + oip);    \
>>>                                       \
>>> -    memcpy(lebytes, kaddr + oip, part);                \
>>> -    kaddr = page_address(eb->pages[idx + 1]);            \
>>> -    memcpy(lebytes + part, kaddr, size - part);            \
>>> -    return get_unaligned_le##bits(lebytes);                \
>>> +        memcpy(lebytes, kaddr + oip, part);            \
>>> +        kaddr = page_address(eb->pages[idx + 1]);        \
>>> +        memcpy(lebytes + part, kaddr, size - part);        \
>>> +        return get_unaligned_le##bits(lebytes);            \
>>> +    }                                \
>>>   }                                    \
>>>   void btrfs_set_token_##bits(struct btrfs_map_token *token,        \
>>>                   const void *ptr, unsigned long off,        \
>>> @@ -124,15 +132,19 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,        \
>>>       }                                \
>>>       token->kaddr = page_address(token->eb->pages[idx]);        \
>>>       token->offset = idx << PAGE_SHIFT;                \
>>> -    if (oip + size <= PAGE_SIZE) {                    \
>>> +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
>>>           put_unaligned_le##bits(val, token->kaddr + oip);    \
>>> -        return;                            \
>>> +    } else {                            \
>>> +        if (oip + size <= PAGE_SIZE) {                \
>>> +            put_unaligned_le##bits(val, token->kaddr + oip); \
>>> +            return;                        \
>>> +        }                            \
>>> +        put_unaligned_le##bits(val, lebytes);            \
>>> +        memcpy(token->kaddr + oip, lebytes, part);        \
>>> +        token->kaddr = page_address(token->eb->pages[idx + 1]);    \
>>> +        token->offset = (idx + 1) << PAGE_SHIFT;        \
>>> +        memcpy(token->kaddr, lebytes + part, size - part);    \
>>>       }                                \
>>> -    put_unaligned_le##bits(val, lebytes);                \
>>> -    memcpy(token->kaddr + oip, lebytes, part);            \
>>> -    token->kaddr = page_address(token->eb->pages[idx + 1]);        \
>>> -    token->offset = (idx + 1) << PAGE_SHIFT;            \
>>> -    memcpy(token->kaddr, lebytes + part, size - part);        \
>>>   }                                    \
>>>   void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,    \
>>>                 unsigned long off, u##bits val)            \
>>> @@ -146,15 +158,19 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,    \
>>>       u8 lebytes[sizeof(u##bits)];                    \
>>>                                       \
>>>       ASSERT(check_setget_bounds(eb, ptr, off, size));        \
>>> -    if (oip + size <= PAGE_SIZE) {                    \
>>> +    if (INLINE_EXTENT_BUFFER_PAGES == 1) {                \
>>>           put_unaligned_le##bits(val, kaddr + oip);        \
>>> -        return;                            \
>>> -    }                                \
>>> +    } else {                            \
>>> +        if (oip + size <= PAGE_SIZE) {                \
>>> +            put_unaligned_le##bits(val, kaddr + oip);    \
>>> +            return;                        \
>>> +        }                            \
>>>                                       \
>>> -    put_unaligned_le##bits(val, lebytes);                \
>>> -    memcpy(kaddr + oip, lebytes, part);                \
>>> -    kaddr = page_address(eb->pages[idx + 1]);            \
>>> -    memcpy(kaddr, lebytes + part, size - part);            \
>>> +        put_unaligned_le##bits(val, lebytes);            \
>>> +        memcpy(kaddr + oip, lebytes, part);            \
>>> +        kaddr = page_address(eb->pages[idx + 1]);        \
>>> +        memcpy(kaddr, lebytes + part, size - part);        \
>>> +    }                                \
>>>   }
>>>
>>>   DEFINE_BTRFS_SETGET_BITS(8)
>>> -- 
>>> 2.31.1
>>>
