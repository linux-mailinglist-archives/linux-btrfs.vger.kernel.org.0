Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB572F2B15
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 10:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbhALJSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 04:18:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:40550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392544AbhALJSd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 04:18:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610443066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=XflxbYa9LUQjLUev+xvZhTvWAFz42QmEpPdg8UIk/j0=;
        b=I+Aj3juG3UMMjorj4PVReAPEsOk3haoGI4qhfh0WGkEbPY8bQsyRDaOlIP2H5NwD63XWyU
        +uw+lryST4nocwcBHQ3NsRKRwMtu274opccL7e7iYDXeQT7ufe+m2hxOoP5KgiYAcexeI+
        ziZBulIVX4X0JpIfQDSYakOJrXZeE2Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBEBFB7DE;
        Tue, 12 Jan 2021 09:17:46 +0000 (UTC)
Subject: Re: [PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs
 in commit
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608319304.git.josef@toxicpanda.com>
 <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608319304.git.josef@toxicpanda.com>
 <20210108160109.GB6430@twin.jikos.cz>
 <52aef9a6-efc7-0820-7056-067e69c2a856@suse.com>
 <20210111215051.GH6430@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e1fd5cc1-0f28-f670-69f4-e9958b4964e6@suse.com>
Date:   Tue, 12 Jan 2021 11:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111215051.GH6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.01.21 г. 23:50 ч., David Sterba wrote:
> On Mon, Jan 11, 2021 at 10:33:42AM +0200, Nikolay Borisov wrote:
>> On 8.01.21 г. 18:01 ч., David Sterba wrote:
>>> On Fri, Dec 18, 2020 at 02:24:20PM -0500, Josef Bacik wrote:
>>>> @@ -2043,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>>>>  	btrfs_trans_release_metadata(trans);
>>>>  	trans->block_rsv = NULL;
>>>>  
>>>> -	/* make a pass through all the delayed refs we have so far
>>>> -	 * any runnings procs may add more while we are here
>>>> -	 */
>>>> -	ret = btrfs_run_delayed_refs(trans, 0);
>>>> -	if (ret) {
>>>> -		btrfs_end_transaction(trans);
>>>> -		return ret;
>>>> -	}
>>>> -
>>>> -	cur_trans = trans->transaction;
>>>> -
>>>>  	/*
>>>> -	 * set the flushing flag so procs in this transaction have to
>>>> -	 * start sending their work down.
>>>> +	 * We only want one transaction commit doing the flushing so we do not
>>>> +	 * waste a bunch of time on lock contention on the extent root node.
>>>>  	 */
>>>> -	cur_trans->delayed_refs.flushing = 1;
>>>> -	smp_wmb();
>>>
>>> This barrier obviously separates the flushing = 1 and the rest of the
>>> code, now implemented as test_and_set_bit, which implies full barrier.
>>>
>>> However, hunk in btrfs_should_end_transaction removes the barrier and
>>> I'm not sure whether this is correct:
>>>
>>> -	smp_mb();
>>>  	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
>>> -	    cur_trans->delayed_refs.flushing)
>>> +	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
>>> +		     &cur_trans->delayed_refs.flags))
>>>  		return true;
>>>
>>> This is never called under locks so we don't have complete
>>> synchronization of neither the transaction state nor the flushing bit.
>>> btrfs_should_end_transaction is merely a hint and not called in critical
>>> places so we could probably afford to keep it without a barrier, or keep
>>> it with comment(s).
>>
>> I think the point is moot in this case, because the test_bit either sees
>> the flag or it doesn't. It's not possible for the flag to be set AND
>> should_end_transaction return false that would be gross violation of
>> program correctness.
> 
> So that's for the flushing part, but what about cur_trans->state?

Looking at the code, the barrier was there to order the publishing of
the delayed_ref.flushing (now replaced by the bit flag) against
surrounding code.

So independently of this patch, let's reason about trans state. In
should_end_transaction it's read without holding any locks. (U)

It's modified in btrfs_cleanup_transaction without holding the
fs_info->trans_lock (U), but the STATE_ERROR flag is going to be set.

set in cleanup_transaction under fs_info->trans_lock (L)
set in btrfs_commit_trans to COMMIT_START under fs_info->trans_lock.(L)
set in btrfs_commit_trans to COMMIT_DOING under fs_info->trans_lock.(L)
set in btrfs_commit_trans to COMMIT_UNBLOCK under fs_info->trans_lock.(L)

set in btrfs_commit_trans to COMMIT_COMPLETED without locks but at this
point the transaction is finished and fs_info->running_trans is NULL (U
but irrelevant).

So by the looks of it we can have a concurrent READ race with a Write,
due to reads not taking a lock. In this case what we want to ensure is
we either see new or old state. I consulted with Will Deacon and he said
that in such a case we'd want to annotate the accesses to ->state with
(READ|WRITE)_ONCE so as to avoid a theoretical tear, in this case I
don't think this could happen but I imagine at some point kcsan would
flag such an access as racy (which it is).

> 
