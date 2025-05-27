Return-Path: <linux-btrfs+bounces-14244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CBAC4635
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 04:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D64C3B279C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E31917FB;
	Tue, 27 May 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c5SKN0/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD914C81;
	Tue, 27 May 2025 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313133; cv=none; b=SEOc32h80lNcjxs1viool54LMvZp3/r/uOv9ZzJx/GX2qkWRUuQQLtZ9V0yDOc4M/+lytWosogE95abxdWlfKx4cYs43xB0g09r0LGyzf6XsD93RP416nSfXI2dc9XpQ9CsORUojhL9FLkHvtqLNjDIid1lXAlyLBVKckRLEVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313133; c=relaxed/simple;
	bh=6LWtrlebSnstaTUnn9Q4XGMJdN8BKFsl2P/abFtO5HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8jdE+sCxnt5oRiLW2iS7i0akUhvKP30VXBk0s7QJdu0OG2lgEK+BiiqJRBwwF8OwxSK7Jijhw959RjAOrmR7yTPBecWPEOc30PPyTmiVfiWU+GzwqKqvTfdaIJ1tUrH2Kl3XYXsYbje7HzVmx8Wo8QWtGfNiGQbYviqU0RV1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c5SKN0/i; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748313122; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HSuWbxTyaqkMGmR51mszZ5ozCfTdYw43QGwAvUIsLQw=;
	b=c5SKN0/iXfoe6c8qUVmFtUPAfDbgsZ/5rnaUb5gR6J/WIc+MnIDILDFzmengN5Q0m0YYc9jTuDv7lJV0PzHISyYpNhmtKzJ6RvvSjZzLoF413oGmBJS8Y4GZzwV+hlOJMu9gn+73ClTsHsNxCLbTkJkJZNwM/oQuQUWqK6SgD98=
Received: from 30.221.132.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wbw-YXZ_1748313120 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 May 2025 10:32:01 +0800
Message-ID: <baafb2ad-e2a2-4d40-9759-109c2cad559c@linux.alibaba.com>
Date: Tue, 27 May 2025 10:32:00 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate through
 acomp
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250508041914.GA669573@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/8 12:19, Eric Biggers wrote:

...

> 
> BTW, I also have to wonder why this patchset is proposing accelerating zlib
> instead of Zstandard.  Zstandard is a much more modern algorithm.

I think simply because QAT doesn't support the Zstandard native offload.
At least, for Intel Xeon Sapphire Rapids processors (it seems to have
built-in QAT 4xxx), only LZ4 and deflate-family are natively supported.

I've confirmed that SPR QAT deflate hardware decompresion already surpasses
LZ4 software decompression on our cloud server setup, which is useful since
it greatly improves decompression performance (even compared to software LZ4)
and saves CPU overhead completely.

For Zstandard, currently it seems it [1] just leverages part of the QAT
engine: hardware sequence producer (matchfinder) to boost up Zstandard
match finding And I think the current hardware QAT will have no positive
effect on the Zstandard decompression.  Without hardware improvements, it
seems it can be hardly changed.

I think it's true for both 5th Sapphire Rapids processors and 6th Granite
Rapids processors.  Correct if I'm wrong here but that is what I got so far.

Thanks,
Gao Xiang

[1] https://github.com/intel/QAT-ZSTD-Plugin

> 
> - Eric
> 


