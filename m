Return-Path: <linux-btrfs+bounces-19183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC6C72409
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 06:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 251F1352172
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 05:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05142FBE1C;
	Thu, 20 Nov 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWo0gNBr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEE2D97BA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763616532; cv=none; b=jMG8kmvMaEsxFMtsbf2dO3lZuywdwYdIbICvPm0T+mIK8bmt5GlKdWq914Z0xj9AqoyiIuT1Vasx5dNOfkRpyEzrtEoPxroXwUTjNynOg4uuF0DayeufdKYvFLTGhUQEgzULN20fjisw1Ni/U/Ix+DL7dROblLDjWym42JXMh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763616532; c=relaxed/simple;
	bh=XcdaVYRVfkhTRSqDrCvgHXesOhk+ed98nmiqe2opk0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLtiL8L9chZk87W6hEcOkFV9DnqyurQx5/7QruZ95yFNBcitlpwQMLkav0JdLI0pPTAZCi3dlwyT/U7g5ZkZ8CLKlOoK3G/Ke4770+Rz0T/Vo7xVtidwtKesEYyUyDzluhMv9A3vqyEwhGrrcVMLKnzVjp7uoQLid55BE/jhks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWo0gNBr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so3934055e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 21:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763616528; x=1764221328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0qCW++nGmEwoDl6IKjIyG4J2Eh1bkC0XGDZCYpt2wo4=;
        b=CWo0gNBrIzekaZzHDwrRaNx9QIoOzKV5aJjTvvRdqsnMKlKWosGYNW2rz+oF/oSuAZ
         szZIMAXpkft0XJ5mRoKVW4DqA67w6yOMs4OeaKvRzJ8fOHDdOcghSNiKh5i6Yexy+MsK
         kwcFfiwQIBVZ5kcsB3+b51gIqrPlLOjv4eWWmNhBzhwm7YY8rYsQaZssR2rHKuOJ0qLD
         kq27vgyAhkbMZZrRogu4GmcAfs5WcScJ6h9Db+bhnhbtL6IUzF4LCZEztPJ1sxLaW97E
         pgtunkEWxYnDou5GXsR8Qhbzn5NHWpyrfzKHiup4G8Um7B1g0fEBIKBzrXMeyEb0L55X
         g3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616528; x=1764221328;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qCW++nGmEwoDl6IKjIyG4J2Eh1bkC0XGDZCYpt2wo4=;
        b=LdDa8nNkKnmOpapWk/RT3NxpWXAn8hWc/IZvc/ELq/A9lMgsSqTGI4oi6MYMymIwwr
         HiAKefehnXv1NClquUV80pmeghnYcs80fE5Sh7hPFfI+tw6zWzndlt3qfzmIkRlE5OUp
         Rt+oWeflv9fDlf9PWm69w/g5LS5aSTJnLCGiz8aMBF2OjKQC6F8wWlj5vtmVBEn+5u6n
         CJi9LK+CXEVZqghyOrrLsb4RmVienVQSV9ddopBQ0lR35kCROm3ffsRLds/nqERyEjKM
         5zeRB4h9c6H+KthoTRR+hd1ksP1mvOWU6YNoF51MO7fthCv3eFDhkpc2W8Rgncdc7cFW
         ApyA==
X-Gm-Message-State: AOJu0YzoVtkaOwVTznOyT7MXToneqVJiKEv5tZpHxYD4b+8XJ95rFm8N
	tQfjB8w6V/irDc4WhboLsROzW3WJQiIzvHKh4vYeK22GzFbewbg7G2pA46Oal4JjPWg=
X-Gm-Gg: ASbGnct4Yz5I0XAYWtOZxdohHivkhtZqLUzpDWBSRkRyKCMIugnwe2sIrYijbMYT94R
	q6vjY2X7gXhL6pBLf63rbwgDlX8bB+poMeJ0u5MLuTbSM1PYS1+vRyFa05Of25kJLmFcORpV8wG
	Z4YwWTr0QuwSGQ3VcP6rMgfjyDHU5x++mv5ZoHsRItv9OoIGcksn1C0S0uC/k2NedrgKfAUvZRH
	uqlHLY7hvU47UNY7A57t4g6oooc4uMilBJkHH9X1sG2NQ2d6ISs7RLU3d05xb1TVzzTSK1e6cWO
	KF3lLrgwTSEx//ckjVPiRK6kaTjj6AwkVyRB4Qafm0KkK8qgm3SuQG3sUsGqWlFWcgW9IqyAp7+
	rbpU/oXchMDhmL8mtjQWd7tnR1dmEo1Hr7cbiTLFmKVedsvZr3isSjm2nDG2ExusO8qjK47s2Hb
	kyBV7Kp5uX4Vmn5fH4G9qyWeudzRwKlwJaVcgQbN4=
X-Google-Smtp-Source: AGHT+IF4u0eZekjl+IgKE/H6wDAsM7EuiY/I2n04f+c5ZplvVS75Qal8XicXwQRzMQB/lREXrAFtfw==
X-Received: by 2002:a05:600c:35ce:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-477b85790bemr20908305e9.2.1763616528255;
        Wed, 19 Nov 2025 21:28:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024adcfsm1239466b3a.31.2025.11.19.21.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 21:28:47 -0800 (PST)
Message-ID: <40dd02f6-5e28-4fb2-af93-4c07dc9bb0fa@suse.com>
Date: Thu, 20 Nov 2025 15:58:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: reduce extent map lookup during writes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763596717.git.wqu@suse.com>
 <a6869c2d5f3b8cdd3360375ea64d0449c97dfd6d.1763596717.git.wqu@suse.com>
 <20251120011626.GB2522273@zen.localdomain>
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
In-Reply-To: <20251120011626.GB2522273@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/20 11:46, Boris Burkov 写道:
> On Thu, Nov 20, 2025 at 10:34:33AM +1030, Qu Wenruo wrote:
>> With large data folios supports, even on x86_64 we can hit a folio that
>> contains several fs blocks.
>>
>> In that case, we still need to call btrfs_get_extent() for each block,
>> as our submission path is still iterating each fs block and submit them
>> one by one. This reduces the benefit of large folios.
>>
>> Change the behavior to submit the whole range when possible, this is
>> done by:
>>
>> - Use for_each_set_bitrange() instead of for_each_set_bit()
>>    Now we can get a contiguous range to submit instead of a single fs
>>    block.
>>
>> - Handle blocks beyond EOF in one go
>>    This is pretty much the same as the old behavior, but for a range
>>    crossing i_size, we finish the range beyond i_size first, then submit
>>    the remaining.
>>
>> - Submit the contiguous range in one go
>>    Although we still need to consider the extent map boundary.
>>
>> - Remove submit_one_sector()
>>    As it's no longer utilized.
>>
> 
> This is very cool, quite excited about it. A couple questions inline but
> the approach looks good to me overall.
> 
> Also, I was curious and looked at writepage_delalloc and that also uses
> for_each_set_bit(...) though with simpler stuff in the loop
> (btrfs_folio_set_lock) though I wonder if that can be simplified as well.

Thanks for catching that one.

I'll check for any similar call sites and do the conversion in the next 
update.

> 
> Thanks,
> Boris
> 
[...]
>> +	while (cur < start + len) {
>> +		struct extent_map *em;
>> +		u64 block_start;
>> +		u64 disk_bytenr;
>> +		u64 extent_offset;
>> +		u64 em_end;
>> +		u32 cur_len = start + len - cur;
>> +
>> +		em = btrfs_get_extent(inode, NULL, cur, sectorsize);
> 
> why is sectorsize still relevant? Just a small size to grab an
> overlapping em or something more meaningful?

This in fact is a pretty important error handling for some corner cases.

Normally we should always have an extent map for the dirty ranges, but 
if we hit some situation like the following:

                          0          16K         32K
Dirty range:             |//////////////////////|
Em range:                |          |///////////|

If we call btrfs_get_extent() with cur == 0, len == 32K, we can get an 
em at 16K, and that can screw up our calculation.

So here we should keep the sectorsize as len to catch above situation.

I'll add an comment about the hidden error handling situation.

> 
>> +		if (IS_ERR(em)) {
>> +			/*
>> +			 * bio_ctrl may contain a bio crossing several folios.
>> +			 * Submit it immediately so that the bio has a chance
>> +			 * to finish normally, other than marked as error.
>> +			 */
>> +			submit_one_bio(bio_ctrl);
>> +
>> +			/*
>> +			 * When submission failed, we should still clear the folio dirty.
>> +			 * Or the folio will be written back again but without any
>> +			 * ordered extent.
>> +			 */
>> +			btrfs_folio_clear_dirty(fs_info, folio, cur, len);
>> +			btrfs_folio_set_writeback(fs_info, folio, cur, len);
>> +			btrfs_folio_clear_writeback(fs_info, folio, cur, len);
> 
> cur, cur_len? or start, len? cur, len feels wrong

Oh, thanks for catching this one, it should be @cur, @cur_len.

.
> 
>> +
>> +			/*
>> +			 * Since there is no bio submitted to finish the ordered
>> +			 * extent, we have to manually finish this sector.
>> +			 */
>> +			btrfs_mark_ordered_io_finished(inode, folio, cur, len, false);
> 
> Same question about cur, len; also I don't know if the comment referring
> to "this sector" still makes sense. Manually finish this ordered_extent
> or something?

I'll fix the the comment too.

Thanks,
Qu

>>


