Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E7429B5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 04:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhJLCT1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 22:19:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34726 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLCT1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 22:19:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5ABD71FF22
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634005045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rSplgUAY6/1XPPJNBKSVOka9Oo5ggTCbmwIwjkhb0is=;
        b=JEI4LgtOl4pQrepTH5WYYvRP4gpCskgpuDrjLBXrXPyaT2lYsQIQ7rTYi37e+3wdCIT3Xo
        3XqPl2Ut38XnbDCfWCp0jGgNtBQ6An/6gF6ugM183VeKfguxR7FwdCxK5JqSDKzuytoLPA
        hfGlZbMzQE23o3l+x0pRrhYgERq+NEo=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 71FCEA3B83
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 02:17:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags output
Date:   Tue, 12 Oct 2021 10:17:19 +0800
Message-Id: <20211012021719.18496-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Commit ("btrfs-progs: use raid table for profile names in
print-tree.c") introduced one bug in block group and chunk flags output
and changed the behavior:

	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
		length 8388608 owner 2 stripe_len 65536 type SINGLE
		...
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 itemsize 112
		length 8388608 owner 2 stripe_len 65536 type DUP
		...
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 itemsize 112
		length 268435456 owner 2 stripe_len 65536 type DUP
		...

Note that, the flag string only contains the profile (SINGLE/DUP/etc...)
no type (DATA/METADATA/SYSTEM).

And we have new "SINGLE" string, even that profile has no extra bit to
indicate that.

[CAUSE]
The "SINGLE" part is caused by the raid array which has a name for
SINGLE profile, even it doesn't have corresponding bit.

The missing type string is caused by a code bug:

		strcpy(buf, name);
		while (*tmp) {
			*tmp = toupper(*tmp);
			tmp++;
		}
		strcpy(ret, buf);

The last strcpy() call overrides the existing string in @ret.

[FIX]
- Enhance string handling using strn*()/snprintf()

- Add extra "UKNOWN.0x%llx" output for unknown profiles

- Call proper strncat() to merge type and profile

- Add extra handling for "SINGLE" to keep the old output

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 47 +++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 67b654e6d2d5..39655590272e 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -159,40 +159,51 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 	}
 }
 
-/* Caller should ensure sizeof(*ret)>=21 "DATA|METADATA|RAID10" */
+/* The minimal length for the string buffer of block group/chunk flags */
+#define BG_FLAG_STRING_LEN	64
+
 static void bg_flags_to_str(u64 flags, char *ret)
 {
 	int empty = 1;
+	char profile[BG_FLAG_STRING_LEN] = {};
 	const char *name;
 
+	ret[0] = '\0';
 	if (flags & BTRFS_BLOCK_GROUP_DATA) {
 		empty = 0;
-		strcpy(ret, "DATA");
+		strncpy(ret, "DATA", BG_FLAG_STRING_LEN);
 	}
 	if (flags & BTRFS_BLOCK_GROUP_METADATA) {
 		if (!empty)
-			strcat(ret, "|");
-		strcat(ret, "METADATA");
+			strncat(ret, "|", BG_FLAG_STRING_LEN);
+		strncat(ret, "METADATA", BG_FLAG_STRING_LEN);
 	}
 	if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 		if (!empty)
-			strcat(ret, "|");
-		strcat(ret, "SYSTEM");
+			strncat(ret, "|", BG_FLAG_STRING_LEN);
+		strncat(ret, "SYSTEM", BG_FLAG_STRING_LEN);
 	}
-	strcat(ret, "|");
 	name = btrfs_bg_type_to_raid_name(flags);
 	if (!name) {
-		strcat(ret, "UNKNOWN");
+		snprintf(profile, BG_FLAG_STRING_LEN, "UNKNOWN.0x%llx",
+			 flags & BTRFS_BLOCK_GROUP_PROFILE_MASK);
 	} else {
-		char buf[32];
-		char *tmp = buf;
+		int i;
 
-		strcpy(buf, name);
-		while (*tmp) {
-			*tmp = toupper(*tmp);
-			tmp++;
-		}
-		strcpy(ret, buf);
+		/*
+		 * Special handing for SINGLE profile, we don't output "SINGLE"
+		 * for SINGLE profile, since there is no such bit for it.
+		 * Thus here we only fill @profile if it's not single.
+		 */
+		if (strncmp(name, "single", strlen("single")) != 0)
+			strncpy(profile, name, BG_FLAG_STRING_LEN);
+
+		for (i = 0; i < BG_FLAG_STRING_LEN && profile[i]; i++)
+			profile[i] = toupper(profile[i]);
+	}
+	if (profile[0]) {
+		strncat(ret, "|", BG_FLAG_STRING_LEN);
+		strncat(ret, profile, BG_FLAG_STRING_LEN);
 	}
 }
 
@@ -215,7 +226,7 @@ void print_chunk_item(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 	u16 num_stripes = btrfs_chunk_num_stripes(eb, chunk);
 	int i;
 	u32 chunk_item_size;
-	char chunk_flags_str[32] = {0};
+	char chunk_flags_str[BG_FLAG_STRING_LEN] = {};
 
 	/* The chunk must contain at least one stripe */
 	if (num_stripes < 1) {
@@ -986,7 +997,7 @@ static void print_block_group_item(struct extent_buffer *eb,
 		struct btrfs_block_group_item *bgi)
 {
 	struct btrfs_block_group_item bg_item;
-	char flags_str[256];
+	char flags_str[BG_FLAG_STRING_LEN] = {};
 
 	read_extent_buffer(eb, &bg_item, (unsigned long)bgi, sizeof(bg_item));
 	memset(flags_str, 0, sizeof(flags_str));
-- 
2.33.0

