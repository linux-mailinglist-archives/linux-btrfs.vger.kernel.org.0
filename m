Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5981F1C4AD7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEEACu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbgEEACu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 80D93AF01
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 08/11] btrfs-progs: dump-tree/dump-super: Introduce support for skinny bg tree
Date:   Tue,  5 May 2020 08:02:27 +0800
Message-Id: <20200505000230.4454-9-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505000230.4454-1-wqu@suse.com>
References: <20200505000230.4454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a new tree called BLOCK_GROUP_TREE.

The new type (SKINNY_BLOCK_GROUP_ITEM) doesn't has any item, thus no
need to add any extra output.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-super.c | 1 +
 cmds/inspect-dump-tree.c  | 6 ++++++
 print-tree.c              | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f22633b99390..bac50cb59391 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -229,6 +229,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
 	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
+	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_BG_TREE),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 1fdbb9a6b9b1..3a91fbe5ed79 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -151,6 +151,8 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "CHECKSUM", BTRFS_CSUM_TREE_OBJECTID },
 		{ "QUOTA", BTRFS_QUOTA_TREE_OBJECTID },
 		{ "UUID", BTRFS_UUID_TREE_OBJECTID },
+		{ "BG", BTRFS_BLOCK_GROUP_TREE_OBJECTID},
+		{ "BLOCK_GROUP", BTRFS_BLOCK_GROUP_TREE_OBJECTID},
 		{ "FREE_SPACE", BTRFS_FREE_SPACE_TREE_OBJECTID },
 		{ "TREE_LOG_FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
 		{ "TREE_LOG", BTRFS_TREE_LOG_OBJECTID },
@@ -668,6 +670,10 @@ again:
 				if (!skip)
 					printf("free space");
 				break;
+			case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+				if (!skip)
+					printf("block group");
+				break;
 			case BTRFS_MULTIPLE_OBJECTIDS:
 				if (!skip) {
 					printf("multiple");
diff --git a/print-tree.c b/print-tree.c
index 27acadb22205..ea9b35f604d6 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -683,6 +683,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_EXTENT_CSUM_KEY]		= "EXTENT_CSUM",
 		[BTRFS_EXTENT_DATA_KEY]		= "EXTENT_DATA",
 		[BTRFS_BLOCK_GROUP_ITEM_KEY]	= "BLOCK_GROUP_ITEM",
+		[BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY] = "SKINNY_BLOCK_GROUP_ITEM",
 		[BTRFS_FREE_SPACE_INFO_KEY]	= "FREE_SPACE_INFO",
 		[BTRFS_FREE_SPACE_EXTENT_KEY]	= "FREE_SPACE_EXTENT",
 		[BTRFS_FREE_SPACE_BITMAP_KEY]	= "FREE_SPACE_BITMAP",
@@ -802,6 +803,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		fprintf(stream, "FREE_SPACE_TREE");
 		break;
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+		fprintf(stream, "BLOCK_GROUP_TREE");
+		break;
 	case BTRFS_MULTIPLE_OBJECTIDS:
 		fprintf(stream, "MULTIPLE");
 		break;
-- 
2.26.2

