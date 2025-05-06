Return-Path: <linux-btrfs+bounces-13712-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940DAAB84A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 08:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5551BC6132
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 06:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AC190462;
	Tue,  6 May 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgD2u6Wk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CE1C831A
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489941; cv=none; b=PxKNKLxiOXrWz/4Pz2IUN5u7TGDntg2lNmYbbeDiccA1GM2+ZOW5hByTby9nr31ge+TM0ES0n/wDw46pkVIg4ilppUh2T25K/uJYxWAI1mcv5rKOVjiWANuOiVB3ZBpF5IPI46/O+ENS022yraYS6tK8YVsWn3l4mtTf+2ZoVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489941; c=relaxed/simple;
	bh=k43Z4raYtXrMI2PlJmH0rNoCHbFzSJoTIQ6dBGB3rZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPoVNUEf7LuibxaUTALcEuNPi/Pk/03yJeD9s3qhs80wqPd/z8JBywWe8+4WWCykaHz24mE0vt35VvJF4lANxddEFgJmgt56rTLDj/9UjoxVRhYdfih9hYcvZy4wR2wzWgLjvs6R3lVsExRMgY0AszKgwemC5L++oXTUr0yI/Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgD2u6Wk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39ac56756f6so5451503f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 May 2025 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746489937; x=1747094737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0EQqQrpuO0nAoG1qjQarD71vyO13kG1r2yTsCjiRT5s=;
        b=CgD2u6WkpxEMdkrcC8uE1Hjx9md2w5gAXUzFQybgr7yRgaCvz9D4VAOSSruvn3Z/4z
         +bdS0maRWqNx03yB/RGhRO4g3Va31WmimisJQTw0FbGZ5UK2EEhH+damVeiXPSMWjuMC
         rOeRSsJXEWQp1lDE6PvdRT9g7iFZyDlVGB1CgYuU5HYNUzSVCL88UBRN/KvC2d5KnJf7
         SoEBjfnKoY/BLsSoyz31e1YqZfa0bzJEPh0eSQmICqZk97Bko8zo7ezFKwomlx4plc8k
         NYcjS2gK/MoivIX9VymmmJN5/ahMxhfj0ZtIcuFpC+G7TFfMWr5IKyi5T3LS2f/KjsD4
         82gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746489937; x=1747094737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EQqQrpuO0nAoG1qjQarD71vyO13kG1r2yTsCjiRT5s=;
        b=vi2cvVMHp1AuOsNOmLWrIMj60M26Xg1Pqf9MVTcmDBLpVgsL/FzN240obaDSfwms51
         1Dt+M5/n83OV5sEYSJX8BA/nfW9YP3zZ4+0jIls3L/gkjpjTkTFcSqrtHcKknWmejnKv
         /UHAmEyt9D1gNImYGdXlxmyeer0heGWcR9BGT2E3gye6Uhx75qHllohO63OMTlEuDl6K
         ZZRU9Lpiy2XPcTBZUrXzBNgUu6AWfZG3LN0Zj7vCtOEvEi7QbF7qEaJgJAPBD1Ig6w86
         xYN31RFOTPOusbFXdLyOyTIbdZj2nsMz8+KU8SCcJwS4ANvt9rn665RbmFZ3fBgL+u0I
         hjdg==
X-Gm-Message-State: AOJu0YzcQL+TGB7SX9EwvGlYZZJHO3kwkmyop2XDscG2WGxtM5EMSg5l
	EGu+a5BsKu3KphBeOpkPrOtj/7JwOCWVTUl3PsT+mO4vp0WiNbDcf8jIyMvubmvwaCKvIyRHUgo
	9
X-Gm-Gg: ASbGnctiV8G1yyyDRBRqNuh5srtCSq1WLEJ1cCPPdakGyzI1DFA6ZyrMRcakiEjknrs
	5DshCA1ziRKMTf4hYer17ja95QzVP+j/eSQXf76KAxwrED8mqvDRBCM5pl2tPp9XFv8XoM7tAp4
	ELnXuNOTGUYwyrgEjkGHfJde2keZjBtIq+NwDi2jbJRWUHTSAuI2cRDwYgdsyeng1X7eQNVXd4A
	KrMkhrLPcmulNIrNSNhsfMebQjObx7LPY/pRvciXb1whdtUp92UEoFeyCCGfLARiNtANzzylDD9
	dBTUGodzfGYSlW08v1cn/0qW7QgEC+KWbXFheSdGwcwpK+UARkQfB8EMLULh9He9EVBI
X-Google-Smtp-Source: AGHT+IGOcpcop9UytZLUW8ZMKA+OxWBovlRC7UbykWbvfWvLXKITkFrPLI2r1Y6SAQmnlMLUmjoWvA==
X-Received: by 2002:a5d:6ac3:0:b0:3a0:ac3f:cdb3 with SMTP id ffacd0b85a97d-3a0ac3fce01mr399553f8f.22.1746489937024;
        Mon, 05 May 2025 17:05:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb6esm61454175ad.158.2025.05.05.17.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 17:05:36 -0700 (PDT)
Message-ID: <daa36106-0667-4c45-a1a2-74c2f04725ed@suse.com>
Date: Tue, 6 May 2025 09:35:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] btrfs: fix beyond EOF truncation for subpage
 generic/363 failures
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1745619801.git.wqu@suse.com>
 <20250505153347.GY9140@twin.jikos.cz>
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
In-Reply-To: <20250505153347.GY9140@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/6 01:03, David Sterba 写道:
> On Sat, Apr 26, 2025 at 08:06:48AM +0930, Qu Wenruo wrote:
>> [CHANGELOG]
>> v5:
>> - Shrink the parameter list for btrfs_truncate_block()
>>    Remove the @front and @len, instead passing a new pair of @start/@end,
>>    so that we can determine if @from is in the head or tail block,
>>    thus no need for @front.
>>
>>    This will give callers more freedom (a little too much),
>>    e.g. for the following zero range/hole punch case:
>>
>>      Page size is 64K, fs block size is 4K.
>>      Truncation range is [6K, 58K).
>>
>>      0        8K                32K                  56K      64K
>>      |      |/|//////////////////////////////////////|/|      |
>>             6K                                         58K
>>
>>      To truncate the first block to zero out range [6K, 8K),
>>      caller can pass @from = 6K, @start = 6K, @end = 58K - 1.
>>      In fact, any @from inside range [6K, 8K) will work.
>>
>>      To truncate the last block to zero out range [56K, 58K),
>>      caller can pass @from=58K - 1, @start = 6K, @end = 58K -1.
>>      Any @from inside range [56K, 58K) will also work.
>>
>>      Furthermore, if aligned @from is passed in, e.g. 8K,
>>      btrfs_truncate_block() will detect that there is nothing to do,
>>      and exit properly.
>>
>> - Only do the extra zeroing if we're truncating beyond EOF
>>    Especially for the recent large folios support, we can do a lot of
>>    unnecessary zeroing for a very large folio.
>>
>> - Remove the lock-wait-retry loop if we're doing aligned truncation
>>    beyond EOF
>>    Since it's already EOF, there is no need to wait for the OE anyway.
> 
> The patches have been in linux-next but I don't think they got coverage
> on the 64k/4k setups. If you don't have further updates please add the
> series to for-next. Thanks.

I'd prefer Boris to give it a final glance.

This v5 changes the parameter list, thus it is different from previous 
versions.

Although tests wise it's pretty boring on x86_64 and aarch64.

Thanks,
Qu

