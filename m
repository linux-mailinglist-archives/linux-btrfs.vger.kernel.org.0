Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54B6A25B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 01:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBYAgK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 19:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBYAgJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 19:36:09 -0500
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA467994
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 16:36:02 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00480927-2.97488e-05-0.995161;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.RW4NSzp_1677285359;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RW4NSzp_1677285359)
          by smtp.aliyun-inc.com;
          Sat, 25 Feb 2023 08:36:00 +0800
Date:   Sat, 25 Feb 2023 08:36:00 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: issue discovered by hung_task_timeout_secs?
Message-Id: <20230225083600.126A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

The following setting maybe useful to diag the data flush problem inside btrfs.

# we need SSD for this test case
vm.dirty_expire_centisecs = 200
vm.dirty_writeback_centisecs = 100
kernel.hung_task_timeout_secs=4
kernel.hung_task_all_cpu_backtrace=1

In fact, only few cases of high load was reported.

but some case of btrfs-cleaner when low load is reported too.
it maybe an issue inside btrfs, or expected behavor?

[   55.195673] INFO: task btrfs-transacti:1550 blocked for more than 4 seconds.
[   55.202770]       Not tainted 6.1.13-5.el7.x86_64 #1
[   55.207770] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   55.215645] task:btrfs-transacti state:D stack:0     pid:1550  ppid:2      flags:0x00004000
[   55.224014] Call Trace:
[   55.226475]  <TASK>
[   55.228589]  __schedule+0x2cb/0x880
[   55.232100]  schedule+0x50/0xc0
[   55.235254]  btrfs_commit_transaction+0x982/0xbc0 [btrfs]
[   55.240723]  ? add_wait_queue+0xa0/0xa0
[   55.244578]  transaction_kthread+0x157/0x1b0 [btrfs]
[   55.249588]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[   55.255298]  kthread+0xe3/0x110
[   55.258454]  ? kthread_complete_and_exit+0x20/0x20
[   55.263263]  ret_from_fork+0x1f/0x30
[   55.266861]  </TASK>
[   55.269069] NMI backtrace for cpu 66
[   55.272654] CPU: 66 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[   55.280054] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   55.287631] Call Trace:
[   55.290083]  <TASK>
[   55.292189]  dump_stack_lvl+0x33/0x46
[   55.295863]  nmi_cpu_backtrace.cold.8+0x30/0x70
[   55.300403]  ? lapic_can_unplug_cpu+0x80/0x80
[   55.304771]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[   55.309832]  watchdog+0x43b/0x440
[   55.313160]  ? proc_dohung_task_timeout_secs+0x30/0x30
[   55.318308]  kthread+0xe3/0x110
[   55.321455]  ? kthread_complete_and_exit+0x20/0x20
[   55.326254]  ret_from_fork+0x1f/0x30
[   55.329835]  </TASK>
[   55.332033] Sending NMI from CPU 66 to CPUs 0-65,67-71:
[   55.337279] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[   55.337283] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[   55.337312] NMI backtrace for cpu 54 skipped: idling at intel_idle+0x8e/0xb0
[   55.337340] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[   55.337359] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[   55.337367] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[   55.337383] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[   55.337395] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[   55.337408] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[   55.337421] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[   55.337434] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[   55.337446] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[   55.337454] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0
[   55.337466] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[   55.337478] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[   55.337491] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[   55.337502] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[   55.337510] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[   55.337521] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[   55.337529] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[   55.337536] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[   55.337549] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[   55.337560] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[   55.337569] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[   55.337581] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[   55.337593] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[   55.337604] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[   55.337612] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[   55.337619] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x8e/0xb0
[   55.337631] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[   55.337643] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[   55.337655] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[   55.337664] NMI backtrace for cpu 65 skipped: idling at intel_idle+0x8e/0xb0
[   55.337676] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[   55.337684] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[   55.337692] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[   55.337699] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[   55.337712] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[   55.337723] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0
[   55.337731] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[   55.337740] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[   55.337752] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[   55.337763] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[   55.337771] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[   55.337783] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[   55.337791] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[   55.337800] NMI backtrace for cpu 25
[   55.337804] CPU: 25 PID: 1549 Comm: btrfs-cleaner Not tainted 6.1.13-5.el7.x86_64 #1
[   55.337809] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   55.337811] RIP: 0010:btrfs_free_path+0x13/0x30 [btrfs]
[   55.337916] Code: cc 41 bf f4 ff ff ff eb e6 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 85 ff 74 19 53 48 89 fb e8 8d fb ff ff <48> 8b 3d 9e 0f 17 00 48 89 de 5b e9 fd 5f 19 f7 c3 cc cc cc cc 0f
[   55.337920] RSP: 0000:ffffaa169c5ef9b0 EFLAGS: 00000246
[   55.337923] RAX: 0000000000000000 RBX: ffff8a8430a6dc40 RCX: 0000000000000000
[   55.337926] RDX: 0000000080000000 RSI: 000000000000068e RDI: 0000000000000000
[   55.337928] RBP: 0000000000000000 R08: ffff8a84369da0c0 R09: 0000000000000000
[   55.337929] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a8430a6dc40
[   55.337931] R13: ffff8a251056e000 R14: 0000000000000001 R15: ffff8a84c852a2c0
[   55.337933] FS:  0000000000000000(0000) GS:ffff8ae27f700000(0000) knlGS:0000000000000000
[   55.337936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.337938] CR2: 00007f7c900088f8 CR3: 000000a269810006 CR4: 00000000007706e0
[   55.337940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.337941] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.337943] PKRU: 55555554
[   55.337944] Call Trace:
[   55.337946]  <TASK>
[   55.337948]  find_parent_nodes+0x80b/0x1280 [btrfs]
[   55.338071]  ? prelim_release+0x13/0x80 [btrfs]
[   55.338189]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[   55.338303]  btrfs_qgroup_trace_extent_post+0x81/0xa0 [btrfs]
[   55.338418]  btrfs_qgroup_trace_leaf_items+0x109/0x160 [btrfs]
[   55.338525]  btrfs_qgroup_trace_subtree+0x2b3/0x3f0 [btrfs]
[   55.338590]  do_walk_down+0x67d/0x760 [btrfs]
[   55.338638]  walk_down_tree+0xcf/0x110 [btrfs]
[   55.338683]  btrfs_drop_snapshot+0x1d4/0x770 [btrfs]
[   55.338728]  ? __schedule+0x2d3/0x880
[   55.338733]  ? cleaner_kthread+0x111/0x150 [btrfs]
[   55.338780]  btrfs_clean_one_deleted_snapshot+0xc1/0x120 [btrfs]
[   55.338828]  cleaner_kthread+0xdf/0x150 [btrfs]
[   55.338875]  ? btree_invalidate_folio+0x40/0x40 [btrfs]
[   55.338921]  kthread+0xe3/0x110
[   55.338925]  ? kthread_complete_and_exit+0x20/0x20
[   55.338927]  ret_from_fork+0x1f/0x30
[   55.338933]  </TASK>
[   55.338934] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.654 msecs
[   55.338934] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[   55.338943] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[   55.338954] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[   55.338962] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[   55.338967] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.687 msecs
[   55.338968] NMI backtrace for cpu 0
[   55.338972] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.13-5.el7.x86_64 #1
[   55.338978] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   55.338980] RIP: 0010:calc_load_nohz_stop+0x13/0x60
[   55.338992] Code: 0f 1f 80 00 00 00 00 0f 1f 44 00 00 e9 f6 6a ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 48 8b 05 2c 98 25 03 48 8b 0d 6d 7b aa 01 <48> c7 c2 40 0b 03 00 65 48 03 15 7e 9b 8b 47 48 89 82 c8 0b 00 00
[   55.338997] RSP: 0018:ffffffffba203e48 EFLAGS: 00000082
[   55.339002] RAX: 00000000fffc2f7a RBX: ffff8a8280822a00 RCX: 00000000fffc2ccd
[   55.339005] RDX: 0000000c03a19bc5 RSI: 0000000c03a19bc5 RDI: 0000000c03a19bc5
[   55.339008] RBP: 0000000c03a19bc5 R08: 0000000000000002 R09: 00000000000303c0
[   55.339011] R10: 00000072d0198100 R11: ffff8a828082f884 R12: 0000000000000001
[   55.339014] R13: 0000000c03a19bc5 R14: ffffffffbb13c180 R15: 0000000000000003
[   55.339016] FS:  0000000000000000(0000) GS:ffff8a8280800000(0000) knlGS:0000000000000000
[   55.339021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.339024] CR2: 00007f7c88010938 CR3: 000000a269810005 CR4: 00000000007706f0
[   55.339027] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   55.339029] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   55.339031] PKRU: 55555554
[   55.339033] Call Trace:
[   55.339035]  <TASK>
[   55.339037]  tick_nohz_restart_sched_tick+0x1f/0xa0
[   55.339047]  tick_nohz_idle_exit+0x9a/0xf0
[   55.339055]  do_idle+0x166/0x290
[   55.339064]  cpu_startup_entry+0x19/0x20
[   55.339069]  rest_init+0xca/0xd0
[   55.339074]  arch_call_rest_init+0xa/0x14
[   55.339086]  start_kernel+0x7a8/0x7d3
[   55.339095]  secondary_startup_64_no_verify+0xe5/0xeb
[   55.339106]  </TASK>
[   55.339108] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[   55.339108] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.828 msecs
[   55.339122] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[   55.339134] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[   55.339142] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[   55.339150] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[   55.339157] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[   55.339165] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[   55.339173] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[   55.339174] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.850 msecs
[   55.339185] NMI backtrace for cpu 68 skipped: idling at intel_idle+0x8e/0xb0
[   55.339192] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[   55.339204] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[   55.339204] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.853 msecs
[   55.339211] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[   55.339211] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.859 msecs
[   55.339218] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[   55.339218] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.866 msecs
[   55.339225] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[   55.339225] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.873 msecs
[   55.339233] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.881 msecs
[   55.339233] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0
[   55.339240] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x8e/0xb0
[   55.339240] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.889 msecs
[   55.339247] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0
[   55.339255] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[   55.339266] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0


[   59.355529] INFO: task in:imjournal:2947 blocked for more than 4 seconds.
[   59.363019]       Not tainted 6.1.13-5.el7.x86_64 #1
[   59.368635] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   59.377110] task:in:imjournal    state:D stack:0     pid:2947  ppid:1      flags:0x00000000
[   59.385738] Call Trace:
[   59.388376]  <TASK>
[   59.390681]  __schedule+0x2cb/0x880
[   59.394355]  schedule+0x50/0xc0
[   59.397672]  wait_current_trans+0xd6/0x130 [btrfs]
[   59.402703]  ? add_wait_queue+0xa0/0xa0
[   59.406724]  start_transaction+0x3b8/0x5e0 [btrfs]
[   59.411734]  btrfs_create_common+0xa6/0x100 [btrfs]
[   59.416820]  path_openat+0xfa0/0x11a0
[   59.420678]  do_filp_open+0xb4/0x120
[   59.424439]  ? __check_object_size+0x219/0x230
[   59.429072]  do_sys_openat2+0x24a/0x310
[   59.433096]  do_sys_open+0x4b/0x80
[   59.436682]  do_syscall_64+0x58/0x80
[   59.440443]  ? syscall_exit_to_user_mode+0x12/0x30
[   59.445418]  ? do_syscall_64+0x67/0x80
[   59.449362]  ? do_syscall_64+0x67/0x80
[   59.453285]  ? syscall_exit_to_user_mode+0x12/0x30
[   59.458259]  ? do_syscall_64+0x67/0x80
[   59.462176]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   59.467397] RIP: 0033:0x7f7e614ef91d
[   59.471139] RSP: 002b:00007f7e5b7fcc30 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
[   59.478879] RAX: ffffffffffffffda RBX: 00007f7e60403d87 RCX: 00007f7e614ef91d
[   59.486195] RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 00007f7e5b7fccd0
[   59.493515] RBP: 00007f7e5b7fcc90 R08: 00007f7e60403d8c R09: 0000000000000240
[   59.500846] R10: 0000000000000024 R11: 0000000000000293 R12: 00007f7e4c01e4b0
[   59.508170] R13: 0000000000000004 R14: 00007f7e4c013ba0 R15: 00007f7e4c013690
[   59.515487]  </TASK>
[   59.517877] NMI backtrace for cpu 0
[   59.522195] CPU: 0 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[   59.530280] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   59.538622] Call Trace:
[   59.541471]  <TASK>
[   59.543885]  dump_stack_lvl+0x33/0x46
[   59.547802]  nmi_cpu_backtrace.cold.8+0x30/0x70
[   59.552612]  ? lapic_can_unplug_cpu+0x80/0x80
[   59.557249]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[   59.562589]  watchdog+0x43b/0x440
[   59.566193]  ? proc_dohung_task_timeout_secs+0x30/0x30
[   59.571594]  kthread+0xe3/0x110
[   59.574989]  ? kthread_complete_and_exit+0x20/0x20
[   59.580027]  ret_from_fork+0x1f/0x30
[   59.583865]  </TASK>
[   59.586318] Sending NMI from CPU 0 to CPUs 1-71:
[   59.591187] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[   59.591191] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[   59.591199] NMI backtrace for cpu 68 skipped: idling at intel_idle+0x8e/0xb0
[   59.591221] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[   59.591229] NMI backtrace for cpu 65
[   59.591232] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
[   59.591234] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   59.591251] RIP: 0010:btrfs_comp_cpu_keys+0x3f/0x50 [btrfs]
[   59.591300] Code: ff ff 72 26 b8 01 00 00 00 0f b6 4e 08 38 4f 08 77 18 b8 ff ff ff ff 72 11 b8 01 00 00 00 48 8b 4e 09 48 39 4f 09 77 02 19 c0 <c3> cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[   59.591301] RSP: 0018:ffffaa169c5f7b10 EFLAGS: 00000206
[   59.591303] RAX: 0000000000000001 RBX: 000000000000001e RCX: ffff8a840ec6f890
[   59.591304] RDX: 00000372db98c000 RSI: ffffaa169c5f7c5e RDI: ffff8a8479adb353
[   59.591305] RBP: 0000000000000020 R08: ffff8a840ec6f850 R09: 0000123804da8000
[   59.591306] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000001d
[   59.591306] R13: ffff8a8423cfb200 R14: 0000000000000019 R15: ffffaa169c5f7c5e
[   59.591307] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
[   59.591309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.591310] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
[   59.591310] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.591311] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   59.591312] PKRU: 55555554
[   59.591313] Call Trace:
[   59.591314]  <TASK>
[   59.591315]  btrfs_generic_bin_search+0xf1/0x160 [btrfs]
[   59.591348]  btrfs_search_slot+0xa38/0xbc0 [btrfs]
[   59.591380]  ? kmem_cache_alloc+0x16b/0x530
[   59.591386]  find_parent_nodes+0xde/0x1280 [btrfs]
[   59.591443]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[   59.591497]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[   59.591549]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
[   59.591602]  btrfs_commit_transaction+0x2eb/0xbc0 [btrfs]
[   59.591639]  ? add_wait_queue+0xa0/0xa0
[   59.591644]  transaction_kthread+0x157/0x1b0 [btrfs]
[   59.591680]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[   59.591715]  kthread+0xe3/0x110
[   59.591718]  ? kthread_complete_and_exit+0x20/0x20
[   59.591720]  ret_from_fork+0x1f/0x30
[   59.591724]  </TASK>
[   59.591726] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0
[   59.591739] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[   59.591752] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[   59.591764] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[   59.591776] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[   59.591788] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[   59.591800] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[   59.591805] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[   59.591817] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[   59.591829] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[   59.591840] NMI backtrace for cpu 66
[   59.591842] CPU: 66 PID: 527 Comm: kworker/66:1 Not tainted 6.1.13-5.el7.x86_64 #1
[   59.591844] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[   59.591845] Workqueue: events drm_fb_helper_damage_work
[   59.591849] RIP: 0010:memcpy_toio+0x6e/0xb0
[   59.591853] Code: 5c c3 cc cc cc cc 48 85 db 74 f2 40 f6 c5 01 75 45 48 83 fb 01 76 06 40 f6 c5 02 75 25 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 5b 5d 41 5c c3 cc cc
[   59.591855] RSP: 0018:ffffaa169a35bb88 EFLAGS: 00010206
[   59.591856] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0
[   59.591857] RDX: 0000000000000000 RSI: ffffaa16b12e7040 RDI: ffffaa16b22e6040
[   59.591858] RBP: ffffaa16b22e6000 R08: ffffaa169a35bc30 R09: ffffaa169a35bc30
[   59.591859] R10: ffffaa169a35bc20 R11: 0000000000000001 R12: ffffaa16b12e7000
[   59.591859] R13: 00000000000002e6 R14: ffffaa16b12e7000 R15: 0000000000001000
[   59.591861] FS:  0000000000000000(0000) GS:ffff8a8281040000(0000) knlGS:0000000000000000
[   59.591862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.591863] CR2: 00007f100260c160 CR3: 000000a269810003 CR4: 00000000007706e0
[   59.591864] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   59.591865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   59.591866] PKRU: 55555554
[   59.591866] Call Trace:
[   59.591867]  <TASK>
[   59.591868]  drm_fb_memcpy+0x120/0x160
[   59.591876]  mgag200_primary_plane_helper_atomic_update+0xa8/0x300 [mgag200]
[   59.591884]  drm_atomic_helper_commit_planes+0xb7/0x240
[   59.591886]  drm_atomic_helper_commit_tail+0x26/0x60
[   59.591889]  mgag200_mode_config_helper_atomic_commit_tail+0x25/0x30 [mgag200]
[   59.591895]  commit_tail+0x91/0x130
[   59.591897]  drm_atomic_helper_commit+0x116/0x140
[   59.591898]  drm_atomic_commit+0x93/0xc0
[   59.591904]  ? drm_plane_get_damage_clips.cold.7+0x1c/0x1c
[   59.591909]  drm_atomic_helper_dirtyfb+0x225/0x2a0
[   59.591912]  drm_fb_helper_damage_work+0x1a4/0x390
[   59.591914]  process_one_work+0x1b0/0x390
[   59.591918]  worker_thread+0x3c/0x370
[   59.591919]  ? process_one_work+0x390/0x390
[   59.591921]  kthread+0xe3/0x110
[   59.591922]  ? kthread_complete_and_exit+0x20/0x20
[   59.591924]  ret_from_fork+0x1f/0x30
[   59.591927]  </TASK>
[   59.591928] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[   59.591940] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[   59.591952] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[   59.591960] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[   59.591972] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x8e/0xb0
[   59.591984] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[   59.591995] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[   59.592003] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0
[   59.592011] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[   59.592018] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[   59.592026] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[   59.592034] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[   59.592045] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[   59.592053] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[   59.592061] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[   59.592069] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[   59.592077] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[   59.592089] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[   59.592101] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[   59.592113] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[   59.592120] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[   59.592132] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[   59.592144] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[   59.592156] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[   59.592168] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[   59.592176] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[   59.592183] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[   59.592190] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[   59.592202] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[   59.592214] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[   59.592222] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[   59.592230] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[   59.592238] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[   59.592248] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[   59.592256] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[   59.592268] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[   59.592276] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[   59.592288] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[   59.592296] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[   59.592304] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[   59.592316] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[   59.592328] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[   59.592336] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[   59.592348] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x8e/0xb0
[   59.592355] NMI backtrace for cpu 54 skipped: idling at intel_idle+0x8e/0xb0
[   59.592363] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[   59.592370] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x8e/0xb0
[   59.592377] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0
[   59.592385] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[   59.592393] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[   59.592405] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[   59.592412] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[   59.592420] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[   59.592432] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0
[   59.592440] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0

[   99.930086] INFO: task btrfs-cleaner:1549 blocked for more than 4 seconds.
[   99.937276]       Not tainted 6.1.13-5.el7.x86_64 #1
[   99.942475] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   99.950549] task:btrfs-cleaner   state:D stack:0     pid:1549  ppid:2      flags:0x00004000
[   99.959006] Call Trace:
[   99.961563]  <TASK>
[   99.963773]  __schedule+0x2cb/0x880
[   99.967363]  schedule+0x50/0xc0
[   99.970602]  wait_current_trans+0xd6/0x130 [btrfs]
[   99.975544]  ? add_wait_queue+0xa0/0xa0
[   99.979486]  start_transaction+0x3b8/0x5e0 [btrfs]
[   99.984418]  ? cleaner_kthread+0x111/0x150 [btrfs]
[   99.989357]  btrfs_drop_snapshot+0xa1/0x770 [btrfs]
[   99.994385]  ? __schedule+0x2d3/0x880
[   99.998178]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  100.003127]  btrfs_clean_one_deleted_snapshot+0xc1/0x120 [btrfs]
[  100.009280]  cleaner_kthread+0xdf/0x150 [btrfs]
[  100.013978]  ? btree_invalidate_folio+0x40/0x40 [btrfs]
[  100.019369]  kthread+0xe3/0x110
[  100.022634]  ? kthread_complete_and_exit+0x20/0x20
[  100.027568]  ret_from_fork+0x1f/0x30
[  100.031267]  </TASK>
[  100.034935] NMI backtrace for cpu 54
[  100.039067] CPU: 54 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[  100.047014] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  100.055148] Call Trace:
[  100.057874]  <TASK>
[  100.060189]  dump_stack_lvl+0x33/0x46
[  100.064120]  nmi_cpu_backtrace.cold.8+0x30/0x70
[  100.068871]  ? lapic_can_unplug_cpu+0x80/0x80
[  100.073453]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[  100.078728]  watchdog+0x43b/0x440
[  100.082266]  ? proc_dohung_task_timeout_secs+0x30/0x30
[  100.087624]  kthread+0xe3/0x110
[  100.091006]  ? kthread_complete_and_exit+0x20/0x20
[  100.096027]  ret_from_fork+0x1f/0x30
[  100.099836]  </TASK>
[  100.102278] Sending NMI from CPU 54 to CPUs 0-53,55-71:
[  100.107782] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[  100.107786] NMI backtrace for cpu 65
[  100.107790] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
[  100.107793] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  100.107794] RIP: 0010:__radix_tree_lookup+0x55/0xb0
[  100.107818] Code: d3 e1 4c 89 c9 48 83 e9 01 48 39 ce 77 63 4d 89 d8 45 31 c9 48 89 c1 83 e1 03 48 83 f9 02 75 2e 48 83 e0 fd 49 89 f0 0f b6 08 <49> 89 c1 49 d3 e8 41 83 e0 3f 49 8d 40 04 4f 8d 44 c1 28 49 8b 44
[  100.107820] RSP: 0018:ffffaa169c5f7aa0 EFLAGS: 00000286
[  100.107823] RAX: ffff8a84d05e6460 RBX: 0000000000000040 RCX: 0000000000000000
[  100.107825] RDX: 0000000000000000 RSI: 0000000034c02a28 RDI: ffff8a251056ea38
[  100.107842] RBP: 0000034c02a28000 R08: 0000000034c02a28 R09: ffff8a84457a3478
[  100.107843] R10: 0000000000000000 R11: ffff8a251056ea40 R12: ffff8a840ec6f850
[  100.107845] R13: ffff8a84235da800 R14: 0000000000000085 R15: 0000000000000001
[  100.107846] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
[  100.107848] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.107849] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
[  100.107851] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  100.107852] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  100.107852] PKRU: 55555554
[  100.107854] Call Trace:
[  100.107855]  <TASK>
[  100.107858]  find_extent_buffer_nolock+0x2a/0x80 [btrfs]
[  100.107929]  find_extent_buffer+0xc/0x50 [btrfs]
[  100.107984]  read_block_for_search+0x13e/0x370 [btrfs]
[  100.108027]  btrfs_search_slot+0x37f/0xbc0 [btrfs]
[  100.108069]  ? kmem_cache_alloc+0x16b/0x530
[  100.108073]  find_parent_nodes+0xde/0x1280 [btrfs]
[  100.108139]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[  100.108201]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[  100.108262]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
[  100.108323]  ? commit_fs_roots+0x1bc/0x1f0 [btrfs]
[  100.108370]  btrfs_commit_transaction+0x2eb/0xbc0 [btrfs]
[  100.108416]  ? add_wait_queue+0xa0/0xa0
[  100.108421]  transaction_kthread+0x157/0x1b0 [btrfs]
[  100.108467]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[  100.108512]  kthread+0xe3/0x110
[  100.108515]  ? kthread_complete_and_exit+0x20/0x20
[  100.108517]  ret_from_fork+0x1f/0x30
[  100.108522]  </TASK>
[  100.108523] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[  100.108530] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[  100.108543] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0
[  100.108554] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[  100.108566] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[  100.108577] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[  100.108583] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[  100.108594] NMI backtrace for cpu 34
[  100.108595] CPU: 34 PID: 534 Comm: kworker/34:1 Not tainted 6.1.13-5.el7.x86_64 #1
[  100.108598] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  100.108599] Workqueue: events drm_fb_helper_damage_work
[  100.108601] RIP: 0010:memcpy_toio+0x6e/0xb0
[  100.108604] Code: 5c c3 cc cc cc cc 48 85 db 74 f2 40 f6 c5 01 75 45 48 83 fb 01 76 06 40 f6 c5 02 75 25 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 5b 5d 41 5c c3 cc cc
[  100.108606] RSP: 0018:ffffaa169a393b88 EFLAGS: 00010206
[  100.108608] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0
[  100.108609] RDX: 0000000000000000 RSI: ffffaa16b1184040 RDI: ffffaa16b2183040
[  100.108610] RBP: ffffaa16b2183000 R08: ffffaa169a393c30 R09: ffffaa169a393c30
[  100.108611] R10: ffffaa169a393c20 R11: 0000000000000001 R12: ffffaa16b1184000
[  100.108612] R13: 0000000000000183 R14: ffffaa16b1184000 R15: 0000000000001000
[  100.108613] FS:  0000000000000000(0000) GS:ffff8a8280c40000(0000) knlGS:0000000000000000
[  100.108614] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.108615] CR2: 00007fc44940c160 CR3: 000000a269810002 CR4: 00000000007706e0
[  100.108616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  100.108617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  100.108618] PKRU: 55555554
[  100.108619] Call Trace:
[  100.108619]  <TASK>
[  100.108620]  drm_fb_memcpy+0x120/0x160
[  100.108626]  mgag200_primary_plane_helper_atomic_update+0xa8/0x300 [mgag200]
[  100.108634]  drm_atomic_helper_commit_planes+0xb7/0x240
[  100.108636]  drm_atomic_helper_commit_tail+0x26/0x60
[  100.108638]  mgag200_mode_config_helper_atomic_commit_tail+0x25/0x30 [mgag200]
[  100.108644]  commit_tail+0x91/0x130
[  100.108646]  drm_atomic_helper_commit+0x116/0x140
[  100.108648]  drm_atomic_commit+0x93/0xc0
[  100.108652]  ? drm_plane_get_damage_clips.cold.7+0x1c/0x1c
[  100.108656]  drm_atomic_helper_dirtyfb+0x225/0x2a0
[  100.108659]  drm_fb_helper_damage_work+0x1a4/0x390
[  100.108660]  process_one_work+0x1b0/0x390
[  100.108663]  worker_thread+0x3c/0x370
[  100.108665]  ? process_one_work+0x390/0x390
[  100.108666]  kthread+0xe3/0x110
[  100.108667]  ? kthread_complete_and_exit+0x20/0x20
[  100.108669]  ret_from_fork+0x1f/0x30
[  100.108672]  </TASK>
[  100.108673] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[  100.108685] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[  100.108697] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[  100.108704] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[  100.108716] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[  100.108724] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[  100.108731] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[  100.108743] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[  100.108755] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[  100.108767] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[  100.108780] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[  100.108791] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[  100.108799] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[  100.108807] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[  100.108815] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[  100.108827] NMI backtrace for cpu 66 skipped: idling at intel_idle+0x8e/0xb0
[  100.108839] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[  100.108850] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[  100.108858] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[  100.108871] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[  100.108882] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[  100.108890] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[  100.108901] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[  100.108909] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[  100.108916] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[  100.108924] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[  100.108936] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0
[  100.108948] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[  100.108959] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[  100.108971] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[  100.108980] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[  100.108987] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[  100.108995] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[  100.109006] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[  100.109014] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[  100.109026] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[  100.109033] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[  100.109041] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[  100.109053] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[  100.109061] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[  100.109070] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[  100.109082] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[  100.109094] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[  100.109105] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0
[  100.109117] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[  100.109125] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x8e/0xb0
[  100.109136] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[  100.109144] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[  100.109156] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x8e/0xb0
[  100.109164] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[  100.109174] NMI backtrace for cpu 68 skipped: idling at intel_idle+0x8e/0xb0
[  100.109181] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x8e/0xb0
[  100.109188] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[  100.109196] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[  100.109203] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[  100.109210] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[  100.109218] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[  100.109225] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[  100.109233] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0
[  100.109244] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[  100.109252] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0

[  104.153931] INFO: task btrfs-cleaner:1549 blocked for more than 8 seconds.
[  104.161156]       Not tainted 6.1.13-5.el7.x86_64 #1
[  104.166460] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  104.174434] task:btrfs-cleaner   state:D stack:0     pid:1549  ppid:2      flags:0x00004000
[  104.182933] Call Trace:
[  104.185491]  <TASK>
[  104.187720]  __schedule+0x2cb/0x880
[  104.191322]  schedule+0x50/0xc0
[  104.194572]  wait_current_trans+0xd6/0x130 [btrfs]
[  104.199528]  ? add_wait_queue+0xa0/0xa0
[  104.203482]  start_transaction+0x3b8/0x5e0 [btrfs]
[  104.208432]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  104.213387]  btrfs_drop_snapshot+0xa1/0x770 [btrfs]
[  104.218434]  ? __schedule+0x2d3/0x880
[  104.222226]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  104.227176]  btrfs_clean_one_deleted_snapshot+0xc1/0x120 [btrfs]
[  104.233365]  cleaner_kthread+0xdf/0x150 [btrfs]
[  104.238079]  ? btree_invalidate_folio+0x40/0x40 [btrfs]
[  104.243485]  kthread+0xe3/0x110
[  104.246769]  ? kthread_complete_and_exit+0x20/0x20
[  104.251702]  ret_from_fork+0x1f/0x30
[  104.255429]  </TASK>


[  104.258749] INFO: task in:imjournal:2947 blocked for more than 4 seconds.
[  104.266196]       Not tainted 6.1.13-5.el7.x86_64 #1
[  104.271804] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  104.280053] task:in:imjournal    state:D stack:0     pid:2947  ppid:1      flags:0x00000000
[  104.288638] Call Trace:
[  104.291324]  <TASK>
[  104.293671]  __schedule+0x2cb/0x880
[  104.297405]  schedule+0x50/0xc0
[  104.300779]  wait_current_trans+0xd6/0x130 [btrfs]
[  104.305846]  ? add_wait_queue+0xa0/0xa0
[  104.309888]  start_transaction+0x3b8/0x5e0 [btrfs]
[  104.314972]  btrfs_create_common+0xa6/0x100 [btrfs]
[  104.320151]  path_openat+0xfa0/0x11a0
[  104.324116]  do_filp_open+0xb4/0x120
[  104.328014]  ? __check_object_size+0x219/0x230
[  104.332741]  do_sys_openat2+0x24a/0x310
[  104.336835]  do_sys_open+0x4b/0x80
[  104.340482]  do_syscall_64+0x58/0x80
[  104.344303]  ? handle_mm_fault+0xfb/0x2f0
[  104.348568]  ? do_user_addr_fault+0x1eb/0x6a0
[  104.353177]  ? exc_page_fault+0x64/0x140
[  104.357350]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  104.362657] RIP: 0033:0x7f7e614ef91d
[  104.366487] RSP: 002b:00007f7e5b7fcc30 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
[  104.374316] RAX: ffffffffffffffda RBX: 00007f7e60403d87 RCX: 00007f7e614ef91d
[  104.381729] RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 00007f7e5b7fccd0
[  104.389125] RBP: 00007f7e5b7fcc90 R08: 00007f7e60403d8c R09: 0000000000000240
[  104.396566] R10: 0000000000000024 R11: 0000000000000293 R12: 00007f7e4c00a9c0
[  104.403965] R13: 0000000000000004 R14: 00007f7e4c00eff0 R15: 00007f7e4c014fe0
[  104.411347]  </TASK>
[  104.413797] NMI backtrace for cpu 0
[  104.417532] CPU: 0 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[  104.425069] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  104.432907] Call Trace:
[  104.435617]  <TASK>
[  104.437977]  dump_stack_lvl+0x33/0x46
[  104.441940]  nmi_cpu_backtrace.cold.8+0x30/0x70
[  104.446760]  ? lapic_can_unplug_cpu+0x80/0x80
[  104.451388]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[  104.456695]  watchdog+0x43b/0x440
[  104.460279]  ? proc_dohung_task_timeout_secs+0x30/0x30
[  104.465670]  kthread+0xe3/0x110
[  104.469087]  ? kthread_complete_and_exit+0x20/0x20
[  104.474132]  ret_from_fork+0x1f/0x30
[  104.477972]  </TASK>
[  104.480433] Sending NMI from CPU 0 to CPUs 1-71:
[  104.485311] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[  104.485315] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[  104.485326] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[  104.485351] NMI backtrace for cpu 65
[  104.485352] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
[  104.485355] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  104.485356] RIP: 0010:__radix_tree_lookup+0x6d/0xb0
[  104.485378] Code: e1 03 48 83 f9 02 75 2e 48 83 e0 fd 49 89 f0 0f b6 08 49 89 c1 49 d3 e8 41 83 e0 3f 49 8d 40 04 4f 8d 44 c1 28 49 8b 44 c1 08 <48> 3d 02 04 00 00 74 98 84 c9 75 c6 48 85 d2 74 03 4c 89 0a 4d 85
[  104.485381] RSP: 0018:ffffaa169c5f7aa0 EFLAGS: 00000206
[  104.485384] RAX: ffff8a8430ca2482 RBX: 0000000000000040 RCX: 0000000000000018
[  104.485385] RDX: 0000000000000000 RSI: 00000000281f8890 RDI: ffff8a251056ea38
[  104.485386] RBP: 00000281f8890000 R08: ffff8a840dc725e8 R09: ffff8a840dc72480
[  104.485387] R10: 0000000000000000 R11: ffff8a251056ea40 R12: ffff8a840ec6f850
[  104.485388] R13: ffff8a84235da800 R14: 00000000000000e9 R15: 0000000000000001
[  104.485389] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
[  104.485391] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.485393] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
[  104.485394] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.485395] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  104.485396] PKRU: 55555554
[  104.485397] Call Trace:
[  104.485397]  <TASK>
[  104.485399]  find_extent_buffer_nolock+0x2a/0x80 [btrfs]
[  104.485460]  find_extent_buffer+0xc/0x50 [btrfs]
[  104.485506]  read_block_for_search+0x13e/0x370 [btrfs]
[  104.485539]  btrfs_search_slot+0x37f/0xbc0 [btrfs]
[  104.485570]  ? kmem_cache_alloc+0x16b/0x530
[  104.485574]  find_parent_nodes+0xde/0x1280 [btrfs]
[  104.485630]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[  104.485683]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[  104.485734]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
[  104.485786]  ? commit_fs_roots+0x1bc/0x1f0 [btrfs]
[  104.485823]  btrfs_commit_transaction+0x2eb/0xbc0 [btrfs]
[  104.485859]  ? add_wait_queue+0xa0/0xa0
[  104.485862]  transaction_kthread+0x157/0x1b0 [btrfs]
[  104.485898]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[  104.485933]  kthread+0xe3/0x110
[  104.485935]  ? kthread_complete_and_exit+0x20/0x20
[  104.485937]  ret_from_fork+0x1f/0x30
[  104.485941]  </TASK>
[  104.485942] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[  104.485954] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[  104.485967] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x8e/0xb0
[  104.485979] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[  104.485991] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[  104.486002] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[  104.486014] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[  104.486024] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[  104.486035] NMI backtrace for cpu 54
[  104.486037] CPU: 54 PID: 1987 Comm: kworker/54:2 Not tainted 6.1.13-5.el7.x86_64 #1
[  104.486039] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  104.486041] Workqueue: events drm_fb_helper_damage_work
[  104.486044] RIP: 0010:memcpy_toio+0x6e/0xb0
[  104.486047] Code: 5c c3 cc cc cc cc 48 85 db 74 f2 40 f6 c5 01 75 45 48 83 fb 01 76 06 40 f6 c5 02 75 25 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 5b 5d 41 5c c3 cc cc
[  104.486049] RSP: 0018:ffffaa169cf3fb88 EFLAGS: 00010206
[  104.486050] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0
[  104.486052] RDX: 0000000000000000 RSI: ffffaa16b11a3040 RDI: ffffaa16b21a2040
[  104.486053] RBP: ffffaa16b21a2000 R08: ffffaa169cf3fc30 R09: ffffaa169cf3fc30
[  104.486054] R10: ffffaa169cf3fc20 R11: 0000000000000001 R12: ffffaa16b11a3000
[  104.486056] R13: 00000000000001a2 R14: ffffaa16b11a3000 R15: 0000000000001000
[  104.486057] FS:  0000000000000000(0000) GS:ffff8a8280ec0000(0000) knlGS:0000000000000000
[  104.486058] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.486060] CR2: 00007fb59dc12804 CR3: 000000a269810004 CR4: 00000000007706e0
[  104.486061] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.486062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  104.486063] PKRU: 55555554
[  104.486063] Call Trace:
[  104.486064]  <TASK>
[  104.486065]  drm_fb_memcpy+0x120/0x160
[  104.486070]  mgag200_primary_plane_helper_atomic_update+0xa8/0x300 [mgag200]
[  104.486079]  drm_atomic_helper_commit_planes+0xb7/0x240
[  104.486081]  drm_atomic_helper_commit_tail+0x26/0x60
[  104.486083]  mgag200_mode_config_helper_atomic_commit_tail+0x25/0x30 [mgag200]
[  104.486090]  commit_tail+0x91/0x130
[  104.486092]  drm_atomic_helper_commit+0x116/0x140
[  104.486094]  drm_atomic_commit+0x93/0xc0
[  104.486097]  ? drm_plane_get_damage_clips.cold.7+0x1c/0x1c
[  104.486101]  drm_atomic_helper_dirtyfb+0x225/0x2a0
[  104.486104]  drm_fb_helper_damage_work+0x1a4/0x390
[  104.486106]  process_one_work+0x1b0/0x390
[  104.486110]  worker_thread+0x3c/0x370
[  104.486112]  ? process_one_work+0x390/0x390
[  104.486114]  kthread+0xe3/0x110
[  104.486115]  ? kthread_complete_and_exit+0x20/0x20
[  104.486116]  ret_from_fork+0x1f/0x30
[  104.486120]  </TASK>
[  104.486121] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x8e/0xb0
[  104.486129] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[  104.486141] NMI backtrace for cpu 68 skipped: idling at intel_idle+0x8e/0xb0
[  104.486149] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[  104.486160] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[  104.486172] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[  104.486184] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x8e/0xb0
[  104.486195] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[  104.486203] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[  104.486215] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0
[  104.486224] NMI backtrace for cpu 66 skipped: idling at intel_idle+0x8e/0xb0
[  104.486235] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[  104.486247] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[  104.486255] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[  104.486267] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[  104.486274] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[  104.486286] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0
[  104.486298] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[  104.486310] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0
[  104.486321] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[  104.486329] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[  104.486341] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[  104.486348] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[  104.486356] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[  104.486367] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[  104.486376] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[  104.486388] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[  104.486395] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[  104.486403] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[  104.486410] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[  104.486417] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[  104.486443] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[  104.486451] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0
[  104.486459] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[  104.486471] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[  104.486478] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[  104.486486] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[  104.486494] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[  104.486506] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[  104.486517] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[  104.486526] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[  104.486537] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[  104.486545] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[  104.486555] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[  104.486566] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[  104.486573] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[  104.486580] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[  104.486592] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[  104.486601] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[  104.486608] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[  104.486616] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[  104.486628] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[  104.486635] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[  104.486642] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[  104.486654] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[  104.486662] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[  104.486671] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[  104.486682] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0


[  108.505654] INFO: task kworker/u146:16:411 blocked for more than 4 seconds.
[  108.512899]       Not tainted 6.1.13-5.el7.x86_64 #1
[  108.518054] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  108.526076] task:kworker/u146:16 state:D stack:0     pid:411   ppid:2      flags:0x00004000
[  108.534518] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[  108.540851] Call Trace:
[  108.543390]  <TASK>
[  108.545592]  __schedule+0x2cb/0x880
[  108.549180]  schedule+0x50/0xc0
[  108.552422]  wait_current_trans+0xd6/0x130 [btrfs]
[  108.557342]  ? add_wait_queue+0xa0/0xa0
[  108.561279]  start_transaction+0x335/0x5e0 [btrfs]
[  108.566203]  btrfs_finish_ordered_io+0x385/0x800 [btrfs]
[  108.571655]  ? pick_next_task_fair+0xb0/0x410
[  108.576125]  ? put_prev_entity+0x22/0xe0
[  108.580153]  ? put_prev_task_fair+0x1b/0x30
[  108.584445]  btrfs_work_helper+0xbe/0x360 [btrfs]
[  108.589296]  process_one_work+0x1b0/0x390
[  108.593414]  worker_thread+0x3c/0x370
[  108.597193]  ? process_one_work+0x390/0x390
[  108.601492]  kthread+0xe3/0x110
[  108.604757]  ? kthread_complete_and_exit+0x20/0x20
[  108.609663]  ret_from_fork+0x1f/0x30
[  108.613365]  </TASK>


[  108.616599] INFO: task btrfs-cleaner:1549 blocked for more than 12 seconds.
[  108.624143]       Not tainted 6.1.13-5.el7.x86_64 #1
[  108.629546] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  108.637767] task:btrfs-cleaner   state:D stack:0     pid:1549  ppid:2      flags:0x00004000
[  108.646332] Call Trace:
[  108.649011]  <TASK>
[  108.651337]  __schedule+0x2cb/0x880
[  108.655056]  schedule+0x50/0xc0
[  108.658436]  wait_current_trans+0xd6/0x130 [btrfs]
[  108.663499]  ? add_wait_queue+0xa0/0xa0
[  108.667578]  start_transaction+0x3b8/0x5e0 [btrfs]
[  108.672641]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  108.677697]  btrfs_drop_snapshot+0xa1/0x770 [btrfs]
[  108.682837]  ? __schedule+0x2d3/0x880
[  108.686741]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  108.691818]  btrfs_clean_one_deleted_snapshot+0xc1/0x120 [btrfs]
[  108.698189]  cleaner_kthread+0xdf/0x150 [btrfs]
[  108.702953]  ? btree_invalidate_folio+0x40/0x40 [btrfs]
[  108.708458]  kthread+0xe3/0x110
[  108.711857]  ? kthread_complete_and_exit+0x20/0x20
[  108.716899]  ret_from_fork+0x1f/0x30
[  108.720743]  </TASK>

[  108.723192] INFO: task in:imjournal:2947 blocked for more than 8 seconds.
[  108.730238]       Not tainted 6.1.13-5.el7.x86_64 #1
[  108.735463] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  108.743561] task:in:imjournal    state:D stack:0     pid:2947  ppid:1      flags:0x00000000
[  108.752198] Call Trace:
[  108.754900]  <TASK>
[  108.757249]  __schedule+0x2cb/0x880
[  108.760989]  schedule+0x50/0xc0
[  108.764389]  wait_current_trans+0xd6/0x130 [btrfs]
[  108.769476]  ? add_wait_queue+0xa0/0xa0
[  108.773569]  start_transaction+0x3b8/0x5e0 [btrfs]
[  108.778649]  btrfs_create_common+0xa6/0x100 [btrfs]
[  108.783821]  path_openat+0xfa0/0x11a0
[  108.787744]  do_filp_open+0xb4/0x120
[  108.791568]  ? __check_object_size+0x219/0x230
[  108.796283]  do_sys_openat2+0x24a/0x310
[  108.800399]  do_sys_open+0x4b/0x80
[  108.804056]  do_syscall_64+0x58/0x80
[  108.807925]  ? handle_mm_fault+0xfb/0x2f0
[  108.812189]  ? do_user_addr_fault+0x1eb/0x6a0
[  108.816802]  ? exc_page_fault+0x64/0x140
[  108.820986]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  108.826293] RIP: 0033:0x7f7e614ef91d
[  108.830128] RSP: 002b:00007f7e5b7fcc30 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
[  108.837939] RAX: ffffffffffffffda RBX: 00007f7e60403d87 RCX: 00007f7e614ef91d
[  108.845326] RDX: 00000000000001b6 RSI: 0000000000000241 RDI: 00007f7e5b7fccd0
[  108.852727] RBP: 00007f7e5b7fcc90 R08: 00007f7e60403d8c R09: 0000000000000240
[  108.860111] R10: 0000000000000024 R11: 0000000000000293 R12: 00007f7e4c00a9c0
[  108.867494] R13: 0000000000000004 R14: 00007f7e4c00eff0 R15: 00007f7e4c014fe0
[  108.874889]  </TASK>
[  108.877330] NMI backtrace for cpu 68
[  108.881156] CPU: 68 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[  108.888753] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  108.896564] Call Trace:
[  108.899273]  <TASK>
[  108.901635]  dump_stack_lvl+0x33/0x46
[  108.905556]  nmi_cpu_backtrace.cold.8+0x30/0x70
[  108.910372]  ? lapic_can_unplug_cpu+0x80/0x80
[  108.915004]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[  108.920329]  watchdog+0x43b/0x440
[  108.923912]  ? proc_dohung_task_timeout_secs+0x30/0x30
[  108.929311]  kthread+0xe3/0x110
[  108.932715]  ? kthread_complete_and_exit+0x20/0x20
[  108.937784]  ret_from_fork+0x1f/0x30
[  108.941629]  </TASK>
[  108.944078] Sending NMI from CPU 68 to CPUs 0-67,69-71:
[  108.949577] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[  108.949581] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[  108.949589] NMI backtrace for cpu 0
[  108.949591] CPU: 0 PID: 1251 Comm: kworker/0:4 Not tainted 6.1.13-5.el7.x86_64 #1
[  108.949593] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  108.949594] Workqueue: events drm_fb_helper_damage_work
[  108.949612] RIP: 0010:memcpy_toio+0x6e/0xb0
[  108.949614] Code: 5c c3 cc cc cc cc 48 85 db 74 f2 40 f6 c5 01 75 45 48 83 fb 01 76 06 40 f6 c5 02 75 25 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 5b 5d 41 5c c3 cc cc
[  108.949616] RSP: 0018:ffffaa169c283b88 EFLAGS: 00010206
[  108.949618] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0
[  108.949619] RDX: 0000000000000000 RSI: ffffaa16b12ff040 RDI: ffffaa16b22fe040
[  108.949620] RBP: ffffaa16b22fe000 R08: ffffaa169c283c30 R09: ffffaa169c283c30
[  108.949621] R10: ffffaa169c283c20 R11: 0000000000000001 R12: ffffaa16b12ff000
[  108.949622] R13: 00000000000002fe R14: ffffaa16b12ff000 R15: 0000000000001000
[  108.949623] FS:  0000000000000000(0000) GS:ffff8a8280800000(0000) knlGS:0000000000000000
[  108.949640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.949641] CR2: 00007f753b25e000 CR3: 000000a269810006 CR4: 00000000007706f0
[  108.949643] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  108.949643] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  108.949644] PKRU: 55555554
[  108.949645] Call Trace:
[  108.949646]  <TASK>
[  108.949647]  drm_fb_memcpy+0x120/0x160
[  108.949651]  mgag200_primary_plane_helper_atomic_update+0xa8/0x300 [mgag200]
[  108.949660]  drm_atomic_helper_commit_planes+0xb7/0x240
[  108.949662]  drm_atomic_helper_commit_tail+0x26/0x60
[  108.949664]  mgag200_mode_config_helper_atomic_commit_tail+0x25/0x30 [mgag200]
[  108.949671]  commit_tail+0x91/0x130
[  108.949673]  drm_atomic_helper_commit+0x116/0x140
[  108.949675]  drm_atomic_commit+0x93/0xc0
[  108.949678]  ? drm_plane_get_damage_clips.cold.7+0x1c/0x1c
[  108.949681]  drm_atomic_helper_dirtyfb+0x225/0x2a0
[  108.949684]  drm_fb_helper_damage_work+0x1a4/0x390
[  108.949686]  process_one_work+0x1b0/0x390
[  108.949688]  worker_thread+0x3c/0x370
[  108.949690]  ? process_one_work+0x390/0x390
[  108.949692]  kthread+0xe3/0x110
[  108.949693]  ? kthread_complete_and_exit+0x20/0x20
[  108.949695]  ret_from_fork+0x1f/0x30
[  108.949698]  </TASK>
[  108.949699] NMI backtrace for cpu 65
[  108.949701] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
[  108.949703] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  108.949704] RIP: 0010:__radix_tree_lookup+0x6d/0xb0
[  108.949709] Code: e1 03 48 83 f9 02 75 2e 48 83 e0 fd 49 89 f0 0f b6 08 49 89 c1 49 d3 e8 41 83 e0 3f 49 8d 40 04 4f 8d 44 c1 28 49 8b 44 c1 08 <48> 3d 02 04 00 00 74 98 84 c9 75 c6 48 85 d2 74 03 4c 89 0a 4d 85
[  108.949711] RSP: 0018:ffffaa169c5f7ad8 EFLAGS: 00000202
[  108.949713] RAX: ffff8a840dc40492 RBX: 0000000000000040 RCX: 000000000000000c
[  108.949714] RDX: 0000000000000000 RSI: 0000000000001a95 RDI: ffff8a251056e078
[  108.949715] RBP: ffff8a251056e070 R08: ffff8a8430dcab88 R09: ffff8a8430dcab58
[  108.949715] R10: 0000000000000000 R11: ffff8a251056e080 R12: 0000000000001a95
[  108.949716] R13: 0000000000001a95 R14: 0000000000000000 R15: ffff8a84d3718cb8
[  108.949717] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
[  108.949719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.949720] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
[  108.949721] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  108.949721] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  108.949722] PKRU: 55555554
[  108.949723] Call Trace:
[  108.949724]  <TASK>
[  108.949725]  btrfs_lookup_fs_root+0x27/0xa0 [btrfs]
[  108.949776]  btrfs_get_root_ref+0x159/0x2e0 [btrfs]
[  108.949813]  resolve_indirect_refs+0x1d5/0x870 [btrfs]
[  108.949869]  ? prelim_ref_insert+0x6e/0x1e0 [btrfs]
[  108.949923]  find_parent_nodes+0x3e7/0x1280 [btrfs]
[  108.949977]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[  108.950028]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[  108.950080]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
[  108.950131]  ? commit_fs_roots+0x1bc/0x1f0 [btrfs]
[  108.950168]  btrfs_commit_transaction+0x2eb/0xbc0 [btrfs]
[  108.950204]  ? add_wait_queue+0xa0/0xa0
[  108.950207]  transaction_kthread+0x157/0x1b0 [btrfs]
[  108.950243]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[  108.950277]  kthread+0xe3/0x110
[  108.950280]  ? kthread_complete_and_exit+0x20/0x20
[  108.950281]  ret_from_fork+0x1f/0x30
[  108.950285]  </TASK>
[  108.950287] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[  108.950300] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[  108.950312] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[  108.950323] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[  108.950335] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[  108.950343] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[  108.950355] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x8e/0xb0
[  108.950367] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[  108.950380] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0
[  108.950392] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[  108.950399] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[  108.950411] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[  108.950423] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[  108.950434] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[  108.950446] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[  108.950457] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[  108.950469] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[  108.950482] NMI backtrace for cpu 66 skipped: idling at intel_idle+0x8e/0xb0
[  108.950493] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[  108.950502] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[  108.950515] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[  108.950523] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[  108.950535] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[  108.950543] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x8e/0xb0
[  108.950555] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[  108.950566] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[  108.950573] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[  108.950581] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[  108.950589] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[  108.950601] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[  108.950608] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[  108.950616] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[  108.950623] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[  108.950631] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[  108.950642] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[  108.950650] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[  108.950657] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[  108.950670] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[  108.950682] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[  108.950694] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[  108.950702] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0
[  108.950714] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[  108.950725] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[  108.950733] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[  108.950740] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[  108.950747] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[  108.950759] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[  108.950767] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[  108.950778] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[  108.950785] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[  108.950797] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[  108.950808] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[  108.950817] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[  108.950824] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[  108.950831] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[  108.950839] NMI backtrace for cpu 54 skipped: idling at intel_idle+0x8e/0xb0
[  108.950847] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[  108.950855] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[  108.950862] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[  108.950869] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[  108.950877] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0
[  108.950885] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0
[  108.950896] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[  108.950941] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[  108.950948] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[  108.950959] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x8e/0xb0
[  108.950969] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0


[  112.985589] INFO: task kworker/u146:16:411 blocked for more than 8 seconds.
[  112.992867]       Not tainted 6.1.13-5.el7.x86_64 #1
[  112.998123] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  113.006130] task:kworker/u146:16 state:D stack:0     pid:411   ppid:2      flags:0x00004000
[  113.014589] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[  113.020913] Call Trace:
[  113.023479]  <TASK>
[  113.025682]  __schedule+0x2cb/0x880
[  113.029295]  schedule+0x50/0xc0
[  113.032560]  wait_current_trans+0xd6/0x130 [btrfs]
[  113.037501]  ? add_wait_queue+0xa0/0xa0
[  113.041462]  start_transaction+0x335/0x5e0 [btrfs]
[  113.046410]  btrfs_finish_ordered_io+0x385/0x800 [btrfs]
[  113.051870]  ? pick_next_task_fair+0xb0/0x410
[  113.056359]  ? put_prev_entity+0x22/0xe0
[  113.060413]  ? put_prev_task_fair+0x1b/0x30
[  113.064732]  btrfs_work_helper+0xbe/0x360 [btrfs]
[  113.069620]  process_one_work+0x1b0/0x390
[  113.073769]  worker_thread+0x3c/0x370
[  113.077574]  ? process_one_work+0x390/0x390
[  113.081898]  kthread+0xe3/0x110
[  113.085182]  ? kthread_complete_and_exit+0x20/0x20
[  113.090116]  ret_from_fork+0x1f/0x30
[  113.093842]  </TASK>

[  113.097417] INFO: task btrfs-cleaner:1549 blocked for more than 17 seconds.
[  113.105009]       Not tainted 6.1.13-5.el7.x86_64 #1
[  113.110452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  113.118671] task:btrfs-cleaner   state:D stack:0     pid:1549  ppid:2      flags:0x00004000
[  113.127243] Call Trace:
[  113.129915]  <TASK>
[  113.132253]  __schedule+0x2cb/0x880
[  113.135988]  schedule+0x50/0xc0
[  113.139363]  wait_current_trans+0xd6/0x130 [btrfs]
[  113.144403]  ? add_wait_queue+0xa0/0xa0
[  113.148499]  start_transaction+0x3b8/0x5e0 [btrfs]
[  113.153556]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  113.158631]  btrfs_drop_snapshot+0xa1/0x770 [btrfs]
[  113.163791]  ? __schedule+0x2d3/0x880
[  113.167711]  ? cleaner_kthread+0x111/0x150 [btrfs]
[  113.172814]  btrfs_clean_one_deleted_snapshot+0xc1/0x120 [btrfs]
[  113.179189]  cleaner_kthread+0xdf/0x150 [btrfs]
[  113.184005]  ? btree_invalidate_folio+0x40/0x40 [btrfs]
[  113.189522]  kthread+0xe3/0x110
[  113.192930]  ? kthread_complete_and_exit+0x20/0x20
[  113.197986]  ret_from_fork+0x1f/0x30
[  113.201834]  </TASK>
[  113.204290] NMI backtrace for cpu 56
[  113.208121] CPU: 56 PID: 458 Comm: khungtaskd Not tainted 6.1.13-5.el7.x86_64 #1
[  113.215765] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  113.223591] Call Trace:
[  113.226310]  <TASK>
[  113.228729]  dump_stack_lvl+0x33/0x46
[  113.232644]  nmi_cpu_backtrace.cold.8+0x30/0x70
[  113.237541]  ? lapic_can_unplug_cpu+0x80/0x80
[  113.242153]  nmi_trigger_cpumask_backtrace+0xf4/0x100
[  113.247458]  watchdog+0x43b/0x440
[  113.251016]  ? proc_dohung_task_timeout_secs+0x30/0x30
[  113.256415]  kthread+0xe3/0x110
[  113.259806]  ? kthread_complete_and_exit+0x20/0x20
[  113.264851]  ret_from_fork+0x1f/0x30
[  113.268696]  </TASK>
[  113.271153] Sending NMI from CPU 56 to CPUs 0-55,57-71:
[  113.276644] NMI backtrace for cpu 20 skipped: idling at intel_idle+0x8e/0xb0
[  113.276648] NMI backtrace for cpu 65
[  113.276651] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
[  113.276653] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  113.276655] RIP: 0010:btrfs_comp_cpu_keys+0x12/0x50 [btrfs]
[  113.276746] Code: 47 38 a8 40 0f 85 33 ff ff ff 4c 89 75 00 31 db e9 6d ff ff ff 0f 1f 00 0f 1f 44 00 00 b8 01 00 00 00 48 8b 16 48 39 17 77 2d <b8> ff ff ff ff 72 26 b8 01 00 00 00 0f b6 4e 08 38 4f 08 77 18 b8
[  113.276747] RSP: 0018:ffffaa169c5f7b10 EFLAGS: 00000287
[  113.276750] RAX: 0000000000000001 RBX: 0000000000000077 RCX: 0000000000000000
[  113.276751] RDX: 0000038666aac000 RSI: ffffaa169c5f7c5e RDI: ffff8a85c3e23fbc
[  113.276752] RBP: 0000000000000079 R08: 0000000000001000 R09: 0000034c06710000
[  113.276753] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000076
[  113.276754] R13: ffff8a84133c6d00 R14: 0000000000000021 R15: ffffaa169c5f7c5e
[  113.276755] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
[  113.276757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.276758] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
[  113.276759] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  113.276760] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  113.276761] PKRU: 55555554
[  113.276762] Call Trace:
[  113.276763]  <TASK>
[  113.276764]  btrfs_generic_bin_search+0xf1/0x160 [btrfs]
[  113.276808]  btrfs_search_slot+0x639/0xbc0 [btrfs]
[  113.276850]  ? kmem_cache_alloc+0x16b/0x530
[  113.276857]  find_parent_nodes+0xde/0x1280 [btrfs]
[  113.276923]  ? ulist_reinit+0x10/0x30 [btrfs]
[  113.276986]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
[  113.277048]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[  113.277109]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
[  113.277169]  ? commit_fs_roots+0x1bc/0x1f0 [btrfs]
[  113.277216]  btrfs_commit_transaction+0x2eb/0xbc0 [btrfs]
[  113.277262]  ? add_wait_queue+0xa0/0xa0
[  113.277266]  transaction_kthread+0x157/0x1b0 [btrfs]
[  113.277312]  ? btrfs_cleanup_transaction+0x5b0/0x5b0 [btrfs]
[  113.277358]  kthread+0xe3/0x110
[  113.277360]  ? kthread_complete_and_exit+0x20/0x20
[  113.277362]  ret_from_fork+0x1f/0x30
[  113.277367]  </TASK>
[  113.277368] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x8e/0xb0
[  113.277380] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x8e/0xb0
[  113.277394] NMI backtrace for cpu 9 skipped: idling at intel_idle+0x8e/0xb0
[  113.277407] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x8e/0xb0
[  113.277420] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x8e/0xb0
[  113.277432] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x8e/0xb0
[  113.277443] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x8e/0xb0
[  113.277455] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x8e/0xb0
[  113.277467] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x8e/0xb0
[  113.277479] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x8e/0xb0
[  113.277491] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x8e/0xb0
[  113.277503] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x8e/0xb0
[  113.277512] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x8e/0xb0
[  113.277524] NMI backtrace for cpu 66 skipped: idling at intel_idle+0x8e/0xb0
[  113.277532] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x8e/0xb0
[  113.277541] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x8e/0xb0
[  113.277552] NMI backtrace for cpu 1 skipped: idling at intel_idle+0x8e/0xb0
[  113.277560] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x8e/0xb0
[  113.277571] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x8e/0xb0
[  113.277576] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x8e/0xb0
[  113.277588] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x8e/0xb0
[  113.277600] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x8e/0xb0
[  113.277608] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x8e/0xb0
[  113.277619] NMI backtrace for cpu 18 skipped: idling at intel_idle+0x8e/0xb0
[  113.277632] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x8e/0xb0
[  113.277643] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x8e/0xb0
[  113.277654] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x8e/0xb0
[  113.277662] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x8e/0xb0
[  113.277668] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x8e/0xb0
[  113.277676] NMI backtrace for cpu 68
[  113.277677] CPU: 68 PID: 528 Comm: kworker/68:1 Not tainted 6.1.13-5.el7.x86_64 #1
[  113.277679] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
[  113.277680] Workqueue: events drm_fb_helper_damage_work
[  113.277682] RIP: 0010:memcpy_toio+0x6e/0xb0
[  113.277684] Code: 5c c3 cc cc cc cc 48 85 db 74 f2 40 f6 c5 01 75 45 48 83 fb 01 76 06 40 f6 c5 02 75 25 48 89 d9 48 89 ef 4c 89 e6 48 c1 e9 02 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 5b 5d 41 5c c3 cc cc
[  113.277685] RSP: 0018:ffffaa169a363b88 EFLAGS: 00010206
[  113.277687] RAX: 0000000000000000 RBX: 0000000000001000 RCX: 00000000000003f0
[  113.277688] RDX: 0000000000000000 RSI: ffffaa16b11ef040 RDI: ffffaa16b21ee040
[  113.277689] RBP: ffffaa16b21ee000 R08: ffffaa169a363c30 R09: ffffaa169a363c30
[  113.277690] R10: ffffaa169a363c20 R11: 0000000000000001 R12: ffffaa16b11ef000
[  113.277691] R13: 00000000000001ee R14: ffffaa16b11ef000 R15: 0000000000001000
[  113.277692] FS:  0000000000000000(0000) GS:ffff8a8281080000(0000) knlGS:0000000000000000
[  113.277693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.277694] CR2: 00007f753b2a6000 CR3: 000000a269810003 CR4: 00000000007706e0
[  113.277695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  113.277696] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  113.277696] PKRU: 55555554
[  113.277697] Call Trace:
[  113.277698]  <TASK>
[  113.277698]  drm_fb_memcpy+0x120/0x160
[  113.277702]  mgag200_primary_plane_helper_atomic_update+0xa8/0x300 [mgag200]
[  113.277709]  drm_atomic_helper_commit_planes+0xb7/0x240
[  113.277711]  drm_atomic_helper_commit_tail+0x26/0x60
[  113.277713]  mgag200_mode_config_helper_atomic_commit_tail+0x25/0x30 [mgag200]
[  113.277719]  commit_tail+0x91/0x130
[  113.277720]  drm_atomic_helper_commit+0x116/0x140
[  113.277722]  drm_atomic_commit+0x93/0xc0
[  113.277724]  ? drm_plane_get_damage_clips.cold.7+0x1c/0x1c
[  113.277727]  drm_atomic_helper_dirtyfb+0x225/0x2a0
[  113.277729]  drm_fb_helper_damage_work+0x1a4/0x390
[  113.277731]  process_one_work+0x1b0/0x390
[  113.277733]  worker_thread+0x3c/0x370
[  113.277735]  ? process_one_work+0x390/0x390
[  113.277736]  kthread+0xe3/0x110
[  113.277738]  ? kthread_complete_and_exit+0x20/0x20
[  113.277739]  ret_from_fork+0x1f/0x30
[  113.277742]  </TASK>
[  113.277743] NMI backtrace for cpu 19 skipped: idling at intel_idle+0x8e/0xb0
[  113.277751] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x8e/0xb0
[  113.277762] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x8e/0xb0
[  113.277770] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x8e/0xb0
[  113.277778] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x8e/0xb0
[  113.277785] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x8e/0xb0
[  113.277795] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x8e/0xb0
[  113.277803] NMI backtrace for cpu 0 skipped: idling at intel_idle+0x8e/0xb0
[  113.277815] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x8e/0xb0
[  113.277823] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x8e/0xb0
[  113.277834] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x8e/0xb0
[  113.277842] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x8e/0xb0
[  113.277850] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x8e/0xb0
[  113.277861] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x8e/0xb0
[  113.277873] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x8e/0xb0
[  113.277880] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x8e/0xb0
[  113.277892] NMI backtrace for cpu 4 skipped: idling at intel_idle+0x8e/0xb0
[  113.277903] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x8e/0xb0
[  113.277911] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x8e/0xb0
[  113.277923] NMI backtrace for cpu 54 skipped: idling at intel_idle+0x8e/0xb0
[  113.277931] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x8e/0xb0
[  113.277938] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x8e/0xb0
[  113.277945] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x8e/0xb0
[  113.277953] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x8e/0xb0
[  113.277965] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x8e/0xb0
[  113.277973] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x8e/0xb0
[  113.277985] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x8e/0xb0
[  113.277993] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x8e/0xb0
[  113.278004] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x8e/0xb0
[  113.278012] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x8e/0xb0
[  113.278020] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x8e/0xb0
[  113.278032] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x8e/0xb0
[  113.278039] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x8e/0xb0
[  113.278047] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x8e/0xb0
[  113.278055] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x8e/0xb0
[  113.278062] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x8e/0xb0
[  113.278073] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x8e/0xb0
[  113.278080] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x8e/0xb0
[  113.278088] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x8e/0xb0
[ 2244.496514] Process accounting resumed


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/25


