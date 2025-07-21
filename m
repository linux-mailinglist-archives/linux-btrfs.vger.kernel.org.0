Return-Path: <linux-btrfs+bounces-15610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F21B0CA26
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A42F188AE3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2C2BDC2C;
	Mon, 21 Jul 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGSt9txn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5862B9A8
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120404; cv=none; b=oX3I/ejdnGs85SD7L60q5LvoEcraXD2FQ8xRlE46pzU/N/j35ulUkXTg+SJAz+ELoxWrojLEDe29Czxn2zd/HnbWB/nUDUSLrq45vQP9k9QgUdHEOcf/XZb5Tv2gBgqcf1xz5+hkKdYsv1UuOw8unmL9PapLa/CzS7zGU4ra37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120404; c=relaxed/simple;
	bh=4FYZPxbsl8W6uwI0ulJpGR2a+CiXHLM+4lwZdFpQ9/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4U1Ska0UIOoGrE5faL/RrSZwUYX+iGOfhKxw2+g8GeSwcit2Onbd+4xXt3gV4g1sd6b2HPV/cl09KfMpvmXOk8fBTHdwlaz4gFBosvJpGBi11w6HVUKF2BUumlXqcaUNDpCKDyOePkslDiYC8isuvg2uNuBoPQV0lOL3kgXGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGSt9txn; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8bacc192e0so3646295276.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 10:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753120402; x=1753725202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exC0oUKm9ItXCGgWuN09qzkgvCVuEiJZnfgCtI4FWl8=;
        b=jGSt9txnGbZRAN3Bz45Vl4WhFhbklqBXgcvdKRTYihZdUKEWbnvnDD7K41jGt6IV9X
         Lx4IAE2al/2phvreAZijEBxOkkP447zYzi+kwN2vvFX8TD/pEv6zSDSV4SB6GidAwoJe
         vBy1ERyOx/93UJQGPrRifK1EgNDl+EqvMzQGMabW99ZP+Q/ftsTj85mlmTZdMPjcsreD
         piJYlmQ7+edNqa69MAPnwKW7Wh858W6qAHGVJojiD2oZP6WFOQS1vdjLYRZD9dNzYAPC
         E/qh+E5l697FKFG5qwye+exQDmlFJ6DV6uQIycVOKeWtvfjCWQ8dDzDgZCoYHQJaeFeK
         ZgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120402; x=1753725202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exC0oUKm9ItXCGgWuN09qzkgvCVuEiJZnfgCtI4FWl8=;
        b=o11yKze5rJpH+W0aVyUAwjhMYwNS36QAXJ2MLNpZjgC+nYUYcv0LPh1W2WveuTEoBR
         iOL6i806etkbrR5o5vpat/70g6tA+P7Ki0YIQ/QRuq8NqA38xEfsS4sXbFEwSOoBBTcq
         o5JHw/20jHyFeZYdwRl8VFJqlYP2TSC8u+n5NeJ07RErlF+sU/YDHC2xx9dpKngcEHyp
         v4M/W3rtPzON4/bKhqhjF4qwoZj9gvdS7G0VSFcBVX8saxklL1FTkgFpzZPdwqCD/g67
         f0JY0TdASnrpib/oWNPY7I2r2Jhr1FR+gHQdrIg7lOfB0QnbWyOwoP+IQ/J+a+FjNll2
         vGmQ==
X-Gm-Message-State: AOJu0YxK6ZVhFWkmPZF3G0ERtb7T+riFsC7KqS/rCzj5HNqceRz/R4I5
	ZQpAjOcY3JKqNWyzEC4ftJFHvPrqNCXsTRToi43AqEx75n5UxpOL8lU8
X-Gm-Gg: ASbGncta5Aw0Rn2mGJXUja9Vn3oo26lczOa//ghYvnSCZeKqzGyufGgwx0PKfXR5vA3
	hL1H7pCVB/wyt3jrxUVllD2pIPmasNftxVs4aq5WUozlYJ2Npwz/A21RJI/gpOUEn/Ig+hrnknz
	NMHQjXNb3ko7Ho/cj+PZXlvf5hnxoDIQDk11uQ0sU9DqD78dQVWy0FQ+1ylbCW52WyhKq6y7BNT
	/v8bBvVoFmwFhNrADYxpszIFf88FPkgaL2ogadVlGEY3eoOQOEmLWf1E7PQk7uAhAhSRGZfWkPQ
	N4QVc1EgQcTuCO5MmOnO6ncZiHN/nXHS50AhthbhLqCvSKS+/iH5RfvIxiQaiETpOjKnf84+5Vq
	yY+NK7K5haNrT/HaD
X-Google-Smtp-Source: AGHT+IEZB5eZ7nqw299fk0xAw6HK6TBYV8l2rmPNFW3NdAMmazzSlLah9A1e3ue/cLOsCPOe+BwvTA==
X-Received: by 2002:a05:6902:1505:b0:e8d:6fa9:b44b with SMTP id 3f1490d57ef6-e8d6fa9b793mr18931678276.45.1753120401798;
        Mon, 21 Jul 2025 10:53:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce114c8sm2639107276.34.2025.07.21.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:53:21 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3] btrfs: fix subpage deadlock
Date: Mon, 21 Jul 2025 10:52:25 -0700
Message-ID: <20250721175306.399089-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <ae190cf1bf4782e5abe4702f7f9758c2864053b5.1753119955.git.loemra.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 10:49:16 -0700 Leo Martins <loemra.dev@gmail.com> wrote:

> There is a potential deadlock that can happen in
> try_release_subpage_extent_buffer because the irq-safe
> xarray spin lock fs_info->buffer_tree is being
> acquired before the irq-unsafe eb->refs_lock.
> 
> This leads to the potential race:
> // T1 (random eb->refs user)                  // T2 (release folio)
> 
> spin_lock(&eb->refs_lock);
> // interrupt
> end_bbio_meta_write()
>   btrfs_meta_folio_clear_writeback()
>                                               btree_release_folio()
>                                                 folio_test_writeback() //false
>                                                 try_release_extent_buffer()
>                                                   try_release_subpage_extent_buffer()
>                                                     xa_lock_irq(&fs_info->buffer_tree)
>                                                     spin_lock(&eb->refs_lock); // blocked; held by T1
>   buffer_tree_clear_mark()
>     xas_lock_irqsave() // blocked; held by T2
> 
> I believe that the spin lock can safely be replaced by an rcu_read_lock.
> The xa_for_each loop does not need the spin lock as it's already
> internally protected by the rcu_read_lock. The extent buffer
> is also protected by the rcu_read_lock so it won't be freed before we
> take the eb->refs_lock and check the ref count.
> 
> The rcu_read_lock is taken and released every iteration, just like the
> spin lock, which means we're not protected against concurrent
> insertions into the xarray. This is fine because we rely on
> folio->private to detect if there are any eb's remaining in the folio.
> 
> There is already some precedent for this with find_extent_buffer_nolock,
> which loads an extent buffer from the xarray with only rcu_read_lock.
> 
> lockdep warning:
> 
>             =====================================================
>             WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>             6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G
> E    N
>             -----------------------------------------------------
>             kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>             ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at:
> try_release_extent_buffer+0x18c/0x560
> 
> and this task is already holding:
>             ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at:
> try_release_extent_buffer+0x13c/0x560
>             which would create a new lock dependency:
>              (&buffer_xa_class){-.-.}-{3:3} ->
> (&eb->refs_lock){+.+.}-{3:3}
> 
> but this new dependency connects a HARDIRQ-irq-safe lock:
>              (&buffer_xa_class){-.-.}-{3:3}
> 
> ... which became HARDIRQ-irq-safe at:
>               lock_acquire+0x178/0x358
>               _raw_spin_lock_irqsave+0x60/0x88
>               buffer_tree_clear_mark+0xc4/0x160
>               end_bbio_meta_write+0x238/0x398
>               btrfs_bio_end_io+0x1f8/0x330
>               btrfs_orig_write_end_io+0x1c4/0x2c0
>               bio_endio+0x63c/0x678
>               blk_update_request+0x1c4/0xa00
>               blk_mq_end_request+0x54/0x88
>               virtblk_request_done+0x124/0x1d0
>               blk_mq_complete_request+0x84/0xa0
>               virtblk_done+0x130/0x238
>               vring_interrupt+0x130/0x288
>               __handle_irq_event_percpu+0x1e8/0x708
>               handle_irq_event+0x98/0x1b0
>               handle_fasteoi_irq+0x264/0x7c0
>               generic_handle_domain_irq+0xa4/0x108
>               gic_handle_irq+0x7c/0x1a0
>               do_interrupt_handler+0xe4/0x148
>               el1_interrupt+0x30/0x50
>               el1h_64_irq_handler+0x14/0x20
>               el1h_64_irq+0x6c/0x70
>               _raw_spin_unlock_irq+0x38/0x70
>               __run_timer_base+0xdc/0x5e0
>               run_timer_softirq+0xa0/0x138
>               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
>               ____do_softirq.llvm.17674514681856217165+0x18/0x28
>               call_on_irq_stack+0x24/0x30
>               __irq_exit_rcu+0x164/0x430
>               irq_exit_rcu+0x18/0x88
>               el1_interrupt+0x34/0x50
>               el1h_64_irq_handler+0x14/0x20
>               el1h_64_irq+0x6c/0x70
>               arch_local_irq_enable+0x4/0x8
>               do_idle+0x1a0/0x3b8
>               cpu_startup_entry+0x60/0x80
>               rest_init+0x204/0x228
>               start_kernel+0x394/0x3f0
>               __primary_switched+0x8c/0x8958
> 
> to a HARDIRQ-irq-unsafe lock:
>              (&eb->refs_lock){+.+.}-{3:3}
> 
> ... which became HARDIRQ-irq-unsafe at:
>             ...
>               lock_acquire+0x178/0x358
>               _raw_spin_lock+0x4c/0x68
>               free_extent_buffer_stale+0x2c/0x170
>               btrfs_read_sys_array+0x1b0/0x338
>               open_ctree+0xeb0/0x1df8
>               btrfs_get_tree+0xb60/0x1110
>               vfs_get_tree+0x8c/0x250
>               fc_mount+0x20/0x98
>               btrfs_get_tree+0x4a4/0x1110
>               vfs_get_tree+0x8c/0x250
>               do_new_mount+0x1e0/0x6c0
>               path_mount+0x4ec/0xa58
>               __arm64_sys_mount+0x370/0x490
>               invoke_syscall+0x6c/0x208
>               el0_svc_common+0x14c/0x1b8
>               do_el0_svc+0x4c/0x60
>               el0_svc+0x4c/0x160
>               el0t_64_sync_handler+0x70/0x100
>               el0t_64_sync+0x168/0x170
> 
> other info that might help us debug this:
>              Possible interrupt unsafe locking scenario:
>                    CPU0                    CPU1
>                    ----                    ----
>               lock(&eb->refs_lock);
>                                            local_irq_disable();
>                                            lock(&buffer_xa_class);
>                                            lock(&eb->refs_lock);
>               <Interrupt>
>                 lock(&buffer_xa_class);
> 
>   *** DEADLOCK ***
>             2 locks held by kswapd0/66:
>              #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at:
> balance_pgdat+0xe8/0xe50
>              #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at:
> try_release_extent_buffer+0x13c/0x560
> 
> Link: https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
> ---
> Changelog:
> v3:
> - change example to better reflect a possible deadlock
> - fix "precedence" -> "precedent"
> - add link tag for lockdep documentation link
> - no code changes

Sorry, there was actually one code change, I removed the rcupdate import.

> v2:
> - include lockdep warning in commit message
> - add information about why rcu_read_lock is safe
> - no code changes
> ---
>  fs/btrfs/extent_io.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6192e1f58860..82da27d5e001 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4332,15 +4332,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
>  	int ret;
>  
> -	xa_lock_irq(&fs_info->buffer_tree);
> +	rcu_read_lock();
>  	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>  		/*
>  		 * The same as try_release_extent_buffer(), to ensure the eb
>  		 * won't disappear out from under us.
>  		 */
>  		spin_lock(&eb->refs_lock);
> +		rcu_read_unlock();
> +
>  		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
>  			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>  			continue;
>  		}
>  
> @@ -4359,11 +4362,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  		 * check the folio private at the end.  And
>  		 * release_extent_buffer() will release the refs_lock.
>  		 */
> -		xa_unlock_irq(&fs_info->buffer_tree);
>  		release_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> +		rcu_read_lock();
>  	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
> +	rcu_read_unlock();
>  
>  	/*
>  	 * Finally to check if we have cleared folio private, as if we have
> @@ -4376,7 +4378,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  		ret = 0;
>  	spin_unlock(&folio->mapping->i_private_lock);
>  	return ret;
> -
>  }
>  
>  int try_release_extent_buffer(struct folio *folio)
> -- 
> 2.47.1

Sent using hkml (https://github.com/sjp38/hackermail)

