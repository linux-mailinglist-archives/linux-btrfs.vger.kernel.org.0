Return-Path: <linux-btrfs+bounces-8835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86263999AA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F321F244D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E361F4725;
	Fri, 11 Oct 2024 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="SCE39OcV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAD717BA9
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614471; cv=none; b=KSz7Z1g3fl8Sf9loJVKDlc6SFIVZoKTy9UgvjKCdbxqOS/vuVqN+2CA1pXzpgPC/L9oMeIYREuZHZUXFVIphYr5QTpqJZ42U6PWsTdtaD5D+w77klgk4OrfcNv3ntVH+rZhy63wVLWAtOev8gOQkAX6kLhFSpKmAjmucpuYei/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614471; c=relaxed/simple;
	bh=t3ghN3RTMr5uFgwJko1H0CjYchF6DkBpT/fMS1jxVoE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ojHowmwRZAezwvOcWhkEuLr11fQRMs7a/sJ2Ane6e+HM++8FfsEMbdqUcZsfvg18RZcGMCKjAL4lAC5gcrg3oRuZcgPI0C9lcTI3b2SV7MjmrjRbtXCm3dobtrziceiOlM0gvmmYcFMt+AhINW3O3qiC+IeejRqgfNqiIvkG/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=SCE39OcV; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Subject: Re: [PATCH] btrfs: reduce lock contention when eb cache miss for
 btree search
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1728614461; bh=t3ghN3RTMr5uFgwJko1H0CjYchF6DkBpT/fMS1jxVoE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To;
	b=SCE39OcVAAj5WQewU7STjliokOXbcwIuHw/grWskzCCQJNt5wRCUZ6ibBFOAdrjPX
	 jNiME2SceA2SKNrxy1Z95TdNKj4WVyvJXP0e/2xkg9+PsS/FW4YVLCYSzqex2+eJpI
	 0Gw+hi9sPn2loi5Iqa4P6pk4lD5OG6Q97lJqkERg=
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20241009020149.23467-1-robbieko@synology.com>
 <CAL3q7H4sjkQ2-s=jdP-bsF3Jpc7iqGTkOfKe1asfo17+a4Mvgg@mail.gmail.com>
 <CAL3q7H4sdxdnLx9uaSDrhVpJCdsik+ZPVCH4cjeZKCBKY_ohzw@mail.gmail.com>
From: robbieko <robbieko@synology.com>
Message-ID: <66227591-281e-8c66-ed55-fdd6a8c4cf9f@synology.com>
Date: Fri, 11 Oct 2024 10:40:25 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4sdxdnLx9uaSDrhVpJCdsik+ZPVCH4cjeZKCBKY_ohzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no


Filipe Manana 於 2024/10/9 下午11:09 寫道:
> On Wed, Oct 9, 2024 at 3:18 PM Filipe Manana <fdmanana@kernel.org> wrote:
>> On Wed, Oct 9, 2024 at 3:09 AM robbieko <robbieko@synology.com> wrote:
>>> From: Robbie Ko <robbieko@synology.com>
>>>
>>> When crawling btree, if an eb cache miss occurs, we change to use
>>> the eb read lock and release all previous locks to reduce lock contention.
>>>
>>> Because we have prepared the check parameters and the read lock
>>> of eb we hold, we can ensure that no race will occur during the check
>>> and cause unexpected errors.
>>>
>>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>>> ---
>>>   fs/btrfs/ctree.c | 88 ++++++++++++++++++++++++++++--------------------
>>>   1 file changed, 52 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>>> index 0cc919d15b14..0efbe61497f3 100644
>>> --- a/fs/btrfs/ctree.c
>>> +++ b/fs/btrfs/ctree.c
>>> @@ -1515,12 +1515,12 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>>>          struct btrfs_tree_parent_check check = { 0 };
>>>          u64 blocknr;
>>>          u64 gen;
>>> -       struct extent_buffer *tmp;
>>> -       int ret;
>>> +       struct extent_buffer *tmp = NULL;
>>> +       int ret, err;
>> Please avoid declaring two (or more) variables in the same line. 1 per
>> line is prefered for readability and be consistent with this
>> function's code.

Okay, I'll modify it.

>>
>>>          int parent_level;
>>> -       bool unlock_up;
>>> +       bool create = false;
>>> +       bool lock = false;
>>>
>>> -       unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
>>>          blocknr = btrfs_node_blockptr(*eb_ret, slot);
>>>          gen = btrfs_node_ptr_generation(*eb_ret, slot);
>>>          parent_level = btrfs_header_level(*eb_ret);
>>> @@ -1551,52 +1551,66 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>>>                           */
>>>                          if (btrfs_verify_level_key(tmp,
>>>                                          parent_level - 1, &check.first_key, gen)) {
>>> -                               free_extent_buffer(tmp);
>>> -                               return -EUCLEAN;
>>> +                               ret = -EUCLEAN;
>>> +                               goto out;
>>>                          }
>>>                          *eb_ret = tmp;
>>> -                       return 0;
>>> +                       tmp = NULL;
>>> +                       ret = 0;
>>> +                       goto out;
>> By setting tmp to NULL and jumping to the out label, we leak a
>> reference on the tmp extent buffer.
We assign tmp to eb_ret, so we don't leak.
>>
>>>                  }
>>>
>>>                  if (p->nowait) {
>>> -                       free_extent_buffer(tmp);
>>> -                       return -EAGAIN;
>>> +                       ret = -EAGAIN;
>>> +                       btrfs_release_path(p);
>> To reduce the critical section sizes, please set ret to -EAGAIN after
>> releasing the path.
Okay, I'll modify it.
>>
>>> +                       goto out;
>>>                  }
>>>
>>> -               if (unlock_up)
>>> -                       btrfs_unlock_up_safe(p, level + 1);
>>> +               ret = -EAGAIN;
>>> +               btrfs_unlock_up_safe(p, level + 1);
>> Same here, set ret after the unlocking.
>>
>> But why set ret to -EAGAIN? Here we know p->nowait is false.
> Nevermind this is because of the unconditional unlock now.
Yes, because we unlock unconditionally, the ret value of this function 
must be -EAGAIN.
>
>>> +               btrfs_tree_read_lock(tmp);
>>> +               lock = true;
>> And here, with the same reasoning, set 'lock' to true before calling
>> btrfs_tree_read_lock().
>>
>>> +               btrfs_release_path(p);
>>>
>>>                  /* now we're allowed to do a blocking uptodate check */
>>> -               ret = btrfs_read_extent_buffer(tmp, &check);
>>> -               if (ret) {
>>> -                       free_extent_buffer(tmp);
>>> -                       btrfs_release_path(p);
>>> -                       return ret;
>>> +               err = btrfs_read_extent_buffer(tmp, &check);
>>> +               if (err) {
>>> +                       ret = err;
>>> +                       goto out;
>> Why do we need to have this 'err' variable?
>> Why not use 'ret' and simplify?
>>
>>>                  }
>>> -
>>> -               if (unlock_up)
>>> -                       ret = -EAGAIN;
>>> -
>>>                  goto out;
>>>          } else if (p->nowait) {
>>> -               return -EAGAIN;
>>> -       }
>>> -
>>> -       if (unlock_up) {
>>> -               btrfs_unlock_up_safe(p, level + 1);
>>>                  ret = -EAGAIN;
>>> -       } else {
>>> -               ret = 0;
>>> +               btrfs_release_path(p);
>> Same here, set 'ret' to -EAGAIN after releasing the path.
>>
>>> +               goto out;
>>>          }
>>>
>>> +       ret = -EAGAIN;
>>> +       btrfs_unlock_up_safe(p, level + 1);
>> Same here.
>>
>> But why set ret to -EAGAIN? Here we know p->nowait is false.
> Nevermind this is because of the unconditional unlock now.
>
> In both cases we still don't need the 'err' variable.
> Just set 'ret' to -EAGAIN if btrfs_find_create_tree_block() below
> doesn't return an error and btrfs_read_extent_buffer() below and above
> don't return an error.

Indeed, we can only use ret value to receive the result of 
btrfs_find_create_tree_block or btrfs_read_extent_buffer.
If the function returns correctly (return 0), we must change ret to 
-EAGAIN again and again,
which is undoubtedly an increase in the function complexity.
Therefore, I use the err variable. If other err occurs, the err can be 
set to ret,
so that the caller can immediately stop and continue searching.

>
>>> +
>>>          if (p->reada != READA_NONE)
>>>                  reada_for_search(fs_info, p, level, slot, key->objectid);
>>>
>>> -       tmp = read_tree_block(fs_info, blocknr, &check);
>>> +       tmp = btrfs_find_create_tree_block(fs_info, blocknr, check.owner_root, check.level);
>>>          if (IS_ERR(tmp)) {
>>> +               ret = PTR_ERR(tmp);
>>> +               tmp = NULL;
>>>                  btrfs_release_path(p);
>>> -               return PTR_ERR(tmp);
>>> +               goto out;
>>>          }
>>> +       create = true;
>>> +
>>> +       btrfs_tree_read_lock(tmp);
>>> +       lock = true;
>> Same here, set 'lock' to true before the call to btrfs_tree_read_lock();
>>
>>> +       btrfs_release_path(p);
>>> +
>>> +       /* now we're allowed to do a blocking uptodate check */
>> Please capitalize the first word of a sentence and end the sentence
>> with punctuation.
>> This is the preferred style and we strive to do that for new comments
>> or code that moves comments around.
Okay, I'll modify it.
>>
>>> +       err = btrfs_read_extent_buffer(tmp, &check);
>> This can block, so if p->nowait at this point we should instead exit
>> with -EAGAIN and not call this function.
>>
>>> +       if (err) {
>>> +               ret = err;
>>> +               goto out;
>>> +       }
>> Same here, no need to use extra variable 'err', can just use 'ret'.
>>
>>> +
>>>          /*
>>>           * If the read above didn't mark this buffer up to date,
>>>           * it will never end up being up to date.  Set ret to EIO now
>>> @@ -1607,11 +1621,13 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>>>                  ret = -EIO;
>>>
>>>   out:
>>> -       if (ret == 0) {
>>> -               *eb_ret = tmp;
>>> -       } else {
>>> -               free_extent_buffer(tmp);
>>> -               btrfs_release_path(p);
>>> +       if (tmp) {
>>> +               if (lock)
>>> +                       btrfs_tree_read_unlock(tmp);
>>> +               if (create && ret && ret != -EAGAIN)
>>> +                       free_extent_buffer_stale(tmp);
>>> +               else
>>> +                       free_extent_buffer(tmp);
>> So in the success case we no longer set *eb_ret to tmp. Why? The
>> callers expect that.
> Ok, it's because of the -EAGAIN due to having the unconditional unlock now.
>
> And btw, have you observed any case where this improved anything? Any
> benchmarks?

In the case of very high-speed 4k random write (cow), using nvme will 
improve.

But I can't give it a clear data improvement, because there are still many

different bottlenecks in the context of 4k random write,

and other patches need to be used to achieve significant improvements.

>
> I can't see how this can make anything better because this function is
> never called for a root node, and therefore level + 1 <
> BTRFS_MAX_LEVEL.

The main improvement point of this patch is that if a eb cache miss 
occurs in a leaf and needs to execute IO,
our original approach is to release level 2~MAX, but this patch is 
changed to release level 1~MAX.
We even Level 1 has also been released, so before releasing level 1, we 
changed to take the lock of level 0 to avoid race.
This change reduces the lock contention of level 1.

>
> But there is one case where this patch causes unnecessary path
> releases and makes the caller retry a search:
> when none of the levels above were locked. That's why we had the
> following expression before:
>
> unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
>
> So we wouldn't make the caller retry the search if upper levels aren't
> locked or p->skip_locking == 1.
> But now after this patch we make the caller retry the search in that case.

Indeed, I missed something about skip_locking. In this case, there is no 
need to search again, I will correct it.

Thank you for your review.

>
> Thanks.
>
>> Thanks.
>>
>>>          }
>>>
>>>          return ret;
>>> @@ -2198,7 +2214,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>>>                  }
>>>
>>>                  err = read_block_for_search(root, p, &b, level, slot, key);
>>> -               if (err == -EAGAIN)
>>> +               if (err == -EAGAIN && !p->nowait)
>>>                          goto again;
>>>                  if (err) {
>>>                          ret = err;
>>> @@ -2325,7 +2341,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
>>>                  }
>>>
>>>                  err = read_block_for_search(root, p, &b, level, slot, key);
>>> -               if (err == -EAGAIN)
>>> +               if (err == -EAGAIN && !p->nowait)
>>>                          goto again;
>>>                  if (err) {
>>>                          ret = err;
>>> --
>>> 2.17.1
>>>
>>>

