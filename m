Return-Path: <linux-btrfs+bounces-22054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CSYOJZGoWkirwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22054-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:24:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB641B3CF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 08:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEBA3156E0B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C4346E7F;
	Fri, 27 Feb 2026 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RIsjY4Pm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DA3290CB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176841; cv=none; b=skb40Zu1aVEeaFXUf1a/w2D0tu2a8Ico+0gMCubTVSc+aVkjwFnUwQd5QluwnbI3yx0/Aq21ZKMLpwQUXl5xWh4BCa973Hvf6B26FHhOuQbVWgEKWDnF9hABnqVdzf8YBhdBNDc5Mo0kCTBMWRqfmFp7NOAxFXtOJ7/NKvz/yW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176841; c=relaxed/simple;
	bh=RINOkdqWzd30PAoNEHTK8gNNinmwkG1WXZpcGX7GSEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGOVtC1HiFrJ+e8Q7l+RJbpG7CCIHxyxR6kqKodfkma549U40EN8hCOQvowkmbppoWRQ5T26z5w99m2LbndJ0YYdShpZMgxmjYLJxpn1+8gBe7hZrQesH30AtKkMlSJfWv7tI66OWWfn4qzEEoBqzX2MXUCskseMHAA1oS0FiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RIsjY4Pm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371119eacso18995345e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 23:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772176838; x=1772781638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IeSLYQq4Yr91/SHFSQfq3HFY0DQpEGqZNemnY1A0BrU=;
        b=RIsjY4PmeZeSeWRJvBY12BvtY+qImYng8GjwGZUBQ1KqZpv5VfzmNBjqpzJ2IyzM0Z
         CquH4PREjW87Q2pIFG05vSP2xxl4YPTfxdBSHtDmOAZ8nETqA8U7livViqTHARcyIYsX
         yPt+pO75nLYsKeitUzrD0iZzTm7BdqcbrQ7tOK5oUdgL4EgwzQ478WvIs1o4hMnZ68e1
         7BnnjrP81L5RFiURl2FwpcOTe4xPrlzJYTjFyNG5Wy3tuVZJ9wpdE+7YEeUer2B0aJDf
         9465+HPRY16F2Upyr+zXKvAw0GOjG/DETJcFNkjvtFgtOQ/gY85FaDaOpPoSURzgyT9h
         D/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176838; x=1772781638;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeSLYQq4Yr91/SHFSQfq3HFY0DQpEGqZNemnY1A0BrU=;
        b=BtL3/P84Q+U7Th8roKGO3gg5JfYT6smGRcUAx4uCGncXY7al4v+5bpuTfw0X54T9lH
         jKogBy4XNbLYrbY0LRqtGXIJ6Hp6l08XcmrUIaLyokO2a0JlE6Az6Kc2Js9QJe+aS6Nt
         2hMGdRpqdAi/ancBtQv4FQCbjGD0uTkxL64RCHeKe3ctnO3sWi4d06u3cw2xdl/6Ncf8
         g3NAIbcdqBa2WcsaQbE1AtC9bV4cXzg3VXqQ++kTdFmZk1dHfUaXFLdFxHZnYKNHLrG/
         04n5jhON0YfRbnT1Hsu841dzdXMYVPJqvqr2/ojGbq0JsTbLJjYVIrvjwym4GIhJYuKB
         XvEg==
X-Forwarded-Encrypted: i=1; AJvYcCWo+kN+01vkLFiWeGPUXULlGuVv+hOIvehmveKjaDjcP0E4tZn01C0dSBAdf9n+5RV4d91SA0GTnyKnQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDiv9WewYj0u9UCO3oozQxm410d/XBhhiqwTYoa4rq92Qun6B
	5pB+q497HfzhQ5hyMV2vEeV97eNF5/r6Grokiq7v+hjzk045Bx6b5IFbtUJjChuhISM=
X-Gm-Gg: ATEYQzyHKALbFedWaQsHuwfjMiHof6T45YK+isa3xhJGvT78R+UxLaUnm0CqRcUd1J3
	Kl0vB2/cpDx/03xBE/miwXONT7CAooCBrbmff1EhN9vGL8+N7hXHjaDwCxkS3PQTftI4uAY7jUI
	8Iub6LGT0Di4ys/BjscWGxiXCCQaISR5OvpudLJOS3oTMyi4pz/3pu2gpr4JL3iutzdK8cQyUTO
	GALwS+sjaGBjPCz9GkQbwEZ+D/UhfELx/FiSsxmd0K6MLwYHMlpWbg2qNgOGUVtqZvD4htxIy4a
	Spgzrvctse67/5ZBSxbVuPOuBrx5fODixFg8EQ8W6yOH1UY1FE2gIF+jj5ijBl31WiFLrcH5vSM
	gMCFm0e895IKJkL7xmVfUBYVIvDjzNVSV6TO/xw1n5LP74mZm7kFEsCm8YNO2l+ntd71w2/7dFj
	0LN9dxBGFD2nqwSBh97lY0KG6kE8RLArrXK+5z0TfOSGasQPWzpyg=
X-Received: by 2002:a05:600c:4748:b0:483:c35d:367f with SMTP id 5b1f17b1804b1-483c9c0ba58mr21897295e9.21.1772176838073;
        Thu, 26 Feb 2026 23:20:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm7533839a91.2.2026.02.26.23.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 23:20:37 -0800 (PST)
Message-ID: <de91765d-1f7d-4152-8c37-36a58bdc4226@suse.com>
Date: Fri, 27 Feb 2026 17:50:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] btrfs: free path if inline extents in
 range_is_hole_in_parent()
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sashal@kernel.org, fdmanana@suse.com, linux-btrfs@vger.kernel.org,
 dsterba@suse.com, josef@toxicpanda.com, clm@fb.com
References: <20260227064414.2314529-1-lihongbo22@huawei.com>
 <2a3587d3-f131-4e19-b7fd-3c14e8d097f6@suse.com>
 <262f6108-35a8-4db0-b1be-c91d14651811@huawei.com>
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
In-Reply-To: <262f6108-35a8-4db0-b1be-c91d14651811@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22054-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AB641B3CF3
X-Rspamd-Action: no action



在 2026/2/27 17:46, Hongbo Li 写道:
> Hi Wenruo,
> 
> On 2026/2/27 14:48, Qu Wenruo wrote:
>>
>>
>> 在 2026/2/27 17:14, Hongbo Li 写道:
>>> Commit f2dc6ab3a14c ("btrfs: send: check for inline extents in
>>> range_is_hole_in_parent()") is a patch backported directly from
>>> mainline to 6.6, it does not free the path in the inline extents case.
>>>
>>> Commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE
>>> conversions") in 6.18-rc1 fixes this by accident
>>
>> It's not "by accident", it's the designed behavior, remember the fix 
>> is after that commit introducing scope-based auto-cleanup.
>>
>> It's missing the dependency, which can not be directly backported, and 
>> considering the scope-based auto-cleanup makes is much harder to 
>> detect just by the patch context, it's indeed a problem.
> 
> Thanks for quickly reviewing.
> 
> Yeah, you are right, the commit 08b096c1372c ("btrfs: send: check for 
> inline extents in range_is_hole_in_parent()") is later. So I think I 
> should update my commit message.
> 
> In addition, the 6.12 LTS may have the same problem which introduced by 
> db00636643e66898d79f2530ac9c56ebd5eca369.

Yep, I also noticed this during my manual backport for SLE kernels and 
fixed them there, but didn't notice the auto-backport from stable branches.

BTW, 5.10.x got the problem noticed, but other branches didn't:

https://lore.kernel.org/stable/2026020514-oat-plant-b273@gregkh/


> 
> Thanks,
> Hongbo
> 
>>
>>> by converting to
>>> BTRFS_PATH_AUTO_FREE, but we cannot backport this to 6.6 due to many
>>> dependencies. Instead, we choose to use a goto statement to avoid the
>>> memory leak in inline extents case.
>>>
>>> Fixes: f2dc6ab3a14c ("btrfs: send: check for inline extents in 
>>> range_is_hole_in_parent()")
>>
>> With the commit message fixed it looks good to me.
>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   fs/btrfs/send.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>> index 6768e2231d61..b107a33dfd4d 100644
>>> --- a/fs/btrfs/send.c
>>> +++ b/fs/btrfs/send.c
>>> @@ -6545,8 +6545,10 @@ static int range_is_hole_in_parent(struct 
>>> send_ctx *sctx,
>>>           extent_end = btrfs_file_extent_end(path);
>>>           if (extent_end <= start)
>>>               goto next;
>>> -        if (btrfs_file_extent_type(leaf, fi) == 
>>> BTRFS_FILE_EXTENT_INLINE)
>>> -            return 0;
>>> +        if (btrfs_file_extent_type(leaf, fi) == 
>>> BTRFS_FILE_EXTENT_INLINE) {
>>> +            ret = 0;
>>> +            goto out;
>>> +        }
>>>           if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
>>>               search_start = extent_end;
>>>               goto next;
>>
>>


