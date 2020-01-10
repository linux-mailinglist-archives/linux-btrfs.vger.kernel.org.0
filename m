Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3493136CF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgAJMXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:23:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:41508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgAJMXi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:23:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA391AEE8;
        Fri, 10 Jan 2020 12:23:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: tests: Extend metadata uuid testcase
Date:   Fri, 10 Jan 2020 14:23:33 +0200
Message-Id: <20200110122333.8272-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds cooked images to exercise the case when a filesystem with
metadata uuid incompat flag is switched back to having fsid/metadata
uuid being equal.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/misc-tests/034-metadata-uuid/disk7.raw.xz | Bin 0 -> 314456 bytes
 tests/misc-tests/034-metadata-uuid/disk8.raw.xz | Bin 0 -> 313708 bytes
 tests/misc-tests/034-metadata-uuid/test.sh      |  25 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk7.raw.xz
 create mode 100644 tests/misc-tests/034-metadata-uuid/disk8.raw.xz

diff --git a/tests/misc-tests/034-metadata-uuid/disk7.raw.xz b/tests/misc-tests/034-metadata-uuid/disk7.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..131d49718de95e9c0212082298e9b5e539c8deea
GIT binary patch
literal 314456
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
T%e|zebv3&R{{63;)x3WJZwDWx

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/034-metadata-uuid/disk8.raw.xz b/tests/misc-tests/034-metadata-uuid/disk8.raw.xz
new file mode 100644
index 0000000000000000000000000000000000000000..993c836eeba1d0139e083d9a334041b93c172afa
GIT binary patch
literal 313708
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

literal 0
HcmV?d00001

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 6ac55b1cacfa..2b7c659998cf 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -155,11 +155,27 @@ check_completed() {
 	[ $? -eq 0 ] || _fail "metadata_uuid not set on $2"
 }
 
+check_flag_cleared() {
+	# Ensure METADATA_UUID is not set. 
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
+		"$1" | grep -q METADATA_UUID
+	[ $? -eq 1 ] || _fail "metadata_uuid not set on $1"
+
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super \
+		"$2" | grep -q METADATA_UUID
+	[ $? -eq 1 ] || _fail "metadata_uuid not set on $2"
+}
+
 check_multi_fsid_change() {
 	check_inprogress_flag "$1" "$2"
 	check_completed "$1" "$2"
 }
 
+check_multi_fsid_unchanged() {
+	check_inprogress_flag "$1" "$2"
+	check_flag_cleared "$1" "$2"
+}
+
 failure_recovery() {
 	local image1
 	local image2
@@ -227,3 +243,12 @@ failure_recovery "./disk4.raw.xz" "./disk3.raw.xz" check_completed
 failure_recovery "./disk5.raw.xz" "./disk6.raw.xz" check_multi_fsid_change
 reload_btrfs
 failure_recovery "./disk6.raw.xz" "./disk5.raw.xz" check_multi_fsid_change
+
+# disk7 contains an image which has undergone a successful fsid change once to 
+# a different value and once back to the original one, disk8 is part of the 
+# same filesystem but in this case it has missed the second transaction commit
+# during the process change. So disk 7 looks as if it never underwent fsid change
+# and disk 8 has FSID_CHANGING_FLAG and METADATA_UUID but is stale. 
+failure_recovery "./disk7.raw.xz" "./disk8.raw.xz" check_multi_fsid_unchanged
+reload_btrfs
+failure_recovery "./disk8.raw.xz" "./disk7.raw.xz" check_multi_fsid_unchanged
-- 
2.7.4

