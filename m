Return-Path: <linux-btrfs+bounces-19232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD7C768A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 23:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13BCF345B69
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 22:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F972FDC41;
	Thu, 20 Nov 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RgOMbhD2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBB2AF1D
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678224; cv=none; b=dSlc85W5SwnF31WpXcNR3ZwuwMQ0BXiRMl4s7NPVkkaRQROnO3agd5XChNrPnE9yU1pmUnkp/Fi9fryDBiWjM1gg4T8jWkxzDUfQaurTzLg4BhFE/QggoAGvKA63fuAam4kpkB0eJvvtHpMm7XCLDaNvcDsILGncrzK5J4Kv7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678224; c=relaxed/simple;
	bh=AcwuMcZ/RJFqblpVlPWKyfVp/SwXhjj1Ku4QknIGlW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6ZGltmqWbD4fIbZ+aX+xcupU4ZIZfbHdRW2dlSArHpgaHBu48lp4JQvURpWEyG/k1bPciAxXT/xYMPiUzl6HTFVWgqDXqbowZcoIkmSlFMZdeAzs9HcMGLG5C2a7jAkWjz9wAwc7QyoGUEV8mn5lntLTEncp2n5xPbrfAdTC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RgOMbhD2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779a637712so9441445e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763678221; x=1764283021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=teHzbHAZt4K2w/tuw2YsIconSZped389koaKoK927cs=;
        b=RgOMbhD2Lo2pLWRPXs3aBFQvMHOq6MABjqbv3xby5ctGfm347SnhOxLVDGymWAuPc1
         thR0MWDyM7ciFjrj+/fmYnRQWy6hymEKs/M+sULcwuagt88ndpwucE+emblAS2zLY7nf
         gkJFwXB/iJzO3mDOY4y6hftELTvjwvZahE+aYUpNbFrLZl1KoxA3cX1Nzx85ITwDz7Ff
         5ew61T2oTqMI5lwLTOm1AIvGP5+Ncp/kFnXkBnvKeDM+H405xNcC++3ac2pzlAEAJ+du
         hGLrXmn5DkG+ryy/YhcSOIHCsxwGZ1ieXK5ffjvctdhHgGDuY4aEZZgn9BJC3ixam9Qp
         v55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763678221; x=1764283021;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teHzbHAZt4K2w/tuw2YsIconSZped389koaKoK927cs=;
        b=iifXswsDFPCy2pgIIvn76y69tHpBrAf50wicOWApgrfmNwdBHTEVdJ2TLPvVW3ktdk
         RwENdY9VyaeYMOzuq1caotxvj0XGBSko7umfkR1TWYXXmXY1tjBYPEvKF+YHYy629VJc
         cUHBmwbb5jhc8eS/F/nRSByLmiWg/NTXHAwQUVz2E7TqscfHnMWMvnsp+YFjVowyJ+/a
         PrQFC+gdaqTRYhjhnQ26n2bbOj7wNIi2kQHKwUS5gS/PNDmOSmcnuws8k1dz5OcnWgIE
         sokoUWK58At2rgUNAQPZgl5t8b4eDz5Mdr0vCT33o4lmOzeCzNnflfS9LIgL7JYbxWNz
         wwig==
X-Forwarded-Encrypted: i=1; AJvYcCV3+6uzbzJtw8RCImDbaIqIuVSEgNe07oL+aA7Tyxybtr18wRvkSs3I1sRiBf2vLrvGiHrjPrcuJO9bOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoqksz7hMhdb5ub68O3veUBaBCkKk7g2bUODX2agXuIMklUUU7
	a6u4RW2EkjNpNmYmFPFMrNvujmjhpgr2u/826KrjOxoC/OZe6WsBBB5qUgMrSJyuFDNI+JaUbRG
	wizI0
X-Gm-Gg: ASbGncvi9kLpYsKezJQZsysBhVcY8MFCLWJ1JaQVMTQn2HnxI3tOkcRSVL2N1mNY8lb
	KDXK1bbLAJZq3DobQhZlQTfv3MM4HeeR/peNbV/5fITQKCO75jCpblsQSzSEkwLKuSwHTx8GGj2
	QrJZocU51xWupYjq4NuRqWVLb2WoMofLmUrlqCzXG4kFcu8wvk/GCtWTl7Ix80vOTx17rMTJ+fb
	MwDFO3yYG2TWKAcPXQJoR0rmYr9Y8PN4duOSXd8qCJVUzS8OkuizVuFxaIVr/MeRIzdkQYRQWDt
	ya7vJCYSgkgjCNFhMHhCWgaEXVJrdVSRI7nS7dZs3vR3geNBm5y/sE+wyPit5yEOWXj2iqyG0pV
	6hwqN0mZC4L00CuYjqiqFATjS9ImT8jSyOF2aokNPo9o/ibYNadQCDiFrCc3xGUQRcRe5Yl8Pzm
	7hxd6Hxq+Jp2W0QtQR0QdlbDce+a52KCWysCfvc1g=
X-Google-Smtp-Source: AGHT+IEi30R7PUEVbcV7RZ1AGGSluhU9fB1gMEH2YtJ/it/mkxTjTJpP3f7nP1Hpolp5Du9gRTeh+Q==
X-Received: by 2002:a05:6000:612:b0:429:c54d:8bd3 with SMTP id ffacd0b85a97d-42cbfb43efamr1062637f8f.53.1763678220800;
        Thu, 20 Nov 2025 14:37:00 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6321sm3584201a12.6.2025.11.20.14.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 14:37:00 -0800 (PST)
Message-ID: <832a46d9-8766-4fcd-a319-940e23a4d765@suse.com>
Date: Fri, 21 Nov 2025 09:06:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Questions about encryption and (possibly weak) checksum
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Daniel Vacek <neelx@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
 <20251120223248.GA3532564@google.com>
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
In-Reply-To: <20251120223248.GA3532564@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/21 09:02, Eric Biggers 写道:
> On Fri, Nov 21, 2025 at 08:28:38AM +1030, Qu Wenruo wrote:
>> Hi,
>>
>> Recently Daniel is reviving the fscrypt support for btrfs, and one thing
>> caught my attention, related the sequence of encryption and checksum.
>>
>> What is the preferred order between encryption and (possibly weak) checksum?
>>
>> The original patchset implies checksum-then-encrypt, which follows what ext4
>> is doing when both verity and fscrypt are involved.
>>
>>
>> But on the other hand, btrfs' default checksum (CRC32C) is definitely not a
>> cryptography level HMAC, it's mostly for btrfs to detect incorrect content
>> from the storage and switch to another mirror.
>>
>> Furthermore, for compression, btrfs follows the idea of
>> compress-then-checksum, thus to me the idea of encrypt-then-checksum looks
>> more straightforward, and easier to implement.
>>
>> Finally, the btrfs checksum itself is not encrypted (at least for now),
>> meaning the checksum is exposed for any one to modify as long as they
>> understand how to re-calculate the checksum of the metadata.
>>
>>
>> So my question here is:
>>
>> - Is there any preferred sequence between encryption and checksum?
>>
>> - Will a weak checksum (CRC32C) introduce any extra attack vector?
> 
> If you won't be encrypting the checksums, then it needs to be
> encrypt+checksum so that the checksums don't leak information about the
> plaintext.  It doesn't matter how "strong" the checksum is.

Great, that matches my expectation.

Thanks,
Qu

> - Eric


