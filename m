Return-Path: <linux-btrfs+bounces-15921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F81B1E1EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 08:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18468189F577
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 06:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A032185BD;
	Fri,  8 Aug 2025 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E5N3Op/W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC56367
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633162; cv=none; b=ZH+UnoFMn5mJCgVrv3gaTs6QS8S85vcDoG4AmKv93IKAqVmE8PO6Am21xIGTO6e01xddm0WG17WU84dW84AWwri7Rmy7Dcn8zZ1q/HdKtjo56nlSgyMPaB3BLyEKAIwd5QMD0xSjPrx5/nokipEEvQSyIRNNFwlp8JXFY0hVyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633162; c=relaxed/simple;
	bh=cR8ibsg5XtSXS4ewezvC6ZZOQOQimfKN0/sNomS95jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/djM48Qun2xxKHvMDXFqi37IJzbUsA0RSDCbU4OQpHXth+77BUY3yeRDX1vu+MwcFS6Y14zRfgrUb5OSOr/egcfUmzxhhLJ26UZ7A4UL5a06L5b6QqR/amsw0YtVbrkYFGJkluYGYBFjuaCdk4DmlUbVZiJY/lL9oPH603JnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5N3Op/W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so1001132f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754633158; x=1755237958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3pa0OAjQPrH1bZ2YX7OPaAjAp7bFQgNPIef1Ic+aR8=;
        b=E5N3Op/WijkE5pcw8Kmdg8y7EI/qPBrtemKrn5w4Bm6Ta9WVcQP9xZzupip7I6IhLN
         jC7n7asLXyOgA8n+gr/0/QZEkZ0ZQSMc+SitvuFX0k3RrzKjHQaUufcnEUFb6OfsSAvP
         HS/ri5lhhoOq6WC/Lj/FolKdbUEHFirH5c4qnaQiGcodqDkgNxw1CsaTRgTRaSnT/RTN
         bygwZ9by038+FGlBAI2vSm2zwyPG+ei9t6+u3fS5851NOD0DDxrNeaHCLeqp0rvZ4yo+
         7wAFlm922YLnqVw5xd2p9/4FDWeJhYNCyl7Z1CvmnwwCOqngoJHNVYvsqadhRu87gqVZ
         b0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633158; x=1755237958;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3pa0OAjQPrH1bZ2YX7OPaAjAp7bFQgNPIef1Ic+aR8=;
        b=kvFwXrua5BnaAhsQliM32+5dz9w2hK4wCrbE/vTXqsyJyBy+EV9K/HWqknOdwu7r8G
         keXAOYnkVF8ayKEVs++Zrmf+dcyODjEiKJh0CaM1hxnPe5n9XhBfTh96eQMtFnUMraIB
         msCZOZqSH3LFYxBppCWGfK+wTuUMwl/1ocT7B6NqeW/lxU/swQB9uzHaK7U0UL3PFqjf
         7rq9s/Y6imYcbCAb3yt75rBU6CQKVhLUfT74KRhF4NArVqMDuLRG5HS+8tIJBPy1HZZ1
         zzoNd/KpmOBnO1sLaEF7k2kZpz7n9xHXZSzQfWqJ5Ld6iuEP8y7T7+M40dIhlo2u5pfo
         /esQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhWvnKGwSH9cpe2XLH/46RiLpOP7OlUxQ7k48YDBmuJsVr537L+YCTGn+I+y6H7v4ykc+sw+COnYpbDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEru/0JeWjrjCTgBkKWTHCx2x9Aiw7ZvboDH/OQl0YFSu8Ki4X
	hvRNV3Cm7CFTUiG+eBcRpCywrXfQUStr6ViNbrsxySU747wp6A22Rlwjr34o4GXJXOUjd2/Vehc
	AdJib
X-Gm-Gg: ASbGncvY5Ah1raa/xleLsIMKIUXWbf/RSuvY4Tnj1Fgp3wd3v0O6znN0OQfzj/P5paV
	yznHFEHROSJ7hfv/1WEI6rHi+T7CljE4hbCusF+ogoimZgfW716KwtIYTZOMlD8ODEAX9IwU+wo
	/dox9QlY5qt7d/Rt6D7CTlR0pvs8y+9olEvLFnp9E21Pp0ptRNAkJrRKK3bx6e2/B8bg9YCXtQP
	UwITQHJEv+tElJY053uR8oSzUbKp6y2fsK0inVsWKZ2hro812fnlT+tJ4pN1yWr31McEY31GGIR
	3tDLKBNXEMaSiIUzZTDY005uWFe5exrNQCby5RdVoBWlBUvO5oQ9vYi0icXWh1xQBzCtoI9mKNY
	h6NY9LUxoZPBcla+x0X8cfiyPs3jFZ4fWPH3v527FZ2jeNHq5qw==
X-Google-Smtp-Source: AGHT+IGNxpEhqXa8BhhuDG+nNBKzHWHQ6g2XRbro9MWisiE3fq4gpTSzTl9AyPdFJOdvZrWODfOYTA==
X-Received: by 2002:a05:6000:200f:b0:3b7:940e:6520 with SMTP id ffacd0b85a97d-3b900b2d7d1mr1148761f8f.18.1754633157711;
        Thu, 07 Aug 2025 23:05:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae2fe7sm17254865a12.44.2025.08.07.23.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 23:05:57 -0700 (PDT)
Message-ID: <984aeb4a-dd52-4b60-9c0b-cbb86d02c6e8@suse.com>
Date: Fri, 8 Aug 2025 15:35:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] btrfs-progs: fix the wrong size from
 device_get_partition_size_sysfs()
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc: Zoltan Racz <racz.zoli@gmail.com>
References: <cover.1754455239.git.wqu@suse.com>
 <2fa034e287a0b7deb5a1b436915426a696a10e71.1754455239.git.wqu@suse.com>
 <479f6581-b2de-445d-92b8-d8c3e03d5af0@oracle.com>
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
In-Reply-To: <479f6581-b2de-445d-92b8-d8c3e03d5af0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/8 15:17, Anand Jain 写道:
> On 6/8/25 12:48, Qu Wenruo wrote:
>> From: Zoltan Racz <racz.zoli@gmail.com>
>>
>> [BUG]
>> When an unprivileged user, who can not access the block device, run
>> "btrfs dev usage", it's very common to result the following incorrect
>> output:
>>
>>    $ btrfs dev usage /mnt/btrfs/
>>    WARNING: cannot read detailed chunk info, per-device usage will not 
>> be shown, run as root
>>    /dev/mapper/test-scratch1, ID: 1
>>       Device size:            20.00MiB <<<
>>       Device slack:           16.00EiB <<<
>>       Unallocated:                 N/A
>>
>> Note if the unprivileged user has read access to the raw block file, it
>> will work as expected:
>>
>>    $ btrfs dev usage /mnt/btrfs/
>>    WARNING: cannot read detailed chunk info, per-device usage will not 
>> be shown, run as root
>>    /dev/mapper/test-scratch1, ID: 1
>>       Device size:            10.00GiB
>>       Device slack:              0.00B
>>       Unallocated:                 N/A
>>
>> [CAUSE]
>> When device_get_partition_size() is called, firstly the function checks
>> if we can do a read-only open() on the block device.
>>
>> However under most distros, block devices are only accessible by root
>> and "disk" group.
>>
>> If the unprivileged user is not in "disk" group, the open() will fail
>> and we have to fallback to device_get_partition_size_sysfs() as the
>> fallback.
>>
>> The function device_get_partition_size_sysfs() will use
>> "/sys/block/<device>/size" as the size of the disk.
>>
>> But according to the kernel source code, the "size" attribute is
>> implemented by returning bdev_nr_sectors(), and that result is always in
>> sector unit (512 bytes).
>>
>> So if device_get_partition_size_sysfs() returns the value directly, it's
>> 512 times smaller than the original size, causing errors.
>>
>> [FIX]
>> Just do the proper left shift to return size in bytes.
>>
>> Issue: #979
>> ---
> 
> SOB is missing.

For progs, SOB really depends on the author.
It's recommended for long time contributors, but for new contributors 
it's fine to skip the SOB.

Unless you mean my SOB, but in this particular case since the author 
didn't provide SOB, I didn't want to have only my SOB.
This will give an impression that I'm the only one contributing to the 
patch.

Thus I didn't leave my SOB either.

Thanks,
Qu
> 
> Changes looks good.
> 
>>   common/device-utils.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index 783d79555446..bca392568d1b 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -375,7 +375,9 @@ static u64 device_get_partition_size_sysfs(const 
>> char *dev)
>>           return 0;
>>       }
>>       close(sysfd);
>> -    return size;
>> +
>> +    /* <device>/size value is in sector (512B) unit. */
>> +    return size << SECTOR_SHIFT;
>>   }
>>   u64 device_get_partition_size(const char *dev)
> 


