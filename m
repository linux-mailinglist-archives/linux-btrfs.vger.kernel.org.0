Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C1B718065
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjEaMyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjEaMyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 08:54:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1091BC
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:53:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 316B568B05; Wed, 31 May 2023 14:52:25 +0200 (CEST)
Date:   Wed, 31 May 2023 14:52:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: new scrub code vs zoned file systems
Message-ID: <20230531125224.GB27468@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

btrfs/163 got really unhappy on zoned devices with the new scrub code,
as it tries to rewrite data in place using btrfs_submit_repair_write,
which is a regression compared to say Linux 6.3.

This log is when running on a SCRATCH_POOL using qemu emulated ZNS
drives:

[   53.359190] BTRFS info (device nvme1n1): host-managed zoned block device /dev/nvme3n1, 160 zones of 134217728 bytes
[   53.360646] BTRFS info (device nvme1n1): dev_replace from /dev/nvme2n1 (devid 2) to /dev/nvme3n1 started
[   53.691003] nvme3n1: Zone Management Append(0x7d) @ LBA 65536, 4 blocks, Zone Is Full (sct 0x1 / sc 0xb9) DNR 
[   53.694996] I/O error, dev nvme3n1, sector 786432 op 0xd:(ZONE_APPEND) flags 0x4000 phys_seg 3 prio class 2
[   53.694996] BTRFS error (device nvme1n1): bdev /dev/nvme3n1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[   53.694996] BUG: kernel NULL pointer dereference, address: 00000000000000a8
[   53.694996] #PF: supervisor write access in kernel mode
[   53.694996] #PF: error_code(0x0002) - not-present page
[   53.694996] PGD 0 P4D 0 
[   53.694996] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   53.694996] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-rc2+ #1190
[   53.694996] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   53.694996] RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
[   53.694996] Code: c2 fe c3 66 0f 1f 84 00 00 00 00 00 53 9c 58 0f 1f 40 00 48 89 c3 fa 0f 1f 44 00 00 65 ff 05 21 e7 c4 7d 31 c0 ba 01 00 00 00 <f0> 0f b1 17 75 05 48 89 d8 5b c3 89 c6 e8 10 03 00 00 48 89 d8 5b
[   53.694996] RSP: 0018:ffffc900000c4e00 EFLAGS: 00010046
[   53.694996] RAX: 0000000000000000 RBX: 0000000000000046 RCX: 0000000000000027
[   53.694996] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000000000a8
[   53.694996] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000003
[   53.694996] R10: ffffffff83076000 R11: ffffffff83076000 R12: ffff88810adecc00
[   53.694996] R13: 00000000000000a8 R14: 0000000000004000 R15: 0000000000004000
[   53.694996] FS:  0000000000000000(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
[   53.694996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.694996] CR2: 00000000000000a8 CR3: 0000000103544000 CR4: 0000000000750ee0
[   53.694996] PKRU: 55555554
[   53.694996] Call Trace:
[   53.694996]  <IRQ>
[   53.694996]  btrfs_lookup_ordered_extent+0x31/0x190
[   53.694996]  btrfs_record_physical_zoned+0x18/0x40
[   53.694996]  btrfs_simple_end_io+0xaf/0xc0
[   53.694996]  blk_update_request+0x153/0x4c0
[   53.694996]  blk_mq_end_request+0x15/0xd0
[   53.694996]  nvme_poll_cq+0x1d3/0x360
[   53.694996]  nvme_irq+0x39/0x80
[   53.694996]  __handle_irq_event_percpu+0x3b/0x190
[   53.694996]  handle_irq_event+0x2f/0x70
[   53.694996]  handle_edge_irq+0x7c/0x210
[   53.694996]  __common_interrupt+0x34/0xa0
[   53.694996]  common_interrupt+0x7d/0xa0
[   53.694996]  </IRQ>
[   53.694996]  <TASK>
[   53.694996]  asm_common_interrupt+0x22/0x40

