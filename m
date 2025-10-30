Return-Path: <linux-btrfs+bounces-18424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BA9C22406
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6EF64E6EC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 20:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C13329E7D;
	Thu, 30 Oct 2025 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fc06X/TV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3500325487
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856330; cv=none; b=Due4pJK+F4rtND8gPtuFcNzqS551R1ds7WiN9k2WgvnjJ1lgsWfzTMiTMQSyTYgWeOTlDF9+fqvZGVN+RGcBOloQvsI1by9GbESi4j19X9lDtfJDFVttO2w1/v/R9QCC/txks6GxSPq9FYbS3ATyawS8WIB+u1O3ZbupxrBAtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856330; c=relaxed/simple;
	bh=NAQS0SEmjuyJxQGMTQ/vtytEZzmRrLpx+PqVe3ur/Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8OFllQHcuV6YjTvUqLG88IusubE+1Kn+tyivGUZMs19iPN2wVnN/2r6ZkmkhbjBvPvBKBToep6MX5UmBHaNPDUV/b49vuZD1kXtOkrcvwW250wIkCUbi5rpNRxquCxmN3ehZA7k/zJMMXRTPQmuQImPYdFwF+sVjRAK9oZ/Du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fc06X/TV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1003169f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761856327; x=1762461127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cPBXXD0Qop14CKNAaMhxLEWhtT3CL1F1mn/gJaNRYBI=;
        b=Fc06X/TVT6j/WkNqgDiyoVwqqssJ2Fj98kNyxV77OOaALFs7hxPbvO0yIn53vjav/Y
         cX2R5GR3cF5+oHpftFp7sipAmMuMUi6zSimkeJ8mQksTkCDHCxz0stQXB95bvwacf3Rn
         2PxRsW03/WlhXNy28uJ7E2DJrHcQSDpc8nFV3lQcNqfwF4OQLlwhwGv2yPDzyCv1wz8a
         rshvyxv60UfrFYzKxCSzusxgHSh3YcXkc2cL29d/GUu8/ZWq/eGc5Cpjh/3y9gDWRrfl
         aaFIxKOF9QGH08mljwvChK7XGyLZ0YSPksoYJZW4CKmo6kmUP+mVs3wHkdD2v/5SQfcQ
         uAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761856327; x=1762461127;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPBXXD0Qop14CKNAaMhxLEWhtT3CL1F1mn/gJaNRYBI=;
        b=wvPdQhD+zB15TKD2OVS5RrJuDQcTHqMOx4kiJTt2wuBY3nMr8wevotu1N/R4/DJRnc
         VKLVRzGXppf/LKqA3Ykhktnpyka9H+UbhRORrKv4lMLbLp/ld9ynTYXFGmvMtpMWWpXc
         pOIZk531ZDXMgBwIGBTzuhc9FIHV7kOsIV6MenjDaobLl6TV9nOu4MjgZAZERTElN/hQ
         DmBRvlvJeN4IkOqSOHG4SivJ/Iz8fLokZNk79RlBqrUUYEs7uuhcUukAZZwFDWny98n/
         +XEGPmO6hdozI7k02T4ArCVhcOu788NOeQu74bHrN/x4M7KaDI6TYhR7dBPl9sgNgBs/
         r8Wg==
X-Gm-Message-State: AOJu0Yysm7/I47DM38Jn9w3DTQvrJgzBiy9+4iVtSjBhE/1qrgTCfAbI
	5QSX3jlt41poWg/O0lMdoi97gZtfg8OXSpIHoiF3KeoI+JUEuBTOnXZaNaC0aAT+k6ZZxtsaxvl
	wfXyw
X-Gm-Gg: ASbGnctoWlNlVXHW1UYF4Zq+qGyixAb2yF8utAnKTt1hGApTGV5zsqlZxoR49OQQX18
	UB+DTXvLb+R/sMZKA7Q5BGetxvYHofTWlDSRK+WUSubFADHlhwxpnGZdvCGSMQGsSBo7NW/bx/X
	UiZSr+RzU1Si4sIgB4DB7I6Yni4g855XwO/ikjnpiBwuGzumYRPPLBa42fPXTB/LY16GBz4cFQH
	/ID1LplBqbLZNJIC6hyG477xrA4QE39ESYEIaWsUjcVvqURJGtyUoq5yBlnmadn7tFrYW5BBiYY
	BLQ6k+3AB6Y/3+lxJyOImygn2FLf5LGaZOXz1aTEI5Zo5XVqeEN4CXn3M8EvCDI2abzRKl3Knqe
	gu5EhXaEr7wxm6in+tT3WPKlbiO+RGSCNy7vPUgehGmNJeGzEJonpMXAMWf0xL8ye5gqXBn3uig
	srNosGECKOdV9HAHoRUVzBsEmSthKoApHnwbwhQ6c=
X-Google-Smtp-Source: AGHT+IHS3eg6lHFUB8wwVwThbgM00O4/3L5yuNkxdr3EFeQzDLspsAH5J5s/BsBIC+Y8uCdOFtFCtQ==
X-Received: by 2002:a05:6000:25ca:b0:428:1dca:ffff with SMTP id ffacd0b85a97d-429bd6add64mr842013f8f.38.1761856326724;
        Thu, 30 Oct 2025 13:32:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414035ecesm19823123b3a.27.2025.10.30.13.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:32:06 -0700 (PDT)
Message-ID: <bf9bf126-9bfb-4fc5-9494-fd71cff83049@suse.com>
Date: Fri, 31 Oct 2025 07:02:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond
 device size
To: Filipe Manana <fdmanana@kernel.org>, Yuwei Han <hrx@bupt.moe>
Cc: linux-btrfs@vger.kernel.org
References: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
 <FDBD17D73E911416+7ade80f6-f273-4190-83e9-61e98aeac808@bupt.moe>
 <CAL3q7H66j2NczLbXj6ZJmy_fu1uPHMHfG_Xit-Kgw7_V+0VSdw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H66j2NczLbXj6ZJmy_fu1uPHMHfG_Xit-Kgw7_V+0VSdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/30 23:54, Filipe Manana 写道:
> On Thu, Oct 30, 2025 at 4:17 AM Yuwei Han <hrx@bupt.moe> wrote:
>>
>>
>>
>> 在 2025/10/25 07:30, Qu Wenruo 写道:
>>> [BUG]
>>> There is a bug report that kernel is rejecting a converted btrfs that
>>> has dev extents beyond device boundary.
>>>
>>> The invovled device extent is at 999627694980, length is 30924800,
>>> meanwhile the device is 999658557440.
>>>
>>> The device is size not aligned to 64K, meanwhile the dev extent is
>>> aligned to 64K.
>>>
>>> [CAUSE]
>>> For converted btrfs, the source fs has all its freedom to choose its
>>> size, as long as it's aligned to the fs block size.
>>>
>>> So when adding new converted data block groups we need to do extra
>>> alignment, but in make_convert_data_block_groups() we are rounding up
>>> the end, which can exceed the device size.
>>>
>>> [FIX]
>>> Instead of rounding up to stripe boundary, rounding it down to prevent
>>> going beyond the device boundary.
>>>
>> Reported-by: Andieqqq <zeige265975@gmail.com>
> 
> While at it, also add a Link tag pointing to the report....

Sorry, no public report available.

I got a lot of private reports forwarded from Yuwei, as a lot of people 
behind the Great Firewall are not used to github/mail to report a bug.

And this is one example of such private report.

Thanks,
Qu

> 
>> Signed-off-by: Qu Wenruo
>> <wqu@suse.com>
>>> ---
>>>    convert/main.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/convert/main.c b/convert/main.c
>>> index e279e3d40c5f..5c40c08ddd72 100644
>>> --- a/convert/main.c
>>> +++ b/convert/main.c
>>> @@ -948,8 +948,8 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
>>>                        u64 cur_backup = cur;
>>>
>>>                        len = min(max_chunk_size,
>>> -                               round_up(cache->start + cache->size,
>>> -                                        BTRFS_STRIPE_LEN) - cur);
>>> +                               round_down(cache->start + cache->size,
>>> +                                          BTRFS_STRIPE_LEN) - cur);
>>>                        ret = btrfs_alloc_data_chunk(trans, fs_info, &cur_backup, len);
>>>                        if (ret < 0)
>>>                                break;
>>


