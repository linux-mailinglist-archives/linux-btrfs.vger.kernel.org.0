Return-Path: <linux-btrfs+bounces-17520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59571BC2BE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 23:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8CCB4E59E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAFB247DE1;
	Tue,  7 Oct 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCPijHzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E671D5CFE
	for <linux-btrfs@vger.kernel.org>; Tue,  7 Oct 2025 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872491; cv=none; b=PhHfpgC48IaiDvLOErrh4Et5iG3ZXPFc54+5KSbRjPT36AAe3fetEld06FsFoqxlsi+4VyhXCaiXdH/uw/ZZ6bDSZ7+cv23iR5c3+a+ryuOmWVXqIK47fN42/d3kMSXJmqLq0MbgH8vF9yl5t21BSUiD7xium+4ps+0ywpVvlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872491; c=relaxed/simple;
	bh=pLO7rkTsoQ2oSd9v/1H7hskqPCX9Z2MtYRiTmkLXaAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSEJnyS6sqT2y7350HWUBe1gd+fysjlmTchuA2i5oTZoxQbobyrLN+dr6NHaoXQwX5oWI4KmrfdfVpnVmiV7mSCOJQXzlUu/b6aW0suKLEJvV8dBrkAflgiGQXoAFqefIP8e5Qv9qYdng5u+CKFa5M4dTmDK5L/MBDjoohkOJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCPijHzW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42568669606so3666862f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Oct 2025 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759872487; x=1760477287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsucf0vVsobG12gzxy2S7+2oOr6aeTIDSUzvjBpxYqI=;
        b=KCPijHzW9Acs6Id6BUsHiwyCQjPIZMuVVHHyRhw0fq0b9pWWouKR99+fzcuQWFDy3i
         3DJ9MwVd6LmwmjVCsYPhCvfc3giNuKIKPW1ReJGUxT8ONdY986NK784UM78sp22QtmZz
         bZclCq45KJnHgWlRAmngPcx9PiR9gQek4A0BvHam9AmOeNPO3Lk0LrnHos5CY7pgeOVC
         OGM75pIJt2CRXN1lBL9jEKF7RdywNGjWIRV2M01qvmmdmRBJdkolgELVIIATfpOUwup1
         sduAOGzkPhgCMS59FKwbCGWFxS+BOqvPs7Imwo0dWRanj6E4sPLwsGUepjscMxzmF4fz
         m0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872487; x=1760477287;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsucf0vVsobG12gzxy2S7+2oOr6aeTIDSUzvjBpxYqI=;
        b=pCzsN6SRBFXZ8ZRanJtSH+R6tDGBTUsO84gYfN0bkXTydUyrR4/MTqcvRsWNcXiysq
         +xLWbQ4Or3L46zzBJBzaIbSeIVVSIbw3aty8qduZW1Y/nhie73SRRCvQkeG5QFv4c9F5
         F5RcdUozCCpBke6kQ0gcJt0Z2984RyeEH7zRKV8lzt5+2Fu7zvY6PRimLLgYMJzrPGfN
         xKzlWwsh492q8sQf9j9SnneUq/bZW4YlmpgSWrXK903AODUbsSE9t++DITbfUsy9MKOl
         m93Xr49SpdLYblIgmiEno1Dql75DtcdjielQdQ6zVRJrSqbXk4e1sVO0N+0uIw0br8rF
         qttA==
X-Forwarded-Encrypted: i=1; AJvYcCU3EUvvkpUeX5FRR3YT28FtKjXR2Eux9XFUFYn7yO3iidjZxa9DIfMTY3N/jYqw15pQvwJkXq/oKUkLsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4V7TSEO/fRjAM7z1BP8a2eNkpo9ASWhI+QqbIbmzS/l58jhS
	TM3ex7uFomefIwMO/VpvgZfOx2v5dnQX5R1uqLvRGhwlaMlc4yvE2+ACVAiM0b9JO4o=
X-Gm-Gg: ASbGncvCdEe3GE82w9u/lpz7FUakDp6jfMunjTVwcM2lfR4tpdpjx40KO9id87rnBfu
	9hmqHECyMt9N2o6ZlWrcaFKvG9Qhr3iSEh569/6ZYYW3yGlNCdh8cFXI5D8RHIrag3b5q8rk8+4
	yDwGrthTRZm34zj6Ae5gv9v1CpnwW5sHzd9D9p7qCXbB8v3KCTzs/XRCC7FrjCzoDJsjtqhXAT2
	2NooTR/Wotmtg3JDmkqL6W1EHo3k7xUq57vLzGLt7wGsMG8FFZqaNepFyP+MK7qpRu10FVNPiHu
	JUfdYg6kUNsnSoPuyw9n/Lt95bBNW7kXkCKSDzPhz+yops8KXdy3dAFqvtthJSby2V/vMhKnLud
	SKeVOhNw5O9lAcpfsaExLSIMajXia+C93d3B+mVxQYTmm1XlhurwcbaIciGp3Y1/qFGFQFoPDwa
	dDSDQpck8f7A==
X-Google-Smtp-Source: AGHT+IHqXS/5UfjAOvdA06A2MvNA06Js3gSo3Wd4dquS+f89kqx+UCNvUIep87qbq7GCT4O3wpDyJw==
X-Received: by 2002:a05:6000:2401:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-4266e8de2c2mr486406f8f.44.1759872487392;
        Tue, 07 Oct 2025 14:28:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ffd77sm716373a91.7.2025.10.07.14.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:28:06 -0700 (PDT)
Message-ID: <8e3ee208-e0d1-4799-a70b-fd4e4de34bc5@suse.com>
Date: Wed, 8 Oct 2025 07:58:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct IO reads being split unexpected at page boundary, but in
 the middle of a fs block (bs > ps cases)
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig
 <hch@infradead.org>, linux-bcachefs@vger.kernel.org
References: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
 <aOPbMs4_wML4qxUg@casper.infradead.org>
 <c9fae0e3-88ad-4e50-a54e-8a73cdc72e38@gmx.com>
 <20251007145843.GP1587915@frogsfrogsfrogs>
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
In-Reply-To: <20251007145843.GP1587915@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/8 01:28, Darrick J. Wong 写道:
> On Tue, Oct 07, 2025 at 01:00:58PM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2025/10/7 01:37, Matthew Wilcox 写道:
>>> On Wed, Oct 01, 2025 at 10:59:18AM +0930, Qu Wenruo wrote:
>>>> Recently during the btrfs bs > ps direct IO enablement, I'm hitting a case
>>>> where:
>>>>
>>>> - The direct IO iov is properly aligned to fs block size (8K, 2 pages)
>>>>     They do not need to be large folio backed, regular incontiguous pages
>>>>     are supported.
>>>>
>>>> - The btrfs now can handle sub-block pages
>>>>     But still require the bi_size and (bi_sector << 9) to be block size
>>>>     aligned.
>>>>
>>>> - The bio passed into iomap_dio_ops::submit_io is not block size
>>>>     aligned
>>>>     The bio only contains one page, not 2.
>>>
>>> That seems like a bug in the VFS/iomap somewhere.  Maybe try cc'ing the
>>> people who know this code?
>>>
>>
>> Add xfs and bcachefs subsystem into CC.
>>
>> The root cause is that, function __bio_iov_iter_get_pages() can split the
>> iov.
>>
>> In my case, I hit the following dio during iomap_dio_bio_iter();
>>
>>   fsstress-1153      6..... 68530us : iomap_dio_bio_iter: length=81920
>> nr_pages=20 enter
>>   fsstress-1153      6..... 68539us : iomap_dio_bio_iter: length=81920
>> realsize=69632(17 pages)
>>   fsstress-1153      6..... 68540us : iomap_dio_bio_iter: nr_pages=3 for next
>>
>> Which bio_iov_iter_get_pages() split the 20 pages into two segments (17 + 3
>> pages).
>> That 17/3 split is not meeting the btrfs' block size requirement (in my case
>> it's 8K block size).
> 
> Just out of curiosity, what are the corresponding
> iomap_iter_{src,dst}map tracepoints for these iomap_dio_bio_iters?

None, those are adhoc added trace_printk()s.

> 
> I'm assuming there's one mapping for all 80k of data?
> 
>> I'm seeing XFS having a comment related to bio_iov_iter_get_pages() inside
>> xfs_file_dio_write(), but there is no special checks other than
>> iov_iter_alignment() check, which btrfs is also doing.
>>
>> I guess since XFS do not need to bother data checksum thus such split is not
>> a big deal?
> 
> I think so too.  The bios all point to the original iomap_dio so the
> ioend only gets called once for the the full write IO, so a completion
> of an out of place write will never see sub-block ranges.
> 
>> On the other hand, bcachefs is doing reverting to the block boundary instead
>> thus solved the problem.
>> However btrfs is using iomap for direct IOs, thus we can not manually revert
>> the iov/bio just inside btrfs.
>>
>> So I guess in this case we need to add a callback for iomap, to get the fs
>> block size so that at least iomap_dio_bio_iter() can revert to the fs block
>> boundary?
> 
> Or add a flags bit to iomap_dio_ops to indicate that the fs requires
> block sized bios?

Yep, that's the next step.

> 
> I'm guessing that you can't do sub-block directio writes to btrfs
> either?

Exactly.

Thanks,
Qu

> 
> --D
> 
>> Thanks,
>> Qu
>>
> 


