Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75BB547262
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiFKGfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 02:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFKGfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 02:35:53 -0400
Received: from out20-182.mail.aliyun.com (out20-182.mail.aliyun.com [115.124.20.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286566C82
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 23:35:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04444366|-1;BR=01201311R211S21rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0127715-0.0012258-0.986003;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.O29-MB2_1654929342;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.O29-MB2_1654929342)
          by smtp.aliyun-inc.com;
          Sat, 11 Jun 2022 14:35:43 +0800
Date:   Sat, 11 Jun 2022 14:35:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: fstests btrfs/057 trigger a deadlock on 5.4.187
In-Reply-To: <20220611142634.3F3C.409509F4@e16-tech.com>
References: <20220610172202.E0EB.409509F4@e16-tech.com> <20220611142634.3F3C.409509F4@e16-tech.com>
Message-Id: <20220611143547.3F40.409509F4@e16-tech.com>
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


> this dead-lock is triggered by fstests btrfs/057 again on the lastest 5.4(5.4.197).
> 
> Frequency: about 1/100.
> 
> The Call Trace on 5.4.197
> 
> [  704.619697] sysrq: Show Blocked State
> [  704.624312]   task                        PC stack   pid father
> [  704.632499] btrfs-cleaner   D    0 33205      2 0x80004000
> [  704.639055] Call Trace:
> [  704.642239]  __schedule+0x284/0x6d0
> [  704.646595]  schedule+0x2f/0xa0
> [  704.650669]  wait_current_trans+0xb3/0xf0 [btrfs]
> [  704.656407]  ? finish_wait+0x80/0x80
> [  704.660916]  start_transaction+0x41c/0x4f0 [btrfs]
> [  704.666767]  btrfs_drop_snapshot+0x548/0x840 [btrfs]
> [  704.672778]  ? btrfs_run_defrag_inodes+0x79/0x380 [btrfs]
> [  704.679247]  ? down_write+0xe/0x40
> [  704.683524]  ? btrfs_delete_unused_bgs+0x35/0x5b0 [btrfs]
> [  704.690065]  ? btree_submit_bio_start+0x10/0x10 [btrfs]
> [  704.696366]  btrfs_clean_one_deleted_snapshot+0xba/0x110 [btrfs]
> [  704.703513]  cleaner_kthread+0xfa/0x120 [btrfs]
> [  704.709054]  kthread+0x112/0x130
> [  704.713104]  ? __kthread_cancel_work+0x40/0x40
> [  704.718511]  ret_from_fork+0x1f/0x40
> 
> [  704.722978] btrfs-transacti D    0 33206      2 0x80004000
> [  704.729585] Call Trace:
> [  704.732809]  __schedule+0x284/0x6d0
> [  704.737156]  schedule+0x2f/0xa0
> [  704.741123]  wait_current_trans+0xb3/0xf0 [btrfs]
> [  704.746823]  ? finish_wait+0x80/0x80
> [  704.751270]  start_transaction+0x315/0x4f0 [btrfs]
> [  704.757099]  transaction_kthread+0xa2/0x180 [btrfs]
> [  704.763001]  ? btrfs_cleanup_transaction+0x590/0x590 [btrfs]
> [  704.769776]  kthread+0x112/0x130
> [  704.773811]  ? __kthread_cancel_work+0x40/0x40
> [  704.779218]  ret_from_fork+0x1f/0x40
> 
> [  704.783650] umount          D    0 33243  33239 0x00004000
> [  704.790253] Call Trace:
> [  704.793423]  __schedule+0x284/0x6d0
> [  704.797788]  schedule+0x2f/0xa0
> [  704.801733]  schedule_timeout+0x20d/0x340
> [  704.806634]  wait_for_completion+0x11f/0x190
> [  704.811866]  ? wake_up_q+0x70/0x70
> [  704.816099]  __synchronize_srcu.part.20+0x81/0xb0
> [  704.821784]  ? __bpf_trace_rcu_utilization+0x10/0x10
> [  704.827787]  btrfs_drop_and_free_fs_root+0x87/0xe0 [btrfs]
> [  704.834350]  switch_commit_roots+0x186/0x1c0 [btrfs]
> [  704.840373]  btrfs_commit_transaction+0x5da/0xa20 [btrfs]
> [  704.846842]  ? finish_wait+0x80/0x80
> [  704.851265]  sync_filesystem+0x71/0x90
> [  704.855907]  generic_shutdown_super+0x22/0x100
> [  704.861342]  kill_anon_super+0x14/0x30
> [  704.866001]  btrfs_kill_super+0x12/0xa0 [btrfs]
> [  704.871487]  deactivate_locked_super+0x34/0x70
> [  704.876890]  cleanup_mnt+0xb8/0x140
> [  704.881190]  task_work_run+0x8a/0xb0
> [  704.885586]  exit_to_usermode_loop+0x103/0x120
> [  704.890981]  do_syscall_64+0x198/0x1a0
> [  704.895604]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  704.901698] RIP: 0033:0x7fc630348ba7
> [  704.906098] Code: Bad RIP value.
> [  704.910097] RSP: 002b:00007ffd612e8a18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [  704.918967] RAX: 0000000000000000 RBX: 0000555b85889060 RCX: 00007fc630348ba7
> [  704.927386] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000555b8588fb10
> [  704.935800] RBP: 0000555b8588fb10 R08: 0000000000000000 R09: 000000000000000d
> [  704.944185] R10: 00007ffd612e84a0 R11: 0000000000000246 R12: 00007fc6310f2ee4
> [  704.952559] R13: 0000000000000000 R14: 0000555b858892d0 R15: 00000000ffffffff

In addition to the 3 state D theads,
another thread(PID: 1560) is 100% busy

this is the call trace reported by 'sysrq l'

[ 1269.337878] CPU: 31 PID: 1560 Comm: kworker/31:2 Not tainted 5.4.197-2.el7.x86_64 #1
[ 1269.337878] Hardware name: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.14.0 01/25/2022
[ 1269.337879] Workqueue: rcu_gp process_srcu
[ 1269.337879] RIP: 0010:delay_tsc+0x27/0x60
[ 1269.337880] Code: 00 00 00 0f 1f 44 00 00 65 44 8b 0d a3 c3 64 54 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 11 f3 90 65 8b 35 89 c3 64 54 <41> 39 f1 75 1b 41 89 f1 0f 01 f9 66 90 48 c1 e2 20 48 09 d0 48 89
[ 1269.337880] RSP: 0018:ffffc3e30e1bbde0 EFLAGS: 00000283
[ 1269.337880] RAX: 000007443487c36f RBX: 00000000000042bc RCX: 000000000000101f
[ 1269.337881] RDX: 00000000000032a8 RSI: 000000000000001f RDI: 00000000000032c5
[ 1269.337881] RBP: 0000000000000000 R08: 00000744348790c7 R09: 000000000000001f
[ 1269.337881] R10: 8080808080808080 R11: ffffffffaca52ff8 R12: 0000000000000000
[ 1269.337882] R13: 00000000000042bf R14: 00000000ffffffff R15: ffffa01a770b0498
[ 1269.337882] FS:  0000000000000000(0000) GS:ffffa05aff7c0000(0000) knlGS:0000000000000000
[ 1269.337882] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1269.337882] CR2: 0000555b8589e838 CR3: 0000007f7006e002 CR4: 00000000003606e0
[ 1269.337883] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1269.337883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1269.337883] Call Trace:
[ 1269.337883]  try_check_zero+0xc2/0xf0
[ 1269.337883]  process_srcu+0x15e/0x4a0
[ 1269.337884]  ? __queue_work+0x13d/0x3e0
[ 1269.337884]  process_one_work+0x1a7/0x360
[ 1269.337884]  worker_thread+0x30/0x390
[ 1269.337884]  ? create_worker+0x1a0/0x1a0
[ 1269.337884]  kthread+0x112/0x130
[ 1269.337885]  ? __kthread_cancel_work+0x40/0x40
[ 1269.337885]  ret_from_fork+0x1f/0x40


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/11


