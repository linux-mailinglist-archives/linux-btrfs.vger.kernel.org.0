Return-Path: <linux-btrfs+bounces-14077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F5FAB95E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 08:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90314E75A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6F223328;
	Fri, 16 May 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FoDujAxy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BD149DF0
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376274; cv=none; b=Y3uXWPbL0wDEjQeI9iM36B2ZO8nMoVp+gw0qViaphfV1c4C7pr5p6eH8Q6RTE5H7q3Z5tu1g5VLDnUN1VWbbpR2xHSsWRuaW1Y0Zj8SWZM7kfDWB4HYwWTsaVNsvBotD7xCKnHSRLENCifgo7ml4Kr83my89ZXcWkED7XPbzPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376274; c=relaxed/simple;
	bh=QmnZVckD7GStQPgm01jF8Okjc51LWvMHHYKns6y7Poo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tN/vpb/NKien+ingJdMyCmSp0qpgEWOhR7pet2AAIZLxZ5fEQBMDuaev6dtxoQiylKfvkxlq6Kj8kWB6J2YYNAekN9u2OznMAnpWeGaNMX2f6zEdlks/deSoUGCc2yjA6qajppefqfP4r1v+ntmdyQbF1k2fczZczYE7RA5GR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FoDujAxy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so16480015e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747376270; x=1747981070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hwFTaPa27O9IQQGVkpCd8K2Lb51owfetj3W+j+04t5k=;
        b=FoDujAxygxsYZtoVj+UntScs7xy8kesOHFL1NSjhXMUdjjyHZK2meDRYc5r+lZRcvh
         XmYQUIhx1D8IcELaRCYgCOUxq2yh1eBfsnRjevGUeuVb9ooACxM9gCI5Bu5b8neoyEgp
         hWBu82gTQ6/60Xfz0K6hDcvl54e7UpkyoodQaBzf8jdkJVEXu1HSg0oUaagWe8/H5Egs
         qyauL8Hp9n0vwf1MR0U+rdaxKmC0XE6rJ4f8yfaduGf1ZlxWwDNwCZ6ws0Lg9A/63YSx
         7wWcrV9M62AimJB61SWw3gs+2PDetnxwRfXiXDEBtYeb7sGQ46RAGSLrCm659fT2G7x/
         axMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747376270; x=1747981070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwFTaPa27O9IQQGVkpCd8K2Lb51owfetj3W+j+04t5k=;
        b=a2ac6xzfiRn8FXcBRrUpPMB203rYf9R+Dgd0FFwc1cmse+rdIDQvRo/H+C4Skc1MTX
         l5uPs4Z11L87dkEnqaMHzWabkA1BdPCQ2+2nouiEgCslErxqxZlCNZrrkUIGQrGA9fbK
         XmB1ZEC+VESn2Bi3u4qif3cQUaGPkomkZRDCCWXEhIIaLgJWMtvH0p/2tVpGanfVdhe2
         Y8lB826iASuuXj7Bgc36DQ/Ltjz46QnjssacmEoVoBOAy86LE2cmP+sYIOdyH1ZupYIp
         0GxGZENMBPlsA/UvpeAAKakeQbx7zEFACvkmGbHoX1j3x15TzynkFXpt1w+54RsMwfVa
         lfeQ==
X-Gm-Message-State: AOJu0YzP2JZP7u4LNLkVhTWkXusAbGvYMlv5njjOukP6PlzsbmOnwThU
	O+69qGh8g9QOV52eOmKETR7iv+8QMiwnD39Is4enRvdX4lH8NqiaYYlfsw2snZrtgNM=
X-Gm-Gg: ASbGncv7+iH6GOj8qkAbJB4cO3MzKdGjUTTLvZ+laXGg6VtaRUk5g4agBCAkuCRB5HZ
	BtNjPWUN5GBovwNB05aomo2ZSH1viG2yx5VgfCXnaOdotGWWZYeS60hg3K5m5mQHAKuZqQdGjch
	uA0zBappTz2kGDWFQgyqhsIa1/nQmOdqkeh+LxPaw8nfJzUpA+5SC5BlM/32dixDQSHgunT02St
	TjDq9qefRtlbEmSC1izYquHtAPw5YRI34vpcSSV0RbRJQI1d0sISwemTwWibRoS/vHu1ztJK/h2
	+p6Sgh14HHIhj1I3BeARR0jGwst5Ix5XgLqb+yVTd/mY15UiZUATgfuMRguHNl7AAGFO3S2Etrf
	5lPY=
X-Google-Smtp-Source: AGHT+IEhiLse0ra8q6b3drOyFaJuhmCIb7phJHkAM0PB6kOOGdAZ6CQGJkm4gqQS4ytsd2RlguadqQ==
X-Received: by 2002:a05:6000:1843:b0:3a0:b0db:24c6 with SMTP id ffacd0b85a97d-3a3511d5c66mr6173890f8f.15.1747376269807;
        Thu, 15 May 2025 23:17:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac95cbsm7476065ad.45.2025.05.15.23.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 23:17:49 -0700 (PDT)
Message-ID: <cc1ea549-b2ee-490b-82e3-a53a4a1bf34f@suse.com>
Date: Fri, 16 May 2025 15:47:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
To: Anand Jain <anand.jain@oracle.com>, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <adb7e0b9365da95d9497c4cde18233f3e52e41df.1747364822.git.anand.jain@oracle.com>
 <96747079-c47b-4df6-8200-90ba91220c20@gmx.com>
 <bb54583e-3017-4636-b31f-f50fc847294a@oracle.com>
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
In-Reply-To: <bb54583e-3017-4636-b31f-f50fc847294a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/16 15:37, Anand Jain 写道:
> 
> 
> On 16/5/25 12:25, Qu Wenruo wrote:
>>
>>
>> 在 2025/5/16 13:27, Anand Jain 写道:
>>> Below is the dmesg output for the failing scrub. Since scrub messages 
>>> are
>>> prefixed with "scrub:", please add this to the missing error/warn/ 
>>> info as
>>> well. It helps dmesg grep for monitoring and debug.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v2:
>>>   Fix remaining scrub warn|info|erro missing the "scrub:" prefix (per 
>>> David’s review, ty).
>>>   Drop rb
>>>   Drop Fixes:
>>>   Update git commit log
>>>
>>>   fs/btrfs/ioctl.c |  3 ++-
>>>   fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
>>>   2 files changed, 30 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index a498fe524c90..680a5fdf89c3 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -3142,7 +3142,8 @@ static long btrfs_ioctl_scrub(struct file 
>>> *file, void __user *arg)
>>>           return -EPERM;
>>>       if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>>> -        btrfs_err(fs_info, "scrub is not supported on extent tree v2 
>>> yet");
>>> +        btrfs_err(fs_info,
>>> +                 "scrub: scrub not yet supported extent tree v2");
>>
>> Duplicated "scrub", please drop one and change the phrase.
>>
> 
> I saw that too, but the sentence after 'scrub:' didn't sound correct.
> I'm fine either way — could this be fixed at merge? Thanks.

Something like "scrub: extent tree v2 not yet supported" would be enough.

Sure, such small change is totally fine at merge time.

Thanks,
Qu

> 
> 
>> The remaining looks good to me.
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
> 
> Thx.
> Anand
> 
>> Thanks,
>> Qu
> 


