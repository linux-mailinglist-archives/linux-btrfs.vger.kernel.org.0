Return-Path: <linux-btrfs+bounces-12974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A59A875FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 05:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABDA16E6B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 03:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6817A31C;
	Mon, 14 Apr 2025 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PuyAC4eQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42314430
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599901; cv=none; b=hbYy7Vjev2Vhe95vlE9qzCBOp+0ZmlfD8o7QHzCM872/ALrf4g08L4809GTN/BcIxTKVor5kEloZmwnznLZfV7nDXkbV6LWLaDUu6+BXQaO6dM70i6eIC+8XaDcpVaSOOsGyjmrGt24GBWhbkYaDZ0IGrZ+XGu3tMhZS45k412I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599901; c=relaxed/simple;
	bh=RT79FGs/6QVxd6/xcvDQhFlDozVMezEuFjHEK+DHKR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UG5WqytqPk0UPQo/cgMfwk97uaZA1HeYQ4aSZyfish0ojblJxwJyL0fuDkKNgO26ZWH4UAzOFkedzhTmyfGBnxEcHs4Yoi3qTZXy5p7bUI4fvc1Iniha2wkuKPIk22Oe2RmRY9yqw8J105Ole2az9BUmTs0D3Nc2doHP1wr8fyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PuyAC4eQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so2343985f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744599897; x=1745204697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qYwZUTPh1pC6HO84cJijBRttMIYJOUyFnwnf2EsiIy0=;
        b=PuyAC4eQhWgIMtX/i4VFyqbb5I/3FVSTNKt4rOm0CGVkml+9eji3VcFEz+iALZaBQT
         DjTXZ1+bLKVNq40r8GsJlUzvX43g2HfYcSOihqqAm5WfClTnrYpx+5kRQGhdLgDumLKs
         kO1X3tYj/4bGJBsqlSgC4mylPNCARJa2tKWxRSOjkvRPHnMfX5QkNsPxi9YLQBbwE88y
         hDx0CaRnaAO/0Qa3f/tY04XZBt9Q0IGpaKfKN/C8ae+kVIbeP2Q5y/jCVXqeXBUDPjy7
         4yPLfe++M0bgyN3swdRQ35jgj2ff/a1xsGYlN/MN5QWOSPo6JI+p33T8upl9nqrq8I5H
         286Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744599897; x=1745204697;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYwZUTPh1pC6HO84cJijBRttMIYJOUyFnwnf2EsiIy0=;
        b=leB7BehjvXjT812Kv9u3MP6LxERuq/SRitkiDKwBTQg1R8ZQhXJJqynW8Ca1Cmox+B
         Pvd8YsM4vjnR10me73KgviCb6o+sITNwH28fDY3gYPHZtTFOc2vglzXLBVk7O2rfYmGG
         UAHKQkG6hkkdpvTtcBgvYF7s3dVekr3bg5SI/vi4z6+LAccUHIyf/a1oCKgNAitbrPJr
         1StHTlHiIHU5SnoJoMeRRPsKF1cItXOYDWlAQw99A3bfSvNk9uMf27l64/ob1it/mEab
         yo1ZZTcFesqu00i0lnkz6UalOMAF0nYM6qAbJ3OmpBbjS/+lKBFebPxA2cO4NbK8WhhI
         kO+w==
X-Gm-Message-State: AOJu0YznlfYNTj+DK4tXMxsqxcE3epbqdxdJxMnao/FMR7+vfk8LF8Cr
	f7YZ578FB/okjjkwtFEwuDCW3VeETmH3hogqenvEpveU0DYEJzgSNo0K/iCHGUw=
X-Gm-Gg: ASbGncs3QuV7Akg6i3FT3TN9b2pKzQvFNjdhhiaDfACu905srQR8ezRF7agbfzFCeus
	nhlfuM+hf8lg82Sosj0z7iyIlbo2dpJspgJUaIrqGgd1I5IHu51dMKXY4cIF2Mz6S21q5mDNiWJ
	mL9VpjUchMyWGssIZGezxufOP+EERIhi1uw52pfo63s4p9sTcfdrAVB0GMH6CyALl/qwoy/gEBj
	pCOrWau9yLkbGcyjDLNHF1WKj2EbJPGZoC61IjrT97h6DZVeexvYti/F2ggc5P0tvjX4nNbLlqL
	CPaZUx63jB79d9pjEH8QyZu7FdDZHlDaw6/dQM0nSeG9L+nC6M33/ElbPSyLcuSbjF+U16/ZERE
	QTG0=
X-Google-Smtp-Source: AGHT+IGst7bb25xXKPyZwcLUBNSXbrenwHCq56U972+ufWAmOegl8354yd5fqeyRqNBFZTaYjc9T9w==
X-Received: by 2002:a5d:64e3:0:b0:39c:1a86:e473 with SMTP id ffacd0b85a97d-39eaaecbde2mr9071046f8f.56.1744599896679;
        Sun, 13 Apr 2025 20:04:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62922sm89363805ad.51.2025.04.13.20.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 20:04:56 -0700 (PDT)
Message-ID: <63e2eafc-1004-4c12-9d90-39377b0071f3@suse.com>
Date: Mon, 14 Apr 2025 12:34:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: store a kernel virtual address in struct
 sector_ptr
To: Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-7-hch@lst.de>
 <0b3a6b18-ab19-4997-86dc-fd269b7b61da@suse.com>
 <20250410053413.GC30044@lst.de>
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
In-Reply-To: <20250410053413.GC30044@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/10 15:04, Christoph Hellwig 写道:
> On Thu, Apr 10, 2025 at 08:04:25AM +0930, Qu Wenruo wrote:
>> 在 2025/4/9 20:40, Christoph Hellwig 写道:
>>> All data pointed to by struct sector_ptr is non-highmem kernel memory.
>>> Simplify the code by using a void pointer instead of a page + offset
>>> pair and dropping all the kmap calls.
>>
>> But the higher level bio from btrfs filemaps can have highmem pages.
>>
>> That's why we keep the kmap/kunmap.
> 
> Where do filemap pages come into the raid code?   As far as I can see
> they are always copied, and the memory is only allocated in the raid
> code.  As seen in this code we have two direct allocations that I
> convered to __get_free_page, and one case that uses the bulk page
> allocator where I use page_address.  Or did I miss something?

The function sector_in_rbio() can force to use the sector_ptr in 
bio_sectors, and by default we use bio_sectors first.

Thus all the kmap/kunmap pairs are needed for call sites that is 
grabbing the sector through sector_in_rbio().

This includes:

- generate_pq_vertical()
- rmw_assemble_write_bios()
- verify_one_sector() for READ_REBUILD
- recovery_vertical() for READ_REBUILD

So I'm afraid we still need the kmap/kunmap for now.

> 
>> Or is there a way to set the filemap to no use any highmem pages?
> 
> You can restrict the allocation of a mapping to avoid highmem using
> mapping_set_gfp_mask().  But that would not help with direct I/O IFF
> user pages came into this code.

Fine, my dream of getting rid of highmem inside btrfs is still really a 
dream...

Thanks,
Qu

