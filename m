Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43A5461E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347608AbiFJJYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbiFJJXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 05:23:54 -0400
Received: from out20-133.mail.aliyun.com (out20-133.mail.aliyun.com [115.124.20.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1D2A97D
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 02:22:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04442967|-1;BR=01201311R341S73rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0235051-0.000940436-0.975554;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.O1e1fH-_1654852918;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O1e1fH-_1654852918)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 17:21:59 +0800
Date:   Fri, 10 Jun 2022 17:22:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: fstests btrfs/057 trigger a deadlock on 5.4.187
Message-Id: <20220610172202.E0EB.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

fstests btrfs/057 trigger a deadlock on linux 5.4.187

Frequency: yet not able to reproduce it after 50 loops.
but it happen on a server with ECC memory.

Maybe the Call Trace info help.

[ 2437.005526] sysrq: Show Blocked State
[ 2437.009825]   task                        PC stack   pid father
[ 2437.017595] btrfs-cleaner   D    0 42617      2 0x80004000
[ 2437.023916] Call Trace:
[ 2437.026841]  __schedule+0x2e9/0x730
[ 2437.030921]  schedule+0x36/0xc0
[ 2437.034672]  wait_current_trans+0xd4/0x110 [btrfs]
[ 2437.040224]  ? finish_wait+0x80/0x80
[ 2437.044462]  start_transaction+0x42a/0x500 [btrfs]
[ 2437.050051]  btrfs_drop_snapshot+0x548/0x840 [btrfs]
[ 2437.055818]  ? btrfs_run_defrag_inodes+0x79/0x380 [btrfs]
[ 2437.062054]  ? down_write+0x21/0x50
[ 2437.066199]  ? btrfs_delete_unused_bgs+0x35/0x610 [btrfs]
[ 2437.072466]  ? cleaner_kthread+0xc8/0x150 [btrfs]
[ 2437.077950]  btrfs_clean_one_deleted_snapshot+0xc1/0x110 [btrfs]
[ 2437.084879]  cleaner_kthread+0x121/0x150 [btrfs]
[ 2437.090277]  ? btree_submit_bio_start+0x10/0x10 [btrfs]
[ 2437.096339]  kthread+0x12b/0x150
[ 2437.100190]  ? __kthread_cancel_work+0x40/0x40
[ 2437.105407]  ret_from_fork+0x1f/0x40

[ 2437.109652] btrfs-transacti D    0 42618      2 0x80004000
[ 2437.116048] Call Trace:
[ 2437.119052]  __schedule+0x2e9/0x730
[ 2437.123224]  schedule+0x36/0xc0
[ 2437.127046]  wait_current_trans+0xd4/0x110 [btrfs]
[ 2437.132671]  ? finish_wait+0x80/0x80
[ 2437.136972]  start_transaction+0x315/0x500 [btrfs]
[ 2437.142655]  transaction_kthread+0xa9/0x190 [btrfs]
[ 2437.148424]  ? btrfs_cleanup_transaction+0x610/0x610 [btrfs]
[ 2437.155048]  kthread+0x12b/0x150
[ 2437.158979]  ? __kthread_cancel_work+0x40/0x40
[ 2437.164279]  ret_from_fork+0x1f/0x40
[ 2437.168610] umount          D    0 42653  42649 0x00004000
[ 2437.175085] Call Trace:
[ 2437.178179]  __schedule+0x2e9/0x730
[ 2437.182444]  ? wait_for_completion+0x116/0x1c0
[ 2437.187768]  schedule+0x36/0xc0
[ 2437.191640]  schedule_timeout+0x222/0x350
[ 2437.196520]  ? wait_for_completion+0x116/0x1c0
[ 2437.201861]  wait_for_completion+0x14e/0x1c0
[ 2437.207017]  ? wake_up_q+0x70/0x70
[ 2437.211237]  __synchronize_srcu.part.20+0x94/0xc0
[ 2437.216912]  ? __bpf_trace_rcu_utilization+0x10/0x10
[ 2437.222847]  btrfs_drop_and_free_fs_root+0x8e/0xf0 [btrfs]
[ 2437.229393]  switch_commit_roots+0x18d/0x1d0 [btrfs]
[ 2437.235361]  btrfs_commit_transaction+0x615/0xa80 [btrfs]
[ 2437.241794]  ? finish_wait+0x80/0x80
[ 2437.246207]  sync_filesystem+0x71/0x90
[ 2437.250837]  generic_shutdown_super+0x22/0x110
[ 2437.256209]  kill_anon_super+0x14/0x30
[ 2437.260846]  btrfs_kill_super+0x12/0xa0 [btrfs]
[ 2437.266304]  deactivate_locked_super+0x34/0x70
[ 2437.271685]  cleanup_mnt+0xb8/0x140
[ 2437.276012]  task_work_run+0xa3/0xe0
[ 2437.280352]  exit_to_usermode_loop+0x103/0x120
[ 2437.285728]  do_syscall_64+0x198/0x1a0
[ 2437.290320]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2437.296376] RIP: 0033:0x7f6d5b088ba7
[ 2437.300782] Code: Bad RIP value.
[ 2437.304780] RSP: 002b:00007ffdc69e0b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 2437.313649] RAX: 0000000000000000 RBX: 000055d46fc65060 RCX: 00007f6d5b088ba7
[ 2437.322070] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055d46fc6bb10
[ 2437.330478] RBP: 000055d46fc6bb10 R08: 0000000000000000 R09: 000000000000000d
[ 2437.338864] R10: 00007ffdc69e0560 R11: 0000000000000246 R12: 00007f6d5be32ee4
[ 2437.347244] R13: 0000000000000000 R14: 000055d46fc652d0 R15: 00000000ffffffff


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/10


