Return-Path: <linux-btrfs+bounces-15818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3B4B195F3
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73457AB503
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3850221F39;
	Sun,  3 Aug 2025 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="THgSbwVQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED11D5CC6
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256019; cv=none; b=MTpKJ+KIfqouPTckXFUOczcqhnx1TWntlSw0w7vXxdLhQkRYs+a6bs8Z0+nscplqgTEKjVlZyNTo0AvQEUmyzgcaPTk+VJv07fKFeeMFkhY2Xrz4xTuaEyv3lynbxd09ScehNLEvk/4G1DSTje0YTueglAC+Qa2L4Osh8j6bOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256019; c=relaxed/simple;
	bh=aGuFeVRzry1IZqEZ0x/e1701On+VNRmKPWWJpmzJoVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mME+cg+Wg6iEx+2jfyf0E6hcPCN8J4BnqLJi2q22+pF0ufHQB6ZENLULrBTbvA//Jd6/ZcpVoWb40XkMTxIyvAGr5sSAK9/BGGDJ/r9g5gI4ubR1sZpDlkowFTzVPLcEs0j2uBIbzo/ko7IFwEWKyFORN5MsW5+A0MK7vg4iUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=THgSbwVQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454f428038eso31790985e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754256013; x=1754860813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TDOAMeFD8bYjAN0uhLjQebc+uwq5ZxwdQyCnS5OLhX4=;
        b=THgSbwVQ0ZeJRDBu0yl56uuiLKq0uPn67t6/XwYs0RS5lniAVjGe+gY6PnBHyNTJc4
         yzbBElmEyoT2mpn4mDBzOpVOpKhbAVwoFemxbd7gXftcexJGPMWJd662jPZn2k/PXWQ9
         +0ieUVcrGlV2w/uooyZXZjAyimzjOuP3aWEr4BCf1VgIX2FiwecebCpt+jlJHq93nist
         UfR1sJJEqeE45w38wkD+9rR8XBCKvzcqGbdUB/FEzp95G8l/aGmthZsBFvZDC28zc0Wz
         tCQFGaN5/pv65f2E+8NHzi5Jx0oYfqI6yCkWo1khT7dQAFZ+8erHAaOBMUHDLFPOsFxW
         2q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256013; x=1754860813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDOAMeFD8bYjAN0uhLjQebc+uwq5ZxwdQyCnS5OLhX4=;
        b=xTXfNyVsQwPtc9FsPwQIEpahza1MS60bNVDWDIizTLBgHs9Jsw/xnzwVkURH0dWUwX
         OiWkVXWLiuUObyXvmAx+GHLWv0hXSHfKC3IR8n+0Y4itsr8tIXVueQOgeMJvfKLAqHjA
         rw0cvi4nj5ZhNHtD0X5CU0CT2bdrLCAdwd1wsrFBZUOQD4/G2Mr3SCPH7UKrgXzHar94
         y+f7zFMZFdMLYQ5uIxyczqs4BE7HYw3zjKxFssmeOCwyfeDxBzp6X47cYC8cXlXLH+qU
         g+j+crF/I1/LU/R2FJN8sx6uMJJm0dFlx5kwJXbaXI3mNPqWp58UHl/yWUMUAPa8aaUV
         ZSdQ==
X-Gm-Message-State: AOJu0Yyqg7C8Ato7AR5n4drhK7R+TTQLy9X0/qEN1NKoCLDWk7bbUjAY
	sReeADAI45PR0zMkpFs1U+5byVpYXvT182P8I2RFkUk2627wriHYzadtYX1Za9f5cPM=
X-Gm-Gg: ASbGncv2qElzQrHnmw/XneQFCNkslVOkKUx7RYFgfBEZieBJaO3qb3l2Uhv3po+Ew4Q
	zrYASIxLZpOUHFya/KWH/z48mKIbPOTbpktKBi6ckQSoQTLK9eXdxIUb9NWZqWeRPjex14ctV3T
	qTK5Ulo2xSuN7HQlILNCSezLwu9MCgvGZ+pGE32v3OVt9yyCplmTGHP/r8Jg9jq74wIwH98gJoH
	YHBpqlOfHpnpLgDyZDqDZ17f3OOrg5eDJ0fYQgoXl2rJ3t6VECMTmpaLlFLPG9o3zNXEdA6pci+
	lw1eOWReUEpHUzKa1OJuupC2AUuR4tY75trFxLuQkinXaCnTevXF9lx39b7vdxCWQmgMARnRtTn
	BXNiteiT0W5fpM5i7sw4oxHn844MFUapMBpytphYZlSZ4QnjkKw==
X-Google-Smtp-Source: AGHT+IG2Ivj4SO+omN0ibCxH7paELvq9Es/Egc3zucOYk0tosH+2/0r4qU//ej5rmSTQqZkUTdTDow==
X-Received: by 2002:a05:6000:220f:b0:3b7:9629:ac9e with SMTP id ffacd0b85a97d-3b8d94ccbd8mr4382961f8f.50.1754256012633;
        Sun, 03 Aug 2025 14:20:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa33sm8891497b3a.43.2025.08.03.14.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 14:20:12 -0700 (PDT)
Message-ID: <f83bc50f-ed82-4ccb-b2cd-6270d8a8de26@suse.com>
Date: Mon, 4 Aug 2025 06:50:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Filesystem corrupted
To: Dave T <davestechshop@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
 <a9793ad6-1254-43d3-8a78-6bad7a27eaf1@gmx.com>
 <CAGdWbB4-4KkN_1P8WbnbkSM7mXfAh6CQhc8KHDHTvRFwA54hiQ@mail.gmail.com>
 <be2e4159-d8ae-4170-83c0-a79354cec001@gmx.com>
 <CAGdWbB7p3u5Hb9uxkS9u1mkZEmSOysuObHKd0F17m1Wgc0eTWA@mail.gmail.com>
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
In-Reply-To: <CAGdWbB7p3u5Hb9uxkS9u1mkZEmSOysuObHKd0F17m1Wgc0eTWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/4 04:28, Dave T 写道:
> Hi. Yes, it had faulty RAM. I now moved the storage device (a Samsung
> SSD 970 EVO Plus 2TB) to a server with Xeon CPUs & Samsung ECC RAM.

btrfs check please.

The bitflip damage is persistent, thus just moving to a healthy hardware 
won't solve the damage already done.

If the btrfs check only reports error in the extent tree for the 
involved bytenr, then you can run "btrfs check --repair".

But still recommended not to run "--repair" until you got some 
confirmation from developers.

Thanks,
Qu

> 
> Here is the output from dmesg when I attempt to mount the device. I
> will wait for your response before attempting any recovery steps. I
> can provide more info if needed. Thank you.
> 
> [Aug 3 14:35] BTRFS: device label mr10ut devid 1 transid 33588
> /dev/mapper/mr10utluks (253:4) scanned by mount (1482)
> [  +0.000592] BTRFS info (device dm-4): first mount of filesystem
> 05ddba03-0192-49e3-8cea-325ae3d1c500
> [  +0.000025] BTRFS info (device dm-4): using crc32c (crc32c-x86)
> checksum algorithm
> [  +0.000007] BTRFS info (device dm-4): using free-space-tree
> [  +0.058262] BTRFS info (device dm-4): last unmount of filesystem
> 05ddba03-0192-49e3-8cea-325ae3d1c500
> [Aug 3 14:36] BTRFS: device label mr10ut devid 1 transid 33588
> /dev/mapper/mr10utluks (253:4) scanned by mount (1504)
> [  +0.000531] BTRFS info (device dm-4): first mount of filesystem
> 05ddba03-0192-49e3-8cea-325ae3d1c500
> [  +0.000019] BTRFS info (device dm-4): using crc32c (crc32c-x86)
> checksum algorithm
> [  +0.000006] BTRFS info (device dm-4): using free-space-tree
> [  +0.061099] BTRFS info (device dm-4): last unmount of filesystem
> 05ddba03-0192-49e3-8cea-325ae3d1c500
> [Aug 3 14:41] BTRFS: device label mr10ut devid 1 transid 33588
> /dev/mapper/mr10utluks (253:4) scanned by mount (1531)
> [  +0.000449] BTRFS info (device dm-4): first mount of filesystem
> 05ddba03-0192-49e3-8cea-325ae3d1c500
> [  +0.000031] BTRFS info (device dm-4): using crc32c (crc32c-x86)
> checksum algorithm
> [  +0.000006] BTRFS info (device dm-4): using free-space-tree
> [Aug 3 14:42] ------------[ cut here ]------------
> [  +0.000005] WARNING: CPU: 15 PID: 1548 at
> fs/btrfs/extent-tree.c:3198 __btrfs_free_extent.isra.0+0x7cd/0xcc0
> [  +0.000011] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency intel_uncore_frequency_common sb_edac
> x86_pkg_temp_thermal intel_pow>
> [  +0.000062] CPU: 15 UID: 0 PID: 1548 Comm: btrfs-transacti Not
> tainted 6.15.8-arch1-2 #1 PREEMPT(full)
> 7b804d8109e142013e8263acc2bd1ff1b0003d09
> [  +0.000003] Hardware name: Supermicro Super Server/X10DAL-i, BIOS
> 3.2 11/26/2019
> [  +0.000003] RIP: 0010:__btrfs_free_extent.isra.0+0x7cd/0xcc0
> [  +0.000003] Code: 44 24 14 89 44 24 10 e9 5a fc ff ff 8d 45 01 41 39
> 46 40 0f 85 3c 02 00 00 41 89 6e 40 c7 44 24 18 02 00 00 00 e9 c0 fd
> ff ff <0f> 0b f0 >
> [  +0.000002] RSP: 0018:ffffd21c869a3c08 EFLAGS: 00010246
> [  +0.000002] RAX: ffff8ef862a7b000 RBX: 00000034e4da1000 RCX: 0000000000000001
> [  +0.000001] RDX: 0000000000000000 RSI: 00000000000000a9 RDI: ffff8ef842596690
> [  +0.000002] RBP: ffff8ef9068f0150 R08: 0000000000000000 R09: 0000000000000001
> [  +0.000001] R10: fffff3f686acd040 R11: 00000000ffffffff R12: 0000000000000000
> [  +0.000001] R13: 000000000006816a R14: ffff8ef8fda31a80 R15: ffff8ef90c3efa00
> [  +0.000002] FS:  0000000000000000(0000) GS:ffff8f3725cec000(0000)
> knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000001] CR2: 00007f3b7c39b070 CR3: 0000001b5d624002 CR4: 00000000003726f0
> [  +0.000016] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000005]  ? kmem_cache_free+0x40c/0x4d0
> [  +0.000007]  __btrfs_run_delayed_refs+0x2df/0xdf0
> [  +0.000003]  ? finish_task_switch.isra.0+0x99/0x2e0
> [  +0.000007]  ? __schedule+0x411/0x1330
> [  +0.000006]  btrfs_run_delayed_refs+0x43/0x100
> [  +0.000002]  ? start_transaction+0x152/0x830
> [  +0.000006]  btrfs_commit_transaction+0x69/0xca0
> [  +0.000003]  ? start_transaction+0x228/0x830
> [  +0.000002]  transaction_kthread+0x157/0x1c0
> [  +0.000003]  ? __pfx_transaction_kthread+0x10/0x10
> [  +0.000002]  kthread+0xfc/0x240
> [  +0.000004]  ? __pfx_kthread+0x10/0x10
> [  +0.000002]  ret_from_fork+0x34/0x50
> [  +0.000006]  ? __pfx_kthread+0x10/0x10
> [  +0.000002]  ret_from_fork_asm+0x1a/0x30
> [  +0.000007]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [  +0.000001] ------------[ cut here ]------------
> [  +0.000001] BTRFS: Transaction aborted (error -117)
> [  +0.000070] WARNING: CPU: 15 PID: 1548 at
> fs/btrfs/extent-tree.c:3199 __btrfs_free_extent.isra.0+0x7f0/0xcc0
> [  +0.000004] Modules linked in: intel_rapl_msr intel_rapl_common
> intel_uncore_frequency intel_uncore_frequency_common sb_edac
> x86_pkg_temp_thermal intel_pow>
> [  +0.000037] CPU: 15 UID: 0 PID: 1548 Comm: btrfs-transacti Tainted:
> G        W           6.15.8-arch1-2 #1 PREEMPT(full)
> 7b804d8109e142013e8263acc2bd1ff1b>
> [  +0.000002] Tainted: [W]=WARN
> [  +0.000001] Hardware name: Supermicro Super Server/X10DAL-i, BIOS
> 3.2 11/26/2019
> [  +0.000001] RIP: 0010:__btrfs_free_extent.isra.0+0x7f0/0xcc0
> [  +0.000002] Code: 00 00 e9 c0 fd ff ff 0f 0b f0 48 0f ba a8 70 0a 00
> 00 02 0f 82 ac c4 94 ff be 8b ff ff ff 48 c7 c7 48 e5 3d 98 e8 50 c3
> a7 ff <0f> 0b c6 >
> [  +0.000002] RSP: 0018:ffffd21c869a3c08 EFLAGS: 00010246
> [  +0.000001] RAX: 0000000000000000 RBX: 00000034e4da1000 RCX: 0000000000000027
> [  +0.000001] RDX: ffff8f36bf7dcbc8 RSI: 0000000000000001 RDI: ffff8f36bf7dcbc0
> [  +0.000002] RBP: ffff8ef9068f0150 R08: 0000000000000000 R09: 00000000ffffbfff
> [  +0.000001] R10: ffffffff99b77b40 R11: ffffd21c869a3aa0 R12: 0000000000000000
> [  +0.000001] R13: 000000000006816a R14: ffff8ef8fda31a80 R15: ffff8ef90c3efa00
> [  +0.000001] FS:  0000000000000000(0000) GS:ffff8f3725cec000(0000)
> knlGS:0000000000000000
> [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000001] CR2: 00007f3b7c39b070 CR3: 0000001b5d624002 CR4: 00000000003726f0
> [  +0.000001] Call Trace:
> [  +0.000001]  <TASK>
> [  +0.000002]  ? kmem_cache_free+0x40c/0x4d0
> [  +0.000003]  __btrfs_run_delayed_refs+0x2df/0xdf0
> [  +0.000003]  ? finish_task_switch.isra.0+0x99/0x2e0
> [  +0.000003]  ? __schedule+0x411/0x1330
> [  +0.000003]  btrfs_run_delayed_refs+0x43/0x100
> [  +0.000002]  ? start_transaction+0x152/0x830
> [  +0.000002]  btrfs_commit_transaction+0x69/0xca0
> [  +0.000003]  ? start_transaction+0x228/0x830
> [  +0.000003]  transaction_kthread+0x157/0x1c0
> [  +0.000002]  ? __pfx_transaction_kthread+0x10/0x10
> [  +0.000002]  kthread+0xfc/0x240
> [  +0.000002]  ? __pfx_kthread+0x10/0x10
> [  +0.000002]  ret_from_fork+0x34/0x50
> [  +0.000002]  ? __pfx_kthread+0x10/0x10
> [  +0.000002]  ret_from_fork_asm+0x1a/0x30
> [  +0.000004]  </TASK>
> [  +0.000001] ---[ end trace 0000000000000000 ]---
> [  +0.000002] BTRFS: error (device dm-4 state A) in
> __btrfs_free_extent:3199: errno=-117 Filesystem corrupted
> [  +0.000082] BTRFS info (device dm-4 state EA): forced readonly
> [  +0.000003] BTRFS info (device dm-4 state EA): leaf 253860970496 gen
> 33589 total ptrs 44 free space 7040 owner 2
> [  +0.000002]   item 0 key (227177136128 168 4096) itemoff 16165 itemsize 118
> [  +0.000003]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426314 offset 0 count 1
> [  +0.000003]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000002]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000002]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 1 key (227177140224 168 4096) itemoff 16047 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426315 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 2 key (227177144320 168 4096) itemoff 15929 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426316 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 3 key (227177148416 168 4096) itemoff 15811 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426317 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000002]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000002]   item 4 key (227177152512 168 4096) itemoff 15693 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426318 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000002]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 5 key (227177156608 168 4096) itemoff 15575 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426319 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000002]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 6 key (227177160704 168 4096) itemoff 15457 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426320 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 7 key (227177164800 168 4096) itemoff 15339 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426325 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000002]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 8 key (227177168896 168 4096) itemoff 15221 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426326 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540040192 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489888768 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355113984 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191386624 count 1
> [  +0.000001]           ref#5: shared data backref parent 253776723968 count 1
> [  +0.000001]   item 9 key (227177172992 168 4096) itemoff 15103 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426327 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000002]   item 10 key (227177177088 168 69632) itemoff 14985 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426328 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000002]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 11 key (227177246720 168 4096) itemoff 14867 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426329 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000002]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 12 key (227177250816 168 4096) itemoff 14749 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426330 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000002]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 13 key (227177254912 168 69632) itemoff 14631 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426334 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000002]   item 14 key (227177324544 168 69632) itemoff 14513 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000000]           ref#0: extent data backref root 490 objectid
> 426336 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 15 key (227177394176 168 69632) itemoff 14395 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426337 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000002]   item 16 key (227177463808 168 69632) itemoff 14277 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000000]           ref#0: extent data backref root 490 objectid
> 426338 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 17 key (227177533440 168 69632) itemoff 14159 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426339 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000002]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 18 key (227177603072 168 57344) itemoff 14041 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426340 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000002]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 19 key (227177660416 168 57344) itemoff 13923 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426341 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000002]   item 20 key (227177717760 168 77824) itemoff 13805 itemsize 118
> [  +0.000001]           extent refs 6 gen 135 flags 1
> [  +0.000000]           ref#0: extent data backref root 490 objectid
> 426342 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 266540023808 count 1
> [  +0.000001]           ref#2: shared data backref parent 266489905152 count 1
> [  +0.000001]           ref#3: shared data backref parent 266355130368 count 1
> [  +0.000001]           ref#4: shared data backref parent 254191403008 count 1
> [  +0.000001]           ref#5: shared data backref parent 253777035264 count 1
> [  +0.000001]   item 21 key (227177795584 168 61440) itemoff 13596 itemsize 209
> [  +0.000001]           extent refs 13 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426346 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent
> 18014665013673984 count 1
> [  +0.000001]           ref#2: shared data backref parent 267180048384 count 1
> [  +0.000002]           ref#3: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#4: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#5: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#6: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#7: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#8: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000002]           ref#11: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#12: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 22 key (227177857024 168 77824) itemoff 13348 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426347 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000002]   item 23 key (227177934848 168 77824) itemoff 13100 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426348 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000002]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000002]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000002]   item 24 key (227178012672 168 77824) itemoff 12852 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426349 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000002]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 25 key (227178090496 168 77824) itemoff 12604 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426350 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000002]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000002]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 26 key (227178168320 168 77824) itemoff 12356 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426351 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000002]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000002]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000002]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000002]   item 27 key (227178246144 168 5492736) itemoff 12108
> itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426352 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000002]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 28 key (227183738880 168 1945600) itemoff 11860
> itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426353 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000002]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 29 key (227185684480 168 5492736) itemoff 11612
> itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426354 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000002]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000002]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 30 key (227191177216 168 1945600) itemoff 11364
> itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426355 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000009]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000002]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 31 key (227193122816 168 77824) itemoff 11116 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426356 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000002]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000002]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000002]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 32 key (227193200640 168 77824) itemoff 10868 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426357 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000002]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000002]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000002]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 33 key (227193278464 168 102400) itemoff 10620 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426358 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000002]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000002]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 34 key (227193380864 168 77824) itemoff 10372 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426359 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000002]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000002]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 35 key (227193458688 168 77824) itemoff 10124 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426360 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000002]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000002]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 36 key (227193536512 168 102400) itemoff 9876 itemsize 248
> [  +0.000002]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426364 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000002]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 37 key (227193638912 168 57344) itemoff 9628 itemsize 248
> [  +0.000002]           extent refs 16 gen 135 flags 1
> [  +0.000000]           ref#0: extent data backref root 490 objectid
> 426366 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000002]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 38 key (227193696256 168 102400) itemoff 9380 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426367 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000002]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000002]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 39 key (227193798656 168 73728) itemoff 9132 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426368 offset 0 count 1
> [  +0.000002]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000002]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000002]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 40 key (227193872384 168 155648) itemoff 8884 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426369 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000002]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000002]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 41 key (227194028032 168 372736) itemoff 8636 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426370 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180048384 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147673600 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079155712 count 1
> [  +0.000001]           ref#4: shared data backref parent 266967482368 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640375808 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567467008 count 1
> [  +0.000002]           ref#7: shared data backref parent 266540056576 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504192000 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489921536 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355146752 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357405696 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230609920 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217502720 count 1
> [  +0.000002]           ref#14: shared data backref parent 254191419392 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777068032 count 1
> [  +0.000001]   item 42 key (227194400768 168 372736) itemoff 8388 itemsize 248
> [  +0.000002]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426375 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180081152 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147689984 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079172096 count 1
> [  +0.000002]           ref#4: shared data backref parent 266967515136 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640392192 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567483392 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540072960 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504208384 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489937920 count 1
> [  +0.000002]           ref#10: shared data backref parent 266355163136 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357438464 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230626304 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217519104 count 1
> [  +0.000001]           ref#14: shared data backref parent 254191435776 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777051648 count 1
> [  +0.000001]   item 43 key (227194773504 168 61440) itemoff 8140 itemsize 248
> [  +0.000001]           extent refs 16 gen 135 flags 1
> [  +0.000001]           ref#0: extent data backref root 490 objectid
> 426378 offset 0 count 1
> [  +0.000001]           ref#1: shared data backref parent 267180081152 count 1
> [  +0.000001]           ref#2: shared data backref parent 267147689984 count 1
> [  +0.000001]           ref#3: shared data backref parent 267079172096 count 1
> [  +0.000002]           ref#4: shared data backref parent 266967515136 count 1
> [  +0.000001]           ref#5: shared data backref parent 266640392192 count 1
> [  +0.000001]           ref#6: shared data backref parent 266567483392 count 1
> [  +0.000001]           ref#7: shared data backref parent 266540072960 count 1
> [  +0.000001]           ref#8: shared data backref parent 266504208384 count 1
> [  +0.000001]           ref#9: shared data backref parent 266489937920 count 1
> [  +0.000001]           ref#10: shared data backref parent 266355163136 count 1
> [  +0.000001]           ref#11: shared data backref parent 254357438464 count 1
> [  +0.000001]           ref#12: shared data backref parent 254230626304 count 1
> [  +0.000001]           ref#13: shared data backref parent 254217519104 count 1
> [  +0.000002]           ref#14: shared data backref parent 254191435776 count 1
> [  +0.000001]           ref#15: shared data backref parent 253777051648 count 1
> [  +0.000001] BTRFS critical (device dm-4 state EA): unable to find
> ref byte nr 227177795584 parent 266504192000 root 490 owner 426346
> offset 0 slot 22
> [  +0.000087] BTRFS error (device dm-4 state EA): failed to run
> delayed ref for logical 227177795584 num_bytes 61440 type 184 action 2
> ref_mod 1: -2
> [  +0.000083] BTRFS: error (device dm-4 state EA) in
> btrfs_run_delayed_refs:2154: errno=-2 No such entry
> 
> On Tue, Sep 24, 2024 at 2:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/9/24 15:57, Dave T 写道:
>>> [  +0.000001] ---[ end trace 0000000000000000 ]---
>> [...]
>>> [  +0.000003]   item 21 key (227177795584 168 61440) itemoff 13596 itemsize 209
>>> [  +0.000003]           extent refs 13 gen 135 flags 1
>>> [  +0.000002]           ref#0: extent data backref root 490 objectid
>>> 426346 offset 0 count 1
>>> [  +0.000003]           ref#1: shared data backref parent
>>> 18014665013673984 count 1
>>> [  +0.000003]           ref#2: shared data backref parent 267180048384 count 1
>>> [  +0.000003]           ref#3: shared data backref parent 267147673600 count 1
>>> [  +0.000003]           ref#4: shared data backref parent 267079155712 count 1
>>> [  +0.000002]           ref#5: shared data backref parent 266967482368 count 1
>>> [  +0.000003]           ref#6: shared data backref parent 266640375808 count 1
>>> [  +0.000003]           ref#7: shared data backref parent 266567467008 count 1
>>> [  +0.000003]           ref#8: shared data backref parent 266540056576 count 1
>>> [  +0.000003]           ref#9: shared data backref parent 266489921536 count 1
>>> [  +0.000002]           ref#10: shared data backref parent 266355146752 count 1
>>> [  +0.000003]           ref#11: shared data backref parent 254191419392 count 1
>>> [  +0.000003]           ref#12: shared data backref parent 253777068032 count 1
>>
>> Above the is the offending slot of the bytenr.
>>
>> At ref#1, the slot has bytenr 18014665013673984, but our target is
>> 266504192000.
>>
>> hex(18014665013673984) = 0x40003e0ce34000
>> hex(266504192000)      = 0x00003e0ce34000
>>
>> This is a strong indication of bitflip.
>>
>> Thus it's strongly recommended to do a memtest before doing anything.
>> Please report back about the memtest result.
>>
>> Thanks,
>> Qu
>>
>>>>>        [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
>>>>> find ref byte nr 227177795584 parent 266504192000 root 490 owner>
>>>>>        [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
>>>>> delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
>>>>>        [  +0.000017] BTRFS: error (device dm-3 state EA) in
>>>>> btrfs_run_delayed_refs:2207: errno=-2 No such entry
>>>>>
>>>>> The drive is a Samsung SSD 970 EVO Plus 2TB.
>>>>>
>>>>> Overall:
>>>>>        Device size:                   1.82TiB
>>>>>        Device allocated:           300.04GiB
>>>>>        Device unallocated:            1.53TiB
>>>>>        Device missing:                  0.00B
>>>>>        Device slack:                    0.00B
>>>>>        Used:                        299.07GiB
>>>>>        Free (estimated):              1.53TiB      (min: 1.53TiB)
>>>>>        Free (statfs, df):             1.53TiB
>>>>>        Data ratio:                       1.00
>>>>>        Metadata ratio:                   1.00
>>>>>        Global reserve:              398.55MiB      (used: 16.00KiB)
>>>>>        Multiple profiles:                  no
>>>>>
>>>>> Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
>>>>>       /dev/mapper/userluks  298.01GiB
>>>>>
>>>>> Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
>>>>>       /dev/mapper/userluks    2.00GiB
>>>>>
>>>>> System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
>>>>>       /dev/mapper/userluks   32.00MiB
>>>>>
>>>>> What is the recommended course of action given this error?
>>>>>
>>>>> What other info do I need to share, if any?
>>>>>
>>>>> Thank you!
>>>>>
>>>>
>>
> 


