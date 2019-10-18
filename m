Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7545DC3C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442537AbfJRLQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 07:16:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfJRLQM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 07:16:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0774CB365;
        Fri, 18 Oct 2019 11:16:10 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/2] btrfs-progs: warn users about the possible dangers of check --repair
Date:   Fri, 18 Oct 2019 13:16:03 +0200
Message-Id: <20191018111604.16463-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The manual page of btrfsck clearly states 'btrfs check --repair' is a
dangerous operation.

Although this warning is in place users do not read the manual page and/or
are used to the behaviour of fsck utilities which repair the filesystem,
and thus potentially cause harm.

Similar to 'btrfs balance' without any filters, add a warning and a
countdown, so users can bail out before eventual corrupting the filesystem
more than it already is.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v1:
- Fix grammar mistakes in warning message
- Skip delay with --force
- Adjust tests to cope with btrfsck --repair --force
---
 check/main.c                                       | 23 ++++++++++++++++------
 tests/cli-tests/007-check-force/test.sh            |  2 --
 tests/fsck-tests/013-extent-tree-rebuild/test.sh   |  2 +-
 tests/fsck-tests/032-corrupted-qgroup/test.sh      |  2 +-
 tests/fuzz-tests/003-multi-check-unmounted/test.sh |  2 +-
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/check/main.c b/check/main.c
index fd05430c1f51..1fecfc37c135 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9970,6 +9970,23 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		exit(1);
 	}
 
+	if (repair && !force) {
+		int delay = 10;
+		printf("WARNING:\n\n");
+		printf("\tDo not use --repair unless you are advised to do so by a developer\n");
+		printf("\tor an experienced user, and then only after having accepted that no\n");
+		printf("\tfsck can successfully repair all types of filesystem corruption. Eg.\n");
+		printf("\tsome software or hardware bugs can fatally damage a volume.\n");
+		printf("\tThe operation will start in %d seconds.\n", delay);
+		printf("\tUse Ctrl-C to stop it.\n");
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+		printf("\nStarting repair.\n");
+	}
+
 	/*
 	 * experimental and dangerous
 	 */
@@ -9998,12 +10015,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			goto err_out;
 		}
 	} else {
-		if (repair) {
-			error("repair and --force is not yet supported");
-			ret = 1;
-			err |= !!ret;
-			goto err_out;
-		}
 		if (ret < 0) {
 			warning(
 "cannot check mount status of %s, the filesystem could be mounted, continuing because of --force",
diff --git a/tests/cli-tests/007-check-force/test.sh b/tests/cli-tests/007-check-force/test.sh
index 317b8cf42f83..6025b8545c52 100755
--- a/tests/cli-tests/007-check-force/test.sh
+++ b/tests/cli-tests/007-check-force/test.sh
@@ -26,7 +26,5 @@ run_mustfail "checking mounted filesystem with --force --repair" \
 run_check_umount_test_dev
 run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 run_check $SUDO_HELPER "$TOP/btrfs" check --force "$TEST_DEV"
-run_mustfail "--force --repair on unmounted filesystem" \
-	$SUDO_HELPER "$TOP/btrfs" check --force --repair "$TEST_DEV"
 
 cleanup_loopdevs
diff --git a/tests/fsck-tests/013-extent-tree-rebuild/test.sh b/tests/fsck-tests/013-extent-tree-rebuild/test.sh
index ac5a406a8b8a..33beb8bf55b4 100755
--- a/tests/fsck-tests/013-extent-tree-rebuild/test.sh
+++ b/tests/fsck-tests/013-extent-tree-rebuild/test.sh
@@ -35,7 +35,7 @@ test_extent_tree_rebuild()
 
 	$SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV" >& /dev/null && \
 			_fail "btrfs check should detect failure"
-	run_check $SUDO_HELPER "$TOP/btrfs" check --repair --init-extent-tree "$TEST_DEV"
+	run_check $SUDO_HELPER "$TOP/btrfs" check --repair --force --init-extent-tree "$TEST_DEV"
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 }
 
diff --git a/tests/fsck-tests/032-corrupted-qgroup/test.sh b/tests/fsck-tests/032-corrupted-qgroup/test.sh
index 4bfa36013e81..91bbd51a4ebd 100755
--- a/tests/fsck-tests/032-corrupted-qgroup/test.sh
+++ b/tests/fsck-tests/032-corrupted-qgroup/test.sh
@@ -13,7 +13,7 @@ check_image() {
 		     "$TOP/btrfs" check "$1"
 	# Above command can fail due to other bugs, so add extra check to
 	# ensure we can fix qgroup without problems.
-	run_check "$TOP/btrfs" check --repair "$1"
+	run_check "$TOP/btrfs" check --repair --force "$1"
 }
 
 check_all_images
diff --git a/tests/fuzz-tests/003-multi-check-unmounted/test.sh b/tests/fuzz-tests/003-multi-check-unmounted/test.sh
index 3021c3a84968..176272e508d7 100755
--- a/tests/fuzz-tests/003-multi-check-unmounted/test.sh
+++ b/tests/fuzz-tests/003-multi-check-unmounted/test.sh
@@ -18,7 +18,7 @@ check_image() {
 	run_mayfail $TOP/btrfs check --init-extent-tree "$image"
 	run_mayfail $TOP/btrfs check --check-data-csum "$image"
 	run_mayfail $TOP/btrfs check --subvol-extents "$image"
-	run_mayfail $TOP/btrfs check --repair "$image"
+	run_mayfail $TOP/btrfs check --repair --force "$image"
 }
 
 check_all_images "$TEST_TOP/fuzz-tests/images"
-- 
2.16.4

