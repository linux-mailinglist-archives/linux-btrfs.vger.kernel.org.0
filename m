Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F49A7D7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 10:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIDISF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 04:18:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfIDISF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 04:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A901AED5;
        Wed,  4 Sep 2019 08:18:04 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2] btrfs-progs: fix zstd compression test on a kernel without ztsd support
Date:   Wed,  4 Sep 2019 10:18:02 +0200
Message-Id: <20190904081802.8985-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test-case 'misc-tests/025-zstd-compression' is failing on a kernel or
btrfs binary built without zstd compression support.

Check if zstd compression is supported by either the kernel or the btrfs
binary and if not skip the test-case.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v1:
- Also check $TOP/btrfs not just the kernel for zstd support (Dave)
---
 tests/misc-tests/025-zstd-compression/test.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/misc-tests/025-zstd-compression/test.sh b/tests/misc-tests/025-zstd-compression/test.sh
index 22795d27500e..d967e358fcb2 100755
--- a/tests/misc-tests/025-zstd-compression/test.sh
+++ b/tests/misc-tests/025-zstd-compression/test.sh
@@ -6,6 +6,16 @@ source "$TEST_TOP/common"
 check_prereq btrfs
 check_global_prereq md5sum
 
+if ! [ -f "/sys/fs/btrfs/features/compress_zstd" ]; then
+       _not_run "kernel does not support zstd compression feature"
+       exit
+fi
+
+if ! ldd "$TOP/btrfs" | grep -q zstd; then
+	_not_run "btrfs is not compiled with zstd compression support"
+	exit
+fi
+
 # Extract the test image
 image=$(extract_image compress.raw.xz)
 
-- 
2.16.4

