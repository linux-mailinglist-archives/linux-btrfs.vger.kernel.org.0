Return-Path: <linux-btrfs+bounces-12972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BAA87506
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961FD188F4EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 00:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F7148832;
	Mon, 14 Apr 2025 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aizau6zu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73E79D2
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 00:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744590930; cv=none; b=Szpd8E36nIsP/qxo6dOP+9RgLcZ3BPszLMFK4eXh6ZhJW7fNGMPQ5wFPKVQSlc1n5udRRMCPLJSMrOMtKpt++MfCZLDlr4DUhIqirF2ttv76VRkz0pr3DZWBHb4XyDNbuzdcF57NLCNkhqjebrfXUnK2D5xh7211L1YCCZCOX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744590930; c=relaxed/simple;
	bh=/SSdxkKwhbtn8+J/b/GSrjymFERHECq3rsnDvGdMMMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XouDi5KQZRLbk/ZrsF05ksUAEWF5Bny4Lnpl1bv3QFbzUywpciUgR6HiAwdSFi419KSCy+i1MXIcHXhTn1SeguVcqax6ImwIGBBY8gbxOgYUM7Vst5S0upAATxB8x5ZLaSfN8AcIIiy4r7S03EhSne2FsB7B0YTw/423f4zUsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aizau6zu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39d83782ef6so3007893f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744590926; x=1745195726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nJQL47ulVAXQrTMo1PjFlux45v+Ume8Jnv9m7/rkOFI=;
        b=Aizau6zukCzKrHqzkWPtaSBG/LWh/LzTmT/l36PNdw2mwYZ/X67yqCRLtPEN2Mb7CG
         i5vrTvX14WKVoiDw+SkrKCTh2qB5vDI/uUzk0UR+MYVl/Nus1B3vNYuuzQg2FvhuWfhn
         DLSQNwyrnWAYsAVgH27rKyUxEGuMk6ZAKhPL+7ZIrMoZfQBSN+1nMFcdDaE4uPqIfUv2
         Mb2a0plwWbvMgLJmfd3RYdBrwBTchjeQEwK23s2xgxf32JMg1nwkDNXElbMuxTw2T03g
         o8/ePdqgA+ofwp/JfgbW9KKltcJszM28i+QM3B8v3NZYzcgUIH0CSBUgQiS0myNvON3Y
         7ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744590926; x=1745195726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJQL47ulVAXQrTMo1PjFlux45v+Ume8Jnv9m7/rkOFI=;
        b=xUo77p/eKaxiBNVyojb9yQC3nCiS332H6NBY6DeIZVHqzEYJH+MjfAQfughSA/fMoC
         NKdI8iK4Gu2deOlznjAOKt/drmV0OaFGXCEA8Zq/8KfLvQOBph2jXH5gZtYngAddAlvq
         QuiVNVBStikaRN0lNYOtkISctV7WdWGbh2i8XfRuMMwo7Wun8F8UWDQUp3UlhvpeqW5h
         wAZ665JzG6Kz+eL7BdLL0vhFeHjPstaXMre1nDBTkoYiLT2zTCMVMuTO3qbMxPf+ix4H
         hrtFtQWesqALRG0LM6bxsZ1Qgf4u0GVpHEuXyEfJEdogx1k/Sbtyb88A5+NDyopbrNU3
         IWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNw5MjdhntelLzBsUMbyx5lldHKsVLiGXEc05KBdEUIEhZ6TWCSjNW9uZu4WW9zuWfPMzem73jZwh7AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+H/QKIoc5jZsAgOD0omj25xSwx8HkfXz72mQ0ZfaXD+DNWTT
	1FV2j3p2kxhSV1eBXgCxjQn7Tl1+gSxXGaLQtZntzUNun2VAgAf+D67BCq+QqvwAkCMOhPRhyX9
	x
X-Gm-Gg: ASbGnct/NlKuzEtHrmMVZ1moQl18EZwO3AWDPq5RPof4fhy7fuIqiQ7W7Gu+ffkenqf
	zEPRrUivquT35BToBEPQE/QyJBgXO2Rf7ZEkq8i9x17SHBP2Ezhe7Fo1MVNenKUXXgzKNHhlaEI
	4eXl1sY6zxnOjG2lMvcAET1juj6MM+h57h5K3Kbl/zKPIe3KOzNWzLrCPCe0/I67ehTftmf2V7w
	d8IKrprb3sU8F9OgY+ho+iGS/3zkKszBbf1suGjbusfZHrEvgJHK0Og64QxJTFpvYuioh90b1rX
	rVOl/kPue0GVJO3PK3UpZSuYu/ht1UUJq6pDCutm0CbL8Y2M9UTd9tQTtRI4XCORCNj+
X-Google-Smtp-Source: AGHT+IFDaGjRHyvg5tvrLWMXF0vTh8pRf+QR7105t+BkkxNRCwW3hUNiPlugWrB9+zMdjrm7DnvGuw==
X-Received: by 2002:a05:6000:1acb:b0:39c:12ce:1112 with SMTP id ffacd0b85a97d-39d8f4c9638mr12734232f8f.21.1744590925474;
        Sun, 13 Apr 2025 17:35:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628c4sm89008595ad.27.2025.04.13.17.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 17:35:24 -0700 (PDT)
Message-ID: <17cd9240-99eb-49e1-8843-0a80a18f8ac2@suse.com>
Date: Mon, 14 Apr 2025 10:05:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests generic/619] hang on aarch64 with btrfs
To: Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org
References: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/13 22:23, Zorro Lang 写道:
> Hi,
> 
> Recently I ran fstests on aarch64 with btrfs (default options), then I the test
> was always blocked on generic/619:
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/aarch64 nvidia-grace-hopper-02 6.15.0-rc1+ #1 SMP PREEMPT_DYNAMIC Sun Apr 13 01:44:03 EDT 2025

Mind to provide the kernel config? Especially the page size.

I guess since you're running on nvidia SoCs, they are pushing 64K page 
size already.

At least on my aarch64 (our for-next branch, based on v6.14-rc7), I 
didn't hit any hang here.
Neither any hang in my older runs on aarch64.

And my test is done with 64K page size and default mkfs options (4K fs 
block size, 16K node size).

>    MKFS_OPTIONS  -- /dev/sda6
>    MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/xfstests/scratch
> 
>    generic/619
>    (can't be end even 2 days)
> 
> The console log as [1], .full output as [2], Show Blocked State as [3]. This
> test is good on x86_64. Currently I reproduced this issue on aarch64 5 times
> on linux v6.14 and v6.15-rc1+(current latest).
> 
> Thanks,
> Zorro
> 
[...]
> [-- MARK -- Sun Apr 13 06:10:00 2025]
> [-- MARK -- Sun Apr 13 06:15:00 2025]
> [-- MARK -- Sun Apr 13 06:20:00 2025]
> [ 1512.501008] nvme nvme0: using unchecked data buffer
> [ 1512.524807] block nvme0n1: No UUID available providing old NGUID
> [-- MARK -- Sun Apr 13 06:25:00 2025]
> [-- MARK -- Sun Apr 13 06:30:00 2025]
> [-- MARK -- Sun Apr 13 06:35:00 2025]
> ...
> ...
> [-- MARK -- Sun Apr 13 12:25:00 2025]
> [-- MARK -- Sun Apr 13 12:30:00 2025]
> ...
> ...
> 
> [2]
> ============ Test details start ============
> Test name: Small-file-fallocate-test
> File ratio unit: 524288
> File ratio: 1
> Disk saturation 0.7
> Disk alloc method 1
> Test iteration count: 3
> Extra arg:  -f -v
> btrfs-progs v6.14
> See https://btrfs.readthedocs.io for more information.
> 
> Performing full device TRIM /dev/sda6 (240.00MiB) ...
> NOTE: several default settings have changed in version 5.15, please make sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
> 
> Label:              (null)
> UUID:               d47723ad-8c22-4fda-bc03-e4b066d65949
> Node size:          4096
> Sector size:        4096        (CPU page size: 4096)
> Filesystem size:    240.00MiB
> Block group profiles:
>    Data+Metadata:    single            8.00MiB
>    System:           single            4.00MiB
> SSD detected:       yes
> Zoned device:       no
> Features:           mixed-bg, extref, skinny-metadata, no-holes, free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  PATH
>      1   240.00MiB  /dev/sda6
> 
> ===== Test: Small-file-fallocate-test iteration: 1 starts =====
> Total available size: 246382592
> Available size: 172467814.4
> Thread count: 328
> Testing with (328) threads
> size: 524288 Bytes
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-1 fsize 524288, id 1
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-0 fsize 524288, id 0
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-3 fsize 524288, id 3
> ...
> ...
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-241 fsize 524288, id 241
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-185 fsize 524288, id 185
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-244 fsize 524288, id 244
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-246 fsize 524288, id 246
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-243 fsize 524288, id 243
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-248 fsize 524288, id 248
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-247 fsize 524288, id 247
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-74 fsize 524288, id 74
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-277 fsize 524288, id 277
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-72 fsize 524288, id 72
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-131 fsize 524288, id 131
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-281 fsize 524288, id 281
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-282 fsize 524288, id 282
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-278 fsize 524288, id 278
> Test write phase starting file /mnt/xfstests/scratch/mmap-file-101 fsi
> (no more)
> 
> 
> [3]
> # ps aux|grep enospc
> root       61679 20.1  0.0 2873604 17524 ?       Sl   02:05  78:36 /var/lib/xfstests/src/t_enospc -t 328 -s 524288 -r 1 -p /mnt/xfstests/scratch -v
> root       71571  0.0  0.0   6192  1788 pts/0    S+   08:34   0:00 grep --color=auto enospc
> [root@nvidia-grace-hopper-02 ~]# cat /proc/
> Display all 921 possibilities? (y or n)
> [root@nvidia-grace-hopper-02 ~]# cat /proc/61679/stack
> [<0>] futex_wait_queue+0x104/0x210
> [<0>] __futex_wait+0x184/0x268
> [<0>] futex_wait+0xf4/0x2c8
> [<0>] do_futex+0x17c/0x240
> [<0>] __arm64_sys_futex+0x1d8/0x308
> [<0>] invoke_syscall.constprop.0+0xdc/0x1e8
> [<0>] do_el0_svc+0x154/0x1d0
> [<0>] el0_svc+0x54/0x140
> [<0>] el0t_64_sync_handler+0x10c/0x138
> [<0>] el0t_64_sync+0x1ac/0x1b0
> # echo w > /proc/sysrq-trigger
> # dmesg
> [23843.226599] sysrq: Show Blocked State
> [23843.227353] task:t_enospc        state:D stack:24272 pid:61684 tgid:61679 ppid:59176  task_flags:0x400040 flags:0x00000204
> [23843.227368] Call trace:
> [23843.227371]  __switch_to+0x1f8/0x328 (T)
> [23843.227381]  __schedule+0x734/0x1428
> [23843.227384]  schedule+0xd0/0x240
> [23843.227386]  handle_reserve_ticket+0x470/0x820 [btrfs]
> [23843.227474]  __reserve_bytes+0x54c/0xb40 [btrfs]
> [23843.227536]  btrfs_reserve_metadata_bytes+0x2c/0xf8 [btrfs]
> [23843.227593]  btrfs_delalloc_reserve_metadata+0x2b0/0x660 [btrfs]
> [23843.227650]  btrfs_delalloc_reserve_space+0x70/0x150 [btrfs]
> [23843.227705]  btrfs_page_mkwrite+0x3fc/0xcb0 [btrfs]
> [23843.227767]  do_page_mkwrite+0x13c/0x2a8
> [23843.227774]  do_wp_page+0x2c4/0x10e0
> [23843.227778]  handle_pte_fault+0x578/0x7c0
> [23843.227780]  __handle_mm_fault+0x2e8/0xa70
> [23843.227783]  handle_mm_fault+0x20c/0x8a8
> [23843.227785]  do_page_fault+0x26c/0x1050
> [23843.227790]  do_mem_abort+0x70/0x1c0
> [23843.227794]  el0_da+0x5c/0x150
> [23843.227797]  el0t_64_sync_handler+0xc4/0x138
> [23843.227800]  el0t_64_sync+0x1ac/0x1b0

There are too many processes blocked and it looks like the dmesg buffer 
has over flown already.

If you can reproduce it reliably, mind to do a manual run, and with 
background "top" checking for CPU usages, as long as you believe the 
hang happened, "echo w > /proc/sysrq-trigger", then the dmesg may be 
more helpful.

On my aarch64, the run only takes around 7 seconds, so after 10 seconds 
without any CPU activities, the call trace should be minimal and may 
expose the root cause.

Thanks,
Qu


