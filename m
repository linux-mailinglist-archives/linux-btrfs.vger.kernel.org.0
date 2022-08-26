Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA95A1DA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiHZAOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHZAOu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 20:14:50 -0400
Received: from out20-74.mail.aliyun.com (out20-74.mail.aliyun.com [115.124.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8936B2D
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 17:14:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04501607|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00383037-0.000411928-0.995758;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.P058SZ1_1661472881;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P058SZ1_1661472881)
          by smtp.aliyun-inc.com;
          Fri, 26 Aug 2022 08:14:42 +0800
Date:   Fri, 26 Aug 2022 08:14:45 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <5f0ab29e-c557-d67c-06a6-9dcb7d850cb9@oracle.com>
References: <4a7ddf8e-f283-a2e8-3c96-c67ae4b3bf5b@suse.com> <5f0ab29e-c557-d67c-06a6-9dcb7d850cb9@oracle.com>
Message-Id: <20220826081444.A633.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
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

> On 11/01/2022 23:19, Nikolay Borisov wrote:
> >
> >
> > On 6.01.22 §Ô. 2:04, Anand Jain wrote:
> >>
> >> Gentle ping?
> 
>    Gentle ping again.
> 
> >>
> >> The related kernel patch is already in misc-next.
> >> I don't find this btrfs-progs patch-set in the devel branch.
> >
> > And what about introducing a test case for this change?
> 
>    btrfs/248 did it.
> 
> Thanks, Anand

Now fstests btrfs/249 always fail because of dmesg output,  any advice?
kernel: 6.0.0-rc2 and 5.15.62

[ 1063.381649] run fstests btrfs/249 at 2022-08-26 08:04:47
[ 1063.593122] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
[ 1063.609363] BTRFS info (device sdb1): using free space tree
[ 1063.618584] BTRFS info (device sdb1): enabling ssd optimizations
[ 1064.768430] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 1 transid 6 /dev/sdb2 scanned by systemd-udevd (3602)
[ 1064.781504] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 2 transid 6 /dev/sdb3 scanned by systemd-udevd (3605)
[ 1065.065938] BTRFS: device fsid 00ebd666-e838-4377-b9b6-aa69449297af devid 2 transid 7 /dev/sdb3 scanned by systemd-udevd (3602)
[ 1065.088577] BTRFS info (device sdb3): using crc32c (crc32c-intel) checksum algorithm
[ 1065.097656] BTRFS info (device sdb3): allowing degraded mounts
[ 1065.112161] BTRFS info (device sdb3): using free space tree
[ 1065.119832] BTRFS warning (device sdb3): devid 1 uuid 37e015cd-b874-4878-b07e-e12360622063 is missing
[ 1065.132956] BTRFS warning (device sdb3): devid 1 uuid 37e015cd-b874-4878-b07e-e12360622063 is missing
[ 1065.148748] BTRFS info (device sdb3): enabling ssd optimizations
[ 1065.156311] BTRFS info (device sdb3): checking UUID tree
[ 1065.162942] BTRFS warning (device sdb3): Skipping commit of aborted transaction.
[ 1065.171228] ------------[ cut here ]------------
[ 1065.176739] BTRFS: Transaction aborted (error -28)
[ 1065.176773] WARNING: CPU: 5 PID: 1665 at fs/btrfs/transaction.c:1942 btrfs_commit_transaction.cold.40+0x9c/0x326 [btrfs]
[ 1065.188622] Modules linked in: XXXXXXX
[ 1065.188694]  wmi i2c_dev ipmi_devintf ipmi_msghandler
[ 1065.282180] Unloaded tainted modules: XXXXXXX
[ 1065.381811]  pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1
[ 1065.495646] CPU: 5 PID: 1665 Comm: kworker/u81:0 Tainted: G        W          6.0.0-2.3.el7.x86_64 #1
[ 1065.506159] Hardware name: Dell Inc. Precision T7610/0NK70N, BIOS A18 09/11/2019
[ 1065.514868] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
[ 1065.523678] RIP: 0010:btrfs_commit_transaction.cold.40+0x9c/0x326 [btrfs]
[ 1065.531855] Code: 30 0a 00 00 03 72 25 41 83 ff fb 0f 84 dc 01 00 00 41 83 ff e2 0f 84 d2 01 00 00 44 89 fe 48 c7 c7 f8 2c bc c4 e8 ac 9b d4 ca <0f> 0b 44 89 f9 ba 96 07 00 00 4c 89 e7 48 c7 c6 b0 68 ba c4 e8 ea
[ 1065.553335] RSP: 0018:ffffaeb5cca4fd28 EFLAGS: 00010282
[ 1065.559946] RAX: 0000000000000000 RBX: ffff8bf409dd1e00 RCX: 0000000000000027
[ 1065.568461] RDX: 0000000000000027 RSI: ffff8c12ef95f860 RDI: ffff8c12ef95f868
[ 1065.576978] RBP: ffff8c1445ceb000 R08: 0000000000000000 R09: c0000000fffdffff
[ 1065.585495] R10: 0000000000000001 R11: ffffaeb5cca4fbc0 R12: ffff8bf411d56f08
[ 1065.594009] R13: ffff8bf411d56e58 R14: ffff8bf411d56e58 R15: 00000000ffffffe4
[ 1065.602502] FS:  0000000000000000(0000) GS:ffff8c12ef940000(0000) knlGS:0000000000000000
[ 1065.611957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1065.619084] CR2: 00007f55c95fd550 CR3: 0000000472a10003 CR4: 00000000001706e0
[ 1065.627604] Call Trace:
[ 1065.631460]  <TASK>
[ 1065.634955]  ? start_transaction+0xd3/0x5f0 [btrfs]
[ 1065.641288]  flush_space+0x54e/0x5f0 [btrfs]
[ 1065.647029]  ? pick_next_task_fair+0xb0/0x420
[ 1065.652782]  ? put_prev_entity+0x22/0xe0
[ 1065.658096]  ? btrfs_get_alloc_profile+0xc9/0x1b0 [btrfs]
[ 1065.664954]  btrfs_async_reclaim_metadata_space+0xfb/0x240 [btrfs]
[ 1065.672599]  process_one_work+0x1b0/0x390
[ 1065.678005]  worker_thread+0x3c/0x370
[ 1065.683055]  ? process_one_work+0x390/0x390
[ 1065.688606]  kthread+0xe3/0x110
[ 1065.693125]  ? kthread_complete_and_exit+0x20/0x20
[ 1065.699291]  ret_from_fork+0x1f/0x30
[ 1065.704233]  </TASK>
[ 1065.707783] ---[ end trace 0000000000000000 ]---
[ 1065.713762] BTRFS: error (device sdb3: state A) in cleanup_transaction:1942: errno=-28 No space left
[ 1065.724284] BTRFS warning (device sdb3: state EA): btrfs_uuid_scan_kthread failed -5
[ 1065.733433] BTRFS error (device sdb3: state EA): commit super ret -30


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/26


