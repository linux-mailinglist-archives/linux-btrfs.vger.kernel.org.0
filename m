Return-Path: <linux-btrfs+bounces-20047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFFCEB48A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 06:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EE3300C281
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717D25F96B;
	Wed, 31 Dec 2025 05:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f/YXHrRS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED35220F38
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767157762; cv=none; b=Ra5rDlwlwcTtbSDm9n74q6WJfXNQD0nilT+OHeZR9Z4oRsUA3hM8ZcrLzw5ZyEP6m9b4YadLxZwC6MWx20vvk7jHwzri/8rcGOdHEdLa4dY4xczFJzdFNaJ5ULltSEHqj7Tc9zFoOu1ysUjGYFLTcrmFSc6OzBvla0u3cb2gKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767157762; c=relaxed/simple;
	bh=7uspNdXbsimGhSop3aLS0pBSL1J4nWtfyBBVVglm/XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMNO19tR2+PmhH6XdaH9wJFcRXALzqtQVZdhVuXCWOVWaMzSccW5yHpq4dPkTLZLea4/Uhy6aS6Rmc12N/v4CFhKyMILQB+vbS9wKDp4bgL+n8tQqy0l3XGw7sDnPnf0lXd0rmb4foCSlzvj267nEglYabzw+EEKhaOldbF3MMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f/YXHrRS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a8195e515so64351665e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 21:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767157757; x=1767762557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DI0k7hgIOB6FXoBmvQUNmPn4Ay/YstMhbmqFpQgeUc0=;
        b=f/YXHrRST3FY+LrYWCQ14oTgfShP0w3VDwR7wFkBu/O3faVL4gRhP+BE1dzCuL6z7s
         REr2zLde1/gJ3kaR5h53beutpH0EK00XJx8/+90xxN3pTn597AKCrcK7J4y+2YzvlCCT
         lkSq7/OXqkkdhbjUxH764oTaDK50jReqhYUIWmksjE+3uYhVNgO8iMRsS8DpPsn8XZdg
         CghXoTrURirVmaXgbpLkK4xQRx8UfKtUkHmAWBxKFqRz5gKLdO0Ep2Y8f5o37Pl9dBkQ
         o1fo68F5s0uAGSMguVcY5jglJjEYuiZ6uD6eh52alxsGvwjpt4n/ZPz0va0K2N7Xy2kB
         Qe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767157757; x=1767762557;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI0k7hgIOB6FXoBmvQUNmPn4Ay/YstMhbmqFpQgeUc0=;
        b=bnSYPA1LzjK0jx5MdG4O069vpamTh5KAGGPZL1wbyKVC416OGMet+Dzs9nS3Yazv3n
         oYT4NhQuW/GG58FY88dRxwteq4y7S8bOMdVm16PCkoe1+JPRw8+vEGNKIVuQPbBjgrjt
         tZA3lOSwgH2XAOc2ZtcE9VcKf452h+XvIXEhMWqVJf4ZB3/VUEmHSWa2uGvIc60UK9Bf
         cAzTVVEQTPaXY8mpQnzFPp9/02n+HFw2kzAhEaJGftOMkUC0BCCrJSDsoFX8ugZzGwWg
         d2DjVCeX/J7U9+WIARWhv7X4UCW9MsFJln0tVDKJF24PGeKe7Wl3FBkNjxR9f3H5Mrpr
         DnOw==
X-Forwarded-Encrypted: i=1; AJvYcCVx+jwTSzvZBKj2Y8m1JQLebcXhwZBWHtVValkMv3sb6UA0dVKKI3ccG+wfriaNOwS7ZJ92lTjZqL2RLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6ov/ROGD5Dq7n0+eqi6cDPKxV526d2zqJe5ag6r8xQUOWPXe
	riSH05Cr2sBj/deW1WZ06b5S6k2ojJ3OEORCThhmV9dSq7Y/q9yxcjjEm+/MMT65Qgw=
X-Gm-Gg: AY/fxX6NZUrsGZC++NgeDlgeAzfA2pjy2TQrAzIpg9M3o0X0yc7acqrzIwO3NkK4eCw
	NYQCVj3wN1lWnCznSUgEckfMcJ3JfHwXmZu50ImqOybDFb15hGxf+V3AFv8ukzkmq/ycwMAK0ZS
	Iy7meWOMB7cEnLqDXFs/nblPeOPqT8nzVFczDzSh4gmTmpi7H0I6obJH73/+gtUZq2BI67nHc6g
	kDuxiTiLLaI5KLW/x8Ra9qmbvmOZnyD7vDfojYrWMNkxcXibnIkTfE1wL3KFZUBHYnsGGRRMu0Y
	0ByZYtWa2JT97LnxxrnOUUsiF9Ab6UelP3z2v8Iwrj/18RZe/WGsZod74Rfn6V58Ov0/2CzuRMl
	YhS7PgcsDInyxUhzNaibo6QFHYOq5cZafUvS18xZYWbtAaRV1XFwAlVX38k8jZszVKFn1jG57db
	0CGOTQBjrsRRfMv3+FgBkHUWp/AaI6TlGRK4cUZVg=
X-Google-Smtp-Source: AGHT+IFSef2aMjOCZGiXaCxi2Igicwoyhqhjno+GXu6eUEHCj9Gse5EYWzTfjdNlvctTRctY6fvSNA==
X-Received: by 2002:a05:600c:6388:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-47d19557cd2mr408312175e9.16.1767157757357;
        Tue, 30 Dec 2025 21:09:17 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d71sm320207135ad.17.2025.12.30.21.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 21:09:16 -0800 (PST)
Message-ID: <eb8d0d62-f8a3-4198-b230-94f72028ac4e@suse.com>
Date: Wed, 31 Dec 2025 15:39:11 +1030
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
In-Reply-To: <CAMVG2subBHEZ4e8vFT7cQM5Ub=WfUmLqAQ4WO1B=Gk2bC3BtdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/31 15:30, Daniel J Blueman 写道:
> On Wed, 31 Dec 2025 at 12:55, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/12/31 14:35, Qu Wenruo 写道:
>>> 在 2025/12/31 13:59, Daniel J Blueman 写道:
>>>> On Tue, 30 Dec 2025 at 17:28, Qu Wenruo <wqu@suse.com> wrote:
>>>>> 在 2025/12/30 19:26, Qu Wenruo 写道:
>>>>>> 在 2025/12/30 18:02, Daniel J Blueman 写道:
>>>>>>> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
>>>>>>> checksumming and KASAN, I see invalid access:
>>>>>>
>>>>>> Mind to share the page size? As aarch64 has 3 different supported pages
>>>>>> size (4K, 16K, 64K).
>>>>>>
>>>>>> I'll give it a try on that branch. Although on my rc1 based development
>>>>>> branch it looks OK so far.
>>>>>
>>>>> Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 tag,
>>>>> no reproduce on newly created fs with xxhash.
>>>>>
>>>>> My environment is aarch64 VM on Orion O6 board.
>>>>>
>>>>> The xxhash implementation is the same xxhash64-generic:
>>>>>
>>>>> [   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6d
>>>>> devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount
>>>>> (629)
>>>>> [   17.038033] BTRFS info (device dm-2): first mount of filesystem
>>>>> 260364b9-d059-410c-92de-56243c346d6d
>>>>> [   17.038645] BTRFS info (device dm-2): using xxhash64
>>>>> (xxhash64-generic) checksum algorithm
>>>>> [   17.041303] BTRFS info (device dm-2): checking UUID tree
>>>>> [   17.041390] BTRFS info (device dm-2): turning on async discard
>>>>> [   17.041393] BTRFS info (device dm-2): enabling free space tree
>>>>> [   19.032109] BTRFS info (device dm-2): last unmount of filesystem
>>>>> 260364b9-d059-410c-92de-56243c346d6d
>>>>>
>>>>> So there maybe something else involved, either related to the fs or the
>>>>> hardware.
>>>>
>>>> Thanks for checking Wenruo!
>>>>
>>>> With KASAN_GENERIC or KASAN_HW_TAGS, I don't see "kasan:
>>>> KernelAddressSanitizer initialized", so please ensure you are using
>>>> KASAN_SW_TAGS, KASAN_OUTLINE and 4KB pages. Full config at
>>>> https://gist.github.com/dblueman/cb4113f2cf880520081cf3f7c8dae13f
>>>
>>> Thanks a lot for the detailed configs.
>>>
>>> Unfortunately with that KASAN_SW_TAGS and KASAN_INLINE, the kernel can
>>> no longer boot, will always crash at boot with the following call trace,
>>> thus not even able to reach btrfs:
>>>
>>> [    3.938722]
>>> ==================================================================
>>> [    3.938739] BUG: KASAN: invalid-access in
>>> bpf_patch_insn_data+0x178/0x3b0
>> [...]
>>> Considering this is only showing up in KASAN_SW_TAGS, not HW_TAGS or the
>>> default generic mode, I'm wondering if this is a bug in KASAN itself.
>>>
>>> Adding KASAN people to the thread, meanwhile I'll check more KASAN +
>>> hardware combinations including x86_64 (since it's still 4K page size).
>>
>> I tried the following combinations, with a simple workload of mounting a
>> btrfs with xxhash checksum.
>>
>> According to the original report, the KASAN is triggered as btrfs
>> metadata verification time, thus mount option/workload shouldn't cause
>> any different, as all metadata will use the same checksum algorithm.
>>
>> x86_64 + generic + inline:      PASS
>> x86_64 + generic + outline:     PASS
> [..]
>> arm64 + hard tag:               PASS
>> arm64 + generic + inline:       PASS
>> arm64 + generic + outline:      PASS
> 
> Do you see "KernelAddressSanitizer initialized" with KASAN_GENERIC
> and/or KASAN_HW_TAGS?

Yes. For my current running one using generic and inline, it shows at 
boot time:

[    0.000000] cma: Reserved 64 MiB at 0x00000000fc000000
[    0.000000] crashkernel reserved: 0x00000000dc000000 - 
0x00000000fc000000 (512 MB)
[    0.000000] KernelAddressSanitizer initialized (generic) <<<
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.3 detected in firmware.


> 
> I didn't see it in either case, suggesting it isn't implemented or
> supported on my system.
> 
>> arm64 + soft tag + inline:      KASAN error at boot
>> arm64 + soft tag + outline:     KASAN error at boot
> 
> Please retry with CONFIG_BPF unset.

I will retry but I believe this (along with your reports about hardware 
tags/generic not reporting the error) has already proven the problem is 
inside KASAN itself.

Not to mention the checksum verification/calculation is very critical 
part of btrfs, although in v6.19 there is a change in the crypto 
interface, I still doubt about whether we have a out-of-boundary access 
not exposed in such hot path until now.

Thanks,
Qu

> 
> Thanks,
>    Dan


