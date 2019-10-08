Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C81CF1F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJHEtq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729686AbfJHEtq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D91B0AF61
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs-progs: dump-tree/dump-super: Introduce support for bg tree
Date:   Tue,  8 Oct 2019 12:49:34 +0800
Message-Id: <20191008044936.157873-6-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044936.157873-1-wqu@suse.com>
References: <20191008044936.157873-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a new tree called BLOCK_GROUP_TREE.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/inspect-dump-super.c | 3 ++-
 cmds/inspect-dump-tree.c  | 5 +++++
 print-tree.c              | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 65fb3506eac6..414d9c2317d8 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -229,7 +229,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
 	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
-	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID)
+	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
+	DEF_INCOMPAT_FLAG_ENTRY(BG_TREE)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e50130a4a161..def5bea39a2b 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -150,6 +150,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "CSUM", BTRFS_CSUM_TREE_OBJECTID },
 		{ "CHECKSUM", BTRFS_CSUM_TREE_OBJECTID },
 		{ "QUOTA", BTRFS_QUOTA_TREE_OBJECTID },
+		{ "BG", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
 		{ "UUID", BTRFS_UUID_TREE_OBJECTID },
 		{ "FREE_SPACE", BTRFS_FREE_SPACE_TREE_OBJECTID },
 		{ "TREE_LOG_FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
@@ -661,6 +662,10 @@ again:
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
index e079f1a971d3..e2a43226ff87 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -770,6 +770,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
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

