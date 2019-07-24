Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700CF72727
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 07:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfGXFHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 01:07:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:34380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXFHL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 01:07:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A91ADACCA
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2019 05:07:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: misc-test/034: Avoid debug log populating stdout
Date:   Wed, 24 Jul 2019 13:07:05 +0800
Message-Id: <20190724050705.29313-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When running misc-test/034, we got unexpected log output:
      [TEST/misc]   033-filename-length-limit
      [TEST/misc]   034-metadata-uuid
  Checking btrfstune logic
  Checking dump-super output
  Checking output after fsid change
  Checking for incompat textual representation
  Checking setting fsid back to original
  Testing btrfs-image restore

This is caused by commit 2570cff076b1 ("btrfs-progs: test: cleanup misc-tests/034")
which uses _log facility which also populates stdout.

Revert to echo "$*" >> "$RESULTS" to remove the noise.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 3ef110cda823..3a6771a85a61 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -31,7 +31,7 @@ read_metadata_uuid() {
 check_btrfstune() {
 	local fsid
 
-	_log "Checking btrfstune logic"
+	echo "Checking btrfstune logic" >> "$RESULTS"
 	# test with random uuid
 	run_check $SUDO_HELPER "$TOP/btrfstune" -m "$TEST_DEV"
 
@@ -66,7 +66,7 @@ check_dump_super_output() {
 	local dev_item_match
 	local old_metadata_uuid
 
-	_log "Checking dump-super output"
+	echo "Checking dump-super output" >> "$RESULTS"
 	# assert that metadata/fsid match on non-changed fs
 	fsid=$(read_fsid "$TEST_DEV")
 	metadata_uuid=$(read_metadata_uuid "$TEST_DEV")
@@ -78,7 +78,7 @@ check_dump_super_output() {
 	[ $dev_item_match = "[match]" ] || _fail "dev_item.fsid doesn't match on non-metadata uuid fs"
 
 
-	_log "Checking output after fsid change"
+	echo "Checking output after fsid change" >> "$RESULTS"
 	# change metadatauuid and ensure everything in the output is still correct
 	old_metadata_uuid=$metadata_uuid
 	run_check $SUDO_HELPER "$TOP/btrfstune" -M d88c8333-a652-4476-b225-2e9284eb59f1 "$TEST_DEV"
@@ -91,13 +91,13 @@ check_dump_super_output() {
 	[ "$fsid" = "d88c8333-a652-4476-b225-2e9284eb59f1" ] || _fail "btrfstune metadata_uuid change failed"
 	[ "$old_metadata_uuid" = "$metadata_uuid" ] || _fail "metadata_uuid changed unexpectedly"
 
-	_log "Checking for incompat textual representation"
+	echo "Checking for incompat textual representation" >> "$RESULTS"
 	# check for textual output of the new incompat feature
 	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
 		"$TEST_DEV" | grep -q METADATA_UUID
 	[ $? -eq 0 ] || _fail "Didn't find textual representation of METADATA_UUID feature"
 
-	_log "Checking setting fsid back to original"
+	echo "Checking setting fsid back to original" >> "$RESULTS"
 	# ensure that  setting the fsid back to the original works
 	run_check $SUDO_HELPER "$TOP/btrfstune" -M "$old_metadata_uuid" "$TEST_DEV"
 
@@ -116,7 +116,7 @@ check_image_restore() {
 	local fsid_restored
 	local metadata_uuid_restored
 
-	_log "Testing btrfs-image restore"
+	echo "Testing btrfs-image restore" >> "$RESULTS"
 	run_check_mkfs_test_dev
 	run_check $SUDO_HELPER "$TOP/btrfstune" -m "$TEST_DEV"
 	fsid=$(read_fsid "$TEST_DEV")
-- 
2.22.0

