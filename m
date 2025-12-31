Return-Path: <linux-btrfs+bounces-20044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16ACCEB36E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 05:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6173012761
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 04:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2830F925;
	Wed, 31 Dec 2025 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZG/ffczn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152926E719
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153941; cv=none; b=ftkVtUkNt3s6jQVtFXlGMfb1/q0BDAZ8v1JSXOGUaiDfcuZ8JLwgLo9t45Oyle5q+yvjRG42E8AxS3nZR4uVbPcJ1D+f0vPpC7NfJDU9Jj+MlE0+ynXT6VxX2XcC5XLhs9Eb84p0skhmN+Qg5j0ZEkWzv7OfOfqH1euKbTs6sXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153941; c=relaxed/simple;
	bh=LKfq6XWk6xLnwfKHbwDdrz6PUrSdMpsuA7G/WSLufbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFbN3XKy8VYbjaOby98ymq5zZ+sq9srCNpkkZvAJQlfSjeRFxoMmScjdeystGz5Rz+Z2nhdeK03K0EdTBaaEQEsbun9U8efzPffjt3ohBj1B3QNK2nVtYhSRHTwPWedAD2TL5JnLTMqJu1Tv8FUP8jfQqAj15H+rvs+NzLB7xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZG/ffczn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so17604865e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 20:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767153937; x=1767758737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QDjH5wbfhxPfj+6uM2hu7o/MrYmh6JDGhunKWeqrN+4=;
        b=ZG/ffczn8fJBqOSLradx+JOzIs7U5g85+crhkSiAKMKFkHGr+hXyiz0bforpHML+Wi
         pWw32dJX9b0IFeKMje3vElk+Kvw+5PWcR18YF49SIQWNwGHYBxDSnP3B0OKXhb7k1p29
         IilvO7/1OqHDgw5e6gbgwMJb8vHerCkDnCYg7JHTS92RqFI/AYmvJzp/7TI4ZflOjcsE
         upt7/9cATNLIePyDWQ4lh7tN2vSOOpJUMi/4CU0oLzXSf9gPVtYXIKQRHWbifg9u7/Hc
         hdnZSna7XYZSKftzPyxKaPXapj0rZva81QgA4H0ReYOZkMK7G2fpRL+TL8qqH6R6zIiR
         z58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767153937; x=1767758737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDjH5wbfhxPfj+6uM2hu7o/MrYmh6JDGhunKWeqrN+4=;
        b=swW+0i9BwTBn7uEBHLnSJji+J1LzZJ6yEM9BUGzLThSKUGSuESz2rPQN1w2RjyypM2
         mogoSsaJAyOP3cwXhOLgfw5QrjUY2yuwk+Sls/GVDcISNCAEV2Z/FEKa2BZj8dPyA4CE
         TxK5PI2WN+p/At8VxN9IuviEhGRErK8ogGtZ1NG/m11dYxcg5qNiaAE8MoGdANWZx2U2
         2RSPj9sYpnG+VErmOyhuUJEii8tnkcbbf/brxbZqVCe4G4+jhsN7xWNVWTHmXmeS84kt
         qRiQtLJFKlnbSZpXJUYLmoFqyeuUBQ4sgRXPuV6EUUpM09fjnZmdY0sPxciyhGKRl/gM
         /MCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpvv1LmBApYVJy035YCziJNj8FXSQ+ksbzF1lYxRcOHNgFa4yY+w3qpGh3aWDZnZ2D6g2WCRzKxp/p8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa19oiEonOehBY4vrF30KbuwgAqNZkSnLsDYw2Eh5ID9ODqs36
	8VLyh83FRKwbk/2DJW1ODC6q1BQTOxH7MkdW/9yLV3f7KCGaOTzumEry24p3+8sQZug=
X-Gm-Gg: AY/fxX5ehrAKXzF4c36EbBPko3zbJg/4dNzWg/X1JtpRKqkkDuR9Gs0f3M7qBuOizPC
	tN32KNTwIbWlIvs9SLEEajfQFW086l7fz4dunnbiQOrQIXXIGvOXyMyCrV9WnllfWTEKD3ck3cH
	Cy97p9sL9rLKmd5Dlb1/mv+rjMuCaOCKk/+BADV6U9jql9g1QNs5QJFpBENzoMNK1NC78WvIAes
	WvurkrDvdAMuWCf0Wnq8JfZIMgHdmVsVn50T16RJJ7rLP4NHepn8YPvPRcRW+tbFZu/UcO8QB2p
	dES1u0ghYd5i1KkE8MtPvNWTpWEu1SzQ8U31uxK2Skudf7I7o5toUoC0lGGEWWWurcEtSk7VjKW
	7dzbC3rjt7maqEP3D5713clY/BLN/D9cDdM3fGlS6379cG3qK2l1j9KmRlTChRjV6XIYwAJIYNG
	VYoJiQKyJ2yMqAWp54x/s8Uj+H3ElpiofuXvpu7DQ=
X-Google-Smtp-Source: AGHT+IGq1WbYpTyuDJZanjHWxzWMet6Rc1nHpwuIX0jiHAucur2qiEceQz+/4gdarAM1/qgMi2ZF5w==
X-Received: by 2002:a05:600c:3489:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-47d206a9856mr367047315e9.5.1767153936756;
        Tue, 30 Dec 2025 20:05:36 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961fbb9sm28972790a12.2.2025.12.30.20.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 20:05:36 -0800 (PST)
Message-ID: <17bf8f85-9a9c-4d7d-add7-cd92313f73f1@suse.com>
Date: Wed, 31 Dec 2025 14:35:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Soft tag and inline kasan triggering NULL pointer dereference, but
 not for hard tag and outline mode (was Re: [6.19-rc3] xxhash invalid access
 during BTRFS mount)
To: Daniel J Blueman <daniel@quora.org>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
 Linux BTRFS <linux-btrfs@vger.kernel.org>, linux-crypto@vger.kernel.org,
 Linux Kernel <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
 ryabinin.a.a@gmail.com
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
 <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com>
 <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
 <CAMVG2suYnp-D9EX0dHB5daYOLT++v_kvyY8wV-r6g36T6DZhzg@mail.gmail.com>
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
In-Reply-To: <CAMVG2suYnp-D9EX0dHB5daYOLT++v_kvyY8wV-r6g36T6DZhzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/31 13:59, Daniel J Blueman 写道:
> On Tue, 30 Dec 2025 at 17:28, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/12/30 19:26, Qu Wenruo 写道:
>>> 在 2025/12/30 18:02, Daniel J Blueman 写道:
>>>> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
>>>> checksumming and KASAN, I see invalid access:
>>>
>>> Mind to share the page size? As aarch64 has 3 different supported pages
>>> size (4K, 16K, 64K).
>>>
>>> I'll give it a try on that branch. Although on my rc1 based development
>>> branch it looks OK so far.
>>
>> Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 tag,
>> no reproduce on newly created fs with xxhash.
>>
>> My environment is aarch64 VM on Orion O6 board.
>>
>> The xxhash implementation is the same xxhash64-generic:
>>
>> [   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6d
>> devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount (629)
>> [   17.038033] BTRFS info (device dm-2): first mount of filesystem
>> 260364b9-d059-410c-92de-56243c346d6d
>> [   17.038645] BTRFS info (device dm-2): using xxhash64
>> (xxhash64-generic) checksum algorithm
>> [   17.041303] BTRFS info (device dm-2): checking UUID tree
>> [   17.041390] BTRFS info (device dm-2): turning on async discard
>> [   17.041393] BTRFS info (device dm-2): enabling free space tree
>> [   19.032109] BTRFS info (device dm-2): last unmount of filesystem
>> 260364b9-d059-410c-92de-56243c346d6d
>>
>> So there maybe something else involved, either related to the fs or the
>> hardware.
> 
> Thanks for checking Wenruo!
> 
> With KASAN_GENERIC or KASAN_HW_TAGS, I don't see "kasan:
> KernelAddressSanitizer initialized", so please ensure you are using
> KASAN_SW_TAGS, KASAN_OUTLINE and 4KB pages. Full config at
> https://gist.github.com/dblueman/cb4113f2cf880520081cf3f7c8dae13f

Thanks a lot for the detailed configs.

Unfortunately with that KASAN_SW_TAGS and KASAN_INLINE, the kernel can 
no longer boot, will always crash at boot with the following call trace, 
thus not even able to reach btrfs:

[    3.938722] 
==================================================================
[    3.938739] BUG: KASAN: invalid-access in bpf_patch_insn_data+0x178/0x3b0
[    3.938766] Write of size 6720 at addr 96ff80008024b120 by task systemd/1
[    3.938772] Pointer tag: [96], memory tag: [08]
[    3.938775]
[    3.938791] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 
6.19.0-rc3-custom #159 PREEMPT(voluntary)
[    3.938801] Hardware name: QEMU KVM Virtual Machine, BIOS unknown 
2/2/2022
[    3.938805] Call trace:
[    3.938808]  show_stack+0x20/0x38 (C)
[    3.938827]  dump_stack_lvl+0x60/0x80
[    3.938846]  print_report+0x17c/0x488
[    3.938860]  kasan_report+0xbc/0x108
[    3.938887]  kasan_check_range+0x7c/0xa0
[    3.938895]  __asan_memmove+0x54/0x98
[    3.938904]  bpf_patch_insn_data+0x178/0x3b0
[    3.938912]  bpf_check+0x2720/0x49d8
[    3.938920]  bpf_prog_load+0xbd0/0x13e8
[    3.938928]  __sys_bpf+0xba0/0x2dc8
[    3.938935]  __arm64_sys_bpf+0x50/0x70
[    3.938943]  invoke_syscall.constprop.0+0x88/0x148
[    3.938957]  el0_svc_common.constprop.0+0x7c/0x148
[    3.938964]  do_el0_svc+0x38/0x50
[    3.938970]  el0_svc+0x3c/0x198
[    3.938984]  el0t_64_sync_handler+0xa0/0xe8
[    3.938993]  el0t_64_sync+0x198/0x1a0
[    3.939001]
[    3.939003] The buggy address belongs to a 2-page vmalloc region 
starting at 0x96ff80008024b000 allocated at bpf_check+0x158/0x49d8
[    3.939015] The buggy address belongs to the physical page:
[    3.939026] page: refcount:1 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x10cede
[    3.939035] flags: 0x2d600000000000(node=0|zone=2|kasantag=0xd6)
[    3.939047] raw: 002d600000000000 0000000000000000 dead000000000122 
0000000000000000
[    3.939053] raw: 0000000000000000 0000000000000000 00000001ffffffff 
0000000000000000
[    3.939057] raw: 00000000000fffff 0000000000000000
[    3.939060] page dumped because: kasan: bad access detected
[    3.939064]
[    3.939065] Memory state around the buggy address:
[    3.939069]  ffff80008024c900: 96 96 96 96 96 96 96 96 96 96 96 96 96 
96 96 96
[    3.939073]  ffff80008024ca00: 96 96 96 96 96 96 96 96 96 96 96 96 96 
96 96 96
[    3.939076] >ffff80008024cb00: 08 08 08 08 08 08 fe fe fe fe fe fe fe 
fe fe fe
[    3.939079]                    ^
[    3.939082]  ffff80008024cc00: fe fe fe fe fe fe fe fe fe fe fe fe fe 
fe fe fe
[    3.939086]  ffff80008024cd00: fe fe fe fe fe fe fe fe fe fe fe fe fe 
fe fe fe
[    3.939089] 
==================================================================
[    3.939107] Disabling lock debugging due to kernel taint
[    3.939134] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000020


Considering this is only showing up in KASAN_SW_TAGS, not HW_TAGS or the 
default generic mode, I'm wondering if this is a bug in KASAN itself.

Adding KASAN people to the thread, meanwhile I'll check more KASAN + 
hardware combinations including x86_64 (since it's still 4K page size).

Thanks,
Qu


> 
> Also ensure your mount options resolve similar to
> "rw,relatime,compress=zstd:3,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/".
> 
> Failing that, let me know of any significant filesystem differences from:
> # btrfs inspect-internal dump-super /dev/nvme0n1p5
> superblock: bytenr=65536, device=/dev/nvme0n1p5
> ---------------------------------------------------------
> csum_type        1 (xxhash64)
> csum_size        8
> csum            0x97ec1a3695ae35d0 [match]
> bytenr            65536
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            f99f2753-0283-4f93-8f5d-7a9f59f148cc
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label
> generation        34305
> root            586579968
> sys_array_size        129
> chunk_root_generation    33351
> root_level        0
> chunk_root        19357892608
> chunk_root_level    0
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        83886080000
> bytes_used        14462930944
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    34305
> dev_item.uuid        86166b5f-2258-4ab9-aac6-0d0e37ffbdb6
> dev_item.fsid        f99f2753-0283-4f93-8f5d-7a9f59f148cc [match]
> dev_item.type        0
> dev_item.total_bytes    83886080000
> dev_item.bytes_used    22624075776
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> 
> Thanks,
>    Dan
> --
> Daniel J Blueman


