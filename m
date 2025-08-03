Return-Path: <linux-btrfs+bounces-15823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D417B196E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 02:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25533B5AFE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 00:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B63FC2;
	Mon,  4 Aug 2025 00:03:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-156.us.a.mail.aliyun.com (out198-156.us.a.mail.aliyun.com [47.90.198.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB117D2
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265818; cv=none; b=RTP095h78BJ78T5JDzYXoMTZ5Ivlpx5si0j0LjlQnXOm5UxCDLIs8IxVwp42VMgu8tSauFujoFV4/erdaTVxt47JnE1i0fcO0tWzmm11/j2ILOPynYpyzCRbVffvKcww7JsgL4B4C0KPQps1MU2Lxh4RsDKFBX5DuQ3tuKU23EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265818; c=relaxed/simple;
	bh=NJIatmU7dbQ3ZVqxiW+Ca8wretCUS8kkOijfyAF+NFo=;
	h=Date:From:To:Subject:Message-Id:MIME-Version:Content-Type; b=cFRD/i9oomdby0znH5XUsfnG+uBMTwez/EmIA7cXZIHF5+TFX5S5TSEicvmPGcfId0ImVdPj7xqs6kPNhaOu/azuDFa4vwmeGEv+9hw0G5C8qb9H13tF9eG2F3UvLz2xd/Mf508rKpcE/PX//aKj1+nF4XPZA5lXuTIUN1ARrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.e5JbHg9_1754265475 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 07:57:56 +0800
Date: Mon, 04 Aug 2025 07:57:57 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: similar deadlock of xfstests generic/475 and generic/648 on 6.12.41 
Message-Id: <20250804075756.608E.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

similar deadlock of xfstests generic/475 and generic/648 on 6.12.41 with some
6.17 backport.

generic/475
[47333.016017] sysrq: Show Blocked State
[47333.022309] task:kworker/u81:5   state:D stack:0     pid:1766531 tgid:1766531 ppid:2      flags:0x00004000
[47333.034537] Workqueue: writeback wb_workfn (flush-btrfs-3405)
[47333.042841] Call Trace:
[47333.047804]  <TASK>
[47333.052328]  __schedule+0x278/0x540
[47333.058191]  ? __blk_flush_plug+0xf5/0x150
[47333.064627]  schedule+0x27/0xa0
[47333.070102]  io_schedule+0x46/0x70
[47333.075814]  folio_wait_bit_common+0x13d/0x390
[47333.082550]  ? folio_wait_bit_common+0x10b/0x390
[47333.089414]  ? __pfx_wake_page_function+0x10/0x10
[47333.096317]  __filemap_get_folio+0x289/0x3b0
[47333.102754]  cleanup_dirty_folios.isra.0+0xda/0x200 [btrfs]
[47333.110601]  run_delalloc_nocow+0x4d7/0x6f0 [btrfs]
[47333.117665]  ? __clear_extent_bit+0xc0/0x4f0 [btrfs]
[47333.124832]  btrfs_run_delalloc_range+0x8e/0x2a0 [btrfs]
[47333.132369]  writepage_delalloc+0x1fa/0x3e0 [btrfs]
[47333.139469]  extent_writepage+0xdb/0x260 [btrfs]
[47333.146322]  extent_write_cache_pages+0x18f/0x410 [btrfs]
[47333.153919]  btrfs_writepages+0x74/0x100 [btrfs]
[47333.160717]  do_writepages+0xd6/0x240
[47333.166440]  ? select_task_rq_fair+0x165/0x340
[47333.172949]  ? __smp_call_single_queue+0xb0/0x120
[47333.179738]  ? ttwu_queue_wakelist+0xf4/0x110
[47333.186177]  __writeback_single_inode+0x41/0x260
[47333.192893]  writeback_sb_inodes+0x21c/0x4e0
[47333.199286]  wb_writeback+0x88/0x310
[47333.204899]  wb_do_writeback+0x87/0x2b0
[47333.210729]  ? set_worker_desc+0xaf/0xc0
[47333.216634]  wb_workfn+0x49/0x150
[47333.221958]  process_one_work+0x179/0x3a0
[47333.227986]  worker_thread+0x24b/0x350
[47333.233745]  ? __pfx_worker_thread+0x10/0x10
[47333.240036]  kthread+0xde/0x110
[47333.245151]  ? __pfx_kthread+0x10/0x10
[47333.250834]  ret_from_fork+0x31/0x50
[47333.256354]  ? __pfx_kthread+0x10/0x10
[47333.262048]  ret_from_fork_asm+0x1a/0x30
[47333.267937]  </TASK>
[47333.272060] task:btrfs-transacti state:D stack:0     pid:3056793 tgid:3056793 ppid:2      flags:0x00004000
[47333.283763] Call Trace:
[47333.288187]  <TASK>
[47333.292173]  __schedule+0x278/0x540
[47333.297555]  schedule+0x27/0xa0
[47333.302603]  io_schedule+0x46/0x70
[47333.307924]  folio_wait_bit_common+0x13d/0x390
[47333.314249]  ? folio_wait_bit_common+0x10b/0x390
[47333.320778]  ? xas_init_marks+0x23/0x50
[47333.326513]  ? __pfx_wake_page_function+0x10/0x10
[47333.333127]  invalidate_inode_pages2_range+0x275/0x4c0
[47333.340165]  btrfs_destroy_all_delalloc_inodes+0x187/0x220 [btrfs]
[47333.348345]  btrfs_cleanup_transaction.isra.0+0x389/0x3f0 [btrfs]
[47333.356454]  transaction_kthread+0x107/0x1d0 [btrfs]
[47333.363413]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[47333.370906]  kthread+0xde/0x110
[47333.375955]  ? __pfx_kthread+0x10/0x10
[47333.381626]  ret_from_fork+0x31/0x50
[47333.387100]  ? __pfx_kthread+0x10/0x10
[47333.392732]  ret_from_fork_asm+0x1a/0x30
[47333.398553]  </TASK>
[47333.402611] task:fsstress        state:D stack:0     pid:3056799 tgid:3056799 ppid:3056794 flags:0x00000006
[47333.414306] Call Trace:
[47333.418668]  <TASK>
[47333.422658]  __schedule+0x278/0x540
[47333.428017]  schedule+0x27/0xa0
[47333.432966]  wb_wait_for_completion+0x6b/0xa0
[47333.439127]  ? __pfx_autoremove_wake_function+0x10/0x10
[47333.446183]  __writeback_inodes_sb_nr+0xa2/0xd0
[47333.452569]  sync_filesystem+0x31/0xa0
[47333.458162]  __x64_sys_syncfs+0x41/0xa0
[47333.463851]  do_syscall_64+0x7d/0x160
[47333.469360]  ? __do_sys_newfstatat+0x35/0x60
[47333.475492]  ? file_close_fd+0x45/0x60
[47333.481090]  ? syscall_exit_to_user_mode+0x32/0x1b0
[47333.487821]  ? do_syscall_64+0x89/0x160
[47333.493500]  ? syscall_exit_to_user_mode+0x32/0x1b0
[47333.500241]  ? do_syscall_64+0x89/0x160
[47333.505917]  ? __do_sys_newfstatat+0x35/0x60
[47333.512025]  ? __x64_sys_ioctl+0xa6/0xc0
[47333.517770]  ? syscall_exit_to_user_mode+0x32/0x1b0
[47333.524495]  ? do_syscall_64+0x89/0x160
[47333.530154]  ? syscall_exit_to_user_mode+0x32/0x1b0
[47333.536868]  ? do_syscall_64+0x89/0x160
[47333.542526]  ? exc_page_fault+0x70/0x160
[47333.548272]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[47333.555147] RIP: 0033:0x7f8510704b8b
[47333.560547] RSP: 002b:00007fff6f808b78 EFLAGS: 00000202 ORIG_RAX: 0000000000000132
[47333.570012] RAX: ffffffffffffffda RBX: 000000000007a120 RCX: 00007f8510704b8b
[47333.579026] RDX: 0000000000000000 RSI: 0000000031eb1450 RDI: 0000000000000004
[47333.588051] RBP: 0000000000000004 R08: 0000000000000060 R09: 00007fff6f808b3c
[47333.597077] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000073a
[47333.606092] R13: 8f5c28f5c28f5c29 R14: 00000000004045c0 R15: 00007f8510932b08
[47333.615123]  </TASK>


generic/648:

[38896.856540] sysrq: Show Blocked State
[38896.863859] task:kworker/u81:9   state:D stack:0     pid:1771117 tgid:1771117 ppid:2      flags:0x00004000
[38896.877114] Workqueue: writeback wb_workfn (flush-btrfs-4069)
[38896.886454] Call Trace:
[38896.892401]  <TASK>
[38896.897932]  __schedule+0x278/0x540
[38896.904848]  ? __blk_flush_plug+0xf5/0x150
[38896.912373]  schedule+0x27/0xa0
[38896.918904]  io_schedule+0x46/0x70
[38896.925672]  folio_wait_bit_common+0x13d/0x390
[38896.933465]  ? folio_wait_bit_common+0x10b/0x390
[38896.941383]  ? __pfx_wake_page_function+0x10/0x10
[38896.949338]  __filemap_get_folio+0x289/0x3b0
[38896.956830]  cleanup_dirty_folios.isra.0+0xda/0x200 [btrfs]
[38896.965742]  run_delalloc_nocow+0x4d7/0x6f0 [btrfs]
[38896.973862]  ? __clear_extent_bit+0x170/0x4f0 [btrfs]
[38896.982121]  btrfs_run_delalloc_range+0x8e/0x2a0 [btrfs]
[38896.990622]  writepage_delalloc+0x1fa/0x3e0 [btrfs]
[38896.998655]  extent_writepage+0xdb/0x260 [btrfs]
[38897.006387]  extent_write_cache_pages+0x18f/0x410 [btrfs]
[38897.014874]  btrfs_writepages+0x74/0x100 [btrfs]
[38897.022545]  do_writepages+0xd6/0x240
[38897.029129]  ? requeue_delayed_entity+0x8c/0x100
[38897.036643]  __writeback_single_inode+0x41/0x260
[38897.044115]  writeback_sb_inodes+0x21c/0x4e0
[38897.051205]  wb_writeback+0x88/0x310
[38897.057606]  wb_do_writeback+0x87/0x2b0
[38897.064277]  ? set_worker_desc+0xaf/0xc0
[38897.071053]  wb_workfn+0x49/0x150
[38897.077226]  process_one_work+0x179/0x3a0
[38897.084068]  worker_thread+0x24b/0x350
[38897.090610]  ? __pfx_worker_thread+0x10/0x10
[38897.097665]  kthread+0xde/0x110
[38897.103542]  ? __pfx_kthread+0x10/0x10
[38897.110007]  ret_from_fork+0x31/0x50
[38897.116241]  ? __pfx_kthread+0x10/0x10
[38897.122598]  ret_from_fork_asm+0x1a/0x30
[38897.129098]  </TASK>
[38897.133829] task:btrfs-transacti state:D stack:0     pid:3363777 tgid:3363777 ppid:2      flags:0x00004000
[38897.146101] Call Trace:
[38897.151052]  <TASK>
[38897.155575]  __schedule+0x278/0x540
[38897.161482]  schedule+0x27/0xa0
[38897.167022]  io_schedule+0x46/0x70
[38897.172810]  folio_wait_bit_common+0x13d/0x390
[38897.179604]  ? folio_wait_bit_common+0x10b/0x390
[38897.186521]  ? xas_init_marks+0x23/0x50
[38897.192628]  ? __pfx_wake_page_function+0x10/0x10
[38897.199614]  invalidate_inode_pages2_range+0x275/0x4c0
[38897.207025]  btrfs_destroy_all_delalloc_inodes+0x187/0x220 [btrfs]
[38897.215553]  btrfs_cleanup_transaction.isra.0+0x389/0x3f0 [btrfs]
[38897.223978]  transaction_kthread+0x107/0x1d0 [btrfs]
[38897.231246]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[38897.239020]  kthread+0xde/0x110
[38897.244329]  ? __pfx_kthread+0x10/0x10
[38897.250208]  ret_from_fork+0x31/0x50
[38897.255854]  ? __pfx_kthread+0x10/0x10
[38897.261619]  ret_from_fork_asm+0x1a/0x30
[38897.267534]  </TASK>
[38897.271661] task:fsstress        state:D stack:0     pid:3363784 tgid:3363784 ppid:3363778 flags:0x00004006
[38897.283430] Call Trace:
[38897.287824]  <TASK>
[38897.291824]  __schedule+0x278/0x540
[38897.297190]  schedule+0x27/0xa0
[38897.302188]  wb_wait_for_completion+0x6b/0xa0
[38897.308387]  ? __pfx_autoremove_wake_function+0x10/0x10
[38897.315428]  sync_inodes_sb+0xc4/0x100
[38897.320978]  sync_filesystem+0x64/0xa0
[38897.326529]  __x64_sys_syncfs+0x41/0xa0
[38897.332173]  do_syscall_64+0x7d/0x160
[38897.337642]  ? syscall_exit_to_user_mode+0x32/0x1b0
[38897.344341]  ? do_syscall_64+0x89/0x160
[38897.349994]  ? exc_page_fault+0x70/0x160
[38897.355733]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[38897.362623] RIP: 0033:0x7f38d7504b8b
[38897.368019] RSP: 002b:00007fff09ab5f68 EFLAGS: 00000202 ORIG_RAX: 0000000000000132
[38897.377470] RAX: ffffffffffffffda RBX: 000000000007a120 RCX: 00007f38d7504b8b
[38897.386494] RDX: 0000000000000000 RSI: 0000000005d26450 RDI: 0000000000000004
[38897.395514] RBP: 0000000000000004 R08: 0000000000000009 R09: 0000000005d32370
[38897.404525] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000783
[38897.413517] R13: 8f5c28f5c28f5c29 R14: 00000000004045c0 R15: 00007f38d7653b08
[38897.422516]  </TASK>

And this is a server with ECC memory and no ECC warning/errror reported.

Is there any patch related to this problem?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/08/04



