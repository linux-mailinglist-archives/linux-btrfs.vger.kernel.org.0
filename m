Return-Path: <linux-btrfs+bounces-15586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4422B0C097
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC52D17E319
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A35579E;
	Mon, 21 Jul 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="nSG7RzXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004528C868
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091208; cv=none; b=Ic/ED3L1JQCF9gTTY4dL2V6UexlU4xDg+gDIsFb8bI544WcSJBfdyLf70HOIbZiFZz38/Uy+MM+sxt+jj8UHxSG+7heAFwXkLCEOTGy/wVLBxrTMIBn7CE8SbWbu3PxuVv1q4JWLg3W8YwDrTLbDoOkEt1+0QiAFy9x+Nt3bu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091208; c=relaxed/simple;
	bh=+URQEK1vdDKa3HAl8j3B8CDEkefwsTybkjqSNvdO04E=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bE2r4YdYow1U+erFxiTDT1LCAlMWBZjCMNlk9jJ1lyGObKdl3ApQ1+btSl3dncyVXNBlPr8nsM2AWdg79fHXVdi8vlrn8MFDSdtp1CIK/EcOtMYcylT6uD0N+fcnaxqqq4giqCUgphV37RexECLOKpO6JltcH4/iH7ZmOnI9XTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=nSG7RzXX; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 2C39B29DC92;
	Mon, 21 Jul 2025 10:46:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1753091201;
	bh=eLJwcvfuD70qtN+kuhuefZCjpINKNm+agc/v84LNGjs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=nSG7RzXXcOrm8D9+S6MlPe0k7KZtIwJgs3LYDwJxigi4qlu3FtMQ9NvtqkFxWDg/R
	 tCj0k4Ryu0BkspxxlcUsff87l8cuxoUudiWotdQidMajtMpJN+r5C0vIclSQYhn+x8
	 lmFlKJxua4KZ0AZwCeano86LrmWDDCzprzX3cZNM=
Message-ID: <73325ab0-a367-4909-9ae5-8d5c97e6c309@harmstone.com>
Date: Mon, 21 Jul 2025 10:46:41 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] btrfs: fix subpage deadlock
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org
References: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <5df8399c15d9265fae8b069dc481ca077810a609.1752882493.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I don't think we even need the rcu_read_lock(). The xa_for_each_range
macro calls xa_find() and xa_find_after(), both of which call
rcu_read_lock() themselves.

The call to rcu_read_lock() in find_extent_buffer_nolock() is
probably also unnecessary.

Mark

On 19/07/2025 12.56 am, Leo Martins wrote:
> There is a potential deadlock that can happen in
> try_release_subpage_extent_buffer because the irq-safe
> xarray spin lock fs_info->buffer_tree is being
> acquired before the irq-unsafe eb->refs_lock.
> 
> This leads to the potential race:
> 
> ```
> // T1                                   // T2
> xa_lock_irq(&fs_info->buffer_tree)
>                                          spin_lock(&eb->refs_lock)
>                                          // interrupt
>                                          xa_lock_irq(&fs_info->buffer_tree)
> spin_lock(&eb->refs_lock)
> ```
> 
> https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A
> 
> I believe that the spin lock can safely be replaced by an rcu_read_lock.
> The xa_for_each loop does not need the spin lock as it's already
> internally protected by the rcu_read_lock. The extent buffer
> is also protected by the rcu_read_lock so it won't be freed before we
> take the eb->refs_lock.
> 
> The rcu_read_lock is taken and released every iteration, just like the
> spin lock, which means we're not protected against concurrent
> insertions into the xarray. This is fine because we rely on folio->private
> to detect if there are any eb's remaining in the folio.
> 
> There is already some precedence for this with find_extent_buffer_nolock,
> which loads an extent buffer from the xarray with only rcu_read_lock.
> 
> lockdep warning:
> 
>              =====================================================
>              WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>              6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N
>              -----------------------------------------------------
>              kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>              ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560
> 
> and this task is already holding:
>              ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
>              which would create a new lock dependency:
>               (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}
> 
> but this new dependency connects a HARDIRQ-irq-safe lock:
>               (&buffer_xa_class){-.-.}-{3:3}
> 
> ... which became HARDIRQ-irq-safe at:
>                lock_acquire+0x178/0x358
>                _raw_spin_lock_irqsave+0x60/0x88
>                buffer_tree_clear_mark+0xc4/0x160
>                end_bbio_meta_write+0x238/0x398
>                btrfs_bio_end_io+0x1f8/0x330
>                btrfs_orig_write_end_io+0x1c4/0x2c0
>                bio_endio+0x63c/0x678
>                blk_update_request+0x1c4/0xa00
>                blk_mq_end_request+0x54/0x88
>                virtblk_request_done+0x124/0x1d0
>                blk_mq_complete_request+0x84/0xa0
>                virtblk_done+0x130/0x238
>                vring_interrupt+0x130/0x288
>                __handle_irq_event_percpu+0x1e8/0x708
>                handle_irq_event+0x98/0x1b0
>                handle_fasteoi_irq+0x264/0x7c0
>                generic_handle_domain_irq+0xa4/0x108
>                gic_handle_irq+0x7c/0x1a0
>                do_interrupt_handler+0xe4/0x148
>                el1_interrupt+0x30/0x50
>                el1h_64_irq_handler+0x14/0x20
>                el1h_64_irq+0x6c/0x70
>                _raw_spin_unlock_irq+0x38/0x70
>                __run_timer_base+0xdc/0x5e0
>                run_timer_softirq+0xa0/0x138
>                handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>                ____do_softirq.llvm.17674514681856217165+0x18/0x28
>                call_on_irq_stack+0x24/0x30
>                __irq_exit_rcu+0x164/0x430
>                irq_exit_rcu+0x18/0x88
>                el1_interrupt+0x34/0x50
>                el1h_64_irq_handler+0x14/0x20
>                el1h_64_irq+0x6c/0x70
>                arch_local_irq_enable+0x4/0x8
>                do_idle+0x1a0/0x3b8
>                cpu_startup_entry+0x60/0x80
>                rest_init+0x204/0x228
>                start_kernel+0x394/0x3f0
>                __primary_switched+0x8c/0x8958
> 
> to a HARDIRQ-irq-unsafe lock:
>               (&eb->refs_lock){+.+.}-{3:3}
> 
> ... which became HARDIRQ-irq-unsafe at:
>              ...
>                lock_acquire+0x178/0x358
>                _raw_spin_lock+0x4c/0x68
>                free_extent_buffer_stale+0x2c/0x170
>                btrfs_read_sys_array+0x1b0/0x338
>                open_ctree+0xeb0/0x1df8
>                btrfs_get_tree+0xb60/0x1110
>                vfs_get_tree+0x8c/0x250
>                fc_mount+0x20/0x98
>                btrfs_get_tree+0x4a4/0x1110
>                vfs_get_tree+0x8c/0x250
>                do_new_mount+0x1e0/0x6c0
>                path_mount+0x4ec/0xa58
>                __arm64_sys_mount+0x370/0x490
>                invoke_syscall+0x6c/0x208
>                el0_svc_common+0x14c/0x1b8
>                do_el0_svc+0x4c/0x60
>                el0_svc+0x4c/0x160
>                el0t_64_sync_handler+0x70/0x100
>                el0t_64_sync+0x168/0x170
> 
> other info that might help us debug this:
>               Possible interrupt unsafe locking scenario:
>                     CPU0                    CPU1
>                     ----                    ----
>                lock(&eb->refs_lock);
>                                             local_irq_disable();
>                                             lock(&buffer_xa_class);
>                                             lock(&eb->refs_lock);
>                <Interrupt>
>                  lock(&buffer_xa_class);
> 
>    *** DEADLOCK ***
>              2 locks held by kswapd0/66:
>               #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
>               #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
> 
> Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>   fs/btrfs/extent_io.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6192e1f58860..060e509cfb18 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/rcupdate.h>
>   #include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/bio.h>
> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>   	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
>   	int ret;
>   
> -	xa_lock_irq(&fs_info->buffer_tree);
> +	rcu_read_lock();
>   	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>   		/*
>   		 * The same as try_release_extent_buffer(), to ensure the eb
>   		 * won't disappear out from under us.
>   		 */
>   		spin_lock(&eb->refs_lock);
> +		rcu_read_unlock();
> +
>   		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
>   			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>   			continue;
>   		}
>   
> @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>   		 * check the folio private at the end.  And
>   		 * release_extent_buffer() will release the refs_lock.
>   		 */
> -		xa_unlock_irq(&fs_info->buffer_tree);
>   		release_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> +		rcu_read_lock();
>   	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
> +	rcu_read_unlock();
>   
>   	/*
>   	 * Finally to check if we have cleared folio private, as if we have
> @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>   		ret = 0;
>   	spin_unlock(&folio->mapping->i_private_lock);
>   	return ret;
> -
>   }
>   
>   int try_release_extent_buffer(struct folio *folio)


