Return-Path: <linux-btrfs+bounces-21468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9UXuOYH/h2nfgwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21468-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:14:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38661107B87
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912AF3014961
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8229E10F;
	Sun,  8 Feb 2026 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gy+8gltx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78332225408
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770520441; cv=none; b=dxUQrX6ycvPOfPBdm8nXFokqtRW2ne6shwH/vxWPCXsyMhGl87JsYC2DTPvQ9RLwizSii5zauU3rKVyUy80r4D2dlNiLUzkV8jgtcRaVYDPPrRtDtp3Dg/GgTyXv/MzqvcbZ6t1wxYhnf44WH24j+AYLRQzwl490gSECvz2kNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770520441; c=relaxed/simple;
	bh=vO9vxXognQw3y+ltUGcVWsvmWciMEuOJExvofwb2mDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2EfUGvGP9ptUxwwZ6ncItSKs3OSPiaDJsCGifAeFS+sMWzhZj8wKOYXcSC9e9RfY7CupKx/tDwpfN3cv94faWynToVwY8U2p+hppGhOw9IkfMNoS5DkmAg9uZNZXUcy6MSWPkVGSczu6VFTXf/Xk7vE9xuzrnUFltBzViAU+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gy+8gltx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436309f1ad7so976669f8f.3
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770520439; x=1771125239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/MGFQwmmcVyce9UevkNKfqF5lzlgoWeOIqRDNULIuc=;
        b=gy+8gltxZmaXv221GCewYeM1jyANn3wX2lLiQzQ6ANIdOr4rjiFQ/8d76zt850GD3J
         c6eKuBONlf20tkhG9KW3mfs/o4UVfMj4E88pA1ixMgxr93yKkG6fgsbJbFTsATqRc6K+
         F60K3xTHN5nywz+e/h0yDDW2g3MEA/hBpANkQXhnWu96AP9xQ70COlusf2ucnm4L3Huu
         PaI/cp2Qpg7f/RPXITxwp84YezmKK2HMoW5oP+eya4cQzR1oivY3hCsiXR2TC5sWkABD
         SRSSqWvnD+SFbLWGDK6ybTxkxa6obMJ1yd3xEXwni89awo78owr5NQenhLhnfbIKgQSp
         GPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770520439; x=1771125239;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/MGFQwmmcVyce9UevkNKfqF5lzlgoWeOIqRDNULIuc=;
        b=PqvNexkgi2sKJ1RAkcNpgrb3aJEF3izIkBBwcfWemfE9qHZNpfiGU43klZR5u+IQkr
         Z86unnD578H7dfjyJZfB5YH8eAvwebWFbonF1EVZbtwwZAWvKbvVD82yhcvV7pYK7w2L
         9jAgrFZ5hvo5OtP3//pA7dRJAzOGNVxVOQjuS4FpjnWioT9IYmqRnAuILOw1ZR1N4WcG
         jSN+Zjnm4+m3GugD/NxR28mkn/lkrxmWlqtWb36gh2j8nwZpBIreFTT/sgeZMP+b3c85
         JBD6jCGJr/Yw7ghPMSpM9VJu1PCAI47RXPntJcnde1025YBlUDpNxB4TRxKVXqG1AQIs
         nnpA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmwZO83xk9DdltuOKsLKxQ1OjhM/EfhETolZK/jsgWZopflHxdVM8xFqSy74lxloYOFhIGaUv6xS4Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5gIiZqshFatapSUOEaYEnSADP+GHMdNQYPZ/p4+D7cxVH7VT
	12Q5ZgSy0stV1N+b0U15zKEB0Mp6vXlQysGZtkDhG0VeAD1rD7m7rkGMbr7YFyaQh3v03QZwiZM
	1RfYgiqA=
X-Gm-Gg: AZuq6aIotJOSKZHp2dvpzOXhXYfcmkY52KIynAvr/knE+zh9Nq8h+TRMvSQWsyWxbCd
	waAti1xJ8mO4e21OWgWM33MIjp59Ht5YSErHKStceNUspFImjUR86XV+8SNuK0wjl7rtmQ4aPJv
	PSYMTvCzAlUSvnGEy5Fr6ljoyxv9iDHdwMhLX33SXnURBgxhcwE+D8BGXeVTu/nEIrgJKZadqTH
	6Zu47RoqF6n2MsUKZkV5kGlvn3iGXruHcfrcXOmIN+zTy1QK/GVvzj5ErnzK1HTsUbc3jB1LIgZ
	nfBKLs0steCdeNWDftdhkdnmhKrK+IipvoxH01FZBgt4YqVjaucIBPFAij8PHIXnGfYgjRcKwYO
	NMqQ+vUH4IBDecLj/9CtE/HVliJ/3b43boOnvQ369VPUyUigxREWTW8eHfo1v6rbiKVRMQfLeto
	Kzy4wHytXatXQJ5acF19PqCkCNAWe96bdNQZR3bHI=
X-Received: by 2002:a05:600c:64c4:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-483202139ecmr110464765e9.24.1770520438705;
        Sat, 07 Feb 2026 19:13:58 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82459b1190esm2615587b3a.37.2026.02.07.19.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 19:13:58 -0800 (PST)
Message-ID: <7d712cd2-21b1-471e-917f-c39d351bc8d6@suse.com>
Date: Sun, 8 Feb 2026 13:43:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs: ctree: cleanup btrfs_prev_leaf()
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
References: <20251211072442.15920-2-sunk67188@gmail.com>
 <20251211072442.15920-6-sunk67188@gmail.com>
 <bf7c477d-ce4c-4d6e-9538-1baa33e39a02@suse.com>
 <ed9925c6-3664-4158-87ef-48e7316a7128@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <ed9925c6-3664-4158-87ef-48e7316a7128@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21468-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38661107B87
X-Rspamd-Action: no action



在 2026/2/8 13:12, Sun YangKai 写道:

> 
> Sorry, I got a little confused here. When btrfs_search_slot() returns an 
> empty leaf, path->slots[0] will be 0 and btrfs_prev_leaf() will return 
> 1. Therefore, if btrfs_prev_leaf() returns 0, the leaf we get should 
> always be non-empty. Which part of this reasoning is incorrect? Or maybe 
> I don't get what you want to say.

Because the old btrfs_prev_leaf() can return 0 if the tree got emptied 
before btrfs_search_slot() call, if you're doing a cleanup, just don't 
change that behavior.

If you think this behavior is not correct, do it in another patch and 
explain it correctly.

>>
>> Although the change is mostly fine, if you want to keep the existing 
>> behavior, you should return 0 for empty tree to keep the old behavior.
> 
> I've not thought about the empty tree case before. But I think the 
> previous behavior in empty tree case is not proper and I don't want to 
> keep the old behavior in this case.

Then it's no longer a cleanup, and you're mixing a cleanup with a 
behavior change.

> All callers is doing
> path->slots[0]-- if btrfs_prev_leaf() returns 0 and it will cause an 
> unexpected underflow although they'll check if nritems is 0 later.

They all have proper nritems check or the tree will never be empty.

For extent tree it will never be empty, at least without extent-tree-v2 
feature.
So btrfs_previous_extent_item() should never hit an empty tree.

For btrfs_search_slot_for_read() the qgroup callers are never blindly 
decreasing slots[0], for send callers the subvolume tree will never be 
empty.

Thus all your underflow argument makes no sense.

If you don't like this behavior, again change it in a dedicated patch, 
not mixing it into the so called "cleanup" patch.


