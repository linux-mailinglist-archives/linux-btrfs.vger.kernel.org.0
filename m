Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75492122503
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfLQGsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 01:48:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:53876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLQGsr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 01:48:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2E07ACFA
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 06:48:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Fix bad comment on disk_bytenr of btrfs_file_extent_item
Date:   Tue, 17 Dec 2019 14:48:39 +0800
Message-Id: <20191217064839.5724-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All btrfs_file_extent_item members don't take checksum size into
consideration.

This bad comment looks like from early days where inlined data checksum
(checksum is stored along with data) is being considered.
But the reality is, we never support inlined data checksum since btrfs
is mainlined.

Remove this dead comment, add a new comment explaining how data checksum is
stored, and remove the unnecessary data csum reference.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/uapi/linux/btrfs_tree.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8e322e2c7e78..bfe6f38031a3 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -776,15 +776,16 @@ struct btrfs_file_extent_item {
 	__u8 type;
 
 	/*
-	 * disk space consumed by the extent, checksum blocks are included
-	 * in these numbers
+	 * disk space consumed by the data extent.
+	 * Checksum is stored in csum tree, thus no bytenr/length takes
+	 * csum into consideration.
 	 *
 	 * At this offset in the structure, the inline extent data start.
 	 */
 	__le64 disk_bytenr;
 	__le64 disk_num_bytes;
 	/*
-	 * the logical offset in file blocks (no csums)
+	 * the logical offset in file blocks
 	 * this extent record is for.  This allows a file extent to point
 	 * into the middle of an existing extent on disk, sharing it
 	 * between two snapshots (useful if some bytes in the middle of the
@@ -792,8 +793,8 @@ struct btrfs_file_extent_item {
 	 */
 	__le64 offset;
 	/*
-	 * the logical number of file blocks (no csums included).  This
-	 * always reflects the size uncompressed and without encoding.
+	 * the logical number of file blocks.  This always reflects the size
+	 * uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
 
-- 
2.24.1

