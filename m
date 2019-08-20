Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F8958E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfHTHvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 03:51:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:43556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfHTHvK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 03:51:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA94CAF05;
        Tue, 20 Aug 2019 07:51:08 +0000 (UTC)
Subject: Re: [PATCH 6/8] btrfs: rework wake_all_tickets
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190816141952.19369-1-josef@toxicpanda.com>
 <20190816141952.19369-7-josef@toxicpanda.com>
 <92c9dda1-bc57-48b5-e3d1-2a0af4e56adb@suse.com>
 <20190819150601.rj4k2li2f2bl35eo@MacBook-Pro-91.local>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <95aa4f11-760b-f056-fe20-8bf8a3097cfd@suse.com>
Date:   Tue, 20 Aug 2019 10:51:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819150601.rj4k2li2f2bl35eo@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.08.19 г. 18:06 ч., Josef Bacik wrote:
> On Mon, Aug 19, 2019 at 05:49:45PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 16.08.19 г. 17:19 ч., Josef Bacik wrote:
>>> Now that we no longer partially fill tickets we need to rework
>>> wake_all_tickets to call btrfs_try_to_wakeup_tickets() in order to see
>>> if any subsequent tickets are able to be satisfied.  If our tickets_id
>>> changes we know something happened and we can keep flushing.
>>>
>>> Also if we find a ticket that is smaller than the first ticket in our
>>> queue then we want to retry the flushing loop again in case
>>> may_commit_transaction() decides we could satisfy the ticket by
>>> committing the transaction.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>  fs/btrfs/space-info.c | 34 +++++++++++++++++++++++++++-------
>>>  1 file changed, 27 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>> index 8a1c7ada67cb..bd485be783b8 100644
>>> --- a/fs/btrfs/space-info.c
>>> +++ b/fs/btrfs/space-info.c
>>> @@ -676,19 +676,39 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
>>>  		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
>>>  }
>>>  
>>> -static bool wake_all_tickets(struct list_head *head)
>>> +static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
>>> +			     struct btrfs_space_info *space_info)
>>>  {
>>>  	struct reserve_ticket *ticket;
>>> +	u64 tickets_id = space_info->tickets_id;
>>> +	u64 first_ticket_bytes = 0;
>>> +
>>> +	while (!list_empty(&space_info->tickets) &&
>>> +	       tickets_id == space_info->tickets_id) {
>>> +		ticket = list_first_entry(&space_info->tickets,
>>> +					  struct reserve_ticket, list);
>>> +
>>> +		/*
>>> +		 * may_commit_transaction will avoid committing the transaction
>>> +		 * if it doesn't feel like the space reclaimed by the commit
>>> +		 * would result in the ticket succeeding.  However if we have a
>>> +		 * smaller ticket in the queue it may be small enough to be
>>> +		 * satisified by committing the transaction, so if any
>>> +		 * subsequent ticket is smaller than the first ticket go ahead
>>> +		 * and send us back for another loop through the enospc flushing
>>> +		 * code.
>>> +		 */
>>> +		if (first_ticket_bytes == 0)
>>> +			first_ticket_bytes = ticket->bytes;
>>> +		else if (first_ticket_bytes > ticket->bytes)
>>> +			return true;
>>>  
>>> -	while (!list_empty(head)) {
>>> -		ticket = list_first_entry(head, struct reserve_ticket, list);
>>>  		list_del_init(&ticket->list);
>>>  		ticket->error = -ENOSPC;
>>>  		wake_up(&ticket->wait);
>>> -		if (ticket->bytes != ticket->orig_bytes)
>>> -			return true;
>>> +		btrfs_try_to_wakeup_tickets(fs_info, space_info);
>>
>> So the change in this logic is directly related to the implementation of
>> btrfs_try_to_wakeup_tickets. Because when we fail and remove a ticket in
>> this function we give a chance that the next ticket *could* be
>> satisfied. But how well does that work in practice, given you fail
>> normal prio tickets here, whereas btrfs_try_to_wakeup_tickets first
>> checks the prio ticket. So even if you are failing normal ticket but
>> there is one unsatifiable prio ticket that won't really change anything.
> 
> In practice we don't get to this state with high priority tickets on the list.
> Anything that would be long-ish term on the priority list is evict, and we wait
> for iput()'s in the normal flushing code.  At the point we hit wake_all_tickets
> we generally should only have tickets on the normal list.

Be that as it may, I think this assumption needs to be codified via an
assert or WARN_ON.

> 
> I suppose we could possibly get into this situation, but again the high priority
> tickets are going to be evict, truncate block, and relocate, which all have
> significantly lower reservation amounts than things like create or unlink.  If
> those things are unable to get reservations then we are truly out of space.
> Thanks,
> 
> Josef
> 
