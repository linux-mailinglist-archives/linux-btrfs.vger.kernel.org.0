Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86211FA8CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgFPGcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 02:32:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPGcq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 02:32:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79A23AC85
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 06:32:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs-tests: Add test case to verify the --rootdir size limit
Date:   Tue, 16 Jun 2020 14:32:30 +0800
Message-Id: <20200616063230.90165-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616063230.90165-1-wqu@suse.com>
References: <20200616063230.90165-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test case to ensure we can create a 350M fs with 128M rootdir.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/mkfs-tests/021-rootdir-size/test.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tests/mkfs-tests/021-rootdir-size/test.sh

diff --git a/tests/mkfs-tests/021-rootdir-size/test.sh b/tests/mkfs-tests/021-rootdir-size/test.sh
new file mode 100755
index 000000000000..064476fdc847
--- /dev/null
+++ b/tests/mkfs-tests/021-rootdir-size/test.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# Regression test for mkfs.btrfs --rootdir with DUP data profile and rootdir
+# size near the limit of the device.
+#
+# There is a bug that makes mkfs.btrfs always to create unnecessary SINGLE
+# chunks, which eats up a lot of space and leads to unexpected ENOSPC bugs.
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+prepare_test_dev
+
+tmp=$(mktemp -d --tmpdir btrfs-progs-mkfs.rootdirXXXXXXX)
+
+fallocate -l 128M $tmp/large_file
+
+# We should be able to create the fs with size limit to 2 * (128 + 32 + 8)
+# which is 336M. Here we round it up to 350M.
+run_check "$TOP/mkfs.btrfs" -f --rootdir "$tmp" -d dup -b 350M "$TEST_DEV"
+run_check "$TOP/btrfs" check "$TEST_DEV"
+
+rm -rf -- "$tmp"
-- 
2.27.0

