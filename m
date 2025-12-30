Return-Path: <linux-btrfs+bounces-20041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FACE9374
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 10:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29C6302CBBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F02BDC28;
	Tue, 30 Dec 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V8A12BD+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979C27F73A
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086940; cv=none; b=F1SWVsAokwR+MAH29rcdRfgIYPp9AUPBrfNeq+GYRcmdqAkcb3OPrFIYa383j67KpqB8xXOTjULlU2+f40GqtgVctV0xbl8b0tCnkqafjrFYzuzJTJOzYFXUJnqhZS1HV0D9mqLHu9jQD9AnGoAqLpMzNy2L84XCJSnuVBPQQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086940; c=relaxed/simple;
	bh=qwEC++WqbmApjnu9M18nBdbcimANwczQYugUDf9TvGI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tp4SAVHteA6f5jO2mWDP24aB0Ypr7NNQTCvXN9Ob/ZJ4dTe+CbrO3NaFBBPRNaax87hNEVFcA6TJPbl4QFv7JKZdL2katG3HYKvnVNqED9pCQboKXrtEY1plYQYiH842FAx+uMaieyNI6+uMH36p3Fk4FkR9piM5szB75F8OmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V8A12BD+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso31884625e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 01:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767086936; x=1767691736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4cdJvd80CA2U8O7Elv/zvHD/XQgNTh189/MTpXl/jBU=;
        b=V8A12BD+1w/HZQCZns2y7HjdOvCuYPW4RcDNP6CokFOMdMr1Z22IlM5yM+vBQ2Glue
         plKo4BGdOcIVXfXcF9fN+mU3X6e8a7jcQKTbUkpNdbpLY09imR24V0IVuKS3/pW9N2Q3
         jtNLL81C22s1ENTtGvz60CpsOrmpf6+MQZ587Ar1OAT8swFIf2zvh1Z6AqXIH1+favDH
         UgRgamNwSxg/KrI9cKEf2v7m521SX7bNT8nW+5qbIBSq7ARFa65dfnSFG7jEKm+68f3X
         VVSWsE9020jUxrUC8FpUHG0fU5UdL1qQwyIGxdwoHj1QJ8QJR89ZZREzuCCnX/IIzboB
         QS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767086936; x=1767691736;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cdJvd80CA2U8O7Elv/zvHD/XQgNTh189/MTpXl/jBU=;
        b=bfOXvoGG/PeQZ2kucbEoWNLq8J5Ojc3vxXghWQLutWzIObqjfvltrp0FWAxfvYrTt0
         JGyrhweYcYmWZkQsfX2AXl5GprTAwuWy2fIJMv+fuzCl+tarq4SQiIfe84zHhKFXMJrt
         sC/OceK+yzqxVUbxqA53fzLH4xD4y1mmJVK04YldnkGkX0auvpAt0tjQGjWzU8Vwmulq
         gubg4NU92FR9syVnD+eTdd91q44WRhQwvV/GF8AxfMeZ8h+4mRJUFPwmgEsZJyLBudUD
         KBCZSDesr2qlqVIiEY6z4HekEu61c27gDvbIUXNzQI0+0FGXIY7iB9LsuyEhiJf+YNa4
         ZAyw==
X-Forwarded-Encrypted: i=1; AJvYcCX8wM0icsVMYdgqcoHDUWHyR6cyLVivafeY1hx+LehN3P49xKRlu01MKd9hJ6GwsEWlo8BxYffp0nkAiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkc/LDEHRKeov0l5JPbWiTh1aLZRzX+5VijvGa+wrzNVCRPpP
	uphFKn5G52+U3e8EvztdxKWUt3QvnbPqaHuV5M4pH+EsmF2icgB5bbBAgb6mv0Syurs=
X-Gm-Gg: AY/fxX5haJRl89ir+mCCx9qvPHMl1xgMJs/YdYZzB9AAUul6eOgRt7C60KCkTKGX/3P
	jO3WFZfMZnQBaXno10qOBd5g4hqFWQXQQV4wNh1DzVJu6GGK1p/boUumgAYvYzsSQuU9nSCWhe0
	vDgaA88dBrZHhUCPoFajCYGqoe6CONavge5RkiEj+3NM3jPCxXd0qB2Cg75PJHLSe3zj/76VhbY
	n/ULiG1JHfZC9leOIwTcOR7XXdiQ49wSllpqYe4b74qYY5/8ItziSCZd+0ran2Tl61Pni7JaKLB
	argzy1eMlPHzhS1iHFZpoks9CRJiZv7pMRknPtDNcWxoXavvcm8DKl7JU+1BF0Rw84XlmNq3m8u
	uHFKc5udho7ye4t/PbedzMTlddBGkQyIfccragp+XPkNmlSvKulh+cw203loOBCNhcCTh8CXrNo
	sF+ogcgJJ0VhbD64voCRFeceO7W/BTsYdgdLLZoCA=
X-Google-Smtp-Source: AGHT+IFqk/T48cnag1G9B75GgfDYvKfty2XjdqVXm7/5MkcznRAMR+VBAz5h6d6frga2FaR9257mng==
X-Received: by 2002:a05:600c:1c29:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-47d1959d4bamr436496335e9.34.1767086936398;
        Tue, 30 Dec 2025 01:28:56 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ebab97affsm10524918a91.4.2025.12.30.01.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:28:55 -0800 (PST)
Message-ID: <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
Date: Tue, 30 Dec 2025 19:58:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.19-rc3] xxhash invalid access during BTRFS mount
From: Qu Wenruo <wqu@suse.com>
To: Daniel J Blueman <daniel@quora.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <clm@fb.com>, Linux BTRFS <linux-btrfs@vger.kernel.org>
Cc: linux-crypto@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
 <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com>
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
In-Reply-To: <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/30 19:26, Qu Wenruo 写道:
> 
> 
> 在 2025/12/30 18:02, Daniel J Blueman 写道:
>> Hi Dave, Chris et al,
>>
>> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
>> checksumming and KASAN, I see invalid access:
> 
> Mind to share the page size? As aarch64 has 3 different supported pages 
> size (4K, 16K, 64K).
> 
> I'll give it a try on that branch. Although on my rc1 based development 
> branch it looks OK so far.

Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 tag, 
no reproduce on newly created fs with xxhash.

My environment is aarch64 VM on Orion O6 board.

The xxhash implementation is the same xxhash64-generic:

[   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6d 
devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount (629)
[   17.038033] BTRFS info (device dm-2): first mount of filesystem 
260364b9-d059-410c-92de-56243c346d6d
[   17.038645] BTRFS info (device dm-2): using xxhash64 
(xxhash64-generic) checksum algorithm
[   17.041303] BTRFS info (device dm-2): checking UUID tree
[   17.041390] BTRFS info (device dm-2): turning on async discard
[   17.041393] BTRFS info (device dm-2): enabling free space tree
[   19.032109] BTRFS info (device dm-2): last unmount of filesystem 
260364b9-d059-410c-92de-56243c346d6d

So there maybe something else involved, either related to the fs or the 
hardware.

Thanks,
Qu

> 
> 
> And is this KASAN triggered for this particular fs or all any btrfs (no 
> matter csum)?
> 
> Thanks,
> Qu
> 
>>
>> BTRFS info (device nvme0n1p5): first mount of filesystem
>> f99f2753-0283-4f93-8f5d-7a9f59f148cc
>> BTRFS info (device nvme0n1p5): using xxhash64 (xxhash64-generic)
>> checksum algorithm
>> ==================================================================
>> BUG: KASAN: invalid-access in xxh64_update (lib/xxhash.c:143 lib/ 
>> xxhash.c:283)
>> Read of size 8 at addr 21ff000802247000 by task kworker/u48:3/48
>> Pointer tag: [21], memory tag: [c0]
>>
>> CPU: 1 UID: 0 PID: 48 Comm: kworker/u48:3 Tainted: G      E
>> 6.19.0-rc3 #19 PREEMPTLAZY
>> Tainted: [E]=UNSIGNED_MODULE
>> Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
>> Workqueue: btrfs-endio-meta simple_end_io_work
>> Call trace:
>> show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
>> dump_stack_lvl (lib/dump_stack.c:122)
>> print_address_description.isra.0 (mm/kasan/report.c:379)
>> print_report (mm/kasan/report.c:450 (discriminator 1)
>> mm/kasan/report.c:483 (discriminator 1))
>> kasan_report (mm/kasan/report.c:597)
>> kasan_check_range (mm/kasan/sw_tags.c:86 (discriminator 1))
>> __hwasan_loadN_noabort (mm/kasan/sw_tags.c:158)
>> xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
>> xxhash64_update (crypto/xxhash_generic.c:49)
>> crypto_shash_finup (crypto/shash.c:123 (discriminator 1))
>> csum_tree_block (fs/btrfs/disk-io.c:110 (discriminator 3))
>> btrfs_validate_extent_buffer (fs/btrfs/disk-io.c:404)
>> end_bbio_meta_read (fs/btrfs/extent_io.c:3822 (discriminator 1))
>> btrfs_bio_end_io (fs/btrfs/bio.c:146)
>> simple_end_io_work (fs/btrfs/bio.c:382)
>> process_one_work (./arch/arm64/include/asm/jump_label.h:36
>> ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3262)
>> worker_thread (kernel/workqueue.c:3334 (discriminator 2)
>> kernel/workqueue.c:3421 (discriminator 2))
>> kthread (kernel/kthread.c:463)
>> ret_from_fork (arch/arm64/kernel/entry.S:861)
>>
>> The buggy address belongs to the physical page:
>> page: refcount:2 mapcount:0 mapping:00000000973bd0ac index:0x9731 
>> pfn:0x882247
>> memcg:aaff000800ae1b00
>> aops:btree_aops ino:1
>> flags: 0x47e400000004020(lru|private|node=0|zone=2|kasantag=0x3f)
>> raw: 047e400000004020 fffffdffe0089188 fffffdffe0089208 ccff000814148300
>> raw: 0000000000009731 10ff0008493322d0 00000002ffffffff aaff000800ae1b00
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>> ffff000802246e00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
>> ffff000802246f00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
>>> ffff000802247000: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
>> ^
>> ffff000802247100: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
>> ffff000802247200: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
>>
>> Let me know for any further testing or debug.
>>
>> Thanks,
>>    Dan
>> -- 
>> Daniel J Blueman
>>
> 
> 


