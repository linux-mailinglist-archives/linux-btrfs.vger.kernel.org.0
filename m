Return-Path: <linux-btrfs+bounces-14255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC5AC4E50
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D818D189EB6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E1426B970;
	Tue, 27 May 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s+Ti7MXo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01E269CEB;
	Tue, 27 May 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347727; cv=none; b=UesiYV9eLiRMcCHffMn8cC/3vPUqj4E/YqbjVlYiAioLxKmTGv5/asCgTf1Bmd5K+105ipaZx5XiRKQigcyCS3J7CAkLDfvtYQf0kf39rWzDZMwQb6LW2FMXPJ3e5Y48DtJDeVxZ4Q5yC7ajIFSrroSXAvspBI2fhVBTJIqn5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347727; c=relaxed/simple;
	bh=DJh0fSsNTxpWskCHLzce9KZ1XBIbWlMxXlEfoax1bgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjWry0o4CEWZHGlUDYdSzYIUZUMeKlnX6fjkICbuZdpQ8KtYHTBm05dRmDa4xAOl8C0Slqf/bbTxHV1nl5zsHM0veCO6d9ALIcCv8AQ5RZnPke3pt+f2aejH34Mm+dFH17Qnnv3I0TPNiJg7NKh6wmUmpus7/XT2CFmSYO4aEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s+Ti7MXo; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748347715; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ucGCQ/Msy4ajI/sJWFTysSC39Fz9Wpl7nrZUi7mKTAI=;
	b=s+Ti7MXoN401fkWUmeiU4v1f8UQUGRsYIuVgt5KeH7q8TOd96Xr0CSANs/ngZpWNKBaHf4jR+fyqFNIciSjem0o7pci7xDUixRtNlQUj14UjtAKo4MR5tNc0WIMi51VZTvCaRZkDjN4WQUIRpW9BUsfjLlyi+E2zWHKanO0i+Sc=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wc0xUnh_1748347710 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 May 2025 20:08:34 +0800
Message-ID: <b3abd55d-8713-4807-b736-00eb99dad610@linux.alibaba.com>
Date: Tue, 27 May 2025 20:08:30 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate through
 acomp
To: dsterba@suse.cz
Cc: Eric Biggers <ebiggers@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
 "Collet, Yann" <cyan@meta.com>, "Will, Brian" <brian.will@intel.com>,
 "Li, Weigang" <weigang.li@intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting> <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <aBrEOXWy8ldv93Ym@gondor.apana.org.au> <20250507121754.GE9140@suse.cz>
 <20250508041914.GA669573@sol>
 <baafb2ad-e2a2-4d40-9759-109c2cad559c@linux.alibaba.com>
 <20250527111731.GC4037@suse.cz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250527111731.GC4037@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2025/5/27 19:17, David Sterba wrote:
> On Tue, May 27, 2025 at 10:32:00AM +0800, Gao Xiang wrote:
>>
>>
>> On 2025/5/8 12:19, Eric Biggers wrote:
>>
>> ...
>>
>>>
>>> BTW, I also have to wonder why this patchset is proposing accelerating zlib
>>> instead of Zstandard.  Zstandard is a much more modern algorithm.
>>
>> I think simply because QAT doesn't support the Zstandard native offload.
>> At least, for Intel Xeon Sapphire Rapids processors (it seems to have
>> built-in QAT 4xxx), only LZ4 and deflate-family are natively supported.
>>
>> I've confirmed that SPR QAT deflate hardware decompresion already surpasses
>> LZ4 software decompression on our cloud server setup, which is useful since
>> it greatly improves decompression performance (even compared to software LZ4)
>> and saves CPU overhead completely.
> 
> Does this measure the overall time of decompression (including the setup
> steps, like the scatter/gather or similar, allocating requests, waiting
> etc)?. Comparing that to the library calls plus the input page iteration.
> I haven't found any public benchmarks with the QAT enabled compression.
> I'm interested how it's benchmarked because we'v had people pointing out
> that LZ4 itself is very fast, but when the overhead is taken into
> account it's reducing the overall performance. Thanks.

Yes, EROFS already supports QAT end-to-end since the ongoing Linux 6.16:

Processor: Intel(R) Xeon(R) Platinum 8475B (192 cores)
Memory: 512 GiB
Dataset: enwik9
Test command: fio --filename=enwik9 -rw=read -readonly -bs=4k -ioengine=psync -name=job1

1) $ mkfs.erofs -zdeflate -C1048576 enwik9.dfl enwik9
    $ echo qat_deflate > /sys/fs/erofs/accel
    READ: bw=662MiB/s (694MB/s), 662MiB/s-662MiB/s (694MB/s-694MB/s), io=954MiB (1000MB), run=1440-1440msec
    $ echo >  /sys/fs/erofs/accel
    READ: bw=381MiB/s (400MB/s), 381MiB/s-381MiB/s (400MB/s-400MB/s), io=954MiB (1000MB), run=2500-2500msec

2) $ mkfs.erofs -zlz4hc -C1048576 enwik9.lz4 enwik9
    READ: bw=541MiB/s (568MB/s), 541MiB/s-541MiB/s (568MB/s-568MB/s), io=954MiB (1000MB), run=1762-1762msec

However, my current test case that the cloud disk is slow (I use the cheapest
cloud disk setup because it will be used for rootfs and container images), so
the overall e2e is I/O bound instead of CPU bound, so in that case since
deflate can compress better (so can save more disk I/Os), it can surpass the
LZ4 one (because even LZ4 is faster but cost more I/Os due to large image).

If the storage/CPU combination is CPU bound, I think it could have different
results anyway.

Thanks,
Gao Xiang

