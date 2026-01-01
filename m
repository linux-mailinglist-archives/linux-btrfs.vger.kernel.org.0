Return-Path: <linux-btrfs+bounces-20058-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FDCECBAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 02:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A1B30169B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 01:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A526E706;
	Thu,  1 Jan 2026 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PX9g6s7P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6F1DF261
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767230136; cv=none; b=Yr7oz0W5BJea4w09XbRVl640rNNyrBrKPQAIhiVpN7gu9dXvsE706nXmjbdNlwwRYguJ1ycb6UbCIa9MGtIM7XL9lOKwW/Vmr6Zj0xj6/PskOAIB1unjiTkSrwsQY5On8Jq9a8AflWdvy1s4taADq6msqh3YCXs2XtK15onRIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767230136; c=relaxed/simple;
	bh=WZP8Mk3QPYqP1XafCBtIPFCwCjR7tvBWQyrv61QEj50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zf5x4Q/IompNpxZPD9tg4zdw4QRNqwGGKHc3PgNmv4FXDDcZTLI+ZXZMav7V4muZYJEnD7MVIMhvaR+m+ALmJEGWZ/BJpoRaHwbLSEq0eYfEaxZN2tQ4l4nPF7dSnXZO9DwDGt6NYNjkJ1lJdUP2FLNeSTRuEf7Mxgbj1sGNxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PX9g6s7P; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso66542615e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 17:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767230132; x=1767834932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xkwY3h33tWtBnJzkbT/5FUlQ2yKG1xK3b/1V8KgcBKA=;
        b=PX9g6s7Ph3PPFIX+Viq5BENmiecv04V+CxrGVMAZt0EyLfzLVKfu3GmGbDuCnHkWDq
         a8yUdbHDdqSfcSi8PDTfp+dne5NHv2Vq13hQrKH9+GfuBRqU/F9/q1Mjc9VOY0VrR/+P
         EnOZyyryp4DesfoHCuFuma+jNZtU9YuG3V5199dVc2daSzNrSx0ZUIAwM0h0FzfC2EeX
         MSrNMT3N6tHqBOPOknxV9ZiJ/7OIqqkTWqmrX98/hRqSdZ+p8FFMK+pWgQqDIZ05t3D4
         vKX+AavAMM5Zjk5HjqdsTqSjwxzN6lOxrAVOEWW0TWcbeHo1ggydy822YnDESQW78lM1
         c7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767230132; x=1767834932;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkwY3h33tWtBnJzkbT/5FUlQ2yKG1xK3b/1V8KgcBKA=;
        b=oIJm3jxjZDFSgJw37Srl0fUPnr6LXNVKbh5E9dnNPsFlpCy9Tmkce45Nwasenfshed
         G4bdBChfL52+9SPE7mxasChghdHRXB1OpBCPJTzC9N8+8KGTQrpvQqLiLIF0dxuwA6KN
         n4JieEFIV6jhYRWEyQbts2VjRAbE6pVvVHGfLBwL2eCriMRZ5n+g6eZjURdT4CJ7lYR7
         7cIK5Jmg/QdPieq9OMi8Br6gi3erjjh267rCktdGpDl3mMN1necjssPwpBDFLlmS8VS/
         Jr9F1jyDgBDLAgIbg+25cDFtGRR2rzOkd+2ePxYmkb7/mAjFZ5eofnzkCct+ngYOa1kS
         IvAA==
X-Forwarded-Encrypted: i=1; AJvYcCX8GJ4mP+IO1ItqXZlv+h9j0sUAuMnPmvtJHaXiCjX88Nt9FskXh2iyQ5GiDM333KN6wSHjNMp/+2YDeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww++/QTw8WGF1ilTwyVl3XRHvBJMhEsDg6F9JOL+V1lfRxePKS
	wwOaj0Mid5TzwzKCI507eYCloS8n1JAE/z81Cz03C65g0Y1qktwqoDlPPLaOpZanicA=
X-Gm-Gg: AY/fxX6Klck9ss6xzVCApZ9YyX+OfuqK5G5lutrOnJlnATIUlahh+isP22+7WiGqZoe
	N6z2oTcijd8YfWAYMD+FxMiN2qMvsSVTD5auw6bWVKvfpL2YPvhXGEL5m9gBrqIrOJWsQl7CXt4
	OczmPC7GfR62N+ykq2Fdfqio6Wjl1FeDrcJw+t+zB3ksd7Y9Fzr4qqcVHeFYebG1Je6SNBjkddo
	AWwoJY4Y58ERdgAN8l8PlzDbn2GXJntJjyFfZ56FDVlUwxuhKrQ/eJTssS0V7Ktnp3qFogLQt9c
	4u37yLmlzL53owOxb46gR+frh6llxj4mMCYHQoY9HN66hBuMMCrz66aNG042xfCfaIpNjzt92q/
	gbfsovhwJrnxJOwsQdALovidanyX7cmu8N6Ss87htLXvrZw1FS3jcusUjh1zipvW29BB8mlKkIH
	TwaLZv0hHB9jxwCqN5pndvvNx/ZExhJvE1jYLUBLuj9N1kCk+MGQ==
X-Google-Smtp-Source: AGHT+IHHvlTnlAqFuFdxrkOeeQhFWwkUxz8xIzyA49UCDGBArtA0A+Cf4JAD2SsHlYIi8ropy5mJIw==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-47d1953b79dmr511779605e9.4.1767230132347;
        Wed, 31 Dec 2025 17:15:32 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8a8e3sm332310245ad.41.2025.12.31.17.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 17:15:31 -0800 (PST)
Message-ID: <03cb035e-e34b-4b95-b1df-c8dc6db5a6b0@suse.com>
Date: Thu, 1 Jan 2026 11:45:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Soft tag and inline kasan triggering NULL pointer dereference,
 but not for hard tag and outline mode (was Re: [6.19-rc3] xxhash invalid
 access during BTRFS mount)
From: Qu Wenruo <wqu@suse.com>
To: Daniel J Blueman <daniel@quora.org>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
 Linux BTRFS <linux-btrfs@vger.kernel.org>, linux-crypto@vger.kernel.org,
 Linux Kernel <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
 ryabinin.a.a@gmail.com
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
 <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com>
 <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
 <CAMVG2suYnp-D9EX0dHB5daYOLT++v_kvyY8wV-r6g36T6DZhzg@mail.gmail.com>
 <17bf8f85-9a9c-4d7d-add7-cd92313f73f1@suse.com>
 <9d21022d-5051-4165-b8fa-f77ec7e820ab@suse.com>
 <CAMVG2subBHEZ4e8vFT7cQM5Ub=WfUmLqAQ4WO1B=Gk2bC3BtdQ@mail.gmail.com>
 <eb8d0d62-f8a3-4198-b230-94f72028ac4e@suse.com>
Content-Language: en-US
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
In-Reply-To: <eb8d0d62-f8a3-4198-b230-94f72028ac4e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/31 15:39, Qu Wenruo 写道:
> 
> 
> 在 2025/12/31 15:30, Daniel J Blueman 写道:
>> On Wed, 31 Dec 2025 at 12:55, Qu Wenruo <wqu@suse.com> wrote:
[...]
>>>
>>> x86_64 + generic + inline:      PASS
>>> x86_64 + generic + outline:     PASS
>> [..]
>>> arm64 + hard tag:               PASS
>>> arm64 + generic + inline:       PASS
>>> arm64 + generic + outline:      PASS
>>
>> Do you see "KernelAddressSanitizer initialized" with KASAN_GENERIC
>> and/or KASAN_HW_TAGS?
> 
> Yes. For my current running one using generic and inline, it shows at 
> boot time:
> 
> [    0.000000] cma: Reserved 64 MiB at 0x00000000fc000000
> [    0.000000] crashkernel reserved: 0x00000000dc000000 - 
> 0x00000000fc000000 (512 MB)
> [    0.000000] KernelAddressSanitizer initialized (generic) <<<
> [    0.000000] psci: probing for conduit method from ACPI.
> [    0.000000] psci: PSCIv1.3 detected in firmware.
> 
> 
>>
>> I didn't see it in either case, suggesting it isn't implemented or
>> supported on my system.
>>
>>> arm64 + soft tag + inline:      KASAN error at boot
>>> arm64 + soft tag + outline:     KASAN error at boot
>>
>> Please retry with CONFIG_BPF unset.
> 
> I will retry but I believe this (along with your reports about hardware 
> tags/generic not reporting the error) has already proven the problem is 
> inside KASAN itself.
> 
> Not to mention the checksum verification/calculation is very critical 
> part of btrfs, although in v6.19 there is a change in the crypto 
> interface, I still doubt about whether we have a out-of-boundary access 
> not exposed in such hot path until now.

BTW, I tried to bisect the cause, and indeed got the same KASAN warning 
during some runs just mounting a newly created btrfs, and the csum 
algorithm doesn't seem to matter.
Both xxhash and sha256 can trigger it randomly.

Unfortunately there is no reliable way to reproduce the kasan warning, I 
have to cancel the bisection.

For now I strongly doubt if this is a bug in software tag-based KASAN 
itself, and that's the only combination resulting the warning.

If KASAN people has some clue I'm very happy to test, meanwhile I'll 
keep using hardware tag-based kasan on arm64 and generic one on x86_64 
to test btrfs, to make sure no obvious bad memory access.

Thanks,
Qu

> 
> Thanks,
> Qu
> 
>>
>> Thanks,
>>    Dan
> 
> 


