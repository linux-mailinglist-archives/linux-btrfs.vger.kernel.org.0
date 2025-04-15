Return-Path: <linux-btrfs+bounces-13022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21878A892A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 05:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528091897829
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 03:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D802192EB;
	Tue, 15 Apr 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GIOS62wk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDE1EE7BD
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744689025; cv=none; b=HPuOjnZacuXSNtJ2XUSdhVW5OFz+qFsRJFUAeDA/TD7IR8p3dbF8ADQpFpBs+viT94n7v9noWAeaKYD6/U2b2jj3InMelnUnwZCCuI9bGqqpCNqlne3Ao7Y40AWPT3+/IriKnX3wk5el+RATeQHqwZCkRut0/YxNP8cFYDDHhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744689025; c=relaxed/simple;
	bh=SdUj5+/nzv0F39Wj5DTjTZXfwhQjLyFRM2hjitzawqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMGde8tI8iVu0Pyp+/Uj9sD7B9Hzo5lnL8ZZGYufJoH9MoplZO1U2w+XWZD0oZ2WbL+vk8niG/YhM6hqJ6q34sg3i8i3zhRwU1z7du83FEpINtIoU9w9ccquQExYhb0Y1j2eEu6/o7gMcPcRlPIq8/HrIwN/9g7oRn8l75ElhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GIOS62wk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc1f6so4225955f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 20:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744689021; x=1745293821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WIAWlJCsgWYXdrGXvRPyrX6FxfdZq+/T8PflCz4FGfk=;
        b=GIOS62wkpzirSMFP53+HZsYpTQZQZUruB/zzaZNGS+7hbMhLJSt6pzO3FjrN5jQ4UV
         oUNmXWD69tH3pzq5RbpmOPdSh8gZ1q9Mv938l/kgqwQWNj+q3THXRVLO0nfvO+kVNGzm
         2K4In3y+n4dDA4TJpi9OlGuJSGBC49OijYkGFm56HZ+/W9YGCYrATmh5LZikDrHblsqf
         QUr472dF9IjrIH8+lkXl1AnKnBhhQ0FofpNdZhUvIQ+OYm1YDk1P4vQ2nyHrxjIaZVJ+
         DmeUHBYX8rRu3aYzXFB3dvEOIApDLJq0gAxAKDuuLkW6oUh0QKTdtjg0MLjZson+SWqr
         r08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744689021; x=1745293821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIAWlJCsgWYXdrGXvRPyrX6FxfdZq+/T8PflCz4FGfk=;
        b=iVBUd5WYgt9wjlPcxEWCzed4p/F9+KZT3qQGCoKEVinsE/5lcQdbeA2mUDNziAkwBF
         HS1NRxtOhpFk41Zl2iVUAy+Fh72+DMrd1p10DX/0zoqTws/RRL9+Rh47vZCAkYe+mbLF
         hXjM+6cPlz24p15YqyoiI38c3j8i9d2yKoeKZpdR9BHKKOfj8fsVmDlw2KiUpZB98G2u
         Dwri3pnDGvAAG5Ond62MAK5ZzbB7dHxNhJEVSPuqKwzhksW/gPOhIabKJq09Hrl9l+qX
         geR67VF4Q3ASYM0BAUIPFBuXT//HSGcUymjReC7zqbXZ7N51hMe5C/gRWPvDXVsr7pV/
         mz3g==
X-Forwarded-Encrypted: i=1; AJvYcCWs0GjlvXpCFdWko/zno8Ui+906ZNY3CS2bbXiDDwkvg7J9PFaSzASE+WUqjYQ2wf6j4w2/4lzewZDmMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62+0fqEs7YcvyJL60LyntNCx3yA3AvFiizWwIhEqGCz8FTARu
	NDaOm6QpiYVTh3FBllNomScCje0OR7MNRDC/qaCfiOeGAYPECkHSC+wa7nt57U8=
X-Gm-Gg: ASbGnctFn32/qeR2jy8RGbwbZ1mXFFP7eVBa3yhru/LqraY+bB9+cuLFE3aNIEE4+2O
	fGzlS63hzc3WSADPUHKPL3pk7q6g1+xKOyHehmKxjzXogyXLHAdxeh04nK2QmO3RpEjwZyGKCeJ
	ROSAb6v5C2lC1sgWMPm4fq1CAo01mFCjwIpkSo7b4nzr8xd3WRQ9L2YcRkRf3U7jN3ShqONmoLB
	XS/1ZnLEvJAMNyJOKPjfCkQi6TDdjCKjoucVrUQr9dFjpyhNHv47TkWLHx0urMud/kDQbDqHebl
	WwJmnsBKe8zBc+Us0jYIcZAZXK0PmoC7ToZKqSJ7qxfkx84/AybEpYKha5gcKBzAIVwnk9K+zxI
	e82g=
X-Google-Smtp-Source: AGHT+IFVa25BdX79BCFwclDmac3DYoFDzPGkDa1AUqdU62w+U2g5gFhFtlXnA29XLAKIuZE8k6ba9A==
X-Received: by 2002:a05:6000:144f:b0:39c:cc7:3c62 with SMTP id ffacd0b85a97d-39eaaecaddamr12746322f8f.51.1744689021420;
        Mon, 14 Apr 2025 20:50:21 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd12b4bdsm12134263a91.27.2025.04.14.20.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 20:50:20 -0700 (PDT)
Message-ID: <f6b92c77-d702-465b-a36a-93c42ecf59a8@suse.com>
Date: Tue, 15 Apr 2025 13:20:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
To: Daniel Vacek <neelx@suse.com>, dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
 <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
 <CAPjX3FfOJMFC8cXCqLa2yS1qSYmhu5cjV__+7xVRFGuKu=RqiA@mail.gmail.com>
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
In-Reply-To: <CAPjX3FfOJMFC8cXCqLa2yS1qSYmhu5cjV__+7xVRFGuKu=RqiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 16:23, Daniel Vacek 写道:
> On Wed, 2 Apr 2025 at 16:31, Daniel Vacek <neelx@suse.com> wrote:
[...]
>> I'd still opt for keeping full range and functionality including
>> negative levels using the plain `zstd:N` option and having the other
>> just as an additional alias (for maybe being a bit nicer to some
>> humans, but not a big deal really and a matter of preference).
>> Checking the official documentation, it still mentions "negative
>> compression levels" being the fast option.
>>
>> https://facebook.github.io/zstd/
>> https://facebook.github.io/zstd/zstd_manual.html
>>
>> The deprecation part looks like just some gossip. It looks more about
>> the cli tool api and we are defining a kernel mount api - perfectly
>> unrelated.
> 
> Any feedback, Dave? I tend to drop this ida of `zstd-fast` alias.

Not Dave here, but if the future of "zstd-fast" is not that clear, we 
can definitely wait for a while.

It's always safer to adapt when the terminology is mature enough.

Thanks,
Qu

> 
>>> We can make this change before 6.15 final so it's not in any released
>>> kernel and we don't have to deal with compatibility.

