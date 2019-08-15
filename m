Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4423B8E5EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 10:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfHOIEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 04:04:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbfHOIEJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 04:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32D3FB0F2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 08:04:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: transaction: Commit transaction more frequently for BPF
Date:   Thu, 15 Aug 2019 16:04:04 +0800
Message-Id: <20190815080404.20600-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has btrfs_end_transaction_throttle() which could try to commit
transaction when needed.

However under most cases btrfs_end_transaction_throttle() won't really
commit transaction, due to the hard timing requirement.

Now introduce a new error injection point, btrfs_need_trans_pressure(),
to allow btrfs_should_end_transaction() to return 1 and
btrfs_end_transaction_throttle() to fallback to
btrfs_commit_transaction().

With such more aggressive transaction commit, we can dig deeper into
cases like snapshot drop.
Now each reference drop of btrfs_drop_snapshot() will lead to a
transaction commit, allowing dm-logwrites to catch more details, other
than one big transaction dropping everything.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add comment to explain why this function is needed
---
 fs/btrfs/transaction.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f6811cdf803..8c5471b01d03 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/uuid.h>
+#include <linux/error-injection.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -749,10 +750,25 @@ void btrfs_throttle(struct btrfs_fs_info *fs_info)
 	wait_current_trans(fs_info);
 }
 
+/*
+ * This function is to allow BPF to override the return value so that we can
+ * make btrfs to commit transaction more aggressively.
+ *
+ * It's a debug only feature, mainly used with dm-log-writes to catch more details
+ * of transient operations like balance and subvolume drop.
+ */
+static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_handle *trans)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);
+
 static int should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
+	if (btrfs_need_trans_pressure(trans))
+		return 1;
 	if (btrfs_check_space_for_delayed_refs(fs_info))
 		return 1;
 
@@ -813,6 +829,8 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 
 	btrfs_trans_release_chunk_metadata(trans);
 
+	if (throttle && btrfs_need_trans_pressure(trans))
+		return btrfs_commit_transaction(trans);
 	if (lock && READ_ONCE(cur_trans->state) == TRANS_STATE_BLOCKED) {
 		if (throttle)
 			return btrfs_commit_transaction(trans);
-- 
2.22.0

