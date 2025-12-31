Return-Path: <linux-btrfs+bounces-20045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4E5CEB3E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 05:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3D49300BEE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 04:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45530F94D;
	Wed, 31 Dec 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AR0Wz5FZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C11D63E4
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767156918; cv=none; b=s5JG8XQohMGebn9eQ6L+WBqZAI3px+X4E0emZm8HPYR3gbpOqPDCofCluqgaCjOovb7pJ3U5oD8jHxMLhQFOM9BSRkr6wiEtVsRHv2qnsYaWGwGudSpRzKoTuAl+ZtESI6sTmYHkdokCZmpXwcEXNFdJwAuFxo3pRSEmcZq74iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767156918; c=relaxed/simple;
	bh=S+9t1lSb0j4Efkz0TwS248JbRQVgxcge3/o+iF0QNqs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iw0Q0uCvegNCsTuYrTxmOP1snZKjktJb8m6kZyyZJCWOP4bKjatgo2adjpUKrQVN8zmQQy9lIEnbzzcmYHOtj9X/4Xo7gUOHb121MdZKrfgU2dYbPQzA4eFVHZ9a3PpCjF0h+tfAXkroZC3engLurTmUmkzUdpRK+bAA6H9THV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AR0Wz5FZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so105269075e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 20:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767156913; x=1767761713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j6JiNX4DyxHQ3Lh71drQeQ4TeiUI1sDQ4EAAd5MGan4=;
        b=AR0Wz5FZt8LTJvKrVga35U0sOBBDtJxbA7BvEGhi7JdEyxdlbe5GU4IwELaQE1TUT4
         eKcCuDvXZ+nvqj+UaLDBHIc6eUyYeb4NSuj7Jkg09E1Dona4ey9LDkQ1lH1fd0EHLpwj
         w6qlSansN3QcuOlkR6j4irffhBoSdpP272V8u6LsgQta6AufdODbteVOPVLXPm85qq3R
         +GTsLMDNtUi/p1vy7rdH+8yhEAavnU2Dtr2F5n9v2SBCiOGUbC73jsPTokpt2+xiYCBa
         PwFIwoDPxd78PTO9elVqW9seE4lB2kjk73zMUoVVUzGoUBLDDpz+43mDN0yCaYae1ylR
         N/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767156913; x=1767761713;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6JiNX4DyxHQ3Lh71drQeQ4TeiUI1sDQ4EAAd5MGan4=;
        b=X0gWSlqyVZjGVLKRKSEym5FeQLz7PQQ/Ko+DXqm5DXzJZ27M+3D3VkSitXrvR6heRn
         D4lGodDIqVPi82OLZvSRIC18doMJb4QHY13cc7LvrKVedzzahFQv4MVgc+3kw1yHOSoQ
         bJg7U4oGxLzxQhVjj6BpapAvU/t8Ucy9IcQenEnybtD0T0dFXPh4GKKqACaQo98iZVBZ
         Sq3uYne3DEuM3XcXALKtPXA6itZm28E/NQ+V49qTTUoWuUCVagzfeRUqCT7TnzKnEYpk
         SjjE2A4BVcIZD2R9CnOheXEF1rIsNTM8N9SLAa04OBwt8+TdzD/NguNZp5sGDXdFYiy6
         KXXg==
X-Forwarded-Encrypted: i=1; AJvYcCWaAbAQ2DYtoUtCjr1H9wzwHhzAPW8L14XCP6WCf9v/G/GSXQd0aFFOfoLLqn5zsJF9o5xLgeLwzxhqag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9pre95prhve4jp5O4ULN4JdBAAlKY4PVIiMvf33ywOkz4zeBR
	lanoMQjrgBBh0M+tbJmMbvvda/TYsbyzuF1FU0tme77affy+u4EKaB3O528lagB46+k=
X-Gm-Gg: AY/fxX4f9eUuYdsnCDIBjrFnLdVGlRD593oZBFIF0qEytrwmfw7uoNo4ErT4ctudB5J
	PmsqPYzBxDDet5YaxttRZI/4+SyWYxAGJ9bYRedWms9WcBJaQ2tJLyi/xSmpu3Y96yUZDqX0cg3
	WdJ6g4OJ/PlwIlv3vqvYcwUn60FvmCZK5Lr5ILxaOjz6QPh2o1zcVA66WjHtVUJav0510LxSqoF
	mGWTJvtuLsYjXyXg1/lXdaJgQeQQbQAM7I4CUJHx+NtbB1ArT9J2bP7Z/C6DR6HK6smkgLv3qKM
	lPksIOJBOg/O5taGAEfnTwZey3fEiE3dsEy2/LwaFJ19SbbMv1DrKGUmf6svYE31hJ2DdRMqktH
	E6QNhjOO79Q0Xi59VfZ5DYrowgIRUYCMtm++Vv+PhrwRuaB6MurCejAFvNN9Fcrw/AaSInIX/hH
	01Xmt/AGRb2ZT1NMi6cxTr6N4f3ly3ZCRw/4mA8PI=
X-Google-Smtp-Source: AGHT+IHvkn/UqHdAbpO5Z7TPw3D2l2hZ15S6rONa7RsN3x7C+TBBN23FzbojrQHxWPIo9kksZRLHZg==
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d19549f5dmr416579065e9.10.1767156913483;
        Tue, 30 Dec 2025 20:55:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb25sm319044435ad.56.2025.12.30.20.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 20:55:12 -0800 (PST)
Message-ID: <9d21022d-5051-4165-b8fa-f77ec7e820ab@suse.com>
Date: Wed, 31 Dec 2025 15:25:08 +1030
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
In-Reply-To: <17bf8f85-9a9c-4d7d-add7-cd92313f73f1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/31 14:35, Qu Wenruo 写道:
> 
> 
> 在 2025/12/31 13:59, Daniel J Blueman 写道:
>> On Tue, 30 Dec 2025 at 17:28, Qu Wenruo <wqu@suse.com> wrote:
>>> 在 2025/12/30 19:26, Qu Wenruo 写道:
>>>> 在 2025/12/30 18:02, Daniel J Blueman 写道:
>>>>> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
>>>>> checksumming and KASAN, I see invalid access:
>>>>
>>>> Mind to share the page size? As aarch64 has 3 different supported pages
>>>> size (4K, 16K, 64K).
>>>>
>>>> I'll give it a try on that branch. Although on my rc1 based development
>>>> branch it looks OK so far.
>>>
>>> Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 tag,
>>> no reproduce on newly created fs with xxhash.
>>>
>>> My environment is aarch64 VM on Orion O6 board.
>>>
>>> The xxhash implementation is the same xxhash64-generic:
>>>
>>> [   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6d
>>> devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount 
>>> (629)
>>> [   17.038033] BTRFS info (device dm-2): first mount of filesystem
>>> 260364b9-d059-410c-92de-56243c346d6d
>>> [   17.038645] BTRFS info (device dm-2): using xxhash64
>>> (xxhash64-generic) checksum algorithm
>>> [   17.041303] BTRFS info (device dm-2): checking UUID tree
>>> [   17.041390] BTRFS info (device dm-2): turning on async discard
>>> [   17.041393] BTRFS info (device dm-2): enabling free space tree
>>> [   19.032109] BTRFS info (device dm-2): last unmount of filesystem
>>> 260364b9-d059-410c-92de-56243c346d6d
>>>
>>> So there maybe something else involved, either related to the fs or the
>>> hardware.
>>
>> Thanks for checking Wenruo!
>>
>> With KASAN_GENERIC or KASAN_HW_TAGS, I don't see "kasan:
>> KernelAddressSanitizer initialized", so please ensure you are using
>> KASAN_SW_TAGS, KASAN_OUTLINE and 4KB pages. Full config at
>> https://gist.github.com/dblueman/cb4113f2cf880520081cf3f7c8dae13f
> 
> Thanks a lot for the detailed configs.
> 
> Unfortunately with that KASAN_SW_TAGS and KASAN_INLINE, the kernel can 
> no longer boot, will always crash at boot with the following call trace, 
> thus not even able to reach btrfs:
> 
> [    3.938722] 
> ==================================================================
> [    3.938739] BUG: KASAN: invalid-access in 
> bpf_patch_insn_data+0x178/0x3b0
[...]
> 
> 
> Considering this is only showing up in KASAN_SW_TAGS, not HW_TAGS or the 
> default generic mode, I'm wondering if this is a bug in KASAN itself.
> 
> Adding KASAN people to the thread, meanwhile I'll check more KASAN + 
> hardware combinations including x86_64 (since it's still 4K page size).

I tried the following combinations, with a simple workload of mounting a 
btrfs with xxhash checksum.

According to the original report, the KASAN is triggered as btrfs 
metadata verification time, thus mount option/workload shouldn't cause 
any different, as all metadata will use the same checksum algorithm.

x86_64 + generic + inline:	PASS
x86_64 + generic + outline:	PASS
arm64 + soft tag + inline:	KASAN error at boot
arm64 + soft tag + outline:	KASAN error at boot
arm64 + hard tag:		PASS
arm64 + generic + inline:	PASS
arm64 + generic + outline:	PASS

So it looks like it's the software tag based KASAN itself causing false 
alerts.

Thanks,
Qu

> 
> Thanks,
> Qu
> 
> 
>>
>> Also ensure your mount options resolve similar to
>> "rw,relatime,compress=zstd:3,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/".
>>
>> Failing that, let me know of any significant filesystem differences from:
>> # btrfs inspect-internal dump-super /dev/nvme0n1p5
>> superblock: bytenr=65536, device=/dev/nvme0n1p5
>> ---------------------------------------------------------
>> csum_type        1 (xxhash64)
>> csum_size        8
>> csum            0x97ec1a3695ae35d0 [match]
>> bytenr            65536
>> flags            0x1
>>              ( WRITTEN )
>> magic            _BHRfS_M [match]
>> fsid            f99f2753-0283-4f93-8f5d-7a9f59f148cc
>> metadata_uuid        00000000-0000-0000-0000-000000000000
>> label
>> generation        34305
>> root            586579968
>> sys_array_size        129
>> chunk_root_generation    33351
>> root_level        0
>> chunk_root        19357892608
>> chunk_root_level    0
>> log_root        0
>> log_root_transid (deprecated)    0
>> log_root_level        0
>> total_bytes        83886080000
>> bytes_used        14462930944
>> sectorsize        4096
>> nodesize        16384
>> leafsize (deprecated)    16384
>> stripesize        4096
>> root_dir        6
>> num_devices        1
>> compat_flags        0x0
>> compat_ro_flags        0x3
>>              ( FREE_SPACE_TREE |
>>                FREE_SPACE_TREE_VALID )
>> incompat_flags        0x361
>>              ( MIXED_BACKREF |
>>                BIG_METADATA |
>>                EXTENDED_IREF |
>>                SKINNY_METADATA |
>>                NO_HOLES )
>> cache_generation    0
>> uuid_tree_generation    34305
>> dev_item.uuid        86166b5f-2258-4ab9-aac6-0d0e37ffbdb6
>> dev_item.fsid        f99f2753-0283-4f93-8f5d-7a9f59f148cc [match]
>> dev_item.type        0
>> dev_item.total_bytes    83886080000
>> dev_item.bytes_used    22624075776
>> dev_item.io_align    4096
>> dev_item.io_width    4096
>> dev_item.sector_size    4096
>> dev_item.devid        1
>> dev_item.dev_group    0
>> dev_item.seek_speed    0
>> dev_item.bandwidth    0
>> dev_item.generation    0
>>
>> Thanks,
>>    Dan
>> -- 
>> Daniel J Blueman
> 
> 


