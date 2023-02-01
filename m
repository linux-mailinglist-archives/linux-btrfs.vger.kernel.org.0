Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C3685D4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Feb 2023 03:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBACWa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 21:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 21:22:27 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859A183;
        Tue, 31 Jan 2023 18:22:25 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4P65KW3Yw1z6FMyr;
        Wed,  1 Feb 2023 10:22:23 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 3112MIjp082981;
        Wed, 1 Feb 2023 10:22:19 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 1 Feb 2023 10:22:19 +0800 (CST)
Date:   Wed, 1 Feb 2023 10:22:19 +0800 (CST)
X-Zmail-TransId: 2af963d9ccdb3c5e9129
X-Mailer: Zmail v1.0
Message-ID: <202302011022199155711@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <clm@fb.com>
Cc:     <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBCdHJmczogZml4IGNvbXBpbGUgZXJyb3IgYWJvdXQgdW5pbml0aWFsaXplZCB2YXJpYWJsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3112MIjp082981
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63D9CCDF.000 by FangMail milter!
X-FangMail-Envelope: 1675218143/4P65KW3Yw1z6FMyr/63D9CCDF.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63D9CCDF.000/4P65KW3Yw1z6FMyr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

fs/btrfs/tree-log.c:6166:6: note: 'last_range_start' was declared here
fs/btrfs/volumes.c:2598:27: note: 'seed_devices' was declared here
fs/btrfs/send.c:1909:13: error: 'right_gen' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/btrfs/send.c     | 2 +-
 fs/btrfs/tree-log.c | 2 +-
 fs/btrfs/volumes.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c3146ce84156..3c9f2d30065d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	int left_ret;
 	int right_ret;
 	u64 left_gen;
-	u64 right_gen;
+	u64 right_gen = 0;
 	struct btrfs_inode_info info;

 	ret = get_inode_info(sctx->send_root, ino, &info);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 200cea6e49e5..b91fa398b814 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6163,7 +6163,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 83cb2db43779..1298569cf8b5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2595,7 +2595,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_fs_devices *seed_devices;
+	struct btrfs_fs_devices *seed_devices = NULL;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
-- 
2.25.1
