Return-Path: <linux-btrfs+bounces-18764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E310C39CC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E3819E014F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4530C343;
	Thu,  6 Nov 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cx9t2Okk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D803093B6
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420969; cv=none; b=s3LF4s44SJGZohvDHPOlDxgFizlIqmm55IsbI28BSxMf+DKfy+K37eNDAMURD+kGVQWiRexdnI8pn4p71Z1Emkur4ILhJHTlk6Lo/AvaOlz5M/MbJZDtK7WWyw/bvBi24NRYeZmA6F/fKh2vTjbB+Zx6KUooii7QUYRV37TAxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420969; c=relaxed/simple;
	bh=leLpYAzd+hHiftVoZH5aYx0dOkstYooCeU3ydeJ1h3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPAVAahXTB0qZJVF7BS/4QZT1acA3LIwmCwlwyCTXNIfi5QEdpZOKpbKnnRyTwPtiznhh5A7kSN11iAa92brhlfrl7kuCWr2pOA9nEsgNIxAu6HtqFUu8nxIGQMXFx6SeUmJoEnwrGZ4VA6RDIqdYq2rJXQsqphLvgOTqPTDENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cx9t2Okk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e9d633b78so129852466b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 01:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762420966; x=1763025766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UVuo0ddpMBq/+iF2yyT0r0Nn+svcJT0VlNrcHmQU2q4=;
        b=cx9t2OkkYKNFxhSLtr5dsWxkE5h1q+7/kKScK7q/BqWG9aJn7De6kdYm9g0Rg5Jjbv
         OUYhL0DXBXp94FiwRJ5i7R13F5nBfLRrOxWhv9+C057tW8we6BuVKVMnCXrO0WgPE+ew
         W0fqb3CQOVOWUZXAJZWe7Fj0VPhf5F9k4Orhh1tTwiJ0VshHinhliYYGuGlTWvMhxGCF
         BjI96XVcax06wzbxoAIUS1k8WQrxuK97c9BK7n6R4r8iiLZCNufDxSW4bcxqq8b++Pbx
         zQvC+VVNt9+H1t3c7IiA8BZ+GZ2umAHrp24ogKe4UPgWomnxy4UGc/cELad6PZJeWKqg
         /aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420966; x=1763025766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVuo0ddpMBq/+iF2yyT0r0Nn+svcJT0VlNrcHmQU2q4=;
        b=KEH+qd4Oytg6cduYyqSYcuCyCjEojcaO2NdwZ6hTxqta52DMdwDSjNZC7D50+ltBTI
         Sed4O3yx95Z+FUXwSkWFBqeTnvsi8FnxQDjxTMahgGI72bDkpkZgKTlfcvmZNIf4xPaj
         Ph0aFJR/fJkYRmKvsRZbHyFu8IpaYAHV5EcB7UwDwu4DkJ/2GVRKHvMWEQN+eh3OcDOo
         Bs8XCtMU4NhQXCkHVograg0cjgvaV2LJ9zAllIVwaPdDARWpynbNR4RpS9RXNnWq3+Zs
         41aiAQ4/Zu3jGIGh21HqpOVI6IzUqERruF22wEzlVMd/fl2bwtjnaNTtVzMBSHKnXsdH
         4M4w==
X-Forwarded-Encrypted: i=1; AJvYcCVN7es54q9euMswhPiZ+NSn/PWYF3cup6CIQQplwjrfTo/Z+OVTLdSymFDRdTPl5cp8XJ+SOVvVjKjQYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlv1w+qTX0ltCRyutHLuzjTT0WDqQHQqn2IxHBKoSs0fS8XNmy
	XeK1x7itYPV6yHWgFQFxO3smyEz9cHp4z3xVPrXfr3RMUVlzPA0SZq9ywsHVT9SRLrdA7J4pFwR
	LpHJz
X-Gm-Gg: ASbGnctUhcMFDvo3b8TtPJqK8qhjFwoVZI92WuiPsKrjLW2Ok8kc5eScLc3VIJBy2QJ
	kEL3VvcBVloy+a3WXDwyJmPtIXGLkB/HUwaOCM9C4NEW5XbE8eKRkp0KZNHxh8UVcaFX1JfdvJl
	6U+r8FZ34zmsfnA6/2mF5S70cSsn7bo7455fU2KGrZBFWj/wL4NdgM0SWcCBaTJo02c/Vs10NBr
	Vx0MgJCQdEEtJuZWePFnZaPBmEFyQdmq1Ob3Ydmeq5eB+8oHAn+dS3XpYGuae6yBonJhJAQVFy+
	rfwPTsfkvf+XRRtC+8Lx7GE7/WaUPOAIhEEX9DvC6WDGu+vXKkTrwgf/Dqmxandf+yx7oiyU/gy
	UNzK5wyw/TgWMbjMss+4l8YVrDycHW7Mz0xdZP9ytNR0t0d0Y6hT9xUyeGpqgNe6No/4HDXuurG
	WdWCPI9CXpS4PtG1Q7ExSseGyYImNT
X-Google-Smtp-Source: AGHT+IF5sb+1p13p4tfJyJvemN+5Sx+ZWj8vG0c9VhdCJT203zjKN/Y4cHe9LcBsFOyLi1co/c9v2g==
X-Received: by 2002:a17:906:4bd6:b0:b72:8b12:57ec with SMTP id a640c23a62f3a-b728b12599dmr174551166b.22.1762420965775;
        Thu, 06 Nov 2025 01:22:45 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5cf37sm21660605ad.35.2025.11.06.01.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:22:45 -0800 (PST)
Message-ID: <51f19b05-701d-4740-81ae-83e7afa40bb7@suse.com>
Date: Thu, 6 Nov 2025 19:52:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>
References: <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
 <f8425395-311d-4e27-a7da-46cc0ef35ccb@wdc.com>
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
In-Reply-To: <f8425395-311d-4e27-a7da-46cc0ef35ccb@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/6 19:31, Johannes Thumshirn 写道:
> On 11/5/25 10:50 PM, Qu Wenruo wrote:
>>    	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
>> -		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
>> +		bbio->csum = kvmalloc(nblocks * csum_size, GFP_NOFS);
>>    		if (!bbio->csum)
>>    			return -ENOMEM;
>>    	} else {
> 
> Can we please use kvcalloc() here? Otherwise some whizkid will clean it
> up afterwards claiming this can overflow.
> 

Done, thanks for pointing this out.

Thanks,
Qu

