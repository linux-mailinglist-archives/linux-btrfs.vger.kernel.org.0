Return-Path: <linux-btrfs+bounces-21462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPG2AwD9hmnhSgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21462-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 09:51:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CE5105444
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 09:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88E6C3022623
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858E30E857;
	Sat,  7 Feb 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fac3w+Ic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39F1F91D6
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770454264; cv=none; b=OFTeK1cDscypm6+5BMbPt+QKxq4jAZfyPSvEfV0Tv+egxiw1LlqekaLXslwEVDE7gfQw0uTomeekkVNfwXlNdwtKRtrUPH0btyuw2dtni8qp27BWkW1p35wjjTDSJDTC60TgNHuAfVO+8WDzmZjiS0tpt6B+z7v/0vgn5JMcAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770454264; c=relaxed/simple;
	bh=aJPSMQrD0YKgzSSOrGa3j3xpZbSbLT2NVvRO9HpsgjI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pne9XphZpqYpVQ02izh5bIjFL4/yPRiPT/Z0PZ03RSYfLnWtK7bMJOZCjrWgHoR9lLmumBaSplTKKrPoKZM5NEeDIv6zt+y+qyU3pD4S32WmfeSVQqvLflu33AYfrSC7or19WuRrZRsmMiQHAiNjdOkdbBdjMODbYCbzc3q5qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fac3w+Ic; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee57c478eso2727785e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770454262; x=1771059062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVb2cmT+ljWqLF59C7PhUkMhY1uy8ZflADdtP6Jtw5w=;
        b=Fac3w+IcbtlgOrlrqAcLTUabBEQEt7+WMROXxrJZZG/Y1Oa8tUy+TXEr3DvjYS9e41
         q5rLVOreU43TtX9BuKeU0zenotbY/EijpfTs+/GwEIyzDm8H32dZ+WxDOukJRvTWFR8C
         UyhNDnSqLlQGnPlQS5FCUYTt/MZxkSJBao7th80mSFvRFuA2RH2t/jTK30zaW+T9QYwk
         s2Zm59zJySUCPwCCnYZ2s6fn1IIpqhbOfMsjffeEojGSB0W+YwQLqW818xX9JWtspyk2
         BgRppI8NVaTnG2+kwRI1VO/PnU+15MNuSto3THUyM0MoYAojXOnNTH5eM+XxXue10sNe
         bb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770454262; x=1771059062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVb2cmT+ljWqLF59C7PhUkMhY1uy8ZflADdtP6Jtw5w=;
        b=Gu4Ik9KwXL0Cg112bm72BL56i+d0XoVQ16H93VEapQ/ctvy30TMhGGLqCGRC6WZQfn
         j80WWWbHzONczI57RqGWTfloJzJTjtaaSZ6vtNqEkGcZgGBaIKsaWHuU08zyVsN9Kjmr
         qKF2SVaIR0+1A+NH/FEbaxk0Ovf5gSHSU2Sp+i6b48VV13DE9jI5tboz4qVvblkrsFVK
         c5WdLffPTQzmeMq4BT3Y6XDUVlRLZ5aFB7nlnEymBYvOOGX4UzFWwV1kx4m/gSCTlhX+
         PjokQJR2WUXvtMShFR370KiHPjcHMAEJ67W+1NA8JElRkgCYjAOhmo8b9xpI9xTlgzgx
         rDIA==
X-Gm-Message-State: AOJu0Yxr6ZYZJzL9VpTZMkQPjHZ8WHV70y/+l5mFu6mGQXpVXVgnq179
	OUT1AurS3D1Y+cGmf5Nj0SMSIMhB7xzQ+dQQDQJfv83lNjxZbvfsZMJb
X-Gm-Gg: AZuq6aLRcLhUUucBCLj91qFYaBwLKteDigYg/VKCpsYG26ZNhIQNq1uYRkx4KGQwiAb
	knu/NPL/UI13pdqX94WQlOEarqPC7infiUkjneRyi1wk05zh9qnMzMWmpm1TPG8f6kmKWifIDt/
	TL+9E6I9YwvIVpVaLq/2V9Zk4/RDyEISWi/QcY8xSeSJm8bYvEPNbyjdnAapjJpeTKyO62qk6+r
	h5XWK6SIPepbn24jbc68B3hMq9+hqwXm1ZxAyPCeFg806Gb8jzxhgUylUvabmYdyIYwNZUdwO79
	IVlpqrKpQS/bnTjbezabQkoN+qax/w9wjBUTv7XOnDabxxV8VQWIlguTT4pcomJbCeNWFXQZ36B
	bNFSVX+ekfnvxDouehLZYdkw98LcXEv2WHwBUYS12mk1935gEOICQbXJFjjh4yggkiODmZv7GPr
	LYqB1hhwR+NCDdXWHBeUW3533ClIeQ4xhgpgRmCF23yNF2TjDVGbbRvkIgOWdV0YLNLw==
X-Received: by 2002:a05:6000:2210:b0:431:66a:cbdc with SMTP id ffacd0b85a97d-4362933fe7fmr4063751f8f.4.1770454262024;
        Sat, 07 Feb 2026 00:51:02 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:180c:86b4:d220:939b? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43631c8d378sm4845396f8f.21.2026.02.07.00.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 00:51:01 -0800 (PST)
Message-ID: <d092aa23-655f-408b-94c6-edede3c8dbf2@gmail.com>
Date: Sat, 7 Feb 2026 16:50:56 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
From: Sun YangKai <sunk67188@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251209033747.31010-1-sunk67188@gmail.com>
 <20251209033747.31010-5-sunk67188@gmail.com>
 <CAL3q7H5RZcENpYOYtPPoMQgemSLZ8OQ5-w_joNAkwFqV+j0raQ@mail.gmail.com>
 <e058b458-0c8a-47ae-9e45-88f2eaa8b821@gmail.com>
Content-Language: en-US
In-Reply-To: <e058b458-0c8a-47ae-9e45-88f2eaa8b821@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-21462-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7CE5105444
X-Rspamd-Action: no action



On 2025/12/9 20:27, Sun Yangkai wrote:
> 
> 
> 在 2025/12/9 20:05, Filipe Manana 写道:
>> On Tue, Dec 9, 2025 at 3:38 AM Sun YangKai <sunk67188@gmail.com> wrote:
>>>
>>> There's a common parttern in callers of btrfs_prev_leaf:
>>> p->slots[0]-- if p->slots[0] points to a slot with invalid item(nritem).
>>>
>>> So just make btrfs_prev_leaf() ensure that path->slots[0] points to a
>>> valid slot and cleanup its over complex logic.
>>>
>>> Reading and comparing keys in btrfs_prev_leaf() is unnecessary because
>>> when got a ret>0 from btrfs_search_slot(), slots[0] points to where we
>>> should insert the key.
>>
>> Hell no! path->slots[0] can end up pointing to the original key, which is what
>> should be the location for the computed previous key, and the
>> comments there explain how that can happen.
>>
>>> So just slots[0]-- is enough to get the previous
>>> item.
>>
>> All that logic in btrfs_prev_leaf() is necessary.
>>
>> We release the path and then do a btrfs_search_slot() for the computed
>> previous key, but after the release and before the search, the
>> structure of the tree may have changed, keys moved between leaves, new
>> keys added, previous keys removed, and so on.
> 
> Thanks for your reply. Here's my thoughts about this:
> 
> My assumption is that there's not a key between the computed previous key and
> the original key. So...
> 
> 1) When searching for the computed previous key, we may get ret==1 and
> p->slots[0] points to the original key. In this case,
> 
> if (p->slots[0] == 0) // we're the lowest key in the tree.
> 	return 1;
> 
> p->slots[0]--; // move to the previous item.
> return 0;
> 
> is exactly what we want if I understand it correctly. I don't understand why
> it's a special case.
> 
> 2) And if there's an item matches the computed previous key, we will get ret==0
> from btrfs_search_slot() and we will early return after calling
> btrfs_search_slot(). If there's no such an item, then we'll never get an item
> whose key is lower than the key we give to btrfs_search_slot().
> So the second comment block is also not a special case.
> 
> These two cases are not related with how the items moved, added or deleted
> before we call btrfs_search_slot().
> 
> Please correct me if I got anything wrong.
> 
> Thanks.

After reviewing this patch several times, I cannot find anything wrong 
with it. I'd glad to learn a special case which will break the new code.

My assumption is that let's say we have leaf A with key range [100, 180] 
and leaf B with key range [200, ...] at search time (and we don't care 
how those keys distribute before we release path), when searching for 
key 199, we'll always get to leaf A and pointing to the position next to 
the last item of leaf A. Please correct me if my assumption is wrong :)

Let's see the origin code:

	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
		ret = btrfs_comp_keys(&found_key, &orig_key);
		if (ret == 0) {
			if (path->slots[0] > 0) {
				path->slots[0]--;
				return 0; // case 1
			}
			return 1; // case 2
		}
	}

	btrfs_item_key(path->nodes[0], &found_key, 0);
	ret = btrfs_comp_keys(&found_key, &key);
	if (ret <= 0)
		return 0; // case 3
	return 1; // case 4

And the new code:

	if (path->slots[0] == 0)
		return 1; // case A

	path->slots[0]--;
	return 0; // case B

For all the origin return branches:

- Case 1: it will go to case B now, the same behavior;
- Case 2: it will go to case A now, the same behavior;
- Case 3: if ret == 0, then the found key matches the key,
	  btrfs_search_slot will return 0 and we'll not get to case 3.
	  So ret must less than 0, and the key of the item at slot 0 is
	  less than the search key so path->slots[0] is greater than
	  0 and we'll go to case B now. The behavior is different,
	  but we make sure pointing to the previous item in new code.
- Case 4: the key of item at slot 0 is larger than the key we give to
	  btrfs_search_slot(). In this case path->slot[0] must be 0 and
	  we'll go to case A now.

The original code's complexity (comparing keys) was an attempt to verify 
if we landed exactly where we started, but this is unnecessary and I 
don't think the previous search result and the release path things 
matter because we're starting a brand new tree search and 
btrfs_search_slot is the source of truth for the current tree structure.
As long as we treat all the things as a brand new search, looking for 
the item with key=(origin_key - 1) or the previous item if it doesn't 
exist, it will be very simple and clear :)

Thanks.

>>
>> I left all such cases commented in detail in btrfs_prev_leaf() for a reason...
>>
>> Removing that logic is just wrong and there's no explanation here for it.
>>
>> Thanks.
>>
>>
>>

