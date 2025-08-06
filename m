Return-Path: <linux-btrfs+bounces-15889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95078B1C05D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5410C188CE4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7320E005;
	Wed,  6 Aug 2025 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TwdvJhBQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E250207A22
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460908; cv=none; b=M6Vvaelhe/XxfQrtJ82bV8MzVzGzUTxBjvhYCS/pdg88TuVfNHAA3bdbNjqF/GMa5rndccv6TnuhUq850pLDDgp1+NrtnIPQ5Cz6oeSgPF2QQF6FclY5tFwCeX93rCim41uLJZeeZldZPq5ysH+US4Hkz1QwyIHdsj+lYmOMT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460908; c=relaxed/simple;
	bh=H3aNDDJO5BF7AwQWNeVCbqRX3BjJ6fG6Yr1KI8wc2Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WmGob7vbyDKtbos6g+KtvttrKmzEApqKz3grp7O6CLXfIKB/KK6+rd7Nt6lw0h7+/OH8dIkQ0uM/beqzveOwovF7RUmAOKFe8NMfOwxYPyhf2sh+zfRDkw5aW3dvv5iBNI+SHuSSOtt8hQXN24se4lVcu1+Uay15TQ3L7q+4pPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TwdvJhBQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso271713f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754460904; x=1755065704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/65Lhh+bvsp8mF/1AZ5//DcPbITffWFrgvWl97dfBVs=;
        b=TwdvJhBQ78oVuMhCy7NXQKLJTSPd4AJJcOyqAD3urgmeu9WYVrIMYtFKdXyQhflaf8
         uxRGQrM6hp1RsxzrZUOC5fwnakWfYEQgc7v9Pn/iYglnY6v1+BmlkbDLrtM2mJlAanfv
         uH2Mq8IEYK62q5GMWRkvQj4hNs+DHoeTWSp2i9yAHCj6sjF8mPxTnywULZdB6TqRPaIv
         mlJQPYr75WwA9ul/qKlJI45jIK+XiNw5a5Lte8F1+q0Le6g2QWXBe5zxCCcrfLX51IGb
         Xt3VS2UDTtyc1eJ1+WIFywmkA4QJzFosP9TlYEBN0aniYSTF0Ckmr6PBByhWVvVFYqIK
         Iivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754460904; x=1755065704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/65Lhh+bvsp8mF/1AZ5//DcPbITffWFrgvWl97dfBVs=;
        b=olCuEU/Jq5s6EtEe6ZCeiG9U5ANaDWFvK/JTNPlmT1oADKwfU9UzLFprMt614P8wE+
         xh6v0G0pv00PXEY+zM6SdkLum6DS2I3NpYAsQXWux++Fll2lcAm2+fykBW+pdo4kKxZy
         3W2geJNu2fhvhcg6tc1Kw3pXt3y95cs/E55qHs9FBxH4lyJfUCCqBIsE1FmgoNaV/+Ha
         WIQHD/wuCxnPjCDD1OfLDAPQf5eFWxVrDDGfv3ZjtLdFNS9jbQDAqr3SwQlAGiN/IuT7
         FxTo/Pnhz5RqUbUK5A7RosBoepenTMavHCqAymCSdMwLP6+6qT5Jc7Ly3fDkEPxi2m9J
         yMYw==
X-Forwarded-Encrypted: i=1; AJvYcCW5nVbY1gfSA03Tubq3QacFWo7UD2x0LzJudUJ4cu0s6hnx5Hu9GgM/Ewa/giKUD65Bn89yvtQnsRE4NA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03a2klI7TjelLXRfMDv2hsrfYs85M9vZUHA3XS7fW23TmgD8G
	0EI9ZUWVqB535cOn/6HSeVMgVV1p4jOCAR7X/puvkRlfMz/PQ1B+QHHPx3tH4w8qp+0=
X-Gm-Gg: ASbGncv5LjaWldzgCQlRoJxftt/DUtWjo2mbST72kA5ZZXSjdUbUBNS/2SuW0XZLcZX
	zncDgddfsoVOzAEd2H2gw8uFBNUD87kK0sVXCxwej6bXfy6hTiNvpTe3Gxf6Kp91PNtkjGkeBVj
	1Ix8Wd7jmCXwFJ5dygksNMXged9QXWrT3ntYkfdkO3bhfY+biEeLU5A70/iXvhTUhM+VZu5ZX3A
	5CGO0YTtRcv3R6Coq/HMsmRWZAsRJsYuyLAySuuyQhFEHYrT3lZwxid7ufFYAuHaQAikv5jz/7y
	zp+FCGHiEawwNNCmRBf0MRBbpJ8SaQ+lNd/GCyIUEiF16Gx1YpeSa8hjELliAWrG5+zD+Z8kMW5
	7pOyQ2Ixib6I7VELBf30ybP9TV0XNCWkd0KTOTNZEAEIaiojTfg==
X-Google-Smtp-Source: AGHT+IEHTgdxJRXps6ABH8wwAJLNiKruLU7t7a2pb5/5MXspSp3YAKKbqa43LzsPqWG3lCtJN0gOgg==
X-Received: by 2002:a05:6000:2385:b0:3b6:d0d:79c1 with SMTP id ffacd0b85a97d-3b8f4316685mr1037470f8f.10.1754460904084;
        Tue, 05 Aug 2025 23:15:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaac0esm150003505ad.152.2025.08.05.23.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 23:15:03 -0700 (PDT)
Message-ID: <bfee8819-5a5b-47d8-90a5-66d053c90cab@suse.com>
Date: Wed, 6 Aug 2025 15:45:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
 <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
 <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
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
In-Reply-To: <6baaa8ad-5cbf-43b2-b7cd-c04572c9952d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/6 15:31, Anand Jain 写道:
> 
> 
> On 6/8/25 13:06, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/6 02:44, Anand Jain 写道:
>>> Some devices may advertise discard support but have discard_max_bytes=0,
>>> effectively disabling it. Add a check to read discard_max_bytes and
>>> treat zero as no discard support.
>>>
>>> Example:
>>> $ cat /sys/block/sda/queue/discard_granularity
>>> 512
>>>
>>> $ ./mkfs.btrfs -vvv -f /dev/sda
>>> ...
>>> Performing full device TRIM /dev/sda (3.00GiB) ...
>>> discard_range ret -1 errno Operation not supported
>>
>> Where does the error come from?
>>
>> In device_discard_blocks() it just calls discard_range() in steps, nor 
>> discard_range() itself would output error message.
>>
> 
> Its from the my own added debug message at
> 
>          if (ioctl(fd, BLKDISCARD, &range) < 0)

So you're only fixing a message caused by a patch not in upstream progs?
> 
>>> ...
>>>
>>> Fix is to also check discard_max_bytes for a non-zero value.
>>>
>>> $ cat /sys/block/sda/queue/discard_max_bytes
>>> 0
>>>
>>> Helps avoid false positives in discard capability detection.
>>
>> Since there is no error message and the error code is either ignored 
>> (in btrfs_prepare_device()) or properly handled (in btrfs_reset_zones).
>>
>> So I didn't see how the false positives are even possible.
>>
> 
> discard_granularity suggests discard is supported, but it's actually not
> discard_max_bytes is zero. So the discard_granularity check gives a
> false positive.
> ----
> $ cat /sys/block/sda/queue/discard_granularity
> 512
> 
> $ cat /sys/block/sda/queue/discard_max_bytes
> 0
> ----
> 
> If the line is confusing, I’ll remove it.

I understand the sysfs problem, but since there is no such error message 
in the first place, it won't cause any confusion, thus I see nothing to 
fix in progs.

Thanks,
Qu

> 
> Thanks, Anand
> 
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> v1: https://lore.kernel.org/linux- 
>>> btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/
>>>
>>> v2: Checks for discard_max_bytes().
>>>
>>>   common/device-utils.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>> index 783d79555446..d110292fe718 100644
>>> --- a/common/device-utils.c
>>> +++ b/common/device-utils.c
>>> @@ -76,6 +76,17 @@ static int discard_supported(const char *device)
>>>           }
>>>       }
>>> +    ret = device_get_queue_param(device, "discard_max_bytes", buf, 
>>> sizeof(buf));
>>> +    if (ret == 0) {
>>> +        pr_verbose(3, "cannot read discard_max_bytes for %s\n", 
>>> device);
>>> +        return 0;
>>> +    } else {
>>> +        if (atoi(buf) == 0) {
>>> +            pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
>>> +            return 0;
>>> +        }
>>> +    }
>>> +
>>>       return 1;
>>>   }
>>
> 


