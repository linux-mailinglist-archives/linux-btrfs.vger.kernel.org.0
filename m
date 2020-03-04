Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543ED178B48
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCDH1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 02:27:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgCDH1N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 02:27:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1045DAD78
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 07:27:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: Add test image for overlapping csum item
Date:   Wed,  4 Mar 2020 15:27:01 +0800
Message-Id: <20200304072701.38403-3-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304072701.38403-1-wqu@suse.com>
References: <20200304072701.38403-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image has a csum item overlap with next csum item, make sure btrfs
check can detect it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../overlap_csum_item.img.xz                  | Bin 0 -> 2172 bytes
 .../fsck-tests/045-overlap-csum-item/test.sh  |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/045-overlap-csum-item/overlap_csum_item.img.xz
 create mode 100755 tests/fsck-tests/045-overlap-csum-item/test.sh

diff --git a/tests/fsck-tests/045-overlap-csum-item/overlap_csum_item.img.xz b/tests/fsck-tests/045-overlap-csum-item/overlap_csum_item.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..9bcf152c7c590d4dca915f5d1ecb15fb4a58af84
GIT binary patch
literal 2172
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

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/045-overlap-csum-item/test.sh b/tests/fsck-tests/045-overlap-csum-item/test.sh
new file mode 100755
index 000000000000..06649ed9331c
--- /dev/null
+++ b/tests/fsck-tests/045-overlap-csum-item/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Verify that check can detect overlapped csum items
+#
+# There is one report of overlap csum items, causing tree-checker to reject
+# the csum tree.
+#
+# Make sure btrfs check can at least detect such error
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail "overlapping csum item not detected" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.25.1

