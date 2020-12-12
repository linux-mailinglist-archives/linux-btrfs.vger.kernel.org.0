Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86AB2D85A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437357AbgLLKEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 05:04:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:32870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438563AbgLLKE0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 05:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607765217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=oopJDJgb5gj8qAschqVd0YtlbNXik5YiULD1RGyaUho=;
        b=NpUFyWPG/5kw2ZUY0Ui4vUEInBUVhPvDuN//AOLgKyW0lUox8lmEj4lDzIOWa5cWgweF1v
        v1UI4u2dpmM0uN5toBMOk8nezV59g9uwt5zoZkHiFZxyFjBdETRMJwe9/CqXWCbbmpgJ6W
        +fCDo9QkEJrzUL8wQI2AjgPMBpvYSVA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57428AEBE;
        Sat, 12 Dec 2020 09:26:57 +0000 (UTC)
Subject: Re: [PATCH v2 12/18] btrfs: extent_io: implement
 try_release_extent_buffer() for subpage metadata support
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-13-wqu@suse.com>
 <d6684ad3-875e-53f1-cf1d-a4490c35c4f9@suse.com>
 <a2732cae-4dea-744e-2eda-8b8e5f2b6710@suse.com>
 <047a66b1-5804-ac05-26ac-4eaf71f5c4df@suse.com>
 <00601760-4e7d-935a-e2bb-056593ff5a39@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f793704e-fdb5-d79e-7a16-bf6e182bb707@suse.com>
Date:   Sat, 12 Dec 2020 11:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00601760-4e7d-935a-e2bb-056593ff5a39@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.12.20 г. 3:28 ч., Qu Wenruo wrote:
> 
> 
> On 2020/12/12 上午12:57, Nikolay Borisov wrote:
>>
>>
>> On 11.12.20 г. 14:11 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2020/12/11 下午8:00, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 10.12.20 г. 8:38 ч., Qu Wenruo wrote:
>>>>> Unlike the original try_release_extent_buffer,
>>>>> try_release_subpage_extent_buffer() will iterate through
>>>>> btrfs_subpage::tree_block_bitmap, and try to release each extent
>>>>> buffer.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>   fs/btrfs/extent_io.c | 73
>>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 73 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>>> index 141e414b1ab9..4d55803302e9 100644
>>>>> --- a/fs/btrfs/extent_io.c
>>>>> +++ b/fs/btrfs/extent_io.c
>>>>> @@ -6258,10 +6258,83 @@ void memmove_extent_buffer(const struct
>>>>> extent_buffer *dst,
>>>>>       }
>>>>>   }
>>>>>
>>>>> +static int try_release_subpage_extent_buffer(struct page *page)
>>>>> +{
>>>>> +    struct btrfs_fs_info *fs_info =
>>>>> btrfs_sb(page->mapping->host->i_sb);
>>>>> +    u64 page_start = page_offset(page);
>>>>> +    int bitmap_size = BTRFS_SUBPAGE_BITMAP_SIZE;
>>>>
>>>> Remove this variable and directly use BTRFS_SUBPAGE_BITMAP_SIZE as a
>>>> terminating condition
>>>>
>>>>> +    int bit_start = 0;
>>>>> +    int ret;
>>>>> +
>>>>> +    while (bit_start < bitmap_size) {
>>>>
>>>> You really want to iterate for a fixed number of items so switch
>>>> that to
>>>> a for loop.
>>>
>>> The problem here is, it's not always fixed.
>>>
>>> If it finds one bit set, it will skip (nodesize >> sectorsize_bits)
>>> bits.
>>>
>>> But if not found, it will skip to just next bit.
>>>
>>> Thus I'm not sure if for loop is really a good choice here for
>>> differential step.
>>>
>>>>
>>>>> +        struct btrfs_subpage *subpage;
>>>>> +        struct extent_buffer *eb;
>>>>> +        unsigned long flags;
>>>>> +        u16 tmp = 1 << bit_start;
>>>>> +        u64 start;
>>>>> +
>>>>> +        /*
>>>>> +         * Make sure the page still has private, as previous run can
>>>>> +         * detach the private
>>>>> +         */
>>>>
>>>> But if previous run has run it would have disposed of this eb and you
>>>> won't find this page at all, no ?
>>>
>>> For the "previous run" I mean, previous iteration in the same loop.
>>>
>>> E.g. the page has 4 bits set, just one eb (16K nodesize).
>>
>> Isn't it guaranteed that if you iterate the eb's in a page if you meet
>> an empty block then the whole extent buffer is gone, hence instead of
>> doing bit_start++ you ought to also increment by the size of nodesize.
>>
>> For example, assume a page contains 4 EBs:
>>
>> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
>> x|x|x|x|0|0|0|0|x|x| x|x |0 | 0|0 |0
>>
>> So first bit is set, so you proceed to call release_extent_buffer on it,
>> which clears the first 4 bits in tree_block_bitmap, in this case you've
>> incremented by nodesize so next iteration begins at index 4. You detect
>> it's unset (0) hence you increment it byte 1 and you repeat this for the
>> next 3 bits, then you free the whole of the next eb. I argue that you
>> also need to increment by nodesize in the case of a bit which is not
>> set, because you cannot really see partially freed eb i.e you cannot see
>> the following state:
>>
>> 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
>> x|x|x|x|x|0|0|0|x|x| x|x |0 | 0|0 |0
>>
>> Am I missing something?
> 
> It's not for partly freed eb, but nodesize unaligned eb.
> 
> E.g. if we have a eb starts at sector 1 of a page, your nodesize based
> iteration would go crazy.
> Although we have ensured no subpage eb can cross page boundary, but it's
> not the same requirement for nodesize alignment.
> 
> Thus I uses the extra safe way for the empty bit.

Which of course cannot happen because the allocator ensures that
returned addresses are always aligned to fs_info::stripeize which in
turn is always equal to sectorsize... So you add extra complexity for no
apparent reason making code which is already subtle to be even more subtle.

<snip>
