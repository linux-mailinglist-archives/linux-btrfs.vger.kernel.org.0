Return-Path: <linux-btrfs+bounces-12780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BB0A7B0D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6345D1890AA3
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37D1F892E;
	Thu,  3 Apr 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JU2t62wS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6191CBA02
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715029; cv=none; b=iq/D6ntiEFiDCWoMoQAddSeZCMo60TbWyyZ3by8wINesxaoRzs85vCyUjW0YRJS4HN2dVMaqcDp51jlLQbr78p4pLf2Oak63X2VAwt/FobbP3rxpfrCrWFgQvh/ckaq13wU7fTtDPEbj+lnjGuCzIHbp8bxwaez6sSdaxG2jfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715029; c=relaxed/simple;
	bh=gjp1MLoBCjtFmMYDK0mIqAHgFy4wSVi0HMLGpuMmAaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g14kwdhatjusuenm4npXCJFXoN7li+yv6pxmG/zOXzjAvxGVe21c5WY60tMUejTsK7K37EwtO55oBMejCxVgox9JanAbzDAMzHCVtcfnfpU6bznCKIQyNV++hfe1tY/gSd36PMw4wXLshQXYX4NcybL1AcBMPLUavQ2PABMPoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JU2t62wS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0dfba946so890773f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Apr 2025 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743715025; x=1744319825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hje/R4x8f8eUiwO/VVrzzPZE9MAu2KSy4teAI/eT2p4=;
        b=JU2t62wSTqi4BWnI6q3d9LRAEMq4xNTMoR/gYf1kHNExv2YPsRU7IyCuc6NEkJtZnj
         XEz6bA8nAOxtTf85nLPtlyzmAfCkhPconv0oOlrzOk+jXpViI7RdPaQ44UjiSNvRThGW
         NmLRCOafnXTiVVkfqvdDcPosAMwN5o+Zs2XOkERfZ1fgfd1nZdz9goJ3NF6WkuUT3Shy
         yyLB/nuCFgtM6Q77//JYec0dnw3GiDnC0VhGLNyEFxd/tq+lcNmeOOGRLlHEvPVcMlo9
         cD9JjADik2MTaySxAx11MBT+sFqw/2tVBOl5Rv1ISKIMl7SZvlxDAiqhOYEnS+R81bCC
         rF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715025; x=1744319825;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hje/R4x8f8eUiwO/VVrzzPZE9MAu2KSy4teAI/eT2p4=;
        b=oL81UrkZth2IXeWj/G6tEWzV/VHALz+N0Rax6rFmy+qR45yHYznGAv8Qu7OT/q7AZv
         Uca11dKohKrVMSSDaMpZLIo6Ll5yccaQ1/iP9fN28B5LR/i3Sk7eZcJ9VSMsVsgm4OKD
         qpL31ZB9sidk2bVexS2kdr7/JcKT6G9Rvcphxt3atArtolcEfyVadzMli0CKNl5b+bnK
         JimTCx2mNDFASh8fmRyP0BMOYu/d6BZLg4Cqjy9XoK3ZjCqqMRLIjxT3fmlm6gpS5Jy7
         wdg5/yqd7gJnBUUXC+Ad761t0TXcqPGgUYVFWyvwfKzpp0pyijNfmVMKiHpkh0XD3TI7
         NPOg==
X-Forwarded-Encrypted: i=1; AJvYcCU+vwWBVXl+0kirGVTrZ3miYGc4cvmzQ+1lAD8VEUcq5y6vkj6vmdxnHcJhzv77xhNIZDzWr14y+bBELA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRld7+8DDrGwSXv23Jsf3wh76ON+lAXhyZldH4UX6D9AbIGu3
	DG2lceU0qWrmkSgwDKzfh/o4YgLjARaR9Lpy19R9bimWEH1o+DFTosTzH8i7UEk=
X-Gm-Gg: ASbGnctJCpCswPBQuxkQbs9jDv8NnHWbznkIpuw9zN7nh59SboXA1uplKWB23SwLT37
	eJ/NYsck52InzRGphdb/US8k2k149X6MjRugyjvrS8OPnBLkaMrCIWiPId+i8ALvDZAjg5YNawk
	F83KxiL8lqt/V2WbOsNRKcblsOCV2O++f3WSD7pffFYahVjh/GZ3OMPpmgXgJ/vvHX1a5MKe6nf
	wEwtr27Mb7Z67v12+s9HCYrpmNUdavgabeEtjo5S6bp7Q0HiAF6m6Q+hoD4jHJDQy/rIjQyCTkV
	P+CLdYq54x2kJVO0KftZvQ0pyAlRekyg4MS57DNCtDq2AFbiOEW0VHgPxV1ClQnThEijGqSE
X-Google-Smtp-Source: AGHT+IHRE5wJmywBZcMLc+JY7rRZmBtEbpNWFHjuKVkK5txq3gu6sAY2kfmXHqDloG0IUjXfz2nzyg==
X-Received: by 2002:a5d:59ac:0:b0:39c:1f04:a646 with SMTP id ffacd0b85a97d-39cb359457bmr695538f8f.13.1743715024782;
        Thu, 03 Apr 2025 14:17:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca7fb80sm2211891a91.25.2025.04.03.14.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 14:17:04 -0700 (PDT)
Message-ID: <59539c02-d353-4811-bcbe-080b408f445e@suse.com>
Date: Fri, 4 Apr 2025 07:46:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large folios and filemap_get_folios_contig()
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, vivek.kasireddy@intel.com,
 Andrew Morton <akpm@linux-foundation.org>
References: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>
 <Z-6ApNtjw9yvAGc4@casper.infradead.org>
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
In-Reply-To: <Z-6ApNtjw9yvAGc4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/3 23:05, Matthew Wilcox 写道:
> On Thu, Apr 03, 2025 at 08:06:53PM +1030, Qu Wenruo wrote:
>> Recently I hit a bug when developing the large folios support for btrfs.
>>
>> That we call filemap_get_folios_contig(), then lock each returned folio.
>> (We also have a case where we unlock each returned folio)
>>
>> However since a large folio can be returned several times in the batch,
>> this obviously makes a deadlock, as btrfs is trying to lock the same
>> folio more than once.
> 
> Sorry, what?  A large folio should only be returned once.  xas_next()
> moves to the next folio.  How is it possible that
> filemap_get_folios_contig() returns the same folio more than once?

But that's exactly what I got from filemap_get_folios_contig():

lock_delalloc_folios: r/i=5/260 locked_folio=720896(65536) start=782336 
end=819199(36864)
lock_delalloc_folios: r/i=5/260 found_folios=1
lock_delalloc_folios: r/i=5/260 i=0 folio=720896(65536)
lock_delalloc_folios: r/i=5/260 found_folios=8
lock_delalloc_folios: r/i=5/260 i=0 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=1 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=2 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=3 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=4 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=5 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=6 folio=786432(262144)
lock_delalloc_folios: r/i=5/260 i=7 folio=786432(262144)

r/i is the root and inode number from btrfs, and you can completely 
ignore it.

@locked_folio is the folio we're already holding a lock, the value 
inside the brackets is the folio size.

@start and @end is the range we're searching for, the value inside the 
brackets is the search range length.

The first iteration returns the current locked folio, and since the 
range inside that folio is only 4K, thus it's only returned once.

The next 8 slots are all inside the same large folio at 786432, 
resulting duplicated entries.

> 
>> Then I looked into the caller of filemap_get_folios_contig() inside
>> mm/gup, and it indeed does the correct skip.
> 
> ... that code looks wrong to me.

It looks like it's xas_find() is doing the correct skip by calling 
xas_next_offset() -> xas_move_index() to skip the next one.

But the filemap_get_folios_contig() only calls xas_next() by increasing 
the index, not really skip to the next folio.

Although I can be totally wrong as I'm not familiar with the xarray 
internals at all.

However I totally agree the duplicated behavior (and the extra handling 
of duplicated entries) looks very wrong.

Thanks,
Qu

