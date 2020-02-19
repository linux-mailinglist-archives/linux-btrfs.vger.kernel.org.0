Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA22163D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSHEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 02:04:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:54790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgBSHEz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 02:04:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA294ACB1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 07:04:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fsck-tests: Add test image for file extent overflow
Date:   Wed, 19 Feb 2020 15:04:43 +0800
Message-Id: <20200219070443.43189-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219070443.43189-1-wqu@suse.com>
References: <20200219070443.43189-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now it only tests detection.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../045-file-extent-overflow/default.img.xz      | Bin 0 -> 1864 bytes
 .../fsck-tests/045-file-extent-overflow/test.sh  |  15 +++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/fsck-tests/045-file-extent-overflow/default.img.xz
 create mode 100755 tests/fsck-tests/045-file-extent-overflow/test.sh

diff --git a/tests/fsck-tests/045-file-extent-overflow/default.img.xz b/tests/fsck-tests/045-file-extent-overflow/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..ba6bb471e1e455dba6dd73556368fb0dce04f5aa
GIT binary patch
literal 1864
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
Cp_5Di

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/045-file-extent-overflow/test.sh b/tests/fsck-tests/045-file-extent-overflow/test.sh
new file mode 100755
index 000000000000..7a635a490d84
--- /dev/null
+++ b/tests/fsck-tests/045-file-extent-overflow/test.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+#
+# Make sure btrfs check can detect file extent end overflow
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail \
+		"btrfs check failed to detect file extent overflow" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.25.0

