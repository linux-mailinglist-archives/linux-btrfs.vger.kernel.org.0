Return-Path: <linux-btrfs+bounces-18966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D09C5A440
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 23:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C673A5902
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304F3324B2E;
	Thu, 13 Nov 2025 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e2vRGHtI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61742322C60
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071051; cv=none; b=uRveK7EFckxZpnSaNRlnIXMHAVTow8w/AGZb0HEZry8jZtOmEEoj8XhFINflwKJTH+XdZo5mPi1WYxXu577wJKLnvtPPMXAaOH5iAhDJW2DcKor+rH7LMta/+CXheVx8fr1FE6HtFNjA7AkXeAsqc2wP0v4jBVmb5eFdj8SvcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071051; c=relaxed/simple;
	bh=wYX2Zo0NdQXIFg/9Lzz0uMV6auzcZWOcA6FkEb2xVUQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qHck5EK8AAkNjWg8/NkLpnySFyptcc+pe4yGqnIZQRHcYLD85F4d8lNiczKtNKYdiNoja9CisH3+5HY6kLC+A9q2PBZQi4q7PQEm0/rxH4vWQeIq6avr+jANvsH6x9wrOotnoQrmudbrAt8mxYqjhdNIDUDbCE+auob7qJGq9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e2vRGHtI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32a5494dso726770f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 13:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763071048; x=1763675848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cyhCFAdDK6XVGK2ohsOxlYFeCpQakQBoFcnY2OjNORg=;
        b=e2vRGHtIBp95camdr8k8Z9guB/xeMSFJP+khD3545W7Lzxudla7D+N64ZMj3YIBtht
         PpnSmkWXn9vk2g1W55s8wXPo2ZHASnk0xXxblRsxIttTYwFHrr/oZwPBjZhvtyhj9TrW
         ECBlfBmYtkzD7ToavDcLikUnkc4yiMfTl0S6rr8vU6nqCFLPDaCYyc/jc/1f0wG2O0+B
         lZiyU1ym9XhZTpNUgr5WBYuaW1glsQs1rsWd0nnAXRy/X0W7kR2lNWyJQ+2xoxlP2SFn
         MLe/TuoVr0Ti4w4x2Sm0IMl4M6VzKdtJEz0bvhYbavzOCBrQu0nxhoxIWgnqKaM72qoI
         nnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763071048; x=1763675848;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyhCFAdDK6XVGK2ohsOxlYFeCpQakQBoFcnY2OjNORg=;
        b=BbSpoSI5pgAQn4EgOGkjGn3Sd/ARMya9s9G4e1DuwnXNOtZ1A2hugDfmj+gHJpU5ut
         4PucF50r4sc8X2uTMAIXuwPmqXE1ub+vVB2Y7proLdZynhjAZASYRUUDdF1D/lrVXg9z
         dpjTseLHlIDGuXzMQM8F+hV/DrQlm0cUFMVOsONpjT7pO5LdWLIz5UXVp5LKEaFi/lfa
         kzFR5cLtxmG2gLODq/vLBC61QF0kzOdKl1wBiVvEq1QBGkRoVlnvAoCYz489wwEhzr9h
         qJwYhMmhzifqsy7X30avPLPuBB8u2zJcjHCaFWYWuIiDfESdkY9Nr+96iH6rrQ9wCSGL
         iyEA==
X-Gm-Message-State: AOJu0YzNQmYE9URj5md5qZ/FxCRFZd///3Q9jh2dGb5r18vEK7faFhmH
	561TDT6CmJ9o1XCFtNsPcaFGfF8KOQc2rvX2l0FEdBPfsD5aZhWS4OhEOY4Owit4nPGpQwQjCn/
	B9uaR
X-Gm-Gg: ASbGncuTzYCar9s1Jzwj4RMeF6kU6XBLMSEhoOzBcQQnioz5uZNV3eAmV6dp7gT24yW
	QltqlP37YUUsmH2bL0JxUzHYbEXvli0UBNmGIAQdubonv3VsVGQpGy5b59hD5TIJv4rSmEvfBVk
	UyI/I0JYtZ8y21cPLvY5ddwAyhCmS8ENuN6mf3Df2DVBMI8rkpi9WWWJdVCnScO9o/ORrAyUGsc
	neuCo/jIy1Z1HNQOFObgmL6GlgB3fVUSqK4mPcZNOTvszXSdPyewP9ZJemxRjp8aiyne3mK6XwE
	TIPoflf4zQEt1uqODGIRGJtNhL3sH43LpGB3jkYRcSaQ/vfKp4RuSYZETy4XKuCAPfIThFDs/Se
	t1u1fvqAAWDWbtd7YtD/O/xtPr718IY6lxCA/dPUQ3TsteW+WWEnmSCZ+2wkEBZTd8dpQmp8zfQ
	o69AQlFyw1bpcgbBwrwvxrpXjIIUBF
X-Google-Smtp-Source: AGHT+IEGLE79WLLoxx+csfGwaq02rvRvIx4iQ4L/7XMSRVFtta9yHU3auZrs3Aedy9ehXhQFy2rn/g==
X-Received: by 2002:a05:6000:1842:b0:42b:53ad:bbfa with SMTP id ffacd0b85a97d-42b59388826mr818119f8f.53.1763071047625;
        Thu, 13 Nov 2025 13:57:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714e298sm3208149b3a.34.2025.11.13.13.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 13:57:27 -0800 (PST)
Message-ID: <0962852b-61f5-4f3f-9258-ef2625e581f8@suse.com>
Date: Fri, 14 Nov 2025 08:27:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: raid56: fix a out-of-boundary access for sub-page
 systems
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <bbd1a41c70c0f37da9e3e82aa89784e831b0e889.1763069997.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <bbd1a41c70c0f37da9e3e82aa89784e831b0e889.1763069997.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/14 08:09, Qu Wenruo 写道:
> [BUG]
> There is a bug report from IBM that on Power11 the test case btrfs/023
> crashed.
> 
> The call trace itself is not useful as this particular case is a wild
> memory write, which corrupted the SLUB system.
> 
> [CAUSE]
> Inside index_stripe_sectors() we will update rbio->stripe_paddrs[] array
> to reflect the latest stripe_pages[].
> 
> We use the physical address of the corresponding page, add an offset
> inside the page to represent the sector.
> 
> However in patch "btrfs: raid56: remove sector_ptr structure", the
> offset is added to the stripe_pages[] array, not the result of
> page_to_phys().
> 
> This makes the stripe_paddrs[] to be hugely incorrect for subpage
> systems.
> 
> [FIX]
> Fix the calculation by adding the offset after page_to_phys().
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> The fix will be folded into the offending patch.
> ---
>   fs/btrfs/raid56.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index ad3d5e789158..7cb756ac19ba 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -331,8 +331,8 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
>   		if (!rbio->stripe_pages[page_index])
>   			continue;
>   
> -		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index] +
> -						      offset_in_page(offset));
> +		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index]) +
> +						      offset_in_page(offset);

The folded version will have one less indent, so that offset_in_page() 
is having the same indent at page_to_phys().

Thanks,
Qu

>   	}
>   }
>   


