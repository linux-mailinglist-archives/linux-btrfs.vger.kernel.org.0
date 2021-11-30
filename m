Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490234630B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbhK3KMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 05:12:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45744 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhK3KMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 05:12:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7412C212C9;
        Tue, 30 Nov 2021 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638266935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83aBn5Oj0xOTWUtY6Q7MriXnb7tTU9m/QkS834L0p5M=;
        b=DUwux42P6aqQBibxVv/VbCWz/HnMTdTWcIIxRL2gLPgZisyylJK9+Dm0L0oiQ5xS9Tq9Q7
        o7v/GWKCn+KqrqZx43JU3cuKK4xvLsBxE079Q5Gdt+ChdzsJDY8ULWspTS6Kck704TnPJl
        CITvMQ2xKJFB1CXKCroGtW0Kv9oATvA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4739713D2F;
        Tue, 30 Nov 2021 10:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bxlODjf4pWGBLQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 30 Nov 2021 10:08:55 +0000
Subject: Re: 'btrfs replace' hangs at end of replacing a device (v5.10.82)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20211129214647.GH17148@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4529d1a3-1485-240d-ed13-79874af12d55@suse.com>
Date:   Tue, 30 Nov 2021 12:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129214647.GH17148@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.11.21 г. 23:46, Zygo Blaxell wrote:
> Not a new bug, but it's still there.  btrfs replace ends in a transaction
> deadlock.
> 
> 'btrfs replace status' reports the replace completed and exits:
> 
> 	Started on 27.Nov 02:05:07, finished on 29.Nov 14:11:20, 0 write errs, 0 uncorr. read errs
> 
> Magic-SysRq-W:
> 
> 	sysrq: Show Blocked State
> 	task:btrfs-transacti state:D stack:    0 pid:29509 ppid:     2 flags:0x00004000
> 	Call Trace:
> 	 __schedule+0x35a/0xaa0
> 	 schedule+0x68/0xe0
> 	 schedule_preempt_disabled+0x15/0x20
> 	 __mutex_lock+0x1ac/0x7e0
> 	 ? lock_acquire+0x190/0x2d0
> 	 ? btrfs_run_dev_stats+0x46/0x450
> 	 ? rcu_read_lock_sched_held+0x16/0x80
> 	 mutex_lock_nested+0x1b/0x20

Transaction commit blocked on device_list_mutex which is held by
rm_dev_replace_blocked.


> 	 btrfs_run_dev_stats+0x46/0x450
> 	 ? _raw_spin_unlock+0x23/0x30
> 	 ? release_extent_buffer+0xa7/0xe0
> 	 commit_cowonly_roots+0xa2/0x2a0
> 	 ? btrfs_qgroup_account_extents+0x2d3/0x320
> 	 btrfs_commit_transaction+0x51f/0xc60
> 	 transaction_kthread+0x15a/0x180
> 	 kthread+0x151/0x170
> 	 ? btrfs_cleanup_transaction.isra.0+0x630/0x630
> 	 ? kthread_create_worker_on_cpu+0x70/0x70
> 	 ret_from_fork+0x22/0x30
> 	task:nfsd            state:D stack:    0 pid:31445 ppid:     2 flags:0x00004000
> 	Call Trace:
> 	 __schedule+0x35a/0xaa0
> 	 schedule+0x68/0xe0
> 	 btrfs_bio_counter_inc_blocked+0xe3/0x120

This task wants to read something and increments bio_counter, then sees
that FS_STATE_DEV_REPLACING and goes to sleep, so it's not really
contributing to the deadlock and is irrelevant.


> 	 ? add_wait_queue_exclusive+0x80/0x80
> 	 btrfs_map_bio+0x4d/0x3f0
> 	 ? rcu_read_lock_sched_held+0x16/0x80
> 	 ? kmem_cache_alloc+0x2e8/0x360
> 	 btrfs_submit_metadata_bio+0xe9/0x100
> 	 submit_one_bio+0x67/0x80
> 	 read_extent_buffer_pages+0x277/0x380

<snip>

> 	task:btrfs           state:D stack:    0 pid:14692 ppid: 14687 flags:0x00004000
> 	Call Trace:
> 	 __schedule+0x35a/0xaa0
> 	 schedule+0x68/0xe0
> 	 btrfs_rm_dev_replace_blocked+0x8a/0xc0

which is held here, yet we are blocked because we have pending bios and
bio_counter is > 0. I'd expect some task which has already issued its
bio to be blocked on transaction commit which would explain why dev
replace is waiting on a bio, which in turn is waiting on a transaction
commit which in turn is waiting on device replace so it becomes a
circular locking. However I don't see a task which is blocked on the
transaction commit and has submitted a bio and not having adjusted back
the bio count (as in the case of nfsd).

> 	 ? add_wait_queue_exclusive+0x80/0x80
> 	 btrfs_dev_replace_finishing+0x59a/0x790
> 	 btrfs_dev_replace_by_ioctl+0x59d/0x6f0
> 	 ? btrfs_dev_replace_by_ioctl+0x59d/0x6f0
> 	 btrfs_ioctl+0x27b2/0x2fe0
> 	 ? _raw_spin_unlock_irq+0x28/0x40
> 	 ? _raw_spin_unlock_irq+0x28/0x40
> 	 ? trace_hardirqs_on+0x54/0xf0
> 	 ? _raw_spin_unlock_irq+0x28/0x40
> 	 ? do_sigaction+0xfd/0x250
> 	 ? __might_fault+0x79/0x80
> 	 __x64_sys_ioctl+0x91/0xc0
> 	 ? __x64_sys_ioctl+0x91/0xc0
> 	 do_syscall_64+0x38/0x90
> 	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	RIP: 0033:0x7f1d8a0f4cc7
> 	RSP: 002b:00007ffc6cffe588 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> 	RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1d8a0f4cc7
> 	RDX: 00007ffc6cfff400 RSI: 00000000ca289435 RDI: 0000000000000003
> 	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> 	R10: 0000000000000008 R11: 0000000000000202 R12: 0000000000000003
> 	R13: 00005583a17fb2e0 R14: 00007ffc6d001b7a R15: 0000000000000001
> 	task:mkdir           state:D stack:    0 pid: 2349 ppid:  2346 flags:0x00000000

This just waits on the pending transaction so is irrelevant.

> 
> After a reboot (still in degraded mode), btrfs finishes the replace in
> a little under 5 seconds:
> 
> 	[  508.664454] BTRFS info (device dm-34): continuing dev_replace from <missing disk> (devid 5) to target /dev/mapper/md17 @100%
> 	[  513.285473] BTRFS info (device dm-34): dev_replace from <missing disk> (devid 5) to /dev/mapper/md17 finished
> 
