Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63FADB40
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfIIOeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:34:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbfIIOeM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 10:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FEC7ABBE;
        Mon,  9 Sep 2019 14:34:10 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] btrfs-progs: check/common: Introduce a function to
 find imode using INODE_REF
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-3-wqu@suse.com>
 <4e7099d2-5b4c-1fa3-ffdf-2b3332ed0b88@suse.com>
 <37228196-3617-e253-6ad1-125e72e6628c@gmx.com>
Cc:     David Sterba <dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9e38c008-6a3e-cf90-4e65-26066710060e@suse.com>
Date:   Mon, 9 Sep 2019 17:34:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <37228196-3617-e253-6ad1-125e72e6628c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.09.19 г. 17:24 ч., Qu Wenruo wrote:
> 
> 
> On 2019/9/9 下午9:25, Nikolay Borisov wrote:
>>
>>
>> On 5.09.19 г. 10:57 ч., Qu Wenruo wrote:
>>> Introduce a function, find_file_type(), to find filetype using
>>> INODE_REF.
>>>
>>> This function will:
>>> - Search DIR_INDEX first
>>>   DIR_INDEX is easier since there is only one item in it.
>>>
>>> - Valid the DIR_INDEX item
>>>   If the DIR_INDEX is valid, use the filetype and call it a day.
>>>
>>> - Search DIR_ITEM then
>>>
>>> - Valide the DIR_ITEM
>>>   If valid, call it a day. Or return -ENOENT;
>>>
>>> This would be used as the primary method to determine the imode in later
>>> imode repair code.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  check/mode-common.c | 99 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 99 insertions(+)
>>>
>>> diff --git a/check/mode-common.c b/check/mode-common.c
>>> index 195b6efaa7aa..c0ddc50a1dd0 100644
>>> --- a/check/mode-common.c
>>> +++ b/check/mode-common.c
>>> @@ -16,6 +16,7 @@
>>>
>>>  #include <time.h>
>>>  #include "ctree.h"
>>> +#include "hash.h"
>>>  #include "common/internal.h"
>>>  #include "common/messages.h"
>>>  #include "transaction.h"
>>> @@ -836,6 +837,104 @@ int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>>>  	return ret;
>>>  }
>>>
>>> +static int find_file_type(struct btrfs_root *root, u64 ino, u64 dirid,
>>> +			  u64 index, const char *name, u32 name_len,
>>> +			  u32 *imode_ret)
>>> +{
>>> +	struct btrfs_path path;
>>> +	struct btrfs_key location;
>>> +	struct btrfs_key key;
>>> +	struct btrfs_dir_item *di;
>>> +	char namebuf[BTRFS_NAME_LEN] = {0};
>>> +	unsigned long cur;
>>> +	unsigned long end;
>>> +	bool found = false;
>>> +	u8 filetype;
>>> +	u32 len;
>>> +	int ret;
>>> +
>>> +	btrfs_init_path(&path);
>>> +
>>> +	/* Search DIR_INDEX first */
>>> +	key.objectid = dirid;
>>> +	key.offset = index;
>>> +	key.type = BTRFS_DIR_INDEX_KEY;
>>> +
>>> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>>> +	if (ret > 0)
>>> +		ret = -ENOENT;
>>
>> Even if it returns 1 meaning there is no DIR_INDEX item perhaps it still
>> makes sense to go to dir_item: label to search for DIR_ITEM, what if the
>> corruption has affected just the DIR_INDEX item?
> 
> I didn't get the point.
> 
> The next line is just going to do dir_item search, just as you mentioned.

You are right, however, this is somewhat subtle and the fact I missed it
just proves the point. The following will be much better (and explicit):

if (ret)
   goto dir_item

In fact setting the -ENOENT on ret > 0 is only needed because of the
awkward way the return value of btrfs_search_slot is handled. So yeah,
I'm even more convinced that a simple if (ret) goto dir_item (or call a
function) is the way to go here.

>>
>>> +	if (ret < 0)
>>> +		goto dir_item;
>> nit: Use elseif to make it more explicit it is a single construct.
> 
> Not sure such usage is recommened, but I see a lot of usage like:
> 	ret = btrfs_search_slot();
> 	if (ret > 0)
> 		ret = -ENOENT;
> 	if (ret < 0)
> 		goto error;
> 
> So I just followed this practice.
> 

I guess this is debatable. You are right that most of the retval
handling is as you say but I think the more "purist" (so to say) way
should be an if {} else if {}. Because ultimately you are handling one
thing - the return value of btrfs_search_slot.

 David, what is your take on that ?

<snip>
