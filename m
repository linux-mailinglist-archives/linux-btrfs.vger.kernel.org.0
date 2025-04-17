Return-Path: <linux-btrfs+bounces-13151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C204FA92E6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 01:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304BF1B617A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429D22256E;
	Thu, 17 Apr 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eErxZBTY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF962206A9
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744933296; cv=none; b=k7NoYXNCy4Dkbw/cczyHUvfwG6IpFZZAnwGHJr3LvmD7NCQCDho/2GEZmTDJe3/c/PWWY1hZytG60o3aEACrF0DHsDWkyOOIM7/h3WEePvPOYvUiWUhzCd4LoSmoODdukptRrt+q33m0HMMHhfH82d3GuYT1WjjAAiXhgsxZQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744933296; c=relaxed/simple;
	bh=g6Q4J6OyBtyv3Oc7wbrZKb6qADczPo4yxoSqVG+RFN0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WlerML3WlHri7SUT1BH7YRfoWjzxO2/F4+898en7TqhIqzg7bP5QPaJGlaNu6bXshC7MBMDatV3cSLckqLPXgV5lDSutMQ5ChzrU7V+dCfoPZ9COg5RGRElShDq3WE9nrXAm4BA0CIiT64OKFusxeyekN46Ns+eYjhHEgFoIYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eErxZBTY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so1226596f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744933292; x=1745538092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8U+kudIz/j8NCJHl9nRYYX9HPI/uXGEfaXUi5QbR2nU=;
        b=eErxZBTY2u1qPJj4dPyVdX8SHrXp3VfYcSkDSDyHsnG/5fg5+2nigBcsLuYZ0nRMNL
         grCnbUBl5SabcSq7zs2AmZCakCQnuDgMtmB4FOprJzZbb2SPrWo9YYUhrfvvs/mHEUG7
         Yl6b3AqxF1ktGc8D+uezaJdLuwJPosSAis9kR4ftQLEQnQpW0xsgrTqUc1Aavaz4VRUj
         YwKcsivfFdBbc6IEpmEBlDNca65IReqhxdLfjP0t9+6oL8xtKYONqs4tSyuhKjztTFYd
         0D8vX+KdolHHRMhwDqDiyAtAGodsvaO8WDnZLnnTGcC5vfiCIJP1z0wjEJ46ET7usSMM
         dsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744933292; x=1745538092;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U+kudIz/j8NCJHl9nRYYX9HPI/uXGEfaXUi5QbR2nU=;
        b=qT9MX6bEHNURvWfV/eE4Scrxl56BXjZkPMmeMMEwP1nH87agrdyEeFHYmMlR8Qqxsz
         28upswH1tVFcsOsgHSAgHbUl4VwqIwRUjmo7Fv0rXqhs++QskypPhN4ZZ9BzLhrBd0n+
         9NWUiYTDVIKm73CEr0VyF68H8pwpPhGCTLMsbyWHUpEDyq82unTjzAD29E+TVXnOdg+9
         H+Oye/dhA5X0Q5pLXmhxzuUs5zeAzU47sPKclX2XiA+MnoGnxJaE/WbcEsKMnO1c4cjI
         OGelU2c1tKCvGy9dP7Dlfc1xBM4KUZluoyXAgIlRdChUSWL+wN0JnfAhyx1RSak0UFOz
         MolQ==
X-Gm-Message-State: AOJu0Yzj2EIk2FlbmdgE7rq0iQZm20r/iizWyXA+vGIJ4q3/kufsp1A2
	XcxCly3gaM58MSG+XHMxjE20UglTozJloaNqnHt/ZlP2oUSkRW2W7V37l3KdKJJFKJni90dQLX4
	J
X-Gm-Gg: ASbGncu4eueR8k3oc+OPFck5/Qyy0cJPaMJoEvMybpSA6ftJfIZ1kgcB9mSGKWxnAty
	tsEfzXHMLNTpIh0nedK31QD2fy125dJh1jbDsDTO+HDdIehqcYWgSvjahs7B2kMb4y+SXLrYkSv
	qiPa7Qhx+m24p2CsS4OH/TsjxnlDZ1qewkhy2U11naQN/ReidjXdrjZUAphw6ur4RG1myFf6Q7Y
	gLWG/dCYyup+C3eXImU8/HdYpA4ILBUd2Bw835oETwrbELMi6SFb1bfyv2i0FYAttMOt/jsgjYJ
	N3Ebw0p+TH9dm2vQTJPyKs5oJZiQRqFzzxkRjjagretYIhiRVr8tVVi3zffV0PtqrUok
X-Google-Smtp-Source: AGHT+IGs6Or8Sbn+hexjFcBQNzQfRYZaR6FVX393OSNIbJ50rIimxI5Wtktv4sUhFAqf0iCjYdDLhg==
X-Received: by 2002:a05:6000:4201:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-39efba608e1mr483148f8f.34.1744933291825;
        Thu, 17 Apr 2025 16:41:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e05e0basm18772a91.44.2025.04.17.16.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 16:41:31 -0700 (PDT)
Message-ID: <9f322b27-ae8a-4042-8eda-68e241734012@suse.com>
Date: Fri, 18 Apr 2025 09:11:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: store a kernel virtual address in struct
 sector_ptr
From: Qu Wenruo <wqu@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-7-hch@lst.de>
 <0b3a6b18-ab19-4997-86dc-fd269b7b61da@suse.com>
 <20250410053413.GC30044@lst.de>
 <63e2eafc-1004-4c12-9d90-39377b0071f3@suse.com>
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
In-Reply-To: <63e2eafc-1004-4c12-9d90-39377b0071f3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 12:34, Qu Wenruo 写道:
> 
> 
> 在 2025/4/10 15:04, Christoph Hellwig 写道:
>> On Thu, Apr 10, 2025 at 08:04:25AM +0930, Qu Wenruo wrote:
>>> 在 2025/4/9 20:40, Christoph Hellwig 写道:
>>>> All data pointed to by struct sector_ptr is non-highmem kernel memory.
>>>> Simplify the code by using a void pointer instead of a page + offset
>>>> pair and dropping all the kmap calls.
>>>
>>> But the higher level bio from btrfs filemaps can have highmem pages.
>>>
>>> That's why we keep the kmap/kunmap.
>>
>> Where do filemap pages come into the raid code?   As far as I can see
>> they are always copied, and the memory is only allocated in the raid
>> code.  As seen in this code we have two direct allocations that I
>> convered to __get_free_page, and one case that uses the bulk page
>> allocator where I use page_address.  Or did I miss something?
> 
> The function sector_in_rbio() can force to use the sector_ptr in 
> bio_sectors, and by default we use bio_sectors first.
> 
> Thus all the kmap/kunmap pairs are needed for call sites that is 
> grabbing the sector through sector_in_rbio().
> 
> This includes:
> 
> - generate_pq_vertical()
> - rmw_assemble_write_bios()
> - verify_one_sector() for READ_REBUILD
> - recovery_vertical() for READ_REBUILD
> 
> So I'm afraid we still need the kmap/kunmap for now.

Most of the series still looks very good to me, for this problem I'll 
changed it to use physical addresses, and keep the kmap/kunmap instead.

When the modified series is properly tested on PAE systems I'll send out 
the refreshed version for review.

Thanks,
Qu

> 
>>
>>> Or is there a way to set the filemap to no use any highmem pages?
>>
>> You can restrict the allocation of a mapping to avoid highmem using
>> mapping_set_gfp_mask().  But that would not help with direct I/O IFF
>> user pages came into this code.
> 
> Fine, my dream of getting rid of highmem inside btrfs is still really a 
> dream...
> 
> Thanks,
> Qu
> 


