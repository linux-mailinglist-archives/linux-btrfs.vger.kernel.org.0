Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E357FE40
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfHBQJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 12:09:58 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40916 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389837AbfHBQJ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 12:09:57 -0400
Received: by mail-qt1-f179.google.com with SMTP id a15so74391732qtn.7
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Um2Dq4YTpnUq/zxGEKY7CfvdY7uS16Qh1H2nGrJ8QXs=;
        b=Q9zT1ABwTArbAqFNBPYDogOrS13zQNeB2UhvftLH3AURBN+bFWAh3WmVS6Qiuo87lu
         VsNgWtqSNV8peQq/rmIeqHfUSpHg3nlg2SknRXSq1GGBV7izVefjpyVpqpVCpCu9Sbkl
         MTeyKfgQQECiHfoSwegUyR8vRNgRe6bDmfi9Y9tM7DzmGpXn3L0JDAM8AAS/1CwxzVam
         lLLTSd1bOXg0f/Sw9rE7swQYgLxJ00bYSugWv1ryG66omU53V1H26l4cR0dqfELop3vf
         Pqk5ZiVqGZH+0AR9dGkHIXE4nPkbDA97IYIp7cQWzWCxi9ZU+2Fi/unkx7gQh2DWXdGA
         4Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Um2Dq4YTpnUq/zxGEKY7CfvdY7uS16Qh1H2nGrJ8QXs=;
        b=U8cXQ9zWdu4x6hrQGpNOEk2M8zUQgYyKs/pDJZldqDlaJEh52/IkTDhIO2hzqBOzUi
         1ESMOr4m6wptMesGgBY3v8ZV48FGrUjbhrzauttQ4um3MRTNkeNAHap/si9u68zeYQpd
         /kMOYlNFlQ/olb7c+/Uqnwx7fJZvGYhwfXwD/HOl44AViylPEH76UwD1Qc48WaISoAjA
         8gYo7lL9DMCgmnyKmDkPz3FpPslirhumt7jomzpTWkbx6P6lfIipR89t4IJqn4w5mWZ1
         RxyNlClx1ckpclprpWA/IIJgOfXEeZQ9CdODEuCfV+fjgIUNwFDChM3gzaNx5jWsuTFJ
         Pphg==
X-Gm-Message-State: APjAAAUu2hEaDFLPCehvU68k5AX/M6esXj0loRrsHglTtqUUMglkD3l3
        O4447jtX3am2yyfPwIwkmRFu1rWw9uw=
X-Google-Smtp-Source: APXvYqx3sWYFSB08ZCDL7WlnkAADlM1epIwtayy6lWYF0098fHIsGqbolKuhZa2HJhC28AQHLMIV2g==
X-Received: by 2002:a0c:d1f0:: with SMTP id k45mr21098187qvh.69.1564762195727;
        Fri, 02 Aug 2019 09:09:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b23sm44142417qte.19.2019.08.02.09.09.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:09:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs-progs: add a --check-bg-usage option to fsck
Date:   Fri,  2 Aug 2019 12:09:53 -0400
Message-Id: <20190802160953.18312-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes when messing with the chunk allocator code we can end up
over-allocating chunks.  Generally speaking I'll notice this when a
random xfstest fails with ENOSPC when it shouldn't, but I'm super
worried that I won't catch a problem until somebody has a fs completely
filled up with empty block groups.  Add a fsck option to check for too
many empty block groups.  This way I can set FSCK_OPTIONS="-B" to catch
cases where we're too aggressive with the chunk allocator but not so
aggressive that it causes problems in xfstests.

Thankfully this doesn't trip up currently, so this will just keep me
from regressing us.  Thanks,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- tested with my alloc chunk ioctl, realized the chunk checker removes the bg
  recs from the list, so this wasn't actually doing anything.  Moved the check
  so now it properly fails on a bad fs.

 btrfsck.h    |  1 +
 check/main.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/btrfsck.h b/btrfsck.h
index ac7f5d48..5e779075 100644
--- a/btrfsck.h
+++ b/btrfsck.h
@@ -44,6 +44,7 @@ struct block_group_record {
 	u64 offset;
 
 	u64 flags;
+	u64 used;
 };
 
 struct block_group_tree {
diff --git a/check/main.c b/check/main.c
index 0cc6fdba..ca2ace10 100644
--- a/check/main.c
+++ b/check/main.c
@@ -62,6 +62,7 @@ int no_holes = 0;
 static int is_free_space_tree = 0;
 int init_extent_tree = 0;
 int check_data_csum = 0;
+int check_bg_usage = 0;
 struct btrfs_fs_info *global_info;
 struct task_ctx ctx = { 0 };
 struct cache_tree *roots_info_cache = NULL;
@@ -5126,6 +5127,7 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
 
 	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
 	rec->flags = btrfs_disk_block_group_flags(leaf, ptr);
+	rec->used = btrfs_disk_block_group_used(leaf, ptr);
 
 	INIT_LIST_HEAD(&rec->list);
 
@@ -8522,6 +8524,41 @@ out:
 	return ret;
 }
 
+static int check_block_group_usage(struct block_group_tree *block_group_cache)
+{
+	struct block_group_record *bg_rec;
+	int empty_data = 0, empty_metadata = 0, empty_system = 0;
+	int ret = 0;
+
+	list_for_each_entry(bg_rec, &block_group_cache->block_groups, list) {
+		if (bg_rec->used)
+			continue;
+		if (bg_rec->flags & BTRFS_BLOCK_GROUP_DATA)
+			empty_data++;
+		else if (bg_rec->flags & BTRFS_BLOCK_GROUP_METADATA)
+			empty_metadata++;
+		else
+			empty_system++;
+	}
+
+	if (empty_data > 1) {
+		ret = -EINVAL;
+		fprintf(stderr, "Too many empty data block groups: %d\n",
+			empty_data);
+	}
+	if (empty_metadata > 1) {
+		ret = -EINVAL;
+		fprintf(stderr, "Too many empty metadata block groups: %d\n",
+			empty_metadata);
+	}
+	if (empty_system > 1) {
+		ret = -EINVAL;
+		fprintf(stderr, "Too many empty system block groups: %d\n",
+			empty_system);
+	}
+	return ret;
+}
+
 static int check_chunks_and_extents(struct btrfs_fs_info *fs_info)
 {
 	struct rb_root dev_cache;
@@ -8622,6 +8659,13 @@ again:
 		goto out;
 	}
 
+	if (check_bg_usage) {
+		ret = check_block_group_usage(&block_group_cache);
+		if (ret)
+			err = ret;
+		goto out;
+	}
+
 	ret = check_chunks(&chunk_cache, &block_group_cache,
 			   &dev_extent_cache, NULL, NULL, NULL, 0);
 	if (ret) {
@@ -9810,6 +9854,7 @@ static const char * const cmd_check_usage[] = {
 	"       -E|--subvol-extents <subvolid>",
 	"                                   print subvolume extents and sharing state",
 	"       -p|--progress               indicate progress",
+	"       -B|--check-bg-usage         check for too many empty block groups",
 	NULL
 };
 
@@ -9841,7 +9886,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
 			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
 			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
-			GETOPT_VAL_FORCE };
+			GETOPT_VAL_FORCE};
 		static const struct option long_options[] = {
 			{ "super", required_argument, NULL, 's' },
 			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
@@ -9864,10 +9909,11 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "clear-space-cache", required_argument, NULL,
 				GETOPT_VAL_CLEAR_SPACE_CACHE},
 			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
+			{ "check-bg-usage", no_argument, NULL, 'B' },
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "as:br:pEQ", long_options, NULL);
+		c = getopt_long(argc, argv, "as:br:pEQB", long_options, NULL);
 		if (c < 0)
 			break;
 		switch(c) {
@@ -9875,6 +9921,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			case 'b':
 				ctree_flags |= OPEN_CTREE_BACKUP_ROOT;
 				break;
+			case 'B':
+				check_bg_usage = 1;
+				break;
 			case 's':
 				num = arg_strtou64(optarg);
 				if (num >= BTRFS_SUPER_MIRROR_MAX) {
-- 
2.21.0

