Return-Path: <linux-btrfs+bounces-15551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B78B0A9AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 19:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A6D3B95B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91262E7F13;
	Fri, 18 Jul 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsyKDhWs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD392E7F01
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752860439; cv=none; b=NGJFbbtMYIeK94AUcaaqE+iCZl2wM/1fqYKGej/rjLn3tWUt8T3qKsZ1BlcfYAZybLJuMr28X8u4iPJ4NiFiv3nqP9T5psnQc2UVRr0MQoHrX6MIHS4KJ9VxZwd0NJm9WiY67o/sCvT7P+1zp20/gofKSiDzvaH7AsxihoqnAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752860439; c=relaxed/simple;
	bh=3ydKJzG1urMyKBpp6Z/yWE3WRqTKfHYsgNOUxDeruPM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/2Ur4spFfBOGYJfBhv5M4aGtlaIeXb1OXX7XsueBJ93AqhUnUMAVQ/MZd/0S8kXCu5kM1bzluK4qFrv1f0iq1ZAIKtrDapxDYFI5R/7hTbldkjJ6XQXqkHik9zU7je4b3jRh1+06672+i5CkzR6Hb0mxxI67QlilJ5jsjKyyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsyKDhWs; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e8c475ecd5bso2017661276.1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752860435; x=1753465235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfYUjhT36ZCWyY70xsuliHaLCwobgCIkBHTOKCV0qhQ=;
        b=NsyKDhWsK4GvAWbwiJ6SyONITiyS8MYV9F0jY4cNqQr3W7aKVTrNtC3hw2DFFwFZIC
         DRUufe2C4rfvwId2PFAwmG+zUfq8C3aTw4x6o9dgf8tCB6nOd/Z7ZVEpN7cZM+rgao21
         rP479oIkUPLiMAkTeffVDvSMEdcvkE0LyVfSBN/ko5zZ9Vfy3jH2OoddMme0Bu9eM6Q8
         O1Q85OKHt3VxpuHU7P0YZNX9kmuepklaBKW0Z6SgAHURo+9+LYXfq3wNLKo6peKy4RF7
         FDT1oTEc16zSr2CQm9XWJY53RDUGFYEjFAuMA53cUs4yynXDFgvZ1JMhiscwkPJf7utl
         6MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752860435; x=1753465235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfYUjhT36ZCWyY70xsuliHaLCwobgCIkBHTOKCV0qhQ=;
        b=JgJjOSv7q0L8ttxv1fYxS72P0P+IWEHG2fVHM2+FmpbyeHvG0Dqu3Ygnxrxlg/53kc
         yPn6g/2HvX25/+5bX+dcQrx4vDZiRsyKqEfM2zic3NGL+z+a2O4wDwwMLPb4OIWhEeCq
         fZIjF78cccRF17MvWs/lmkDY7A+qijcpnHgDLW+iRfZ8hXEPsS72cMSIzzZXst8K57T9
         uTnOF9isKuvyH2ltl3FeKd0dqo6xOJNLvfpcylMn9RNVJiladWEjzYCfOLfCpiCwXMuC
         C5RbLdruCS/LJuQIIC1iNXtPjGD56TazWArA6agLudauez6z0YgyPaX8K54kgtLHrnMZ
         idEg==
X-Forwarded-Encrypted: i=1; AJvYcCVYb1IIFi662ubYIpjU/B68kfEuZm+zrHes1mzZbhbXnHnbYardCfmYWTrS5f8sUwD4RPLNKYgZQTpCZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZ/KDnt0JDwHgGLiKFJSyuftb0fjtFunRwCHu7DHLlR0gsFzh
	CWbew/Yhlz/4afy3S/eRc5oujPKmQ8PL88aNG7ihu74JVfsJFOCd+cH4E1cK517M
X-Gm-Gg: ASbGncsBvwy8d4ykGAoVPZXezNrHDMfVivBAr2gUO5bCFibTWTvo0IKs7uuxD+6qKOQ
	XwUTA+YkcCYkVI7dVwtS8fvy/v2Ms4KCVpKdt8V620Hzv5oXQlTPXavqKWnGe32DQwrFOr0KwR1
	1FO36CNq/0tfs4yctuWqTOqPtz3juFcm75qVmvwthXjqxcH9FOI2DZViGiecgL+KiJ8mb+L9H9+
	v2a2HGU6w4Z23r6rZlTMaSW1FdSL74DDk6d6xcdM0RTkntGn+p/UIeqR/oL+wUocudS16lR5zmg
	RL6wnMCxXnCGiYMBZRhkkIA57+IaXpV6wW74WMyjW5kAmHBJR5+EHaKuQrK+GCab/vDIf1UZmoc
	b8T8kyHAfi938TDY3T0LQ11vnQfHGkO7//3CNphjb2HrYOFmX0i4=
X-Google-Smtp-Source: AGHT+IEGF9MiX7Mq7uSgm0xim6WgXxpBePbGrTFF7XmZEGUJaH7Im1TntygFOS/VM2WoRZiACdjNjQ==
X-Received: by 2002:a05:6902:1582:b0:e8d:6e7e:714b with SMTP id 3f1490d57ef6-e8d6e7e72edmr7217610276.18.1752860434833;
        Fri, 18 Jul 2025 10:40:34 -0700 (PDT)
Received: from devbig568.nha1.facebook.com ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce53af0sm523013276.35.2025.07.18.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:40:34 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:40:28 -0700
From: Leo Martins <loemra.dev@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix subpage deadlock
Message-ID: <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
 <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>

On Fri 18 Jul 10:18, Qu Wenruo wrote:
> 
> 
> 在 2025/7/18 09:14, Leo Martins 写道:
> > There is a deadlock happening in `try_release_subpage_extent_buffer`
> > because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
> > acquired before the irq-unsafe `eb->refs_lock`.
> > 
> > This leads to the potential race:
> > 
> > ```
> > // T1					// T2
> > xa_lock_irq(&fs_info->buffer_tree)
> > 					spin_lock(&eb->refs_lock)
> > 					// interrupt
> > 					xa_lock_irq(&fs_info->buffer_tree)
> > spin_lock(&eb->refs_lock)
> > ```
> > 
> 
> If it's a lockdep warning, mind to provide the full calltrace?
>

           =====================================================
           WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
           6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 Tainted: G            E    N 
           -----------------------------------------------------
           kswapd0/66 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
           ffff000011ffd600 (&eb->refs_lock){+.+.}-{3:3}, at: try_release_extent_buffer+0x18c/0x560
           
and this task is already holding:
           ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
           which would create a new lock dependency:
            (&buffer_xa_class){-.-.}-{3:3} -> (&eb->refs_lock){+.+.}-{3:3}
           
but this new dependency connects a HARDIRQ-irq-safe lock:
            (&buffer_xa_class){-.-.}-{3:3}
           
... which became HARDIRQ-irq-safe at:
             lock_acquire+0x178/0x358
             _raw_spin_lock_irqsave+0x60/0x88
             buffer_tree_clear_mark+0xc4/0x160
             end_bbio_meta_write+0x238/0x398
             btrfs_bio_end_io+0x1f8/0x330
             btrfs_orig_write_end_io+0x1c4/0x2c0
             bio_endio+0x63c/0x678
             blk_update_request+0x1c4/0xa00
             blk_mq_end_request+0x54/0x88
             virtblk_request_done+0x124/0x1d0
             blk_mq_complete_request+0x84/0xa0
             virtblk_done+0x130/0x238
             vring_interrupt+0x130/0x288
             __handle_irq_event_percpu+0x1e8/0x708
             handle_irq_event+0x98/0x1b0
             handle_fasteoi_irq+0x264/0x7c0
             generic_handle_domain_irq+0xa4/0x108
             gic_handle_irq+0x7c/0x1a0
             do_interrupt_handler+0xe4/0x148
             el1_interrupt+0x30/0x50
             el1h_64_irq_handler+0x14/0x20
             el1h_64_irq+0x6c/0x70
             _raw_spin_unlock_irq+0x38/0x70
             __run_timer_base+0xdc/0x5e0
             run_timer_softirq+0xa0/0x138
             handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
             ____do_softirq.llvm.17674514681856217165+0x18/0x28
             call_on_irq_stack+0x24/0x30
             __irq_exit_rcu+0x164/0x430
             irq_exit_rcu+0x18/0x88
             el1_interrupt+0x34/0x50
             el1h_64_irq_handler+0x14/0x20
             el1h_64_irq+0x6c/0x70
             arch_local_irq_enable+0x4/0x8
             do_idle+0x1a0/0x3b8
             cpu_startup_entry+0x60/0x80
             rest_init+0x204/0x228
             start_kernel+0x394/0x3f0
             __primary_switched+0x8c/0x8958
           
to a HARDIRQ-irq-unsafe lock:
            (&eb->refs_lock){+.+.}-{3:3}
           
... which became HARDIRQ-irq-unsafe at:
           ...
             lock_acquire+0x178/0x358
             _raw_spin_lock+0x4c/0x68
             free_extent_buffer_stale+0x2c/0x170
             btrfs_read_sys_array+0x1b0/0x338
             open_ctree+0xeb0/0x1df8
             btrfs_get_tree+0xb60/0x1110
             vfs_get_tree+0x8c/0x250
             fc_mount+0x20/0x98
             btrfs_get_tree+0x4a4/0x1110
             vfs_get_tree+0x8c/0x250
             do_new_mount+0x1e0/0x6c0
             path_mount+0x4ec/0xa58
             __arm64_sys_mount+0x370/0x490
             invoke_syscall+0x6c/0x208
             el0_svc_common+0x14c/0x1b8
             do_el0_svc+0x4c/0x60
             el0_svc+0x4c/0x160
             el0t_64_sync_handler+0x70/0x100
             el0t_64_sync+0x168/0x170
           
other info that might help us debug this:
            Possible interrupt unsafe locking scenario:
                  CPU0                    CPU1
                  ----                    ----
             lock(&eb->refs_lock);
                                          local_irq_disable();
                                          lock(&buffer_xa_class);
                                          lock(&eb->refs_lock);
             <Interrupt>
               lock(&buffer_xa_class);
           
 *** DEADLOCK ***
           2 locks held by kswapd0/66:
            #0: ffff800085506e40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xe8/0xe50
            #1: ffff0000c1d91b88 (&buffer_xa_class){-.-.}-{3:3}, at: try_release_extent_buffer+0x13c/0x560
           
the dependencies between HARDIRQ-irq-safe lock and the holding lock:
           -> (&buffer_xa_class){-.-.}-{3:3} ops: 8759 {
              IN-HARDIRQ-W at:
                               lock_acquire+0x178/0x358
                               _raw_spin_lock_irqsave+0x60/0x88
                               buffer_tree_clear_mark+0xc4/0x160
                               end_bbio_meta_write+0x238/0x398
                               btrfs_bio_end_io+0x1f8/0x330
                               btrfs_orig_write_end_io+0x1c4/0x2c0
                               bio_endio+0x63c/0x678
                               blk_update_request+0x1c4/0xa00
                               blk_mq_end_request+0x54/0x88
                               virtblk_request_done+0x124/0x1d0
                               blk_mq_complete_request+0x84/0xa0
                               virtblk_done+0x130/0x238
                               vring_interrupt+0x130/0x288
                               __handle_irq_event_percpu+0x1e8/0x708
                               handle_irq_event+0x98/0x1b0
                               handle_fasteoi_irq+0x264/0x7c0
                               generic_handle_domain_irq+0xa4/0x108
                               gic_handle_irq+0x7c/0x1a0
                               do_interrupt_handler+0xe4/0x148
                               el1_interrupt+0x30/0x50
                               el1h_64_irq_handler+0x14/0x20
                               el1h_64_irq+0x6c/0x70
                               _raw_spin_unlock_irq+0x38/0x70
                               __run_timer_base+0xdc/0x5e0
                               run_timer_softirq+0xa0/0x138
                               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
                               ____do_softirq.llvm.17674514681856217165+0x18/0x28
                               call_on_irq_stack+0x24/0x30
                               __irq_exit_rcu+0x164/0x430
                               irq_exit_rcu+0x18/0x88
                               el1_interrupt+0x34/0x50
                               el1h_64_irq_handler+0x14/0x20
                               el1h_64_irq+0x6c/0x70
                               arch_local_irq_enable+0x4/0x8
                               do_idle+0x1a0/0x3b8
                               cpu_startup_entry+0x60/0x80
                               rest_init+0x204/0x228
                               start_kernel+0x394/0x3f0
                               __primary_switched+0x8c/0x8958
              IN-SOFTIRQ-W at:
                               lock_acquire+0x178/0x358
                               _raw_spin_lock_irqsave+0x60/0x88
                               buffer_tree_clear_mark+0xc4/0x160
                               end_bbio_meta_write+0x238/0x398
                               btrfs_bio_end_io+0x1f8/0x330
                               btrfs_orig_write_end_io+0x1c4/0x2c0
                               bio_endio+0x63c/0x678
                               blk_update_request+0x1c4/0xa00
                               blk_mq_end_request+0x54/0x88
                               virtblk_request_done+0x124/0x1d0
                               blk_mq_complete_request+0x84/0xa0
                               virtblk_done+0x130/0x238
                               vring_interrupt+0x130/0x288
                               __handle_irq_event_percpu+0x1e8/0x708
                               handle_irq_event+0x98/0x1b0
                               handle_fasteoi_irq+0x264/0x7c0
                               generic_handle_domain_irq+0xa4/0x108
                               gic_handle_irq+0x7c/0x1a0
                               do_interrupt_handler+0xe4/0x148
                               el1_interrupt+0x30/0x50
                               el1h_64_irq_handler+0x14/0x20
                               el1h_64_irq+0x6c/0x70
                               _raw_spin_unlock_irq+0x38/0x70
                               __run_timer_base+0xdc/0x5e0
                               run_timer_softirq+0xa0/0x138
                               handle_softirqs.llvm.13542289750107964195+0x32c/0xbd0
                               ____do_softirq.llvm.17674514681856217165+0x18/0x28
                               call_on_irq_stack+0x24/0x30
                               __irq_exit_rcu+0x164/0x430
                               irq_exit_rcu+0x18/0x88
                               el1_interrupt+0x34/0x50
                               el1h_64_irq_handler+0x14/0x20
                               el1h_64_irq+0x6c/0x70
                               arch_local_irq_enable+0x4/0x8
                               do_idle+0x1a0/0x3b8
                               cpu_startup_entry+0x60/0x80
                               rest_init+0x204/0x228
                               start_kernel+0x394/0x3f0
                               __primary_switched+0x8c/0x8958
              INITIAL USE at:
                              lock_acquire+0x178/0x358
                              _raw_spin_lock_irq+0x5c/0x78
                              release_extent_buffer+0x170/0x2a8
                              free_extent_buffer_stale+0xf4/0x170
                              btrfs_read_sys_array+0x1b0/0x338
                              open_ctree+0xeb0/0x1df8
                              btrfs_get_tree+0xb60/0x1110
                              vfs_get_tree+0x8c/0x250
                              fc_mount+0x20/0x98
                              btrfs_get_tree+0x4a4/0x1110
                              vfs_get_tree+0x8c/0x250
                              do_new_mount+0x1e0/0x6c0
                              path_mount+0x4ec/0xa58
                              __arm64_sys_mount+0x370/0x490
                              invoke_syscall+0x6c/0x208
                              el0_svc_common+0x14c/0x1b8
                              do_el0_svc+0x4c/0x60
                              el0_svc+0x4c/0x160
                              el0t_64_sync_handler+0x70/0x100
                              el0t_64_sync+0x168/0x170
            }
            ... key      at: [<ffff80008fd9b820>] buffer_xa_class+0x0/0x20
           
the dependencies between the lock to be acquired
            and HARDIRQ-irq-unsafe lock:
           -> (&eb->refs_lock){+.+.}-{3:3} ops: 226471 {
              HARDIRQ-ON-W at:
                               lock_acquire+0x178/0x358
                               _raw_spin_lock+0x4c/0x68
                               free_extent_buffer_stale+0x2c/0x170
                               btrfs_read_sys_array+0x1b0/0x338
                               open_ctree+0xeb0/0x1df8
                               btrfs_get_tree+0xb60/0x1110
                               vfs_get_tree+0x8c/0x250
                               fc_mount+0x20/0x98
                               btrfs_get_tree+0x4a4/0x1110
                               vfs_get_tree+0x8c/0x250
                               do_new_mount+0x1e0/0x6c0
                               path_mount+0x4ec/0xa58
                               __arm64_sys_mount+0x370/0x490
                               invoke_syscall+0x6c/0x208
                               el0_svc_common+0x14c/0x1b8
                               do_el0_svc+0x4c/0x60
                               el0_svc+0x4c/0x160
                               el0t_64_sync_handler+0x70/0x100
                               el0t_64_sync+0x168/0x170
              SOFTIRQ-ON-W at:
                               lock_acquire+0x178/0x358
                               _raw_spin_lock+0x4c/0x68
                               free_extent_buffer_stale+0x2c/0x170
                               btrfs_read_sys_array+0x1b0/0x338
                               open_ctree+0xeb0/0x1df8
                               btrfs_get_tree+0xb60/0x1110
                               vfs_get_tree+0x8c/0x250
                               fc_mount+0x20/0x98
                               btrfs_get_tree+0x4a4/0x1110
                               vfs_get_tree+0x8c/0x250
                               do_new_mount+0x1e0/0x6c0
                               path_mount+0x4ec/0xa58
                               __arm64_sys_mount+0x370/0x490
                               invoke_syscall+0x6c/0x208
                               el0_svc_common+0x14c/0x1b8
                               do_el0_svc+0x4c/0x60
                               el0_svc+0x4c/0x160
                               el0t_64_sync_handler+0x70/0x100
                               el0t_64_sync+0x168/0x170
              INITIAL USE at:
                              lock_acquire+0x178/0x358
                              _raw_spin_lock+0x4c/0x68
                              free_extent_buffer_stale+0x2c/0x170
                              btrfs_read_sys_array+0x1b0/0x338
                              open_ctree+0xeb0/0x1df8
                              btrfs_get_tree+0xb60/0x1110
                              vfs_get_tree+0x8c/0x250
                              fc_mount+0x20/0x98
                              btrfs_get_tree+0x4a4/0x1110
                              vfs_get_tree+0x8c/0x250
                              do_new_mount+0x1e0/0x6c0
                              path_mount+0x4ec/0xa58
                              __arm64_sys_mount+0x370/0x490
                              invoke_syscall+0x6c/0x208
                              el0_svc_common+0x14c/0x1b8
                              do_el0_svc+0x4c/0x60
                              el0_svc+0x4c/0x160
                              el0t_64_sync_handler+0x70/0x100
                              el0t_64_sync+0x168/0x170
            }
            ... key      at: [<ffff80008fda1490>] __alloc_extent_buffer.__key.170+0x0/0x10
            ... acquired at:
              _raw_spin_lock+0x4c/0x68
              try_release_extent_buffer+0x18c/0x560
              btree_release_folio+0x80/0xc0
              filemap_release_folio+0x12c/0x1d0
              shrink_folio_list+0x17ec/0x3140
              shrink_lruvec+0xc94/0x1a88
              shrink_node+0xc80/0x1c78
              balance_pgdat+0x81c/0xe50
              kswapd+0x1ac/0xbc0
              kthread+0x3fc/0x530
              ret_from_fork+0x10/0x20
           
           
stack backtrace:
           CPU: 3 UID: 0 PID: 66 Comm: kswapd0 Tainted: G            E    N  6.16.0-0_fbk701_debug_rc0_123_g4c06e63b9203 #1 PREEMPT(undef) 
           Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
           Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20241117-3.el9 11/17/2024
           Call trace:
            show_stack+0x1c/0x30 (C)
            dump_stack_lvl+0x38/0xb0
            dump_stack+0x14/0x1c
            __lock_acquire+0x35bc/0x3690
            lock_acquire+0x178/0x358
            _raw_spin_lock+0x4c/0x68
            try_release_extent_buffer+0x18c/0x560
            btree_release_folio+0x80/0xc0
            filemap_release_folio+0x12c/0x1d0
            shrink_folio_list+0x17ec/0x3140
            shrink_lruvec+0xc94/0x1a88
            shrink_node+0xc80/0x1c78
            balance_pgdat+0x81c/0xe50
            kswapd+0x1ac/0xbc0
            kthread+0x3fc/0x530
            ret_from_fork+0x10/0x20
           virtio_net virtio8 eth0: renamed from enp0s10 (while UP)
           cppc_cpufreq: module verification failed: signature and/or required key missing - tainting kernel
           input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
           ACPI: button: Power Button [PWRB]
           hrtimer: interrupt took 2020913 ns

> I'm wondering at which exact interruption path that we will try to acquire
> the buffer_tree xa lock.
> 
> Since the read path is always happening inside a workqueue, it won't cause
> xa_lock_irq() under interruption context.
> 
> For the write path it's possible through end_bbio_meta_write() ->
> buffer_tree_clear_mark().
> 
> But remember if there is an extent buffer under writeback, the whole folio
> will have writeback flag, thus the btree_release_folio() won't even try to
> release the folio.
> 

Interesting, that makes sense. So this deadlock is impossible to hit?
What do you think about this patch? Should I pivot and try and figure
out how to express to lockdep that this deadlock is impossible?

> 
> > https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:text=Multi%2Dlock%20dependency%20rules%3A
> > 
> > I believe that in this case a spin lock is not needed and we can get
> > away with `rcu_read_lock`. There is already some precedence for this
> > with `find_extent_buffer_nolock`, which loads an extent buffer from
> > the xarray with only `rcu_read_lock`.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >   fs/btrfs/extent_io.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6192e1f58860..060e509cfb18 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0
> > +#include <linux/rcupdate.h>
> 
> We already have other rcu_read_lock() usage inside the same file, no need to
> manually include the header.

Sounds good.

Thanks,
Leo

> 
> Thanks,
> Qu
>
> >   #include <linux/bitops.h>
> >   #include <linux/slab.h>
> >   #include <linux/bio.h>
> > @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >   	unsigned long end = index + (PAGE_SIZE >> fs_info->nodesize_bits) - 1;
> >   	int ret;
> > -	xa_lock_irq(&fs_info->buffer_tree);
> > +	rcu_read_lock();
> >   	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
> >   		/*
> >   		 * The same as try_release_extent_buffer(), to ensure the eb
> >   		 * won't disappear out from under us.
> >   		 */
> >   		spin_lock(&eb->refs_lock);
> > +		rcu_read_unlock();
> > +
> >   		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
> >   			spin_unlock(&eb->refs_lock);
> > +			rcu_read_lock();
> >   			continue;
> >   		}
> > @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >   		 * check the folio private at the end.  And
> >   		 * release_extent_buffer() will release the refs_lock.
> >   		 */
> > -		xa_unlock_irq(&fs_info->buffer_tree);
> >   		release_extent_buffer(eb);
> > -		xa_lock_irq(&fs_info->buffer_tree);
> > +		rcu_read_lock();
> >   	}
> > -	xa_unlock_irq(&fs_info->buffer_tree);
> > +	rcu_read_unlock();
> >   	/*
> >   	 * Finally to check if we have cleared folio private, as if we have
> > @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
> >   		ret = 0;
> >   	spin_unlock(&folio->mapping->i_private_lock);
> >   	return ret;
> > -
> >   }
> >   int try_release_extent_buffer(struct folio *folio)
> 
> 

