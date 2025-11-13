Return-Path: <linux-btrfs+bounces-18961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4ACC59EE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6109D3502CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 20:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A73148B6;
	Thu, 13 Nov 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FUFgmWBQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306630EF6E
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064899; cv=none; b=HIYCk9NI9vgMbPHbXNjYOpNMSJAYQrYf9SC1BigHKVJzgq6kcl5dVNpIn+EcuPMU1oTPc5TfTMMo1iH9I6wMXfpWaCNGYFQvDY3K1fO1aztWoBzq95T91zRkVogB56rBgM9ichKo0uinMGH4KwEKpLLk6XWY9ayS38dPVS1/xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064899; c=relaxed/simple;
	bh=Iokln6xv/zqCzNuTtOvyietZGl3Vo3v42vEE6tCkkeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glMNk7kkazrKhj8RigPtmF4l1DbpZsm1Q6bGDEaZdgwFIETWrsb8IuQXhZ1LWPZDr5Nu+A2IyEgjdf1u2eUfmTVFenD1vlqq3cRvSwSeNODGLQ+A73m61bp+xR676MZf9+vwL3KZ1NI5/KDewaVFcv2Y5HP0JTX2rHgjgb2dihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FUFgmWBQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso10991625e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763064895; x=1763669695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xJHquruVR9BqfKAfx53l9u+xauV84x5VK+oq8R758Ks=;
        b=FUFgmWBQ94QeLacJrG4QOrkGh2Zu4U/2fs0/ayoIok+sZFV9nLJ3luGrHIRW4MfMLW
         V4Fezyu/Sp2IR3mxcE3EN7hxCVNBCBrG7cfN8VMb9XkxH6CgghvOWHAAHIJ1kXd0zsQN
         DusIIAeU0QmNFSQ6C9ft6BDqYyTvnLIDgmWzXPwmJvDBf5IoxwLCNCSSRgvevDFv+jnP
         ZJ4PjPE/vHFtdFg7/Dlsom46dviYupMZBmRFQob/o9WA2Cxj2o2wwt72L3qajLrj+y/t
         tYickzsR4MjXPvowI6bY1qTYVUpFaKsl30WoYrE6V4NnRVoNUIUTft9SVOF3pL3MzAI7
         Nirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064895; x=1763669695;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJHquruVR9BqfKAfx53l9u+xauV84x5VK+oq8R758Ks=;
        b=Ugv0iFPO63m17wGyZzjrCzs4b7bi4XUNeowCApPLoRunqO1xIpp490wWyGKagCmWzL
         hxUP9Js8uRhir8u+3+YxyPZnfoivCMrtcTjRBstGcwDKr3uqJGn0xRBNFf8UCRjtBrvq
         U3vsXNaollAQGle8rNMkYHawqY75TTtKLbPOrpTE/Fv8VqSQzESF5DVz5W1vtJJTuAN6
         uFdIfae8ut3DJs3mtKwyIMd2+GNsTW/XtfysMTioTIElTgakSA58KmDw4la8qVW+6iWR
         qUeIC8CNsOPrDtWLv4FmeWngpS1lxzpb7+ip5SehxHTOJNjJvia5E9Jv2AkeltXfwy0O
         gkTg==
X-Forwarded-Encrypted: i=1; AJvYcCXt8iPMFPLmOLW1BCFvcItIylGrxDmVOPr7k0xRJQ6S5XVciGlLAMJN0qmOi6NvL6hXdkoQwi7X5zDEeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAgsz6O4NrE0+PvnkrMQLi4SjRGJvscIfhaED1m74uotxxM4c
	XA5plHOcMvNuglVIY1v57vzKaB0ovPPjBoCl0BCukbRpPhUi8+2VyAc6G9g4TQMIPEM=
X-Gm-Gg: ASbGnctKENlYraEXloPWwvQDZu0OT4ohusaIjSxxFRNn4t7uzJDyLWijLYa5ZvWPb9g
	evJYcIJtesyMzd37SKGarMxlbYJU2NDxVBMKeVRbjxdADLqs7xm9SWR0i41E4otjaUAcplN1YOM
	ooAF4apTegNiIjNahnK7EAtUipMJwiWRHSlq6TnmNUdPaB5yL2F1kk2eLr/+d1ovx3TmdXrzxFH
	dQRpdpG7CNEWqhrmMOIhcSpYZaPHW9MxU3YRl49YNdLQwyfvZrwtleeMnD/+p3cN5MQC0B0p6eO
	Cmxrjp7R+Pm+h6y4FpdBA5ZBx+I98Qmz2TspnG+Z/xmQV6S326zEllwVE8ZYPvWTedr30tFs4xG
	hF5rNXXX9dGuKi5IHv298VAt8ZL+qgMobMpnaSQhqqx2rDR6EfOHfuMCuKu7VgI8YUgTDx2xf7h
	jt/V4lUTkylDBOER5OUrK+luIjYnCCRN0leOru8jU=
X-Google-Smtp-Source: AGHT+IGfCk32tHqCL7SYjgxFGQtRASf+D+TZF7Bkb2lJVXy8ZisKnomrNnjS9IMIOPgvGH2WkTeaRg==
X-Received: by 2002:a05:600c:4895:b0:477:78db:19ca with SMTP id 5b1f17b1804b1-4778bcb36f7mr28759225e9.3.1763064895040;
        Thu, 13 Nov 2025 12:14:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea713fdfsm1990223a91.2.2025.11.13.12.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:14:54 -0800 (PST)
Message-ID: <e632b549-5898-48af-9859-10babd1a7f88@suse.com>
Date: Fri, 14 Nov 2025 06:44:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next20251112]Kernel OOPs while running btrfs/023 test case
To: dsterba@suse.cz, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: riteshh@linux.ibm.com, linux-btrfs@vger.kernel.org,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <83749167-c479-46df-a749-e3f65ffc3964@linux.ibm.com>
 <65b02403-25e5-4ec3-8577-de1409b0a765@linux.ibm.com>
 <20251113155107.GQ13846@twin.jikos.cz>
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
In-Reply-To: <20251113155107.GQ13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/14 02:21, David Sterba 写道:
> On Thu, Nov 13, 2025 at 06:47:43PM +0530, Venkat Rao Bagalkote wrote:
>> On 13/11/25 6:21 pm, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> IBM CI has reported a kernel crash while running btrfs/023 test from
>>> xfstest suite on IBM Power11 system.
>>>
>>>
>>> Traces:
>>> [  184.714500] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> devid 1 transid 8 /dev/loop1 (7:1) scanned by mkfs.btrfs (2697)
>>> [  184.714612] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> devid 2 transid 8 /dev/loop2 (7:2) scanned by mkfs.btrfs (2697)
>>> [  184.714731] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> devid 3 transid 8 /dev/loop3 (7:3) scanned by mkfs.btrfs (2697)
>>> [  184.714825] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> devid 4 transid 8 /dev/loop4 (7:4) scanned by mkfs.btrfs (2697)
>>> [  184.714918] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> devid 5 transid 8 /dev/loop5 (7:5) scanned by mkfs.btrfs (2697)
>>> [  184.720659] BTRFS info (device loop1): first mount of filesystem
>>> b8c762d5-3f1a-4020-bca9-2e7e107e5363
>>> [  184.720694] BTRFS info (device loop1): using crc32c (crc32c-lib)
>>> checksum algorithm
>>> [  184.720708] BTRFS info (device loop1): forcing free space tree for
>>> sector size 4096 with page size 65536
>>> [  184.725011] BTRFS info (device loop1): checking UUID tree
>>> [  184.725060] BTRFS info (device loop1): enabling ssd optimizations
>>> [  184.725068] BTRFS info (device loop1): turning on async discard
>>> [  184.725075] BTRFS info (device loop1): enabling free space tree
>>> [  184.735050] BUG: Unable to handle kernel data access at
>>> 0x6696fffdda1ea4c2
>>> [  184.735072] Faulting instruction address: 0xc0000000007bd030
>>> [  184.735087] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [  184.735101] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
>>> [  184.735118] Modules linked in: loop nft_fib_inet nft_fib_ipv4
>>> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
>>> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
>>> nf_defrag_ipv4 bonding tls ip_set rfkill nf_tables sunrpc nfnetlink
>>> pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi
>>> ibmveth scsi_transport_srp pseries_wdt
>>> [  184.735316] CPU: 22 UID: 0 PID: 1948 Comm: systemd-udevd Kdump:
>>> loaded Tainted: G    B               6.18.0-rc5-next-20251112 #1
>>> VOLUNTARY
>>> [  184.735342] Tainted: [B]=BAD_PAGE
>>> [  184.735352] Hardware name: IBM,9080-HEX Power11 (architected)
>>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>>> [  184.735369] NIP:  c0000000007bd030 LR: c0000000007bcef4 CTR:
>>> c000000000902824
>>> [  184.735386] REGS: c00000006fdb7910 TRAP: 0380   Tainted: G B
>>>        (6.18.0-rc5-next-20251112)
>>> [  184.735404] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
>>> 28004402  XER: 20040000
>>> [  184.735460] CFAR: c0000000007bcf98 IRQMASK: 0
>>> [  184.735460] GPR00: c0000000007bcef4 c00000006fdb7bb0
>>> c0000000026aa100 0000000000000000
>>> [  184.735460] GPR04: 0000000000000cc0 000000013470ff60
>>> 00000000000006f0 c0000009906ff4f0
>>> [  184.735460] GPR08: 669164fddb1e9c02 0000000000000800
>>> 000000098d420000 0000000000000000
>>> [  184.735460] GPR12: c000000000902824 c000000991e0e700
>>> 0000000000000000 0000000000000000
>>> [  184.735460] GPR16: 0000000000000000 0000000000000000
>>> 0000000000000000 0000000000000000
>>> [  184.735460] GPR20: 0000000000000000 0000000000000000
>>> 0000000000000000 0000000000000000
>>> [  184.735460] GPR24: 00000000000006ef 0000000000001000
>>> ffffffffffffffff c00c000000402680
>>> [  184.735460] GPR28: c0000000008f312c 0000000000000cc0
>>> 6696fffdda1e9cc2 c00000000701e880
>>> [  184.735688] NIP [c0000000007bd030] kmem_cache_alloc_noprof+0x4ac/0x708
>>> [  184.735711] LR [c0000000007bcef4] kmem_cache_alloc_noprof+0x370/0x708
>>> [  184.735729] Call Trace:
>>> [  184.735738] [c00000006fdb7bb0] [c0000000007bcef4]
>>> kmem_cache_alloc_noprof+0x370/0x708 (unreliable)
>>> [  184.735766] [c00000006fdb7c30] [c0000000008f312c]
>>> getname_flags.part.0+0x54/0x30c
>>> [  184.735793] [c00000006fdb7c80] [c0000000009028a0]
>>> sys_unlinkat+0x7c/0xe4
>>> [  184.735814] [c00000006fdb7cc0] [c000000000039d50]
>>> system_call_exception+0x1e0/0x450
>>> [  184.735839] [c00000006fdb7e50] [c00000000000d05c]
>>> system_call_vectored_common+0x15c/0x2ec
>>> [  184.735866] ---- interrupt: 3000 at 0x7fff9df366bc
>>> [  184.735881] NIP:  00007fff9df366bc LR: 00007fff9df366bc CTR:
>>> 0000000000000000
>>> [  184.735897] REGS: c00000006fdb7e80 TRAP: 3000   Tainted: G B
>>>        (6.18.0-rc5-next-20251112)
>>> [  184.735913] MSR:  800000000280f033
>>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004402  XER: 00000000
>>> [  184.735989] IRQMASK: 0
>>> [  184.735989] GPR00: 0000000000000124 00007fffe0b3a3a0
>>> 00007fff9e037d00 0000000000000006
>>> [  184.735989] GPR04: 000000013470ff60 0000000000000000
>>> 0000000000001000 00007fff9e0314b8
>>> [  184.735989] GPR08: 0000000000000271 0000000000000000
>>> 0000000000000000 0000000000000000
>>> [  184.735989] GPR12: 0000000000000000 00007fff9e8c4ca0
>>> 00000001161e5a78 00007fffe0b3ab10
>>> [  184.735989] GPR16: 0000000000000003 0000000000000000
>>> 00000001161aaed0 00000001161e9750
>>> [  184.735989] GPR20: 00007fffe0b3a780 00000001161eb260
>>> 00000001161eb320 0000000000000008
>>> [  184.735989] GPR24: 00000001347061c0 0000000000000000
>>> 0000000000000009 00000001347061c0
>>> [  184.735989] GPR28: 0000000000000006 00007fffe0b3a53c
>>> 0000000134715740 0000000000100000
>>> [  184.736216] NIP [00007fff9df366bc] 0x7fff9df366bc
>>> [  184.736231] LR [00007fff9df366bc] 0x7fff9df366bc
>>> [  184.736251] ---- interrupt: 3000
>>> [  184.736262] Code: f8610030 4082fccc 4bfffc28 2c3e0000 4182ff98
>>> 2c3b0000 4182ff90 60000000 3b40ffff 813f0030 e91f00c0 38d80001
>>> <7f7e482a> 7d3e4a14 79270022 552ac03e
>>> [  184.736362] ---[ end trace 0000000000000000 ]---
>>>
> 
> Thanks for the report.
> 
>> Mostly the issue got introduced by one of the below three commits. As
>> reverting these three, this issue is not seen.

Mind to share the block size of the fs? 4K or 64K?
>>
>>
>> 9299051573d9 e8ea54f86241 cd93c0aad7e3
> 
> 9299051573d9 btrfs: enable encoded read/write/send for bs > ps cases
> e8ea54f86241 btrfs: make read verification handle bs > ps cases without large folios
> cd93c0aad7e3 btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
> 

The problem looks weird, as for 64K page sized power11, there should be 
no path involved for bs > ps cases.

Thanks,
Qu

