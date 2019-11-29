Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6C10D0C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 05:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfK2EmT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 23:42:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbfK2EmT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 23:42:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD639ACF1
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 04:42:17 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: relocation: Output current relocation stage at btrfs_relocate_block_group()
Date:   Fri, 29 Nov 2019 12:40:59 +0800
Message-Id: <20191129044059.46353-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several reports of hanging relocation, populating the dmesg
with things like:
  BTRFS info (device dm-5): found 1 extents

The investigation is still on going, but will never hurt to output a
little more info.

This patch will also output the current relocation stage, making that
output something like:

  BTRFS info (device dm-5): balance: start -d -m -s
  BTRFS info (device dm-5): relocating block group 30408704 flags metadata|dup
  BTRFS info (device dm-5): found 2 extents, stage: move data extents
  BTRFS info (device dm-5): relocating block group 22020096 flags system|dup
  BTRFS info (device dm-5): found 1 extents, stage: move data extents
  BTRFS info (device dm-5): relocating block group 13631488 flags data
  BTRFS info (device dm-5): found 1 extents, stage: move data extents
  BTRFS info (device dm-5): found 1 extents, stage: update data pointers
  BTRFS info (device dm-5): balance: ended with status: 0

This patch will not increase the number of lines, but with extra info
for us to debug the reported problem.
(Although it's very likely the bug is sticking at "update data pointers"
stage, even without the patch)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Format change
  Put stage string at the end of messages, to keep indent while still
  provide better readability
---
 fs/btrfs/relocation.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..26b605a49449 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4291,6 +4291,15 @@ static void describe_relocation(struct btrfs_fs_info *fs_info,
 		   block_group->start, buf);
 }
 
+static const char *stage_to_string(int stage)
+{
+	if (stage == MOVE_DATA_EXTENTS)
+		return "move data extents";
+	if (stage == UPDATE_DATA_PTRS)
+		return "update data pointers";
+	return "unknown";
+}
+
 /*
  * function to relocate all extents in a block group.
  */
@@ -4365,12 +4374,15 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 				 rc->block_group->length);
 
 	while (1) {
+		int finishes_stage;
+
 		mutex_lock(&fs_info->cleaner_mutex);
 		ret = relocate_block_group(rc);
 		mutex_unlock(&fs_info->cleaner_mutex);
 		if (ret < 0)
 			err = ret;
 
+		finishes_stage = rc->stage;
 		/*
 		 * We may have gotten ENOSPC after we already dirtied some
 		 * extents.  If writeout happens while we're relocating a
@@ -4396,8 +4408,8 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		if (rc->extents_found == 0)
 			break;
 
-		btrfs_info(fs_info, "found %llu extents", rc->extents_found);
-
+		btrfs_info(fs_info, "found %llu extents, stage: %s",
+			   rc->extents_found, stage_to_string(finishes_stage));
 	}
 
 	WARN_ON(rc->block_group->pinned > 0);
-- 
2.24.0

