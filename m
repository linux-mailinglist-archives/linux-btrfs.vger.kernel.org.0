Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7F6E134
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfGSGvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 02:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfGSGvv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 02:51:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82EFDAC8F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 06:51:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: volumes: Add comment for find_free_dev_extent_start()
Date:   Fri, 19 Jul 2019 14:51:42 +0800
Message-Id: <20190719065144.15263-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719065144.15263-1-wqu@suse.com>
References: <20190719065144.15263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 6df9a95e6339 ("Btrfs: make the chunk allocator completely tree lockless")
we search commit root of device tree to avoid deadlock.

This introduced a safety feature, find_free_dev_extent_start() won't
use dev extents which just get freed in current transaction.

This safety feature makes sure we won't allocate new block group using
just freed dev extents to break CoW.

However this feature also makes find_free_dev_extent_start() not
reliable reporting free device space.
Just add such comment to make later viewer careful about this behavior.

This behavior makes one caller, btrfs_can_relocate() unreliable
determining the device free space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b3fae492912d..41811522c4a3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1546,6 +1546,12 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
  * @len is used to store the size of the free space that we find.
  * But if we don't find suitable free space, it is used to store the size of
  * the max free space.
+ *
+ * NOTE: This function will search *commit* root of device tree, and does extra
+ * check to ensure dev extents are not double allocated.
+ * This makes the function safe to allocate dev extents but may not report
+ * correct usable device space, as device extent freed in current transaction
+ * is not reported as avaiable.
  */
 static int find_free_dev_extent_start(struct btrfs_device *device,
 				u64 num_bytes, u64 search_start, u64 *start,
-- 
2.22.0

