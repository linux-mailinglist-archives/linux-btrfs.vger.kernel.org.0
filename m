Return-Path: <linux-btrfs+bounces-18344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B396C0B43D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 22:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22667189BC63
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011828727D;
	Sun, 26 Oct 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dsF2lGgY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8E27F75C
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761513725; cv=none; b=dP/YKPImZBSC7J8W3h1Lz73qtj8bx2BXPn+l/HJP/4gVh1zvRm0z6n2M2biuxZ9YP4cPNi7L3Tj3N0hfyDEqXJAKZcmEdbQrGwn3P49rYoWJJx2sJSKuAm3hNO02AVkCBemLEodcDuXIxsd3W//d4y1bY17ncnqA4yxDdBp2xPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761513725; c=relaxed/simple;
	bh=a1/9XHL6RZXBYYYMBWZGCNUUL5sDAQSvXjlyhlgJicc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O18qLWefUkwgDM8K8hMQaTuB6quZYzTo+w5jA6kyyxb9hn9EiREzUO/i0dAXVCdgt15CVG1UCX2M0450kgSu2nr4bFUhB9ZqxiflR4tHu9Pgv9T56V+onF8a2H1mDT5edEeldTn6DRZ3YVSOX39HBBd2ktW9TbJez/FBUDV+bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dsF2lGgY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710022571cso41182595e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761513719; x=1762118519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJnhrBKb7Q1XGTyrN1ooaG1VwEdQ47C7rvpiUhJxdHY=;
        b=dsF2lGgYlz1J6WuPRv1CcJGSjwh6GE7OrC6jUJg84EAPss12arnwNyt+1ZQ04WRFeD
         sLhGWyE8LCLajzRBE/y6rbZW5BglX2AZKukcgR4o4oLKdL764dpXNc9y3jV66ofiPXsl
         YuFeXlAr/80ty5saCiIFNAetEay7QGdj+BehxQ5XGZ+/PY5HmgKs3bDtLR3M6B5L7rAw
         EpQdSvC0S66neeTENKkm46Btx1QgXb2x4fFBvzX7jG83GhvxMrLFtehkxcGxHgou6sZp
         ulDUBI/cbr2A2a280RiIGz3iFpu0DQnfo+79XOD6KeT1pDbVppnjEoalBW1wRNk9tAvB
         9XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761513719; x=1762118519;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJnhrBKb7Q1XGTyrN1ooaG1VwEdQ47C7rvpiUhJxdHY=;
        b=XsCnLPzchZ6C2ZzTuPwPSUmorWj6KfAW0xa8SztnHl09hbNu3iAR7f19Jxrr0a5vqZ
         jEtU62256ZnweYIsyoNr/IsS+jCYlAm1LLFA0/zi4ICJusZ3Af5oDaodxe2SIU8tFbuf
         Wo9gZQB2aA9zKRNOB5aVR8cxiaUvj7MfU7Cg3AVgsEm1QdgP6a7HWmwQ3QRSqpIcUVpA
         XqBOb1jum4zXASJkfhHsn5LmxrpqucgqRAROqBx4WJXZNmS+RtnewBdBh0AvVdMb8Oif
         d1Kp1lcfyMUtAlfWbcvQ5WPMxUaKBE3VybfeQn8QgcnTfmvgi3MKh1Hpb/I52PaEjcBa
         HO7g==
X-Forwarded-Encrypted: i=1; AJvYcCUYj6LNrB9yuMKSvTaJ7evmzV5E+11JPw933WemBNwRa15gUC8a7wkBr9YcjABYqKBjRcszUD7EhjF8vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbetZKchEo4Xl8j6kttwQ9xjXp7Bv/pIqnK6xE1HzxRYDwRxz
	Qqhl80uf7Bn9F59mBFRxJutOJPkLzZoWVCNd0c+SlicMLw9n7RPq3OJGjVdG0GcQVsWrNs2jC3X
	u3z9C
X-Gm-Gg: ASbGnctt1f1/X+PLyG5okEGOkQqePWgkwerWektRWij+Xhgf8Y2keM3lr52RqSPmEAd
	iV6pDaFa+Ebx1tv3+jhsvoKtR3qySXjj1+ft3mD1VRNZskT7GoQLD/9Y9tiRGqvQvD9v/MsgkXO
	gtTJcS1hLGkR71mpF8z34WKvffIRWMMGq2G8XONP7OH+xHAqEYRKDcWxv1MFPyEwEMyVYyzKzei
	Usup7IV4ae12JZ3afXX6pGHf/SGg5R2Av3cO5nxdSUHOV/flj0s7QnKDg4FGfjnEq49rdXpCgzc
	pzhBs7LNjarRYo5r0rziDcezwR7VGv4XpTWKQ3mwZM6/QSyec+MCy12GP1IBBe67x1AdxzVGa+B
	7nlBbzLLTFhZYSZ6kPwbVq4gRCi1svTVhbyFzvTDVdOUGFnta++mMu4CmAgLHAMKOjWoGR6EAKA
	RHk9P5SUBNiKI3V4i+KBRwU/izP9Bp
X-Google-Smtp-Source: AGHT+IFlZNv+IiKoTmF6MWsHkGSXmTT4hQnIBdt05h0zjPvprEiJrcldIDWJxir3BYc9au3fR92Y/Q==
X-Received: by 2002:a05:600c:4e48:b0:475:db8f:ae0e with SMTP id 5b1f17b1804b1-475db8fb17dmr49960895e9.2.1761513719428;
        Sun, 26 Oct 2025 14:21:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed73a7b7sm5989840a91.5.2025.10.26.14.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 14:21:58 -0700 (PDT)
Message-ID: <da6943fe-5f4a-40e1-81cc-35bdacfb3683@suse.com>
Date: Mon, 27 Oct 2025 07:51:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Strange btrfs error
From: Qu Wenruo <wqu@suse.com>
To: Brent Belisle <brent.belisle@verizon.net>, linux-btrfs@vger.kernel.org
References: <c01bd806-9490-454b-b29d-61e5911b2483.ref@verizon.net>
 <c01bd806-9490-454b-b29d-61e5911b2483@verizon.net>
 <0725451c-7354-4ac2-9bd5-e0487feb77c7@suse.com>
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
In-Reply-To: <0725451c-7354-4ac2-9bd5-e0487feb77c7@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/27 07:46, Qu Wenruo 写道:
> 
> 
> 在 2025/10/27 00:59, Brent Belisle 写道:
>> when I run a btrfs check on my file system using btrfs-progs 6.17-1 I 
>> receive the following error "we have a spare info key for a block 
>> group that doesn't exist" , however when I do the same btrfs check 
>> using btrfs-progs 6.16-2 the operation completes and says "no 
>> errors".  Is this just a bug or has btrfs-progs 6.17-1 really found an 
>> error in my filesystem?
> 
> It's a known minor (aka doesn't really affect end users) bug in older 
> mkfs, and the ability to detect is added in commit e2cf6a03796b ("btrfs- 
> progs: use btrfs_lookup_block_group() in check_free_space_tree()"), 
> introduced in v6.16.1.
> 
> You don't need to repair (no repair support in btrfs-check yet) nor 
> bother too much.
> There will be a kernel fix that will automatically repair this on mount 
> soon.
> 
> If you really want that minor problem to be gone as soon as possible, 
> you can rebuild your free space tree by mounting with "-o 
> free_space_tree,clear_cache",

My bad, the free_space_tree mount option is no longer there (but still 
in the man page).

The correct one should be "-o space_cache=v2,clear_cache".

Will update the docs soon.

Thanks,
Qu

> which will rebuild the free space tree at 
> the first RW mount, which may take some time depending on the fs size.
> 
> Thanks,
> Qu
>>
>> Thanks for looking into this
>>
>>
> 
> 


