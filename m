Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D2515420
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380126AbiD2S5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiD2S5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:57:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35996CEE33
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:54:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E42731F893;
        Fri, 29 Apr 2022 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651258466;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHAlOyA03FtLolpLknUHmLYkbNSq/ps5k4K+sm756zk=;
        b=CjK3rSR8MXFl/1YKFE0flC/qorQm4E8U407zkL75ICurcWfEpJKefLhDfBLh7pSQViM/0A
        Y/VNCR0AlE6WkD8SGCliV7GzbLxIzWBwaFZSnzpVrki3WarQ5cZ8sGwujEkf0rkTLQI5JF
        WRh0T29LkHBUwI96ZfmugzvQsNCYNkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651258466;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHAlOyA03FtLolpLknUHmLYkbNSq/ps5k4K+sm756zk=;
        b=bM1DrvbKd0sLizBuKPdwpxA3shgx+/MFzjhmOfWaHc+0wQtHXSrRFUdrEAF5JNStD0Rk6Q
        rW/LRchiF1OLcgBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CBF413AE0;
        Fri, 29 Apr 2022 18:54:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id skdYJWI0bGKhdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Apr 2022 18:54:26 +0000
Date:   Fri, 29 Apr 2022 20:50:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock between concurrent dio writes when
 low on free data space
Message-ID: <20220429185017.GH18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <ca54a0f0251d2f77c51747de0e096f7f29542feb.1651154066.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca54a0f0251d2f77c51747de0e096f7f29542feb.1651154066.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 02:59:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When reserving data space for a direct IO write we can end up deadlocking
> if we have multiple tasks attempting a write to the same file range, there
> are multiple extents covered by that file range, we are low on available
> space for data and the writes don't expand the inode's i_size.
> 
> The deadlock can happen like this:
> 
> 1) We have a file with an i_size of 1M, at offset 0 it has an extent with
>    a size of 128K and at offset 128K it has another extent also with a
>    size of 128K;
> 
> 2) Task A does a direct IO write against file range [0, 256K[, and because
>    the write is within the i_size boundary, it takes the inode's lock (VFS
>    level) in shared mode;
> 
> 3) Task A locks the file range [0, 256K[ at btrfs_dio_iomap_begin(), and
>    then gets the extent map for the extent covering the range [0, 128K[.
>    At btrfs_get_blocks_direct_write(), it creates an ordered extent for
>    that file range ([0, 128K[);
> 
> 4) Before returning from btrfs_dio_iomap_begin(), it unlocks the file
>    range [0, 256K[;
> 
> 5) Task A executes btrfs_dio_iomap_begin() again, this time for the file
>    range [128K, 256K[, and locks the file range [128K, 256K[;
> 
> 6) Task B starts a direct IO write against file range [0, 256K[ as well.
>    It also locks the inode in shared mode, as it's within the i_size limit,
>    and then tries to lock file range [0, 256K[. It is able to lock the
>    subrange [0, 128K[ but then blocks waiting for the range [128K, 256K[,
>    as it is currently locked by task A;
> 
> 7) Task A enters btrfs_get_blocks_direct_write() and tries to reserve data
>    space. Because we are low on available free space, it triggers the
>    async data reclaim task, and waits for it to reserve data space;
> 
> 8) The async reclaim task decides to wait for all existing ordered extents
>    to complete (through btrfs_wait_ordered_roots()).
>    It finds the ordered extent previously created by task A for the file
>    range [0, 128K[ and waits for it to complete;
> 
> 9) The ordered extent for the file range [0, 128K[ can not complete
>    because it blocks at btrfs_finish_ordered_io() when trying to lock the
>    file range [0, 128K[.
> 
>    This results in a deadlock, because:
> 
>    - task B is holding the file range [0, 128K[ locked, waiting for the
>      range [128K, 256K[ to be unlocked by task A;
> 
>    - task A is holding the file range [128K, 256K[ locked and it's waiting
>      for the async data reclaim task to satisfy its space reservation
>      request;
> 
>    - the async data reclaim task is waiting for ordered extent [0, 128K[
>      to complete, but the ordered extent can not complete because the
>      file range [0, 128K[ is currently locked by task B, which is waiting
>      on task A to unlock file range [128K, 256K[ and task A waiting
>      on the async data reclaim task.
> 
>    This results in a deadlock between 4 task: task A, task B, the async
>    data reclaim task and the task doing ordered extent completion (a work
>    queue task).
> 
> This type of deadlock can sporadically be triggered by the test case
> generic/300 from fstests, and results in a stack trace like the following:
> 
> [12084.033689] INFO: task kworker/u16:7:123749 blocked for more than 241 seconds.
> [12084.034877]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
> [12084.035562] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [12084.036548] task:kworker/u16:7   state:D stack:    0 pid:123749 ppid:     2 flags:0x00004000
> [12084.036554] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [12084.036599] Call Trace:
> [12084.036601]  <TASK>
> [12084.036606]  __schedule+0x3cb/0xed0
> [12084.036616]  schedule+0x4e/0xb0
> [12084.036620]  btrfs_start_ordered_extent+0x109/0x1c0 [btrfs]
> [12084.036651]  ? prepare_to_wait_exclusive+0xc0/0xc0
> [12084.036659]  btrfs_run_ordered_extent_work+0x1a/0x30 [btrfs]
> [12084.036688]  btrfs_work_helper+0xf8/0x400 [btrfs]
> [12084.036719]  ? lock_is_held_type+0xe8/0x140
> [12084.036727]  process_one_work+0x252/0x5a0
> [12084.036736]  ? process_one_work+0x5a0/0x5a0
> [12084.036738]  worker_thread+0x52/0x3b0
> [12084.036743]  ? process_one_work+0x5a0/0x5a0
> [12084.036745]  kthread+0xf2/0x120
> [12084.036747]  ? kthread_complete_and_exit+0x20/0x20
> [12084.036751]  ret_from_fork+0x22/0x30
> [12084.036765]  </TASK>
> [12084.036769] INFO: task kworker/u16:11:153787 blocked for more than 241 seconds.
> [12084.037702]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
> [12084.038540] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [12084.039506] task:kworker/u16:11  state:D stack:    0 pid:153787 ppid:     2 flags:0x00004000
> [12084.039511] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
> [12084.039551] Call Trace:
> [12084.039553]  <TASK>
> [12084.039557]  __schedule+0x3cb/0xed0
> [12084.039566]  schedule+0x4e/0xb0
> [12084.039569]  schedule_timeout+0xed/0x130
> [12084.039573]  ? mark_held_locks+0x50/0x80
> [12084.039578]  ? _raw_spin_unlock_irq+0x24/0x50
> [12084.039580]  ? lockdep_hardirqs_on+0x7d/0x100
> [12084.039585]  __wait_for_common+0xaf/0x1f0
> [12084.039587]  ? usleep_range_state+0xb0/0xb0
> [12084.039596]  btrfs_wait_ordered_extents+0x3d6/0x470 [btrfs]
> [12084.039636]  btrfs_wait_ordered_roots+0x175/0x240 [btrfs]
> [12084.039670]  flush_space+0x25b/0x630 [btrfs]
> [12084.039712]  btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
> [12084.039747]  process_one_work+0x252/0x5a0
> [12084.039756]  ? process_one_work+0x5a0/0x5a0
> [12084.039758]  worker_thread+0x52/0x3b0
> [12084.039762]  ? process_one_work+0x5a0/0x5a0
> [12084.039765]  kthread+0xf2/0x120
> [12084.039766]  ? kthread_complete_and_exit+0x20/0x20
> [12084.039770]  ret_from_fork+0x22/0x30
> [12084.039783]  </TASK>
> [12084.039800] INFO: task kworker/u16:17:217907 blocked for more than 241 seconds.
> [12084.040709]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
> [12084.041398] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [12084.042404] task:kworker/u16:17  state:D stack:    0 pid:217907 ppid:     2 flags:0x00004000
> [12084.042411] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> [12084.042461] Call Trace:
> [12084.042463]  <TASK>
> [12084.042471]  __schedule+0x3cb/0xed0
> [12084.042485]  schedule+0x4e/0xb0
> [12084.042490]  wait_extent_bit.constprop.0+0x1eb/0x260 [btrfs]
> [12084.042539]  ? prepare_to_wait_exclusive+0xc0/0xc0
> [12084.042551]  lock_extent_bits+0x37/0x90 [btrfs]
> [12084.042601]  btrfs_finish_ordered_io.isra.0+0x3fd/0x960 [btrfs]
> [12084.042656]  ? lock_is_held_type+0xe8/0x140
> [12084.042667]  btrfs_work_helper+0xf8/0x400 [btrfs]
> [12084.042716]  ? lock_is_held_type+0xe8/0x140
> [12084.042727]  process_one_work+0x252/0x5a0
> [12084.042742]  worker_thread+0x52/0x3b0
> [12084.042750]  ? process_one_work+0x5a0/0x5a0
> [12084.042754]  kthread+0xf2/0x120
> [12084.042757]  ? kthread_complete_and_exit+0x20/0x20
> [12084.042763]  ret_from_fork+0x22/0x30
> [12084.042783]  </TASK>
> [12084.042798] INFO: task fio:234517 blocked for more than 241 seconds.
> [12084.043598]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
> [12084.044282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [12084.045244] task:fio             state:D stack:    0 pid:234517 ppid:234515 flags:0x00004000
> [12084.045248] Call Trace:
> [12084.045250]  <TASK>
> [12084.045254]  __schedule+0x3cb/0xed0
> [12084.045263]  schedule+0x4e/0xb0
> [12084.045266]  wait_extent_bit.constprop.0+0x1eb/0x260 [btrfs]
> [12084.045298]  ? prepare_to_wait_exclusive+0xc0/0xc0
> [12084.045306]  lock_extent_bits+0x37/0x90 [btrfs]
> [12084.045336]  btrfs_dio_iomap_begin+0x336/0xc60 [btrfs]
> [12084.045370]  ? lock_is_held_type+0xe8/0x140
> [12084.045378]  iomap_iter+0x184/0x4c0
> [12084.045383]  __iomap_dio_rw+0x2c6/0x8a0
> [12084.045406]  iomap_dio_rw+0xa/0x30
> [12084.045408]  btrfs_do_write_iter+0x370/0x5e0 [btrfs]
> [12084.045440]  aio_write+0xfa/0x2c0
> [12084.045448]  ? __might_fault+0x2a/0x70
> [12084.045451]  ? kvm_sched_clock_read+0x14/0x40
> [12084.045455]  ? lock_release+0x153/0x4a0
> [12084.045463]  io_submit_one+0x615/0x9f0
> [12084.045467]  ? __might_fault+0x2a/0x70
> [12084.045469]  ? kvm_sched_clock_read+0x14/0x40
> [12084.045478]  __x64_sys_io_submit+0x83/0x160
> [12084.045483]  ? syscall_enter_from_user_mode+0x1d/0x50
> [12084.045489]  do_syscall_64+0x3b/0x90
> [12084.045517]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [12084.045521] RIP: 0033:0x7fa76511af79
> [12084.045525] RSP: 002b:00007ffd6d6b9058 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> [12084.045530] RAX: ffffffffffffffda RBX: 00007fa75ba6e760 RCX: 00007fa76511af79
> [12084.045532] RDX: 0000557b304ff3f0 RSI: 0000000000000001 RDI: 00007fa75ba4c000
> [12084.045535] RBP: 00007fa75ba4c000 R08: 00007fa751b76000 R09: 0000000000000330
> [12084.045537] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [12084.045540] R13: 0000000000000000 R14: 0000557b304ff3f0 R15: 0000557b30521eb0
> [12084.045561]  </TASK>
> 
> Fix this issue by always reserving data space before locking a file range
> at btrfs_dio_iomap_begin(). If we can't reserve the space, then we don't
> error out immediately - instead after locking the file range, check if we
> can do a NOCOW write, and if we can we don't error out since we don't need
> to allocate a data extent, however if we can't NOCOW then error out with
> -ENOSPC. This also implies that we may end up reserving space when it's
> not needed because the write will end up being done in NOCOW mode - in that
> case we just release the space after we noticed we did a NOCOW write - this
> is the same type of logic that is done in the path for buffered IO writes.
> 
> Fixes: f0bfa76a11e93d ("btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
