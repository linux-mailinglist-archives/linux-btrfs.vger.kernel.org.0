Return-Path: <linux-btrfs+bounces-3241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FD87A50E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7761F2282F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55420B33;
	Wed, 13 Mar 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="lzuPImqM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.15.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38991168CE
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322586; cv=none; b=hxOdy56TBezl4TBYpsQ+O2pwizCrGPGKWbtGhxXhJPUIfbDroQeGsxz/qV4/O3CwuZfDLyxYfUfAbqqYwDG8BQ7CUZsInL72EPSGrfSdX/v/XE7QtYGvA3bjADADkw8HDGzYx9JJoYmP1HwKqsxP/+RhDAtsgAP6UNv1HPzCGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322586; c=relaxed/simple;
	bh=j32/5REATnj53c00RzF+1gyA9mio/D+zVBa53Tu1RTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rkRi7SAnmaUjDNJfB32rxnSS2/OmeqGbO+JiKatlrU6jM2sQNm4tlvPyh7YlbhNrt3859gURRmHAkiHDHePSAUxsMV936ck4yHMpDGhevmEWq/cS0Pzgwy9NvrE43hdhJpj/TN8nI90EzUaFk8lYhzTJiJHL07cz46jA06/Ycl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=lzuPImqM; arc=none smtp.client-ip=212.227.15.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	 s=corp1; h=From:To:Subject:MIME-Version:Date:Message-ID:cc:sender:reply-to;
	 bh=DWU9MUMqQVajXVHjm3Dl+vu7QgCXiHT7CTHDcDQGmmw=; b=lzuPImqMDgDeEOr2yHmRNSK8M
	I0pMPEoYIrMFJdgtGUZ+q+8UlYK3lqaIIbvOFnjunARyet1RVWPZclaeuW8Hz4l4+HxsdRBDEkjgG
	6/stEqixdtPGpZQ2yziHVlFphEKQ36QRPYxkPytQUN1JgIrKHLBuiSUrNtP9eFbWbnmyUnQjLRFhx
	t2PqGwT0jKA1lHvTNsSRKxYOIbY4rDrstI3yNmSfrFvYuj0FxcnLkI1FZIJpfdowmat0x6vUUVyt1
	n5f4XmCFQ0oqa7xAhJvZkaJykwSbdBCUIv5lBKf82iSGpvPOqSZ54m8jwaRC65UwfeH1U4+yCD0g8
	G4lz2XPeQ==;
Received: from [10.98.28.7] (helo=KAPPEX022.united.domain)
	by mrint.1and1.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <julian.taylor@1und1.de>)
	id 1rkL26-0006Ky-Av
	for linux-btrfs@vger.kernel.org; Wed, 13 Mar 2024 10:36:22 +0100
Message-ID: <5f527804-9d52-4f96-b0a7-72d49e524e18@1und1.de>
Date: Wed, 13 Mar 2024 10:36:21 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: slow performance due to frequent memalloc_retry_wait in
 btrfs_alloc_page_array
To: <linux-btrfs@vger.kernel.org>
References: <8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de>
 <9d66a2e0-96a5-4aea-acf3-732d6667e60e@gmx.com>
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
Autocrypt: addr=julian.taylor@1und1.de; keydata=
 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
 7oKCuVqh8kE3PYxoRHbuOnFcKDL7dV8w3Mak
In-Reply-To: <9d66a2e0-96a5-4aea-acf3-732d6667e60e@gmx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KAPPEX024.united.domain (10.98.28.9) To
 KAPPEX022.united.domain (10.98.28.7)
X-Virus-Scanned: ClamAV@mvs-ha-bs


On 13.03.24 07:26, Qu Wenruo wrote:
>
>
> 在 2024/3/13 00:05, Julian Taylor 写道:
>> Hello,
>>
>> After upgrading a machine using btrfs to a 6.1 kernel from 5.10 we are
>> experiencing very low read performance on some (compressed) files when
>> most of the nodes memory is in use by applications and the filesystem
>> cache. Reading some files does not exceed 5MiB/second while the
>> underlying disks can sustain ~800MiB/s. The load on the machine while
>> reading the files slowly is basically zero
>>
>> The filesystem is mounted with
>>
>>   btrfs (rw,relatime,compress=zstd:3,space_cache=v2,subvolid=5,subvol=/)
>>
>> The filesystem contains several snapshot volumes.
>>
>> Checking with blktrace we noticed a lot of queue unplug events which
>> when traced showed that the cause is most likely io_schedule_timeout
>> being called extremely frequent from btrfs_alloc_page_array which since
>> 5.19 (91d6ac1d62c3dc0f102986318f4027ccfa22c638) uses bulk page
>> allocations with a memalloc_retry_wait on failure:
>>
>> $ perf record -e block:block_unplug -g
>>
>> $ perf script
>>
>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>> ([kernel.kallsyms])
>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>> ([kernel.kallsyms])
>>          ffffffffa3bb1205 __blk_flush_plug+0xf5 ([kernel.kallsyms])
>>          ffffffffa4213f15 io_schedule_timeout+0x45 ([kernel.kallsyms])
>>          ffffffffc0c74d42 btrfs_alloc_page_array+0x42 
>> ([kernel.kallsyms])
>
> Btrfs needs to allocate all the pages for the compressed extents, which
> can be very large (as large as 128K, even if the read may only be 4K).
>
> Furthermore, since your system have very high memory pressure, it also
> means the page cache doesn't have much chance to cache the decompressed
> contents.
>
> Thus I'm afraid for your high memory pressure cases, it is not really
> not a good use case with compression.
> (Both compressed read and write would need extra pages other than the
> inode page cache).
>
> And considering your storage is very fast (800+MiB/s), there is really
> little benefit for compression (other than saving disk usages).

The machine does not have high memory pressure it has 380Gi of memory 
and the applications on it only use a small fraction of it, it is just a 
machine handling backups most of the time.

The memory is all just used by the page cache and is reclaimable. The 
bulk page allocation functions just do not do that without falling back 
to single page allocations.


>
>>
>>
>> Further checking why the bulk page allocations only return a single page
>> we noticed this is only happening when all memory of the node is tied up
>> even if still reclaimable.
>>
>> It can be reliably reproduced on the machine when filling the page cache
>> with data from the disk (just via cat * >/dev/null) until we are have
>> following memory situation on the node with two sockets:
>>
>> $numactl --hardware
>>
>> available: 2 nodes (0-1)
>>
>> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40
>> 42 44 46 48 50 52 54 56 58 60 62
>> node 0 size: 192048 MB
>> node 0 free: 170340 MB
>> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41
>> 43 45 47 49 51 53 55 57 59 61 63
>> node 1 size: 193524 MB
>> node 1 free: 224 MB        <<< nothing free due to cache
>
> This is interesting, such unbalanced free memory is indeed going to
> cause problems.
>
>>
>> $ top
>>
>> MiB Mem : 385573.2 total, 170093.0 free,  19379.1 used, 201077.9 
>> buff/cache
>> MiB Swap:   3812.0 total,   3812.0 free,      0.0 used. 366194.1 
>> avail Mem
>>
>>
>> When now reading a file with a process bound to a cpu on node 1 (taskset
>> -c cat $file) we see the high io_schedule_timeout rate and very low read
>> performance.
>>
>> This is seen with linux 6.1.76 (debian 12 stable) and linux 6.7.9
>> (debian unstable).
>>
>>
>> It appears the bulk page allocations used by btrfs_alloc_page_array will
>> have a high failure rate when the per cpu page lists are empty and they
>> do not appear to attempt to reclaim memory from the page cache but
>> instead return a single page via the normal page allocations. But this
>> combined with memalloc_retry_wait called on each iteration causes very
>> slow performance.
>
> Not an expert on NUMA, but I guess there should be some way to balance
> the free memory between different numa nodes?
>
> Can it be done automatically/periodically as a workaround?

Dropping data from the page cache is the workaround we are using, via 
fadvice(DONTNEED) on the data.

Balancing the memory between numa nodes will not help. At some point 
both nodes memory is in the caches and the same situation will occur on 
both nodes.

I have verified this loading the caches on both nodes:

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 
42 44 46 48 50 52 54 56 58 60 62
node 0 size: 192048 MB
node 0 free: 2316 MB
node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 
43 45 47 49 51 53 55 57 59 61 63
node 1 size: 193524 MB
node 1 free: 327 MB

and now loading files with processes bound to either node is affected by 
this. ]


>
>>
>> Increasing sysctl vm.percpu_pagelist_high_fraction did not yield any
>> improvement for the situation, the only workaround seems to be to free
>> the page cache on the nodes before reading the data.
>>
>> Assuming the bulk page allocations functions are intended to not reclaim
>> memory when the per core lists are empty probably the way
>> btrfs_alloc_page_array handles failure of bulk allocation should be
>> revised.
>
> Any suggestion for improvement?
>
> In our usage, we can not afford to reclaim page cache, as that may
> trigger page writeback, meanwhile we may also in the page writeback path
> and can lead to deadlock.
>
> On the other hand, if we allocate pages for compressed read/write from
> other NUMA nodes, wouldn't that cause different performance problems?
> E.g. we still need to do compression using the page from the remote numa
> nodes, wouldn't that also greatly reduce the compression speed?

The problem we see is not the page allocation itself but the looping on 
memalloc_retry_wait when the bulk allocation falls back to single page 
allocations due to empty per cpu page lists.

My naive suggestion would be to revert the bulk allocation 
(91d6ac1d62c3dc0f102986318f4027ccfa22c638) and do single page 
allocations again. As far as I can tell the bulk allocation was done for 
performance reasons not to avoid deadlocks due to writeback.

If the performance gain by the bulk allocation is very significant maybe 
the looping on memalloc_retry_wait can be done in some better way but I 
am unfamiliar with the details here on why the single page allocation 
did not need to do a retry-wait loop and the bulk page allocation does.


Cheers,

Julian Taylor


