Return-Path: <linux-btrfs+bounces-18414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D278EC1EB6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 08:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6258D19C1CA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 07:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235CB336EC6;
	Thu, 30 Oct 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dESBZqrb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52358318133
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808473; cv=none; b=E2Y5ywAfo2mnUfiuPtbKIXA0uV0TYd40lGioCJMKcUiJ7S8q9nuwGNicCCtJG+wSxuXLASPSQugRiR5B+HFhktcVOCxtzxfrXQtwTJheQSFNC028E9TXPo74A/JMobOOgiwuuflq5RF+edt5HP4U6yFfEm1KTFr+pS/kz8YofmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808473; c=relaxed/simple;
	bh=XMlrJEWTdkAKXDcZVo3PSrnFRhI521tu4gKbZ0l7fQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQD7Zc7qEkKwg2bHyQuej1ul1QTOzWl297RanxkwbvHLsE2Yj5PTpFDstHPovBHddpsaebC2VIGQW5fZOHK0Ogp6b6AkgnsB+LiQTf07cSEcyULWFqX7cMihulfq2QS/UwmMUtNlD5sQfm9/rpsNGJ2YKy7cw3z/18dhalkgPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dESBZqrb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso619882f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761808470; x=1762413270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aH6T32Cb7TYi8VumYlF/21u6CEuW0X6v+ipNrECbl3c=;
        b=dESBZqrbJr9m7OWaPAwMJ95tYkFIOS+NwWaX9JNkA9HUJCHaX7GCOWGG5hXziKdzE2
         1TAXx65D1LUwmIR0gu45LUHth75+7K9tCEErn+8KTRy12ryjSVruj64pcqKKyDv4UCes
         Tuq5t6YZwU6DYZFXXKsfhnIrTqB/9Aity/Gelie/uB6OydNiugpotdXyxMmSs07XVsMI
         YxUB8VGaD2Cc5eLrax3ZzKXs0iRncIkshZtw6FJWDv27YBB8SIgQZoBg7zH4XHWmpQtm
         tfWvINqsrB2zEIDo/Ql0ABnGkOKTDnE5W8sGgfGj6t49J8t3M8Hd4mP6IKxKKPAgLIPR
         KHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808470; x=1762413270;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH6T32Cb7TYi8VumYlF/21u6CEuW0X6v+ipNrECbl3c=;
        b=j7EhX39i3RKMr9OEQAKvuywodjBUGjQZxEN1vdubzvS+Gk0YCbIuSsJEhmAn97OsxL
         0Khh0xkRhf3sXYy9pSjEqMAts6f4WRy0sHRNzh5yxB5Gg9Pl39azhQ8IHGaW+Xgttgb0
         pdMJVCrUAWb79OOeEHt/EK+0RuLXniiA1vFu3eNmsImrRXe2Lm0B4Ow8ZXWmdlRT6dvz
         xUhg2cbD8X0HsmxaaeSGrtXTRxEeCjNm4sH9JqzpjQeEQbj6ql/7PdxJZbB0r0fqeMoc
         igkYjUdiuIlY8SmNZPKJukbW74xp1w0AqfoTH6gyisiJxVgTbYFVCkZYZRMEx0qJqNUI
         sOGA==
X-Forwarded-Encrypted: i=1; AJvYcCVwaG1mT4xOB+wHMvQlx+bQYxcpi5UJZX3md5XGjjeDOgL7In0xTfyxNC7okj7g7HiqTBH4cnGxAdJicA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZ9hXocv3j4p7eiNxWMWt2aI5Nfe6wCB7zM/9nbmEKrmVhTvz
	TD9QnPTHS/5UxCLigM71YgMC5AiTHSHQmyhUaSqPK6RrxNWqOYL/16k4RMnv342uka0=
X-Gm-Gg: ASbGnctbzQxt1CLZT9SdK55F4Zvy7VNaQbVJw4h45DtoN8P8gfF/E2pdf4U+VF+DjI5
	zC1rt5Bp2NWhyAm4T0ykUGT0PtQnVTBSPcWoHmJr6BASqrOoTyx1rBZ8T+hklDrwuvew91ClFbL
	s8A6sNNDofpIEwjAWb8AT5M6qP5FH4PIVZGMBE0ypeY4TAvw8EoKjR1JyLgslCLQaHv1C9cuqQe
	5b6si9HUsPiJEKZ1hIJKQ0tGmAs4ddVShLk5WUTia63Gs2OjLfh1ZHVGycYWRsQs9TBKtzu+rhH
	UPdZKM9ERbqQh1I5zJ9kIV5iCdwmADUSMuKwnVfKSWMMe+ixxAiOV+riU4Ywb52SpSnzC1aDJGJ
	CMdcKqzU6+kG334uAk4gsJMm7LLrn+wmxqoesT8draQuDg/zFfmik+LyTBXyZPq/xDcvpBUwx7d
	CBUm3+7QmoDJXsFyH2MIDbU2LsXaAKCxvBXW2GtMg=
X-Google-Smtp-Source: AGHT+IHn7MtTON5++FHTniNKg/4xSWijqk1ryDdUxKxT7I/HueMz7ChV39hFowYXxw84gLxbWRyTuQ==
X-Received: by 2002:a05:6000:43d6:10b0:429:b8e2:1064 with SMTP id ffacd0b85a97d-429b8e211e5mr534668f8f.47.1761808469621;
        Thu, 30 Oct 2025 00:14:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm175434765ad.44.2025.10.30.00.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 00:14:29 -0700 (PDT)
Message-ID: <c3512f2a-f995-4642-8eb9-a227890ba856@suse.com>
Date: Thu, 30 Oct 2025 17:44:22 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de>
 <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
 <20251030055851.GA12703@lst.de>
 <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
 <20251030064917.GA13549@lst.de>
 <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com>
 <20251030065504.GB13617@lst.de>
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
In-Reply-To: <20251030065504.GB13617@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/30 17:25, Christoph Hellwig 写道:
> On Thu, Oct 30, 2025 at 05:23:32PM +1030, Qu Wenruo wrote:
>>> So what is your application going to do if the open fails?
>>
>> If it can not accept buffered fallback, error out.
> 
> Why would it not be able to accept that?
> 

Because for whatever reasons, although the only reason I can come up 
with is performance.

I thought the old kernel principle is, providing the mechanism not the 
policy.
But the fallback-to-buffered looks more like a policy, and if that's the 
case user space should be more suitable.

Thanks,
Qu

