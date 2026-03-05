Return-Path: <linux-btrfs+bounces-22241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLTSGL0HqWlW0QAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22241-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 05:34:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72B20AD5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 05:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43053063D56
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 04:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEEC212548;
	Thu,  5 Mar 2026 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CUk16eUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEB286A4
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685193; cv=none; b=G07mGwQnTcvuJ4GxtO3WOqcUVt/4FtMeaxHvyDHT4/6uk5321RMOr/TjcyolYcr15ingLiu8T5c9xBl8EaM/DjwZuLmn+fu70NIJ+5rIEAKW1FAIt7LEX7QmyaXbSzaR6KA1tOh4SKH+/6Uc0iCp1RG7MfYKVVtkjXjrm1Fd3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685193; c=relaxed/simple;
	bh=UmqTvmR3jfuncTcqPmf8rI8T9WI6RpR0VFWHOtEyBkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ach5JSpvWMfC3dRF8gjr/+oJWgoJxsB98Q6T4bltQoUz51w8vjj6s88yVABpyrwdZxORyhEZA9r80X/3skbW/65N3Enks+3o3k7eXEFdZA0A+n6pnron8H9IlPdA8uny1DekDh+ujwnRIpYuWdW6qh4GssUHYda+YnZ4AmaMf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CUk16eUN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so86010075e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 20:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772685190; x=1773289990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mVhmo+I/YGNi8YFec693o8S5zjbgSBAqzyi3hU/aHLc=;
        b=CUk16eUN/sFjA2GDhO2ueYdWsGP+z4vG50uek/gr38cx8LL7bVAoL3hLmWUSibmYP+
         89PzGz09gWnyOTvIA1CiGDo7TLxAEzpt6uYLPIoH0IO2kC7PZKeq1Fm0aVYWqyCSJZVa
         wKr/e9rHf+BVlZC6OfSYALWzQHiLAQ5cBZEw5ky9I0lIswDMB+OgBaSIPaiO59Ptee1t
         /2QHEGGUCziYeQPYlawoh7Bsp85/JkMJoJNFnfrU65V21cxZJ1VAClOhKFMaAOhvhBo7
         xMcTvRYXS6vu0UuJ1+eW3xgG/45xdC/s+nVr12SSpl8Ma2EkOvQOAvXk4T2Hl/FLMaen
         j1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685190; x=1773289990;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVhmo+I/YGNi8YFec693o8S5zjbgSBAqzyi3hU/aHLc=;
        b=P6FzuGtnKa4iHjN5nGv3XL1rOF+Mp1mzWMhGt8EM+bR6H6U9jHi5GK3MNUXn/0wzUf
         Bqrf24mtFjIXTZ6x69FpxND0B1XESsspQBcwjiTuxvksOdoB+BeoD8uk7FZ+Yu42+7Wr
         Tx8WnFzSbETpAw+B5V7gmkQ5qar03TcVyQ+hbw6KxwPGVLz6dHYzf31tL31UR5BdSOns
         LqIrnaWuqIGq1hfdSnxgp+M4+05xdusa/5FCCujUPYtEe5jPwucph4l9JHYnKTpfO1DH
         EJeh8PYzDijQPkjTqa5BFG7zAjMzRBbkt/FU07ZAWl9RbKxp+WtRJcDhy+e+4rE4wiB/
         +1mA==
X-Gm-Message-State: AOJu0YwoH0y3JViT06yMSyGg9AcqBWkNFRGNdqmSKYf6BzfR74KH5oSc
	rxeTOhtF03xmpRjs6Lskq9h0GeUsKkSnIdRvwC+wK3sxkz81v2f+2X5fnMj+0/2xX9nod9VAdEZ
	oJUJXn2Y=
X-Gm-Gg: ATEYQzxFFxv4xsrTG3sJ2O2wwkQoTWeoBZPVlFP+eBdw54G7EDC8md9zTxJZts3a1Vj
	X+VJ/tH/GaqcC1pVNp7jn+8HrBxSmrrMbxQqfBPiONCX364ZUoX/q67DLB1OUCeAeGu3UuP3c3R
	xpmPsUW5zXkmsIMnr3O/ujjhKSHh49xBUhY6CgN4tPiRUsS/m6BmQmYVglWpNAaEmcF0JdlQ+jc
	9cvxfpRFG9gwmEHMM3031OdgVss4rDzPE/Cwjbh/nuAlk3RDUNP24aR5R3gE327DNCP6qLeDeyN
	/HwjTYYb5a288+11pkX2+8lF/+ysfLyQIitM8Ao1G3zbIZPzvgZxFPFzKnImiHXCZJFpzuxczOK
	WHfCJ00bqkrRkG4S5N9S4wmFOInlAi4F8fw5koNlD0bn4QDzXt7P4rxtKp7yGCQlCELhX6/7c50
	IATBLKarqY5O6/8jpgUspO2cNp2njAR8GvaVX1akPTDws59D1BNBk=
X-Received: by 2002:a05:600c:1c21:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-48519866866mr78571295e9.15.1772685189779;
        Wed, 04 Mar 2026 20:33:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a929f854sm1032407a91.5.2026.03.04.20.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 20:33:08 -0800 (PST)
Message-ID: <a6652fe0-0ab5-4301-9c82-bc992a9bb3a0@suse.com>
Date: Thu, 5 Mar 2026 15:03:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
 <20260305025611.GC5735@twin.jikos.cz> <20260305030911.GD5735@suse.cz>
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
In-Reply-To: <20260305030911.GD5735@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E72B20AD5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22241-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



在 2026/3/5 13:39, David Sterba 写道:
> On Thu, Mar 05, 2026 at 03:56:11AM +0100, David Sterba wrote:
>> On Mon, Mar 02, 2026 at 06:30:30PM +1030, Qu Wenruo wrote:
>>> And hopefully this will address David's recent crash (as usual I'm not
>>> able to reproduce locally).
>>
>> I'll run the test with this patch.
> 
> Still crashes so the lru is a false hunch.

Mind to try this branch again?

https://github.com/adam900710/linux/tree/debug

It has only one patch beyond for-next, which adds several trace_printk() 
related to zlib compression.

My current guess is, zlib compression can add a folio into the bio, but 
later called folio_put() on that folio, resulting the problem.

The problem is I do not have any clue just staring at the code.

Also, please enable "kernel.ftrace_dump_on_oops = 1" sysctl so that at 
crash the ftrace buffer will also be dumped into dmesg.
Finally this ftrace can result lengthy output, and the default buffer is 
very large.

Recommended to use "trace-cmd set -b 2" to limit the buffer to 2KiB per CPU.

Thanks,
Qu

> 
> [  110.693070] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888100000000 pfn:0x111262
> [  110.694052] flags: 0x4000000000000000(node=0|zone=2)
> [  110.694596] raw: 4000000000000000 ffffea00040f2008 ffffea00042088c8 0000000000000000
> [  110.695383] raw: ffff888100000000 0000000000000000 00000000ffffffff 0000000000000000
> [  110.696164] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> [  110.696925] ------------[ cut here ]------------
> [  110.697414] kernel BUG at ./include/linux/mm.h:1493!
> [  110.697955] Oops: invalid opcode: 0000 [#1] SMP KASAN
> [  110.698482] CPU: 8 UID: 0 PID: 12 Comm: kworker/u64:0 Not tainted 7.0.0-rc1-default+ #626 PREEMPT(full)
> [  110.699385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
> [  110.700464] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> [  110.701110] RIP: 0010:btrfs_compress_bio+0x5c2/0x6a0 [btrfs]
> [  110.702716] RSP: 0018:ffff8881003b79a0 EFLAGS: 00010286
> [  110.703082] RAX: 000000000000003e RBX: ffff88810a83d5f8 RCX: 0000000000000000
> [  110.703550] RDX: 000000000000003e RSI: 0000000000000004 RDI: ffffed1020076f27
> [  110.704019] RBP: 1ffff11020076f37 R08: ffffffff8a444651 R09: fffffbfff195c438
> [  110.704484] R10: 0000000000000003 R11: 0000000000000001 R12: ffffea00044498c0
> [  110.704956] R13: ffffea00044498b4 R14: 0000000000000000 R15: ffffea0004449880
> [  110.705555] FS:  0000000000000000(0000) GS:ffff88818baa0000(0000) knlGS:0000000000000000
> [  110.706197] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  110.706664] CR2: 00007f4aa3c715a0 CR3: 0000000097a59000 CR4: 00000000000006b0
> [  110.707131] Call Trace:
> [  110.707335]  <TASK>
> [  110.707522]  ? btrfs_compress_filemap_get_folio+0x130/0x130 [btrfs]
> [  110.707999]  ? _raw_spin_unlock+0x1a/0x30
> [  110.708307]  ? btrfs_compress_heuristic+0x48c/0x700 [btrfs]
> [  110.708766]  compress_file_range+0x7b7/0x1640 [btrfs]
> [  110.709169]  ? cow_file_range_inline.constprop.0+0x1b0/0x1b0 [btrfs]
> [  110.709629]  ? __lock_acquire+0x568/0xbd0
> [  110.709934]  ? lock_acquire.part.0+0xad/0x230
> [  110.710240]  ? process_one_work+0x7ec/0x1590
> [  110.710550]  ? submit_one_async_extent+0xb00/0xb00 [btrfs]
> [  110.710970]  btrfs_work_helper+0x1c1/0x760 [btrfs]
> [  110.711354]  ? lock_acquire+0x128/0x150
> [  110.711635]  process_one_work+0x86b/0x1590
> [  110.711934]  ? pwq_dec_nr_in_flight+0x720/0x720
> [  110.712255]  ? lock_is_held_type+0x83/0xe0
> [  110.712584]  worker_thread+0x5e9/0xfc0
> [  110.712869]  ? process_one_work+0x1590/0x1590
> [  110.713179]  kthread+0x323/0x410
> [  110.713430]  ? _raw_spin_unlock_irq+0x1f/0x40
> [  110.713741]  ? kthread_affine_node+0x1c0/0x1c0
> [  110.714058]  ret_from_fork+0x476/0x5f0
> [  110.714339]  ? arch_exit_to_user_mode_prepare.isra.0+0x60/0x60
> [  110.714730]  ? __switch_to+0x22/0xe00
> [  110.715011]  ? kthread_affine_node+0x1c0/0x1c0
> [  110.715327]  ret_from_fork_asm+0x11/0x20
> [  110.715616]  </TASK>
> [  110.715806] Modules linked in: btrfs xor raid6_pq loop
> [  110.716186] ---[ end trace 0000000000000000 ]---
> [  110.716538] RIP: 0010:btrfs_compress_bio+0x5c2/0x6a0 [btrfs]
> [  110.718125] RSP: 0018:ffff8881003b79a0 EFLAGS: 00010286
> [  110.718488] RAX: 000000000000003e RBX: ffff88810a83d5f8 RCX: 0000000000000000
> [  110.718958] RDX: 000000000000003e RSI: 0000000000000004 RDI: ffffed1020076f27
> [  110.719448] RBP: 1ffff11020076f37 R08: ffffffff8a444651 R09: fffffbfff195c438
> [  110.719912] R10: 0000000000000003 R11: 0000000000000001 R12: ffffea00044498c0
> [  110.720373] R13: ffffea00044498b4 R14: 0000000000000000 R15: ffffea0004449880
> [  110.720871] FS:  0000000000000000(0000) GS:ffff88818baa0000(0000) knlGS:0000000000000000
> [  110.721409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  110.721800] CR2: 00007f4aa3c715a0 CR3: 0000000097a59000 CR4: 00000000000006b0
> 
> Looks like folio references are wrong, the assert in zlib related to the page
> pool was just a symptom and I think actually correct.
> 
> The line numbers do not tell anything interesting:
> 
> (gdb) l *(btrfs_compress_bio+0x5c2)
> 0x1f38e2 is in btrfs_compress_bio (./include/linux/mm.h:1493).
> 1488    /*
> 1489     * Drop a ref, return true if the refcount fell to zero (the page has no users)
> 1490     */
> 1491    static inline int put_page_testzero(struct page *page)
> 1492    {
> 1493            VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
> 1494            return page_ref_dec_and_test(page);
> 1495    }
> 1496
> 1497    static inline int folio_put_testzero(struct folio *folio)
> 
> (gdb) l *(compress_file_range+0x7b7)
> 0xde947 is in compress_file_range (fs/btrfs/inode.c:1014).
> 1009            } else if (inode->prop_compress) {
> 1010                    compress_type = inode->prop_compress;
> 1011            }
> 1012
> 1013            /* Compression level is applied here. */
> 1014            cb = btrfs_compress_bio(inode, start, cur_len, compress_type,
> 1015                                     compress_level, async_chunk->write_flags);
> 1016            if (IS_ERR(cb)) {
> 1017                    cb = NULL;
> 1018                    goto mark_incompressible;
> 
> (gdb) l *(btrfs_compress_filemap_get_folio+0x130)
> 0x1f3320 is in btrfs_compress_bio (fs/btrfs/compression.c:902).
> 897      * to do the round up before submission.
> 898      */
> 899     struct compressed_bio *btrfs_compress_bio(struct btrfs_inode *inode,
> 900                                               u64 start, u32 len, unsigned int type,
> 901                                               int level, blk_opf_t write_flags)
> 902     {
> 903             struct btrfs_fs_info *fs_info = inode->root->fs_info;
> 904             struct list_head *workspace;
> 905             struct compressed_bio *cb;
> 906             int ret;


