Return-Path: <linux-btrfs+bounces-9426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352489C3FBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85A32829A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2C19E804;
	Mon, 11 Nov 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXc5l5KS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08FB19E7E2
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332657; cv=none; b=XbIOfPf480Sa8sCY0fcHg4AgzDnZJFwVc8VmTeu28TKoI9v5YZn/n47pKOJbFLMngTY1xTZ1zxl4+gASbkM9j/YZRERxlYQQENRLBG5tI2rGHzSfCUx5wONFgUS4ylUwBsI8vzw2hUfkiOtVSxZcYzeJYrO2DOcmJJiOlv5xAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332657; c=relaxed/simple;
	bh=ZSdc1dmMpTsMPnYWfC0knDFc1VA/UxmJVzCqaKMcZA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmloRyI9IbIXdgayDGr5DaQnWwOnVNa31ym8vUqgEh8U26sMpghBga4577y/fc1e8Phu8Atz+xENWgLrBB31y4jfi5xmofWHWG6vi7dYifHGkaWcry91luUNPzsMoXpLPHLvYsV42AMDLECLNfNCLcV4dQrGMY9J+OHjBx1F/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXc5l5KS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E12C4CECF;
	Mon, 11 Nov 2024 13:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731332657;
	bh=ZSdc1dmMpTsMPnYWfC0knDFc1VA/UxmJVzCqaKMcZA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IXc5l5KS1V/bhgMMYrkbb4I4sfr7kLepvTMs1+6CCZGhl/jjxqLX0b3s2TJ5Eqnr+
	 wdT68OzDhm/Zgkfes8CAK1r5d0uL6dX+KoonJCbWX0PDx+IEAj7zkLWNToxPhFwlSe
	 7qjPhYyenljQDyrTuQSfA0jzNVhcT58YuFz3VREi/nnSNMoPUxrdNbU8wh7raGJdh4
	 aJir2lQTTakXQNvaFqOEEmphO+gTdpbqT52ISjPIi+46vHDPTpDzyNPCFBmig7kog5
	 KwqzKwCR/if6Y3XeeUQgnRpLi3VFCwjLWZsuuVxul0MXO76dUG4Ttu32+1RP5ERTYl
	 e/SYllsnQ8eDQ==
Message-ID: <9e934fb2-9fa7-4f66-bc48-55df4c1be142@kernel.org>
Date: Mon, 11 Nov 2024 22:44:14 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: fix use-after-free in btrfs_encoded_read_endio
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <cover.1731316882.git.jth@kernel.org>
 <88ede763421d4f9847a057bdc944cb9c684e8cae.1731316882.git.jth@kernel.org>
 <CAL3q7H7k8buoKnegzh1r4a0zmeErozBOP8JN0jfeBVLeLqDZLQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAL3q7H7k8buoKnegzh1r4a0zmeErozBOP8JN0jfeBVLeLqDZLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 22:27, Filipe Manana wrote:
> On Mon, Nov 11, 2024 at 9:28 AM Johannes Thumshirn <jth@kernel.org> wrote:
>>
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Shinichiro reported the following use-after free that sometimes is
>> happening in our CI system when running fstests' btrfs/284 on a TCMU
>> runner device:
>>
>>    ==================================================================
>>    BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
>>    Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219
>>
>>    CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kts+ #15
>>    Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>>    Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x6e/0xa0
>>     ? lock_release+0x708/0x780
>>     print_report+0x174/0x505
>>     ? lock_release+0x708/0x780
>>     ? __virt_addr_valid+0x224/0x410
>>     ? lock_release+0x708/0x780
>>     kasan_report+0xda/0x1b0
>>     ? lock_release+0x708/0x780
>>     ? __wake_up+0x44/0x60
>>     lock_release+0x708/0x780
>>     ? __pfx_lock_release+0x10/0x10
>>     ? __pfx_do_raw_spin_lock+0x10/0x10
>>     ? lock_is_held_type+0x9a/0x110
>>     _raw_spin_unlock_irqrestore+0x1f/0x60
>>     __wake_up+0x44/0x60
>>     btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
>>     btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
>>     ? lock_release+0x1b0/0x780
>>     ? trace_lock_acquire+0x12f/0x1a0
>>     ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
>>     ? process_one_work+0x7e3/0x1460
>>     ? lock_acquire+0x31/0xc0
>>     ? process_one_work+0x7e3/0x1460
>>     process_one_work+0x85c/0x1460
>>     ? __pfx_process_one_work+0x10/0x10
>>     ? assign_work+0x16c/0x240
>>     worker_thread+0x5e6/0xfc0
>>     ? __pfx_worker_thread+0x10/0x10
>>     kthread+0x2c3/0x3a0
>>     ? __pfx_kthread+0x10/0x10
>>     ret_from_fork+0x31/0x70
>>     ? __pfx_kthread+0x10/0x10
>>     ret_from_fork_asm+0x1a/0x30
>>     </TASK>
>>
>>    Allocated by task 3661:
>>     kasan_save_stack+0x30/0x50
>>     kasan_save_track+0x14/0x30
>>     __kasan_kmalloc+0xaa/0xb0
>>     btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
>>     send_extent_data+0xf0f/0x24a0 [btrfs]
>>     process_extent+0x48a/0x1830 [btrfs]
>>     changed_cb+0x178b/0x2ea0 [btrfs]
>>     btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>>     _btrfs_ioctl_send+0x117/0x330 [btrfs]
>>     btrfs_ioctl+0x184a/0x60a0 [btrfs]
>>     __x64_sys_ioctl+0x12e/0x1a0
>>     do_syscall_64+0x95/0x180
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>    Freed by task 3661:
>>     kasan_save_stack+0x30/0x50
>>     kasan_save_track+0x14/0x30
>>     kasan_save_free_info+0x3b/0x70
>>     __kasan_slab_free+0x4f/0x70
>>     kfree+0x143/0x490
>>     btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
>>     send_extent_data+0xf0f/0x24a0 [btrfs]
>>     process_extent+0x48a/0x1830 [btrfs]
>>     changed_cb+0x178b/0x2ea0 [btrfs]
>>     btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>>     _btrfs_ioctl_send+0x117/0x330 [btrfs]
>>     btrfs_ioctl+0x184a/0x60a0 [btrfs]
>>     __x64_sys_ioctl+0x12e/0x1a0
>>     do_syscall_64+0x95/0x180
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>    The buggy address belongs to the object at ffff888106a83f00
>>     which belongs to the cache kmalloc-rnd-07-96 of size 96
>>    The buggy address is located 24 bytes inside of
>>     freed 96-byte region [ffff888106a83f00, ffff888106a83f60)
>>
>>    The buggy address belongs to the physical page:
>>    page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888106a83800 pfn:0x106a83
>>    flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>>    page_type: f5(slab)
>>    raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 0000000000000004
>>    raw: ffff888106a83800 0000000080200019 00000001f5000000 0000000000000000
>>    page dumped because: kasan: bad access detected
>>
>>    Memory state around the buggy address:
>>     ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>     ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>    >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>                                ^
>>     ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>>     ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>    ==================================================================
>>
>> Further analyzing the trace and the crash dump's vmcore file shows that
>> the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
>> the wait_queue that is in the private data passed to the end_io handler.
>>
>> Commit 4ff47df40447 ("btrfs: move priv off stack in
>> btrfs_encoded_read_regular_fill_pages()") moved 'struct
>> btrfs_encoded_read_private' off the stack.
>>
>> Before that commit one can see a corruption of the private data when
>> analyzing the vmcore after a crash:
> 
> Can you highlight what's the corruption?
> Just dumping a large structure isn't immediately obvious, I suppose
> you mean it's related to the large negative values of the atomic
> counters?
> 
>>
>> *(struct btrfs_encoded_read_private *)0xffff88815626eec8 = {
>>         .wait = (wait_queue_head_t){
>>                 .lock = (spinlock_t){
>>                         .rlock = (struct raw_spinlock){
>>                                 .raw_lock = (arch_spinlock_t){
>>                                         .val = (atomic_t){
>>                                                 .counter = (int)-2005885696,
>>                                         },
>>                                         .locked = (u8)0,
>>                                         .pending = (u8)157,
>>                                         .locked_pending = (u16)40192,
>>                                         .tail = (u16)34928,
>>                                 },
>>                                 .magic = (unsigned int)536325682,
>>                                 .owner_cpu = (unsigned int)29,
>>                                 .owner = (void *)__SCT__tp_func_btrfs_transaction_commit+0x0 = 0x0,
>>                                 .dep_map = (struct lockdep_map){
>>                                         .key = (struct lock_class_key *)0xffff8881575a3b6c,
>>                                         .class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
>>                                         .name = (const char *)0xffff88815626f100 = "",
>>                                         .wait_type_outer = (u8)37,
>>                                         .wait_type_inner = (u8)178,
>>                                         .lock_type = (u8)154,
>>                                 },
>>                         },
>>                         .__padding = (u8 [24]){ 0, 157, 112, 136, 50, 174, 247, 31, 29 },
>>                         .dep_map = (struct lockdep_map){
>>                                 .key = (struct lock_class_key *)0xffff8881575a3b6c,
>>                                 .class_cache = (struct lock_class *[2]){ 0xffff8882a71985c0, 0xffffea00066f5d40 },
>>                                 .name = (const char *)0xffff88815626f100 = "",
>>                                 .wait_type_outer = (u8)37,
>>                                 .wait_type_inner = (u8)178,
>>                                 .lock_type = (u8)154,
>>                         },
>>                 },
>>                 .head = (struct list_head){
>>                         .next = (struct list_head *)0x112cca,
>>                         .prev = (struct list_head *)0x47,
>>                 },
>>         },
>>         .pending = (atomic_t){
>>                 .counter = (int)-1491499288,
>>         },
>>         .status = (blk_status_t)130,
>> }
>>
>> Move the call to bio_put() before the atomic_test operation and
>> also change atomic_dec_return() to atomic_dec_and_test() to fix the
>> corruption, as atomic_dec_return() is defined as two instructions on
>> x86_64, whereas atomic_dec_and_test() is defineda s a single atomic
>> operation.
> 
> And why does this fixes the problem?
> 
> Can we also get a description here about why the corruption happens?
> Having this may be enough to understand why these changes fix the bug.

Waking up the issuer before doing the bio put can result in the issuer function
returning before the bio is cleaned up. Which is weird... But thinking more
about this, it is probably not a bug in itself since the bbio is allocated and
not on the stack of the issuer.

What is definitely a bug is that there is nothing atomic with:

if (atomic_dec_return(&priv->pending) == 0)
	wake_up(&priv->wait);

on the completion side and

if (atomic_dec_return(&priv.pending))
	io_wait_event(priv.wait, !atomic_read(&priv.pending));

on the issuer side (btrfs_encoded_read_regular_fill_pages()).

The atomic_dec_return() on the completion side can cause io_wait_event() to
return and thus have the issuer return *BEFORE* the completion side has a chance
to call wake_up(&priv->wait), because the "if" is not fully processed yet as the
comparison with 0 is still needed. And given that priv is on the stack of the
issuer, the wake_up() call can endup referencing invalid memory.

Johannes,

I think more and more that the proper fix is to squash your 2 patches together
to avoid all these dangerous games played with the pending atomic.

-- 
Damien Le Moal
Western Digital Research

