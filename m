Return-Path: <linux-btrfs+bounces-18132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006DBF9088
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 00:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6122D404745
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69572299950;
	Tue, 21 Oct 2025 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adEW525+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929C284686
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085185; cv=none; b=FKS3JLP09jlqjLoXaLBNbBSAgGWsU+RJcPDA9pV49JUi3aaAsgLnoh44nckDUoJZ9lt4+Fp44jDhHedSCh0yNsy8AOL9oAfdPvoRgOONEs5cXA9lck7jfOsFqX3cyoSTzY2rT19ACRQXIAlvx9juR4y6WcttkWEwrxlUtnddo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085185; c=relaxed/simple;
	bh=EywJ5qqkPxJBUnGZD1/jJhpC/CUF/knssh6TGbX/GxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bem9bY78yofKyAPglthuvkSQ6SdjJH+hb/TSYngBKbroqJyIfRy30vEC1l/jgMR6j9iQr7Y6LVXR1EgLMapNjTwndXLs+1NjoYLwb5ktkdpoZRq+E6ElpSZCtbPrxwC85CuELJw7ZfOOgTDgWoXzCRYtpo9DzIhFo1+kmsI2TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adEW525+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2697899a202so2686825ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761085183; x=1761689983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HiaYjApV6yJV4K3CJ9hX1bYA1zLwFiSLOOxYX+cDHk4=;
        b=adEW525+TDKmARpllIRXVZ6+2nW42JnhbPo/5ZKMwGXVlnIH0ug+EcHiVcf+DKecwa
         r42M9ctI3AnUatk5Tjhkyd+jsbAuruOcu5azc0k7jb+ojMP5HKkQImJ4/uk1X0VE6HsD
         33cpavcQ4fPt+ez9r24pKnw9tARYuiphftJmi9BhsqywGAfMxm4UZ5hYpW5fc2qGfydu
         WIleBSnnNiVSva5QDTASVnHwjjuBhnw0tgNQa2jZZwshimnD4yWyhVkVWM6wzcsvs828
         aKtf1kHSoAr3gUuxfEHL7smYixe2LZM8FynsjIeYKJPjyKogiimUh1WeVRx70sm9HerY
         XICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085183; x=1761689983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiaYjApV6yJV4K3CJ9hX1bYA1zLwFiSLOOxYX+cDHk4=;
        b=K1I8QePnS9MeQCo4y3YQfB91PfS67fs09OgfJyIGY+Pg4vRG5L2U67LhtDLAwITxY+
         orrpYw34xl9qzY+YcArbf+51K5Jkk5n/51Sr24JmWCp68Ni7Uziod/gMKJRKiV8BV0QA
         mhn9fHCgPa2OtyspCsIPyC1IL5DefazfoM8MWScX0+u60EL8WUCppW9Sej0bzsIxe9hd
         2I+Z/TshTx/IzVycg6eoCGtDugc+qm5Z3j4njhruxJZ+6pn9HuomIA2SrTe+B8Rc1BPb
         kuojfLO3RIAqm0qJ6RhZjo8y4zDfFsQ+SxzO4womymCGbPOyzZUnxOZxckybqL/2gNNf
         Wcug==
X-Forwarded-Encrypted: i=1; AJvYcCXXJcAzXUHkLMPHFppCLHJOyqTUeMjpnvwaBmj9CTJ/hKzAVA7lZPg56AxyXIn5wx1YUfHh3idKsnKI8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjdpx1djoVuqhmalp53wxedC/fYby6O5htI97JiGqf5HKpfLDV
	innlC/vNX+HQ7qhtZU/vSeeDZSLnwFkA+tuqTOuJCfW3l50Ea+XbwbX5
X-Gm-Gg: ASbGncuD1fzrY64waCJjjd+UO3HKijvcaGWrUVntAjO0xltsmVJ+O5KaXz1zLVHtYC2
	l00Nmv7qjgx4+2ueVcTCDGWZ6pS2abMik8ck7QOTMj7GmOxyciGJH04Wtp+CFwYzTQ7OjYc048b
	MZU0RI4PD+pP6iDeJcLAWfRoBGyrHvUXOXh0A/GR27DUTJa3NC8k7J9Aii/foxrm2eSImMvfvd9
	SQmP2TWNc3ig0uE084QhQVSqNFCybjipv6/fnwl/REE+/42C2BL9VKOqS13h/qZ2YTeIs7Jyj5k
	eyeR/we6hfRMs1sef+y6F9Ov7YYq5cNCMD4ND8x5cWN6enDKol3tReWFaaBLEcwZFIe05JnfRL1
	bY5w5Ab5bV8XeVeuw9HUx7MM6FPEGiXwqkKIxf6SD5hVCsLAY83+7zqCfuDPfmMLrRl6zDYhxUW
	OOofjCyTDbT2+XfpSq1TGeOmN3HDCDi/75HebvVuGBuXpnDaHImEUsjXstILnFNA==
X-Google-Smtp-Source: AGHT+IGtducAKJgYfbsuTFXx/cKFzxloLsqka1bC9rgeo8zlTH4KLvWXnvPO1cFYKzKGBpbP8YuZiA==
X-Received: by 2002:a17:902:dac5:b0:282:2c52:508e with SMTP id d9443c01a7336-292ffbd00d3mr14873525ad.8.1761085183308;
        Tue, 21 Oct 2025 15:19:43 -0700 (PDT)
Received: from [192.168.188.28] (210-5-38-62.ip4.superloop.au. [210.5.38.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm120061085ad.18.2025.10.21.15.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:19:42 -0700 (PDT)
Message-ID: <2bef36fe-95a3-40d5-ba8e-c5e2ec27b16f@gmail.com>
Date: Wed, 22 Oct 2025 09:19:38 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: kreijack@inwind.it, Mark Harmstone <mark@harmstone.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <3a3df034-4461-4c35-b170-a5084586d2b3@gmail.com>
 <d7e67eee-ac1a-4677-8bed-25c358c66c81@harmstone.com>
 <a8a16938b9112d7aa68b6df3de30d35c116fb17a.camel@scientia.org>
 <76ac6739-806e-4e6b-acb3-ebfba74cb8f3@harmstone.com>
 <2a0a802c-0879-4ae4-9eb1-31b1a02efff4@libero.it>
Content-Language: en-US, en-AU
From: DanglingPointer <danglingpointerexception@gmail.com>
In-Reply-To: <2a0a802c-0879-4ae4-9eb1-31b1a02efff4@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Just going back to the original question I posted...

Will the BTRFS project decide to fix once and for all RAID56 to fix the 
write-hole even if the result is a slower-latent result?

At least that would be a fully functional production ready offering as 
version 1.0?

Future optimisations and improvements on that version 1.0 will obviously 
happen for the life of BTRFS and linux which will improve the 
performance from the impact of adding whatever is needed to fix the 
write-hole.  Just like everything else!  At least everyone can say it is 
done, although slower now!  But feature complete!   Making it faster 
will then incrementally happen as it evolves like everything else.



On 22/10/25 06:32, Goffredo Baroncelli wrote:
> On 21/10/2025 18.45, Mark Harmstone wrote:
>> On 21/10/2025 4.53 pm, Christoph Anton Mitterer wrote:
>>> On Tue, 2025-10-21 at 16:46 +0100, Mark Harmstone wrote:
>>>> The brutal truth is probably that RAID5/6 is an idea whose time has
>>>> passed.
>>>> Storage is cheap enough that it doesn't warrant the added latency,
>>>> CPU time,
>>>> and complexity.
>>>
>>> That doesn't seem to be generally the case. We have e.g. large storage
>>> servers with 24x 22 TB HDDs.
>>>
>>> RAID6 is plenty enough redundancy for these, loosing 2 HDDs.
>>> RAID1 would loose half.
>>>
>>>
>>> Cheers,
>>> Chris.
>> So for every sector you want to write, you actually need to write three
>> and read 21. That seems a very quick way to wear out all those disks.
>> And then one starts operating more slowly, which slows down every 
>> write...
>
> Yes, it is true that the classic raid5/6 doesn't scale well when the 
> number
> of disks grows.
>
> However I still think that there is room to a different approach. Like 
> putting
> the redundancy inside the extent to avoid an RMW cycles. This and the
> fact that in BTRFS the extents are immutable, would avoid the slowness
> that you mention.
>
>> I'd still use RAID1 in this case.
>>
> This is faster, but also doesn't scale well (== expensive) when the 
> storage
>  size grows.
>
> BR
> G.Baroncelli
>

