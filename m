Return-Path: <linux-btrfs+bounces-18405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83FC1D6A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 22:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB6407053
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4A314D24;
	Wed, 29 Oct 2025 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lhi4nY7m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F383191C6
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773021; cv=none; b=iPtoWweY1mr5Xjx7pjchxRxwymmifwhoW83tW5a/DUL/kp97LGZ2h8wklx52QngNkDCz1iGWpRiuQ/1WKwDqoQAufcaG8ZY7y0/5yFkx0ScKeHTSC+3+86U2Wc6ESIhSyJT1AeOcu2wF+jVy8Ef/v8Q0Y+/vCdIEyzj8axY+9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773021; c=relaxed/simple;
	bh=Q8GbFpKZ0G2WK3boaHgt/WIjta7Wgy2yicNjI9IW2zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0Yh24ju2XScdhnWAZ2El33/jN/Ox0YyydnDWwJ0IVL3mAL4+peLjuenBe0CHoyTNoiD20sOsOoZFV63KJua5+Z70qox1ELLknV3rzleUmMjnUffutrLiGhSonYIi4ybcMxg9kR4wnSAjLra5QyuDqxoAz4QJJ3NgquvWmc5kSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lhi4nY7m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-427007b1fe5so253947f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761773018; x=1762377818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pTUPsF7Fte/AGInCGPT8Bm06cRTL6FI2Yd2BduEa3rQ=;
        b=Lhi4nY7mE1VKGUIUe7MMOYx3vwfyb6bQKJi06EWO7qIIMxMobGFA6FoW5ZEE3pgX50
         sM145QJkripClJTk67gkYqNmwgRuVFelnnuNxatUMdMQHFwIYCOnh0J9/ywJ69/52sjb
         pDQ5XLuS05q4hZh50K4/87jw6GEtgk3UvyJk3NAxZS8zcoGnByseefsUyTU48e4pN2zA
         Kqem8znipIdYalxSf8ePbKh+lDpl/pyRjso98IFsZo3qIkcCRicik7m7HolQ8nU90oSD
         As5LJDjFf/bBpJoeMCFxzmJ3WZ+xcd/slEusVnTyORw5Y1Zg0qS1rQfg7NN1/4+XXMo2
         0JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773018; x=1762377818;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTUPsF7Fte/AGInCGPT8Bm06cRTL6FI2Yd2BduEa3rQ=;
        b=WtPA53TM0Gcpl77xn4XHpdehrx4faSszZK463QcwlnHiIMZYdAVYUL3i4mkrP+2mzS
         oG3U//Qcb+CbRLmQGiV42jY2zF0nOgthjK1dc9Rsa1pK/uMCayOx+XazC/zkg0jyyU8f
         JgrZOS4JqsoJiFULiW0wHFEeiC13COzgEAsv/KJnPTZrxBxIxg/FvAo/B3KeXwvTXoaQ
         xL44CJNumaU/yOBWlZ/TKt+K+OtxTWSFdno5vtgWpfCFneoGRwx+A9NzOdAABVWb/gPw
         yWbjmqD/N/vNDnQzLa7dZ6VQa24QgTOtA5Eh5J1a7dwSdEsAab/e0/+oHqmPUtBxCDLH
         9sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQgDt2vJEguZ4A0BvB0Hb8m4YaxzMhAymY9UroiMOPfebeVKQAkmRWEcizR2dd2ZRwWM5b3fUfiYownw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpKz59fE4tDKHBk0d4BzdtmyRACImhYyvt/Q6aZdZft5t+wI8
	NiiswSHhjEKAF0254TLV6cQgDPnB6nsPyB64i3827bEiKFd0GO1/IyuFh81p+81Isfc=
X-Gm-Gg: ASbGnctGoqZLMwPsnjVLgAPFblRVOzKsRLv7N32bYLGSgrVhzmqZQ4RoR3HQn6nKA0k
	tD497o769oiPJcvm0Fbybt+SxNbJfRhkSzkn3cgwyV7Ma3+A0U3E/MoBIJ0OziiWaOHeUBTdv6i
	KSJrmJu1Sjqe8c/hkt5XJJVddNjZYmRW1K7rKecksC8dFtTmREjGRQlq6tbB6sG0DfhvOmQ8QwQ
	5MXESsAVAoEeFZnA2Mw6Zekovl2LjRlQDsgT225mNmyenrm4Mfetmi/q6JbCdThPq2/CYV2dM1w
	6Gihi0y7X/7qZW7z7pkg0Rk1HQo9VceLuptXQenYXz+aR/HtlM/XbZ2IK1b4Yp00L0/czBbiGqJ
	OkmqgYxkXb4nI349ez+A67lHDtdaKh+3BvF5C6QGWTup1zRlBocXxuVt8HqWYB0aeJ3MTpUanVX
	TVFMAzqJks0k7RNcyYVWgBnX4nbqy+
X-Google-Smtp-Source: AGHT+IFWiY+tTPVyw5FGPKRDc6cNk4FAtKyr7K6bwTWppv+W/Z3W2oVYRb1tD5oyBMeW0DnOYj0IDg==
X-Received: by 2002:a05:6000:2088:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-429aef7355amr2706394f8f.7.1761773017473;
        Wed, 29 Oct 2025 14:23:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d097fasm161757355ad.29.2025.10.29.14.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 14:23:36 -0700 (PDT)
Message-ID: <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
Date: Thu, 30 Oct 2025 07:53:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de>
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
In-Reply-To: <20251029163555.GB26985@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/30 03:05, Christoph Hellwig 写道:
> [Adding Qu and the btrfs list]
> 
> On Wed, Oct 29, 2025 at 08:53:06AM -0700, Darrick J. Wong wrote:
>>> +	if (mapping_stable_writes(iocb->ki_filp->f_mapping)) {
>>> +		xfs_info_once(mp,
>>> +			"falling back from direct to buffered I/O for write");
>>> +		return -ENOTBLK;
>>> +	}
>>
>> /me wonders if the other filesystems will have to implement this same
>> fallback and hence this should be a common helper ala
>> dio_warn_stale_pagecache?  But we'll get there when we get there.
> 
> As far as I'm concerned they should.  Btrfs in fact has recently done
> that, as they are even more exposed due to the integrated checksumming.
> 
> So yes, a common helper might make sense.  Especially if we want common
> configuration for opt-outs eventually.

Yep, a common helper will help, or even integrate the check into 
__iomap_dio_rw().

Although btrfs currently uses some btrfs specific flags to do the check, 
we're also setting stable writes flags for the address space, thus we 
can share the same check.

However I'm not sure if a warning will be that useful.

If the warning is only outputted once like here, it doesn't show the ino 
number to tell which file is affected.
If the warning is shown every time, it will flood the dmesg.

It will be much straightforward if there is some flag allowing us to 
return error directly if true zero-copy direct IO can not be executed.

Thanks,
Qu

> 
>>>   	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
>>> -	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>>> -	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
>>> -		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>>> +	if (!mapping_stable_writes(file->f_mapping)) {
>>> +		file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>>
>> Hrm.  So parallel directio writes are disabled for writes to files on
>> stable_pages devices because we have to fall back to buffered writes.
>> Those serialize on i_rwsem so that's why we don't set
>> FMODE_DIO_PARALLEL_WRITE, correct?
> 
> Yes.
> 
>> There's not some more subtle reason
>> for not supporting it, right?
> 
> Not that I know of anyway.
> 


