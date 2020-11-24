Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3B2C1D34
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 06:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgKXFEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 00:04:05 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49319 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgKXFEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 00:04:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGNsJ9m_1606194241;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGNsJ9m_1606194241)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 13:04:02 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/btrfs: remove parent_level in btrfs_sb_log_location_bdev
Date:   Tue, 24 Nov 2020 13:03:55 +0800
Message-Id: <1606194235-53397-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable parent_level isn't used, so don't bother to get it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Chris Mason <clm@fb.com> 
Cc: Josef Bacik <josef@toxicpanda.com> 
Cc: David Sterba <dsterba@suse.com> 
Cc: linux-btrfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/btrfs/ctree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 32a57a70b98d..e5a0941c4bde 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1578,13 +1578,10 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int end_slot;
 	int i;
 	int err = 0;
-	int parent_level;
 	u32 blocksize;
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
 
-	parent_level = btrfs_header_level(parent);
-
 	WARN_ON(trans->transaction != fs_info->running_transaction);
 	WARN_ON(trans->transid != fs_info->generation);
 
-- 
2.29.GIT

