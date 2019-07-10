Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC6460D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGJMMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 08:12:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfGJMMk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 08:12:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8DE6AD70;
        Wed, 10 Jul 2019 12:12:38 +0000 (UTC)
Subject: Re: [PATCH 5/5] btrfs: ctree: Checking key orders before merged tree
 blocks
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-6-wqu@suse.com>
 <ba828afc-46b9-b48f-1b05-e5bd3b78af6e@suse.com>
 <3547c87e-5da0-d4d5-0c37-9e4957a2d390@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <49581349-af2d-f800-c3fc-095ef96ab755@suse.com>
Date:   Wed, 10 Jul 2019 15:12:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3547c87e-5da0-d4d5-0c37-9e4957a2d390@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.07.19 г. 15:02 ч., Qu Wenruo wrote:
> 
> 
> On 2019/7/10 下午7:19, Nikolay Borisov wrote:
>>
>>
> [...]
>>> +static int check_cross_tree_key_order(struct extent_buffer *left,
>>> +				      struct extent_buffer *right)
>>> +{
>>> +	struct btrfs_key left_last;
>>> +	struct btrfs_key right_first;
>>> +	int level = btrfs_header_level(left);
>>> +	int nr_left = btrfs_header_nritems(left);
>>> +	int nr_right = btrfs_header_nritems(right);
>>> +
>>> +	/* No key to check in one of the tree blocks */
>>> +	if (!nr_left || !nr_right)
>>> +		return 0;
>>> +	if (level) {
>>> +		btrfs_node_key_to_cpu(left, &left_last, nr_left - 1);
>>> +		btrfs_node_key_to_cpu(right, &right_first, 0);
>>> +	} else {
>>> +		btrfs_item_key_to_cpu(left, &left_last, nr_left - 1);
>>> +		btrfs_item_key_to_cpu(right, &right_first, 0);
>>> +	}
>>> +	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
>>> +		btrfs_crit(left->fs_info,
>>> +"bad key order cross tree blocks, left last (%llu %u %llu) right first (%llu %u %llu",
>>> +			   left_last.objectid, left_last.type,
>>> +			   left_last.offset, right_first.objectid,
>>> +			   right_first.type, right_first.offset);
>>> +		return -EUCLEAN;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>
>> nit: I wonder if it will make it a bit easier to reason about the code
>> if that function is renamed to valid_cross_block_key_order and make it
>> return true or false, then it's callers will do if
>> (!valid_cross_block_key_ordered) {
>> return -EUCLEAN
>> }>
> I'm always uncertain what's the correct schema for check function.
> 
> Sometimes we have bool check_whatever() sometimes we have bool
> is_whatever(), and sometimes we have int check_whatever().
> 
> If we have a good guidance for btrfs, it will be a no-brain choice.

There is no such guidance in this case my logic is that this function
really returns a boolean value - 0 or -EUCLEAN to make that explicit I'd
define it as returning bool and rename it to valid_cross_block_key_order
to really emphasize the fact it's a predicated-type of function. Thus if
someone reads the they will be certain that this function return either
true or false depending on whether the input parameters make sense.
Whereas right now I will have to go and look at the implementation to
determine what are the return values because of the "int" return type.

Again, that's just me and if you deem it doesn't bring value then feel
free to ignore it.



> 
>>
>> I guess it won't be much different than it is now.
>>
>>>  /*
>>>   * try to push data from one node into the next node left in the
>>>   * tree.
>>> @@ -3263,6 +3309,10 @@ static int push_node_left(struct btrfs_trans_handle *trans,
>>>  	} else
>>>  		push_items = min(src_nritems - 8, push_items);
>>>
>>> +	/* dst is the left eb src is the middle eb */
>> nit: missing ',' between 'eb' and 'src'. But this is very minor.
> 
> I'd prefer the rename the parameter of push_node_left() directly in
> another patch so that we won't need this comment at all.
> 
> @dst @src?! That makes no sense compared to @left and @right.

I somewhat agree, however you will also need to rename the respective nr
items variables -> src_nritems/dst_nritems.


> 
> Thanks,
> Qu
> 
>>
>>
>>> +	ret = check_cross_tree_key_order(dst, src);
>>> +	if (ret < 0)
>>> +		return ret;
>>>  	ret = tree_mod_log_eb_copy(dst, src, dst_nritems, 0, push_items);
>>>  	if (ret) {
>>>  		btrfs_abort_transaction(trans, ret);
>>> @@ -3331,6 +3381,10 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
>>>  	if (max_push < push_items)
>>>  		push_items = max_push;
>>>
>>> +	/* dst is the right eb, src is the middle eb */
>>> +	ret = check_cross_tree_key_order(src, dst);
>>> +	if (ret < 0)
>>> +		return ret;
>>>  	ret = tree_mod_log_insert_move(dst, push_items, 0, dst_nritems);
>>>  	BUG_ON(ret < 0);
>>>  	memmove_extent_buffer(dst, btrfs_node_key_ptr_offset(push_items),
>>> @@ -3810,6 +3864,12 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
>>>  	if (left_nritems == 0)
>>>  		goto out_unlock;
>>>
>>> +	ret = check_cross_tree_key_order(left, right);
>>> +	if (ret < 0) {
>>> +		btrfs_tree_unlock(right);
>>> +		free_extent_buffer(right);
>>> +		return ret;
>>> +	}
>>>  	if (path->slots[0] == left_nritems && !empty) {
>>>  		/* Key greater than all keys in the leaf, right neighbor has
>>>  		 * enough room for it and we're not emptying our leaf to delete
>>> @@ -4048,6 +4108,9 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
>>>  		goto out;
>>>  	}
>>>
>>> +	ret = check_cross_tree_key_order(left, right);
>>> +	if (ret < 0)
>>> +		goto out;
>>>  	return __push_leaf_left(path, min_data_size,
>>>  			       empty, left, free_space, right_nritems,
>>>  			       max_slot);
>>>
> 
