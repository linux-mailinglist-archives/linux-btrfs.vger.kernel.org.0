Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E5225FA9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGTMvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 08:51:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:44130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgGTMvV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 08:51:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F460AD1B
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jul 2020 12:51:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: convert-tests: Add test case for multiply overflow
Date:   Mon, 20 Jul 2020 20:51:09 +0800
Message-Id: <20200720125109.93970-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720125109.93970-1-wqu@suse.com>
References: <20200720125109.93970-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new test case will test whether btrfs-convert can handle 64G ext*
fs.

This exercise the cctx->total_bytes calculation where multiplying 4K
(unsigned int) and 16777216 (u32) could lead to bit overflow for
unsigned int and got 0, and screw up later free space calculation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../018-fs-size-overflow/test.sh              | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tests/convert-tests/018-fs-size-overflow/test.sh

diff --git a/tests/convert-tests/018-fs-size-overflow/test.sh b/tests/convert-tests/018-fs-size-overflow/test.sh
new file mode 100755
index 000000000000..2335225445f8
--- /dev/null
+++ b/tests/convert-tests/018-fs-size-overflow/test.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# Check if btrfs-convert can handle an ext4 fs whose size is 64G.
+# That fs size could trigger a multiply overflow and screw up free space
+# calculation
+
+source "$TEST_TOP/common"
+source "$TEST_TOP/common.convert"
+
+setup_root_helper
+prepare_test_dev
+check_prereq btrfs-convert
+check_global_prereq mke2fs
+check_global_prereq truncate
+
+truncate -s 64g $TEST_DEV
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check_umount_test_dev
+
+# Unpatched btrfs-convert would fail half way due to corrupted free space
+# cache tree
+convert_test_do_convert
-- 
2.27.0

