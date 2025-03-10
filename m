Return-Path: <linux-btrfs+bounces-12166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C4A5AF9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4895D171496
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40080221F20;
	Mon, 10 Mar 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WZFs6eNm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CE1E0E0A
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650695; cv=none; b=dGoStsGcLUzc581AUuYr7Ur/lkTTYt1Zv2OOtMVZdtxAOMmlkOWNsKHGyfA4PjulmOLAbyqZPp5pY1hsKIT2b3UHjgtY4T+wJaWiQd5yz0hoelcWVpUpPtrzZw7pVdymXrV3jByq7Q6ZWeF5BVr0iDDUYVvnPq//UPvM1yhNKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650695; c=relaxed/simple;
	bh=tBKvt3eNNCb3DwCXCAmh6XRTKlmQ2kMocZXza6+jwUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiBLKI5663Nm2/3PlzEMULXDw3LvI7wAQkrND4wx0G6e4BfBdVSWs+WYubuNvObugXTy2yXhn40MUId5QIMvl9jC3W/mF4gbBju8Q9m57c3b1pWWOPSJG/CvZJOipjM+tVKCgy/Qjq2CimW8s4Tp4G2M7TFRtjhoQhWUvsRnhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WZFs6eNm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2319313f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741650691; x=1742255491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GzYrvwfCJFcKIM+U/oVRSUvtK/KYHHPu3QoU+61gfz8=;
        b=WZFs6eNmtDI4lOJN5a3fKHmlReaceLM5REVn4DuihQ+RrGAFwjCstMH4tFVBTZLz5F
         pxx65RSbx7buy+bDhjWhE2Fu3ebU7eMIls0Ipj4qEfYseOoBuhjGmPMzJDGl5SFrEC5Y
         Yaudjp/S86DHU7GxuHEqpHdhSAiQ9nrHJL5/Y6FTlqt2iLZbCCllBwK50jbCxu7LXP4N
         f42WQAy3dvlSNNlcyHGcb43QrYuU0+7ntbq1/G5xgjAhIInCRnfO1gLMQ7vDaGs7hEmS
         eTA9btHJnrDB1FqlITWlYC04BZIgLuJk3ZZ3sR3KNLMhmpe5bDOm1AkC5hS/f9vrtVOE
         2qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650691; x=1742255491;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzYrvwfCJFcKIM+U/oVRSUvtK/KYHHPu3QoU+61gfz8=;
        b=VOnxUj094/Gf8bTyO20GbluuCFlwV3dozh4WbEQBspSoKXRASnbQQIXnFhajRoyJmC
         jgOipp3c3NAx9WyhiDd4tGSkfMuYEqyRp4zSJl9Wuk1z3yfJgmBTDUlbYRWgBt8DYlfB
         kwkJCItB6hS9HD2or+Y83yUIEYpr22rAenPgpnXvcvWea2nh7J8cFIvNGc2bjEjBMopo
         rqERoaXU34ULfFprSyqFkgDGQQVtLNpWMz9Qft3xwGIJRFM8lonEr9KfX2jh5j1/ladm
         QHAXXsW5JYX0pBrEiLqv0o3rrntiuunhgyPe75Q3slgDdKjJgWQkE904DiLrAyZUf5bC
         V0qQ==
X-Gm-Message-State: AOJu0Yw8SRiHjmwrMMQ2G0jHH0j8IHbFlAlg3l3scTiZXHhBbeZ5VBSI
	R3ExeqE9ku0d7CSMm1zs6uhdKTCLrVBwai338ONbT2oL99KVd0KgioyytPzD14vPBtE3rKR6wdy
	f
X-Gm-Gg: ASbGncsgA3y/tH8EVxOXfbIlc+lmJyx6BSJxXzwOqh5TRhQE+NAJZIODKFHsoUIIPGB
	Zw+COFtfva4ItSfR0GkU4jSIL1v/mhygeuJ+txWO0SrX3Tql1X4yIuCM11xhI8uSrK2MJUvZa7E
	mHjy3f+eiU3WbpS5kdUedcCD2qg5pbzvfOJRcVGAt2ZOXiOOyevXIWRo6scXppK/kiNF9LnbLYq
	E7GIQYETuDElYy2yz1MXVDF3bygn4dBnPSWVx+9MS0MTWA6/9ekmVNKh7QW4Yr0W91Xh8/vjjnN
	NL0wqcP7XwGDCZ2/PTip/mFssoaRrAWO0AAL7GaYJvQFjigbBIEECCsXYgLivoqOD60cfX7UeRh
	o09Leb+M=
X-Google-Smtp-Source: AGHT+IGs0XZ5VtZyN3qK0gGpgMKv7tA+U1bQ1lP1Bj13Ub3+aEa4PT33ShTJyoEtnOP/6eFPHdsXgA==
X-Received: by 2002:a05:6000:1a8e:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39132da9221mr11329656f8f.35.1741650691021;
        Mon, 10 Mar 2025 16:51:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91db3sm84667905ad.170.2025.03.10.16.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:51:30 -0700 (PDT)
Message-ID: <78f107a0-0feb-45e2-afa8-2fe854cd70e5@suse.com>
Date: Tue, 11 Mar 2025 10:21:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] btrfs: prepare extent_io.c for future larger folio
 support
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1741591823.git.wqu@suse.com>
 <657d28be4aebee9d3b40e7e34b0c1b75fbbf5da6.1741591823.git.wqu@suse.com>
 <20250310232750.GA967114@zen.localdomain>
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
In-Reply-To: <20250310232750.GA967114@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/11 09:57, Boris Burkov 写道:
[...]
>> @@ -2503,13 +2503,18 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>>   		 * code is just in case, but shouldn't actually be run.
>>   		 */
>>   		if (IS_ERR(folio)) {
>> +			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
>> +			cur_len = cur_end + 1 - cur;
> 
> Curious: is this guess based on PAGE_SIZE more correct than using 1 as
> num_bytes? How much more correct? :)

Filemap (page cache) itself is mostly an xarray using page index.

That's why filemap_get_folio() only accepts a page index, not a bytenr.

Using length 1 will just waste a lot of CPU (PAGE_SIZE times) trying to 
get the same missing folio at the same index.

> 
> Probably better question: what is the behavior for the range
> [PAGE_SIZE, folio_size(folio)] should that filemap_get_folio have
> returned properly?

Depends on the range of extent_write_locked_range().

If the range covers [PAGE_SIZE, folio_size(folio)], we just submit the 
write in one go, thus improving the performance.


> If it truly can never happen AND we can't handle
> it correctly, is handling it "sort of correctly" a good idea?

So far I think it should not happen, but this is only called by the 
compressed write path when compression failed, which is not a super hot 
path.
Thus I tend to keep it as-is for now.

The future plan is to change how we submit compressed write.
Instead of the more-or-less cursed async extent (just check how many 
rabbits I have to pull out of the hat for subpage block-perfect 
compression), we will submit the write no different than any other writes.

And the real compression is handled with one extra layer (like RAID56, 
but not exactly the same) on that bbio.

Then we can get rid of the extent_write_locked_range() completely, thus 
no more such weird handling.

Thanks,
Qu

> 
>>   			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>>   						       cur, cur_len, false);
>>   			mapping_set_error(mapping, PTR_ERR(folio));
>> -			cur = cur_end + 1;
>> +			cur = cur_end;
>>   			continue;
>>   		}
>>   
>> +		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
>> +		cur_len = cur_end + 1 - cur;
>> +
>>   		ASSERT(folio_test_locked(folio));
>>   		if (pages_dirty && folio != locked_folio)
>>   			ASSERT(folio_test_dirty(folio));
>> @@ -2621,7 +2626,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>>   				     struct folio *folio)
>>   {
>>   	u64 start = folio_pos(folio);
>> -	u64 end = start + PAGE_SIZE - 1;
>> +	u64 end = start + folio_size(folio) - 1;
>>   	bool ret;
>>   
>>   	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
>> @@ -2659,7 +2664,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>>   bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
>>   {
>>   	u64 start = folio_pos(folio);
>> -	u64 end = start + PAGE_SIZE - 1;
>> +	u64 end = start + folio_size(folio) - 1;
>>   	struct btrfs_inode *inode = folio_to_inode(folio);
>>   	struct extent_io_tree *io_tree = &inode->io_tree;
>>   
>> -- 
>> 2.48.1
>>


