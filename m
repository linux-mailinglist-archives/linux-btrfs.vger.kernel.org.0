Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB4466DA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 00:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbhLBX0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 18:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349346AbhLBX0u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 18:26:50 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Dec 2021 15:23:27 PST
Received: from mail.virtall.com (mail.virtall.com [IPv6:2a01:4f8:141:216f::203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C3C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 15:23:26 -0800 (PST)
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id ECC519959F35
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
        t=1638486987; bh=YPfT92YfTBGcFBg1S9nGUy+ancJlpftbihCabuuAabI=;
        h=Date:From:To:Subject;
        b=OC0WRVlX6iwcDCRh8+brYrqZsCfoU9W4022EpVq+uWkN5pyTc5NpQci2jNwbaRB6s
         JegSIjjTzznMhsEkBgSFV3kY53hTNyhftpx8pqCd4WbBlsCHzXENOCd0v1/YaVpWXX
         wIROL/f2wv/HIi81+4G/y1x+Ao/AFp8e1KO8gINxLqA83KoJ8ydTiuucvSsJZ3Hc1e
         VnhzpvsV/HnFrbIh6SPrVSXj+aYGyYYV/X+pIXRzxL0R+pTr+KRNT3SKgmeXVms+GE
         0Ooz/I4JXL/Tn/4+M+FtGgxXpP3yrIRDSn5BuuDuh3kVwBaXJbWvgUbHL/vzMmEez1
         VuPO4Np/n95Ig==
X-Fuglu-Suspect: 1fa4f879941d4e03b982060a2db991b5
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.virtall.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 23:16:25 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 03 Dec 2021 00:16:22 +0100
From:   Tomasz Chmielewski <mangoo@wpkg.org>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: kworker/u32:5+btrfs-delalloc using 100% CPU
Message-ID: <c5af7d3735e68237fbd49a2ae69a7e7f@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On two of my servers running Linux 5.15.5 I can observe 
kworker/u32:5+btrfs-delalloc process using 100% CPU.

The servers receive files with rsync and I suspect that because of that 
process using 100% CPU, the speed is very slow, less than 1 MB/s over a 
gigabit network.


echo w > /proc/sysrq-trigger produces the following:

[566889.534346] sysrq: Show Blocked State
[566889.534615] task:kworker/u32:1   state:D stack:    0 pid:19498 ppid: 
     2 flags:0x00004000
[566889.534619] Workqueue: writeback wb_workfn (flush-btrfs-1)
[566889.534625] Call Trace:
[566889.534626]  <TASK>
[566889.534628]  __schedule+0x21a/0x530
[566889.534631]  schedule+0x4e/0xb0
[566889.534632]  io_schedule+0x46/0x70
[566889.534633]  wait_on_page_bit_common+0x10c/0x3d0
[566889.534636]  ? filemap_invalidate_unlock_two+0x40/0x40
[566889.534638]  __lock_page+0x4c/0x50
[566889.534640]  extent_write_cache_pages+0x377/0x4a0 [btrfs]
[566889.534680]  extent_writepages+0x92/0x130 [btrfs]
[566889.534706]  btrfs_writepages+0xe/0x10 [btrfs]
[566889.534728]  do_writepages+0xda/0x200
[566889.534731]  __writeback_single_inode+0x44/0x290
[566889.534733]  writeback_sb_inodes+0x223/0x4d0
[566889.534736]  __writeback_inodes_wb+0x56/0xf0
[566889.534737]  wb_writeback+0x1cc/0x290
[566889.534739]  wb_do_writeback+0x1fc/0x280
[566889.534741]  wb_workfn+0x77/0x250
[566889.534743]  ? psi_task_switch+0x1c8/0x1e0
[566889.534745]  ? finish_task_switch.isra.0+0xa7/0x260
[566889.534747]  process_one_work+0x229/0x3d0
[566889.534749]  worker_thread+0x53/0x420
[566889.534751]  kthread+0x11e/0x140
[566889.534753]  ? process_one_work+0x3d0/0x3d0
[566889.534755]  ? set_kthread_struct+0x50/0x50
[566889.534757]  ret_from_fork+0x22/0x30
[566889.534760]  </TASK>
[566889.534765] task:btrfs           state:D stack:    0 pid:22657 ppid: 
22651 flags:0x00000000
[566889.534767] Call Trace:
[566889.534767]  <TASK>
[566889.534768]  __schedule+0x21a/0x530
[566889.534769]  schedule+0x4e/0xb0
[566889.534770]  schedule_timeout+0x87/0x140
[566889.534773]  ? __bpf_trace_tick_stop+0x10/0x10
[566889.534775]  io_schedule_timeout+0x51/0x80
[566889.534776]  balance_dirty_pages+0x344/0xe70
[566889.534778]  ? __mod_lruvec_state+0x37/0x40
[566889.534781]  balance_dirty_pages_ratelimited+0x300/0x3d0
[566889.534783]  btrfs_buffered_write+0x59a/0x850 [btrfs]
[566889.534809]  btrfs_file_write_iter+0x76/0x130 [btrfs]
[566889.534834]  new_sync_write+0x117/0x1a0
[566889.534837]  vfs_write+0x1cd/0x260
[566889.534838]  __x64_sys_pwrite64+0x92/0xc0
[566889.534840]  do_syscall_64+0x5c/0xc0
[566889.534842]  ? do_syscall_64+0x69/0xc0
[566889.534844]  ? exit_to_user_mode_prepare+0x37/0xb0
[566889.534846]  ? syscall_exit_to_user_mode+0x27/0x50
[566889.534848]  ? __x64_sys_read+0x19/0x20
[566889.534849]  ? do_syscall_64+0x69/0xc0
[566889.534851]  ? syscall_exit_to_user_mode+0x27/0x50
[566889.534852]  ? do_syscall_64+0x69/0xc0
[566889.534854]  ? do_syscall_64+0x69/0xc0
[566889.534856]  ? do_syscall_64+0x69/0xc0
[566889.534858]  ? do_syscall_64+0x69/0xc0
[566889.534860]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
[566889.534862]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[566889.534864] RIP: 0033:0x7fb894d57cda
[566889.534866] RSP: 002b:00007ffc3620af08 EFLAGS: 00000246 ORIG_RAX: 
0000000000000012
[566889.534868] RAX: ffffffffffffffda RBX: 000000000000c000 RCX: 
00007fb894d57cda
[566889.534869] RDX: 000000000000c000 RSI: 00007ffc3620c095 RDI: 
0000000000000006
[566889.534869] RBP: 0000562681ae59e0 R08: 0000000000000000 R09: 
0000000000000093
[566889.534870] R10: 000000000fca4000 R11: 0000000000000246 R12: 
0000000000000000
[566889.534871] R13: 00007ffc3621e198 R14: 000000000fca4000 R15: 
00007ffc3620c095
[566889.534872]  </TASK>
[566889.534878] task:rsync           state:D stack:    0 pid:43786 ppid: 
43782 flags:0x00004000
[566889.534880] Call Trace:
[566889.534880]  <TASK>
[566889.534881]  __schedule+0x21a/0x530
[566889.534882]  schedule+0x4e/0xb0
[566889.534883]  schedule_timeout+0x87/0x140
[566889.534885]  ? free_extent_state+0x4a/0x90 [btrfs]
[566889.534912]  ? __bpf_trace_tick_stop+0x10/0x10
[566889.534913]  io_schedule_timeout+0x51/0x80
[566889.534914]  balance_dirty_pages+0x344/0xe70
[566889.534916]  ? __mod_lruvec_state+0x37/0x40
[566889.534919]  balance_dirty_pages_ratelimited+0x300/0x3d0
[566889.534921]  btrfs_buffered_write+0x59a/0x850 [btrfs]
[566889.534947]  btrfs_file_write_iter+0x76/0x130 [btrfs]
[566889.534972]  new_sync_write+0x117/0x1a0
[566889.534974]  vfs_write+0x1cd/0x260
[566889.534975]  ksys_write+0x67/0xe0
[566889.534977]  __x64_sys_write+0x19/0x20
[566889.534978]  do_syscall_64+0x5c/0xc0
[566889.534980]  ? ksys_read+0xb1/0xe0
[566889.534981]  ? exit_to_user_mode_prepare+0x37/0xb0
[566889.534983]  ? syscall_exit_to_user_mode+0x27/0x50
[566889.534984]  ? __x64_sys_read+0x19/0x20
[566889.534985]  ? do_syscall_64+0x69/0xc0
[566889.534987]  ? __x64_sys_select+0x21/0x30
[566889.534989]  ? do_syscall_64+0x69/0xc0
[566889.534991]  ? do_syscall_64+0x69/0xc0
[566889.534993]  ? asm_common_interrupt+0x8/0x40
[566889.534995]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[566889.534997] RIP: 0033:0x7f12f22e81e7
[566889.534998] RSP: 002b:00007ffd870af8c8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[566889.534999] RAX: ffffffffffffffda RBX: 00005654bb3b64d0 RCX: 
00007f12f22e81e7
[566889.535000] RDX: 0000000000040000 RSI: 00005654bb3b64d0 RDI: 
0000000000000004
[566889.535001] RBP: 0000000000000004 R08: 00000000000041e1 R09: 
00005654bb3a9ff1
[566889.535002] R10: 000000005f0494dd R11: 0000000000000246 R12: 
0000000000040000
[566889.535002] R13: 00005654bb3a6480 R14: 0000000000003b71 R15: 
00007ffd870af9a8
[566889.535004]  </TASK>




Tomasz Chmielewski
