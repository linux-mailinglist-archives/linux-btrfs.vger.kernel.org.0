Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067836313ED
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Nov 2022 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKTMnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 07:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKTMnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 07:43:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D827DE1
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+7ybICL7OAqGeOqFufXzXkAPNmweHW3/7tXXTmJUaGc=; b=4/ngEK4PiZKO0Gj0Px35UCu9Ai
        Ycy11mdiqSCtL6XvEZWmum9u5KhHfHoOD9whmzb8/gVj3a4jzfHjG7ZkujLuQ5bhPKDz9SMcXUDSs
        /nd9Gm/TQrzpy6hZRCZuwiY40fHIvaydIgGlFW1oOhMpg03QNeKSa/eC6K0663QM6wxEbyW40LkZG
        gQ4t2HniVBQWUB9i0LX5Cr7sdQthBAIJ/V9YnmaxWTOZcGFk5cRoq7CKWPFgTE2uSF+NtpkeZzZm/
        I2ShM8nFtdGfFSIM0AqvvO6UT/mj1VTopYEe6rsYCS8iXm4U8Uj8tu1Uee9RN3Nu73eG2hXMrWNj1
        N2/HXAgg==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjf8-004GtK-CJ; Sun, 20 Nov 2022 12:43:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Date:   Sun, 20 Nov 2022 13:43:03 +0100
Message-Id: <20221120124303.17918-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Otherwise the kernel memory allocator seems to be unhappy about failing
order 6 allocations for the zones array, that cause 100% reproducible
mount failures in my qemu setup:

[   26.078981] mount: page allocation failure: order:6, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
[   26.079741] CPU: 0 PID: 2965 Comm: mount Not tainted 6.1.0-rc5+ #185
[   26.080181] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   26.080950] Call Trace:
[   26.081132]  <TASK>
[   26.081291]  dump_stack_lvl+0x56/0x6f
[   26.081554]  warn_alloc+0x117/0x140
[   26.081808]  ? __alloc_pages_direct_compact+0x1b5/0x300
[   26.082174]  __alloc_pages_slowpath.constprop.0+0xd0e/0xde0
[   26.082569]  __alloc_pages+0x32a/0x340
[   26.082836]  __kmalloc_large_node+0x4d/0xa0
[   26.083133]  ? trace_kmalloc+0x29/0xd0
[   26.083399]  kmalloc_large+0x14/0x60
[   26.083654]  btrfs_get_dev_zone_info+0x1b9/0xc00
[   26.083980]  ? _raw_spin_unlock_irqrestore+0x28/0x50
[   26.084328]  btrfs_get_dev_zone_info_all_devices+0x54/0x80
[   26.084708]  open_ctree+0xed4/0x1654
[   26.084974]  btrfs_mount_root.cold+0x12/0xde
[   26.085288]  ? lock_is_held_type+0xe2/0x140
[   26.085603]  legacy_get_tree+0x28/0x50
[   26.085876]  vfs_get_tree+0x1d/0xb0
[   26.086139]  vfs_kern_mount.part.0+0x6c/0xb0
[   26.086456]  btrfs_mount+0x118/0x3a0
[   26.086728]  ? lock_is_held_type+0xe2/0x140
[   26.087043]  legacy_get_tree+0x28/0x50
[   26.087323]  vfs_get_tree+0x1d/0xb0
[   26.087587]  path_mount+0x2ba/0xbe0
[   26.087850]  ? _raw_spin_unlock_irqrestore+0x38/0x50
[   26.088217]  __x64_sys_mount+0xfe/0x140
[   26.088506]  do_syscall_64+0x35/0x80
[   26.088776]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2218b33dac568..a759668477bb2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -468,7 +468,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		goto out;
 	}
 
-	zones = kcalloc(BTRFS_REPORT_NR_ZONES, sizeof(struct blk_zone), GFP_KERNEL);
+	zones = kvcalloc(BTRFS_REPORT_NR_ZONES, sizeof(struct blk_zone), GFP_KERNEL);
 	if (!zones) {
 		ret = -ENOMEM;
 		goto out;
@@ -587,7 +587,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 
-	kfree(zones);
+	kvfree(zones);
 
 	switch (bdev_zoned_model(bdev)) {
 	case BLK_ZONED_HM:
@@ -619,7 +619,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	return 0;
 
 out:
-	kfree(zones);
+	kvfree(zones);
 out_free_zone_info:
 	btrfs_destroy_dev_zone_info(device);
 
-- 
2.30.2

