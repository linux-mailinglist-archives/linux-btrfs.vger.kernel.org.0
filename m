Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9D472D3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 14:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhLMN23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 08:28:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43174 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhLMN22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 08:28:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B36D1F3BB;
        Mon, 13 Dec 2021 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639402107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PjkYN8pzJAF/wSEAaJDzoiiKCLc3bjluVwZAsI9tbs=;
        b=UPUX/P802gSq70moDlglHTzcyC/Vo+AP5LkVBnQOxsG2nEELipJ/stV4Cdh58NjVKscjlm
        rS07SNpklDizuZHp0/kTRKs8p4/df2JrZ+UtLN6kGzl81dro062y2brZnk6FgY3optQu9c
        g4/52JG+e1RIXB0VlkCTHIgcmFv6Hjc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B6013AFF;
        Mon, 13 Dec 2021 13:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f5MSNHpKt2HJDwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Dec 2021 13:28:26 +0000
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10 vfs:
 verify source area in vfs_dedupe_file_range_one()
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>
References: <20211210183456.GP17148@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
Date:   Mon, 13 Dec 2021 15:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210183456.GP17148@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.21 г. 20:34, Zygo Blaxell wrote:
> I've been getting deadlocks in dedupe on btrfs since kernel 5.11, and
> some bees users have reported it as well.  I bisected to this commit:
> 
> 	3078d85c9a10 vfs: verify source area in vfs_dedupe_file_range_one()
> 
> These kernels work for at least 18 hours:
> 
> 	5.10.83 (months)
> 	5.11.22 with 3078d85c9a10 reverted (36 hours)
> 	btrfs misc-next 66dc4de326b0 with 3078d85c9a10 reverted
> 
> These kernels lock up in 3 hours or less:
> 
> 	5.11.22
> 	5.12.19
> 	5.14.21
> 	5.15.6
> 	btrfs for-next 279373dee83e
> 
> All of the failing kernels include this commit, none of the non-failing
> kernels include the commit.
> 
> Kernel logs from the lockup:
> 
> 	[19647.696042][ T3721] sysrq: Show Blocked State
> 	[19647.697024][ T3721] task:btrfs-transacti state:D stack:    0 pid: 6161 ppid:     2 flags:0x00004000
> 	[19647.698203][ T3721] Call Trace:
> 	[19647.698608][ T3721]  __schedule+0x388/0xaf0
> 	[19647.699125][ T3721]  schedule+0x68/0xe0
> 	[19647.699615][ T3721]  btrfs_commit_transaction+0x97c/0xbf0

Can you run this through symbolize script as I'd like to understand
where in transaction commit the sleep is happening. The picture painted
by the presented logs is that  PID 6502 has already locked 2 inodes and
is trying to get a handle for the currently run transaction via
btrfs_start_transaction but has to wait for it to commit. Subsequently
there are 3 more crawl processes (I assume those come from bees?) PIDs
6494, 6503 and 6504 which are trying to lock an inode as part of remap
but have to wait since likely 6502 has those locked.

So the real reason of the hang is that transaction commit is stuck for
some reason and we have to figure why this is the case.

> 	[19647.700276][ T3721]  ? start_transaction+0xd5/0x6f0
> 	[19647.700897][ T3721]  ? do_wait_intr_irq+0xd0/0xd0
> 	[19647.701507][ T3721]  transaction_kthread+0x138/0x1b0
> 	[19647.702154][ T3721]  kthread+0x151/0x170
> 	[19647.702651][ T3721]  ? btrfs_cleanup_transaction.isra.0+0x620/0x620
> 	[19647.703404][ T3721]  ? kthread_create_worker_on_cpu+0x70/0x70
> 	[19647.704119][ T3721]  ret_from_fork+0x22/0x30
> 	[19647.704679][ T3721] task:crawl_257_291   state:D stack:    0 pid: 6494 ppid:  6435 flags:0x00000000
> 	[19647.705797][ T3721] Call Trace:
> 	[19647.706188][ T3721]  __schedule+0x388/0xaf0
> 	[19647.706723][ T3721]  ? rwsem_down_write_slowpath+0x35f/0x770
> 	[19647.707414][ T3721]  schedule+0x68/0xe0
> 	[19647.707905][ T3721]  rwsem_down_write_slowpath+0x39f/0x770
> 	[19647.708597][ T3721]  down_write_nested+0xc1/0x130
> 	[19647.709167][ T3721]  lock_two_nondirectories+0x59/0x70
> 	[19647.709831][ T3721]  btrfs_remap_file_range+0x54/0x3c0
> 	[19647.710505][ T3721]  vfs_dedupe_file_range_one+0x117/0x180
> 	[19647.711197][ T3721]  vfs_dedupe_file_range+0x159/0x1e0
> 	[19647.711902][ T3721]  do_vfs_ioctl+0x551/0x720
> 	[19647.712434][ T3721]  ? __fget_files+0x109/0x1d0
> 	[19647.713010][ T3721]  __x64_sys_ioctl+0x6f/0xc0
> 	[19647.713544][ T3721]  do_syscall_64+0x38/0x90
> 	[19647.714098][ T3721]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	[19647.714818][ T3721] RIP: 0033:0x7f0ab2429cc7
> 	[19647.715327][ T3721] RSP: 002b:00007f0ab03241d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[19647.716326][ T3721] RAX: ffffffffffffffda RBX: 00007f0ab0324420 RCX: 00007f0ab2429cc7
> 	[19647.717264][ T3721] RDX: 00007f0a981afe50 RSI: 00000000c0189436 RDI: 0000000000000012
> 	[19647.718203][ T3721] RBP: 00007f0a981afe50 R08: 00007f0a983759e0 R09: 0000000000000000
> 	[19647.719151][ T3721] R10: 00007ffc0f9f2080 R11: 0000000000000246 R12: 00007f0a981afe50
> 	[19647.720087][ T3721] R13: 00007f0ab0324428 R14: 0000000000000000 R15: 00007f0ab0324448

<snip>

> 	[19647.734438][ T3721] RIP: 0033:0x7f0ab2429cc7
> 	[19647.734992][ T3721] RSP: 002b:00007f0aaf322378 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[19647.735994][ T3721] RAX: ffffffffffffffda RBX: 0000558110d25dd0 RCX: 00007f0ab2429cc7
> 	[19647.736949][ T3721] RDX: 00007f0aaf322608 RSI: 00000000c038943b RDI: 0000000000000003
> 	[19647.737895][ T3721] RBP: 00007f0aaf322550 R08: 0000000000000000 R09: 00007f0aaf3227e0
> 	[19647.738862][ T3721] R10: 000019f231c642a4 R11: 0000000000000246 R12: 00007f0aaf322600
> 	[19647.739799][ T3721] R13: 0000000000000003 R14: 00007f0aaf322608 R15: 00007f0aaf3225e0
> 	[19647.740748][ T3721] task:crawl_257_292   state:D stack:    0 pid: 6502 ppid:  6435 flags:0x00000000
> 	[19647.741832][ T3721] Call Trace:
> 	[19647.742216][ T3721]  __schedule+0x388/0xaf0
> 	[19647.742761][ T3721]  schedule+0x68/0xe0
> 	[19647.743225][ T3721]  wait_current_trans+0xed/0x150
> 	[19647.743825][ T3721]  ? do_wait_intr_irq+0xd0/0xd0
> 	[19647.744399][ T3721]  start_transaction+0x587/0x6f0
> 	[19647.745003][ T3721]  btrfs_start_transaction+0x1e/0x20
> 	[19647.745638][ T3721]  btrfs_replace_file_extents+0x135/0x8d0
> 	[19647.746305][ T3721]  ? release_extent_buffer+0xae/0xf0
> 	[19647.746973][ T3721]  btrfs_clone+0x828/0x8c0
> 	[19647.747513][ T3721]  btrfs_extent_same_range+0x75/0xa0
> 	[19647.748152][ T3721]  btrfs_remap_file_range+0x354/0x3c0
> 	[19647.748802][ T3721]  vfs_dedupe_file_range_one+0x117/0x180
> 	[19647.749460][ T3721]  vfs_dedupe_file_range+0x159/0x1e0
> 	[19647.750098][ T3721]  do_vfs_ioctl+0x551/0x720
> 	[19647.750666][ T3721]  ? __fget_files+0x109/0x1d0
> 	[19647.751216][ T3721]  __x64_sys_ioctl+0x6f/0xc0
> 	[19647.751777][ T3721]  do_syscall_64+0x38/0x90
> 	[19647.752290][ T3721]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	[19647.752992][ T3721] RIP: 0033:0x7f0ab2429cc7
> 	[19647.753511][ T3721] RSP: 002b:00007f0aac31c1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[19647.754500][ T3721] RAX: ffffffffffffffda RBX: 00007f0aac31c420 RCX: 00007f0ab2429cc7
> 	[19647.755460][ T3721] RDX: 00007f0a787fc690 RSI: 00000000c0189436 RDI: 0000000000000012
> 	[19647.756406][ T3721] RBP: 00007f0a787fc690 R08: 00007f0a78f4fd40 R09: 0000000000000000
> 	[19647.757340][ T3721] R10: 00007ffc0f9f2080 R11: 0000000000000246 R12: 00007f0a787fc690
> 	[19647.758291][ T3721] R13: 00007f0aac31c428 R14: 0000000000000000 R15: 00007f0aac31c448
> 	[19647.759261][ T3721] task:crawl_257_293   state:D stack:    0 pid: 6503 ppid:  6435 flags:0x00000000
> 	[19647.760362][ T3721] Call Trace:
> 	[19647.760761][ T3721]  __schedule+0x388/0xaf0
> 	[19647.761261][ T3721]  ? rwsem_down_write_slowpath+0x35f/0x770
> 	[19647.761958][ T3721]  schedule+0x68/0xe0
> 	[19647.762425][ T3721]  rwsem_down_write_slowpath+0x39f/0x770
> 	[19647.763126][ T3721]  down_write+0xbd/0x120
> 	[19647.763643][ T3721]  btrfs_remap_file_range+0x2eb/0x3c0
> 	[19647.764278][ T3721]  vfs_dedupe_file_range_one+0x117/0x180
> 	[19647.764954][ T3721]  vfs_dedupe_file_range+0x159/0x1e0
> 	[19647.765589][ T3721]  do_vfs_ioctl+0x551/0x720
> 	[19647.766115][ T3721]  ? __fget_files+0x109/0x1d0
> 	[19647.766700][ T3721]  __x64_sys_ioctl+0x6f/0xc0
> 	[19647.767238][ T3721]  do_syscall_64+0x38/0x90
> 	[19647.767772][ T3721]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	[19647.768458][ T3721] RIP: 0033:0x7f0ab2429cc7
> 	[19647.768990][ T3721] RSP: 002b:00007f0aabb1b1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[19647.769986][ T3721] RAX: ffffffffffffffda RBX: 00007f0aabb1b420 RCX: 00007f0ab2429cc7
> 	[19647.770951][ T3721] RDX: 00007f0a6c1f5ac0 RSI: 00000000c0189436 RDI: 0000000000000012
> 	[19647.771894][ T3721] RBP: 00007f0a6c1f5ac0 R08: 00007f0a6d00da10 R09: 0000000000000000
> 	[19647.772839][ T3721] R10: 00007ffc0f9f2080 R11: 0000000000000246 R12: 00007f0a6c1f5ac0
> 	[19647.773789][ T3721] R13: 00007f0aabb1b428 R14: 0000000000000000 R15: 00007f0aabb1b448
> 	[19647.774784][ T3721] task:crawl_256_289   state:D stack:    0 pid: 6504 ppid:  6435 flags:0x00000000
> 	[19647.775882][ T3721] Call Trace:
> 	[19647.776271][ T3721]  __schedule+0x388/0xaf0
> 	[19647.776807][ T3721]  ? rwsem_down_write_slowpath+0x35f/0x770
> 	[19647.777499][ T3721]  schedule+0x68/0xe0
> 	[19647.777994][ T3721]  rwsem_down_write_slowpath+0x39f/0x770
> 	[19647.778712][ T3721]  down_write_nested+0xc1/0x130
> 	[19647.779285][ T3721]  lock_two_nondirectories+0x59/0x70
> 	[19647.779931][ T3721]  btrfs_remap_file_range+0x54/0x3c0
> 	[19647.780564][ T3721]  vfs_dedupe_file_range_one+0x117/0x180
> 	[19647.781366][ T3721]  vfs_dedupe_file_range+0x159/0x1e0
> 	[19647.782009][ T3721]  do_vfs_ioctl+0x551/0x720
> 	[19647.782554][ T3721]  ? __fget_files+0x109/0x1d0
> 	[19647.783230][ T3721]  __x64_sys_ioctl+0x6f/0xc0
> 	[19647.783804][ T3721]  do_syscall_64+0x38/0x90
> 	[19647.784319][ T3721]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	[19647.785031][ T3721] RIP: 0033:0x7f0ab2429cc7
> 	[19647.785548][ T3721] RSP: 002b:00007f0aab31a1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[19647.786660][ T3721] RAX: ffffffffffffffda RBX: 00007f0aab31a420 RCX: 00007f0ab2429cc7
> 	[19647.787609][ T3721] RDX: 00007f0a70008f00 RSI: 00000000c0189436 RDI: 0000000000000012
> 	[19647.788551][ T3721] RBP: 00007f0a70008f00 R08: 00007f0a708e66e0 R09: 0000000000000000
> 	[19647.789533][ T3721] R10: 00007ffc0f9f2080 R11: 0000000000000246 R12: 00007f0a70008f00
> 	[19647.790482][ T3721] R13: 00007f0aab31a428 R14: 0000000000000000 R15: 00007f0aab31a448
> 	[32609.668575][ T3721] sysrq: Show Locks Held
> 	[32609.673950][ T3721] 
> 	[32609.673950][ T3721] Showing all locks held in the system:
> 	[32609.675276][ T3721] 1 lock held by in:imklog/3603:
> 	[32609.675885][ T3721] 1 lock held by dmesg/3720:
> 	[32609.676432][ T3721]  #0: ffff8a1406ac80e0 (&user->lock){+.+.}-{3:3}, at: devkmsg_read+0x4d/0x320
> 	[32609.678403][ T3721] 3 locks held by bash/3721:
> 	[32609.678972][ T3721]  #0: ffff8a142a589498 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x70/0xf0
> 	[32609.680364][ T3721]  #1: ffffffff98f199a0 (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x5/0xa0
> 	[32609.682046][ T3721]  #2: ffffffff98f199a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x23/0x187
> 	[32609.683847][ T3721] 1 lock held by btrfs-transacti/6161:
> 	[32609.684498][ T3721]  #0: ffff8a14e0178850 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: transaction_kthread+0x5a/0x1b0
> 	[32609.686275][ T3721] 3 locks held by crawl_257_265/6491:
> 	[32609.686937][ T3721] 3 locks held by crawl_257_291/6494:
> 	[32609.687578][ T3721]  #0: ffff8a14bd092498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> 	[32609.689126][ T3721]  #1: ffff8a1410d7c848 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
> 	[32609.690694][ T3721]  #2: ffff8a14161a39c8 (&sb->s_type->i_mutex_key#17/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x59/0x70
> 	[32609.692091][ T3721] 4 locks held by crawl_257_292/6502:
> 	[32609.692763][ T3721]  #0: ffff8a14bd092498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> 	[32609.694014][ T3721]  #1: ffff8a131637a908 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
> 	[32609.695377][ T3721]  #2: ffff8a14161a39c8 (&sb->s_type->i_mutex_key#17/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x59/0x70
> 	[32609.696764][ T3721]  #3: ffff8a14bd0926b8 (sb_internal#2){.+.+}-{0:0}, at: btrfs_start_transaction+0x1e/0x20
> 	[32609.697986][ T3721] 2 locks held by crawl_257_293/6503:
> 	[32609.698629][ T3721]  #0: ffff8a14bd092498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> 	[32609.699882][ T3721]  #1: ffff8a14161a39c8 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: btrfs_remap_file_range+0x2eb/0x3c0
> 	[32609.701674][ T3721] 3 locks held by crawl_256_289/6504:
> 	[32609.702443][ T3721]  #0: ffff8a14bd092498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> 	[32609.703927][ T3721]  #1: ffff8a140f2c4748 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
> 	[32609.705444][ T3721]  #2: ffff8a14161a39c8 (&sb->s_type->i_mutex_key#17/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x59/0x70
> 	[32609.706899][ T3721] 
> 	[32609.707177][ T3721] =============================================
> 
> There is also a severe performance regression (50% slower) in btrfs dedupe
> starting in 5.11, but reverting this commit doesn't make the performance
> regression go away.  I'll follow up on that separately.
> 
