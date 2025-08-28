Return-Path: <linux-btrfs+bounces-16513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A66B3AE74
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 01:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178BE1C86C4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8723C507;
	Thu, 28 Aug 2025 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FyQlbqZr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1613FC7
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424054; cv=none; b=igjmjK0DxH/XY/87tiFcRJtKG/XugXSyPn114TwTvdcNBmDdLcXd/8mdnvPxwjh7utehfW+YOLfWtnNX5/gVslX01NrftGV1YvEAgcgiNYi81D8SvMxCnwwSEXRrvGpvuAB3g67m13js3wBZHBq4NoVvSZRSlWP7zopGg3E9zVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424054; c=relaxed/simple;
	bh=Lm2r016WalmWBE/v70IBEr6iWvW9YaePjTcyh0vSCrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOLKk1hxcUszKFbeVtd4T0jJhegxbSRzUh5WkzRUDGwacIzOCU5e5jUvSLpwiF3UWBPeAR+khGFtbMUV8St2FohfEBcnsGVl7NVBZrmsIxTik3xtJkXtyjP2OXIK1Xs/hZv01sAQgDuw1h0TLNASoqqheDnHrlp75J1HJS3687k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FyQlbqZr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so630399f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756424050; x=1757028850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KxvcrMwaCd1tXhpxtoLa3VmX4SI5spiGBIdly9xUmis=;
        b=FyQlbqZr9/F2y44dEaqfZyoIGoS2tw2j2pHmkcAHt8WcbyW8UiOH6zIDR1BIPy6khl
         uKbI4w7EuwXxPJSQXvKzyyMD8ZdRv+zizLTpAbSvRH/VlDfXvguY5kbaW4OQ7dtue4Zz
         LTgKv6dHiJTWs7g2rgD+X3KsAErB4jzYPLMzOndwGxI28ng1OQdPpWyHCHLFdKlUx4Vx
         a6Xpg4ExKXHmMhBZKhxGT2Pw/ITHGMPfeHepZM+j9tcyTtjYUyU3o1l+sTFzIKK8AvHC
         sjK00lh7mckKKc28I7fh/jeWLNKkEClrWmr9RvlsWmNwldUvlsEi+jzlIv5ha7f+aIm+
         3wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756424050; x=1757028850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxvcrMwaCd1tXhpxtoLa3VmX4SI5spiGBIdly9xUmis=;
        b=jISl0KkmV/H+Avg15pxVZYgUY2TRyn8MyVtJzS2z028o0D+LK625SVWcPRi7X9EkcH
         AQNA3/DUwIOo9XJYBSLJs3TR6MgzLMWUTTG5eWvr+rkxsxip7LfSdMFf+TznW1SkWdbn
         gLk/BCTSmeMGxMmMuyVzeIPba1DFet7aXWt5act5YseGES03pX8+6wBv5Edt2KQ/37Og
         lbd8j42Riv9U1AYYqAD78kHAj9zbgckJApNcDAVotH8jf1y4vi/96SIljw22aprQXeHW
         axPRYn7Oz/iAczxy9p4fTZlN4QQxuK+h57XqipJA4p0uJnPbL+mbyq9U8RWSrWSxiEz+
         bsRA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTgfLvt31cqbyRLmglSZlIz/JGh87k8inSGHcIkcEBQyHxskVsLf2Ur6aDTSbd6X27AcfRLGs/8v9pA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywesev2Y9acqekE2zU3AZxg2/9RLlXfcKzTcyUyQKfKAlyPl5ZF
	jHGJBcHYhV6CPCaVNccrmh90a0OBFDYD2lfU0w0zmyWXmGwEL0DrKlJQZTztbT3EE0Q=
X-Gm-Gg: ASbGncsMtg5KXYvos068akcX6rqn6R1qjwpQA+IZ757y67yoIrdGBNBHv2I8t0UdZcx
	64vjHWa6bNY9uB0JZbkBKeX/v9GtwqFuiEY/5IvGhRMT73u+Q742/cSnYakB56GYCUQPdNrnPfU
	F54We3IpReYX05UVKKN6RhTwnwiT6BlGqN47ZdsHYNqA8ysYphd1AH40/3Tpnkd6+wSIfVUfn04
	PZmxPNYI8W6HVAotRxkGDuUVyuCM9oNqqWFBPSFxnElLWutxVI5kh1K0rnmusMe9YkfKFgr+cYC
	uGcN4zI5LnkXfILdzUiWKcwGKoua9nPJk7Fs4Ap55i8flY4/Uofg90jGak5VCYXbUm3If2Vge6B
	DuwzxqI9Ryo9CYbarw9inpgh9oHUp1Z1gJTRVd33Xt7FjV9FUk/7ULK1ZgXnB4A==
X-Google-Smtp-Source: AGHT+IFWLYr5m61dxzAWPbfs8vxCt+VNY40vndSkd3pO16h2hPauULxGIrlPHhpE0tJlL1qDKRebCw==
X-Received: by 2002:a05:6000:3107:b0:3d0:205e:9768 with SMTP id ffacd0b85a97d-3d0206de1ccmr207478f8f.11.1756424049897;
        Thu, 28 Aug 2025 16:34:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm576214b3a.34.2025.08.28.16.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 16:34:09 -0700 (PDT)
Message-ID: <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
Date: Fri, 29 Aug 2025 09:04:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
 <20250828233011.GE29826@twin.jikos.cz>
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
In-Reply-To: <20250828233011.GE29826@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/29 09:00, David Sterba 写道:
> On Fri, Aug 29, 2025 at 07:56:31AM +0930, Qu Wenruo wrote:
>> 在 2025/8/29 07:23, David Sterba 写道:
>>> This is preparatory work to use cache folio address in the extent buffer
>>> to avoid reading folio_address() all the time (this is hidden in the
>>> accessors).
>>>
>>> However this is not as straightforward as just adding the array, the
>>> extent buffers are of variable size depending on the node size and
>>> adding 16*8=128 bytes would bloat the whole structure too much.
>>>
>>> We already waste 3/4 of the folios array on x86_64 and default node size
>>> 16K so we need to make the arrays variable size. This is allowed only
>>> for one such array and it must be at the end of the structure. And we
>>> need two.
>>>
>>> With one indirection this is possible. For N folios in a node the
>>> variable sized array will be 2N:
>>
>> I'm OK with the variable folio pointer array, but why faddrs?
> 
> It's explained in the 2nd patch, it saves the lookups and translation of
> page/folio -> address
> 
>> It looks like a little overkilled just to get rid of folio_address().
> 
> The folio_address does not show up in profiles becaues it's completely
> inlined but it's in each and every accessor.
> 
>> And to be honest, if we really want to reduce the complexity of
>> folio_address(), we should go direct to large folios, which is much
>> easier and less risky.
> 
> In terms of code perhaps it is but it's still a major step compared to
> the individual pages or folios so I'd rather make a few more steps in
> between.
> 
>>> 	faddr     ----+
>>> 	folios[]      |
>>> 	[0]           |
>>> 	[1]           |
>>> 	...           |
>>> 	[N]       <---+
>>> 	[N+1]
>>> 	...
>>>
>>> There are 5 node sizes supported in total, but not all of them are used.
>>> Create slabs only for 2 sizes where 16K is for the default size on
>>> x86_64 and 64K. The one that contains the node size will be used,
>>> possibly with some slack space.
>>
>> I'm not a fan of two magic numbers.
> 
> It's not magic rather than optimizing for the most common case which is
> default of 16k and a fallback. It does not make sense to create a slab
> for each supported node size while only 16k would be in use.

It is. And all the two magic numbers are all based on 4K page sized systems.

This doesn't look good for anything with larger page sizes.

E.g. on 64K page size systmes, the 16K makes no sense and will not 
allocate any space for the folios[] array.

That's why I hate this two magic numbers based solution.

> 
>> Can we just make folios[] variable size first without bothering the
>> cached folio address?
> 
> Yes the first patch can be taken separately.

Not really until it can properly handle all page sizes.

Thanks,
Qu


