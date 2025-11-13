Return-Path: <linux-btrfs+bounces-18963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A05C5A25A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 22:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3503B3BC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018232936C;
	Thu, 13 Nov 2025 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HBuvQvGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FA325714
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069595; cv=none; b=cKiow/tI5ieMTv+i7MizR52DNUe2j0dqZMkaslvFtpFCXAoixjM6TExZkKzpV/vGt84ZxKYig81vFJ+66MX2PoVbZfzeQbnekcdGYPyJXRHFLd3yv8GQJYK/OiW1GlMxLeaVHxhdnJe9g4BjaIwIRugxCVBCNfkPd4X8V2ah9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069595; c=relaxed/simple;
	bh=np+vk5ny2bYK/J1069dc49GCIMS8AbTomaCxcDLUlqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pS35TGgbaORxTYWuI6N9w+t5x53QZwrWHBj7tJsvuTXs7oXxZ7DAqKyfizMSo/6OxSWVUCOzUUJDNZt/3ssEhlzYCavg0ONvMEAD+gfCbxedrnT8yTwDPldiM3PIhqY7GvIg2z3z04hfaBMBsR4GWqXb11ExkxXxlLkeX0/2wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HBuvQvGu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso9072585e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763069592; x=1763674392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82CslIJMH4NtD4yMGdoweloKRKRZzvtMoYx7Z2BxtjY=;
        b=HBuvQvGunkab3wSma0IWz7bqvrih04nGX83rtv5boJIGIpDf54/SazYl0+v+dLS56k
         Q+XzvFfTK7BQx3bCPwzh66IaZAsh/IW3vNbgx0Bj0tUfW7rOQL3mF8kRp5kL6myBLgIo
         i7Yu3GxGzdjX/VOFQ0HAjDobQu0sn4ux80PO+2TI5/WT0XggxQ1lXcucK7Tw/2ttpigA
         0pV54qLTnlU/MEg/N57R/5lYe9De44iSPWd4Ygpr6hCBE+glOUi1irR3h3fOjPgUkDhJ
         HjHk1Mrz1N4fXg7ZiENnXwUE4OC7FPorDKL6LmWrv28jnZ5zL3MT98NqnvD/Clcih39Q
         E9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069592; x=1763674392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82CslIJMH4NtD4yMGdoweloKRKRZzvtMoYx7Z2BxtjY=;
        b=OvpA4LkWedz8nZmpqgRpB/6LslEeP5GhTRAHSMvbSWgDVEq+zG3U6iFNO1GOQmTyID
         hoQ0N0gPk+jUCmhiaObicYtCClye+jgW5vi8L5sCNQm8A36el6GQ/e3VfpNskrugDXJi
         FRHDILb0DUPZcfC2CaZaf46uc73bo8LU1rlFTzBUyinKp6Hn6dY/4rQlnf975A1hjt9y
         uwUGID/ROw1RpXd7Krm3LeNfIBdk2VHZiwGtnl6xtxfQ6Iui+aEnPeqQmS2xyX8b5guS
         BSnnvdtZcg9yTYl1hPtl+NEJOFXrP6tPxinnRCijagg5QGm0m9bwRi4VvQmigJ9b9fJv
         aXZg==
X-Forwarded-Encrypted: i=1; AJvYcCVIEAneuC7Uq6sPgUU2FQKISl7P6gsH1vzsVS4DxJ9suU8wxpugThUCXvci82b3oz1sptHeY7XCQJvsvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmyI+/Zx5ukUXnmN0qNkX1ZbdHwJn5gtBMBwFzhazLedAxk3R
	O9C4pLdHWk+S6yvcwCST8Jz0JSSWTBlUFeHo1k1CD57qRfsApUvMCsrizMVG9LLXA84=
X-Gm-Gg: ASbGnctmM5jUq4zkq47we7hXjdjjNKHJY/5nQI9C21Bk+8k9DeGijh+dtEleAdxd17c
	HDbEeOrkJbXBQhdL6I+9KUV2EDICSiPdF/MMmmYF/BFV/ZEO+4uho8LLwYze6V7ShteUVzZ6arW
	QTEjgLs6u6XcNPKfgmLV5JiFX4XOzTuP6LMCvmaE2Wnm6Y+r3EGRHFuNpyamANnWJfM7jl/0enJ
	vysFzsZhIKPkaRzjZ+ak3VrOCZa5BFBkZkBGFxTor3gFyIcOv9Ti7/bOSDxgO8a1rc3YY6h6886
	D2icwzhXVP+Q/vXA0DSZcHStKMyKfIBxmOqDAeXFkVkPQkc/s6/eAID8KD3FzVIVJ0CMu93ZD79
	8aj/0+aJB4KwIn11fTfP9S4HtIpwWsW2f2XvE4YrLnzlKdOn3u80xPNSTAKehQMgVU6bn51b+N3
	XSA0Q+ZyrgRgQpxlUpLMBI8Ze6YizB
X-Google-Smtp-Source: AGHT+IFL6vHCRHS9O9F/gskdlKph0HMYqCbjuv5R8XS85FM3NQvLnFi3jnD3xcwfhwTJJYI7q85SBg==
X-Received: by 2002:a05:600c:1d19:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-4778feadf96mr8736545e9.29.1763069591541;
        Thu, 13 Nov 2025 13:33:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf172sm35206785ad.83.2025.11.13.13.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 13:33:10 -0800 (PST)
Message-ID: <d84d8a70-bd78-4e49-965f-150a3c231d2a@suse.com>
Date: Fri, 14 Nov 2025 08:03:05 +1030
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
>>
>>
>> 9299051573d9 e8ea54f86241 cd93c0aad7e3
> 
> 9299051573d9 btrfs: enable encoded read/write/send for bs > ps cases
> e8ea54f86241 btrfs: make read verification handle bs > ps cases without large folios
> cd93c0aad7e3 btrfs: make btrfs_repair_io_failure() handle bs > ps cases without large folios
> 

I located the problem to be the patch "btrfs: raid56: remove sector_ptr 
structure", where I have a local fix not submitted to the mailing list.

And during the recent push into for-next branch, I'm again using the 
mailing list one, not the local fixed one, resulting 
btrfs_raid_bio::stripe_paddrs[*] to be assigned way beyond its boundary.

This makes us to randomly corrupt the memory, resulting weird results.

And the fix is pretty straightforward:

Bad:

+		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index] +
+						      offset_in_page(offset));

Good:

+		rbio->stripe_paddrs[i] = page_to_phys(rbio->stripe_pages[page_index]) +
+						      offset_in_page(offset);

Since offset_in_page() is involved, it only affects subpage systems.

I'll fold the fix into the offending patch.

Thanks for the report, and sorry for the bug.

Thanks,
Qu

