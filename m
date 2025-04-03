Return-Path: <linux-btrfs+bounces-12781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CFFA7B199
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 23:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB3E18853DD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B11632C8;
	Thu,  3 Apr 2025 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CMhbgLx0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781902E62DA
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716744; cv=none; b=mVhyjQffB/HlKiwyMEdyQcoyhxDen7QkEO0WogYWDB9P/ydtSRkBrMg3dT/ZMf9BWKOkK+ltkfUgpWQQiJbbRUBYJfgY8W5EsVjre6LbKpFCXgcuqijLsCVE0dao81cdX5gPPpasxm/uaUhKTqU5Z3rv75Cyb6xenw/WXMND53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716744; c=relaxed/simple;
	bh=azGN5GepWvFzERcitzOxA2682TBgON7Li4nw9m0I1NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDahZ7U8BU63nsyK7O7tZFjS/6xn6d5bDd0owfOSjPoDFxfNX/Mtu4DYFulU2CnzWk22664rFmPrswwnvZzQMiHAeUheQNeewXnl0peX5wyjrY/0j9Hr0WyAmprroZBj1TnDo/V22mmjDN+BWh13Lzoj3Uw6Nb2X85U7vYNxHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CMhbgLx0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394036c0efso9905565e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Apr 2025 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743716740; x=1744321540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUFFuWFDrRv361fgddpu7QYneU7Y4HaZaGUy1mElJS0=;
        b=CMhbgLx0MGSrKnb6Cx8VqAh16o99DtftQkupinAokQKxk3vAs+2Ir39KoqZ5ZhHGWY
         oP8aonlJecw2PZcjj3Z+QtaxNuQLfDMicNMorsaTvqjjJo+1grNP5fXx90AWcd720XLP
         FLBe4sE8Zwe0gBCsJTrcaLiYDjUahwKD6ZfixdhQiMqgIifmti0Rufr1PW7VBiRmnkAC
         9jAapYaQdJs3A/0qSrb19A0j90hC84v04rmgRuZPFPdzCVobYBgAowVmENTn3KlmYfhi
         02Ct+W+rewATRjR+i64uup/bxvsgpqpOBQUo5t7hH2/8nP4UVGEwh5VHTI778xQsQenL
         ixfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716740; x=1744321540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUFFuWFDrRv361fgddpu7QYneU7Y4HaZaGUy1mElJS0=;
        b=qbNJUEyoRSmHNozez7ipOSN7kglK744RNjHErT9pZIQzL9y4W5MKHAdzYVBQf8zAfa
         swuij1bAKcguGzfncGV6QT/PEsPg49erKzEkZ55yvjRnyaAL8Wtss6FeQcyi15rd1/8u
         4zFcb9w3im6OlOOseBakT8D93V5eLLkqCVa/e7BkIJPzvQrz3xHYajxMay1vQuOlFvTa
         UU/iQdW/C444aDMuZzlc3szilomQggFaF3WUQeDPTs27XL+5M1LRUm04pECFT6/Yvbdp
         FnuvVq0H0PiCdcgN3CV0H0LE8hk9q4ZHs7VK+jSB4cRLx8LakMoy1YlsvWZUwqSZeRc6
         doYA==
X-Gm-Message-State: AOJu0Yy9E+Wkczmov0+px7zqMFeOLHe7Jbinn+xMGj2EI9KpU3cyXqbp
	o9CjElRp5GDoOobcUylqSN86tsl7zbbTYtzIkQ717ns6xI3pRq7Kvv1SSKu1AH4=
X-Gm-Gg: ASbGncumA22m9fWNtxVrmzB2+czUlEBQa2FTFVh23IhzoQMggkr1xyNvqOdqbFu/EST
	sHgAN1DwW+pmQfXK2X0BRie3gytARDf3tdNJGDfCNzVi9L9AyhCLnba33JH6YTMwbCCY7IMUIlS
	ocH7E2Rn0waz1gcKjKxWNEURMnbMyCf4nRW3fiknLM1Xkzc6nEaYJSoyW1/n2HgeBb1fO/0o0Gc
	+oCGj3ZzIOqpRYT3EnCkZ12XORVcCLLTMjT3HRHeT4uxWSHkk3jIiU3hnXjW6oYmKbDaXpe9mEJ
	lrF3Y69W78EbStM13wvO4NY8yv3ANkz0bj5AYoSsR8p+9jz5voPhmf+Zq6WiYfygJ5fTFC9g
X-Google-Smtp-Source: AGHT+IEvWbDuK+v9w4MjJZnCoBsFyTAnOYbAzMBqS8V4AO/Jm0NG6CIqUv9gqIzMUqp6hcauAz3g/w==
X-Received: by 2002:a05:6000:220d:b0:39c:1159:fe1f with SMTP id ffacd0b85a97d-39d0de3b27amr256731f8f.32.1743716739443;
        Thu, 03 Apr 2025 14:45:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787778bcsm19448575ad.257.2025.04.03.14.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 14:45:38 -0700 (PDT)
Message-ID: <f053eeef-4bfc-492a-8724-5ae15aa478e8@suse.com>
Date: Fri, 4 Apr 2025 08:15:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and
 folio_test_large()
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1742195085.git.wqu@suse.com>
 <20250317135502.GW32661@twin.jikos.cz> <20250317151312.GZ32661@twin.jikos.cz>
 <e9b76101-d14b-43ed-bd9c-97a5978f4d59@gmx.com>
 <20250403195427.GT32661@twin.jikos.cz>
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
In-Reply-To: <20250403195427.GT32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 06:24, David Sterba 写道:
> On Mon, Mar 31, 2025 at 03:17:35PM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2025/3/18 01:43, David Sterba 写道:
>>> On Mon, Mar 17, 2025 at 02:55:02PM +0100, David Sterba wrote:
>>>> On Mon, Mar 17, 2025 at 05:40:45PM +1030, Qu Wenruo wrote:
>>>>> [CHANGELOG]
>>>>> v3:
>>>>> - Prepare btrfs_end_repair_bio() to support larger folios
>>>>>     Unfortunately folio_iter structure is way too large compared to
>>>>>     bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
>>>>>     folio_iter.
>>>>>
>>>>>     Thankfully it's not that complex to grab the folio from a bio_vec.
>>>>>
>>>>> - Add a new patch to prepare defrag for larger data folios
>>>>
>>>> I was not expecting v3 as the series was in for-next so I did some edits
>>> [...]
>>>
>>> Scratch that, this is not the same series.
>>>
>>
>> BTW, any extra commends needs to be addressed? (E.g. should I merge them
>> all into a single patch?)
> 
> I think the patch separation is good, please leave it as it is.
> 
>> I notice several small comment conflicts ("larger folio -> large
>> folio"), but is very easy to resolve (local branch updated).
>>
>> There is a newer series that is already mostly reviewed:
>>
>> https://lore.kernel.org/linux-btrfs/cover.1743239672.git.wqu@suse.com/
>>
>> That relies on this series, and I'm already doing some basic (fsstress
>> runs) large folio tests now.
>>
>> So I'm wondering can I push the series now, or should I continue waiting
>> for extra reviews?
> 
> Please add it to for-next. I did only a light review, we'll find more
> things during testing.

Thanks, but it looks like the read repair and defrag part (the last two 
patches) should be delayed a little.

I'll push the first 7 safe ASSERT() removals into for-next first.


As I finally fixed the last bug exposed by fsstress runs, I can continue 
with fstests runs.

Instead of the untested defrag and read-repair patches, I can do proper 
test and fix (since the read-repair one seems to cause bugs during my 
local tests) bugs in them.

Thanks,
Qu


