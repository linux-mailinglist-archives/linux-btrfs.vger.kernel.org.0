Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF32D12D6C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfLaHMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:46476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfLaHMd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 920F3B168
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: fsck-tests: Make sure btrfs check can detect bad extent item generation
Date:   Tue, 31 Dec 2019 15:12:20 +0800
Message-Id: <20191231071220.32935-6-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new image has a bad data extent item generation:

        item 0 key (13631488 EXTENT_ITEM 4096) itemoff 16230 itemsize 53
                refs 1 gen 16384 flags DATA
                extent data backref root FS_TREE objectid 257 offset 0 count 1

Just like what older `btrfs check --init-extent-tree` could cause.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../bad_extent_item_gen.img.xz                | Bin 0 -> 1916 bytes
 .../test.sh                                   |  19 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz
 create mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh

diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz b/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..c3e30313538558384352d4987acef69f56acea2d
GIT binary patch
literal 1916
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
C2dftV

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/test.sh b/tests/fsck-tests/044-invalid-extent-item-generation/test.sh
new file mode 100755
index 00000000..2b88a3c7
--- /dev/null
+++ b/tests/fsck-tests/044-invalid-extent-item-generation/test.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+#
+# Due to a bug in --init-extent-tree option, we may create bad generation
+# number for data extents.
+#
+# This test case will ensure btrfs check can at least detect such problem,
+# just like kernel tree-checker.
+
+source "$TEST_TOP/common"
+
+check_prereq btrfs
+
+check_image() {
+	run_mustfail \
+		"btrfs check failed to detect invalid extent item generation" \
+		"$TOP/btrfs" check "$1"
+}
+
+check_all_images
-- 
2.24.1

