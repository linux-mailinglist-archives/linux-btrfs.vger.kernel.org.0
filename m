Return-Path: <linux-btrfs+bounces-12808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D4A7C5BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932023B30EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78EF21930A;
	Fri,  4 Apr 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OE3WG1T+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DF18BC3B
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803070; cv=none; b=QV0YS7WvCy99T1JvN/BRqDLRKn76W5q0Ah/ILhfcpuwZ+Gh+FRFnkPLS+Mlyj9Wf28WoSUGBI7grnQ7SfRqrtmLDgq6ODFMpgy0MjYgr55btVsVVWhAe+mqn6dgAY2UGXbPJYcnkfXGqYRbq44x4g005e1wxjv4/dEjK9anaq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803070; c=relaxed/simple;
	bh=tu2z3RyxJ1GqLPf8Bok+0DZk6lUz6XRXS5hvzdkKAso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdjPGVs7vm8tfaNDnlDG0E8TSGbn3+5QBa3+1YkgAN3TEWuJt7bd2qr0D6+Wgju7mfvaJQFqDb/xL5jE90XCwYHsSdxjo95HQVYoXM7PKGkxPrV7+hj6U00loE+FOcBAUUN78otymPlrpCQerN4nutKgFglDw4+15EaeilAZB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OE3WG1T+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so4551975e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743803066; x=1744407866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImpQo54y9mYidRFSCAcvQo+B6QGgRjuvPFPSFjQ7vMc=;
        b=OE3WG1T+1RQl26rJG5hB/dcdAqFfX9i7B9BiZUzmJ1TfoJsRjYqTFAsBi90NQB3HIV
         eXzQUSOQ/TRKszQBb4Voh9D7LMIwmbXLHB9EgwEDSFiOAPYQutWZdKpZ/Gy4R/vsTj5n
         TehXs7lEzU1g6qX+mp4mhVlGdepsEXGL5EBgMWPfBCCYL/qhy58bnvNPXu3qGnjzPP8Y
         xhJ47NMlkMS460pu1dnM8nevcLQ62m+Uf6gnyrRPyW7YFKrUAG90U9oUBGsJNtiFiCbe
         DR9qJNN3Fmu5g/HBtoRA7WjLV9gYlXxEplmvne1tdcNRPB6FlaNNXmUTz+8mSyxE40aO
         go3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743803066; x=1744407866;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImpQo54y9mYidRFSCAcvQo+B6QGgRjuvPFPSFjQ7vMc=;
        b=Bxk/ai6ivrtsaTR68yQFexkYegcKPjpZznof40hn8ViTuL2uCtdvGOgzYT3RNmT3F3
         tcIfoRiW4wtoqC9VXI5BliVfQuWeS0GwGjk5uyYLgH7JYvDz35CVuV119OmesgUQFhB0
         1KKqVzymUVIVl8QdC1CycfAlu5TVKss5sdkfq0X6thXAlwAlKaLD496TdMbwC3YFxkr6
         CHhkhBy5EL33xHv77jnSFwZF4Fr63gkPRPx6K5KABSu7Y+++RvJce5TBKnVuQR6am5n9
         CmXvfKrEsDOktjEupXDvTj2BK6ryuzklWrmNYGVTpQ6HEWjsYO3UL32p1wl5V+xHq6pt
         yXCQ==
X-Gm-Message-State: AOJu0YzrWrvE/ceqFI0BvKOeCtJffAM5ZTMpoQAxfJVAkoAvccnXUHMY
	fkubMnU/zWkac27J9X7cBzcCSpIFemCnNlLQISbs1a8xN4G6HhS0QpS0tDIaxeSJdAReYfO5RdO
	F
X-Gm-Gg: ASbGncswbbr9oXZ4fOfCXDYjPFeEgie6fwkzF5jiJ3ZmvIUJzW/S5xf2XEOnIzOrcm6
	637oaaoSNNe+qfZ+wxDT3jwWsJteq6oeMJuZR01qpTElIeca8paz9/xV3hoNWABTCWN8sxAOZWz
	zifYbFkl242O+KH/+0gwA8sH84WzE6iJacodNOUW9ohzOT0sxZdtE6n+2N21nosyJ1LoJCDbBuR
	owFF3HxBnK2+O4MKyAhrRTigLYmdtvaozgWSkElW2kjge3T4cuH32uZhq7ctoiiZwo69KEX9o7F
	dGAYpAh8h/oO3Bqx0qRz0/QlJCt+vBMTYWwY78RyGVsJOg4zKe5QTumds+8uDbY1ydMGW4kY
X-Google-Smtp-Source: AGHT+IGjKrv13wA8ubhyfEXFCx7+qqCrHjtWvRMOUXNQMXjzC9x3ca0JcWPSJehmETZk3InZkJKgGw==
X-Received: by 2002:adf:9cc4:0:b0:39c:1257:cd41 with SMTP id ffacd0b85a97d-39d14764ce2mr2770279f8f.59.1743803065620;
        Fri, 04 Apr 2025 14:44:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d2f2csm3929268b3a.29.2025.04.04.14.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:44:25 -0700 (PDT)
Message-ID: <dc2618d9-0ff8-40f1-b5e7-93644fbbe17c@suse.com>
Date: Sat, 5 Apr 2025 08:14:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: remove unnecessary early exits in delalloc
 folio lock and unlock
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <39d3966f896f04c3003eb9a954ce84ff33d51345.1743731232.git.wqu@suse.com>
 <CAL3q7H5vSyG3zpCZ5hbPT8aR2-xODazLwcKhWGhJYUUMLTus1w@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5vSyG3zpCZ5hbPT8aR2-xODazLwcKhWGhJYUUMLTus1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/5 02:34, Filipe Manana 写道:
> On Fri, Apr 4, 2025 at 2:48 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Inside function unlock_delalloc_folio() and lock_delalloc_folios(), we
> 
> function -> functions
> 
>> have the following early exist:
> 
> exist -> exit
> 
>>
>>          if (index == locked_folio->index && end_index == index)
>>                  return;
>>
>> This allows us to exist early if the range are inside the same locked
> 
> exist -> exit
> the range are inside -> the range is inside
> 
>> folio.
>>
>> But even without the above early check, the existing code can handle it
>> well, as both __process_folios_contig() and lock_delalloc_folios() will
>> skip any folio page lock/unlock if it's on the locked folio.
>>
>> Just remove those unnecessary early exits.
> 
> It looks good to me from a functional point of view.
> 
> But without this early exits there's a bit of work done, from function
> calls to initializing and releasing folio batches, calling
> filemap_get_folios_contig()  which
> will search the mapping's xarray and always grab one folio and add it
> to the batch, etc.
> 
> It's not uncommon to do IO on a range not spanning more than one
> folio, especially when supporting large folios, which will be more
> likely.
> I understand the goal here is to remove some code, but this code is
> cheaper compared to all that unnecessary overhead.
> 
> Have you considered that?

Yes, but the main reason here is the usage of (folio->index == index) check.

With  large folios, such check is no longer reliable anyway, and 
initially I thought to just change it to folio_contains(), but it turns 
out that is not really needed either.

So that's the main reason to get rid this of these early exits.

Thanks,
Qu

> 
> Thanks.
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 8b29eeac3884..013268f70621 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -224,12 +224,7 @@ static noinline void unlock_delalloc_folio(const struct inode *inode,
>>                                             const struct folio *locked_folio,
>>                                             u64 start, u64 end)
>>   {
>> -       unsigned long index = start >> PAGE_SHIFT;
>> -       unsigned long end_index = end >> PAGE_SHIFT;
>> -
>>          ASSERT(locked_folio);
>> -       if (index == locked_folio->index && end_index == index)
>> -               return;
>>
>>          __process_folios_contig(inode->i_mapping, locked_folio, start, end,
>>                                  PAGE_UNLOCK);
>> @@ -246,9 +241,6 @@ static noinline int lock_delalloc_folios(struct inode *inode,
>>          u64 processed_end = start;
>>          struct folio_batch fbatch;
>>
>> -       if (index == locked_folio->index && index == end_index)
>> -               return 0;
>> -
>>          folio_batch_init(&fbatch);
>>          while (index <= end_index) {
>>                  unsigned int found_folios, i;
>> --
>> 2.49.0
>>
>>


