Return-Path: <linux-btrfs+bounces-15743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF84DB154DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 23:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644D116C47F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB724275867;
	Tue, 29 Jul 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UKUdUS6b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A121D00D
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826018; cv=none; b=dZQciQu8I/jnteN4DwGeuDMrAAyYs/ZyjvNvR289ilEsCQtASqzwISYyeGizi5zoyss4Vuq2TNq8V+4Yjdd2M16oXPTaeOrXVReZjaVjd5OcC6h5LUgOvwvA3mzL6qcB8cSSAWZFpQqyoqvC6o7UnWnn9fWjGb7B04huwQWCoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826018; c=relaxed/simple;
	bh=KYwBxFiNONBJD7uytC8XivjY+9cxHWsOZLB3mWwRu6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLJC2P9CLBKo2izYtD3+Ww2yFagtZQo8tccSUdBmhvUkr4B0ZOGiAb5xXejEasZBFOOykxFa63TNg2AUlF3FWtfzSnDEKaRmkKGXaiDvRIDUdDgFKC6nQb3I7ZIcfV878HGUX+q3CElXq2H9fpkHMMnnYyPpv41a+Cv5v8a2Ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UKUdUS6b; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b780bdda21so3575355f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753826013; x=1754430813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y0AScTJzzRrxblQrKps562zdNONIZpTxG+4WD7nf7g=;
        b=UKUdUS6beYklc64xgdxETwrkbWxnNg7NKVIM1lE+9N2C/7bYSD6+XvBqtc0qr9CTjk
         32LHpqKM2AJY+sCEadm9wQOOrgH3f+WIx41/SD3MBBWaXCBXlgp/W7GmomiPURz7uPDf
         JsqMI7rlnCJ99LV4AR28KS+y3pmNDVwrl9jZ1WBwsh8BHvzbRKeqVAIl8h+RaToL9nW3
         K9oA9jiiap4A1Q3GSLcbKIx9i0KyvJKHpJr2YN7Ca3DieMjvcJVFuBgknvWWBwMQLSDr
         N3butdda0ZXizC6M7f70YNl5dr21iRt1p3j+pwoxDcxRhHvyKUV3d30HM4Od5LHKLTc2
         Rugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826013; x=1754430813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y0AScTJzzRrxblQrKps562zdNONIZpTxG+4WD7nf7g=;
        b=WDK6uWoj7sYyeVG4JPPqVzMXB6irWReGzTmcu5+SFkTOOzf3D9Gp1FJsUnghqS3LkE
         u0UWapFXptZ/huINGy2aTaosbZcUh3rS8/X1B5c0O+QH9DL7fbzqLtMkYwwerKD/x3or
         Zk8WK72QrgJkEOQorHLe0qfFhyh1bMnOb4/CbCY1yXVIkHlMCIENioFmVMiV21uFNYWg
         J1sy24UcAPgu7GKvoO2tk4nurx/7IBHHbOKTH3WwAEgGpeCQ0Z3Ju7j9r/xdrE2YqmCf
         15caDD5JvbvCF1sdyDq6SpNzAaNqAgGhhiisl2qKYpIW4LKGgzrXxfzQfQhwkJZf/nWc
         FUng==
X-Gm-Message-State: AOJu0YyhiZDPFuuIu1lqVTlkkXbxIJq46JO/KTHSCu22u6HsJ8andvuj
	VNf0spK84tlJdbeYnVZ0umsLuc61JQPAYOGCQmfExYXKQDeoEZU/X3jP1bO0yFZYbJU=
X-Gm-Gg: ASbGncsV30gV8jE+IVSD6MLisfrYgRshdfr3EsLGyJKy9VDwdCBgpdTeXZJ8oLv/z7c
	lbIzBuJfZM9mdSFnkad24cdhxMJNfYrS1Ob08hwquESUkuGHutKSn6MHJMziCuqW5xhnoZnbjQa
	lXaZ2CplI19IjSfx28A4wM5LhOSBq1jhq7ioExoMt7go11WjiUa6j0d1WqLZp8++xIDIfs+POGS
	aMAso7mwelEOtVXXV50hlZKqmVicITu4XmpFS05liwWnQi/F4jB6xA9yTlxIYJkwgtSlM5zuHG+
	zZ+SEIjpUklZPC3zD0hmxL/gRAXTRK533lJRgbgPyklkTM4q17Tf0A1yymHa9xzJfXizKLu/l5r
	WJ6IK90t/ta5ttcCchxsZ+DG2TdBjecMMX+adOw7ALTibDdD1hw==
X-Google-Smtp-Source: AGHT+IHVNHCNfsPXyH6FRLPZFObZwpdVC4bqH/xsEMB4Mck2p47SfFqfbthlzZCquUylxiTSIxi2OQ==
X-Received: by 2002:a05:6000:1a86:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3b794fc18d5mr970373f8f.1.1753826013361;
        Tue, 29 Jul 2025 14:53:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c02874sm8349757b3a.51.2025.07.29.14.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:53:32 -0700 (PDT)
Message-ID: <9fedf737-92f4-443c-a48c-b39cd5981e99@suse.com>
Date: Wed, 30 Jul 2025 07:23:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: clear block dirty if submit_one_sector()
 failed
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250729204922.3820916-1-loemra.dev@gmail.com>
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
In-Reply-To: <20250729204922.3820916-1-loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/30 06:19, Leo Martins 写道:
> On Tue, 29 Jul 2025 19:01:45 +0930 Qu Wenruo <wqu@suse.com> wrote:
> 
>> [BUG]
>> If submit_one_sector() failed, the block will be kept dirty, but with
>> their corresponding range finished in the ordered extent.
>>
>> This means if later a writeback happens again, we can hit the following
>> problems:
>>
>> - ASSERT(block_start != EXTENT_MAP_HOLE) in submit_one_sector()
>>    If the original extent map is a hole, then we can hit this case, as
>>    the new ordered extent failed, we will drop the new extent map and
>>    re-read one from the disk.
>>
>> - DEBUG_WARN() in btrfs_writepage_cow_fixup()
>>    This is because we no longer have an ordered extent for those dirty
>>    blocks. The original for them is already finished with error.
>>
>> [CAUSE]
>> The function submit_one_sector() is not following the regular error
>> handling of writeback.
>> The common practice is to clear the folio dirty, start and finish the
>> writeback for the block.
>>
>> This is normally done by extent_clear_unlock_delalloc() with
>> PAGE_START_WRITEBACK | PAGE_END_WRITEBACK flags during
>> run_delalloc_range().
>>
>> So if we keep those failed blocks dirty, they will stay in the page
>> cache and wait for the next writeback.
>>
>> And since the original ordered extent is already finished and removed,
>> depending on the original extent map, we either hit the ASSERT() inside
>> submit_one_sector(), or hit the DEBUG_WARN() in
>> btrfs_writepage_cow_fixup().
>>
>> [FIX]
>> Follow the regular error handling to clear the dirty flag for the block,
>> start and finish writeback for that block instead.
> 
> Might be a dumb question, but if the page failed to finish writeback why
> are we allowed to clear the dirty flag? Wouldn't the page still have dirty
> data?

The error is recorded into the mapping by mapping_set_error().

There is no better solution than clearing dirty and finishing the 
writeback, and that's also shared between all common fses and iomap.

Thanks,
Qu

> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index c11c93bcc7f6..f6765ddab4a7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1548,7 +1548,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>>   
>>   /*
>>    * Return 0 if we have submitted or queued the sector for submission.
>> - * Return <0 for critical errors.
>> + * Return <0 for critical errors, and the sector will have its dirty flag cleared.
>>    *
>>    * Caller should make sure filepos < i_size and handle filepos >= i_size case.
>>    */
>> @@ -1571,8 +1571,19 @@ static int submit_one_sector(struct btrfs_inode *inode,
>>   	ASSERT(filepos < i_size);
>>   
>>   	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
>> -	if (IS_ERR(em))
>> -		return PTR_ERR(em);
>> +	if (IS_ERR(em)) {
>> +		int ret = PTR_ERR(em);
>> +
>> +		/*
>> +		 * When submission failed, we should still clear the folio dirty.
>> +		 * Or the folio will be written back again but without any
>> +		 * ordered extent.
>> +		 */
>> +		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
>> +		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
>> +		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
>> +		return ret;
>> +	}
>>   
>>   	extent_offset = filepos - em->start;
>>   	em_end = btrfs_extent_map_end(em);
>> @@ -1702,8 +1713,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
>>   	 * Here we set writeback and clear for the range. If the full folio
>>   	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
>>   	 *
>> -	 * If we hit any error, the corresponding sector will still be dirty
>> -	 * thus no need to clear PAGECACHE_TAG_DIRTY.
>> +	 * If we hit any error, the corresponding sector will still have its
>> +	 * dirty flag cleared and finish writeback just like below, thus
>> +	 * no need to handle error case either.
>>   	 */
>>   	if (!submitted_io && !error) {
>>   		btrfs_folio_set_writeback(fs_info, folio, start, len);
>> -- 
>> 2.50.1
> 
> Sent using hkml (https://github.com/sjp38/hackermail)


