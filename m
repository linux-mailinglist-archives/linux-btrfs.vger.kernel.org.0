Return-Path: <linux-btrfs+bounces-3226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172F879534
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 14:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24B81C22014
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C537A154;
	Tue, 12 Mar 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="eMr++wuj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.15.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71125A939
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250696; cv=none; b=gTcS+PxLefZ3s5rpI7IuexZhVJ3jcjNZF4wGTlNyaoUifogNR73Ckd50LpWsHY/HNk/t4MrzvSiq6Nps1YgwvJTXCZpds+5zv+GcHixLsXpgkbP53sZUBgcOf8HXsqmUGX7WewTnbawtMmtuianYlDwzuQFJ3Xla5XHNPS5V6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250696; c=relaxed/simple;
	bh=uUEW0qBhecZHGuBLwS04RHTD/12bmTqspGNZB5fQfD8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=Zb7+QuwigJpIlGE0yVpmrWVA2FFEOAEBjpGWgJcFWSDi/or1rtE4PAOm7u0C516FCAulEZgLyYOq5dZWJW/8tVBxCpJls0c5JPMATYT4lK0W+65q9B27W/4LeSkMQY062kWmIiVE8YQPYzrAPSG0InkMZlpS+BhjCe1cQmS/AVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=eMr++wuj; arc=none smtp.client-ip=212.227.15.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	 s=corp1; h=Subject:To:From:MIME-Version:Date:Message-ID:cc:sender:reply-to;
	 bh=vxxJlAwUzsg5LPEm8OxGT8WJzNvD8riTZatvc5b61AU=; b=eMr++wujNF3yxhX4sYcusCD5I
	pZfOUrpJ4OA27xUW73H7Ufvyq0uHDTqmQqmPdPMbxXzNzsi1TOqg29wZ23Zn+awlo/wM1smHwXkQd
	2cOIN5kRErusNR91KQXFqXNp9JqrKxzqI4kSYtxKeACD2zIbep2h0mlEozJFB2KB6TiVnHh140G4r
	xqC+Sci1v2w7vbce+gcR4nj7vmyDJ4pjomhcAHoNf5Qmg9CBpkVhvb1UOgwk325PF5iJoAu4t5nxA
	W8UaZvZdN+aGm7qQQsxubN2oABx6SFXvBO8fbd5HbdegPrzLJ8HbKw7OBmcbMx4q+Q/DPmoQntI1O
	Pf3RomHUQ==;
Received: from [10.98.28.7] (helo=KAPPEX022.united.domain)
	by mrint.1and1.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <julian.taylor@1und1.de>)
	id 1rk2IE-0006tX-SE
	for linux-btrfs@vger.kernel.org; Tue, 12 Mar 2024 14:35:46 +0100
Message-ID: <8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de>
Date: Tue, 12 Mar 2024 14:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
To: <linux-btrfs@vger.kernel.org>
Subject: slow performance due to frequent memalloc_retry_wait in
 btrfs_alloc_page_array
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BAPPEX021.united.domain (10.98.29.6) To
 KAPPEX022.united.domain (10.98.28.7)
X-Virus-Scanned: ClamAV@mvs-ha-bs

Hello,

After upgrading a machine using btrfs to a 6.1 kernel from 5.10 we are 
experiencing very low read performance on some (compressed) files when 
most of the nodes memory is in use by applications and the filesystem 
cache. Reading some files does not exceed 5MiB/second while the 
underlying disks can sustain ~800MiB/s. The load on the machine while 
reading the files slowly is basically zero

The filesystem is mounted with

  btrfs (rw,relatime,compress=zstd:3,space_cache=v2,subvolid=5,subvol=/)

The filesystem contains several snapshot volumes.

Checking with blktrace we noticed a lot of queue unplug events which 
when traced showed that the cause is most likely io_schedule_timeout 
being called extremely frequent from btrfs_alloc_page_array which since 
5.19 (91d6ac1d62c3dc0f102986318f4027ccfa22c638) uses bulk page 
allocations with a memalloc_retry_wait on failure:

$ perf record -e block:block_unplug -g

$ perf script

         ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246 
([kernel.kallsyms])
         ffffffffa3bbff86 blk_mq_flush_plug_list.part.0+0x246 
([kernel.kallsyms])
         ffffffffa3bb1205 __blk_flush_plug+0xf5 ([kernel.kallsyms])
         ffffffffa4213f15 io_schedule_timeout+0x45 ([kernel.kallsyms])
         ffffffffc0c74d42 btrfs_alloc_page_array+0x42 ([kernel.kallsyms])
         ffffffffc0ca8c2e btrfs_submit_compressed_read+0x16e 
([kernel.kallsyms])
         ffffffffc0c724f8 submit_one_bio+0x48 ([kernel.kallsyms])
         ffffffffc0c75295 btrfs_do_readpage+0x415 ([kernel.kallsyms])
         ffffffffc0c766d1 extent_readahead+0x2e1 ([kernel.kallsyms])
         ffffffffa3904bf2 read_pages+0x82 ([kernel.kallsyms])

When bottlenecked in this code the allocations of less than 10 pages  
only receives a single page per loop so it runs into the 
io_schedule_timeout every time.

Tracing the arguments while reading on slow performance shows:

# bpftrace -e "kfunc:btrfs_alloc_page_array {@pages = 
lhist(args->nr_pages, 0, 20, 1)} kretfunc:__alloc_pages_bulk {@allocret 
= lhist(retval, 0, 20, 1)}"
Attaching 2 probes...


@allocret:
[1, 2)               298 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[2, 3)               295 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[3, 4)               295 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
[4, 5)               300 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@pages:
[4, 5)               295 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|


Further checking why the bulk page allocations only return a single page 
we noticed this is only happening when all memory of the node is tied up 
even if still reclaimable.

It can be reliably reproduced on the machine when filling the page cache 
with data from the disk (just via cat * >/dev/null) until we are have 
following memory situation on the node with two sockets:

$numactl --hardware

available: 2 nodes (0-1)

node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 
42 44 46 48 50 52 54 56 58 60 62
node 0 size: 192048 MB
node 0 free: 170340 MB
node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 
43 45 47 49 51 53 55 57 59 61 63
node 1 size: 193524 MB
node 1 free: 224 MB        <<< nothing free due to cache

$ top

MiB Mem : 385573.2 total, 170093.0 free,  19379.1 used, 201077.9 buff/cache
MiB Swap:   3812.0 total,   3812.0 free,      0.0 used. 366194.1 avail Mem


When now reading a file with a process bound to a cpu on node 1 (taskset 
-c cat $file) we see the high io_schedule_timeout rate and very low read 
performance.

This is seen with linux 6.1.76 (debian 12 stable) and linux 6.7.9 
(debian unstable).


It appears the bulk page allocations used by btrfs_alloc_page_array will 
have a high failure rate when the per cpu page lists are empty and they 
do not appear to attempt to reclaim memory from the page cache but 
instead return a single page via the normal page allocations. But this 
combined with memalloc_retry_wait called on each iteration causes very 
slow performance.

Increasing sysctl vm.percpu_pagelist_high_fraction did not yield any 
improvement for the situation, the only workaround seems to be to free 
the page cache on the nodes before reading the data.

Assuming the bulk page allocations functions are intended to not reclaim 
memory when the per core lists are empty probably the way 
btrfs_alloc_page_array handles failure of bulk allocation should be revised.


Cheers,

Julian Taylor


