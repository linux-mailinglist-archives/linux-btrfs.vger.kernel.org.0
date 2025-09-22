Return-Path: <linux-btrfs+bounces-17073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E1B903C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC432A2E1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F82FBE12;
	Mon, 22 Sep 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aL9aX9bT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE1296BA2
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537703; cv=none; b=SqNnt4977WFzgEu0VNv9afDKOxn0DVx6eVGg0ZsCsxqmP0cwGvvEl3ONtBG21F6GQ1imBQnl9QwkzrHaSNlF3IgzLaMbQHWjwE9S7wZN/C4xahYKHtVghpIXUSOLiz2BRZqAmBvx3Edh1JHR62ajkwkFS2rIFE1S6YTFGrdmHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537703; c=relaxed/simple;
	bh=neN6cCRc1fymNdkkr+3X5LP4L5KjTJO1yydYMI0jGC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o2sezU9ykBAwajM5CD3dF7nFIhYSLrp0o+EW0TJU5RsZt1v8ytnB/8J6Z55Gu7tF287AYFc+CBA0NVaIBoqRf4wV1K2u7Ntl/sDQI5frFwFuDAQtLkUsXQSZzrElFKFiWQubgp4t+pJyar1cF2zZpNraW3VkYvsAHJWsko6icHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aL9aX9bT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b303f7469so11548225e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758537700; x=1759142500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ekgGJOZXJQVlLOzbK7sUWqRJRHJzWmXH+8SPyJQgrY=;
        b=aL9aX9bTCgL4ZxYGUi8Dc2w6wANJffLmzWGecgx5BgaEmxngxDfo2Cwwef/4w2Kvcx
         Ny8KP9OdwvVP53tMBE7qCCrPfe+qoj8iuVY15Frbu9j40tj5CXK84rYmWdrZ5b4ypJw3
         JLsisa/XjRQubSzCk32lApM/pYXAFr8fRi7bSj/OiYMMohN/YFtj8HQ9MlLZzBFhoOzC
         PPv1+s5qLBm8byG1tCnVfV1tCVWnCN+/T0ElEPhpV/ZeJGyynwOozqm9Csc0dJ9EQQNL
         u3si8jvIC3ZQF0twyVeHU9VsDK/WJRNUMQvc0a2wMdA52JmRSOZAetYCOrElpPy96UA5
         DiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537700; x=1759142500;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ekgGJOZXJQVlLOzbK7sUWqRJRHJzWmXH+8SPyJQgrY=;
        b=vfnkJ10g3FNNUmcA74IrPdKTxmdDF6BgxmB2/PGRb54DPdXnk8/5ciXpKdozuGYV7+
         f+jfdqiofR3Htsz86ZA+QMQnPBOAnns8rES4rOXbE7BG5wzlp1eGw3/CcA+7FtpiNsvP
         RAevrv5PfUtsO6V3aPa2ypjihdsYKBkLYJq/5Q1+2uswYFgwdNCcw8QwTVKOf/cssv8k
         CoYeOirhMgsHO/9aaoDl1lZxR27Ena0tGva6soHqLLQMGgiKSGvv/sz31JAiG+IHR3jT
         +WV2AFz8pJ3meQsP2tJ+g02kAaaOVRFxuKLgSLlB2foxN75mMYChqRZIvvkl+Vbl9+ZR
         IpUg==
X-Gm-Message-State: AOJu0Yzf9xfgeNGEQ8xokv7SzR6py5v6BFrtRSYpEFhwIGB4DiLKdnml
	I0CIROXiapPbHWolDdO61/iPtATz8qOJBjCT7z6+ynF8NPSSxFc78mVDnBDupoU3begL8fhJSFI
	xKF5Z
X-Gm-Gg: ASbGncsesi3IiXSVrnqplrDxbYbzf6jXkolVTJHTeI20d4vhN/IaDOXTE8IEm02DJZ7
	MR1xGsr96ykK7ZIGRxBmUlne8MTodr3JOhTTtuIDHT07zfDOWZL3jv+fsvG0NRATBSvZB9gnz3m
	e9zSdVf0f7FzSa31JToR06Amfk3tkEwAmK4jIK1bO7pK+kpFEGsBlbPPfbiTCL7MhOSTaaZKXir
	p5RT8sgtPBgvM+Xt4AA6xC+HVeSeGRtnh6VVceQlETBSpd974rDQMMa2zGLAIKKv8t7g+UHjcrQ
	il4mAo23GJSQkg3ucRVyqQeVGcnHlCiprVCfhX191Ze2DVMVgbr50+AXD4SjnEViDDN/uRb81lU
	gopDVCBPJqIqZEVRPNxwfnlhhLS10/ROvEy9DXvqTyLxBN4JkMic=
X-Google-Smtp-Source: AGHT+IFlbHjSP8V//bhDb6H5VZYo2RDrr9fd6XfTVGoUP6dBXxdh42DxpI/10vbnn72TsPqvR4ErlQ==
X-Received: by 2002:a05:6000:2911:b0:3ea:b91f:8f4a with SMTP id ffacd0b85a97d-3ee7e106ae9mr9790718f8f.21.1758537699669;
        Mon, 22 Sep 2025 03:41:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm15919871a91.11.2025.09.22.03.41.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:41:39 -0700 (PDT)
Message-ID: <d4608ad8-c847-46bb-a4e7-b4b4b395c1d3@suse.com>
Date: Mon, 22 Sep 2025 20:11:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <20250922094304.GB2634184@tik.uni-stuttgart.de>
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
In-Reply-To: <20250922094304.GB2634184@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 19:13, Ulli Horlacher 写道:
> On Mon 2025-09-22 (17:11), Qu Wenruo wrote:
> 
>> Btrfs RAID56 has no journal to protect against write hole. But has the
>> ability to properly detect and rebuild corrupted data using data checksum.
> 
> As I wrote before, I could use btrfs RAID1 (only) for the / filesystem (64
> GB), the other partitions without any RAID level, just simple btrfs
> filesytems. No md RAID volumes at all.
> 
> btrfs RAID1 is not prone to write holes, but is able to rebuild corrupted
> data using data checksum?

Yes.

Write-hole is only possible for RAID56 profiles which needs RMW.

RAID0/1/10 do not need RWM at all, thus they are completely safe.

> 
> Then this is could be the most robust solution for me.
> In case of a disk failure I have to recover from backup.
> 


