Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91424EAAEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiC2KEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiC2KEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 06:04:23 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568F51E4F
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 03:02:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.41.212])
        by synology.com (Postfix) with ESMTPA id 5A9C613726867;
        Tue, 29 Mar 2022 18:02:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1648548157; bh=DGWUdHTgOPEJcyfWpwX+Lxj362wg7DmurSGs+EWNs2g=;
        h=From:To:Cc:Subject:Date;
        b=n2+yOp8VkrTYMoa1wl/Nu4XYMULouG/hl/MgwQhQxdpNU7Y/wuY+GN6Rv8W3WQQWO
         mZ9xFDM/fF8Uw90YhoBX5lHwWc7u3M5amVhye2bXvZk/8euG4yg1NlUhbtw3Lsgizj
         wrTLzzjLOwYPXS+IKl4YQFHdy0oAsdD7E185wNA0=
From:   Kaiwen Hu <kevinhu@synology.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     robbieko@synology.com, cccheng@synology.com, seanding@synology.com,
        Kaiwen Hu <kevinhu@synology.com>
Subject: [PATCH] btrfs: test that we can't delete subvolume within swapfile
Date:   Tue, 29 Mar 2022 18:02:02 +0800
Message-Id: <20220329100201.1502010-1-kevinhu@synology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subvolumes with active swapfiles should be forbidden
to be deleted, because when the subvolume is deleted,
we cannot swapoff the swapfile in the deleted subvolume.

Fixed by the patch
	btrfs: prevent subvol with swapfile from being deleted

Reviewed-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: Kaiwen Hu <kevinhu@synology.com>
---
 tests/btrfs/174     | 10 ++++++++++
 tests/btrfs/174.out |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/tests/btrfs/174 b/tests/btrfs/174
index 3bb5e7f9..08d4af40 100755
--- a/tests/btrfs/174
+++ b/tests/btrfs/174
@@ -11,6 +11,7 @@
 _begin_fstest auto quick swap
 
 . ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _require_scratch_swapfile
@@ -43,7 +44,16 @@ echo "Defrag"
 # fragmented.
 $BTRFS_UTIL_PROG filesystem defrag -c "$swapfile" 2>&1 | grep -o "Text file busy"
 
+# We cannot delete sub-volume when the sub-volume contains active swapfile.
+echo "Delete subvol"
+$BTRFS_UTIL_PROG subvolume delete "$SCRATCH_MNT/swapvol" \
+	2>&1 | grep -o "Text file busy"
+
 swapoff "$swapfile"
+
+# Delete the sub-volume
+$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/swapvol | _filter_btrfs_subvol_delete
+
 _scratch_unmount
 
 status=0
diff --git a/tests/btrfs/174.out b/tests/btrfs/174.out
index 15bdf79e..8bed461b 100644
--- a/tests/btrfs/174.out
+++ b/tests/btrfs/174.out
@@ -8,3 +8,6 @@ Snapshot
 Text file busy
 Defrag
 Text file busy
+Delete subvol
+Text file busy
+Delete subvolume 'SCRATCH_MNT/swapvol'
-- 
2.25.1

