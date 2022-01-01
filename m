Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8F48285C
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiAATsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 14:48:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43166 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAATsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jan 2022 14:48:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05F4D1F38C;
        Sat,  1 Jan 2022 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641066509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwhshQPZSL/7OZIMRInUJYuun8kmQXSDUq8ko03SDb4=;
        b=MSbeUOJcDcnVkJBzuV+HrNzZSTBjdKSRNV3ORoJV2N2+OA7OioRCwSKMLU1/DAQWuHtYi7
        SIkubN+ALni+7AGjI7RXZO/RklwivkhjV+BptLVvigFTavL8krwEj2pcdu8cyg9XGeg+kr
        54lXMPoD6eaY3IWqVEamg6lQBmUMNNw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5B5413AFF;
        Sat,  1 Jan 2022 19:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y26vLAyw0GGvHwAAMHmgww
        (envelope-from <nborisov@suse.com>); Sat, 01 Jan 2022 19:48:28 +0000
Subject: Re: 'btrfs replace' hangs at end of replacing a device (v5.10.82)
From:   Nikolay Borisov <nborisov@suse.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20211129214647.GH17148@hungrycats.org>
 <cfceba98-f925-8a95-5b09-caec932efc42@suse.com>
Message-ID: <eb5804bc-10d0-ab12-73c4-bcaa08b297e0@suse.com>
Date:   Sat, 1 Jan 2022 21:48:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cfceba98-f925-8a95-5b09-caec932efc42@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.11.21 г. 15:55, Nikolay Borisov wrote:
> 
> 
> On 29.11.21 г. 23:46, Zygo Blaxell wrote:
>> Not a new bug, but it's still there.  btrfs replace ends in a transaction
>> deadlock.
>>
>> 'btrfs replace status' reports the replace completed and exits:
>>
>> 	Started on 27.Nov 02:05:07, finished on 29.Nov 14:11:20, 0 write errs, 0 uncorr. read errs
>>
>> Magic-SysRq-W:
>>
>> 	sysrq: Show Blocked State
>> 	task:btrfs-transacti state:D stack:    0 pid:29509 ppid:     2 flags:0x00004000
>> 	Call Trace:
>> 	 __schedule+0x35a/0xaa0
>> 	 schedule+0x68/0xe0
>> 	 schedule_preempt_disabled+0x15/0x20
>> 	 __mutex_lock+0x1ac/0x7e0
>> 	 ? lock_acquire+0x190/0x2d0
>> 	 ? btrfs_run_dev_stats+0x46/0x450
>> 	 ? rcu_read_lock_sched_held+0x16/0x80
>> 	 mutex_lock_nested+0x1b/0x20
>> 	 btrfs_run_dev_stats+0x46/0x450
>> 	 ? _raw_spin_unlock+0x23/0x30
>> 	 ? release_extent_buffer+0xa7/0xe0
>> 	 commit_cowonly_roots+0xa2/0x2a0
>> 	 ? btrfs_qgroup_account_extents+0x2d3/0x320
>> 	 btrfs_commit_transaction+0x51f/0xc60
>> 	 transaction_kthread+0x15a/0x180
>> 	 kthread+0x151/0x170
>> 	 ? btrfs_cleanup_transaction.isra.0+0x630/0x630
>> 	 ? kthread_create_worker_on_cpu+0x70/0x70
>> 	 ret_from_fork+0x22/0x30
>> 	task:nfsd            state:D stack:    0 pid:31445 ppid:     2 flags:0x00004000
>> 	Call Trace:
>> 	 __schedule+0x35a/0xaa0
>> 	 schedule+0x68/0xe0
>> 	 btrfs_bio_counter_inc_blocked+0xe3/0x120
>> 	 ? add_wait_queue_exclusive+0x80/0x80
>> 	 btrfs_map_bio+0x4d/0x3f0
>> 	 ? rcu_read_lock_sched_held+0x16/0x80
>> 	 ? kmem_cache_alloc+0x2e8/0x360
>> 	 btrfs_submit_metadata_bio+0xe9/0x100
>> 	 submit_one_bio+0x67/0x80
>> 	 read_extent_buffer_pages+0x277/0x380
>> 	 btree_read_extent_buffer_pages+0xa1/0x120
>> 	 read_tree_block+0x3b/0x70
>> 	 read_block_for_search.isra.0+0x1a2/0x350
>> 	 ? rcu_read_lock_sched_held+0x16/0x80
>> 	 btrfs_search_slot+0x20f/0x910
>> 	 btrfs_lookup_dir_item+0x78/0xc0
>> 	 btrfs_lookup_dentry+0xca/0x540
>> 	 btrfs_lookup+0x13/0x40
>> 	 __lookup_slow+0x10d/0x1e0
>> 	 ? rcu_read_lock_sched_held+0x16/0x80
>> 	 lookup_one_len+0x77/0x90
>> 	 nfsd_lookup_dentry+0xe0/0x440 [nfsd]
>> 	 nfsd_lookup+0x89/0x150 [nfsd]
>> 	 nfsd4_lookup+0x1a/0x20 [nfsd]
>> 	 nfsd4_proc_compound+0x58b/0x8a0 [nfsd]
>> 	 nfsd_dispatch+0xe6/0x1a0 [nfsd]
>> 	 svc_process+0x55e/0x990 [sunrpc]
>> 	 ? nfsd_svc+0x6a0/0x6a0 [nfsd]
>> 	 nfsd+0x173/0x2a0 [nfsd]
>> 	 kthread+0x151/0x170
>> 	 ? nfsd_destroy+0x190/0x190 [nfsd]
>> 	 ? kthread_create_worker_on_cpu+0x70/0x70
>> 	 ret_from_fork+0x22/0x30
>> 	task:btrfs           state:D stack:    0 pid:14692 ppid: 14687 flags:0x00004000
>> 	Call Trace:
>> 	 __schedule+0x35a/0xaa0
>> 	 schedule+0x68/0xe0
>> 	 btrfs_rm_dev_replace_blocked+0x8a/0xc0
>> 	 ? add_wait_queue_exclusive+0x80/0x80
>> 	 btrfs_dev_replace_finishing+0x59a/0x790
>> 	 btrfs_dev_replace_by_ioctl+0x59d/0x6f0
>> 	 ? btrfs_dev_replace_by_ioctl+0x59d/0x6f0
>> 	 btrfs_ioctl+0x27b2/0x2fe0
>> 	 ? _raw_spin_unlock_irq+0x28/0x40
>> 	 ? _raw_spin_unlock_irq+0x28/0x40
>> 	 ? trace_hardirqs_on+0x54/0xf0
>> 	 ? _raw_spin_unlock_irq+0x28/0x40
>> 	 ? do_sigaction+0xfd/0x250
>> 	 ? __might_fault+0x79/0x80
>> 	 __x64_sys_ioctl+0x91/0xc0
>> 	 ? __x64_sys_ioctl+0x91/0xc0
>> 	 do_syscall_64+0x38/0x90
>> 	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> 	RIP: 0033:0x7f1d8a0f4cc7
>> 	RSP: 002b:00007ffc6cffe588 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
>> 	RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1d8a0f4cc7
>> 	RDX: 00007ffc6cfff400 RSI: 00000000ca289435 RDI: 0000000000000003
>> 	RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> 	R10: 0000000000000008 R11: 0000000000000202 R12: 0000000000000003
>> 	R13: 00005583a17fb2e0 R14: 00007ffc6d001b7a R15: 0000000000000001
>> 	task:mkdir           state:D stack:    0 pid: 2349 ppid:  2346 flags:0x00000000
>> 	Call Trace:
>> 	 __schedule+0x35a/0xaa0
>> 	 schedule+0x68/0xe0
>> 	 wait_current_trans+0xed/0x150
>> 	 ? add_wait_queue_exclusive+0x80/0x80
>> 	 start_transaction+0x551/0x700
>> 	 btrfs_start_transaction+0x1e/0x20
>> 	 btrfs_mkdir+0x5f/0x210
>> 	 vfs_mkdir+0x150/0x200
>> 	 do_mkdirat+0x118/0x140
>> 	 __x64_sys_mkdir+0x1b/0x20
>> 	 do_syscall_64+0x38/0x90
>> 	 entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> 	RIP: 0033:0x7f608a3c6b07
>> 	RSP: 002b:00007fffbbd2bab8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
>> 	RAX: ffffffffffffffda RBX: 0000563d79f1dc30 RCX: 00007f608a3c6b07
>> 	RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007fffbbd2db5e
>> 	RBP: 00007fffbbd2db39 R08: 0000000000000000 R09: 0000563d79f1dd60
>> 	R10: fffffffffffff284 R11: 0000000000000246 R12: 00000000000001ff
>> 	R13: 00007fffbbd2bc30 R14: 00007fffbbd2db5e R15: 0000000000000000
>>
>> After a reboot (still in degraded mode), btrfs finishes the replace in
>> a little under 5 seconds:
>>
>> 	[  508.664454] BTRFS info (device dm-34): continuing dev_replace from <missing disk> (devid 5) to target /dev/mapper/md17 @100%
>> 	[  513.285473] BTRFS info (device dm-34): dev_replace from <missing disk> (devid 5) to /dev/mapper/md17 finished
>>
> 
> 
> I have a working hypothesis what might be going wrong, however without a
> crash dump to investigate I can't really confirm it. Basically I think
> btrfs_rm_dev_replace_blocked is not seeing the decrement aka the store
> to running bios count since it's using cond_wake_up_nomb. If I'm right
> then the following should fix it:
> 
> @@ -1122,7 +1123,8 @@ void btrfs_bio_counter_inc_noblocked(struct
> btrfs_fs_info *fs_info)
>  void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
>  {
>         percpu_counter_sub(&fs_info->dev_replace.bio_counter, amount);
> -       cond_wake_up_nomb(&fs_info->dev_replace.replace_wait);
> +       /* paired with the wait_event barrier in replace_blocked */
> +       cond_wake_up(&fs_info->dev_replace.replace_wait);
>  }

Ping, any feedback on this patch?


> 
> 
> 
> Can you apply it and see if it can reproduce, I don't know what's the
> incident rate of this bug so you have to decide at what point it should
> be fixed. In any case this patch can't have any negative functional
> impact, it just makes the ordering slightly stronger to ensure the write
> happens before possibly waking up someone on the queue.
> 
> 
