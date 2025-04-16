Return-Path: <linux-btrfs+bounces-13113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33441A90EC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 00:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B694218920C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A397242902;
	Wed, 16 Apr 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mb5/qCNi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9623E332
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843494; cv=none; b=TdzfpfM8ZyOsC7N7q5yoMQhrmwQ14Ww/mU9GuHKtcyKFRQeAPZ9yDWVpDV9Wt75o69S6LHg00GUdheQnB7hhBo5U/o2fffHZVBcawGV6dbrPlwyY0yXfq8vf2h1NPDmIQPKbQImXD6rgablqaBXhSaNH6ywBIVRxCq+fH4OaS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843494; c=relaxed/simple;
	bh=znKSCkdj2+fk/Oa7ERAaFQyJVAz75oUwuFwOc1dpiJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHcDr0ukK8QF2BIqqdNgq7hoUjEvNcwjhnpQz8VgnFHJusrbEqAMeCtMUY3QspUcF+qHHRGkV0oQtQXO0gqoUqkM2zAolX9Zq+RHugPoTBQd+MPH4ONdORX3rRl+9rzozSePRKRsL7vB9sX4wMBUYtUWAzLej0eyElXvUwyJCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mb5/qCNi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so1105275e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744843490; x=1745448290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hETAzxG+wiRZYJM/IDb00IMN2l5A2zl6fMFESFEpf2s=;
        b=Mb5/qCNiLbiUcIzaDigMyg/qPLWWDceJ1t2Imd30b4VyX0lM02+9EGbwPpDBFeIbzk
         ghOvvyyIY6LT+i4l9cf+Pgr/9dcTsA6RfOY20zumz7cx18uPLcWcHwJXIRvNNQeSW1tW
         +uJfMi+xJtCv3Oq3cNaxLeomp/zIq09U2vsfQO+b1zknDUh4O8Z5vGpJaed8n9B0qql4
         v0vd0PidwuuecJy41X+UT2SaQXEwdZYalU/6c2gHFRL1kPzNALNsTwqyBYfl9YfHk4CD
         AfsdjKMwKDI0cmuflk2LL3llVceuYDY6bYpnwG4rgBV4tAOGiLqlSEdqKX/XCNxmAqiV
         S8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843490; x=1745448290;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hETAzxG+wiRZYJM/IDb00IMN2l5A2zl6fMFESFEpf2s=;
        b=sTyelQ65kJC/BGSBKsgfOJeRBcCx3Q4tN5JGtxmnfH1bsUFnjcrxgOiNTN0bcG2Y4e
         iuNDtevGf/lV30VTSAgki8JT4JFeeXlX4Yf+uvP1OsBXusIn9BulpcyESXcpPC7F7o9o
         R2bkCkkvGl253L9qDes92UV/J3a9bBiFo4dmT/PEcu/74a+AaCR7Yzze5voU7q7vFz71
         1P2Km64mPG6MobTxkmjgTdyIIwNMz8bu5HfFx4UI9PXneG0+p+3eVs0fcfO63I0xWMqp
         ot+EkCMlqMt+w66tIsHzSPNSIYSMPHlExnonDSFET1BAQPfkkYY9M8IOO5Pg9R6ur/xk
         G3pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8qhYRviJqfj7jqk+iWkjlkJuVrMELwIcUsvRVaH3u8dCqmiDY7X++89S8699+vkE6MjKWcYggDEKFwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvrtkzWsxivZk0sC0zx/zpRiShELboxUNDdcxq6sC+z3NFkxA
	dGlV7o1jI840s/KfyYOxZHx3HWZ3mfqoc42gJRNhOgn1un8tFh+37LqHtiQfvVk=
X-Gm-Gg: ASbGncu9w4qHQJchv5XBkEFmyEK83ekwVkU604SbMC4Js4ch+/duGYt2JLyLKozFvvC
	vrOFwx93fLHlll8h7yfiDVjfpCJmRwduOZI/GLz8FXTK1t2lUu1YMpMrjqCQ/7y9kFHA2fWO4Mv
	eUD+J91H+te4LwC8rUqk745KHyEH5AuG+Yk+BYe8pQHHkQGjzYChAXgGwDPFhTZIly/i4+BXDTX
	VIMvGsi1DVpOgRzc8cvH2M2F5+ePbYBOtp0apDWbU4pdgBuGnvdBIWIF++59fM0MH1exNWWz9aY
	ybAbWCyeFv9jpYxjgXowNoQf4afYgHkEarA/jM5j9uAcuZ4BH/2oBq9wsBq3dP8mkKjzfmENS8K
	U8Qg=
X-Google-Smtp-Source: AGHT+IGGrQuGAuMzTo20EKgg1KPp1Gl7+mo6Z+9i4z5CqXxJ7/1H4OyWf14JqMMgXyuhdW4bbXwZGg==
X-Received: by 2002:a5d:6da6:0:b0:390:f738:246b with SMTP id ffacd0b85a97d-39ee5b1891bmr3531348f8f.15.1744843490226;
        Wed, 16 Apr 2025 15:44:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fcc095sm19854705ad.202.2025.04.16.15.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:44:49 -0700 (PDT)
Message-ID: <a05cbb2e-8ec2-4763-b60f-67fa1d766eb4@suse.com>
Date: Thu, 17 Apr 2025 08:14:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Assertion and debugging helpers
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1744794336.git.dsterba@suse.com>
 <dbdf0811-6359-428b-bf23-79e793973c12@suse.com>
 <20250416202055.GG13877@suse.cz> <20250416223002.GH13877@suse.cz>
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
In-Reply-To: <20250416223002.GH13877@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/17 08:00, David Sterba 写道:
> On Wed, Apr 16, 2025 at 10:20:56PM +0200, David Sterba wrote:
>>> So, if we're pushing towards VASSERT(), then it should replace all
>>> ASSERT() eventually. At least mark the ASSERT() macro deprecated and
>>> stop new usages.
>>
>> You can consider VASSERT equivalent to ASSERT, the only reason it's a
>> different macro now is because I'd have to implement the variable number
>> of arguments and printk. But I can look into that, I agree that having
>> just ASSERT would be best in the long term.
> 
> I have something, so the following will work:
> 
> ASSERT(condition);
> ASSERT(condition, "string");
> ASSERT(condition, "string=%d", variable);

That will be great, we can keep the single ASSERT() debug type, with all 
the new extra output.

Thanks,
Qu

