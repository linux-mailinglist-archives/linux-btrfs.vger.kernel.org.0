Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C86FCC71
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjEIRNG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEIRNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 13:13:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BDAB
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683652383; x=1715188383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wTHWlp4rFpG+FeRLTSTcSiLaDRvacadidIzZl0tKX6k=;
  b=oBBSR2gyTXtZ+nVjGNFSfZeS/eat3QT2P1YWh0lac0/lCRA1IBTU+nij
   2lM1it+ggmz9N4wHXwlVGj/nqveNgjUKFU9+JxtNn3KFgwmegD1fx63SZ
   A6QMhf/Ly81zpiF3PyzGTuy7wU/AwJeE5LZiiicQwI8Py/7gzVBtmmtoT
   j6xBKaCFgK43sgQ0z38zEIQV2quG5TpxR7QwV5YRmmUHkpI0m/AM2CoWV
   okCkTt8G0qA+dwMVzk6XQK7zCpTViA5DcBNUXeX2aHE3ovA0ay9+yDT3n
   jfRTNZjMSK3BQlfXhuGrfqC68IONa3qBZktr0TmjP1AGQENlDtMph+m2e
   w==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="342304164"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 01:13:02 +0800
IronPort-SDR: IY5RnKZvkH6wRkb450MRJySGUhDoMwnsG+5mZ6/osGuylU0BYwQ/U+Biv6Xw/dIYhILL/8yauG
 nwp2RT6to+NJR38RMBnAp1RhVIZNJ/8Fw24dxa1S8AFscVxJp+RktbgcYxqDfYVkDAhTBlWhgH
 AjojAR6HtuLm0mpOk4EqLwVFq4YohHF+p9t0CyJc84RcRaTdSqIVqJIjmRR+pdNVLFZZ5JbhuE
 qUBvBJWcAjuiI7RDHwDKpGWY2q9DNy+ySMa3mCG1S1GY2ygsvwMKsOMDgMnOpZbwv4GctGHKKC
 sCM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2023 09:22:41 -0700
IronPort-SDR: 5Gm0tL+lLao/AIb6WCWW+SCSva0v5Iy0KuJecvpueeDuXz/FiDjfSUpng05ju4bq9LFjdmuHZo
 iKHDQtUK29ie32vePLcCHu+1nm8i+C8mOkcPx0kTPJWOPpmhpOU7BVkDXmtIWeQOOpKyMn+Mtr
 l5IHpZ3bfZBfD1rezEs42RcNqs2y8c1xz98mfoihor+eViDJsef6Vx9nSLBlhAouvPjKLUupy6
 3Wn5ZeUplQ0lOgIXO9iUlwhA4NDscadOIuJ2oCJf+G8UHSa8Fi/zW3wpst9puqOtet606jqLut
 J00=
WDCIronportException: Internal
Received: from 3qrpw33.ad.shared (HELO localhost.localdomain) ([10.225.97.191])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 May 2023 10:13:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <david.sterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: mark btrfs_run_discard_work status
Date:   Tue,  9 May 2023 10:12:01 -0700
Message-Id: <a6acf3890428f9ffc5ca42b4c37faa4292f30c3e.1683652229.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mark btrfs_run_discard_work static and move it above its callers.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/discard.c | 34 +++++++++++++++++-----------------
 fs/btrfs/discard.h |  1 -
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index a6d77fe41e1a..944a7340f6a4 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -73,6 +73,23 @@ static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	return &discard_ctl->discard_list[block_group->discard_index];
 }
 
+/*
+ * Determine if async discard should be running.
+ *
+ * @discard_ctl: discard control
+ *
+ * Check if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
+ */
+static bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
+{
+	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
+						     struct btrfs_fs_info,
+						     discard_ctl);
+
+	return (!(fs_info->sb->s_flags & SB_RDONLY) &&
+		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
+}
+
 static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				  struct btrfs_block_group *block_group)
 {
@@ -544,23 +561,6 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_unlock(&discard_ctl->lock);
 }
 
-/*
- * Determine if async discard should be running.
- *
- * @discard_ctl: discard control
- *
- * Check if the file system is writeable and BTRFS_FS_DISCARD_RUNNING is set.
- */
-bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
-{
-	struct btrfs_fs_info *fs_info = container_of(discard_ctl,
-						     struct btrfs_fs_info,
-						     discard_ctl);
-
-	return (!(fs_info->sb->s_flags & SB_RDONLY) &&
-		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
-}
-
 /*
  * Recalculate the base delay.
  *
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 57b9202f427f..dddb0f9101ba 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -24,7 +24,6 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 			      struct btrfs_block_group *block_group);
 void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
-bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
 /* Update operations */
 void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
-- 
2.40.1

