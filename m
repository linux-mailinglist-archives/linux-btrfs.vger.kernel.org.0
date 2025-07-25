Return-Path: <linux-btrfs+bounces-15680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A63B1261A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 23:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B903A8AFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E425DB07;
	Fri, 25 Jul 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aM+ZQiCj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0C1096F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753478465; cv=none; b=CpFlXrGxittZBWC8daYmykMbrQbciNh0yUlDs4gqrr2LsVaY3IaFZVfD1cHI0leN3AHZO7NZnQZQ++608KtMIIS//1iXUoyLCL5u5sFKGcrfYTkEaZTR3m40EbATLLNYguHBy3rNRKDJ5UQtdFVQQxbIp5tixDvE2pXAQThH5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753478465; c=relaxed/simple;
	bh=JBKSixCoODueEyM+YV2zntBnddv87c5tIaxAbcE+C4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVsyo5/KV9LR0j8iawBEFXSSOL38T2a4HIfMIuX3Sa/Aa+q97ljVmtJ33T+dLStrMxXuA6jOps/BRvhZz4JprDTysnFVCJfPG4NPYo1Mou1OzXJTC/Yyt1sxMU1bT0G9aE94KPkDK+PhfolgI8LLtyQY/lMncAIn2RZ/W4gFgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aM+ZQiCj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1761026f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753478460; x=1754083260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fN9YSzgJW3lrs2p7p2U1RcIt3lt2kIHZS8q/WX2Mits=;
        b=aM+ZQiCjhbZ0PZGbfBAJhuiBIuqCc3zJ+Tp9lylS2kFzXMYCS0QfA3avVjpyQe/lxI
         sb2CVM2r2wO2jqRA1dsqKU82Jloe5Ojghju/3HRKHwXrrG/3LlK/7tTWCtdbQbo00jkc
         KNHMs77CanY1MG5bvaf1uwHO6EU7PUzlhZyyaFN3RRHNZ+5p2Tkoyh7rpZkcQUjbZdGt
         NIUqCjIw+VOErPeyKd2cxepwwxBaC9mRcOVmfzDW/nV/YvU2OP8r6vtC04bsOluaBO+1
         aN+nHFqzxqxXgl7uMshyoTU328f9tHYqbKDUOxU+HM/9WHJmCxeLDia404fQWZS4Lg89
         eaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753478460; x=1754083260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN9YSzgJW3lrs2p7p2U1RcIt3lt2kIHZS8q/WX2Mits=;
        b=J01VKMiCmFEYTmkmqrC5KVLIreItzolJXIGoCYR7k/UATNyNFXi6MzqnAPpLYufT04
         fz80uOl4mvFs5uRqZzeBnrAYUfnjlLGsZp5zmkc81F/flSk6h+uyZObHNWW9xC728sAY
         vYreKOCgCsYVvGuWd7sU8Pw9KPTPJOIgCvwix0TMTeZ93DVlENHBZIdo3rA4xQs13713
         O3HCnCCtgRnVJd3G/RhxCndQHUUYEr/whiEaweabrdOQcvGeVXQPMwu7M+BI7N3b7iXn
         3CiF2eXuM39CDY0WEsOhZzwNE/PlECVTgNBzrXhEdlBx/AWJP/h74bztccbo5P2F0pn9
         BFXg==
X-Gm-Message-State: AOJu0YxXPfKpzFL6svyC/XdcyEsA37J0G1qkW1odDolgzfU/MX9MAO5W
	4xC3L15CzEzqhpl/UtKK8kYXsKXaJJlHtQ/YPX5zfahjBtpz5sqcfOINPv421U7+oxTPpJ7Vh9+
	5LSBS
X-Gm-Gg: ASbGncuHvXO5jssMsm6lcv/aCDI3gfWOVbNIkYWoxXezGwopQu99b1h3gsagEqVUOyW
	9tY0GtZ1kM7qXgdZz7z4d17cwE5NQtCZpWO8gaMLHuvobcePNEgD4Gd9COMF27G7bwqAYmK+asV
	L9KyKue6PjDR9s7U/zIVU88+Btaj6j0AKycgW74G9LleDkDlEFbP4G3HMkLfacLy4pvocicW78B
	IHgKps9eqOS8z8QAOVLQQ1qtOAYWL607WTpFhBqGcn2VvWyxQuUXYTlNG29Fb8OFn6Mg3rJq1c9
	59lGWXjjzFvxJ+o3S0qzZqHcwDc4y4B3oRwD7E5BIUQ8zjpHcusvvCFQf2hz2f9HdAqGCivn3g9
	KTlKa3vnKXbbUnxTYYQ1dJAPwdDv2F7zndqpTy/uIB02FjkIhM6E8WqUNy/lD
X-Google-Smtp-Source: AGHT+IEGvnVUhFDfZa4uhDZxvNZZrOul41elb98zriehmUgM8q/U0fY0spCllSa0lQdOWd1WLzb8vg==
X-Received: by 2002:a05:6000:2901:b0:3b6:936:92fa with SMTP id ffacd0b85a97d-3b77678b2a3mr2589438f8f.52.1753478457999;
        Fri, 25 Jul 2025 14:20:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863506dsm413211b3a.18.2025.07.25.14.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 14:20:57 -0700 (PDT)
Message-ID: <b4ce5d39-5ef3-4b33-bf45-8841c28a75e3@suse.com>
Date: Sat, 26 Jul 2025 06:50:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: make nocow_one_range() to do cleanup on error
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1753269601.git.wqu@suse.com>
 <b851a5b50ae3f291fdb40818b3342b58f199f82d.1753269601.git.wqu@suse.com>
 <20250725183739.GC1649496@zen.localdomain>
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
In-Reply-To: <20250725183739.GC1649496@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/26 04:07, Boris Burkov 写道:
> On Wed, Jul 23, 2025 at 08:51:23PM +0930, Qu Wenruo wrote:
[...]
>> @@ -2291,6 +2298,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>>   	 */
>>   	if (cow_end)
>>   		cur_offset = cow_end + 1;
> 
> The cow_end case has a comment explaining how cow_file_range does the
> cleanup. Now that you made nocow_one_range match cow_file_range, can you
> update the comment(s) to make that clear? I think the logic is the same
> so one shared comment (rather than a separate one for this else-if
> should do.

Sure.

> 
> I also wonder if some of the descriptions of the 3 cases still make
> perfect sense. What ordered extent are we ever finishing in case 1,

The case 1 is a little more complex.

It implies have ordered extents created before our @cur_offset, but 
without new @cow_start.

E.g. we created one cow OE and updated @cur_offset. Then before we are 
able to determine if we can do NOCOW or not, some error happened and we 
have to error out.

In that case, we hit case 1.

But to be honest, I'd prefer to merge case 1 with case 2, so that we can 
focus on the range [start, @cur_offset) only.

1.1) @cow_start not set.
      Then [start, cur_offset) is purely some range covered by new OE.

1.2) @cow_start set
      Then [start, cow_start) is new OE.
      [cow_start, cur_offset) has not been touched.

But the problem is, @cur_offset is touched too many times during error 
handling.

Maybe it's time to get rid of the @cur_offset modification during error 
handling?

Thanks,
Qu

> if nocow_one_range already did it, for example?
> 
>> +	else if (nocow_end)
>> +		cur_offset = nocow_end + 1;
>>   
>>   	/*
>>   	 * We need to lock the extent here because we're clearing DELALLOC and
>> -- 
>> 2.50.0
>>


