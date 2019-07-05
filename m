Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABB60174
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGEH1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfGEH1O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 03:27:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0A4FAFCB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 07:27:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: convert-tests: Skip tests if kernel doesn't support subpage sized sector size
Date:   Fri,  5 Jul 2019 15:26:51 +0800
Message-Id: <20190705072651.25150-6-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190705072651.25150-1-wqu@suse.com>
References: <20190705072651.25150-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most convert tests needs to mount the converted image, and both reiserfs
and ext* uses 4k block size, on 32K page size system we can't mount them
and will cause test failure.

Skip most of convert tests, except 007-unsupported-block-sizes, which
should fail on all systems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/convert-tests/001-ext2-basic/test.sh                    | 1 +
 tests/convert-tests/002-ext3-basic/test.sh                    | 1 +
 tests/convert-tests/003-ext4-basic/test.sh                    | 1 +
 tests/convert-tests/004-ext2-backup-superblock-ranges/test.sh | 1 +
 tests/convert-tests/005-delete-all-rollback/test.sh           | 1 +
 tests/convert-tests/006-large-hole-extent/test.sh             | 2 ++
 tests/convert-tests/008-readonly-image/test.sh                | 1 +
 tests/convert-tests/009-common-inode-flags/test.sh            | 1 +
 tests/convert-tests/010-reiserfs-basic/test.sh                | 2 ++
 tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh  | 1 +
 tests/convert-tests/012-reiserfs-large-hole-extent/test.sh    | 1 +
 tests/convert-tests/013-reiserfs-common-inode-flags/test.sh   | 1 +
 tests/convert-tests/014-reiserfs-tail-handling/test.sh        | 1 +
 tests/convert-tests/015-no-rollback-after-balance/test.sh     | 1 +
 tests/convert-tests/016-invalid-large-inline-extent/test.sh   | 1 +
 15 files changed, 17 insertions(+)

diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 74cc74e86fe4..94be68bc6b84 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -4,6 +4,7 @@ source "$TEST_TOP/common"
 source "$TEST_TOP/common.convert"
 
 setup_root_helper
+check_prereq_mount_with_sectorsize 4096
 prepare_test_dev
 check_prereq btrfs-convert
 check_global_prereq mke2fs
diff --git a/tests/convert-tests/002-ext3-basic/test.sh b/tests/convert-tests/002-ext3-basic/test.sh
index f08698976c15..57e83681adb7 100755
--- a/tests/convert-tests/002-ext3-basic/test.sh
+++ b/tests/convert-tests/002-ext3-basic/test.sh
@@ -4,6 +4,7 @@ source "$TEST_TOP/common"
 source "$TEST_TOP/common.convert"
 
 setup_root_helper
+check_prereq_mount_with_sectorsize 4096
 prepare_test_dev
 check_prereq btrfs-convert
 check_global_prereq mke2fs
diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index c5caf67c9300..d20d854fc387 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -4,6 +4,7 @@ source "$TEST_TOP/common"
 source "$TEST_TOP/common.convert"
 
 setup_root_helper
+check_prereq_mount_with_sectorsize 4096
 prepare_test_dev
 check_prereq btrfs-convert
 check_global_prereq mke2fs
diff --git a/tests/convert-tests/004-ext2-backup-superblock-ranges/test.sh b/tests/convert-tests/004-ext2-backup-superblock-ranges/test.sh
index 857e240837dc..620374e857d1 100755
--- a/tests/convert-tests/004-ext2-backup-superblock-ranges/test.sh
+++ b/tests/convert-tests/004-ext2-backup-superblock-ranges/test.sh
@@ -14,6 +14,7 @@ source "$TEST_TOP/common"
 
 check_prereq btrfs-convert
 check_prereq btrfs
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq e2fsck
 check_global_prereq xzcat
 
diff --git a/tests/convert-tests/005-delete-all-rollback/test.sh b/tests/convert-tests/005-delete-all-rollback/test.sh
index a5f9d594bfd5..431c642b221d 100755
--- a/tests/convert-tests/005-delete-all-rollback/test.sh
+++ b/tests/convert-tests/005-delete-all-rollback/test.sh
@@ -8,6 +8,7 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mke2fs
 
 # simple wrapper for a convert test
diff --git a/tests/convert-tests/006-large-hole-extent/test.sh b/tests/convert-tests/006-large-hole-extent/test.sh
index a37fcbdc99a6..7a974d74e47f 100755
--- a/tests/convert-tests/006-large-hole-extent/test.sh
+++ b/tests/convert-tests/006-large-hole-extent/test.sh
@@ -11,6 +11,8 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
+prepare_test_dev
 check_global_prereq mke2fs
 
 default_mke2fs="mke2fs -t ext4 -b 4096"
diff --git a/tests/convert-tests/008-readonly-image/test.sh b/tests/convert-tests/008-readonly-image/test.sh
index 1a65ea6b3a19..08d87b0d4433 100755
--- a/tests/convert-tests/008-readonly-image/test.sh
+++ b/tests/convert-tests/008-readonly-image/test.sh
@@ -7,6 +7,7 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mke2fs
 
 default_mke2fs="mke2fs -t ext4 -b 4096"
diff --git a/tests/convert-tests/009-common-inode-flags/test.sh b/tests/convert-tests/009-common-inode-flags/test.sh
index 428213bfcb15..22702af338f7 100755
--- a/tests/convert-tests/009-common-inode-flags/test.sh
+++ b/tests/convert-tests/009-common-inode-flags/test.sh
@@ -7,6 +7,7 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mke2fs
 check_global_prereq lsattr
 check_global_prereq chattr
diff --git a/tests/convert-tests/010-reiserfs-basic/test.sh b/tests/convert-tests/010-reiserfs-basic/test.sh
index 73652991cc6b..7f14956fd853 100755
--- a/tests/convert-tests/010-reiserfs-basic/test.sh
+++ b/tests/convert-tests/010-reiserfs-basic/test.sh
@@ -10,6 +10,8 @@ fi
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
+prepare_test_dev
 check_global_prereq mkreiserfs
 
 for feature in '' 'extref' 'skinny-metadata' 'no-holes'; do
diff --git a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
index 28877e142483..36b3b3888ddb 100755
--- a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
+++ b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
@@ -11,6 +11,7 @@ fi
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mkreiserfs
 
 # simple wrapper for a convert test
diff --git a/tests/convert-tests/012-reiserfs-large-hole-extent/test.sh b/tests/convert-tests/012-reiserfs-large-hole-extent/test.sh
index d492779a386b..55d17cd54bf2 100755
--- a/tests/convert-tests/012-reiserfs-large-hole-extent/test.sh
+++ b/tests/convert-tests/012-reiserfs-large-hole-extent/test.sh
@@ -15,6 +15,7 @@ fi
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mkreiserfs
 
 default_mkfs="mkreiserfs -b 4096"
diff --git a/tests/convert-tests/013-reiserfs-common-inode-flags/test.sh b/tests/convert-tests/013-reiserfs-common-inode-flags/test.sh
index 521e8bd4fba4..cf83b29b4d82 100755
--- a/tests/convert-tests/013-reiserfs-common-inode-flags/test.sh
+++ b/tests/convert-tests/013-reiserfs-common-inode-flags/test.sh
@@ -11,6 +11,7 @@ fi
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mkreiserfs
 check_global_prereq chattr
 check_global_prereq lsattr
diff --git a/tests/convert-tests/014-reiserfs-tail-handling/test.sh b/tests/convert-tests/014-reiserfs-tail-handling/test.sh
index 3be2ed5b6299..a2757f4674d6 100755
--- a/tests/convert-tests/014-reiserfs-tail-handling/test.sh
+++ b/tests/convert-tests/014-reiserfs-tail-handling/test.sh
@@ -16,6 +16,7 @@ fi
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq md5sum
 check_global_prereq mkreiserfs
 
diff --git a/tests/convert-tests/015-no-rollback-after-balance/test.sh b/tests/convert-tests/015-no-rollback-after-balance/test.sh
index 2f6407f3a5f7..155887879aa2 100755
--- a/tests/convert-tests/015-no-rollback-after-balance/test.sh
+++ b/tests/convert-tests/015-no-rollback-after-balance/test.sh
@@ -8,6 +8,7 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mke2fs
 
 # convert_test_prep_fs() will create large enough file inside the test device,
diff --git a/tests/convert-tests/016-invalid-large-inline-extent/test.sh b/tests/convert-tests/016-invalid-large-inline-extent/test.sh
index f37c7c09d2e7..0308dcea13b3 100755
--- a/tests/convert-tests/016-invalid-large-inline-extent/test.sh
+++ b/tests/convert-tests/016-invalid-large-inline-extent/test.sh
@@ -8,6 +8,7 @@ source "$TEST_TOP/common.convert"
 setup_root_helper
 prepare_test_dev
 check_prereq btrfs-convert
+check_prereq_mount_with_sectorsize 4096
 check_global_prereq mke2fs
 
 convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
-- 
2.22.0

