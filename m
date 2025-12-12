Return-Path: <linux-btrfs+bounces-19682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909DCB7B98
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 04:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC0A302533F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D52580D7;
	Fri, 12 Dec 2025 03:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T7HinfJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F021ABD0
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765508970; cv=none; b=u2mCxT6iG+4zgiPHXCq3kzH2gbuoQnlg4qdFiKF2LLf2sYlynnra6r1vpIoZUXK1VsAWv7CzDjM1Z7sIOT7v1xwog16iOJfa1ji8B1kFj6B9efd4ObeCX5eClKG7ukS7aCeAtddM3Xxm3PItlXretjgdnx659p2+V0mgZpqR3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765508970; c=relaxed/simple;
	bh=UAbscXjOybijOBktK8hVQyuCMBEp+JYujeegAo6+F68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA1o0vXGRJbI1xg4vGnGAq/vvTrDjzrDDBcFvsvMWOluC52TWiH9h409kmc6vNl1/UZsOCWaxsNJ3g2l0gJCnV8EFatl6zBPikUR9P6Imi8SBJiCIsxQFZa/oCifosM5xM1RoPdF607Ek3ywe9rL4P6LM+2i5BvrwQzCdRF0dLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T7HinfJS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso4859535e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 19:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765508967; x=1766113767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jj5zYw7P0oX9QS/0hCFZBTR+6K2TxqVH9H1iHyzA2KE=;
        b=T7HinfJS9APkRSj1lDe20KhRUoVVDkiZL/MtIG5nHuapwR5Wji+u64jR+S9GQ68oQ3
         5n2RLd3/iSC2SdD2px6CI6kf4ql4H7CZ4lUiLyHfR16xx7rCbHvfni2+NG+RckdmzKVC
         2+Xm0AjyIoe6Xalys4TGVUuLC0DRwebDLFyGrjBPb34thOxhCDKOoUn1EdrkpZ/DUDW3
         QBfwIJx2x0sfvs3zMWIabpK6fAgjb0hhE+VbKZAKUwYj1hOL5M0yBAESpBE1qPLBsZrh
         q+8JL/l/30IsGtyLLKSKtZmg5tYvf/VoLib3Bu7U6y6N7ZLpqUAVsrG8W2FX5Q81Fdfg
         5uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765508967; x=1766113767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj5zYw7P0oX9QS/0hCFZBTR+6K2TxqVH9H1iHyzA2KE=;
        b=s2w8rPBgJOvL6bDTWUuvDYOdeCNq2OCsO+h4V/y4wA14uTpWBYkYuz8GcQpRKzrbXd
         1byUNb2OCwetmSqzFZnf3PhwsFH0CIoLWQyqTX7/pK4/uoOOMuRusExQU7Mj9E9tahIP
         sRxJf39oQnqSGHnS36afD5Gsz5XGR+6pc7WW4/Pm4+d5hHZ1KsQZ9oH596Z/8cx4Prz2
         Xxoaomu925D/h2rmYv/RntGwTuf6XMxSfNmv4Jut36FGV7bfhIE27vax3vTDt1fX5lWd
         SWW2VpVaV81YwFOlIrG0pOVuzM3LFHDh1XCV0pTpPoADwzeo2RniX3M+9lL2x+eVaOFI
         IOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXn/5vH1CcTZB5oMS0lUwfoCF0HuACBJ7sWnX3gPAOi1Wdf8kG6kZIbe4ZZzXBPk3I05sEO6UvJWk3tsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyppnVXJIVlIEDZHRAqr9M7vGyH6Sm6h2jH3Xgw+/gSxzRQcvP
	4ZGW8W54QcRE00//NiN+5wmr2eu9dllNh6CG78pzrmpyjoa51lFmrJJiCqxAbPucRnE=
X-Gm-Gg: AY/fxX7x2aaTNePlI5bsskNGrQb7bBLedOJfzbudK5AR1GZLlx7LminxUdFL/VT3W2y
	gS/EKkILyfLr5R2v8I+WW2LWdFESf/00maVTI/SORxJhldPO3OStcEtwfUsh4mJFnIeu4gNFWJv
	NCX6l2CWhMWtNxuvGiOFpFz6xUt3s5Kx/plLmATG+ZxQwBmlcosaAxJ++Vk6JTmWuIW4dNQWG60
	zwXT8vv7T2JNXYt2B/aVvYe7i8GxJt2kutC3Ooz36KZMNSVejMhAgIftVutKL6770yGSeOC3UXb
	nEPz2Q/2SGGWhDLuZG7ckJBZSGluYGhnlnbzZoifaoxxsU3gf8Lk1Wu5RJiP3ucs1N9n5/YPYeO
	HKO8obd5TwYkyZ2MRlMx1rzZ/tBbkm6PStvIef4EbdxjzrD3MnTKWEBGk5rkX8ioDd9lhL58fR8
	iI2RWoUq+7IDb7J0RDn6Q5fmbNnJh0P1cd7Bmkc4o=
X-Google-Smtp-Source: AGHT+IHJ0vB8GSL5MVmGw4MonjvPS92mfqKmgZf3GXE3W6qVuBmFCX/0aSwJh/vVhz4beNK4PUwgKg==
X-Received: by 2002:a05:600c:608d:b0:477:632a:fd67 with SMTP id 5b1f17b1804b1-47a8f8c16bfmr4314055e9.12.1765508966606;
        Thu, 11 Dec 2025 19:09:26 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c566b3cesm3701873b3a.68.2025.12.11.19.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 19:09:26 -0800 (PST)
Message-ID: <a8a5741f-7124-4204-b1aa-93782dd4b78f@suse.com>
Date: Fri, 12 Dec 2025 13:39:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: fix memory leak when add_qgroup_item()
 fails
To: dsterba@suse.cz, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
References: <20251212005224.3565337-1-kartikey406@gmail.com>
 <20251212030357.GO4859@twin.jikos.cz>
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
In-Reply-To: <20251212030357.GO4859@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/12 13:33, David Sterba 写道:
> On Fri, Dec 12, 2025 at 06:22:24AM +0530, Deepanshu Kartikey wrote:
>> If add_qgroup_item() fails, we jump to the out label without freeing the
>> preallocated qgroup structure. This causes a memory leak and triggers
>> the ASSERT(prealloc == NULL) assertion.
>>
>> Fix this by freeing prealloc and setting it to NULL before jumping to
>> the out label when add_qgroup_item() fails.
>>
>> Reported-by: syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=803e4cb8245b52928347
>> Fixes: 8d54518b5e52 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage")

And that's the wrong commit, at that commit things are still correct and 
no leakage.

>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> Thanks for the fix, this has been fixed in a different way by commit
> https://github.com/btrfs/linux/commit/b95d1588dd2395d0fa1cd3ecf368b2dcec5445ff
> and there were more problems than the one you fixed.
> 
> You're probably using master branch where this code is still broken so
> the fix is present only in the development for-next branch. It's been in
> linux-next.git though so you may want to check there first before
> sending fixes.


