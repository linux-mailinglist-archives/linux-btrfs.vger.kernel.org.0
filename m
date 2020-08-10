Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A108240280
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHJH2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgHJH2F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:28:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BC4BB57A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 07:28:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: tests/fsck: enhance invalid extent item geneartion test cases
Date:   Mon, 10 Aug 2020 15:27:47 +0800
Message-Id: <20200810072747.64439-5-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810072747.64439-1-wqu@suse.com>
References: <20200810072747.64439-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will:
- Add a new test image for fsck/044
  This new image has a corrupted extent item generation for tree block.
  This image can expose a bug in original mode, which can't detect the
  problem.
  This image also utilize the tree block generation detection code,
  which the existing image doesn't.

- Rename the existing image
  To reflect the fact that the existing one is only for data extent.

- Remove the test.sh
  So that the generic path will test both detection and repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 ...xz => bad_extent_item_gen_for_data.img.xz} | Bin
 .../bad_extent_item_gen_for_tree_block.img.xz | Bin 0 -> 1804 bytes
 .../test.sh                                   |  19 ------------------
 3 files changed, 19 deletions(-)
 rename tests/fsck-tests/044-invalid-extent-item-generation/{bad_extent_item_gen.img.xz => bad_extent_item_gen_for_data.img.xz} (100%)
 create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen_for_tree_block.img.xz
 delete mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh

diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz b/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen_for_data.img.xz
similarity index 100%
rename from tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen.img.xz
rename to tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen_for_data.img.xz
diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen_for_tree_block.img.xz b/tests/fsck-tests/044-invalid-extent-item-generation/bad_extent_item_gen_for_tree_block.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..8bc4688dea9c952282b7124fc53175fe1ebd9c4f
GIT binary patch
literal 1804
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

literal 0
HcmV?d00001

diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/test.sh b/tests/fsck-tests/044-invalid-extent-item-generation/test.sh
deleted file mode 100755
index 2b88a3c7b3bb..000000000000
--- a/tests/fsck-tests/044-invalid-extent-item-generation/test.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-#
-# Due to a bug in --init-extent-tree option, we may create bad generation
-# number for data extents.
-#
-# This test case will ensure btrfs check can at least detect such problem,
-# just like kernel tree-checker.
-
-source "$TEST_TOP/common"
-
-check_prereq btrfs
-
-check_image() {
-	run_mustfail \
-		"btrfs check failed to detect invalid extent item generation" \
-		"$TOP/btrfs" check "$1"
-}
-
-check_all_images
-- 
2.28.0

