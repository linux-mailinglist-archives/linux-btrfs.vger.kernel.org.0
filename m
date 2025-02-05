Return-Path: <linux-btrfs+bounces-11308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256EA29D37
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 00:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1823168961
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 23:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179D21C9E1;
	Wed,  5 Feb 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UBgRCCq1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076321B918
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797165; cv=none; b=sOGW3n4VKIA9H87Rt3en+cUruyMznFZzOb+S8RGbKOsEKmwbmM+BTWvhyc9FzLB7ViJLoOmXpXOSPYbEoyieOSLhz8aJgax88k7zEyvfnX2h9pSCBgLSXdOBTO8z6R2TIoPXwpR2UkkG77n6KR5IxtOplBKQ8qM8DGwgHbhlXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797165; c=relaxed/simple;
	bh=UuBJKth4IeEtceT5pFgxCVGn1YSFQzGEfsSmjblqna8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJK6COu3+/qGxy3EQ9+hmshWLomM+5fTMBW/zdbk/ddcv4AOhBCljY+7JvypfdGXeBC71nz9HwimjVF/Ymbd3iotleJoJx0oyio3YAGriiqXK/LO/gc/l7AJh8tLW0iWs5nDn23MXN7t+Y32dDXSqQqZZk3vP+kyITsCF12VVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UBgRCCq1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38da88e6db0so122452f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738797161; x=1739401961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62ZaRhi599FcOgQEjRaa5307xLOpxOMg13jnmGkKq4A=;
        b=UBgRCCq1+E87SoxipKQKfxBEMDtqWl2zoI2Qm1hjT+tBaH3hztrNhT3OCGrySagZWg
         asc9mrnN9A5Z+9m/cJDNgYN1KWW86yBj55+i/mlwUu9TR4LWB1fVhnyXcIKQUUxvqfP5
         V0T4r/yUXWTR+OgwYSKRlbiQaVbIe3ZTc3FGF9gvAykliEKlzhA0UnZwcKz5lOLzM8Wx
         6+Nmzm/vlo3mhhNvl0Zwwuv1xTcb0asClZPI7RrZcnw1oXzEa8xsWUNxaJ5zaQZITRGY
         BgIxn7dU7UoddWJrX8H5CaKTS4Wh+fv3AaRtZrVeT2qjLYpfnUVLEMFOsjalc8TgGwT3
         BCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738797161; x=1739401961;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62ZaRhi599FcOgQEjRaa5307xLOpxOMg13jnmGkKq4A=;
        b=od3YzFF4fbmhkpq6l330uaOkZccDtC2dWvVTaR6ulTTcnq59ubGpIA+XhYbAUB1Xjf
         UStQhkaugIEQNLzEtFgObbTw9qqCQur9RwHbfrSgQq7BZG6b5+xeaY1nLz+XnMvzbHRf
         x6HdnLX9Ok/2AcAYlcIJWAsBR5itD9DSkTbIuIuuihstcfNdijd78Jz5RulC7ZFJuboM
         7U8PrSA8ayqR+STfuHj6r5aAhtR+RJQ7XMetE1b5dedConBGnOvmh34UYwOPFq8y0XTx
         jKX2OtXg5qrdZwgVCw1fPGaW1hJT+/10KLxvzx5CgFSAD6aCFV9ifYYWUkdpObTQ9vRu
         itJw==
X-Gm-Message-State: AOJu0Yycdk+92ZPczKTxQI999y7E62F4XFneXaDRxJc8HeR36f+XZR2f
	51ghPEg8/R3y4J5wTv3pZtx4hP6eGIbu6osQBHEfiLBtad3l1gpF60TRJEx+dd8=
X-Gm-Gg: ASbGncuRMppce3i0elZm8HuM8b5WGouSVZsfLH1Y4ym35qriZD09RzAySc+V5LntgKq
	0LNYo95MM+vdlAK7UxkGwRM3eF4vtFNtQMtQbUoKmESMKi/f0kXVOKhwywXbGGF/dj9ycINbuAD
	bkLYvatnkefvOXc8IHHHrQahBem0IE10aKUEiHU73mId/plyE3ZuRf/sh4bUVgeC6kweegkVRCY
	43DXq5CFn1zs9Acx8zbNnHEyssHzMOzb1qcDH7c1hecnQ0IfrFRL2+G5e4PoIqHjI9Ww2wnAgIs
	5/CVQwBhSpIAbpirTQ3cGlIUBc2Tn1HnN313PZSTVPk=
X-Google-Smtp-Source: AGHT+IFShJokkFla6ZH5Q/U/LuCI5y7E/3Qyrmk47C05U9xMpcbxqZjSJHNXhVDbbMbDi8T6GYan0A==
X-Received: by 2002:a05:6000:1fac:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-38db4929c37mr3948306f8f.35.1738797161074;
        Wed, 05 Feb 2025 15:12:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a94csm13587921b3a.173.2025.02.05.15.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:12:40 -0800 (PST)
Message-ID: <38d9e532-a810-4402-a4d2-ebc5236577aa@suse.com>
Date: Thu, 6 Feb 2025 09:42:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
 <20250206071036.ED84.409509F4@e16-tech.com>
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
In-Reply-To: <20250206071036.ED84.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/6 09:40, Wang Yugui 写道:
> HI,
> 
>> [BUG]
>> It is a long known bug that VM image on btrfs can lead to data csum
>> mismatch, if the qemu is using direct-io for the image (this is commonly
>> known as cache mode none).
>>
>> [CAUSE]
>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>> fs is allowed to dirty/modify the folio even the folio is under
>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>> flag inherited from the block device).
>>
>> This is a valid optimization to improve the concurrency, and since these
>> filesystems have no extra checksum on data, the content change is not a
>> problem at all.
>>
>> But the final write into the image file is handled by btrfs, which need
>> the content not to be modified during writeback, or the checksum will
>> not match the data (checksum is calculated before submitting the bio).
>>
>> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
>> but btrfs requires no modification, this leads to the false csum
>> mismatch.
>>
>> This is only a controlled example, there are even cases where
>> multi-thread programs can submit a direct IO write, then another thread
>> modifies the direct IO buffer for whatever reason.
>>
>> For such cases, btrfs has no sane way to detect such cases and leads to
>> false data csum mismatch.
>>
>> [FIX]
>> I have considered the following ideas to solve the problem:
>>
>> - Make direct IO to always skip data checksum
>>    This not only requires a new incompatible flag, as it breaks the
>>    current per-inode NODATASUM flag.
>>    But also requires extra handling for no csum found cases.
>>
>>    And this also reduces our checksum protection.
>>
>> - Let hardware to handle all the checksum
>>    AKA, just nodatasum mount option.
>>    That requires trust for hardware (which is not that trustful in a lot
>>    of cases), and it's not generic at all.
>>
>> - Always fallback to buffered IO if the inode requires checksum
>>    This is suggested by Christoph, and is the solution utilized by this
>>    patch.
>>
>>    The cost is obvious, the extra buffer copying into page cache, thus it
>>    reduce the performance.
>>    But at least it's still user configurable, if the end user still wants
>>    the zero-copy performance, just set NODATASUM flag for the inode
>>    (which is a common practice for VM images on btrfs).
>>
>>    Since we can not trust user space programs to keep the buffer
>>    consistent during direct IO, we have no choice but always falling
>>    back to buffered IO.
>>    At least by this, we avoid the more deadly false data checksum
>>    mismatch error.
>>
>> Suggested-by: hch@infradead.org <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Another point about uncached buffered I/O since 6.14.
> 
> when the direct i/o is fallbacked to buffered i/o,
> should it be marked as uncached(RWF_DONTCACHE)?

At the time of write, the uncached write support for btrfs is not yet 
merged.

Thanks,
Qu

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/02/06
> 
> 
> 
>> ---
>>   fs/btrfs/direct-io.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index c99ceabcd792..d64cda76cc92 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>>   			goto err;
>>   	}
>>   
>> +	/*
>> +	 * For direct IO, we have no control on the folio passed in, thus the content
>> +	 * can change halfway after we calculated the data checksum.
>> +	 *
>> +	 * To be extra safe and avoid false data checksum mismatch, if the inode still
>> +	 * requires data checksum, we just fall back to buffered IO by returning
>> +	 * -ENOTBLK, and iomap will do the fallback.
>> +	 */
>> +	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>> +		ret = -ENOTBLK;
>> +		goto err;
>> +	}
>> +
>>   	/*
>>   	 * If this errors out it's because we couldn't invalidate pagecache for
>>   	 * this range and we need to fallback to buffered IO, or we are doing a
>> -- 
>> 2.48.1
>>
> 
> 


