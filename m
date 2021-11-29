Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22494460CD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 03:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhK2Cyx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 21:54:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17863 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbhK2Cww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 21:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638154176; x=1669690176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QcHrAHEm7Ui5Lc74bXWMicLoE2BkfKLTkTkY1nkvZDA=;
  b=rVQ9mj3bTYl0gcGrrVkqvJv/x1Nwkcwb6D2HtYL6O63x33EeaEvxXhqH
   qRTnXZECUYh4Qt/ev58kq7Fg3zGHiWvm9lQRnej4nND3cGIfiwGVxyl1U
   qmI0KweRO7n63Lfr8oSgi7q6+rTjkLs5+qmCyig+YNv7oHFK4asxamczt
   apJtvXJahUmmDR2fmEwdRF2WmdSYGqYjpWrVJqBiuRMXkw9U0iVOzCyhH
   X0lwE59WV7ute25BqskOlyRPae8di+CJKXgnEwMcFQ5SvnwBa5jSqstC4
   xs20R3NuGy7dy7e9Ay6nPUxtiWUAF2i90dwQP+ivBeUI3rrCY76d3L7+u
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="185902820"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 10:49:35 +0800
IronPort-SDR: PwfGC6QyTCD5hcwMYPLXt+/I2z0fH5z3Ue64OqBye1sutdQytT26FyiHqQ0ZwgrpKLGZrLLrS7
 lCjqOuNAC8Qb4+Lz7Vycd6jUmI/DKo3qt9ywMZUU2T9Uz1bLImRuO41iFH9kmsLJQW47QGFVy3
 i/lneJIbt2pBFYeRG0Q9ZplUlK+VDCsyu3PY/mnkVFCYDD7OmXZILFW2xyypblqZDplVHDVLpk
 OIrGm0g000l2+o3miDhkF9pCAu0xX7x3QFsKbbiee+rrFYlw0ID6kUMhE8WNLVdE1W3BUdWE4x
 ySH7rptdfrEIPKLNKM0+4FW3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 18:24:22 -0800
IronPort-SDR: +agPGeegGtjjxYjEXDOb583LYDIBsrO6xBPN7RhXMderSJ/6X9H0iPgw97pjAolGaR/chwPGb+
 AG1ts+NQHsi1e6CGguW9HxaWxPkmWBpBoaZbJvh55TwB+TIAQ4UEIqJQbPao8km6bqx/TjWKfY
 qYOFUqapPsyIDeQ5IMWNdL8oXyot1R3mG1g5FpVQrmPUXzHSvUPvnNOtQcYsHfXaeN7OXWw5AN
 uZgOQnwW8Es0/9Z0pa4wOHyfwV1rmnuknO94kcBxd8mNaIWnff7ufRaygFoLLTE0IcZDzeEDI3
 UcA=
WDCIronportException: Internal
Received: from cdf5fb3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.113])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Nov 2021 18:49:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Date:   Mon, 29 Nov 2021 11:49:30 +0900
Message-Id: <20211129024930.1574325-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For zoned btrfs, we re-dirty a freeing tree node to ensure btrfs write
the region and not to leave a write hole on a zoned device. Current
code failed to re-dirty a node when the tree-log tree's depth >=
2. This leads to a transaction abort with -EAGAIN.

Fix the issue by properly re-dirty a node on walking up the tree.

Link: https://github.com/kdave/btrfs-progs/issues/415
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de79e15a7c6a..a42e132f35f5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2890,6 +2890,8 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 						     path->nodes[*level]->len);
 					if (ret)
 						return ret;
+					btrfs_redirty_list_add(trans->transaction,
+							       next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -2970,6 +2972,8 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 						next->start, next->len);
 				if (ret)
 					goto out;
+				btrfs_redirty_list_add(trans->transaction,
+						       next);
 			} else {
 				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 					clear_extent_buffer_dirty(next);
@@ -3420,8 +3424,6 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	extent_io_tree_release(&log->log_csum_range);
 
-	if (trans && log->node)
-		btrfs_redirty_list_add(trans->transaction, log->node);
 	btrfs_put_root(log);
 }
 
-- 
2.34.1

