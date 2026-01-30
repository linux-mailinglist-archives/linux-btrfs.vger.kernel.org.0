Return-Path: <linux-btrfs+bounces-21253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNCrLusxfWntQgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21253-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 23:34:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A9BF255
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 23:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72CE7300BC57
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1F438A29C;
	Fri, 30 Jan 2026 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZIyZKaml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB22DE703
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812452; cv=none; b=m/IqcGPJxdNwz+mUu0iGf0knWmuG63sdHNlJzWCiR+zN8X233VbZbG9hFeni1qR8/HDn8jBWwFQOLA57o0zLKuUv/Xr1BWFHq2xdVIUXLxKMBYx2qLUB6IE5g4SgFy+m4fzkxB7EHty4mAmoUExzTaj3FvTA8uk7J6iuqe13U0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812452; c=relaxed/simple;
	bh=ppshadGWR0gbbonUwLpZH9BmQVn2IskfWtWCpIOBk48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MulfU9IFs5g3Ax7JCEUs6o7ztuM9STlcqb4gLDxXdfBNeGFtnJQT91TIU+R6jIFtypU5xxwsp6rtR6pmA2BwEaduJ9x7+TvlBTFaUiDRG1bCxpuVY4twZnxyNDAahmTsG5OGGDbFuhsy9Wcrt21jfUkSutiDX6bvgKsVbSrEKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZIyZKaml; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee0291921so23875885e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 14:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769812449; x=1770417249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HN5B/zXS6qT/pwBiow2+oKV7CY8LkH6ofLWDs+WOzYk=;
        b=ZIyZKamlVS/dWTOh6thLDBktbOIlNwLB8pTbAifagbQL5aNtCuriYZS+L/F7RQFoiD
         2McqNU2yeSIWowSFcbeFhpJLpNFxZr3yyoq8hqFVI2IM6wEzPBJ3DgGfOv5bVT76Glkb
         KJ5wOMIzU/E0FdMnEmtseN14EukacWPpIxm3qxTeErFwuChhH9wZ7Qt6qAQ9vet8V754
         LZOfaHr7bSl+17sFWURqRXerjetWH1m7aEzsbQMGJq56Pfe92TpchhhdlE1e3d2irCrl
         8Y7wHkLGl7ZsDe8sdt4JQnfn/PIDfzjc72lnwBaY3uR9ewqBkv7fE1UWL8i4q8ofC0MJ
         fsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812449; x=1770417249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HN5B/zXS6qT/pwBiow2+oKV7CY8LkH6ofLWDs+WOzYk=;
        b=iNpyXWw9D0oedCfrgVD9IgiNRsoGSVu97bew6WNY6htDut8ph3jNlWaM+gvlUA8L/+
         iqJfXoZBXFfiOsrSZsIke0xS203h9Amw/PmqxXW59LVHMbTZ6vmUZ1NTCwrbR98nkQ5p
         vjAeHsAdMvNg5M1WoXPecQVJVNNjEIQHcq/RMfMVMeTvFKNlh6iQ6rM6W1dYYKQsE8Vo
         BVXrmUI9E5Nh5IquV+BRp68GZNCGggR79UxYZU3Dhpw8mFsfjvnkDx6/4VQ1NYIP/Lth
         4IJT/6tSRkWoz4J4vRqOwoW7q84mE5N9fCsqd/JnliE4jsuQ6zNykTv0KWG1aOUdtI2E
         vnmw==
X-Gm-Message-State: AOJu0YxvkD96NLjLrQhH3DUQyEMMwG+zX6ir2YJpUGBYphe6uc4xqsdT
	LycRy+Dff3wBhu4uqBF+W/lM7fyXGbIs5vN7gH0ATh7sFy+d3cWjr4igkQm+EoRY+iM=
X-Gm-Gg: AZuq6aIRl+46lfFz7mAKu0ZxzO07y5vBgbTmN2hC5Z+2kpKJCfEZGEn8eFRduXA7kaf
	XKpcUHiTGFrxUaxaS5qHs/0RYhQneroMZDBx5gEbMnLvWKp5k3j4765Ky3c+16XoJIRF6l2K9tV
	L4qKTVN+NuHsz7/hIKGQZQNjcb0GhyeG+Tgh3J6aliGQ2bxZeXhvHgWQcqE77errlNCYeBGEf4o
	Rak54TPWnpSzGcxiTMhv8YsAseTdlyRDuILJ8PUYyjKsfBHNjDDO7mNcNk/gD3NQWS9SoS+LK9u
	xqkcTykGKNodXdNyEOLbUgHBr5OgF9nfKf3MVI7c/+WapDSPyjFYQg4tG+BvHa2q47XECswGv2w
	IkYRFX+gy2IStlDTWxWDKtaxC2e6sl2x21VoDPZU38dBT+FSCqw1MCLpeCw6UJjZn8PHIQtiyGf
	AlGIDKZtUYrlyx4huN6M1dGcGKod7eOHC0/dxyoqo=
X-Received: by 2002:a05:600c:8b26:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-482db4e5cb1mr50091115e9.27.1769812448904;
        Fri, 30 Jan 2026 14:34:08 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bff93esm10668275b3a.41.2026.01.30.14.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 14:34:08 -0800 (PST)
Message-ID: <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
Date: Sat, 31 Jan 2026 09:04:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Leo Martins <loemra.dev@gmail.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20260130214319.3714908-1-loemra.dev@gmail.com>
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
In-Reply-To: <20260130214319.3714908-1-loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21253-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E23A9BF255
X-Rspamd-Action: no action



在 2026/1/31 08:13, Leo Martins 写道:
> On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> 
[...]
> 
>>
>> This was before a recent refactoring of should_cow_block(), but you
>> should get the ideia.
>> IIRC all fstests were passing back then, except for one or two which I
>> never spent time debugging.
>>
>> And as that attempt was before the tree checker existed, we would need
>> to make sure we don't change and eb while the tree checker is
>> verifying it - making sure the tree checker read locks the eb should
>> be enough.

That may still be racy not just to tree-checker, but with the extent 
buffer writeback path.

Even we locked the eb for tree-checker, but someone still modified the 
the eb after tree-checker but before submission, it can still be very 
problematic.

Or we have to block all future writers until the eb is fully written 
back, which may slow down the whole fs.

>>
>> There's also one problem with this idea: it won't work for zoned
>> devices as writes are sequential and we can't write twice to the same
>> location without doing the zone reset thing which only happens around
>> transaction commit time IIRC.

That's also the same concern I have, meaning having to again divide 
zoned and non-zoned metadata routine.

Although before all the new ideas/attempts, I'm wondering the following 
two points:

- With the AS_KERNEL_FILE flag, how frequent we're re-dirtying COWed ebs
   We need extra benchmarks on this first.

- Is there any pattern of the re-dirtying COWed ebs
   E.g. which trees are re-drity the most frequently? Extent or csum or
   log trees?

   Can we take advantage of such patterns if they exist?

- Is there any less invasive alternatives to changing COW basics?
   E.g. Changing btree_writepages() to utilize some LRU so only the
   oldest/least frequent accessed dirty ebs are written back first.

Thanks,
Qu

>>
>> Thanks.
>>
>>>
>>> Please let me know if you see any issues with this approach or
>>> if you can think of a better method.
>>>
>>> Thanks,
>>> Leo

