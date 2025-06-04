Return-Path: <linux-btrfs+bounces-14438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9DACD4F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 03:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC11645E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AEE79F5;
	Wed,  4 Jun 2025 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YFLMecUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUFcA+GK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F081E
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000982; cv=none; b=nA0ZPx5viOTCKzrjbBpj0lUbBMUPeSSy/tcPZgVr1+dyYvEjvxrrVf6AlrQQ8GZiiyaWvd7raM7CAoHZ+n0aV0nbv4zk5OiaST0hf4so48uoq3CowKJOsece+6WukhUgHY3gFoTN76o+ohA79mLX0OtEmaclDWP8wTKVOccp3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000982; c=relaxed/simple;
	bh=Hlhlk1i/4Q9WfbhSJvVVS1QMkyNpJdoBhjs+9u+T44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWUQLRM88nWnZZyp6x1uVnkzL+RxXciISd8k6AdS4Z7PMgWpLt3SA2tJnC3pp6RZJtOjQJreMpgzTafMnAfsaJs4tlDWC0OXk3G7Dduo76nl+Zniy0LgtNhSzPRoPSkKFZjzZs+S8P1fF1Ov+LE1FJ+9uO/NKNV0wgOt0yzjo70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YFLMecUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUFcA+GK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 497351380313;
	Tue,  3 Jun 2025 21:36:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 03 Jun 2025 21:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749000976; x=1749087376; bh=YQV5p5YDJ+
	QK3wXH4ep1K49/A+BREgNY+dv3LvT67cE=; b=YFLMecUDA04Or8bHDYBid/aU10
	F/I4pA141m5sMqTIPD/edyN99eSpShv5GrlIdqCIh37pobWrC+AL0MqPoIHs79RU
	2OPETAbxezUFv9D9tcxLR7aQ3ruAhF4g4NQqZhiI9VRRG6hwUj/QbAInRow0mIGa
	1Bl+RStsnp/SXUSixXsbnFbIYmuctWY7T11vhtoFwUm0FfHamptLGUb7FTy9vC4x
	zIfqG6pOH9qez9PJtFrETwdBfPhGtw1fAXGRkAOSI7fV0e6rCE43axq5UgHGtcIu
	hkjM8+ylmRi8wWKD5IZW5VXe+n+XORivb5B5WE5iiP0yvyI3U6wAsexteuKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749000976; x=1749087376; bh=YQV5p5YDJ+QK3wXH4ep1K49/A+BREgNY+dv
	3LvT67cE=; b=IUFcA+GK2DC4ZnkVqW2Ypj9dCxQezbF66/K3B1sHvygpaeZHZQI
	foIOME4XfpsFaOmEhkMuKyp8ULYaOO2Qbe/fTcreICvaNWq6XQGX3Xykp2C9fOw4
	1a/Vuj4RCHhkpFil+c9vQSQa6v5ZzdBrBOy0WlI542jC5soMPjDpXlImfDMcTMm3
	6BUZrPrs5l+XaLPT7KwPVC2dnugnglg16IKQb1zHjVTNBbMhpJ/+J3WzHD3xW4rG
	zB00aeNIyinmRF/pzCDQF+CJvaSpKolxIzNP6KBr44RED+HnTffO3fomafsDQNs4
	lVFMcZ2CiPQSJZcT8uCRC5GTpTZIs3SlQ2g==
X-ME-Sender: <xms:D6M_aCbcAUW8ndeChNjMJpKHa1ak7XEhcuRHav_Ot2d_X2uJQO5rdQ>
    <xme:D6M_aFb8kjyXUs1U54fA7rc3PkEOvo-Y96IKuqcXJg8DmA_VcfR2xlTU8HBNtJ_9z
    _Xj5wZZVNhHEOOhoT4>
X-ME-Received: <xmr:D6M_aM8M8wMzPYfVHXlvXrvtMn9bF4UMdWG8QmmRzzqEg9kOlUnT3TiaeqrGDL5NPjmfhu6VbHqLndGO8HsUaqNpJtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeduueeigffhuddtleelkeeihfelheekueeffffgvefhheegueej
    ueektdevkeetieenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    himhhishesghhmgidrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhsse
    hgmhigrdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopegrnhgrnhgurdhjrghinhesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:D6M_aErataGt7ZT2Sc-r4wY-hK_eqjt96X9dhmo3I-va-XDcDOPljw>
    <xmx:D6M_aNoxCOEpEB1bnA4uvZCyhmVBaEalb5sGQ-13LOPuu1Ug6a6DUA>
    <xmx:D6M_aCSyJa8JFYm_qUcfCfpcOujLfl_4ofB07kB6iRRCg2xyKmYsOQ>
    <xmx:D6M_aNrC5lRU6-xhqWw-bKZy7FnXA72O-l3-Kr8ljJMnzb1ERT41Zw>
    <xmx:EKM_aFmaxwtb4WSjZHPj5mgreWMtcXx8zr6-cSRiZlFlodjKrUlNQqWe>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 21:36:14 -0400 (EDT)
Date: Tue, 3 Jun 2025 18:36:11 -0700
From: Boris Burkov <boris@bur.io>
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Anand Jain <anand.jain@oracle.com>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <20250604013611.GA485082@zen.localdomain>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>

On Tue, Jun 03, 2025 at 09:56:22PM +0200, Dimitrios Apostolou wrote:
> Hello list,
> 
> I notice consistently that sequential reads from compressed files are slow
> when the block size is small.
> 
> It's extremely easy to reproduce, but the problem is I can't find the
> bottleneck. I suspect it is an issue of Btrfs, not doing read-ahead like it
> does with non-compressed files.
> 
> Can you reproduce it? I'd also appreciate instructions for further debugging
> it. Or tweaking my system to improve the case.

I'm actually having trouble reproducing the fast performance for
un-compressed files but with small read blocksize. I get 1.2GB/s for
compressed reads with a large bs setting (32k+) but only 600MB/s for a
10G file with 80 uncompressed extents just like yours with bs=8k and
bs=1M...

However, I do observe the huge delta between bs=8k and bs=128k for
compressed which is interesting, even if I am doing something dumb and
failing to reproduce the fast uncompressed reads.

I also observe that the performance rapidly drops off below bs=32k.
Using the highly compressible file, I get 1.4GB/s with 128k, 64k, 32k
and then 200-400MB/s for 4k-16k.

IN THEORY, add_ra_bio_pages is supposed to be doing our own readahead
caching for compressed pages that we have read, so I think any overhead
we incur is not going to be making tons more IO. It will probably be in
that readahead caching or in some interaction with VFS readahead.

To confirm this I invoked the following bpftrace script while doing the
8k and 128k reproducers:
bpftrace -e 'fentry:btrfs_submit_compressed_read {@[kstack]=count();}'

results:
128K:
@[
        _sub_D_65535_0+21531255
        _sub_D_65535_0+21531255
        bpf_trampoline_225485939039+67
        btrfs_submit_compressed_read+5
        submit_one_bio+261
        btrfs_readahead+999
        read_pages+381
        page_cache_ra_unbounded+841
        filemap_readahead.isra.0+231
        filemap_get_pages+1507
        filemap_read+726
        vfs_read+1643
        ksys_read+239
        do_syscall_64+76
        entry_SYSCALL_64_after_hwframe+118
]: 2562
@[
        _sub_D_65535_0+21531255
        _sub_D_65535_0+21531255
        bpf_trampoline_225485939039+67
        btrfs_submit_compressed_read+5
        submit_one_bio+261
        btrfs_do_readpage+2751
        btrfs_readahead+760
        read_pages+381
        page_cache_ra_unbounded+841
        filemap_readahead.isra.0+231
        filemap_get_pages+1507
        filemap_read+726
        vfs_read+1643
        ksys_read+239
        do_syscall_64+76
        entry_SYSCALL_64_after_hwframe+118
]: 79354

8K:
@[
        _sub_D_65535_0+21531247
        _sub_D_65535_0+21531247
        bpf_trampoline_225485939039+67
        btrfs_submit_compressed_read+5
        submit_one_bio+261
        btrfs_readahead+999
        read_pages+381
        page_cache_ra_unbounded+841
        filemap_get_pages+717
        filemap_read+726
        vfs_read+1643
        ksys_read+239
        do_syscall_64+76
        entry_SYSCALL_64_after_hwframe+118
]: 40960
@[
        _sub_D_65535_0+21531247
        _sub_D_65535_0+21531247
        bpf_trampoline_225485939039+67
        btrfs_submit_compressed_read+5
        submit_one_bio+261
        btrfs_readahead+999
        read_pages+381
        page_cache_ra_unbounded+841
        filemap_readahead.isra.0+231
        filemap_get_pages+1507
        filemap_read+726
        vfs_read+1643
        ksys_read+239
        do_syscall_64+76
        entry_SYSCALL_64_after_hwframe+118
]: 40960

So that is the same total number of IOs issued (81920) which is 10G
divided into 128K extents. Therefore, it doesn't appear that btrfs is
issuing more compressed IOs in the bs=8K case. I also checked metadata
IOs and nothing crazy stuck out to me.

However, I do see that in the 8k case, we are repeatedly calling
btrfs_readahead() while in the 128k case, we only call btrfs_readahead
~2500 times, and the rest of the time we loop inside btrfs_readahead
calling btrfs_do_readpage.

This incurs two bits of overhead:
locking/unlocking the extent and possibly not caching the extent_map.
Tracing btrfs_get_extent shows that both sizes call btrfs_get_extent
81920 times, so it's not extent caching.

But the slow variant does call the lock/unlock extent functions 79k times
more.

I then instrumented them to measure the overhead of those functions and
saw that the slow variant spent ~20s of wall time on this
locking/unlocking:

8K:
@lock_delay_ns: 5623087671

@lookup_delay_ns: 29422788

@unlock_delay_ns: 19067071333

128K:
@lock_delay_ns: 91195771

@lookup_delay_ns: 1302691

@unlock_delay_ns: 4911877331

I removed all the extent locking as an experiment, as it is not really
needed for safety in this single threaded test and did see an
improvement but not full parity between 8k and 128k for the compressed
file. I'll keep poking at the other sources of overhead in the builtin
readahead logic and in calling btrfs_readahead more looping inside it.

I'll keep trying that to see if I can get a full reproduction and try to
actually explain the difference.

If you are able to use some kind of tracing to see if these findings
hold on your system, I think that would be interesting.

Also, if someone more knowledgeable in how the generic readahead works
like Christoph could give me a hint to how to hack up the 8k case to
make fewer calls to btrfs_readahead, I think that could help bolster the
theory.

Thanks,
Boris

> 
> I'm CC'ing people from previous related discussion at
> https://www.spinics.net/lists/linux-btrfs/msg137840.html
> 
> 
> ** How to reproduce:
> 
> Filesystem is newly created with btrfs-progs v6.6.3, on NVMe drive with
> 1.5TB of space, mounted with compress=zstd:3. Kernel version is 6.11.
> 
> 
> 1. create 10GB compressible and incompressible files
> 
> head -c 10G /dev/zero          > highly-compressible
> head -c 10G <(od /dev/urandom) > compressible
> head -c 10G /dev/urandom       > incompressible
> 
> 
> 2. Verify they are indeed what promised
> 
> $ sudo compsize highly-compressible
> Processed 1 file, 81920 regular extents (81920 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL        3%      320M          10G          10G
> $ sudo compsize compressible
> Processed 1 file, 81965 regular extents (81965 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       43%      4.3G          10G          10G
> zstd        43%      4.3G          10G          10G
> $ sudo compsize incompressible
> Processed 1 file, 80 regular extents (80 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       10G          10G          10G
> none       100%       10G          10G          10G
> 
> 
> 3. Measure read() speed with 8KB block size
> 
> $ sync
> $ echo 1 | sudo tee /proc/sys/vm/drop_caches
> 
> $ dd if=highly-compressible   of=/dev/null bs=8k
> 1310720+0 records in
> 1310720+0 records out
> 10737418240 bytes (11 GB, 10 GiB) copied, 12.9102 s, 832 MB/s
> 
> $ dd if=compressible   of=/dev/null bs=8k
> 1310720+0 records in
> 1310720+0 records out
> 10737418240 bytes (11 GB, 10 GiB) copied, 30.68 s, 350 MB/s
> 
> $ dd if=incompressible   of=/dev/null bs=8k
> 1310720+0 records in
> 1310720+0 records out
> 10737418240 bytes (11 GB, 10 GiB) copied, 3.85749 s, 2.8 GB/s
> 
> 
> The above results are repeatable. The device can give several GB/s like in
> the last case, so I would expect such high numbers or up to what the CPU can
> decompress. But CPU cores utilisation is low, so I have excluded that from
> being the bottleneck.
> 
> 
> What do you think?
> Dimitris
> 

