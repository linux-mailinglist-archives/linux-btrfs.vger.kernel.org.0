Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAEEDFA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfKDMEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 07:04:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbfKDMEV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 07:04:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BE7DAF7E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2019 12:04:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/7] btrfs-progs: dump-tree/dump-super: Introduce support for skinny bg tree
Date:   Mon,  4 Nov 2019 20:03:58 +0800
Message-Id: <20191104120401.56408-5-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104120401.56408-1-wqu@suse.com>
References: <20191104120401.56408-1-wqu@suse.com>
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
 cmds/inspect-dump-super.c | 3 ++-
 cmds/inspect-dump-tree.c  | 5 +++++
 print-tree.c              | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index fc06488dde32..02afa96054cc 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -227,7 +227,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_BG_TREE)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e5efe2470111..002fd92fdc84 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -152,6 +152,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "QUOTA", BTRFS_QUOTA_TREE_OBJECTID },
 		{ "UUID", BTRFS_UUID_TREE_OBJECTID },
 		{ "FREE_SPACE", BTRFS_FREE_SPACE_TREE_OBJECTID },
+		{ "BG", BTRFS_BLOCK_GROUP_TREE_OBJECTID},
 		{ "TREE_LOG_FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
 		{ "TREE_LOG", BTRFS_TREE_LOG_OBJECTID },
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
@@ -663,6 +664,10 @@ again:
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
index f70ce6844a7e..87c1bf2f40f6 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -656,6 +656,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_EXTENT_CSUM_KEY]		= "EXTENT_CSUM",
 		[BTRFS_EXTENT_DATA_KEY]		= "EXTENT_DATA",
 		[BTRFS_BLOCK_GROUP_ITEM_KEY]	= "BLOCK_GROUP_ITEM",
+		[BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY] = "SKINNY_BLOCK_GROUP_ITEM",
 		[BTRFS_FREE_SPACE_INFO_KEY]	= "FREE_SPACE_INFO",
 		[BTRFS_FREE_SPACE_EXTENT_KEY]	= "FREE_SPACE_EXTENT",
 		[BTRFS_FREE_SPACE_BITMAP_KEY]	= "FREE_SPACE_BITMAP",
@@ -775,6 +776,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
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
2.23.0

