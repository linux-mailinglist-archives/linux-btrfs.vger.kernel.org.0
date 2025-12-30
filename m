Return-Path: <linux-btrfs+bounces-20040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D2CE919B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 09:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20873301AD1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C112FFF82;
	Tue, 30 Dec 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QeBXW8yP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D3212FB9
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767084990; cv=none; b=PAVplntbI1weQ7WOzt2L8sp/Z9eUeZFSGJ4k+8f95TRb4Jwhwx6VT2H8doCbwxcyviCv9mINrXa9V4ZHeLkTWQTHm9glD37iYh9etuyqBLtgPNZ7fKc9gnl5D3eSIVvNEPq9kC2APmavO6m0Y3BgwgpBy1x7Q0KbXw5QthWOU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767084990; c=relaxed/simple;
	bh=SOh4wDkvjiOZ3R0dET0ded3CLt+CKJrrynHHGNvrvOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTqPBHhqhsjNM4j6pgaEzT6RVLZplLzhOUUVbohfX+1/Cof4J4Qy9zZuQBLkFadBQOYnKw65mO5azsolxM1bE2hy4pVYoyQ1BNd146Pq6t3kOqsfUG5ZnATjUD7JX7CDo+fVLPHCVTD11MQxPDCt2a11hYmXdaoPKC7EvxpXyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QeBXW8yP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so56244755e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 00:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767084986; x=1767689786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bvVKJdJnaM2On7inUohbQ2SBmLtrl2Hh0yjl1Wl9US0=;
        b=QeBXW8yPeY9XbmFeHWEuJ4ezgjUSq9HllXVikCoetHPTZb+okOujaPM8DiJiHwPvpf
         Pl9klDLJR+jYOsBHci7Tb7Pfx7ygScqcjBS+XHm9KR5OGeuFNdFhccFb3BzcTEhMSxl8
         57PdBfd65AabeN7JubWNRQJ3j3Ve2uqRIcP2fp1LUviN9YlAw0mipWRNuJH5Z4qNOQrC
         R0P73zi97S835Xrm2eBAA7y1THbgUhenpHVUhd4Nh+TFMSBRVg6SiwFJIiAnyu88Sid+
         isHb0/wa/lm/Qk398y7AIMw/qRRARWk2cFqRF8C94xYWnN/3P/1aTEqeYDnPNsx5UP67
         PHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767084986; x=1767689786;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvVKJdJnaM2On7inUohbQ2SBmLtrl2Hh0yjl1Wl9US0=;
        b=dp57Ye2xdU+1+sWK4HOwHIPHv8qgAjvkglXhDFWIj3nW8q89EJ7XR8hrAJjAQ7tsim
         Ja7rTFU+t7MTAszC7+EpTA1C0fUNEcIn1RPFc0OX5l+hvW2dFIGjmuyJiRYL+G4u4Yfh
         zVEBpYUoquIDExkMWJ6dc3kWhinODc0YRBMepZHmLNQps8urzxiomWJjADs3nhrPwMvr
         /6tMRLQqnppH/deceFcwbq0mMqD8ehEK1dXRi28ki4eFPimzDjOAZ8DRKidPuY0/iczi
         0NVSih4pr+Q+MS+odsNa+h0f22+WwUyrCgWPVZl5vEwqCXRJqpNVpZeeizX0ce4cpsUj
         b+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+6Ve3n62XchZWPpooVB7sJPYmPMNrCjyNSpGXp0WdOh92S0CPeb/4etCXbIRsZn3yrXiLB/IJ+aG3AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRT+PLQIvf3O27qdSAXX7Sz6rA/5OFvHjR+/1scllNQrtGUQMZ
	cCxLE31lE79vzTqJ/x2UaBDBti9ttbTvvwfmrDO4++5y5uGIL7Y/+BqZHBvKFoPxC4Y=
X-Gm-Gg: AY/fxX5DE0qPcbyCZmtDCij0kkQpBE17MFgW1VaOv96RTKL+hGz+YhPYufy1M7sv5Uf
	HF3hcm2udwxDlJUITP2eiQVObjO0im8gg5WfC4q3MQlUejfU76YuUFBF/pZBMNGScHNfjFGParq
	l6pBONi+DzaO90ry/P20uvPkYhZ7Drb3x0WVeI3DumMiZrhVCfLxFj6aD8F9oZMAogc9ie+RKbW
	fRO3zOm7aLuIlh78q168cz99RMv6JVTpVe5DTBVBvAMOVHH2t6aydN52HuUaTcaN8a42Tl/7SH3
	N7NxHvanY5iO1cqJ+i/U2+fV+w3GhA9fvfoUCxYcNSZqsGerYPy04ed9UAN7BwvRA6+nog99867
	WsZfrF7wQzNnoMyPj/TWCrgiRITTIiuLCtWZOmI8Rip8X0ycnPIZpHmfNDOAA3HBBSEo7uoO9oh
	cPgnno4/hZCR/n3rcVprmA9NguNFpNrYBnTkaM9NI=
X-Google-Smtp-Source: AGHT+IH0TX4uMbCWOhKC0MLWDkqWvu8vcJojlbWCNpKRTWXbCrgq0KZO63CKhqyIn0N12C001zt9Zg==
X-Received: by 2002:a05:600c:3489:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-47d206a9856mr334441665e9.5.1767084986462;
        Tue, 30 Dec 2025 00:56:26 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb9csm290248015ad.47.2025.12.30.00.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 00:56:25 -0800 (PST)
Message-ID: <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com>
Date: Tue, 30 Dec 2025 19:26:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.19-rc3] xxhash invalid access during BTRFS mount
To: Daniel J Blueman <daniel@quora.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <clm@fb.com>, Linux BTRFS <linux-btrfs@vger.kernel.org>
Cc: linux-crypto@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
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
In-Reply-To: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/30 18:02, Daniel J Blueman 写道:
> Hi Dave, Chris et al,
> 
> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
> checksumming and KASAN, I see invalid access:

Mind to share the page size? As aarch64 has 3 different supported pages 
size (4K, 16K, 64K).

I'll give it a try on that branch. Although on my rc1 based development 
branch it looks OK so far.


And is this KASAN triggered for this particular fs or all any btrfs (no 
matter csum)?

Thanks,
Qu

> 
> BTRFS info (device nvme0n1p5): first mount of filesystem
> f99f2753-0283-4f93-8f5d-7a9f59f148cc
> BTRFS info (device nvme0n1p5): using xxhash64 (xxhash64-generic)
> checksum algorithm
> ==================================================================
> BUG: KASAN: invalid-access in xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
> Read of size 8 at addr 21ff000802247000 by task kworker/u48:3/48
> Pointer tag: [21], memory tag: [c0]
> 
> CPU: 1 UID: 0 PID: 48 Comm: kworker/u48:3 Tainted: G      E
> 6.19.0-rc3 #19 PREEMPTLAZY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
> Workqueue: btrfs-endio-meta simple_end_io_work
> Call trace:
> show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
> dump_stack_lvl (lib/dump_stack.c:122)
> print_address_description.isra.0 (mm/kasan/report.c:379)
> print_report (mm/kasan/report.c:450 (discriminator 1)
> mm/kasan/report.c:483 (discriminator 1))
> kasan_report (mm/kasan/report.c:597)
> kasan_check_range (mm/kasan/sw_tags.c:86 (discriminator 1))
> __hwasan_loadN_noabort (mm/kasan/sw_tags.c:158)
> xxh64_update (lib/xxhash.c:143 lib/xxhash.c:283)
> xxhash64_update (crypto/xxhash_generic.c:49)
> crypto_shash_finup (crypto/shash.c:123 (discriminator 1))
> csum_tree_block (fs/btrfs/disk-io.c:110 (discriminator 3))
> btrfs_validate_extent_buffer (fs/btrfs/disk-io.c:404)
> end_bbio_meta_read (fs/btrfs/extent_io.c:3822 (discriminator 1))
> btrfs_bio_end_io (fs/btrfs/bio.c:146)
> simple_end_io_work (fs/btrfs/bio.c:382)
> process_one_work (./arch/arm64/include/asm/jump_label.h:36
> ./include/trace/events/workqueue.h:110 kernel/workqueue.c:3262)
> worker_thread (kernel/workqueue.c:3334 (discriminator 2)
> kernel/workqueue.c:3421 (discriminator 2))
> kthread (kernel/kthread.c:463)
> ret_from_fork (arch/arm64/kernel/entry.S:861)
> 
> The buggy address belongs to the physical page:
> page: refcount:2 mapcount:0 mapping:00000000973bd0ac index:0x9731 pfn:0x882247
> memcg:aaff000800ae1b00
> aops:btree_aops ino:1
> flags: 0x47e400000004020(lru|private|node=0|zone=2|kasantag=0x3f)
> raw: 047e400000004020 fffffdffe0089188 fffffdffe0089208 ccff000814148300
> raw: 0000000000009731 10ff0008493322d0 00000002ffffffff aaff000800ae1b00
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff000802246e00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
> ffff000802246f00: 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21 21
>> ffff000802247000: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
> ^
> ffff000802247100: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
> ffff000802247200: c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0
> 
> Let me know for any further testing or debug.
> 
> Thanks,
>    Dan
> --
> Daniel J Blueman
> 


