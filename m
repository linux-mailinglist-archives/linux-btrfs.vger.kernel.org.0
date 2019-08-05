Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391EE81857
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 13:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHELp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 07:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727259AbfHELp0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 07:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED357B627
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 11:45:24 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Check for metadata uuid feature in misc-tests/034-metadata-uuid
Date:   Mon,  5 Aug 2019 14:45:22 +0300
Message-Id: <20190805114522.12151-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of checking the kernel version, explicitly check for the
presence of metadata_uuid file in sysfs. This allows the test to be run
on older kernels that might have this feature backported.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/misc-tests/034-metadata-uuid/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tests/034-metadata-uuid/test.sh
index 3ef110cda823..6ac55b1cacfa 100755
--- a/tests/misc-tests/034-metadata-uuid/test.sh
+++ b/tests/misc-tests/034-metadata-uuid/test.sh
@@ -10,8 +10,8 @@ check_prereq btrfs-image
 setup_root_helper
 prepare_test_dev
 
-if ! check_min_kernel_version 5.0; then
-	_not_run "kernel too old, METADATA_UUID support needed"
+if [ ! -f /sys/fs/btrfs/features/metadata_uuid ] ; then
+	_not_run "METADATA_UUID feature not supported"
 fi
 
 read_fsid() {
-- 
2.17.1

