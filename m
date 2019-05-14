Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67FCC1C95A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfENNZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 09:25:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfENNZh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 09:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D6F0AD4F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 13:25:36 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 1/3] btrfs-progs: factor out super_block reading from load_and_dump_sb
Date:   Tue, 14 May 2019 15:25:30 +0200
Message-Id: <20190514132532.16934-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190514132532.16934-1-jthumshirn@suse.de>
References: <20190514132532.16934-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

inspect-internal dump-superblock's load_and_dump_sb() already reads a
super block from a file descriptor and places it into a 'struct
btrfs_super_block'.

For inspect-internal dump-csum we need this super block as well but don't
care about printing it.

Separate the read from the dump phase so we can re-use it elsewhere.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 cmds-inspect-dump-super.c | 15 ++++++---------
 utils.c                   | 15 +++++++++++++++
 utils.h                   |  2 ++
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
index 7815c863f2ed..879f979f526a 100644
--- a/cmds-inspect-dump-super.c
+++ b/cmds-inspect-dump-super.c
@@ -477,16 +477,13 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		int force)
 {
-	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
-	struct btrfs_super_block *sb;
+	struct btrfs_super_block sb;
 	u64 ret;
 
-	sb = (struct btrfs_super_block *)super_block_data;
-
-	ret = pread64(fd, super_block_data, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
-	if (ret != BTRFS_SUPER_INFO_SIZE) {
+	ret = load_sb(fd, sb_bytenr, &sb);
+	if (ret) {
 		/* check if the disk if too short for further superblock */
-		if (ret == 0 && errno == 0)
+		if (ret == -ENOSPC)
 			return 0;
 
 		error("failed to read the superblock on %s at %llu",
@@ -496,11 +493,11 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 	}
 	printf("superblock: bytenr=%llu, device=%s\n", sb_bytenr, filename);
 	printf("---------------------------------------------------------\n");
-	if (btrfs_super_magic(sb) != BTRFS_MAGIC && !force) {
+	if (btrfs_super_magic(&sb) != BTRFS_MAGIC && !force) {
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
 	} else {
-		dump_superblock(sb, full);
+		dump_superblock(&sb, full);
 	}
 	return 0;
 }
diff --git a/utils.c b/utils.c
index 9e26c884cc6c..04908b174708 100644
--- a/utils.c
+++ b/utils.c
@@ -2593,3 +2593,18 @@ void print_all_devices(struct list_head *devices)
 		print_device_info(dev, "\t");
 	printf("\n");
 }
+
+int load_sb(int fd, u64 bytenr, struct btrfs_super_block *sb)
+{
+	size_t size = sizeof(sizeof(struct btrfs_super_block));
+	int ret;
+
+	ret = pread64(fd, sb, size, bytenr);
+	if (ret != size) {
+		if (ret == 0 && errno == 0)
+			return -EINVAL;
+
+		return -errno;
+	}
+	return 0;
+}
diff --git a/utils.h b/utils.h
index 7c5eb798557d..f0b9ec372893 100644
--- a/utils.h
+++ b/utils.h
@@ -171,6 +171,8 @@ unsigned long total_memory(void);
 void print_device_info(struct btrfs_device *device, char *prefix);
 void print_all_devices(struct list_head *devices);
 
+int load_sb(int fd, u64 bytenr, struct btrfs_super_block *sb);
+
 /*
  * Global program state, configurable by command line and available to
  * functions without extra context passing.
-- 
2.16.4

