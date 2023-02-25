Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88596A2682
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Feb 2023 02:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBYB1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 20:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYB1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 20:27:54 -0500
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09CF3C3D
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Feb 2023 17:27:51 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0522332|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0218095-8.11869e-05-0.978109;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.RW5kK4P_1677288468;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RW5kK4P_1677288468)
          by smtp.aliyun-inc.com;
          Sat, 25 Feb 2023 09:27:49 +0800
Date:   Sat, 25 Feb 2023 09:27:49 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: issue discovered by hung_task_timeout_secs?
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <b12f8dbc-85d6-ada9-3ff3-d16b2d178911@suse.com>
References: <20230225083600.126A.409509F4@e16-tech.com> <b12f8dbc-85d6-ada9-3ff3-d16b2d178911@suse.com>
Message-Id: <20230225092749.E7CC.409509F4@e16-tech.com>
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


> On 2023/2/25 08:36, Wang Yugui wrote:
> > Hi,
> >
> > The following setting maybe useful to diag the data flush problem inside btrfs.
> >
> > # we need SSD for this test case
> > vm.dirty_expire_centisecs = 200
> > vm.dirty_writeback_centisecs = 100
> > kernel.hung_task_timeout_secs=4
> > kernel.hung_task_all_cpu_backtrace=1
> >
> > In fact, only few cases of high load was reported.
> >
> > but some case of btrfs-cleaner when low load is reported too.
> > it maybe an issue inside btrfs, or expected behavor?
> > [...]
> > [   59.591229] NMI backtrace for cpu 65
> > [   59.591232] CPU: 65 PID: 1550 Comm: btrfs-transacti Not tainted 6.1.13-5.el7.x86_64 #1
> > [   59.591234] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.16.1 08/19/2022
> > [   59.591251] RIP: 0010:btrfs_comp_cpu_keys+0x3f/0x50 [btrfs]
> > [   59.591300] Code: ff ff 72 26 b8 01 00 00 00 0f b6 4e 08 38 4f 08 77 18 b8 ff ff ff ff 72 11 b8 01 00 00 00 48 8b 4e 09 48 39 4f 09 77 02 19 c0 <c3> cc cc cc cc 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > [   59.591301] RSP: 0018:ffffaa169c5f7b10 EFLAGS: 00000206
> > [   59.591303] RAX: 0000000000000001 RBX: 000000000000001e RCX: ffff8a840ec6f890
> > [   59.591304] RDX: 00000372db98c000 RSI: ffffaa169c5f7c5e RDI: ffff8a8479adb353
> > [   59.591305] RBP: 0000000000000020 R08: ffff8a840ec6f850 R09: 0000123804da8000
> > [   59.591306] R10: 0000000000000001 R11: 0000000000000000 R12: 000000000000001d
> > [   59.591306] R13: ffff8a8423cfb200 R14: 0000000000000019 R15: ffffaa169c5f7c5e
> > [   59.591307] FS:  0000000000000000(0000) GS:ffff8ae27fc00000(0000) knlGS:0000000000000000
> > [   59.591309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   59.591310] CR2: 00007fed7e13102c CR3: 000000a269810001 CR4: 00000000007706e0
> > [   59.591310] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   59.591311] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   59.591312] PKRU: 55555554
> > [   59.591313] Call Trace:
> > [   59.591314]  <TASK>
> > [   59.591315]  btrfs_generic_bin_search+0xf1/0x160 [btrfs]
> > [   59.591348]  btrfs_search_slot+0xa38/0xbc0 [btrfs]
> > [   59.591380]  ? kmem_cache_alloc+0x16b/0x530
> > [   59.591386]  find_parent_nodes+0xde/0x1280 [btrfs]
> > [   59.591443]  btrfs_find_all_roots_safe+0xa3/0x160 [btrfs]
> > [   59.591497]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
> > [   59.591549]  btrfs_qgroup_account_extents+0xc4/0x270 [btrfs]
> 
> This is the cause, qgroup.
> 
> And you mentioned cleaner kthread, are you dropping some large shared snapshots?
> If so, no wonder.
> 
> In that case, you'd better config /sys/fs/btrfs/<uuid>/qgroups/drop_subtree_threshold to some lower value, e.g. 3, to prevent the problem.

the snapshot drop should be triggered by snapper timeline cleanup.

Could we do some schedule change inside btrfs to slicence it?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/25

