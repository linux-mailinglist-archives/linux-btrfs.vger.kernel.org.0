Return-Path: <linux-btrfs+bounces-21232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIyKIT86fGntLQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21232-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 05:57:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AEB72C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 05:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4010B3016481
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 04:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F53148A6;
	Fri, 30 Jan 2026 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0YWDKvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D472F12D6
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749047; cv=none; b=AX8cYQ2jwSKMFnkslFyxAGBsMNVI8E/EBXKVRrMofIv+NXDcLnZBF6wF09+uzJ6EVcPp5/LvBMCjMOPEOWYsw9gLhhPCYzC04w6puXIy96w4cb2EPtR7foB9QYKgz+dFMDt1unnNZ8HlJ366fGoEK/y2MpGVybe5G5HOmMVFQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749047; c=relaxed/simple;
	bh=IevJUNfITA9WFaxE4J1zyMR57z/AVcKSCq+dfuoyNcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi8K/TegKufeDfgo5jd7/eIa82wSq3eRDqWY5LUxkfpFwRRp5EXMYRZwdacVYYz8sOKyWnBV1ph8VzL26gGiSlUGvNBvZe8l4jq272v95vx2wEQ99lANm6lFUUKpUFUM1B2NaUMSA5p5ZDqGPGVWRCfKjl75Yx4hLl2QE/zSJc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0YWDKvp; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f2d829667so152175ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 20:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769749045; x=1770353845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8IrzUq6Oo4WJWsamx5P/AHT8xE4XcbFbULmYjc72E4=;
        b=g0YWDKvpheN706ogxsSuwYSzndgfxAKrLfjgvHDZ2nhBoQxQAoY5W2oUGUBQ7P/6ox
         w2YgliRqfIugYG6J8pfbTwE8G6FIjbF+Rm5HoPVmKMhRr2PurpwDip9HkkjytZqCEpUN
         eVea7RIE6xVezyMHYSulfk3d+EoVVYeorZ+SbjjpKDroN30h4NyyS0Di3GFRqtHumEkJ
         7p3cIHhIRoDsW985/e3znFlx43UJPVntKlsiU9xVXy1tbYpQ/BaQPh6/jesYLwtxhyws
         Q6n1o8PmRm6t4B+zFm1cHEQTj+lFvmOH3gueTGgh9LfHow/76ZYkDs+KLdf+4vDPnA6X
         qp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769749045; x=1770353845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8IrzUq6Oo4WJWsamx5P/AHT8xE4XcbFbULmYjc72E4=;
        b=Q5jQ6pdqR1Lf8qwmb4JDOyaghle6eoUe9oZmRd1s5paIfBzbuPbgbiyCmm3XdfbhYB
         tOVaxQs/Y5ZRU5JyeI+dfQ2pKj968v2sWzFRVJjv2X1oB/j8If6v//DgGBCbEZK+j10S
         bZ/bcNmmD/zJ7RVynr541/9co/PNPy0JXlkHnO8wJyCK11NZGNdG7Ab7g3BAAabxand/
         PuiEe0PEW1+fZSl48uuI8gijwO3XFUPW6pFPB1oasLk/Hc6+Urko5B6BwMDRbgmQvWhc
         FVuuDpF7CMzs4+XNTQFJGbeIntYfayjwBIQHw8noiWxMpuYVNqUewaCeVCniSlu8YcN0
         KXaQ==
X-Gm-Message-State: AOJu0YxkrsRKL30l076qc/Gw2lZy11Yv95s9y0lJo+yDO1xUP+XqGB5t
	6Wx5sGU08zJlo+RYOY4cKBST3+Zea6KmqhwZU/65PV22HSFJtJpwp7IMg9tLhErF
X-Gm-Gg: AZuq6aJINwJgvss9Al9Wi9Io3+9XeyjE0//gKZjAKLq1rb/j3n8/O7BfT5hEX6bgY7z
	1T8OVDWIGw56TnHzHTmFSKpwFtk78uzZh7+U3eTKZAyjFayGQtPZGrjXzWQIaN1M+CV0V5r/KuZ
	ad24ZHOl7/SYLCsyKmO48hlAc4N91Wb8TK+DdTeuezXIzsOMFU5OcmPBwzFBZU85FaL/EqV1lM2
	ou3IFGOvylYZqgT332bLV/OOPHomicUQhI7iyUhfAwJT25gEJwgUzsBIE2ZE/MsZDxTHwABFSHU
	tffJpNj8iAetOTBsbrwr8ClxRRdLpcJOW9Ifpy7oREAf5QirHZKcpn3o4AZf3bomOuvh9M5Ak6K
	UdCoBo8RlC5pepY1spg3dFBobLNGU3WJUwweB7LNSpapNrDjTkJwTuryMFQ0GotsOPEQL2/sVJI
	DLqzhS9IqR4CBa9qlTd+zpPTQnYkZbZDqR+tu5inHvR1iWU+mlJE+DDrG2rm/LS5DJqA==
X-Received: by 2002:a17:903:2351:b0:2a0:d07a:bb2f with SMTP id d9443c01a7336-2a8d96d41f9mr12269635ad.3.1769749044877;
        Thu, 29 Jan 2026 20:57:24 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:2559:47c:86ee:26cc? ([175.143.94.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd7654dasm36195115ad.81.2026.01.29.20.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 20:57:24 -0800 (PST)
Message-ID: <1c16f43f-289a-4f0b-b5a8-69e5ed27ce0e@gmail.com>
Date: Fri, 30 Jan 2026 12:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: initialize periodic_reclaim_ready to true
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260126113104.9884-1-sunk67188@gmail.com>
 <20260126173450.GB1066493@zen.localdomain>
 <4f2af29b-6720-47fb-814c-e6f8b0327c30@gmail.com>
 <20260127192059.GC3450664@zen.localdomain>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260127192059.GC3450664@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21232-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 065AEB72C0
X-Rspamd-Action: no action



On 2026/1/28 03:20, Boris Burkov wrote:
> On Tue, Jan 27, 2026 at 10:15:20PM +0800, Sun Yangkai wrote:
>>
>>
>> 在 2026/1/27 01:34, Boris Burkov 写道:
>>> On Mon, Jan 26, 2026 at 07:30:52PM +0800, Sun YangKai wrote:
>>>> The periodic_reclaim_ready flag determines whether the background reclaim
>>>> worker should process a specific space_info. Previously, this flag
>>>> defaulted to false because space_info structures are zero-initialized.
>>>>
>>>> According to the original design, periodic reclaim should be active from
>>>> the start and only disable itself (set to false) if it fails to find
>>>> reclaimable block groups.
>>>>
>>>> Now that the reclaim condition has been fixed in a previous patch to
>>>> properly handle reclaim_bytes, it is necessary to enable this by default.
>>>> This ensures background reclaim logic kicks in as soon as the thresholds
>>>> are met after mount.
>>
>> Hi Boris. Glad to receive your reply within hours :)
>>
>>> Is this problem practical on a test/real workload or theoretical? If we
>>> never free net-1G, I don't know how much reclaim is gonna help anyway.
>>
>> Yes, actually we don't know how much space is enough currently :(. It would be
>> a lot better of we could find it out when failed to reclaim a blockgroup ...
>>
>> I have a test case for periodic reclaim like this:
>> 1. mount the fs with >10G unallocated
>> 2. filling the disk to nearly full (< 10G unallocated)
>> 3. free up some space(>10G unallocated) and umount, preparing for the next
>> test
>>
>> I expect the periodic reclaim kick in when the disk is nearly full (during 2)
>> instead of after freeing up some space(during 3). This let me started to think
>> about this patch.
> 
> If the filesystem has only ever allocated and never freed, then it
> cannot possibly make progress at 2.
> 
> If you have also freed a gig in smaller extents than later allocations but
> bigger extents than the ones in one of the block groups you are
> relocating, then it could succeed even with net allocation greater than
> -1GiB.
> 
>>
>> In real world workload, we may have a fs quite empty when mounted, and fill up
>> to quite full and expect periodic reclaim will happen to get rid of running
>> out of space for unallocated. But periodic reclaim will not work without this
>> change.
>>
>> And this patch is the simple and quick fix for that "edge case".
>>
> 
> Except that it runs into any number of trivial edge cases itself. Like
> "never freeing" like I pointed out above, but also failing on the first
> try (setting back to false) then later having net free less than 1GiB
> but in a state that could make progress and not re-enabling.
> 
> Fundamentally the thing to work on is the enabling condition. Whether
> it's on at mount or not is kind of irrelevant, IMO, because it is
> essentially the same as the state after a relocation fails.

Well... I agree with that the enabling condition is important. But I 
think mount time and relocation failure are different. Relocation 
failure will only happen when the disk is kind of "full" so we know we 
can do nothing helpful until there's enough net free. But at mount time 
it's not the case.

> e.g., with your change, this is still possible and essentially not that
> different from starting at step 3 on a fresh mount.
> 
> T0: blank fs size 100G
> T1: alloc 95G contiguous
> T2: reclaim tries, fails; periodic_reclaim_ready = false
> T3: concurrently free and allocate 10G while never seeing a net of -1G,
> but making real, big holes that could result in a successful relocation
> T4: reclaim is still disabled forever
> 
>>> If the "net 1G freed" condition is not the actual condition that we
>>> want, maybe we should rethink that? We can enable it on 1G total freed,
>>> regardless of allocation to give it a chance to run even if the net free
>>> is 800M or something. I was worried about workloads that did actually
>>> allocate and fill in the gaps.
>>
>> I agree. It's not reliable and may trigger too often than what we expect.
>>
>>> Or we can just use the total available space
>>> as a proxy, like "if we do a free and the total free in the space_info
>>> is >1G, enable periodic reclaim". The reclaim loops aren't gonna be
>>> costly and we don't expect them to do anything when the fs isn't full
>>> anyway.
>>
>> Comparing current free space with a target free space instead of tracing a
>> reclaim_bytes is a good idea. At least we don't need to maintain an extra
>> counter any more. But the fixed 1G target might cause some problems since a
>> reclaim might fail with a >1G free space. With the fixed 1G target, we might
>> trying the useless work again and again. I suggest to set a target larger than
>> the free space we have when setting periodic_reclaim_ready to false so we'll
>> not trigger periodic reclaim if there's no "enough" free space freed.
> 
> The current periodic+dynamic reclaim is already essentially saying it is
> targeting something like 2-10GiB unallocated. It simply goes away past
> 10G and gets quite aggressive as you get closer to 0. So more signals
> based on a target free doesn't make that much sense to me, unless I am
> misunderstanding your idea. Please feel free to explain in more detail
> :)

Maybe there's some misunderstanding here. Currently we maintain a 
separate counter called reclaimable_bytes to trace the net free/alloc 
and compare it with a fixed value(1G) as the enabling condition.
I want to use a target free value instead of the reclaimable_bytes 
counter and compare the free space with the target free as the enabling 
condition so we don't need to maintain a separate counter on every 
alloc/free code path when periodic_reclaim_ready is false. It's a micro 
optimization, totally get rid of the signed/unsigned comparing issue, 
and has nothing to do with the dynamic reclaim things:)

> Here's how I was thinking when I came up with the current condition:
> I was concerned about a filesystem that is in a relatively steady state
> and quite full, so in the <10G unallocated. If it is totally steady
> state, then nothing can ever make progress. So we should say we aren't
> ready until *something* changes. What could that something be? Some
> ideas:
> 1. any space at all has been freed
> 2. >THRESH space has been freed (ignoring concurrent allocations)
> 3. >THRESH net space has been freed
> 4. the largest available hole in a bg has changed (that means the bg is
> now "better" at receiving relocated extents)

Interesting. How can we detect the largest hole in the filesystem and 
what's the cost? I've never thought about that.

> So 1. will definitely catch every case where you could reclaim, but is
> also susceptible to getting stuck failing a lot with trivial amounts
> freed.
> 
> And 3. is maybe too "mean" and doesn't account for fragmentation.
> 
> I intuitively thought 2. was going to be too similar to 1., but maybe
> it's a good middle ground. If there is a high enough rate of freeing
> activity, since the last time we looked, then we should look again.
> 
> I think 4 is also interesting (perhaps in concert with 2 or 3) as it
> more directly accounts for the critical factor of the current
> fragmentation. But as written it is too similar to 1., small irrelevant
> changes might change the largest hole even if there is still no hope
> whatsoever.
And with the "target free" method to detect net free, we can have a 
dynamic THRESH by setting the target free to "current_free - 
dyn_thresh". What do you think about using the `min_used_bg->used` as 
the dyn_thresh? I think it would be better than 1G.

Thanks,
Sun Yangkai

>>
>> How much the target should be larger than the current free space? Still 1G, or
>> maybe we could find a better value, taking more factors into consideration?
>>
>> And at mount time we cannot find out a proper target value so just set
>> periodic_reclaim_ready to true. (BTW, this is why I use "paused" instead of
>> "ready" in the previous fixup patch: to make the default value fits the default
>> logic, but just set it to true as default seems enough :)
>>
>> So even with this redesign , I think this patch is also necessary, or at least
>> no harm.
> 
> Agreed that it's no harm.
> 
>>
>> Thanks,
>> Sun YangKai
>>
>>> Either way, though, I don't think this is harmful, so we can probably
>>> put it in. Just curious what you think about the other ideas and why
>>> you decided this was needed.
>>>
>>> Thanks,
>>> Boris
>>


