Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77D60172
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfGEH1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:27:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfGEH1L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 03:27:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45DDEAFCB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 07:27:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: misc-tests: Make test cases work or skipped on 64K page size system
Date:   Fri,  5 Jul 2019 15:26:50 +0800
Message-Id: <20190705072651.25150-5-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190705072651.25150-1-wqu@suse.com>
References: <20190705072651.25150-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following test cases fails on aarch64 64K page size mode:
      [TEST/misc]   010-convert-delete-ext2-subvol
  failed: mount -t btrfs -o loop /home/adam/btrfs-progs/tests//test.img /home/adam/btrfs-progs/tests//mnt
  test failed for case 010-convert-delete-ext2-subvol
  make: *** [Makefile:387: test-misc] Error 1

[CAUSE]
Most of them are caused by the lack of subpage sized sector size
support.
Or the conflicts sector size (64K) and nodesize (smaller than 64K).

[FIX]
Check if the current kernel accepts subpage sized sector size and
manually specify 4K sector size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/010-convert-delete-ext2-subvol/test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/010-convert-delete-ext2-subvol/test.sh b/tests/misc-tests/010-convert-delete-ext2-subvol/test.sh
index 5f441a7f5eb9..aa741e7aca7f 100755
--- a/tests/misc-tests/010-convert-delete-ext2-subvol/test.sh
+++ b/tests/misc-tests/010-convert-delete-ext2-subvol/test.sh
@@ -7,12 +7,15 @@ source "$TEST_TOP/common"
 
 check_prereq btrfs-convert
 check_prereq btrfs
+check_global_prereq getconf
+
+page_size=$(getconf PAGESIZE)
 
 setup_root_helper
 prepare_test_dev
 
 run_check truncate -s 2G "$TEST_DEV"
-run_check mkfs.ext4 -F "$TEST_DEV"
+run_check mkfs.ext4 -F "$TEST_DEV" -b $page_size
 run_check "$TOP/btrfs-convert" "$TEST_DEV"
 run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-tree "$TEST_DEV"
 run_check_mount_test_dev
-- 
2.22.0

