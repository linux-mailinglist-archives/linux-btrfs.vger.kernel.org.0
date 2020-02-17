Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE01A16144E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBQONw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 09:13:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgBQONw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 09:13:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CCF0B32A;
        Mon, 17 Feb 2020 14:13:49 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] btrfs: backref: Implement
 btrfs_backref_iterator_next()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200217063111.65941-1-wqu@suse.com>
 <20200217063111.65941-3-wqu@suse.com>
 <e5e5ba05-2f9f-d8be-63bb-9bcd3e0c090e@suse.com>
 <2cee1b97-b6a3-bffd-8cb0-cb7d903497ca@gmx.com>
 <696547c7-84ea-d346-cecb-6270c2430031@suse.com>
 <3aadef5b-7bd2-b830-869f-67de417a4600@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c75fb84e-fa6b-a666-a30a-811d95c6735a@suse.com>
Date:   Mon, 17 Feb 2020 16:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3aadef5b-7bd2-b830-869f-67de417a4600@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.02.20 г. 13:45 ч., Qu Wenruo wrote:
> 
> 
> On 2020/2/17 下午7:42, Nikolay Borisov wrote:
>>
>>
>> On 17.02.20 г. 13:29 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2020/2/17 下午6:47, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 17.02.20 г. 8:31 ч., Qu Wenruo wrote:
>>>>> This function will go next inline/keyed backref for
>>>>> btrfs_backref_iterator infrastructure.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>  fs/btrfs/backref.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  fs/btrfs/backref.h | 34 +++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 81 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
>>>>> index 8bd5e067831c..fb0abe344851 100644
>>>>> --- a/fs/btrfs/backref.c
>>>>> +++ b/fs/btrfs/backref.c
>>>>> @@ -2310,3 +2310,50 @@ int btrfs_backref_iterator_start(struct btrfs_backref_iterator *iterator,
>>>>>  	btrfs_backref_iterator_release(iterator);
>>>>>  	return ret;
>>>>>  }
>>>>> +
>>>>> +int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterator)
>>>>
>>>> Document the return values: 0 in case there are more backerfs for the
>>>> given bytenr or 1 in case there are'nt. And a negative value in case of
>>>> error.
>>>>
>>>>> +{
>>>>> +	struct extent_buffer *eb = btrfs_backref_get_eb(iterator);
>>>>> +	struct btrfs_path *path = iterator->path;
>>>>> +	struct btrfs_extent_inline_ref *iref;
>>>>> +	int ret;
>>>>> +	u32 size;
>>>>> +
>>>>> +	if (btrfs_backref_iterator_is_inline_ref(iterator)) {
>>>>> +		/* We're still inside the inline refs */
>>>>> +		if (btrfs_backref_has_tree_block_info(iterator)) {
>>>>> +			/* First tree block info */
>>>>> +			size = sizeof(struct btrfs_tree_block_info);
>>>>> +		} else {
>>>>> +			/* Use inline ref type to determine the size */
>>>>> +			int type;
>>>>> +
>>>>> +			iref = (struct btrfs_extent_inline_ref *)
>>>>> +				(iterator->cur_ptr);
>>>>> +			type = btrfs_extent_inline_ref_type(eb, iref);
>>>>> +
>>>>> +			size = btrfs_extent_inline_ref_size(type);
>>>>> +		}
>>>>> +		iterator->cur_ptr += size;
>>>>> +		if (iterator->cur_ptr < iterator->end_ptr)
>>>>> +			return 0;
>>>>> +
>>>>> +		/* All inline items iterated, fall through */
>>>>> +	}
>>>>
>>>> This if could be rewritten as:
>>>> if (btrfs_backref_iterator_is_inline_ref(iterator) && iterator->cur_ptr
>>>> < iterator->end_ptr)
>>>>
>>>> what this achieves is:
>>>>
>>>> 1. Clarity that this whole branch is executed only if we are within the
>>>> inline refs limits
>>>> 2. It also optimises that function since in the current version, after
>>>> the last inline backref has been processed iterator->cur_ptr ==
>>>> iterator->end_ptr. On the next call to btrfs_backref_iterator_next you
>>>> will execute (needlessly)
>>>>
>>>> (struct btrfs_extent_inline_ref *) (iterator->cur_ptr);
>>>> type = btrfs_extent_inline_ref_type(eb, iref);
>>>> size = btrfs_extent_inline_ref_size(type);
>>>> iterator->cur_ptr += size;
>>>> only to fail "if (iterator->cur_ptr < iterator->end_ptr)" check and
>>>> continue processing keyed items.
>>>>
>>>> As a matter of fact you will be reading past the metadata_item  since
>>>> cur_ptr will be at the end of them and any deferences will read from the
>>>> next item this might not cause a crash but it's still wrong.
>>>
>>> This shouldn't happen, as we must ensure the cur_ptr < item_end for callers.
>>
>>
>> How are you ensuring this? Before processing the last inline ref
>> cur_ptr  would be end_ptr - btrfs_extent_inline_ref_size(type);
> 
> Firstly, in _start() call, we can easily check if we have any inline refs.
> 
> If no, search next item.
> If yes, return cur_ptr which points to the current inline extent ref.
> 
> Secondly, in _next() call, we keep current check. Increase cur_ptr, then
> check against ptr_end.
> 
> So that, all backref_iter callers will get a cur_ptr that is always
> smaller than ptr_end.

Apparently not, btrfs/003 with the following assert:

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index fb0abe344851..403a75f0c99c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2328,6 +2328,7 @@ int btrfs_backref_iterator_next(struct
btrfs_backref_iterator *iterator)
                        /* Use inline ref type to determine the size */
                        int type;

+                       ASSERT(iterator->cur_ptr < iterator->end_ptr);
                        iref = (struct btrfs_extent_inline_ref *)
                                (iterator->cur_ptr);
                        type = btrfs_extent_inline_ref_type(eb, iref);


Trigger:

[   58.884441] assertion failed: iterator->cur_ptr < iterator->end_ptr,
in fs/btrfs/backref.c:2331


> 
> Thanks,
> Qu
>>
>> After it's processed cur_ptr == end_ptr. THen you will do another call
>> to btrfs_backref_iterator_next which will do the same calculation? What
>> am I missing?
>>
>>>
>>> For the _next() call, the check after increased cur_ptr check it's OK.
>>>
>>> But it's a problem for _start() call, as we may have a case where an
>>> EXTENT_ITEM/METADATA_ITEM has no inlined ref.
>>>
>>> I'll fix this in next version.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>
>>>>> +	/* We're at keyed items, there is no inline item, just go next item */
>>>>> +	ret = btrfs_next_item(iterator->fs_info->extent_root, iterator->path);
>>>>> +	if (ret > 0 || ret < 0)
>>>>> +		return ret;
>>>>
>>>> nit: if (ret != 0) return ret;
>>>>
>>>> <snip>
>>>>
