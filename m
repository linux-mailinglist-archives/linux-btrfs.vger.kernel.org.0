Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAF438409
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Oct 2021 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJWPhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Oct 2021 11:37:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34529 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229954AbhJWPhB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Oct 2021 11:37:01 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19NFYcnT005856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Oct 2021 11:34:39 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9B1A215C34DD; Sat, 23 Oct 2021 11:34:38 -0400 (EDT)
Date:   Sat, 23 Oct 2021 11:34:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
Subject: Is generic/647 known failing test for btrfs?
Message-ID: <YXQrjnZcqU8pmUOI@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm seeing generic/647 cause a 5.15-rc4 based kernel to hang/deadlock
when running xfststs on brtfs.  Is this a known problem?

A pretty munged serial console output is attached below.

Thanks!

[ 9085.034794] run fstests generic/647 at 2021-10-23 03:07:13
Oct 23 03:07:13 xfstests-tytso-20211023003444 systemd[1]: Started /usr/bin/bash -c test -w /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/647.
Oct 23 03:09:00 xfstests-tytso-20211023003444 systemd[1]: Starting Clean php session files...
Oct 23 03:09:01 xfstests-tytso-20211023003444 systemd[1]: phpsessionclean.service: Succeeded.
Oct 23 03:09:01 xfstests-tytso-20211023003444 systemd[1]: Started Clean php session files.
[ 9214.888763] INFO: task mmap-rw-fault:11719 blocked for more than 122 seconds.
[ 9214.896065]       Not tainted 5.15.0-rc4-xfstests-00012-gfb5becb151d5 #369
[ 9214.903209] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 9214.911174] task:mmap-rw-fault   state:D stack:    0 pid:11719 ppid: 11423 flags:0x00000000
[ 9214.919701] Call Trace:
Oct 23 03:09:23 [ 9214.922419]  __schedule+0x30a/0x8f0
xfstests-tytso-2[ 9214.927533]  ? _raw_spin_lock_irqsave+0x5a/0x90
0211023003444 ke[ 9214.933500]  schedule+0x59/0xc0
rnel: [ 9214.888[ 9214.938181]  wait_extent_bit.constprop.0+0x1eb/0x260
763] INFO: task [ 9214.944786]  ? print_dl_stats+0x30/0x30
mmap-rw-fault:11[ 9214.950067]  lock_extent_bits+0x37/0x90
719 blocked for [ 9214.955845]  btrfs_lock_and_flush_ordered_range+0xa9/0x120
more than 122 se[ 9214.962839]  extent_readahead+0x9a/0x160
conds.
Oct 23 0[ 9214.968448]  ? __mod_memcg_lruvec_state+0x21/0x40
3:09:23 xfstests[ 9214.974635]  ? rcu_read_lock_sched_held+0x12/0x70
-tytso-202110230[ 9214.980886]  ? __add_to_page_cache_locked+0x1c7/0x390
03444 kernel: [ [ 9214.987475]  ? lock_release+0xd5/0x110
9214.896065]    [ 9214.992750]  ? trace_hardirqs_on+0x1b/0xd0
   Not tainted 5[ 9214.998371]  ? rcu_read_lock_sched_held+0x12/0x70
.15.0-rc4-xfstes[ 9215.004595]  ? rcu_read_lock_sched_held+0x12/0x70
ts-00012-gfb5bec[ 9215.010823]  ? lock_acquire+0xf3/0x130
b151d5 #369
Oct[ 9215.016131]  ? lru_cache_add+0x5/0x170
 23 03:09:23 xfs[ 9215.021396]  read_pages+0x86/0x250
tests-tytso-2021[ 9215.026424]  ? lru_cache_add+0xd7/0x170
1023003444 kerne[ 9215.031798]  page_cache_ra_unbounded+0x1bd/0x240
l: [ 9214.903209[ 9215.039498]  ? xas_start+0x3b/0x260
] "echo 0 > /pro[ 9215.044777]  do_sync_mmap_readahead+0x11f/0x1b0
c/sys/kernel/hun[ 9215.050897]  filemap_fault+0x4f9/0xa10
g_task_timeout_s[ 9215.056204]  ? try_charge_memcg+0x1ec/0x720
ecs" disables th[ 9215.061877]  ? rcu_read_lock_sched_held+0x12/0x70
is message.
Oct[ 9215.068384]  ? rcu_read_lock_sched_held+0x12/0x70
 23 03:09:23 xfs[ 9215.074781]  ? lock_acquire+0xf3/0x130
tests-tytso-2021[ 9215.080233]  ? rcu_read_lock_sched_held+0x12/0x70
1023003444 kerne[ 9215.086475]  ? lock_acquire+0xf3/0x130
l: [ 9214.911174[ 9215.091750]  ? __cgroup_throttle_swaprate+0xb/0x2b0
] task:mmap-rw-f[ 9215.098173]  __do_fault+0x38/0xb0
ault   state:D s[ 9215.103268]  do_cow_fault+0xa9/0x270
tack:    0 pid:1[ 9215.108341]  do_fault+0x36/0x250
1719 ppid: 11423[ 9215.113043]  __handle_mm_fault+0x188/0x200
 flags:0x0000000[ 9215.118694]  handle_mm_fault+0x129/0x3b0
0
Oct 23 03:09:[ 9215.124329]  __get_user_pages+0x181/0x3e0
23 xfstests-tyts[ 9215.130011]  get_user_pages_unlocked+0xcf/0x340
o-20211023003444[ 9215.136024]  internal_get_user_pages_fast+0x234/0x2b0
 kernel: [ 9214.[ 9215.142794]  iov_iter_get_pages+0x7d/0x270
919701] Call Tra[ 9215.148485]  __bio_iov_iter_get_pages+0x6f/0x240
ce:
Oct 23 03:0[ 9215.154604]  bio_iov_iter_get_pages+0x24/0xb0
9:23 xfstests-ty[ 9215.160525]  iomap_dio_bio_iter+0x245/0x420
tso-202110230034[ 9215.166293]  __iomap_dio_rw+0x37f/0x630
44 kernel: [ 921[ 9215.171611]  ? vma_link+0x3d/0x1c0
4.922419]  __sch[ 9215.176615]  iomap_dio_rw+0xa/0x30
edule+0x30a/0x8f[ 9215.181709]  btrfs_file_read_iter+0x111/0x140
0
Oct 23 03:09:[ 9215.187652]  new_sync_read+0x11b/0x1a0
23 xfstests-tyts[ 9215.192924]  ? shrink_active_list+0x580/0x610
o-20211023003444[ 9215.198778]  vfs_read+0x106/0x1a0
 kernel: [ 9214.[ 9215.203687]  __x64_sys_pread64+0x8c/0xc0
927533]  ? _raw_[ 9215.209109]  ? ksys_mmap_pgoff+0x88/0xd0
spin_lock_irqsav[ 9215.214549]  do_syscall_64+0x3b/0x90
e+0x5a/0x90
Oct[ 9215.219704]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 23 03:09:23 xfs[ 9215.226309] RIP: 0033:0x7f9bcf764df4
tests-tytso-2021[ 9215.231359] RSP: 002b:00007ffd2afdd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
1023003444 kerne[ 9215.240459] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f9bcf764df4
l: [ 9214.933500[ 9215.249189] RDX: 0000000000001000 RSI: 00007f9bcf77d000 RDI: 0000000000000003
]  schedule+0x59[ 9215.257848] RBP: 00007f9bcf77d000 R08: 0000000000000003 R09: 0000000000000000
/0xc0
Oct 23 03[ 9215.266504] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
:09:23 xfstests-[ 9215.275177] R13: 0000000000001000 R14: 0000000000000003 R15: 0000000000000000
tytso-2021102300[ 9215.283834] INFO: lockdep is turned off.
3444 kernel: [ 9214.938181]  wait_extent_bit.constprop.0+0x1eb/0x260
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.944786]  ? print_dl_stats+0x30/0x30
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.950067]  lock_extent_bits+0x37/0x90
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.955845]  btrfs_lock_and_flush_ordered_range+0xa9/0x120
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.962839]  extent_readahead+0x9a/0x160
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.968448]  ? __mod_memcg_lruvec_state+0x21/0x40
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.974635]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.980886]  ? __add_to_page_cache_locked+0x1c7/0x390
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.987475]  ? lock_release+0xd5/0x110
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.992750]  ? trace_hardirqs_on+0x1b/0xd0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9214.998371]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.004595]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.010823]  ? lock_acquire+0xf3/0x130
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.016131]  ? lru_cache_add+0x5/0x170
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.021396]  read_pages+0x86/0x250
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.026424]  ? lru_cache_add+0xd7/0x170
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.031798]  page_cache_ra_unbounded+0x1bd/0x240
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.039498]  ? xas_start+0x3b/0x260
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.044777]  do_sync_mmap_readahead+0x11f/0x1b0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.050897]  filemap_fault+0x4f9/0xa10
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.056204]  ? try_charge_memcg+0x1ec/0x720
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.061877]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.068384]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.074781]  ? lock_acquire+0xf3/0x130
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.080233]  ? rcu_read_lock_sched_held+0x12/0x70
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.086475]  ? lock_acquire+0xf3/0x130
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.091750]  ? __cgroup_throttle_swaprate+0xb/0x2b0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.098173]  __do_fault+0x38/0xb0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.103268]  do_cow_fault+0xa9/0x270
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.108341]  do_fault+0x36/0x250
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.113043]  __handle_mm_fault+0x188/0x200
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.118694]  handle_mm_fault+0x129/0x3b0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.124329]  __get_user_pages+0x181/0x3e0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.130011]  get_user_pages_unlocked+0xcf/0x340
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.136024]  internal_get_user_pages_fast+0x234/0x2b0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.142794]  iov_iter_get_pages+0x7d/0x270
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.148485]  __bio_iov_iter_get_pages+0x6f/0x240
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.154604]  bio_iov_iter_get_pages+0x24/0xb0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.160525]  iomap_dio_bio_iter+0x245/0x420
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.166293]  __iomap_dio_rw+0x37f/0x630
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.171611]  ? vma_link+0x3d/0x1c0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.176615]  iomap_dio_rw+0xa/0x30
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.181709]  btrfs_file_read_iter+0x111/0x140
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.187652]  new_sync_read+0x11b/0x1a0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.192924]  ? shrink_active_list+0x580/0x610
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.198778]  vfs_read+0x106/0x1a0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.203687]  __x64_sys_pread64+0x8c/0xc0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.209109]  ? ksys_mmap_pgoff+0x88/0xd0
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.214549]  do_syscall_64+0x3b/0x90
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.219704]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.226309] RIP: 0033:0x7f9bcf764df4
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.231359] RSP: 002b:00007ffd2afdd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.240459] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007f9bcf764df4
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.249189] RDX: 0000000000001000 RSI: 00007f9bcf77d000 RDI: 0000000000000003
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.257848] RBP: 00007f9bcf77d000 R08: 0000000000000003 R09: 0000000000000000
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.266504] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.275177] R13: 0000000000001000 R14: 0000000000000003 R15: 0000000000000000
Oct 23 03:09:23 xfstests-tytso-20211023003444 kernel: [ 9215.283834] INFO: lockdep is turned off.
[ 9337.755942] INFO: task mmap-rw-fault:11719 blocked for more than 245 seconds.
[ 9337.763670]       Not tainted 5.15.0-rc4-xfstests-00012-gfb5becb151d5 #369
[ 9337.770861] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

