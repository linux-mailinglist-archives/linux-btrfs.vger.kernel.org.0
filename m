Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229441462D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 08:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWHpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 02:45:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWHpD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 02:45:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B634AC54
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 07:44:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Add intrudoction to dev-replace.
Date:   Thu, 23 Jan 2020 15:44:50 +0800
Message-Id: <20200123074450.24328-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The overview of btrfs dev-replace is not that complex.
But digging into the code directly can waste some extra time, so add
such introduction to help later guys.

Also, it mentions some corner cases caused by the write duplication and
scrub based data copy, to inform new comers not to get trapped by that
pitfall.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..5889c10ed8d2 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,44 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 
+/*
+ * Introduction for dev-replace.
+ *
+ * [Objective]
+ * To copy all extents (both runtime and on-disk) from source device
+ * to target device, while still keeps the fs RW.
+ *
+ * [Method]
+ * There are two main methods involved:
+ * - Write duplication
+ *   All newer write will to written to both target and source devices.
+ *   So that even replace get canceled, old device is still valid.
+ *
+ *   Location:		handle_ops_on_dev_replace() from __btrfs_map_block()
+ *   Start timing:	btrfs_dev_replace_start()
+ *   End timing:	btrfs_dev_replace_finishing()
+ *   Content:		Latest data/meta
+ *
+ * - Existing extents copy
+ *   This happens by re-using scrub facility, as scrub also iterates through
+ *   exiting extents from commit root.
+ *
+ *   Location:		scrub_write_block_to_dev_replace() from
+ *   			scrub_block_complete()
+ *   Content:		Data/meta from commit root.
+ *
+ * Due to the content difference, we need to avoid nocow write when dev-replace
+ * is happening.
+ * This is done by marking the block group RO and wait for nocow writes.
+ *
+ * After replace is done, the finishing part is done by:
+ * - Swap target and source device
+ *   When the scrub finishes, swap the source device with target device.
+ *
+ *   Location:		btrfs_dev_replace_update_device_in_mapping_tree() from
+ *   			btrfs_dev_replace_finishing()
+ */
+
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
 static void btrfs_dev_replace_update_device_in_mapping_tree(
-- 
2.25.0

