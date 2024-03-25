Return-Path: <linux-btrfs+bounces-3553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC188A572
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 15:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F7F2E81FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735333E1;
	Mon, 25 Mar 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="Nga8sD6A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.15.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCD137758
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366545; cv=none; b=f2ztcIOc75O1t9br+HyIpDnWCV750lM3OQVwCwCC2uxQ0iWkm85XU2yToUM9/ljtaeuymF275gSnKWMRYQLVyLHeZ39HerpEBDS4uEqj3nthNDLncz/VaU/6ShzUHB5UQplbLMq6S8H4sJZGWk7dYw/vqvwumgueYTaV7nHCpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366545; c=relaxed/simple;
	bh=nQuUpg6nmsEeQnd0MoThKxE6gBSAeRU3rU+OXZDHh4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5XYiIGtJlXXuoX3XxBLTnWaKyh9syy4K+fQ7TWgBdHAMFzHvlJkBQrHbyLfWzWrKkcYC0Po5jypqHp7uuLndemGTwkxYuNOxJxhDrNACA9tTuhc5J97zKsPLvnC3ikS0D4+1c9YWB3/Xk3Lsrza+lX4Fg3+m4dbQpqzovcRAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=Nga8sD6A; arc=none smtp.client-ip=212.227.15.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	 s=corp1; h=From:To:Subject:MIME-Version:Date:Message-ID:cc:sender:reply-to;
	 bh=hDnvSI6ynptwz2Qm03Pkj6qL6sUaoeru2cusiooNvWw=; b=Nga8sD6AZ4ZxEW5IP++93xly9
	QBhAgyp0ip8zNJeKb526X9z3V6D9/FlWYD3b9H+gRBtn7xH2CqzmjH1QlufRVSMFPA2JAEE7IYa2L
	294D5hShlR5iYrkyg7uQtTgdaICt2HxJ1ibn+tB6PXhX/dG7aoKXZkv271fgfQU6DZ9LqtMwcca3G
	gdw6IsGe8/iRv+1wDv53I/CIwp1MoD/1l1sm82+6hPrIPlIPbn6isxCPsKYDbNBjgqz3O8u3o1nn7
	SUKlnyDkaPgR4uzNACJN1RrpHOSNQLzHYGWsJkStc9hll0xuaYV6t3HmFJMAkSO9DytQ4yDgeKYVA
	N6mWvgM1w==;
Received: from [10.98.28.7] (helo=KAPPEX022.united.domain)
	by mrint.1and1.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <julian.taylor@1und1.de>)
	id 1roiZc-0008Uf-6Z; Mon, 25 Mar 2024 12:33:04 +0100
Message-ID: <5921e2eb-6017-42db-984b-a074bade40b2@1und1.de>
Date: Mon, 25 Mar 2024 12:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: slow performance due to frequent memalloc_retry_wait in
 btrfs_alloc_page_array
To: Qu Wenruo <wqu@suse.com>, <linux-btrfs@vger.kernel.org>
References: <8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de>
 <9d66a2e0-96a5-4aea-acf3-732d6667e60e@gmx.com>
 <5f527804-9d52-4f96-b0a7-72d49e524e18@1und1.de>
 <d4955b70-f379-43b0-ab8f-7aaa8bafb41c@suse.com>
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
Autocrypt: addr=julian.taylor@1und1.de; keydata=
 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
 7oKCuVqh8kE3PYxoRHbuOnFcKDL7dV8w3Mak
In-Reply-To: <d4955b70-f379-43b0-ab8f-7aaa8bafb41c@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KAPPEX024.united.domain (10.98.28.9) To
 KAPPEX022.united.domain (10.98.28.7)
X-Virus-Scanned: ClamAV@mvs-ha-bs


On 22.03.24 08:37, Qu Wenruo wrote:
>
>
> 在 2024/3/13 20:06, Julian Taylor 写道:
>>
>> On 13.03.24 07:26, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/3/13 00:05, Julian Taylor 写道:
>>>> Hello,
>>>>
>>>> After upgrading a machine using btrfs to a 6.1 kernel from 5.10 we are
>>>> experiencing very low read performance on some (compressed) files when
>>>> most of the nodes memory is in use by applications and the filesystem
>>>> cache. Reading some files does not exceed 5MiB/second while the
>>>> underlying disks can sustain ~800MiB/s. The load on the machine while
>>>> reading the files slowly is basically zero
>>>>
>>>> The filesystem is mounted with
>>>>
>>>>   btrfs 
>>>> (rw,relatime,compress=zstd:3,space_cache=v2,subvolid=5,subvol=/)
>>>>
>>>> The filesystem contains several snapshot volumes.
>>>>
>>>> Checking with blktrace we noticed a lot of queue unplug events which
>>>> when traced showed that the cause is most likely io_schedule_timeout
>>>> being called extremely frequent from btrfs_alloc_page_array which 
>>>> since
>>>> 5.19 (91d6ac1d62c3dc0f102986318f4027ccfa22c638) uses bulk page
>>>> allocations with a memalloc_retry_wait on failure:
>>>>
>>>> $ perf record -e block:block_unplug -g
>>>>
>>>> $ perf script
>>>>
>>>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>>>> ([kernel.kallsyms])
>>>>          ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246
>>>> ([kernel.kallsyms])
>>>>          ffffffffa3bb1205 __blk_flush_plug+0xf5 ([kernel.kallsyms])
>>>>          ffffffffa4213f15 io_schedule_timeout+0x45 ([kernel.kallsyms])
>>>>          ffffffffc0c74d42 btrfs_alloc_page_array+0x42 
>>>> ([kernel.kallsyms])
>>>
>>> Btrfs needs to allocate all the pages for the compressed extents, which
>>> can be very large (as large as 128K, even if the read may only be 4K).
>>>
>>> Furthermore, since your system have very high memory pressure, it also
>>> means the page cache doesn't have much chance to cache the decompressed
>>> contents.
>>>
>>> Thus I'm afraid for your high memory pressure cases, it is not really
>>> not a good use case with compression.
>>> (Both compressed read and write would need extra pages other than the
>>> inode page cache).
>>>
>>> And considering your storage is very fast (800+MiB/s), there is really
>>> little benefit for compression (other than saving disk usages).
>>
>> The machine does not have high memory pressure it has 380Gi of memory 
>> and the applications on it only use a small fraction of it, it is 
>> just a machine handling backups most of the time.
>>
>> The memory is all just used by the page cache and is reclaimable. The 
>> bulk page allocation functions just do not do that without falling 
>> back to single page allocations.
>>
>>
>>>
>>>>
>>>>
>>>> Further checking why the bulk page allocations only return a single 
>>>> page
>>>> we noticed this is only happening when all memory of the node is 
>>>> tied up
>>>> even if still reclaimable.
>>>>
>>>> It can be reliably reproduced on the machine when filling the page 
>>>> cache
>>>> with data from the disk (just via cat * >/dev/null) until we are have
>>>> following memory situation on the node with two sockets:
>>>>
>>>> $numactl --hardware
>>>>
>>>> available: 2 nodes (0-1)
>>>>
>>>> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40
>>>> 42 44 46 48 50 52 54 56 58 60 62
>>>> node 0 size: 192048 MB
>>>> node 0 free: 170340 MB
>>>> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41
>>>> 43 45 47 49 51 53 55 57 59 61 63
>>>> node 1 size: 193524 MB
>>>> node 1 free: 224 MB        <<< nothing free due to cache
>>>
>>> This is interesting, such unbalanced free memory is indeed going to
>>> cause problems.
>>>
>>>>
>>>> $ top
>>>>
>>>> MiB Mem : 385573.2 total, 170093.0 free,  19379.1 used, 201077.9 
>>>> buff/cache
>>>> MiB Swap:   3812.0 total,   3812.0 free,      0.0 used. 366194.1 
>>>> avail Mem
>>>>
>>>>
>>>> When now reading a file with a process bound to a cpu on node 1 
>>>> (taskset
>>>> -c cat $file) we see the high io_schedule_timeout rate and very low 
>>>> read
>>>> performance.
>>>>
>>>> This is seen with linux 6.1.76 (debian 12 stable) and linux 6.7.9
>>>> (debian unstable).
>>>>
>>>>
>>>> It appears the bulk page allocations used by btrfs_alloc_page_array 
>>>> will
>>>> have a high failure rate when the per cpu page lists are empty and 
>>>> they
>>>> do not appear to attempt to reclaim memory from the page cache but
>>>> instead return a single page via the normal page allocations. But this
>>>> combined with memalloc_retry_wait called on each iteration causes very
>>>> slow performance.
>>>
>>> Not an expert on NUMA, but I guess there should be some way to balance
>>> the free memory between different numa nodes?
>>>
>>> Can it be done automatically/periodically as a workaround?
>>
>> Dropping data from the page cache is the workaround we are using, via 
>> fadvice(DONTNEED) on the data.
>>
>> Balancing the memory between numa nodes will not help. At some point 
>> both nodes memory is in the caches and the same situation will occur 
>> on both nodes.
>>
>> I have verified this loading the caches on both nodes:
>>
>> # numactl --hardware
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 
>> 40 42 44 46 48 50 52 54 56 58 60 62
>> node 0 size: 192048 MB
>> node 0 free: 2316 MB
>> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 
>> 41 43 45 47 49 51 53 55 57 59 61 63
>> node 1 size: 193524 MB
>> node 1 free: 327 MB
>>
>> and now loading files with processes bound to either node is affected 
>> by this. ]
>>
>>
>>>
>>>>
>>>> Increasing sysctl vm.percpu_pagelist_high_fraction did not yield any
>>>> improvement for the situation, the only workaround seems to be to free
>>>> the page cache on the nodes before reading the data.
>>>>
>>>> Assuming the bulk page allocations functions are intended to not 
>>>> reclaim
>>>> memory when the per core lists are empty probably the way
>>>> btrfs_alloc_page_array handles failure of bulk allocation should be
>>>> revised.
>>>
>>> Any suggestion for improvement?
>>>
>>> In our usage, we can not afford to reclaim page cache, as that may
>>> trigger page writeback, meanwhile we may also in the page writeback 
>>> path
>>> and can lead to deadlock.
>>>
>>> On the other hand, if we allocate pages for compressed read/write from
>>> other NUMA nodes, wouldn't that cause different performance problems?
>>> E.g. we still need to do compression using the page from the remote 
>>> numa
>>> nodes, wouldn't that also greatly reduce the compression speed?
>>
>> The problem we see is not the page allocation itself but the looping 
>> on memalloc_retry_wait when the bulk allocation falls back to single 
>> page allocations due to empty per cpu page lists.
>>
>> My naive suggestion would be to revert the bulk allocation 
>> (91d6ac1d62c3dc0f102986318f4027ccfa22c638) and do single page 
>> allocations again. As far as I can tell the bulk allocation was done 
>> for performance reasons not to avoid deadlocks due to writeback.
>>
>> If the performance gain by the bulk allocation is very significant 
>> maybe the looping on memalloc_retry_wait can be done in some better 
>> way but I am unfamiliar with the details here on why the single page 
>> allocation did not need to do a retry-wait loop and the bulk page 
>> allocation does.
>
> I believe you're right.
>
> The common scheme for bulk allocation should be try the bulk/optimized 
> version, if failed fallback to the single allocation one.
>
> In fact, that's exactly what's I'm trying to do for larger folio 
> support for btrfs metadata.
> In that case, we try larger folio first, then fallback to regular 
> btrfs_alloc_page_array().
>
> So mind to test the attached patch to see if it solves the problem for 
> you?
> The patch would exactly do what I said above, try bulk allocation 
> first, then go single page allocation for the remaining ones, since 
> this version no longer do any way, the behavior should be more or less 
> the same, meanwhile still keep the bulk attempt to benefit from it.


I have applied the patch to the running 6.1 kernel (just needed 
extra_gfp removed) and the problem is not reproducible anymore.

# ensure all memory is used by page cache by reading arbitrary data.

find . -size +100M | taskset -c 1 xargs cat > /dev/null

6.1 unpatched:

# reading compressed file that triggers btrfs_alloc_page_array

  python3 /tmp/drop-caches.py $f; taskset -c 1 cat $f | pv > /dev/null
   2  399MiB 0:02:03 [3.23MiB/s]


6.1 patched:

python3 /tmp/drop-caches.py $f; taskset -c 1 cat $f | pv > /dev/null
  399MiB 0:00:00 [ 710MiB/s] [   <=>


To verify the bulk allocation still returns one only page in the patched 
kernel I ran this trace during reading:

# bpftrace -e "kretfunc:__alloc_pages_bulk {if (args->nr_pages != 
retval) {@allocret = lhist(retval, 0, 20, 1);}}"
Attaching 1 probe...
^C

@allocret:
[1, 2)              9516 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


So the patch does solve the problem for us.



+    const gfp_t gfp = GFP_NOFS | extra_gfp;
+    allocated = alloc_pages_bulk_array(GFP_NOFS | gfp, nr_pages, 
page_array);

The GFP_NOFS | is on alloc_pages_bulk_array redundant.


Thanks,

Julian


