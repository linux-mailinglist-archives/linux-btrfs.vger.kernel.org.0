Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343F8781052
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355702AbjHRQ00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378687AbjHRQ0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 12:26:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14573C3E
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692375970; x=1723911970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjlW5mWGQbqv/wDz2Z+3kad675CP3Ya6Y93bziIMTXc=;
  b=OkX+L0PiftViIQYlnx3fAbHxo1avPFYXdqEIt10k9kroeV+hwfF+5HOn
   EjX8kSxb395NvfuxMqTWJotvYAFhDV86QCfU6pbuSZpouL5kibyPYplEI
   MWF5TaJQ98gnx1Yd0epgKCGnieaLyoUwGV07aq1IJ6fKNPtMx/z7ODRuS
   QkMXS1T/rGdXGOuNW/7c23m6iMloWQWdFQ0FHWcq9O3pM5uqGS6HDApYG
   xBWQ/lllX8fV5os3cqf9UJHQRxvRFn9eUamff3iPgVH0RjdL5OhPemYDE
   kJwVQz21BKhiAd/apx54XMk4cQ1IK8bKVwxIXwlj1sboXwtyU9SeQWQol
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,183,1684771200"; 
   d="scan'208";a="346691708"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2023 00:26:10 +0800
IronPort-SDR: +NdtAVcI9Wqzr0fHCqAJNq0T7Ew938J3O/qMa8xUZB4jnyi5Ivm1vSdjKX9rjngoBWlQ70TGPD
 xcMhRNNVCOKvTymRa3SYMzUDvep7yRdx+Eyw14eAtoP5UApDo7DeQ/pOwbUud86QAUI6dDTbeZ
 gWB4Yo5BE/Nojt33W1xb0QqoNlSZrdgqylYEU6M+OP5ac5kFDUCkQsVPDm36zX+zh18ZQokrRy
 1BYw48/uWoZZ64zCLwzQvsiUfLPUfOU/M14QpoMwinOwhn9gYXEbuiCLSJldvYp74Deu+a/qqc
 fE4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2023 08:33:44 -0700
IronPort-SDR: NiahChUYhXx1QxqZewxSOSHKN007OcL93tM8puWW5ieFCMXnYhUMl6anK3d38DL5ISHr/aymoh
 bUoDH9xmFSk4CPikNGWsOI5Pu62szv1byozo96iET+rzU6EVY5MBJ18duTpffJYVtfxMQeiHJh
 iHrHrVOlVXGn1xCExw7cKkXHzZ4O+WtJuVhE6Jud+m67HFOZi1Uz9LSgsTKGmWBTqpVcYN11eo
 lIqkwPlTBcRS8avKyvdL+M/VRuuEljhfaPZAecckQ6BJqYTkXhuOKavKhk4znZAKQ5qjj48wOd
 r7U=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.93])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Aug 2023 09:26:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@lst.de, shinichiro.kawasaki@wdc.com,
        Johannes.Thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: skip splitting and logical rewriting on pre-alloc write
Date:   Sat, 19 Aug 2023 01:26:07 +0900
Message-ID: <b9fec5bebe9d5be20c51bf0934a95609830d04d4.1692375606.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When doing a relocation, there is a chance that at the time of
btrfs_reloc_clone_csums(), there is no checksum for the corresponding
region.

In this case, btrfs_finish_ordered_zoned()'s sum points to an invalid item
and so ordered_extent's logical is set to some invalid value. Then,
btrfs_lookup_block_group() in btrfs_zone_finish_endio() failed to find a
block group and will hit an assert or a null pointer dereference as
following.

This can be reprodcued by running btrfs/028 several times (e.g, 4 to 16
times) with a null_blk setup. The device's zone size and capacity is set to
32 MB and the storage size is set to 5 GB on my setup.

    KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
    CPU: 6 PID: 3105720 Comm: kworker/u16:13 Tainted: G        W          6.5.0-rc6-kts+ #1
    Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
    Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
    RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
    Code: 41 54 49 89 fc 55 48 89 f5 53 e8 57 7d fc ff 48 8d b8 88 00 00 00 48 89 c3 48 b8 00 00 00 00 00
    > 3c 02 00 0f 85 02 01 00 00 f6 83 88 00 00 00 01 0f 84 a8 00 00
    RSP: 0018:ffff88833cf87b08 EFLAGS: 00010206
    RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
    RDX: 0000000000000011 RSI: 0000000000000004 RDI: 0000000000000088
    RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed102877b827
    R10: ffff888143bdc13b R11: ffff888125b1cbc0 R12: ffff888143bdc000
    R13: 0000000000007000 R14: ffff888125b1cba8 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff88881e500000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007f3ed85223d5 CR3: 00000001519b4005 CR4: 00000000001706e0
    Call Trace:
     <TASK>
     ? die_addr+0x3c/0xa0
     ? exc_general_protection+0x148/0x220
     ? asm_exc_general_protection+0x22/0x30
     ? btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
     ? btrfs_zone_finish_endio.part.0+0x19/0x160 [btrfs]
     btrfs_finish_one_ordered+0x7b8/0x1de0 [btrfs]
     ? rcu_is_watching+0x11/0xb0
     ? lock_release+0x47a/0x620
     ? btrfs_finish_ordered_zoned+0x59b/0x800 [btrfs]
     ? __pfx_btrfs_finish_one_ordered+0x10/0x10 [btrfs]
     ? btrfs_finish_ordered_zoned+0x358/0x800 [btrfs]
     ? __smp_call_single_queue+0x124/0x350
     ? rcu_is_watching+0x11/0xb0
     btrfs_work_helper+0x19f/0xc60 [btrfs]
     ? __pfx_try_to_wake_up+0x10/0x10
     ? _raw_spin_unlock_irq+0x24/0x50
     ? rcu_is_watching+0x11/0xb0
     process_one_work+0x8c1/0x1430
     ? __pfx_lock_acquire+0x10/0x10
     ? __pfx_process_one_work+0x10/0x10
     ? __pfx_do_raw_spin_lock+0x10/0x10
     ? _raw_spin_lock_irq+0x52/0x60
     worker_thread+0x100/0x12c0
     ? __kthread_parkme+0xc1/0x1f0
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x2ea/0x3c0
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x30/0x70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1b/0x30
     </TASK>

On the zoned mode, writing to pre-allocated region means data relocation
write. Such write always uses WRITE command so there is no need of splitting
and rewriting logical address. Thus, we can just skip the function for the
case.

Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for zoned writes")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a2f8e7440f8c..9e7794c2ef11 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1700,10 +1700,21 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_ordered_sum *sum =
-		list_first_entry(&ordered->list, typeof(*sum), list);
-	u64 logical = sum->logical;
-	u64 len = sum->len;
+	struct btrfs_ordered_sum *sum;
+	u64 logical, len;
+
+	/*
+	 * Write to pre-allocated region is for the data relocation, and so
+	 * it should use WRITE operation. No split/rewrite are necessary.
+	 */
+	if (ordered->flags & (1 << BTRFS_ORDERED_PREALLOC))
+		return;
+
+	ASSERT(!list_empty(&ordered->list));
+	/* ordered->list can be empty in the above pre-alloc case. */
+	sum = list_first_entry(&ordered->list, typeof(*sum), list);
+	logical = sum->logical;
+	len = sum->len;
 
 	while (len < ordered->disk_num_bytes) {
 		sum = list_next_entry(sum, list);
-- 
2.41.0

