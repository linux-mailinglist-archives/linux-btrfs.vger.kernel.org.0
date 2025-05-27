Return-Path: <linux-btrfs+bounces-14245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B1EAC468D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 04:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7953A5ABF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F79918DB01;
	Tue, 27 May 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EZyED3KZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25993FFD;
	Tue, 27 May 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313949; cv=none; b=re+6X5yO8TY8V83Xqt+h/8wk4pIrbIcSGr8YsYzwM88e4YOzBWYqgFpgtrEr2ceHmz/RW2We/lrkoeGjMdgd8cme0y32PokJn4BcByxPNnIX2MXBiLFLaro0i4ESTBrUoOHsWuxHySLX9lFfBHA1ihkgS9CnY5SsrhtLpx8a4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313949; c=relaxed/simple;
	bh=ZUjMiIRX7ObfGXH9UoZs5ZmlEEQZpyRtJCW6bSrZAxc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uUCMIZIEdIZ5PP9ngRZPjFZP+X0ZozER3Sc5R9PLd8yh0IUpQMmlR9WBP2vZkBslNKae4G7FsY6DSQfVnjnzAzxscSOQaNjpku0MWe2AlMVhtaikFuCpqhGbT5YpQaU9bMN8jy1aJfTrncbZG0XxdoCCBG7OU70zfRIROqc30VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EZyED3KZ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748313938; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Zt54fnfMVjjUEQ1E4h3Cefs6EQLFYZaTht7S9Okpavk=;
	b=EZyED3KZ8PaNB/fM+bBkIrFu4IhfKWndFqhScaJK2ykNGl7b9Q/gcl4tWwS7N0Na3WWBZPUsLbkdBPv18OvSNBLAlqHLc5P3alIaMx7IqETvYFP4Rw3lNRRv3lnJ9zzwu3zyHJLM3ytCBlpxYjW3bt+pT7StczoKKX0pS7nbRMo=
Received: from 30.221.132.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wbw4yeT_1748313936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 May 2025 10:45:37 +0800
Message-ID: <d4928552-4977-4195-8d89-a9eb50c7dd7b@linux.alibaba.com>
Date: Tue, 27 May 2025 10:45:36 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate through
 acomp
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Eric Biggers <ebiggers@kernel.org>, David Sterba <dsterba@suse.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
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
In-Reply-To: <baafb2ad-e2a2-4d40-9759-109c2cad559c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/27 10:32, Gao Xiang wrote:
> 
> 
> On 2025/5/8 12:19, Eric Biggers wrote:
> 
> ...
> 
>>
>> BTW, I also have to wonder why this patchset is proposing accelerating zlib
>> instead of Zstandard.  Zstandard is a much more modern algorithm.
> 
> I think simply because QAT doesn't support the Zstandard native offload.
> At least, for Intel Xeon Sapphire Rapids processors (it seems to have
> built-in QAT 4xxx), only LZ4 and deflate-family are natively supported.
> 
> I've confirmed that SPR QAT deflate hardware decompresion already surpasses
> LZ4 software decompression on our cloud server setup, which is useful since
> it greatly improves decompression performance (even compared to software LZ4)
> and saves CPU overhead completely.

Also see:
https://intel.github.io/quickassist/PG/services_compression_api.html

for more details on QAT hardware native supported algorithms.

> 
> For Zstandard, currently it seems it [1] just leverages part of the QAT
> engine: hardware sequence producer (matchfinder) to boost up Zstandard
> match finding And I think the current hardware QAT will have no positive
> effect on the Zstandard decompression.  Without hardware improvements, it
> seems it can be hardly changed.
> 
> I think it's true for both 5th Sapphire Rapids processors and 6th Granite
> Rapids processors.  Correct if I'm wrong here but that is what I got so far.
> 
> Thanks,
> Gao Xiang
> 
> [1] https://github.com/intel/QAT-ZSTD-Plugin
> 
>>
>> - Eric
>>
> 


