Return-Path: <linux-btrfs+bounces-13589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA26AA57AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 23:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD7E4C6085
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823ED221DA2;
	Wed, 30 Apr 2025 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bpHSzkoc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833122129D
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050326; cv=none; b=sP4ucfovFLG3xXChfZiqPievUitT0ODcQ5jeEeFAJPKKx+BYMDR5tv+MfYzydfZrJeAfGT2YBRWx6w0EE9tRDp+tSgZl8ObMvbrMH9JAcnIZLxnE1x6zzyi6K8qqtdXyuAefYI5lAtgWwIO7kL3LFtEs+FFlLkk30p4VVrqrozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050326; c=relaxed/simple;
	bh=DmDqUDXb39rNnGXKQjQZrPbdivhD4PmYkho1j+hYWfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mglOMSi2QjOJg4MsyKnRpGa8ilRGJCtDBNHnCnKAVfjv2TTalNZGghS0Pyd7N7j+2lRQOwjmvY8sjbfOUp71hMP0MLcXZ0KK9Zeq/FqUrRwQL1DtBmmq8BYWKfmxQlSr6m1x/fYDxRT8AsLeN0DAy9dI3Ppmw6u/2ukqtN/Nves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bpHSzkoc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so211008f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746050322; x=1746655122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eWWrqwnLhQenGzV7KAIF5NRe8wBhEqWcnq/hVFaM2vo=;
        b=bpHSzkoc2F2b646Fpy+rMJr3BqXjNCXYVA1tif/kMxhvoxQkD5Msl55G5Qe+btCsjJ
         6ltZ9dfGTG5vlWYHixwNzcuE7mlsJlDQK0xmOix2zwljye/GnBIOY5SY7544cqqbI6JV
         519jWDrcYCW5UU7vDXp4yB7mme+1fKy15BOPw6BZrBrXabWJRW26D+RRd8V4VAbxRGgQ
         M9eAnytQGUPSo0qCy8r0C5T1AJ2LyX2a7J3A/AFRN0Upx/LhMhD+6h2HPTgWey8PVA94
         bM1x9kMAuPQAIg2RRf7wWC/7qk+TijuFWYuoMnHsMLfF2nB6I3bxvXkkABcpbfaItffE
         4I2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050322; x=1746655122;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWWrqwnLhQenGzV7KAIF5NRe8wBhEqWcnq/hVFaM2vo=;
        b=J7loUSRmWfks1fFRHN76rXz1jP/R/6CI95Nm51zoE1UtL7seJgnfIn7Fkxazrr4DYn
         1sUFcvqgd7vjgcMN8qRlnLAmr6mhyAQxv85zhdCnFCebNLQTBoP7NZyxBCTv1HK2wCIW
         uQFZXMWCQMmBSIXQetcJ4S/f29GeJYePCj1/RL56yBFY9taeYJg6/oeRa0EOHnGDBPoA
         VfZBWlETjtw5V+dtCZaDpj6B7FoO7kmhQBw/dqycVbEIEgrBzsha/o5qJiUU5loN7rDT
         7+3adjqsIaQl8SRtd2GrWejYDbN0pk0CCMfpFuLPjnTjUHPqpxmDUwnDsFQa09pK/eKG
         mncw==
X-Gm-Message-State: AOJu0YyVPPU1gsQ70ITBQaHAAOTvWOtrJOQ9MeW09mPW0znbI8DdvNXC
	2LgnuYGrJd9flvCrIl61Lh0jCYsll83LGEui/XoOKr9BiE92puyRFUE2UUJOR9w1ahSaJ5N/0iN
	F
X-Gm-Gg: ASbGncuOpGgiDtHLdYRu3VvqLmZbIYrH8ZlbMWfosHruh8vWUzcge9fW7cHCenwDFha
	5K9Cl99CytvrpfKOJMd3iiN6uKzX13/SyCo4grMwRd0+jaB0EpXyygjT1w6KEg5tYC1xyOnGZtv
	+WzOERFd1e1dYYxV67I3XJrP9kWMIekRsLUtuzu8fYWD1tGHJqRfpBhXoP3zaHgL51Re9mnMLnW
	fZLVCGe1Hq129rgx+m97em4aylccDYyeTZu2vFnj6F8e6xr11IlPVohyuoiOfRJGx72FrFq9Y58
	Ha+w2fh4s+eXo4Z0aAxpzhXOf0lXOFe/NOf/BCGbxP4vHExRtzrofbbvA90IX+5ilFjk
X-Google-Smtp-Source: AGHT+IH5Eb4Jkfd6+vRTCWMdJR6L2pQC13p8tAj8m7BGPVv6+AWfwiyf94K7Td8ugHC+mjzblJg9fw==
X-Received: by 2002:a05:6000:2ca:b0:3a0:8c46:1763 with SMTP id ffacd0b85a97d-3a092fd9094mr560237f8f.0.1746050322017;
        Wed, 30 Apr 2025 14:58:42 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d77395sm127279355ad.5.2025.04.30.14.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:58:41 -0700 (PDT)
Message-ID: <9d1c205f-fc6e-4503-ae91-9917f5cc2eaa@suse.com>
Date: Thu, 1 May 2025 07:28:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
 <20250430143035.GJ9140@twin.jikos.cz>
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
In-Reply-To: <20250430143035.GJ9140@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/1 00:00, David Sterba 写道:
> On Wed, Apr 23, 2025 at 07:54:42PM +0930, Qu Wenruo wrote:
>> With all the preparation patches already merged, it's pretty easy to
>> enable large data folios:
>>
>> - Remove the ASSERT() on folio size in btrfs_end_repair_bio()
>>
>> - Add a helper to properly set the max folio order
>>    Currently due to several call sites are fetching the bitmap content
>>    directly into an unsigned long, we can only support BITS_PER_LONG
>>    blocks for each bitmap.
>>
>> - Call the helper when reading/creating an inode
>>
>> The support has the following limits:
>>
>> - No large folios for data reloc inode
>>    The relocation code still requires page sized folio.
>>    But it's not that hot nor common compared to regular buffered ios.
>>
>>    Will be improved in the future.
>>
>> - Requires CONFIG_BTRFS_EXPERIMENTAL
>>
>> Unfortunately I do not have a physical machine for performance test, but
>> if everything goes like XFS/EXT4, it should mostly bring single digits
>> percentage performance improvement in the real world.
>>
>> Although I believe there are still quite some optimizations to be done,
>> let's focus on testing the current large data folio support first.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> This is behind the experimental build we could add it now. I'm not sure
> if this would not interfere with the xarray conversion of extent
> buffers, that we need to get stabilized and tested too.

At least all my previous runs with large folios are very boring.

And in theory this is only affecting data folios, not affecting metadata 
folios.

> 
> We'd need to have a separate way to enable/disable the large folios when
> the experimental config. A module parameter might work best and it would
> be just for targeted testing, so off by default.

I'd prefer not go the module parameter way.

Larger folios will eventually being enabled for end users, and when that 
happened, QA guys needs to change their module parameters again just to 
remove the no longer working one.

> 
> Alternatively we can postpone it to another development cycle and leave
> it on by default (for experimental build).
This one is small enough and very easy to revert.

I'd prefer to give it a try. If our tests show it's really boring we can 
continue pushing.

Thanks,
Qu

