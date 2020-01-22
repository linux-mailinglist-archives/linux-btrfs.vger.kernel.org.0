Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3C144C68
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 08:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgAVHU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 02:20:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:38252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVHU6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 02:20:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 055D6AF62
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 07:20:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Add intrudoction to dev-replace.
Date:   Wed, 22 Jan 2020 15:20:52 +0800
Message-Id: <20200122072052.11123-1-wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is just a code reading note for dev replace code.

The real problem I'm chasing is the data corruption bug reported by
Filipe.
That bug can be produced by looping btrfs/06[45] btrfs/071 test cases.

The offending commit is b12de52896c0 ("btrfs: scrub: Don't check free
space before marking a block group RO").

While older commit 76a8efa171bf ("btrfs: Continue replace when
set_block_ro failed") also looks suspicious since it allows dev-replace
to happen without even marking the block group RO.

The observed result is, all data corruption happens when data chunks
are not marked RO.
So commit b12de52896c0 is increasing the possibility of a block group
not marked as RO.

But with the protection from write duplication, it shouldn't happen at
all.

Write duplication starts by setting fs_info::dev_replace, then wait for
all existing ordered extents, then commit transaction.
So that all write after btrfs_dev_replace_start() should also happen on
target device.

Although scrub only iterates through commit tree, after
setting fs_info::dev_replace there is no way that any new write won't
reach target device.
Thus no matter whether the block group is marked RO, it should be safe.

Looking for extra ideas.
---
 fs/btrfs/dev-replace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f639dde2a679..a3d8272d9d80 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,37 @@
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
+ *
+ * - Existing extents copy
+ *   This happens by re-using scrub facility, as scrub also iterates through
+ *   exiting extents from commit root.
+ *
+ *   Location:		scrub_write_block_to_dev_replace() from
+ *   			scrub_block_complete()
+ *
+ * After replace is done, the finishing part is done by:
+ * - Swap target and source device
+ *   When the scrub finishes, swap the source device with target device.
+ *
+ *   Location:		btrfs_dev_replace_update_device_in_mapping_tree() from
+ *   			btrfs_dev_replace_finishing()
+ */
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
 static void btrfs_dev_replace_update_device_in_mapping_tree(
-- 
2.25.0

