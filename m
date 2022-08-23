Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1759EA91
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHWSKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiHWSKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 14:10:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6276F277
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HowSmQfDZuwAwJi8ixQV1JWdUIB6j62PwP8g1h9dd9E=; b=ZwCu0NTQ8p7quGky67IFAJrCCP
        zXU2H29rX4S4l536YPd4R+FK+qwbTN5ftWPYXXPoENS/clOpX50WFh8fp221r7B6kuPxeL6g1sisb
        iOu9bNx72LfhD0ShVYyzWaAOQaAtGake8Vuqoze9JJjEO1yL8EjM58inZGv1RtL6jKsSkt5gea/8y
        DDaWBzrEyWuxQP/z2RYsQ7e35K02Dy4mPIvaWWd1kkedN0IKfVARE0ae9SbRJw3x2Iiv0A75itYTG
        BDXi/MqDQFu8Yuwbajxt3behsmE9e48IKjXCIFy6gzjOcGghWc+BV8a655tHfHNPeim9c6kbgDm3N
        R04F2NOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQWcs-007FZ9-A9
        for linux-btrfs@vger.kernel.org; Tue, 23 Aug 2022 16:19:38 +0000
Date:   Tue, 23 Aug 2022 09:19:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-btrfs@vger.kernel.org
Subject: xfstests is rather unhappy on curret for-next
Message-ID: <YwT+GsTRLUwXKJ2w@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

default options on x86-64 with a five-device spare bool gets
unhappy in the kobject code when running btrfs/017, and the
xfstest run then hangs:

[   85.716152] run fstests btrfs/017 at 2022-08-23 16:15:45
[   87.843179] BTRFS: device fsid 439db035-2c01-4c8e-9217-40d0accfd536 devid 1 transid 6)
[   87.921800] BTRFS info (device vdc): using crc32c (crc32c-generic) checksum algorithm
[   87.923465] BTRFS info (device vdc): using free space tree
[   87.937642] BTRFS info (device vdc): checking UUID tree
[   88.046021] kobject (ffff888104755140): tried to init an initialized object, somethin.
[   88.048050] CPU: 0 PID: 7250 Comm: btrfs Not tainted 6.0.0-rc2-block+ #2218
[   88.049364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/04
[   88.050906] Call Trace:
[   88.051381]  <TASK>
[   88.051798]  dump_stack_lvl+0x56/0x6f
[   88.052506]  kobject_init.cold+0x31/0x3f
[   88.053251]  kobject_init_and_add+0x35/0xa0
[   88.054022]  ? rcu_read_lock_sched_held+0x3a/0x60
[   88.054864]  ? trace_kmalloc+0x29/0xd0
[   88.055537]  ? kmem_cache_alloc_trace+0x1ee/0x340
[   88.056376]  btrfs_sysfs_add_qgroups+0x87/0x100
[   88.057192]  btrfs_quota_enable+0xc6/0x830
[   88.057930]  ? trace_kmalloc+0x29/0xd0
[   88.058598]  ? __kmalloc_track_caller+0x20f/0x3b0
[   88.059431]  ? btrfs_ioctl+0x251f/0x35c0
[   88.060138]  btrfs_ioctl+0x2e06/0x35c0
[   88.060818]  ? find_held_lock+0x2b/0x80
[   88.061519]  ? lock_release+0x147/0x2f0
[   88.062217]  ? __x64_sys_ioctl+0x7b/0xb0
[   88.062919]  __x64_sys_ioctl+0x7b/0xb0
[   88.063592]  do_syscall_64+0x35/0x80
[   88.064245]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   88.065146] RIP: 0033:0x7f0240ada397
[   88.065912] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e8
[   88.069908] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[   88.071473] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0240ada397
[   88.072988] RDX: 00007fff156c90e0 RSI: 00000000c0109428 RDI: 0000000000000003
[   88.074391] RBP: 0000000000000003 R08: 000056165e61c2a0 R09: 00007f0240bb8c00
[   88.075788] R10: fffffffffffff248 R11: 0000000000000202 R12: 00007fff156c9dfa
[   88.077433] R13: 0000000000000001 R14: 000056165cc0008d R15: 00007fff156c9288
[   88.079003]  </TASK>
[   88.080327] general protection fault, probably for non-canonical address 0x1ad998badaI
[   88.082664] CPU: 1 PID: 7250 Comm: btrfs Not tainted 6.0.0-rc2-block+ #2218
[   88.083949] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/04
[   88.085488] RIP: 0010:kfree+0x6e/0x550
[   88.086159] Code: 01 d8 0f 82 dd 04 00 00 49 bc 00 00 00 80 7f 77 00 00 49 01 c4 48 b4
[   88.089383] RSP: 0018:ffffc900036d7c58 EFLAGS: 00010203
[   88.090304] RAX: ffffea0000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000001
[   88.091550] RDX: 0000000000000000 RSI: ffffffff82fbd87b RDI: ffffffff830a6076
[   88.092793] RBP: ffffc900036d7c90 R08: ffffffff83085f05 R09: 0000000000000001
[   88.094042] R10: 0000000000000304 R11: ffffffff83a3b9e0 R12: 01ad998badadad80
[   88.095345] R13: ffff888104755140 R14: ffff88810d375910 R15: ffff88810d3b4000
[   88.096588] FS:  00007f02409e8d40(0000) GS:ffff88813bd00000(0000) knlGS:00000000000000
[   88.098002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   88.099010] CR2: 000055f382527900 CR3: 000000010d1da000 CR4: 00000000000006e0
[   88.100254] Call Trace:
[   88.100699]  <TASK>
[   88.101088]  kobject_set_name_vargs+0x6f/0x90
[   88.101950]  kobject_init_and_add+0x5d/0xa0
[   88.102697]  ? trace_kmalloc+0x29/0xd0
[   88.103366]  ? kmem_cache_alloc_trace+0x1ee/0x340
[   88.104256]  btrfs_sysfs_add_qgroups+0x87/0x100
[   88.105340]  btrfs_quota_enable+0xc6/0x830
[   88.106076]  ? trace_kmalloc+0x29/0xd0
[   88.106748]  ? __kmalloc_track_caller+0x20f/0x3b0
[   88.107584]  ? btrfs_ioctl+0x251f/0x35c0
[   88.108282]  btrfs_ioctl+0x2e06/0x35c0
[   88.108953]  ? find_held_lock+0x2b/0x80
[   88.109654]  ? lock_release+0x147/0x2f0
[   88.110340]  ? __x64_sys_ioctl+0x7b/0xb0
[   88.111038]  __x64_sys_ioctl+0x7b/0xb0
[   88.111724]  do_syscall_64+0x35/0x80
[   88.112368]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   88.113263] RIP: 0033:0x7f0240ada397
[   88.113913] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e8
[   88.117319] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[   88.118657] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0240ada397
[   88.119898] RDX: 00007fff156c90e0 RSI: 00000000c0109428 RDI: 0000000000000003
[   88.121137] RBP: 0000000000000003 R08: 000056165e61c2a0 R09: 00007f0240bb8c00
[   88.122404] R10: fffffffffffff248 R11: 0000000000000202 R12: 00007fff156c9dfa
[   88.123648] R13: 0000000000000001 R14: 000056165cc0008d R15: 00007fff156c9288
[   88.124895]  </TASK>
[   88.125298] Modules linked in:
[   88.126308] ---[ end trace 0000000000000000 ]---





