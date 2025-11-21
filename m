Return-Path: <linux-btrfs+bounces-19238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D4BC77991
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 07:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E44824E4FF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24926ED45;
	Fri, 21 Nov 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XvFMXs6i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D48125A0
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763707460; cv=none; b=jTpJOGxTB4ctSxXGbwUNlxB/1dvjAeiCDo3VE3YMb1eEm4axlB6AvZDw9iivFfyoUMUU65+h6qaVJZazFo2itU7s1EAh8dRr3Z0RZUAWMA4gRqruA1AXSgb7nLjSq9Q93fPINQlNbE6C7E4hqPANOvZnhADUheARrmXg94d0veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763707460; c=relaxed/simple;
	bh=l9MuTE5VheQCTPhfizSRT5jBAOEVsLN5vfmku4wTn1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=evU2KbKmSJUjKOsywWqkXD48l0ntzPTs9CKCt/59sinmC2yTln8jJ2GPXLhXLPW/F5v2pZrjM0oMz0hYki7wb9sgiNcXukXVG3PeUi2wxEhmIt2Zd9fu/MxW82Dm1vzDcFRaR849QLyo35hH6czTC8xdx+eEU2KRzW8JXEoB/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XvFMXs6i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a1c28778so18840055e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 22:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763707456; x=1764312256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXR0JUhcsmCtHv8GpcE2s/3ds9XyZB689MRsifN/sv0=;
        b=XvFMXs6iMJE3FcAIsx9z06xbJcD0RqnIU3mr36jrwyqq4EwMwDQeq7Vn/xRSApG6B4
         H8FqgLJVze406uqB+VhI99EXOzwzZVJRQtuaCHu/MqupCNm013HW6HZBlEJUtF6av/Vw
         bD/Myi4X/RmB809h7Cye2aDTTS7dpbNULTkTY6GPtSOFnEeM3HlGmkejiX6T/IK6c5xK
         BVeRYCrY1xE0ikko70jc1omp3nDPa2JycOp978GL2pTkVuwzoB+4oMqVOW86EvLmuFsb
         PZQEz+Bo7KohgnKJmwlNIg5G3+/EMJqTXjoOSGcBioE/o6idfSXP0r9ooXgxBUmGLGgu
         p1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763707456; x=1764312256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXR0JUhcsmCtHv8GpcE2s/3ds9XyZB689MRsifN/sv0=;
        b=snIzsSfQxyvfTp49W1b+mq4kh6B5bnj7NYsiuCEM6cMjpeIcQG71GHLAVwdylidVJR
         gjt4PwVOZ+ocmKt30lpazfi9dPBC43LjfmG9Q4kooiawsHFGENPJ2tHAcargWRv9e/AT
         RpvQf9c5H22bvDODrIm0A+3/kmBUn1Kgymqrcdd9Y1/wmxMKIcXFYNWI7q6I1jHRHXTw
         APnRGUzci7ZKfpca1S+/HIac5fJ6k92DWQA7efAaCNs0tzpfNvnvcU+wI2MRjqiTdbp9
         aMVgAWKBYnMo8PmFJBEqHB/mTksNJ/WWSQPuFPWB3GSnZKnFeyDEbNHb1Ms4zey2tzep
         AX4g==
X-Forwarded-Encrypted: i=1; AJvYcCUNBMSB9uChT3KTbVUTH45IItECWDkDBi/DWEtuO/ERYKmpjAoaKl3zao/+0rQ1oVkuMu742fTdIPorgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYQnYfsSeMl1whUCDJeV1anw7D+mfVgEE9v7aZ1L9UTnMgEiD
	MWrcc5f9ugtWtVCCDD1xF0rdBZuwa/buKCg8nfwgbGQdgeMrRxbTmBVfylept5OxNvQ=
X-Gm-Gg: ASbGncuInNQmNFb/Fpy8CeqXycDVFaoX7kroOIP6QRvazkvUob9emEpKWRq9hWwn8Y4
	bF5vQ6PUGIhzKOBMeSQbo1JX1uvQNBvXgqoX3QG/9zJ75YiEPD+I+YJXXimc7IoHf20sAJ2+tOd
	VkLgxLv2mc0p3by8EN8WWSCBHvK8UrjEFwuy2I+3XXBvWamblZbW9tpfnMt5uhvVb25klLzPgBV
	k0Wx3mZOYpGQJ/Ovmj8gxCHm/6fbcBT1tQVBkl9OcKW/2lx7NraxOYSKyHVLbHu9jxlXPDRQmiq
	AjJKefkGh6/kIwPhm1pjvxItJADvfcuOySvp/08iA3rDK5HAITjm89O2hXb45AKksBEgI0fLGe9
	f6aLBqzeloPbp/zka2fpQ4mkbLh8D5swGQ6X5NFjX/NjgOGb+1klL1Evh9taaCZOItvh99cluQT
	jX6rk3JgcbHRLT/YwY5WxpQkm2AYYQESqftl3akVk=
X-Google-Smtp-Source: AGHT+IGdIK6trM43tQIGcKRtdsyNFsLvxqida6hjALDLiZxyklMajArhH6t08+l8cjPKgEwcO2Hddg==
X-Received: by 2002:a05:600c:4f15:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-477c00eae92mr15791095e9.0.1763707455751;
        Thu, 20 Nov 2025 22:44:15 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm45907915ad.77.2025.11.20.22.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 22:44:15 -0800 (PST)
Message-ID: <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
Date: Fri, 21 Nov 2025 17:14:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: docs: add warning for btrfs checksum
 features
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
 <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org>
 <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
 <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org>
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
In-Reply-To: <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/21 16:32, Christoph Anton Mitterer 写道:
> 
> 
> On November 21, 2025 6:24:26 AM GMT+01:00, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/11/21 15:47, Christoph Anton Mitterer 写道:
>>> Is that even the case when the wohle btrfs itself is encrypted, like in dm-crypt (without AEAD or verity, but only a normal cipher like aes-xts-plain64)?
>>> Wouldn't an attacker then neet to know how he can forge the right encrypted checksum?
>>
>> In that case the attacker won't even know it's a btrfs or not.
> 
> I wouldn't be so sure about that, at least not depending on the threat model.
> First, there's always the case of leaking meta data,... like people observing the list or my access to Debian's packages archives (btrfs-progs) would e.g. know that there's a good chance I'm using btrfs.
> 
> Also, an attacker might be able to make snapshots of the offline device and see write patterns that may be typical for btrfs.
> Even with only a single snapshot being made, with the empty device not randomised in advance, it might be clear which fs is used.
> 
> 
> But all that's anyway not the main point.
> 
> Even if an attacker doesn't know what's in it,  he could try to silently corrupt data or replace (encrypted)  blocks with such from an older snapshot... which would then perhaps decrypt to something non-gibberish.

Adding linux-crypto list for more feedback.

In that case, as long as the csum tree can not be modified, no matter 
whatever algorithm is, btrfs can still detect something is modified.

> 
> The question IMO is, whether a (dm-crypt) encrypted btrfs that uses a strong hash function for btrfs (i.e. like hash-then-encrypt) would be effectively integrity protected.

In that case, I can not give a concrete answer, but I tend to believe 
it's protected, and no matter what the algorithm is (including CRC32C).

The attack must be able to modify both the data and the checksum to pass 
the check.

But since it's encrypted, the attacker is only to move the encrypted 
data around, not able to modify the content pin-pointly, btrfs should be 
able to detect the mismatch for both metadata and data:

- For metadata
   The bytenr will mismatch, thus be rejected.

   This prevents csum tree from bing modified.

- For data
   The checksum will mismatch, thus be rejected.


> I never really found a definitive answer on that (as in properly analysed by some professional cryptographer).
> 
> If so, keeling SHA256/etc. would make sense for that use case.

Still makes not much sense, CRC32C is enough for the above case.

Thanks,
Qu

> 
> Cheers,
> Chris.


