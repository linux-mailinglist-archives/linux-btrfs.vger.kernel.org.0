Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67729140479
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAQHaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 02:30:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:45080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgAQHaK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 02:30:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F4152AC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 07:30:08 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tests/fsck-044: Enable repair test for invalid extent item generation
Date:   Fri, 17 Jan 2020 15:29:59 +0800
Message-Id: <20200117072959.27929-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117072959.27929-1-wqu@suse.com>
References: <20200117072959.27929-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since both original and lowmem mode can repair it, make that test case
to cover both detection and repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../.lowmem_repairable                        |  0
 .../test.sh                                   | 19 -------------------
 2 files changed, 19 deletions(-)
 create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable
 delete mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh

diff --git a/tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable b/tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
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
2.24.1

