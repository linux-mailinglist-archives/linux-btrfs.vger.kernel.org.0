Return-Path: <linux-btrfs+bounces-20314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68772D0703C
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 04:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E84BE300792E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 03:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E425D53B;
	Fri,  9 Jan 2026 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ctOBQT0d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098423BF91
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930172; cv=none; b=KSyGJCnVv4KXhF1uuuWbePbwmyWqKXscMw8WiQ9ey1GZDT0HSnW/XhLqqfG/ND6ibdYvQkiDe5e0936RaNQ9QbZHZz8yGpPid50d1IhZdzuHJvdmVO2+jqAK1nNkayEtGjm7mNXHhpB6qNmSfPyOjxc3vyp9UD7tuvA8w/DsnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930172; c=relaxed/simple;
	bh=yrsVywKxiCT8zlycoeh+r5ziG9OlcmrTQbSt6Li/mz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8V76aoD+ZY6uL/A0g/CDnEv0bSav3rpbw+gFzQWgNni7/gUx/zy3eg8yx2r3jdi/v8slGLvpo2cJwcAaMbPQDP9L5De+qVbffBxcG9JyVqjRvbv11KgpdEuX0+k8+d7fnh4SFEQzc5okDCet9Bn3U9nti1xSaRHpHocu1KbuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ctOBQT0d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so35855775e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 19:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767930169; x=1768534969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GZOVLSj2ck/R24Kq5lyw8KJmSvRNfhPOVRdT1D1mGvM=;
        b=ctOBQT0drOpSUoncyPfoF4PMx0O8w44KS3ei1TpxXlr1ixNihxWydla3QlcTjg6hZt
         QJ7e/JWwVWJrD6GevYyuoCi8Z2m6aEKHOKR3qi92BbfEzLyQoajOBrVzF538uhTsMOAL
         Rurlz5TS6Yxw8SAi7Z9X4KizPHxt+cCxBoNFVTZ5MSHjn0+Oiybyu9rPjGgxXOpB/X4X
         5zU4R61tlHhGbtOA0siv2deKat36M3O4fcO6E9v6jVyTeOziVhLoQO1KKAjAHWmUuQxD
         DPC84xypqFqySlX3haEwqg+mvLWxXmFJg/G5Uw/lFo0vp+BhidHdKzazsBDV92djaz7d
         2AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930169; x=1768534969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZOVLSj2ck/R24Kq5lyw8KJmSvRNfhPOVRdT1D1mGvM=;
        b=sNiUW2aM2MiviHIOwCeCMLnWYq0bY/9VWIUGaPD69LVUG6cVH4HQ7qldDbrRqi7CHQ
         DrAP6STfrPzzjplTBMFztDKpIJLnANCyeDyQmytzjwKkBh+1fX5FI3NLF6mB6cwBm2Ht
         S6TodoMKCVJKoGJP35Mj6H4oFR39YqaN/0O6kJC9Rz6G29YZMP4wWueWb8nGRPmbbD80
         MjcCz/nijqszyQN3SV0YRlnobLV9gpxq4E6gHezrtLbCO3IC6QUqQXRI2rYeYXftEpEL
         /poMfbTW1RvM8l/j3cSJu5qZDYrUM6Gjpr0oK5gjp2sEdryJnIPH/azpSjJJZE6pkQAg
         /Rsw==
X-Gm-Message-State: AOJu0YzQFskrHmuNNu2isxyWzd3hF1YLiSNb+2z6Anazi7qh15ANfRwl
	oaJJH9IWAF4e2mW5HAzWByc4sSo24koB0sWs31wUPhNO4JTGc+5JC0TBS398DcgIna8kPS/uUsF
	6+mAfFmA=
X-Gm-Gg: AY/fxX6NDPJ3nOYzdyKiPBCNxnhWyuNQDbYpJV61LRLX4GSvI+mDNZfryICowUyzmKV
	5mGi4Jf6Scdsh3d20WOJ8TIv6vNpMFvGDTFjOjHpjfSuXIlWxuRbw9vHh6dU//1V2NTjHdOLTIG
	MWXinG5Oa7U4Ryn/am7APW0MEQwFd/I/l1Wynj4GsCiipVqQz3pfKOKUICWwUpVH+bwh39NTyfq
	T/zcCO3OuAWzNHEbwi9SHqTjI8YWEPrRceRJ6voQOOKp4Eata4vSwthCCR6u+O5z8zM3gwToCYX
	WFsohJgkjQzWOwl5DmgDAb2mNenUJaHcJ0Tw28Lub9E0fKz5Z5faLj+5qCpZ3LE2QntaN7KQJPq
	otlQhYaQS/BLO7+3qb5bmWQJSkcPqx+Tju8Gya4gn4jquYq4PSYEpmFiaZuiGL01AdmqZzgRrsa
	4Q7YaUVRYPCcytXYCpnMSPGav9/7Z4ZdRnnN4Yw3ycIioJFev0
X-Google-Smtp-Source: AGHT+IHQE25B+1fwul06x/3unLSpEHfeEkmgq/GrsxyHlsk1oM0sj9t039V0AuyPAgFH0NdO5UqBgQ==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr97730515e9.22.1767930168582;
        Thu, 08 Jan 2026 19:42:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb75902sm9088702a91.16.2026.01.08.19.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 19:42:47 -0800 (PST)
Message-ID: <ed724086-b7a2-4df4-878e-751dfa614a71@suse.com>
Date: Fri, 9 Jan 2026 14:12:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove offload csum mode
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <318d41265ab70ffc1220355b3396209d12b23373.1767845479.git.wqu@suse.com>
 <20260108214022.GN21071@twin.jikos.cz>
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
In-Reply-To: <20260108214022.GN21071@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/9 08:10, David Sterba 写道:
> On Thu, Jan 08, 2026 at 02:41:26PM +1030, Qu Wenruo wrote:
>> The offload csum mode is introduced to allow developers to compare the
>> performance of generating checksum for data writes at different timings:
>>
>> - During btrfs_submit_chunk()
>>    This is the most common one, if any of the following condition is met
>>    we go this path:
>>
>>    * The csum is fast
>>      For now it's CRC32C and xxhash.
>>
>>    * It's a synchronous write
>>
>>    * Zoned
>>
>> - Delay the checksum generation to a workqueue
>>
>> However since commit dd57c78aec39 ("btrfs: introduce
>> btrfs_bio::async_csum") we no longer need to bother any of them.
>>
>> As if it's an experimental build, async checksum generation at the
>> background will be faster anyway.
>>
>> And if not an experimental build, we won't even have the offload csum
>> mode support.
>>
>> Considering the async csum will be the new default, let's remove the
>> offload csum mode code.
>>
>> There will be no impact to end users, and offload csum mode is still
>> under experimental features.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> 
>> ---
>>   fs/btrfs/bio.c     |  5 -----
>>   fs/btrfs/sysfs.c   | 44 --------------------------------------------
>>   fs/btrfs/volumes.h |  3 ---
> 
> Please also remove the entry from Kconfig.

Done and pushed to for-next, with the 3 enum definition for offload csum 
mode removed too.

Thanks,
Qu

