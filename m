Return-Path: <linux-btrfs+bounces-19481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3923C9EC74
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0D13A472A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C722F12CD;
	Wed,  3 Dec 2025 10:54:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C322DE707;
	Wed,  3 Dec 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759275; cv=none; b=eTMh5eYPcfHDwYiQnPixLXitW4FsiZ7LWNcmOT5UIEMc+BfkmJg/2+q67n3l0rkPON4a4+b9szkxukr6TpkU3UNnXCbD3FLjnf7OgnfsdbWXWeXjbaqgvUKMzPssXBotMW8Rh8jF6YGbFAMezpjpvQaRC/VqwCDcTfqUFej7L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759275; c=relaxed/simple;
	bh=zlku+hEAoDWyukBBVx477+OkecSYeuAuCSlqe8H5itw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTHbIJUevPeQCeAwA3oITYJGLiHwfgmWaGsVKSUQH8hlAZRHDn7vyDIgHQT8r5d2m4OSm9JGDTQidB62o89LE833xuLzKRkEK+kIYnLsge+05it4UQDduRZ9PihMmMf6ql/2LkN+MsnwX+AmfhAAo1L4RKTQF+foRpEdGHdgJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 0E35C3F11A;
	Wed,  3 Dec 2025 11:47:13 +0100 (CET)
Message-ID: <9d7b182e-9da7-458f-b913-14eee415359d@hogyros.de>
Date: Wed, 3 Dec 2025 19:47:11 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
To: Christoph Hellwig <hch@infradead.org>, Jani Partanen <jiipee@sotapeli.fi>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.com,
 dsterba@suse.com, terrelln@fb.com, herbert@gondor.apana.org.au,
 linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
 qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
 weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aS6a_ae64D4MvBpW@infradead.org>
 <8d3e44b0-23d8-4493-8e7e-33bbe1d904ef@sotapeli.fi>
 <aS_f9axsi0QmmhiL@infradead.org>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <aS_f9axsi0QmmhiL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/3/25 4:00 PM, Christoph Hellwig wrote:

> Well, if you compared QAT-L9 to LZO-L1 specifically:

FWIW I think the same infrastructure is useful for nx-gzip on POWER9+, 
which is a definite win:

1. With 4 GiB of random data, effectively uncompressible:

$ time nx_gzip -c test.bin >test.bin.nxgz
real    0m4.716s
user    0m1.381s
sys     0m2.237s

$ time gzip -c test.bin >test.bin.gz
real    2m58.536s
user    2m56.098s
sys     0m2.084s

2. With 4 GiB of NUL bytes:

$ time nx_gzip -c zero.bin >zero.bin.nxgz
real    0m0.855s
user    0m0.613s
sys     0m0.241s

$ time gzip -c zero.bin >zero.bin.gz
real    0m25.944s
user    0m25.600s
sys     0m0.336s

This includes quite a bit of overhead because we're commanding the 
coprocessor from a userspace library with a zlib compatible interface, 
so there is syscall overhead for reading, poking the coprocessor and 
writing, and the blocks submitted aren't as large as they could be, so 
I'd expect an acomp module running before transferring data to userspace 
to be a bit faster still.

Unpacking is quite a bit faster as well, to the point where unpacking 
the compressed block of 4GiB NUL bytes is faster than reading 4 GiB from 
/dev/zero for me.

For acomp, I pretty much always expect offloading to be worth the 
overhead if hardware is available, simply because working with 
bitstreams is awkward on any architecture that isn't specifically 
designed for it, and when an algorithm requires building a dictionary, 
gathering statistics and two-pass processing, that becomes even more 
visible.

For ahash/acrypt, there is a trade-off here, and where it is depends on 
CPU features, the overhead of offloading, the overhead of receiving the 
result, and how much of that overhead can be mitigated by submitting a 
batch of operations.

For the latter, we also need a better submission interface that actually 
allows large batches, and submitters to use that.

Much of the discussion about hardware offload has been circular -- no 
one is submitting large requests because for CPU based implementations 
there is no benefit in doing so (it just makes the interface more 
complex), and hardware based implementations are sequentially processing 
one small request at a time because no one is submitting larger batches, 
and as a result we can't see a lot of performance improvements.

As an example of interface pain points: ahash has synchronous 
import/export functions, and no way for the driver to indicate that the 
result buffer must be reachable by DMA as well, so even with a mailbox 
interface that allows me to submit operations with low overhead, I need 
to synthesize state readbacks into an auxiliary buffer and request an 
interrupt to be delivered after each "update" operation, simply so I can 
have the state available in case it is requested, while normally I would 
only generate an interrupt after an "export" or "final" operation is 
completed (and also rate-limit these).

There's a lot of additional things that I think a good API would allow, 
such as directly feeding data from mass storage to a coprocessor if they 
have compatible interfaces -- since the initial fetch is asynchronous 
anyway, the offload overhead becomes even less relevant then.

I also think that zswap is going to be an important use case here, and 
there has been quite a bit of discussion about large folios and batching 
requests here. It would be cool if QAT or nx-gzip could be plugged into 
zswap.

    Simon

