Return-Path: <linux-btrfs+bounces-21464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLMLJnlVh2kRWwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21464-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 16:08:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34451106507
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49085301AB8A
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA8352F83;
	Sat,  7 Feb 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vasve6JV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC873502A7
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476874; cv=none; b=JQkvfcZVwhA0S2sYZMUf/bGE5Ewt8mCKJ2RLm1lCRjFTQDP8vSzc7oaLsH41h/Dthmz9pKe46Pq73KRVNivLD/lSnabilZjZNylUoHhR3W75sE340yBTSDHbKMqDdkZ/9A//mVIPbVWWT+guilkstZ66htztCyt7ehlADesn23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476874; c=relaxed/simple;
	bh=drUrK4Xm95afNohTyVkfeJrbwtCrEQIFrvDnlaqoTmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBURxfTDNZdg52j4+aBMtq1Y1GoyPNw4SaUY7OuMoYtKaUGsH2b88vDn/sYSeKbP2HhI+Bxs8phsk+8CSMPkF2K90Au6rhCZVnLIICNUp8ybhzpKeLbDp4Wd2WmwMEClQNq24zY2VNXNhqBY42HKOS0kw9DyGm7s5E00VacA898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vasve6JV; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806b8fca44so2602775e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476873; x=1771081673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Hg+Mh32shPmDJsI4dzONIsqp1xniRZMwFygqatbU8=;
        b=Vasve6JV5nsZCzulZpjCaG0pokU0wrslbw+KYK+3zU5+YjlgUjaulrWI+RyaM9TStz
         nHwW0SBpR5OOFjUixAqFub73pO4fSdxVw9IGQFp44fXvRyimuDOZQ038d2J6g8076/LH
         Bb9JrnlGSNgPLo5NhOrj41xQ9WvLsTzQgoBsOlk/RMzD6kzuCpge7CJ1ezPSKyiHHvqD
         ramutmSo4LqWxoCW7QAGcJx0Sx/MiEkDYUz8Q3j3Km49i8PU0ewycu9FxhfMhsFjr4fp
         m5ovcAKKUFb+3o6X14IwTd0qIPaX2SFJ4gDwXhszKGR/z/ly1y+Il55cfGnnkPlIpsg1
         kyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476873; x=1771081673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+Hg+Mh32shPmDJsI4dzONIsqp1xniRZMwFygqatbU8=;
        b=bP0Rg4MUZbxMjftdD1weYz3YgXQ5jpB1aGOpJmlfMFGiywc44Dr71DXjnTVmH4irhc
         SlScpqHETBQFsGt4Bn7tSzDGs9M9H9ZtxAi/BzUN5O+SliXPKc2gNn/T29NTbaatcneH
         B1jtTjedt/sze2pBgKTWPCIXC6NAQU9mX8OrGyuTNtUoVCIe/glsq4mR6CxKmLXXFD6Y
         130AwudUMAvvprLzWV+7cJn1r3Z0AqDZaPKms1dfRMblTlxt+x1tji4ScVxMjjaC+eWM
         mr5kSu2pX1yDemzEvcxRtogOxBgOkdhg0n1gJYqNNdLWHcwt7oKtqMVfzUMCaIlye68f
         0R8Q==
X-Gm-Message-State: AOJu0Yx4DKHRX6msVUNHtgBg0Ny8W8N6FiuI44f4oefxR3Xq9dNAVpvO
	zFcZ5wpLIVUPnlOnBL9E7x2BIzjTNlW2teaRnkrJthE06FWBqaWvYQZE
X-Gm-Gg: AZuq6aIY8ptR5UJQXGQPPH8LsITXuYF6eNMM4Zj2/n9VoU13ROc5Y2lqWTx+UkILVEc
	C//2y3m7sUuY/bLGnUQZ+KpBqCICyFM5RgzuKpmiLH+ULjvC3dzktQO4JI1naaF8yRwlJblN58X
	wypBVMsnkMcLwIHWygQo4O+QkkA4S9qbLJsYDUG2PBadVUaZyQPCi/5WhRqTQFzYTHeseMkNbRd
	fbolRlfB4c5mGAreha0Q5hSn+JVO9kUuJaEc+bTy7bH6QEvldNLHlyKQOyMz2Q2QicMy+IySHiB
	APodvfm9MogR+51c3x1KDNtm4f0t+LbZCIS/4HVunYKgtx97mHao1XpA5Loq2uh5BgjG9TUcwPc
	LuS7sdUiAE1CPZ3qjkX293NEtSzDYfgnAASmxqbqHLSdTcDMNde6DuGvjECKwkA6z9mlxTRSNb9
	zZVAZAhR3UuA1SMHlQWvG6qBmNmWT9F9GAiHoJ1lhG52nREgKDikHtYG5scpjzW2hABkGLrK5M1
	AdoWw==
X-Received: by 2002:a05:600c:6818:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-4832033b5femr51634285e9.6.1770476872744;
        Sat, 07 Feb 2026 07:07:52 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:180c:86b4:d220:939b? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b2facsm13874427f8f.9.2026.02.07.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 07:07:52 -0800 (PST)
Message-ID: <82db13d3-1ef7-4745-9598-78746d2626ef@gmail.com>
Date: Sat, 7 Feb 2026 23:07:47 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
 <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
 <e058b458-0c8a-47ae-9e45-88f2eaa8b821@gmail.com>
 <d092aa23-655f-408b-94c6-edede3c8dbf2@gmail.com>
 <75b0f891-0338-48d7-ba99-ebadd7e2bc07@gmx.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <75b0f891-0338-48d7-ba99-ebadd7e2bc07@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21464-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34451106507
X-Rspamd-Action: no action



On 2026/2/7 18:18, Qu Wenruo wrote:
> 
> 
> 在 2026/2/7 19:20, Sun YangKai 写道:
>>
>>
>> On 2025/12/9 20:27, Sun Yangkai wrote:
>>>
>>>
>>> 在 2025/12/9 20:05, Filipe Manana 写道:
>>>> On Tue, Dec 9, 2025 at 3:38 AM Sun YangKai <sunk67188@gmail.com> wrote:
>>>>>
>>>>> There's a common parttern in callers of btrfs_prev_leaf:
>>>>> p->slots[0]-- if p->slots[0] points to a slot with invalid 
>>>>> item(nritem).
>>>>>
>>>>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>>>>> valid slot and cleanup its over complex logic.
>>>>>
>>>>> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
>>>>> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
>>>>> should insert the key.
>>>>
>>>> Hell no! path->slots[0] can end up pointing to the original key, 
>>>> which is what
>>>> should be the location for the computed previous key, and the
>>>> comments there explain how that can happen.
>>>>
>>>>> So just slots[0]-- is enough to get the previous
>>>>> item.
>>>>
>>>> All that logic in btrfs_prev_leaf() is necessary.
>>>>
>>>> We release the path and then do a btrfs_search_slot() for the computed
>>>> previous key, but after the release and before the search, the
>>>> structure of the tree may have changed, keys moved between leaves, new
>>>> keys added, previous keys removed, and so on.
>>>
>>> Thanks for your reply. Here's my thoughts about this:
>>>
>>> My assumption is that there's not a key between the computed previous 
>>> key and
>>> the original key. So...
>>>
>>> 1) When searching for the computed previous key, we may get ret==1 and
>>> p->slots[0] points to the original key. In this case,
>>>
>>> if (p->slots[0] == 0) // we're the lowest key in the tree.
>>>     return 1;
>>>
>>> p->slots[0]--; // move to the previous item.
>>> return 0;
>>>
>>> is exactly what we want if I understand it correctly. I don't 
>>> understand why
>>> it's a special case.
>>>
>>> 2) And if there's an item matches the computed previous key, we will 
>>> get ret==0
>>> from btrfs_search_slot() and we will early return after calling
>>> btrfs_search_slot(). If there's no such an item, then we'll never get 
>>> an item
>>> whose key is lower than the key we give to btrfs_search_slot().
>>> So the second comment block is also not a special case.
>>>
>>> These two cases are not related with how the items moved, added or 
>>> deleted
>>> before we call btrfs_search_slot().
>>>
>>> Please correct me if I got anything wrong.
>>>
>>> Thanks.
>>
>> After reviewing this patch several times, I cannot find anything wrong 
>> with it. I'd glad to learn a special case which will break the new code.
> 
> Check the following corner case.
> 
> Originally the leaf has the following first key
> 
>      Slot 0 key X (X is a u136 value, combined objectid/type/offset)
> 
> Now we're search using key X - 1, and released the path.
> COW happened, deleted everything in the tree.
> 
> Now btrfs_search_slot() returned 1, pointing the empty leaf with:
> 
>      Slot 0 key 0

Thanks a lot for providing this case which I've never thought about. It 
seems the old version will try reading key at slot 0 while there's no 
item. We'll get key 0 and it's safe because of we always set all the 
unused space to zero in a leaf? Or we may get the old uncleared key 
originally at slot 0?

> The old code will return 0 (went through the btrfs_item_key() and 
> btrfs_comp_keys() check), but the new code will return 1 (slots[0] == 0 
> check only).

Although I'm not sure if this case could happen in reality, but I think 
return 1 is the expected behavior.

> Although I'm not sure if this makes much sense to the caller though.
> 
> 
> And I have to admit, despite the above empty tree corner case, the new 
> code seems correct.

And much simpler :D

> Firstly if we hit an exact match for (X - 1), then we immediately return 
> 0, no need to bother exact match anymore.
> 
> The remaining cases are for non-exact match.
> 
> If there is a key smaller than X - 1, we will be at the next slot of 
> that key, thus slots[0] should not be 0.
> 
> The only case we hit slots[0] == 0 for non-exact match, is when that key 
> at slot 0 is already the smallest in the whole tree.

Thanks a lot for making this clear!

And I forgot that I've sent a patch v2:

https://lore.kernel.org/linux-btrfs/20251211072442.15920-2-sunk67188@gmail.com/

Maybe we can move future discussions there.

Thanks,
Sun YangKai

> Thanks,
> Qu
> 
>>
>> My assumption is that let's say we have leaf A with key range [100, 
>> 180] and leaf B with key range [200, ...] at search time (and we don't 
>> care how those keys distribute before we release path), when searching 
>> for key 199, we'll always get to leaf A and pointing to the position 
>> next to the last item of leaf A. Please correct me if my assumption is 
>> wrong :)
>>
>> Let's see the origin code:
>>
>>      if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
>>          btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
>>          ret = btrfs_comp_keys(&found_key, &orig_key);
>>          if (ret == 0) {
>>              if (path->slots[0] > 0) {
>>                  path->slots[0]--;
>>                  return 0; // case 1
>>              }
>>              return 1; // case 2
>>          }
>>      }
>>
>>      btrfs_item_key(path->nodes[0], &found_key, 0);
>>      ret = btrfs_comp_keys(&found_key, &key);
>>      if (ret <= 0)
>>          return 0; // case 3
>>      return 1; // case 4
>>
>> And the new code:
>>
>>      if (path->slots[0] == 0)
>>          return 1; // case A
>>
>>      path->slots[0]--;
>>      return 0; // case B
>>
>> For all the origin return branches:
>>
>> - Case 1: it will go to case B now, the same behavior;
>> - Case 2: it will go to case A now, the same behavior;
>> - Case 3: if ret == 0, then the found key matches the key,
>>        btrfs_search_slot will return 0 and we'll not get to case 3.
>>        So ret must less than 0, and the key of the item at slot 0 is
>>        less than the search key so path->slots[0] is greater than
>>        0 and we'll go to case B now. The behavior is different,
>>        but we make sure pointing to the previous item in new code.
>> - Case 4: the key of item at slot 0 is larger than the key we give to
>>        btrfs_search_slot(). In this case path->slot[0] must be 0 and
>>        we'll go to case A now.
>>
>> The original code's complexity (comparing keys) was an attempt to 
>> verify if we landed exactly where we started, but this is unnecessary 
>> and I don't think the previous search result and the release path 
>> things matter because we're starting a brand new tree search and 
>> btrfs_search_slot is the source of truth for the current tree structure.
>> As long as we treat all the things as a brand new search, looking for 
>> the item with key=(origin_key - 1) or the previous item if it doesn't 
>> exist, it will be very simple and clear :)
>>
>> Thanks.
>>
>>>>
>>>> I left all such cases commented in detail in btrfs_prev_leaf() for a 
>>>> reason...
>>>>
>>>> Removing that logic is just wrong and there's no explanation here 
>>>> for it.
>>>>
>>>> Thanks.
>>>>
>>>>
>>>>
>>
> 


