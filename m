Return-Path: <linux-btrfs+bounces-19207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF96C72FF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B90C92A3AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3A3101B7;
	Thu, 20 Nov 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gUMjJpMk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4A270EBA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629236; cv=none; b=D/AzPBxzfy+RjpuDja6CLgGHvqmGNOWCW2I6X05u9e9uFex7Qb44IxNSSSYLx6wLoFtj4oFXWJCLZhkJus7I7dS7plKdVKv0+GmhS4K+h7sF1NTtzPUEPIQuY2RqyiyAMD4KgxcrFmsnsyttdT0FJsVXaEufJ6tpVDjwvpKZsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629236; c=relaxed/simple;
	bh=IgKdvMzWFo5mht5IbNZlCQSJdhwDCNcvbaa32ffp1os=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kduZ4di54IgfZ2Ehij68GAwg5YGMCxfls7j6gFllhrX/+npNNaAq4Zqj8kl/2r9x15ligpkyuMoHAJoedOMXXSpLiOdxG/AJpQcnrbOPKr+ZZHU5rp0acqMXYh+L+qTsasHepSXI+Tn+fWJVUYCRP9SdPagEnBi4A/Sd+85x7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUMjJpMk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47789cd2083so3629825e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 01:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763629232; x=1764234032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gVcXJwdjovaiC2z0g/EhVh8SfXQTCTXQ9d8Fqw2gRcc=;
        b=gUMjJpMkst/zSKSzifsJERsNsS7ziDnguyyaEJMgb46DwWqPIj/EIkUX3HUVvetdu2
         5Lyw0CVD3vl8KKyEa0T7Tn6innT+isfyAIdgOSwnvnWaYzMVqj+2D3HUfk3d7CBg4Fzh
         grxzuJVpYY6DbtCP8c5/Jkdwg8Zvcxt4eoFAFqs7lMgmw4NbYBkyLPPe7AUN8+vfliuT
         Fz34/hx16llGmlC0gqjTijz9PygjXgbBFzIoBDeaUPSq1KTXeczVhOZMyLaEliYqKI0X
         QYjkDySUFHquA4TyvaGtnFIxnkqGPfsfnOeK2GgWlVa7d7MSefjB4R3W0rASKcjJKrti
         mYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763629232; x=1764234032;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVcXJwdjovaiC2z0g/EhVh8SfXQTCTXQ9d8Fqw2gRcc=;
        b=OGrCMttJ/PinpBtpw5+D20eDpM/BAAFXFzf+PbTJKP4oivK/lO6oG9IYldkY/UP6F6
         m2MVSSR3ZaLvw++0+7FC7Sxu+BvNLbKn0rr7OFLuZ+8ORHcfK/aHbxWMKWYkkO5Suk8l
         KOtQ1fnyNxSOuHFGjULWs+87bNWxAJr+UU6PNq/eiXYeTC/gewvFfwpOhd/HGI0mLBwi
         hrxzKrJRYaVo10zu8x6miC/OANWdguWh+m5dugIpDkjLviywFNDB0E6BMRi9VyG2s0WW
         CBEtrt+l/83RfFfjV6xht82OAWoKO3fi+rc9e6VyFHwFjpuBjPOnkj1I1Wp7NrhIUPaf
         gpKw==
X-Gm-Message-State: AOJu0Yy5rsgVGPpshuVC5WHAA7eJuM4WMAJDPf0ZQoqvlyEdY69/xtJg
	EgONExaaAvE4iDR9b5YXCEYRkiPTdfOdH47vecDLAXPSdxqUULbIc4a1bvQQ4HjYOSE=
X-Gm-Gg: ASbGncsVtBGQXJrKB0YK9H2avJ8hBZNGrVhvYw9+srpgbkhLvFq6NVw+DhEGoptQ4YQ
	C71imyZC/HmjAgCqp70Dy+iWZOtIjxJ5ZuRBV7jH0BPYoyOXYn9wbW+t6xwzu7/VM6YHW9IhaPJ
	CuT3WqNet3UaXGzQUV/5T+YrgDXBYRc9FUegyY7FScsnyRSuu1mZYKiZAeEpyh6wWZ4FGYRIaX3
	vcmBrI2Vwg5tUzO+aBQyBkz3sk+S6Y1ONkYzkksIKTEvWQ2wxYWqGDC5+4w1a4hB9NVmU1XhN8+
	isk5A/LshmXjFzZpZl1/jdXAb//zxrLMGF1/klwDdBwINI1YdxBfEwGWgLKFY7AzzXfYI1yXUyf
	mAjDThcDUUmUnVO0yHHdedqQIYrEMtPNrg2vXh4uQqxkNeRsnXpN1GvCFO7IoqbX1aVo8BZucN0
	CGf7FwE7fLrRO1ieAlZ2/9n/AapEhzuV8wjRmqYYc=
X-Google-Smtp-Source: AGHT+IHeFQ9hD95DkNxPNZFg7M7c1CoMckqmaKU2DEmm4a5oPlshI6IBQIOCKuy0QvR7IWtj0szotg==
X-Received: by 2002:a05:600c:c492:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-477b8d8f05bmr21882605e9.35.1763629231945;
        Thu, 20 Nov 2025 01:00:31 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f1263641sm1993918b3a.59.2025.11.20.01.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 01:00:30 -0800 (PST)
Message-ID: <491ac9ab-0fbe-4ddb-a7fb-64e129733912@suse.com>
Date: Thu, 20 Nov 2025 19:30:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: reduce extent map lookup during writes
From: Qu Wenruo <wqu@suse.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763596717.git.wqu@suse.com>
 <a6869c2d5f3b8cdd3360375ea64d0449c97dfd6d.1763596717.git.wqu@suse.com>
 <20251120011626.GB2522273@zen.localdomain>
 <40dd02f6-5e28-4fb2-af93-4c07dc9bb0fa@suse.com>
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
In-Reply-To: <40dd02f6-5e28-4fb2-af93-4c07dc9bb0fa@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/20 15:58, Qu Wenruo 写道:
> 
> 
> 在 2025/11/20 11:46, Boris Burkov 写道:
>> On Thu, Nov 20, 2025 at 10:34:33AM +1030, Qu Wenruo wrote:
>>> With large data folios supports, even on x86_64 we can hit a folio that
>>> contains several fs blocks.
>>>
>>> In that case, we still need to call btrfs_get_extent() for each block,
>>> as our submission path is still iterating each fs block and submit them
>>> one by one. This reduces the benefit of large folios.
>>>
>>> Change the behavior to submit the whole range when possible, this is
>>> done by:
>>>
>>> - Use for_each_set_bitrange() instead of for_each_set_bit()
>>>    Now we can get a contiguous range to submit instead of a single fs
>>>    block.
>>>
>>> - Handle blocks beyond EOF in one go
>>>    This is pretty much the same as the old behavior, but for a range
>>>    crossing i_size, we finish the range beyond i_size first, then submit
>>>    the remaining.
>>>
>>> - Submit the contiguous range in one go
>>>    Although we still need to consider the extent map boundary.
>>>
>>> - Remove submit_one_sector()
>>>    As it's no longer utilized.
>>>
>>
>> This is very cool, quite excited about it. A couple questions inline but
>> the approach looks good to me overall.
>>
>> Also, I was curious and looked at writepage_delalloc and that also uses
>> for_each_set_bit(...) though with simpler stuff in the loop
>> (btrfs_folio_set_lock) though I wonder if that can be simplified as well.
> 
> Thanks for catching that one.
> 
> I'll check for any similar call sites and do the conversion in the next 
> update.
> 
>>
>> Thanks,
>> Boris
>>
> [...]
>>> +    while (cur < start + len) {
>>> +        struct extent_map *em;
>>> +        u64 block_start;
>>> +        u64 disk_bytenr;
>>> +        u64 extent_offset;
>>> +        u64 em_end;
>>> +        u32 cur_len = start + len - cur;
>>> +
>>> +        em = btrfs_get_extent(inode, NULL, cur, sectorsize);
>>
>> why is sectorsize still relevant? Just a small size to grab an
>> overlapping em or something more meaningful?
> 
> This in fact is a pretty important error handling for some corner cases.
> 
> Normally we should always have an extent map for the dirty ranges, but 
> if we hit some situation like the following:
> 
>                           0          16K         32K
> Dirty range:             |//////////////////////|
> Em range:                |          |///////////|
> 
> If we call btrfs_get_extent() with cur == 0, len == 32K, we can get an 
> em at 16K, and that can screw up our calculation.
> 
> So here we should keep the sectorsize as len to catch above situation.
> 
> I'll add an comment about the hidden error handling situation.

I'm an idiot, the existing code can handle it by properly return a HOLE em.

To be honest, I think the length parameter is only making the function 
more confusing than needed.

I'll look into if we can remove the parameter completely.

Thanks,
Qu

> 
>>
>>> +        if (IS_ERR(em)) {
>>> +            /*
>>> +             * bio_ctrl may contain a bio crossing several folios.
>>> +             * Submit it immediately so that the bio has a chance
>>> +             * to finish normally, other than marked as error.
>>> +             */
>>> +            submit_one_bio(bio_ctrl);
>>> +
>>> +            /*
>>> +             * When submission failed, we should still clear the 
>>> folio dirty.
>>> +             * Or the folio will be written back again but without any
>>> +             * ordered extent.
>>> +             */
>>> +            btrfs_folio_clear_dirty(fs_info, folio, cur, len);
>>> +            btrfs_folio_set_writeback(fs_info, folio, cur, len);
>>> +            btrfs_folio_clear_writeback(fs_info, folio, cur, len);
>>
>> cur, cur_len? or start, len? cur, len feels wrong
> 
> Oh, thanks for catching this one, it should be @cur, @cur_len.
> 
> .
>>
>>> +
>>> +            /*
>>> +             * Since there is no bio submitted to finish the ordered
>>> +             * extent, we have to manually finish this sector.
>>> +             */
>>> +            btrfs_mark_ordered_io_finished(inode, folio, cur, len, 
>>> false);
>>
>> Same question about cur, len; also I don't know if the comment referring
>> to "this sector" still makes sense. Manually finish this ordered_extent
>> or something?
> 
> I'll fix the the comment too.
> 
> Thanks,
> Qu
> 
>>>
> 


