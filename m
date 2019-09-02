Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BCA4EBC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 06:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfIBE6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 00:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729376AbfIBE57 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 00:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8C0DAF5A
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2019 04:57:56 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: Add test image for valid half-dropped orphan inode
Date:   Mon,  2 Sep 2019 12:57:50 +0800
Message-Id: <20190902045750.17183-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902045750.17183-1-wqu@suse.com>
References: <20190902045750.17183-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs check used to report false alerts on half dropped orphan inodes.
Add test cases to prevent such problem from happening again.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../042-half-dropped-inode/default.raw.xz     | Bin 0 -> 58940 bytes
 .../fsck-tests/042-half-dropped-inode/test.sh |  34 ++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tests/fsck-tests/042-half-dropped-inode/default.raw.xz
 create mode 100755 tests/fsck-tests/042-half-dropped-inode/test.sh

diff --git a/tests/fsck-tests/042-half-dropped-inode/default.raw.xz b/tests/fsck-tests/042-half-dropped-inode/default.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..6170fb35f49870685865bce6daa3becc04bc3501
GIT binary patch
literal 58940
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

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/042-half-dropped-inode/test.sh b/tests/fsck-tests/042-half-dropped-inode/test.sh
new file mode 100755
index 000000000000..1195fa19dd1a
--- /dev/null
+++ b/tests/fsck-tests/042-half-dropped-inode/test.sh
@@ -0,0 +1,34 @@
+#!/bin/bash
+# To check if btrfs check can handle half dropped inodes.
+# Such inodes are orphan inodes going through file items evicting.
+# During that evicting, btrfs won't bother updating the nbytes of the orphan
+# inode as they will soon be removed completely.
+#
+# Btrfs check should be able to recognize such inodes without giving false
+# alerts
+#
+# The way to reproduce the image:
+# - Create a lot of regular file extents for one inode
+#   Using direct IO with small block size is the easiy method
+# - Modify kernel to commit transaction more aggresively
+#   Two locations are needed:
+#   * btrfs_unlink():
+#     To make the ORPHAN item reach disk asap
+#   * btrfs_evict_inode():
+#     Make the btrfs_end_transaction() call after btrfs_trncate_inode_items()
+#     to commit transaction, so we can catch every file item deletion
+# - Setup dm-log-writes
+#   To catch every transaction commit
+# - Delete the inode
+# - Sync the fs
+# - Replay the log
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_check "$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.23.0

