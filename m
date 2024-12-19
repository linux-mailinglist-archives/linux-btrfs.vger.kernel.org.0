Return-Path: <linux-btrfs+bounces-10619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920D9F8890
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 00:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B38B1887617
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5611E9B17;
	Thu, 19 Dec 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Err+w9XA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213321CCB21
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734651201; cv=none; b=stw8HrIrBxCmPNvsH/TmNuzze6r4HcYwhi5XR1lrwyw/9Px+bFKgzO2b+n4Qhi8cVfKDvAt2gEIz4WDbZjuHn9QRu3uFgZofjBXEku3SP83kc7kPST9WGz+IBVooXw34HMjVrWX3T9ZBG3Ihx/TLiUSc4gCSKzgQaubLToU19Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734651201; c=relaxed/simple;
	bh=IGUlTiZB+8SYnvIyjl7ycth1V8p6AFVwQwmiellDTDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/0Q2ZUd4AsNHSndO9JaB7hgasiw0m9aUdEGuC+O2DsL0y+Sg9cLOKjSdMudyr2iF19GClnul/6W2hu/5CFMhnE7SvKbbN37CUOcxs8RKTzuSm5euDWuXYQZ7tU1vxvpft4eTMqyrDcJ9KjT/CZohD2Hlt7N8KftdcMBduL2c+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Err+w9XA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso9142095e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734651196; x=1735255996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plXzy0mqccglcjN60lQtMmRi6JM3/4v7bNfZ+B+BCEo=;
        b=Err+w9XAJrRshT+9EMZ54cYI6Wp6gCUpdFiFrOkIOdYNCZ8lLmxZ3h/p22uBxK/eSK
         5OnApN7LzXRUBe1YgexRGll0JKThV1pXVE0C+Sowu8NVANpRSSzl3TAv0P4D30Qun/Au
         9D3FnlqMbAeLWnIglT3WwPmTeJhlzicOMjOvuu8IxYSzLrT6+n9sacdfRo67vqghici9
         owJ7pXQNixo9IOmm+H4HVdOx5flecfbS2/L0QhgijnX4RKV/Rm7CJ3FPgMLcRSTW7yoM
         1/JgYKkNIqqAJboVjYZeEwyOH7CKi3b0ZAAQy+lCMKWvwCtM4CDCcCLT0V4GVjVhZMix
         jhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734651196; x=1735255996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plXzy0mqccglcjN60lQtMmRi6JM3/4v7bNfZ+B+BCEo=;
        b=WaKFXyEpFS8QN3QDL+bjkMbvu5aB9VvvegW8PGa5Vk0M+sUJd5zg7oW8JHrE0Dhhhw
         sbjlgOxAlYi2wQbT2QNj/NAe/n+bfrtpeySAlv6SCfxto5wx8y3uZnxVQsbbfAcTFMe/
         qP+x812rg6Smi5USiJ8qNXfsQYx1ijJ4HCW3bIkKMhU/8EWmyz55I9banhfjX7UsJyrb
         Plwd/OgzhJyPcsJ5E41TgePWKOvCOOt1tmmo4ikzahwcUm0yrfR6nehgstUSFEA7dr1Q
         51PyePzn1X9YOxg7zxQZ/TG+GFBujyzE3OqyPgSFUCgBjF/do44I4UqoT2WeWCnKmMkh
         wY5w==
X-Forwarded-Encrypted: i=1; AJvYcCVJyoyFFWY8Ag5h9xp7uGHhP3wWhDuo0If/aiDOkLP5r5XDpLjc/UTlRcmdVX3M3iG944I5F+4Qhi7hzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnw/B/ciQoMoaJWtxlFf7qktLTVxAMJF4VexfEoD3CYHV1XAbl
	dM6DlUA90ozh4rSDWxIUf72tG1q8ILwdEdCPcChKz4uBVMVBALcF513E06RLSdA=
X-Gm-Gg: ASbGncvWMcK7LcKULwRswjRcREEZNd/cffOoSqCbKlmuEJ7gWLIPOXjdbvtgddGJDyh
	zXcGBsXIlxGocHeTHio1gkUz3lxV1qRkB6f+1y3OItMsP63OC6GSgZBf80x2DiFbby9BNSIAjGr
	Ae2tZx+BvqmICZaU6pU+q9mAfQ2NvV3QA2eTHfuvxIj81yKyW0zuLc8AXwHO6IFt5BQfDv9oeRZ
	w25696PBNt2L95s/oRQs77/ZfPbzGM1qLID2JPqstq032XeBGDlZV2AwHS9H3dwp/3W8gUkDxcc
	ntUzN4Ad
X-Google-Smtp-Source: AGHT+IF6jsLKrygiCsaqg3pCcyY8MzhIQvO7tqSo5RX2vJWoS0uQZfdMN1myWFcxAw/3ExiSRCwNfw==
X-Received: by 2002:a5d:5e09:0:b0:385:f16d:48b4 with SMTP id ffacd0b85a97d-38a223f7510mr934878f8f.40.1734651196065;
        Thu, 19 Dec 2024 15:33:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8162d0sm1883546b3a.12.2024.12.19.15.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 15:33:15 -0800 (PST)
Message-ID: <023311e6-9666-4fe0-9c22-6a8409065539@suse.com>
Date: Fri, 20 Dec 2024 10:03:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Linux btrfs <linux-btrfs@vger.kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 David Sterba <dsterba@suse.com>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
 <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
 <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
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
In-Reply-To: <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/20 02:07, Dan Carpenter 写道:
> On Thu, Dec 19, 2024 at 06:10:56PM +0300, Dan Carpenter wrote:
>>>> Mind to test it with KASAN enabled?
>>>
>>
>> Anders is going to try that later and report back.
>>
> 
> Anders ran it and emailed me.  I was going to tell him to respond to
> the thread but I decided to steal the credit.  #GreatArtists
> 
>   BTRFS info (device loop0): using crc32c (crc32c-arm64) checksum algorithm
>   ==================================================================
>   BUG: KASAN: slab-out-of-bounds in __bitmap_set+0xf8/0x100
>   Read of size 8 at addr fff0000020e4a3c8 by task chdir01/479
>   
>   CPU: 1 UID: 0 PID: 479 Comm: chdir01 Not tainted 6.13.0-rc3-next-20241218 #1
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x8c/0xd0
>    print_report+0x118/0x5e0
>    kasan_report+0xb4/0x100
>    __asan_report_load8_noabort+0x20/0x30
>    __bitmap_set+0xf8/0x100
>    btrfs_subpage_set_uptodate+0xd8/0x1d0 [btrfs]
>    set_extent_buffer_uptodate+0x1ac/0x288 [btrfs]
>    __alloc_dummy_extent_buffer+0x2cc/0x488 [btrfs]

Thanks a lot. The problem is still inside the dummy extent buffer 
allocation.

This time it's again related to the uninitialized fs_info->* variables.

In this case, it's the fs_info->sectorsize_bits which is not 
initialized, thus its default value is 0.

Then in btrfs_subpage_set_uptodate(), we use (len >> sectorsize_bits) to 
calculate how many bits must be set.

But since sectorsize_bits is 0, the @len (4K) is utilized, resulting the 
out-of-boundary access.

The root cause is the same as the initial failure, that we can not use a 
lot of functions to do such early verification, thus I'll create a 
dedicated helper to do the sanity check to avoid memory allocation nor 
early access to fs_info.

Thanks everyone involved in exposing this bug!
Qu

>    alloc_dummy_extent_buffer+0x4c/0x78 [btrfs]
>    btrfs_check_system_chunk_array+0x30/0x308 [btrfs]
>    btrfs_validate_super+0x7e8/0xd40 [btrfs]
>    open_ctree+0x958/0x3c98 [btrfs]
>    btrfs_get_tree+0xce4/0x13d8 [btrfs]
>    vfs_get_tree+0x7c/0x290
>    fc_mount+0x20/0xa8
>    btrfs_get_tree+0x72c/0x13d8 [btrfs]
>    vfs_get_tree+0x7c/0x290
>    path_mount+0x748/0x1518
>    __arm64_sys_mount+0x234/0x4f8
>    invoke_syscall.constprop.0+0x78/0x1f0
>    do_el0_svc+0xcc/0x1d8
>    el0_svc+0x38/0xa8
>    el0t_64_sync_handler+0x10c/0x138
>    el0t_64_sync+0x198/0x1a0
> 
> Here are the full logs.
> https://people.linaro.org/~anders.roxell/next-20241218-issue-arm64-64k+kasan/
> 
> regards,
> dan carpenter


