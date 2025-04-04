Return-Path: <linux-btrfs+bounces-12810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA913A7C61D
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5713BCA18
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632731A7AF7;
	Fri,  4 Apr 2025 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZfcRRGYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695213CA9C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804043; cv=none; b=eUqD1zLjj+21RZmsKRQ53e4q8//hvA3bHW74AUi4+Qweixfzmepiu9/shxO5mevnThtEpiMDi8VeVy9jOuupvNycgDqECcTlDQs5yVrV72KXyE6yTz8Z5WkgfehdDhSeAtgJM84SK7ZM8IyNp/c966Ni2Sv/zSFaG2UkGMWYHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804043; c=relaxed/simple;
	bh=YPSFRfiwWxwsbzSt4cQQYEc9fycwXGq/DFmpegb0vZI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sbfyimRHEPfGCQDLnBV38EF3LFA2K1TZtTY37re96R3fPdSFLAH8z9hOpV2oegzRspj3ggv+O9WOVnCD4pNOQuwkZIHkX7vSWMtl5GMFaQ0GEJvwSv1MXBvFWKZv5CRwOjFU6Eqq/x+NiA/T6GehGs1zD7QaCI9z+XVlU/aeNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZfcRRGYm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1959451f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743804039; x=1744408839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5RZqEqD/uDWLym9vnMaP3cNT3GGfFNnYFVBpkUdKbA=;
        b=ZfcRRGYm7YhRsLzWun/5DmqQS/vloTucK3Z0HjjOk5pIfPrn605tLbURzWV7XbMZ7z
         r/3z7bI/SDGFVeVQ4krg/kyRH0a28KOyqL+dVnnvO9K8V6zdlQ/j4JqGLXhicIJNPTD/
         zjKxEBLTcnjy/HjOXjhMcF7UsPduJlxtS/w8RQhnDMM5EtdhABL60DTyH5ZEN+GU9OUY
         Nh4EHK7bgmAN33+iUSNodzDtuJr5sHmChgtygnUvYmWwwYOvBXGod/rHT3ghQILg1MFk
         hKYYWtTkGSSzX0mvI+peyZCck1z5xg1YIMUIr2kIiKd6BFIkZJHLgHtPxRb9zj+d5SBO
         Nj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804039; x=1744408839;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5RZqEqD/uDWLym9vnMaP3cNT3GGfFNnYFVBpkUdKbA=;
        b=Lb1z0x6CVsQbv2yckd/59oHlBun0wonsNVthBoaDCwqacTQKDhiOFnUtl52vOPPoRq
         YobvkAfcuontDmWiGcuegoLM+c+gVnTCyCI3WjItfYYSPjsixA7oH1JmRr4DUgh6Tr8A
         VAvX3RujZjpODXOLY3T9Lx3Hpkws+c43AZ3MKiN4JHQ2mMB/ukWC0TFKTZcsccmFaQ8+
         v2i1VvsJm94f8VrQepdtFUfABqG2PBLWRoVN8xmsGXHETTUqY75I8bhCi7wQ6XnRUFgZ
         1Cjvw6Td3bX5x7PThtMbECWVJ+9uJ0bHIww/h7SB/805IM6YGoUutb4BN/LIlB3eR20a
         CuGg==
X-Gm-Message-State: AOJu0YxxktO/krZC9LawUEfSrOTn7gYBGLSeHWIGCmp7pXQ/v9U8Ains
	cLsK1FoVvm8McBI4iQ7g7UtjvWbdzzVUd8HMD2v2DJv5aaU49gfW4xRGBaDUSkQSTJ+vOWqi6bi
	D
X-Gm-Gg: ASbGnctIH9CZI/rmARD2h433mLvigjJr/UJj7O46c2yVKvE6sfi2lo2/0uoJWe5Vwr+
	wIouIFrIdHiZhdD9G311aQRbRvOAn83JMyhZGd02tvYsMYQcqwOj2fH91kw9dsCA9FqjZ0/Dqg0
	Eeo4H0ZB6AD7FJ+/qOMqJZPpC0zWuEtyKsHySZuuqB/hHSt47/kUDge4rWjqhV2EHrotJBRzrkR
	l5F059pRQlj+oeinnI4NlxQvX8jvPJHXdIH0Cf07Yt4+yp29nUEx4PQrPr3YvARvdHeK0vM4Bsn
	iRSzz0Z9cYQjg6cyHkST7I4bLLB+yLXbmb5RnTy2HWMOjtMXTN7s70CBwLZAfi8Ih4VcVHPr
X-Google-Smtp-Source: AGHT+IFXmTgd/MQeZNB/cvH3s5j6M14ZWMT/PhdMRPvgLFJQYf979PwK2kxAnLA728MR0bDYzDn9vw==
X-Received: by 2002:a05:6000:4022:b0:39c:140b:feec with SMTP id ffacd0b85a97d-39cb36b28b5mr4234338f8f.7.1743804039298;
        Fri, 04 Apr 2025 15:00:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01c2sm37682425ad.75.2025.04.04.15.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 15:00:38 -0700 (PDT)
Message-ID: <da29597d-001c-41fd-b0ca-5e34449d2459@suse.com>
Date: Sat, 5 Apr 2025 08:30:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: get rid of filemap_get_folios_contig() calls
From: Qu Wenruo <wqu@suse.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
 <CAL3q7H4AZZtCe6FXwAwaoKL7JNtnoLfu3BimKQ1KRZUNuezkwQ@mail.gmail.com>
 <caa57242-1971-46f9-a2f9-dceb19ab7b4f@suse.com>
Content-Language: en-US
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
In-Reply-To: <caa57242-1971-46f9-a2f9-dceb19ab7b4f@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/5 08:21, Qu Wenruo 写道:
> 
> 
> 在 2025/4/5 03:08, Filipe Manana 写道:
>> On Fri, Apr 4, 2025 at 2:48 AM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> With large folios, filemap_get_folios_contig() can return duplicated
>>> folios, for example:
>>>
>>>          704K                     768K                             1M
>>>          |<-- 64K sized folio --->|<------- 256K sized folio ----->|
>>>                                |          |
>>>                                764K       800K
>>>
>>> If we call lock_delalloc_folios() with range [762K, 800K) on above
>>> layout with locked folio at 704K, we will hit the following sequence:
>>>
>>> 1. filemap_get_folios_contig() returned 1 for range [764K, 768K)
>>>     As this is a folio boundary.
>>>
>>>     The returned folio will be folio at 704K.
>>>
>>>     Since the folio is already locked, we will not lock the folio.
>>>
>>> 2. filemap_get_folios_contig() returned 8 for range [768K, 800K)
>>>     All the entries are the same folio at 768K.
>>>
>>> 3. We lock folio 768K for the slot 0 of the fbatch
>>>
>>> 4. We lock folio 768K for the slot 1 of the fbatch
>>>     We deadlock, as we have already locked the same folio at step 3.
>>>
>>> The filemap_get_folios_contig() behavior is definitely not ideal, but on
>>> the other hand, we do not really need the filemap_get_folios_contig()
>>> call either.
>>>
>>> The current filemap_get_folios() is already good enough, and we require
>>> no strong contiguous requirement either, we only need the returned 
>>> folios
>>> contiguous at file map level (aka, their folio file offsets are 
>>> contiguous).
>>
>> This paragraph is confusing.
>> This says filemap_get_folios() provides contiguous results in the
>> sense that the file offset of each folio is greater than the previous
>> ones (the folios in the batch are ordered by file offsets).
>> But then what is the kind of contiguous results that
>> filemap_get_folios_contig() provides? How different is it? Is it that
>> the batch doesn't get "holes" - i.e. a folio's start always matches
>> the end of the previous one +1?
> 
>  From my understanding, filemap_get_folios_contig() returns physically 
> contiguous pages/folios.
> 
> And the hole handling is always the caller's responsibility, no matter 
> if it's the _contig() version or not.
> 
> Thus for filemap_get_folios_contig(), and the above two large folios 
> cases, as long as the two large folios are not physically contiguous, 
> the call returns the first folio, then the next call it returns the next 
> folio.
> 
> Not returning both in one go, and this behavior is not that useful to us 
> either.

My bad, I should double check the code before commenting on this.

It turns out it's not really splitting the result based on physical 
addresses, but purely returning to the end of a large folio.
Which is another thing we do not really want in btrfs' code.

So the contiguous part really seems to be the following points:

- There should always be a folio at the start index
   Or it will return 0 immediately

- No holes in the returned fbatch
   Although it can still return the result early, due to large folios.

Anyway I'll add these to the next version of the commit message, to 
explain the behavior in details and why it's safe we go the regular 
filemap_get_folios() call.

Thanks,
Qu

> 
> 
> And talking about holes, due to the _contig() behavior itself, if we hit 
> a hole the function will definitely return, but between different calls 
> caller should check the folio's position between calls, to make sure no 
> holes is between two filemap_get_folios_contig() calls.
> 
> Of course, no caller is really doing that, thus another reason why we do 
> not need the filemap_get_folios_contig() call.
> 
> Thanks,
> Qu>
>>>
>>> So get rid of the cursed filemap_get_folios_contig() and use regular
>>> filemap_get_folios() instead, this will fix the above deadlock for large
>>> folios.
>>
>> I think it's worth adding in this changelog that it is known that
>> filemap_get_folios_contig() has a bug and there's a pending fix for
>> it, adding links to the thread you started and the respective fix:
>>
>> https://lore.kernel.org/linux-btrfs/b714e4de-2583-4035- 
>> b829-72cfb5eb6fc6@gmx.com/
>> https://lore.kernel.org/linux-btrfs/Z-8s1-kiIDkzgRbc@fedora/
>>
>> Anyway, it seems good, so with those small changes:
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>
>> Thanks.
>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c             | 6 ++----
>>>   fs/btrfs/tests/extent-io-tests.c | 3 +--
>>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index f0d51f6ed951..986bda2eff1c 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -207,8 +207,7 @@ static void __process_folios_contig(struct 
>>> address_space *mapping,
>>>          while (index <= end_index) {
>>>                  int found_folios;
>>>
>>> -               found_folios = filemap_get_folios_contig(mapping, 
>>> &index,
>>> -                               end_index, &fbatch);
>>> +               found_folios = filemap_get_folios(mapping, &index, 
>>> end_index, &fbatch);
>>>                  for (i = 0; i < found_folios; i++) {
>>>                          struct folio *folio = fbatch.folios[i];
>>>
>>> @@ -245,8 +244,7 @@ static noinline int lock_delalloc_folios(struct 
>>> inode *inode,
>>>          while (index <= end_index) {
>>>                  unsigned int found_folios, i;
>>>
>>> -               found_folios = filemap_get_folios_contig(mapping, 
>>> &index,
>>> -                               end_index, &fbatch);
>>> +               found_folios = filemap_get_folios(mapping, &index, 
>>> end_index, &fbatch);
>>>                  if (found_folios == 0)
>>>                          goto out;
>>>
>>> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/ 
>>> extent-io-tests.c
>>> index 74aca7180a5a..e762eca8a99f 100644
>>> --- a/fs/btrfs/tests/extent-io-tests.c
>>> +++ b/fs/btrfs/tests/extent-io-tests.c
>>> @@ -32,8 +32,7 @@ static noinline int process_page_range(struct inode 
>>> *inode, u64 start, u64 end,
>>>          folio_batch_init(&fbatch);
>>>
>>>          while (index <= end_index) {
>>> -               ret = filemap_get_folios_contig(inode->i_mapping, 
>>> &index,
>>> -                               end_index, &fbatch);
>>> +               ret = filemap_get_folios(inode->i_mapping, &index, 
>>> end_index, &fbatch);
>>>                  for (i = 0; i < ret; i++) {
>>>                          struct folio *folio = fbatch.folios[i];
>>>
>>> -- 
>>> 2.49.0
>>>
>>>
> 
> 


