Return-Path: <linux-btrfs+bounces-17076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27AEB90465
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6806188DE98
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45972F657A;
	Mon, 22 Sep 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vlq/XRuB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CEF78F43
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538323; cv=none; b=D0Rm45JfvzgR69idM3Ue1KmlnVKgiwx0DMHtaJSc1fs1zwWy1L6Ttf6mBWrcpAcYTn1R4xRgSItRc+jtKsOaY6dyaMS+BeFC8JtIQx0f70rCkrHQdT7JIuYyAggmT7moHcPXQh4rnrqTIdMtvfkmKEID9j94CbpFThSE/dOmegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538323; c=relaxed/simple;
	bh=wtCHjk/IKnW7bKfw8DVrFKXKvgPJsXZnbQC8x6Z1H9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tteaprFGXMzLCoGnhst0jitAJj8C1QmMD4aJat/kbGwYvF/GhuJQEVJYgqAqibJDwS5ZOLX41nrRPd4OSdfWx6BGl7Wna3L40fcHjWQpSQ1APXL7DtF1flvJq4XtkfTAQA4eGX3STpwAcFayPf5mSOtM6wPLsQs01KlygAzHO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vlq/XRuB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso5011615f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758538319; x=1759143119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYAUvtj9SFAWlZ6s2cw9RGQGom9dWPV1E0qR8Z1GclM=;
        b=Vlq/XRuB+wNSNgrUvPI3yJkX5J+ne+jk0UkNGWDnLR15pukp6ZqNKU9YaBbpE6UsXe
         4Dt01SlYyUbGoeYZl+plxBYbMPSAkAGDFsCeyGBILjibIfP/2LWbI1w8vau0fupawoAC
         wRVzO+LThbmxWcJwd83HMPR8SPRlNvUO3fAYM2rNGlmmfnUK7ZK530mnOYpTvKuijPn+
         dI4mYMwB+V0dK0Zn46mjbPk3b2ccBW90YMVimTGaleAkzOq7mGR0Z/0nh0eN6jp1py+B
         bTC1x0tB6PFGxIpePmSmcOjAmP+P1+rqcbr+U99G3y9d6g7jacphoedQMKiwXKjhbPVv
         jySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758538319; x=1759143119;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYAUvtj9SFAWlZ6s2cw9RGQGom9dWPV1E0qR8Z1GclM=;
        b=q4+KkqsTQv7iodTUZtF+95JMry2lUEHSLquOqCj0ujMNDrODqi4pMB/GkCIkDoLUkl
         YrVnAI6UogKj9+l7afg9O9pPJCHGPKhhFCjxzZP+gY5C7H55AFFC1pJmjziIvu9t2ymC
         a1skZlSv0GFcHSdNnbWjsHdLZVrgel2daLuv1R9nei6CPr0TblDPxjTPWfTfgwqcCJzz
         e0lVeoKyKszI33+0aO36SbdWY1myDYcxrhSIfW1V0GsfClgglGh+PAVcLB3AVqgP9qe4
         sTimwhvX00QLM65lCgKQ4IRWwMdgHZ/ORecS3cu75xFQzwZPIGI08E1gbL6TLKLJBnr/
         5srw==
X-Gm-Message-State: AOJu0Yz6KsPknjzcFGMiLn7cov9o230JDIJgy8aFYN0/AJpOxamYr3Ku
	z621tY2wWy55ILt7dbSAmkWV3YbsHobpNMGyZ7yCo8VcRJmsIbxA9HHQZAVkVJBmPM8=
X-Gm-Gg: ASbGncvKbUAOW9twXaPzpCr1M8GbhYMs31dkvtLE9zJk0n+ULsayb+JByqmoxTWW7iT
	WZOiiDiRjIW+wODiD7Py7asZbZjm4fix9xYcM1sBcBx4aru1xlCn6PL2JN1O1TQqc6cgGg2GIP5
	F+jV8kIwClGKfnjXlymj+C6G5/ARzQ7roln1Pkvie8rCw6OajbItgT3RDMTF24uH0knzskRi59z
	K0ohNh6aqKa6eSk3Ni/I2bd0W1k9Gn3BcYbVjWRRWUG8JT4N9l74QXOX0iO4FQx7RF+bV1O3jHE
	D6PINiOLxMV3K6bVvFKyT38D9wKwngK5vAn+U8Oqw2FszcJVYU+pZ5bCukCewQWBHjJ5OzmS6JO
	nPDKXi1/eROLjwR/x1oSvVo6Ny0AwiWXL+riuWf5NErngHfhsWS1mSlz6thQgsw==
X-Google-Smtp-Source: AGHT+IHAKEajEOHfGjxF5IRE1ZGh14CjPHFA0Pyb1uQXapvM39CVwinDEJZr7Vnt5FJlDYoAVLuLEA==
X-Received: by 2002:a05:6000:1ac8:b0:3e8:b4cb:c3a0 with SMTP id ffacd0b85a97d-3ee7d6864f4mr9239730f8f.8.1758538317578;
        Mon, 22 Sep 2025 03:51:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699ae52db1sm118082575ad.43.2025.09.22.03.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:51:57 -0700 (PDT)
Message-ID: <7598271d-18c8-41d6-80c8-87d645882a05@suse.com>
Date: Mon, 22 Sep 2025 20:21:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] btrfs: enable experimental bs > ps support
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1758494326.git.wqu@suse.com>
 <018a9a3216ac9a4d79562105ea10727cec23e8ed.1758494327.git.wqu@suse.com>
 <20250922102124.GK5333@twin.jikos.cz>
 <1f4c903b-9a7a-49c7-ac5a-76511c514ebb@suse.com>
 <20250922104224.GN5333@twin.jikos.cz>
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
In-Reply-To: <20250922104224.GN5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 20:12, David Sterba 写道:
> On Mon, Sep 22, 2025 at 07:57:40PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/9/22 19:51, David Sterba 写道:
>>> On Mon, Sep 22, 2025 at 08:10:51AM +0930, Qu Wenruo wrote:
>>>> +	if (fs_info->sectorsize > PAGE_SIZE) {
>>>> +		ret = -ENOTTY;
>>>
>>> I did a minor fixup of the error code to -EOPNOTSUPP,
>>
>> Please don't.
>>
>> The error code is to co-operate with btrfs-progs, which doesn't check
>> EOPNOTSUPP.
> 
> Well then we should fix btrfs-progs because this breaks the informal
> error code protocol

It's the egg-and-chicken compatibility problem.

> 
>> And the encoded receive only falls back to regular one when got a ENOTTY.
> 
> But this is still only for the bs > ps case, right? So it may be
> temporarily broken until we sync the kernel code and progs but would not
> otherwise break the other cases.

I'd prefer to remove those exceptions when the sub-block handling is 
added, and keep the compatibility so that I don't need to run tests with 
a special version of btrfs-progs.

The fix of btrfs-progs will take time to reach end users.

And that full bs > ps support will not be that far away, considering how 
many cycles (in fact, just two cycles, some preparation in v6.17, then 
v6.18) we spent to reach the current state (full fstests run, 6 known 
failures, all in btrfs group), the removal of those checks should be 
pretty close.

Especially I already have an idea on how to support sub-block checksum 
handling.

Thanks,
Qu

