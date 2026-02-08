Return-Path: <linux-btrfs+bounces-21467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rgSfKhr4h2kZggQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21467-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 03:42:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E695E107A9E
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 03:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C63430177B6
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE2270ED7;
	Sun,  8 Feb 2026 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp6eBUaX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C01CBEB9
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518545; cv=none; b=MtcP7uChxZrKWixWj7J46rewoOzLe6h44EK+yF6uL6F+0Q0Y60i5cqpkyU3tfhpCWZ5bH6kw/scC14SQvxIfF3/1hDzjJhaRQMKxKyXEpFMnHqAUDabR0QVLcVROiINC29o4lcXdh1wc9mB0xn/1f413DOQ8oBtiTnMftO3XJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518545; c=relaxed/simple;
	bh=j5IN6rQUFAX4iZZ3sqR/e2shsYehMA0t/xj7bljJA+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEcjnpyvSrBo6BL0IL5GJaefJ3ieSH1j1rWfeFl4mFBxv6W5efZ1/5JqSj3ZbsKYitEntQOk5z7NB5NagvXuMqdUByizmVa9rpj0A/ZpgTGq40tc11d73wfPCyGpH7wxLASQXNY12eZrytUB9C4adcP29npTSn5gN15DZZhhRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp6eBUaX; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483103c7126so2607505e9.2
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 18:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518543; x=1771123343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0X/HphAro9CK1Rgx7odAh/8DDzo2IFjR3qoHzgcYz48=;
        b=Wp6eBUaXWddt0Zr+9PgSwq75ae7uJWAe9GmJJqreOaUHEdhl+ddVERbTkQizmon9rb
         CqjhLSVDmYmN8ykgyskQXBnD5xcL+ZGxC7DFmPEf/zLXfuqpZLpqBSk6aREZOIxk/DWk
         WrrWaFplKQ4NlTTlDoi76vdSNLvkm+2FVsKD40RIcQXKpUhdfsKQjgjMlFzXTIJa6orL
         WJJOAZGHxGqoTvePaDYAFtBtF25AuXzHxDZ7WLNGotDP07MVdwuAXQnljOD0nKJGrFa6
         X0P7PBRCmVnlfofgVxGWURB8fe06t2tPHh3MotpiuXGYJOdndLKb8xp04kwWYA6knDUB
         flfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518543; x=1771123343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0X/HphAro9CK1Rgx7odAh/8DDzo2IFjR3qoHzgcYz48=;
        b=Rc3BQVgqC5pxNbqZlO6+e0WnWwd0GOpcL/NMSt99pi+SM4McDeG1f9LQBpWuzJ25TL
         hFos23paIvB7V3L1/69Ngq7gt7E6+ebl6lHypNAmTn1i6RAv5qKmAquHQwA8m3EqHeDx
         ac01yRZKmNu3+OAVOp4wOVOQI4v4g+iFP9FySFmtqdJE5zmzeOfDutEZ5ZQRihP+IrBA
         9nzb7KT8SuJqJ9e5Gim/Kvjc8X8sRJe8+KtaRXJ4lLh0jE7IF18MtRf97BJLYx9UR2S2
         Yo1wAVOqyNyUtPFoa99utwxtaUOr3lGaMlb8QLMzoIWIbVqqAr1tipupjQz6r3UoxRaR
         vf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUou+NRT12Dh6JtBWNOn0Z4ouF2F8gSpqSOlw+KEnfWftEsgqVv+LnGvYvKVaOcdSf0X/MNP0i/6jpjDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YweGN0WFCLivZaPC46qJe9vpDf+TXQ73f+OL1sTMn0ApvhVeI7b
	f1YN94T7jYIxafsqt8P2T3NNygM7k7SJRa13AmbGlzfXo98gtehWR5M7
X-Gm-Gg: AZuq6aJ7R1Q9Pm4Rc2Q3AkSp+xrDfUGn5QBw7rCUJRE1EhHNurfGfmMUs6az0mhGqW+
	cXjbXLk0Ku/E8IN1BN2of/VIXFPWEnFD5d7dKOrlYTFYBbuE8f04jlqegCeO9thqWwrUTK2MgYT
	nIAaPoapMGZ4uYJMChOvpzgohwpTH2gWh1q3phd+EQnfLln/OWVsWEZcS1LcreLggBQMsb+Yb4P
	C2ExAyoh9FbqItjCjTDdK1Y2vQ76KF+GHpfJjdBGBdceGpWACydkRCHN1A/4oYYFyJM1WzfUMNN
	tod52+pO6fbcOfMIaJxjnIuLYiCh3jOMQnT/knl3ha7CKrTeSlxsiCSRQKM5DSYVHsd+A+z3/52
	xA4YJBCZF/cBVsVxSOKY8ggSMbV61Ozc0J8qiiKA/CiGaMqEFZlzfZ71Io925g2njjTD4m5WKTm
	4tRDCMvmTQpM5XbyPDEa96ivTYXVKSAtQolGVS2xa2DMoIlDQw88PmPAhhYlTCReFpiw==
X-Received: by 2002:a05:600c:4fc9:b0:477:9fd6:7a53 with SMTP id 5b1f17b1804b1-4832020f975mr57946145e9.2.1770518542805;
        Sat, 07 Feb 2026 18:42:22 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:180c:86b4:d220:939b? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm288295575e9.0.2026.02.07.18.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 18:42:22 -0800 (PST)
Message-ID: <ed9925c6-3664-4158-87ef-48e7316a7128@gmail.com>
Date: Sun, 8 Feb 2026 10:42:17 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
References: <20251211072442.15920-2-sunk67188@gmail.com>
 <20251211072442.15920-6-sunk67188@gmail.com>
 <bf7c477d-ce4c-4d6e-9538-1baa33e39a02@suse.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <bf7c477d-ce4c-4d6e-9538-1baa33e39a02@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21467-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E695E107A9E
X-Rspamd-Action: no action



On 2026/2/8 07:09, Qu Wenruo wrote:
> 
> 
> 在 2025/12/11 17:52, Sun YangKai 写道:
>> There's a common parttern in callers of btrfs_prev_leaf:
>> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
>>
>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>> valid slot and cleanup its over complex logic.
>>
>> And then remove the related logic and cleanup the callers.
>>
>> This will make things much simpler.
>>
>> No functional changes.
>>
>> A. Details about changes in callers:
>>
>> ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0])) in callers
>> is enough to make sure that nritems != 0 and slots[0] points to a valid
>> btrfs_item.
> 
> I don't think the change is safe.
> 
> There are callers doing proper checks for empty trees, e.g. 
> btrfs_previous_extent_item() and btrfs_previous_item(), now you will 
> just ignore that for kernels without CONFIG_BTRFS_ASSERT, or crash the 
> kernel if CONFIG_BTRFS_ASSERT is selected.
> 
> If you're just cleaning up btrfs_prev_leaf(), then you should keep the 
> callers the same without changing their behaviors.

Thanks a lot for your code review and it makes a lot of sense. I'll not 
touch the callers in the next version.

> I think there may be some corner case races when tree deleting and some 
> other work are happening at the same time.
> 
>>
>> And getting a `nritems==0` when btrfs_prev_leaf() returns 0 is a logic
>> error because btrfs_pref_leaf() should always
>>
>> 1. either find a non-empty leaf
> 
> Nope, there is no such guarantee in the first place.
> btrfs_prev_leaf() will unlock the path, thus all kinds of modification 
> can happen between btrfs_release_path() and btrfs_search_slot().
> 
> This assumption is just wrong.

Sorry, I got a little confused here. When btrfs_search_slot() returns an 
empty leaf, path->slots[0] will be 0 and btrfs_prev_leaf() will return 
1. Therefore, if btrfs_prev_leaf() returns 0, the leaf we get should 
always be non-empty. Which part of this reasoning is incorrect? Or maybe 
I don't get what you want to say.

>> 2. or return 1
>>
>> So we can use ASSERT safely here.
>>
>> B. Details about cleanup of btrfs_prev_leaf().
>>
>> The previous implementation works like this:
>>
>> 0) Get a previous key by "dec by 1" of the original key. Let's call it
>>     search key. It's obvious that search key is less than original key
>>     and there's no key between them.
>>
>> 1) Call btrfs_search_slot() with search key.
>>
>> 2) If we got an error or an exact match, early return.
>>
>> 3) If p->slots[0] points to the original item, p->slots[0]-- to make sure
>>     that we will not return the same item again. This may happen because
>>     there might be some tree balancing happened so the original item 
>> is no
>>     longer at slot 0.
>>
>> 4) Check if the key of the item at slot 0 is (less than the original key
>>     / less than or equal to search key) to verify if we got a previous 
>> leaf.
>>
>> However, 3) and 4) are over complex. We only need to check if
>> p->slots[0] == 0 because:
>>
>> 3a) If p->slots[0] == 0, there's no key less than or equal to search key
>>      in the tree, which means the original key is lowest in the tree. In
>>      this case, there's no previous leaf, we should return 1.
>>
>> 3b) If p->slots[0] != 0, using p->slots[0]-- is enough to get a valid
>>      previous item neither missing anything nor return the original item
>>      again because:
>>
>>      i) p->slots[0] == nritems, which means all keys in the leaf are less
>>         than search key so the leaf is a previous leaf. We only need to
>>         p->slots[0]-- to get a valid previous item.
>>
>>      ii) p->slots[0] < nritems, p->slots[0] points to an item whose key
>>          is greater than search key(probably the original item if it was
>>          not deleted), and p->slots[0] - 1 points to an item whose key is
>>          less than search key. So use p->slots[0]-- to get the previous
>>          item and we will neigher miss anything nor return the original
>>          item again. This handles the case 3) in original implementation.
>>
>> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
>> ---
>>   fs/btrfs/ctree.c | 99 ++++++++++--------------------------------------
>>   1 file changed, 19 insertions(+), 80 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 0a0157db0b0c..3026d956c7fb 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -2376,12 +2376,9 @@ int btrfs_search_old_slot(struct btrfs_root 
>> *root, const struct btrfs_key *key,
>>   static int btrfs_prev_leaf(struct btrfs_root *root, struct 
>> btrfs_path *path)
>>   {
>>       struct btrfs_key key;
>> -    struct btrfs_key orig_key;
>> -    struct btrfs_disk_key found_key;
>>       int ret;
>>       btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
>> -    orig_key = key;
>>       if (key.offset > 0) {
>>           key.offset--;
>> @@ -2401,48 +2398,12 @@ static int btrfs_prev_leaf(struct btrfs_root 
>> *root, struct btrfs_path *path)
>>       if (ret <= 0)
>>           return ret;
>> -    /*
>> -     * Previous key not found. Even if we were at slot 0 of the leaf 
>> we had
>> -     * before releasing the path and calling btrfs_search_slot(), we 
>> now may
>> -     * be in a slot pointing to the same original key - this can 
>> happen if
>> -     * after we released the path, one of more items were moved from a
>> -     * sibling leaf into the front of the leaf we had due to an 
>> insertion
>> -     * (see push_leaf_right()).
>> -     * If we hit this case and our slot is > 0 and just decrement the 
>> slot
>> -     * so that the caller does not process the same key again, which 
>> may or
>> -     * may not break the caller, depending on its logic.
>> -     */
> 
> Although the change is mostly fine, if you want to keep the existing 
> behavior, you should return 0 for empty tree to keep the old behavior.

I've not thought about the empty tree case before. But I think the 
previous behavior in empty tree case is not proper and I don't want to 
keep the old behavior in this case. All callers is doing
path->slots[0]-- if btrfs_prev_leaf() returns 0 and it will cause an 
unexpected underflow although they'll check if nritems is 0 later. So I 
will mention this behavior change in commit message and comments in the 
next version.

> Furthermore, you have to explain why it's safe not only in the commit 
> message, but also comments.
> 
> This not a small change, and very low-level. Just doing black magic is 
> not acceptable.
> 
> And you need something better than your commit message as comments.
> 
> In short, you should:
> 
> - Not change the callers
> 
> - Better comments

Thanks. Very helpful for me. And wish you have a good weekend :)

> 
>> -    if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
>> -        btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
>> -        ret = btrfs_comp_keys(&found_key, &orig_key);
>> -        if (ret == 0) {
>> -            if (path->slots[0] > 0) {
>> -                path->slots[0]--;
>> -                return 0;
>> -            }
>> -            /*
>> -             * At slot 0, same key as before, it means orig_key is
>> -             * the lowest, leftmost, key in the tree. We're done.
>> -             */
>> -            return 1;
>> -        }
>> -    }
>> +    /* There's no smaller keys in the whole tree. */
>> +    if (path->slots[0] == 0)
>> +        return 1;
>> -    btrfs_item_key(path->nodes[0], &found_key, 0);
>> -    ret = btrfs_comp_keys(&found_key, &key);
>> -    /*
>> -     * We might have had an item with the previous key in the tree right
>> -     * before we released our path. And after we released our path, that
>> -     * item might have been pushed to the first slot (0) of the leaf we
>> -     * were holding due to a tree balance. Alternatively, an item 
>> with the
>> -     * previous key can exist as the only element of a leaf (big fat 
>> item).
>> -     * Therefore account for these 2 cases, so that our callers (like
>> -     * btrfs_previous_item) don't miss an existing item with a key 
>> matching
>> -     * the previous key we computed above.
>> -     */
>> -    if (ret <= 0)
>> -        return 0;
>> -    return 1;
>> +    path->slots[0]--;
>> +    return 0;
>>   }
>>   /*
>> @@ -2473,19 +2434,11 @@ int btrfs_search_slot_for_read(struct 
>> btrfs_root *root,
>>           if (p->slots[0] >= btrfs_header_nritems(p->nodes[0]))
>>               return btrfs_next_leaf(root, p);
>>       } else {
>> -        if (p->slots[0] == 0) {
>> -            ret = btrfs_prev_leaf(root, p);
>> -            if (ret < 0)
>> -                return ret;
>> -            if (!ret) {
>> -                if (p->slots[0] == btrfs_header_nritems(p->nodes[0]))
>> -                    p->slots[0]--;
>> -                return 0;
>> -            }
>> +        /* We have no lower key in the tree. */
>> +        if (p->slots[0] == 0)
>>               return 1;
>> -        } else {
>> -            p->slots[0]--;
>> -        }
>> +
>> +        p->slots[0]--;
>>       }
>>       return 0;
>>   }
>> @@ -4969,26 +4922,19 @@ int btrfs_previous_item(struct btrfs_root *root,
>>               int type)
>>   {
>>       struct btrfs_key found_key;
>> -    struct extent_buffer *leaf;
>> -    u32 nritems;
>>       int ret;
>>       while (1) {
>>           if (path->slots[0] == 0) {
>>               ret = btrfs_prev_leaf(root, path);
>> -            if (ret != 0)
>> +            if (ret)
>>                   return ret;
>> -        } else {
>> -            path->slots[0]--;
>> -        }
>> -        leaf = path->nodes[0];
>> -        nritems = btrfs_header_nritems(leaf);
>> -        if (nritems == 0)
>> -            return 1;
>> -        if (path->slots[0] == nritems)
>> +        } else
>>               path->slots[0]--;
>> -        btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +        ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
>> +
>> +        btrfs_item_key_to_cpu(path->nodes[0], &found_key, path- 
>> >slots[0]);
>>           if (found_key.objectid < min_objectid)
>>               break;
>>           if (found_key.type == type)
>> @@ -5010,26 +4956,19 @@ int btrfs_previous_extent_item(struct 
>> btrfs_root *root,
>>               struct btrfs_path *path, u64 min_objectid)
>>   {
>>       struct btrfs_key found_key;
>> -    struct extent_buffer *leaf;
>> -    u32 nritems;
>>       int ret;
>>       while (1) {
>>           if (path->slots[0] == 0) {
>>               ret = btrfs_prev_leaf(root, path);
>> -            if (ret != 0)
>> +            if (ret)
>>                   return ret;
>> -        } else {
>> -            path->slots[0]--;
>> -        }
>> -        leaf = path->nodes[0];
>> -        nritems = btrfs_header_nritems(leaf);
>> -        if (nritems == 0)
>> -            return 1;
>> -        if (path->slots[0] == nritems)
>> +        } else
>>               path->slots[0]--;
>> -        btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +        ASSERT(path->slots[0] < btrfs_header_nritems(path->nodes[0]));
>> +
>> +        btrfs_item_key_to_cpu(path->nodes[0], &found_key, path- 
>> >slots[0]);
>>           if (found_key.objectid < min_objectid)
>>               break;
>>           if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
> 


