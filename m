Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B82B9796
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKSQRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 11:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgKSQRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 11:17:08 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BB3C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 08:17:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so5814647qka.11
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Nov 2020 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msVUtOBeTPqQi8nSB0igTPnYwjZ/cIeUtGu2lh21t1k=;
        b=NwYtH8v8XzmD1podmRJ0OlL8WxQMT9G6zg+hM7jkkVr1gq+IJa//YAisoMookv8h8R
         ctpFvFqMKw2jKFNeuOhNOzqVTCY6IxI9NJVpuPBId3SwPUIq82osc1mgWWCOJxDPgPfA
         A0bsFM1ty93MCvDUOFjhm5xqn5ZBVurYmqEkNTX1KFXYEnIIb9oIV9onR/DZ/i3ItSxe
         1qQoV+0CXXDjOsqXsZb6lHK4DfO9xIXbS/V2xsvjxJ9cPuLW7CCWj2Hvuxjb7di2KVqx
         +UNOtC9Ix5Oiikan1AfEj66Lx7PM7vGxzPrRwGs3HN2C/1b97PoVNA7xh4EujgfejRuU
         KKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msVUtOBeTPqQi8nSB0igTPnYwjZ/cIeUtGu2lh21t1k=;
        b=KpHJyJzVYJ6ZDchM66wS5c2EBmfdzEEyS8fXwiI6aQuA6fxa5dIQ+pYnYXatTDXpFX
         fLbpIHxuLYcsNgao9qqJBRmRA0de3OniHH1ZmiuZTla+hCK8gH2au1lyITeKUq+VfA3m
         Ba04smqH6rWJBhQ/VC0NDxmPYFhmPmzFeEkXVtRLVg+jVMu19oAEXApQEcmL28FaF1jb
         6YS5UqoEwzS3Upnkb3zPX4U2c1sULQ6iWUdlPl3ncBEYN3rHA11rdNVip194yIqTgZT8
         fDcz/KGiG3Hg50JXcQLvlNkHiBmQFoXzFUwBtjRAJPyB177ImROqUttBnFFFxIgqK3kV
         PRdg==
X-Gm-Message-State: AOAM530q7+L4Hn9LtSi0hiM9ZxGMUWX7m5QoilzQ6xpW7DR/Q00Z1aA5
        eE7ILLlB98/7DS+Do2orsSiuj0P2LfDV9g==
X-Google-Smtp-Source: ABdhPJzV5xmykIw1t+ltdrQEAKkwoIUGkWnSYsQkuk8b9BL+PJsqqOA95hIQaTTCyDWHf5lccUWg+w==
X-Received: by 2002:a37:6814:: with SMTP id d20mr11407381qkc.445.1605802626607;
        Thu, 19 Nov 2020 08:17:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i15sm144190qke.16.2020.11.19.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:17:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: print the eb flags for nodes as well
Date:   Thu, 19 Nov 2020 11:17:04 -0500
Message-Id: <15066ba6ad8acaff53242f7cc4580874c42ce411.1605802617.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging a corruption problem I realized we don't spit out the
flags for nodes, which is needed when debugging relocation problems so
we know which nodes are the RELOC root items and which are the actual fs
tree's items.  Fix this by unifying the header printing helper so both
leaf's and nodes get the same information printed out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/print-tree.c | 52 ++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 7ab55e29..391c1139 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1196,16 +1196,11 @@ static void header_flags_to_str(u64 flags, char *ret)
 	}
 }
 
-void btrfs_print_leaf(struct extent_buffer *eb)
+static void print_header_info(struct extent_buffer *eb)
 {
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct btrfs_item *item;
-	struct btrfs_disk_key disk_key;
 	char flags_str[128];
-	u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
-	u32 i;
-	u32 nr;
 	u64 flags;
+	u32 nr;
 	u8 backref_rev;
 
 	flags = btrfs_header_flags(eb) & ~BTRFS_BACKREF_REV_MASK;
@@ -1213,17 +1208,38 @@ void btrfs_print_leaf(struct extent_buffer *eb)
 	header_flags_to_str(flags, flags_str);
 	nr = btrfs_header_nritems(eb);
 
-	printf("leaf %llu items %u free space %d generation %llu owner ",
-		(unsigned long long)btrfs_header_bytenr(eb), nr,
-		btrfs_leaf_free_space(eb),
-		(unsigned long long)btrfs_header_generation(eb));
+	if (btrfs_header_level(eb))
+		printf(
+	"node %llu level %d items %u free %u generation %llu owner ",
+		       (unsigned long long)eb->start, btrfs_header_level(eb),
+		       nr, (u32)BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb) - nr,
+		       (unsigned long long)btrfs_header_generation(eb));
+	else
+		printf(
+	"leaf %llu items %u free space %d generation %llu owner ",
+		       (unsigned long long)btrfs_header_bytenr(eb), nr,
+		       btrfs_leaf_free_space(eb),
+		       (unsigned long long)btrfs_header_generation(eb));
 	print_objectid(stdout, btrfs_header_owner(eb), 0);
 	printf("\n");
-	printf("leaf %llu flags 0x%llx(%s) backref revision %d\n",
-		btrfs_header_bytenr(eb), flags, flags_str, backref_rev);
+	printf("%s %llu flags 0x%llx(%s) backref revision %d\n",
+	       btrfs_header_level(eb) ? "node" : "leaf",
+	       btrfs_header_bytenr(eb), flags, flags_str, backref_rev);
 	print_uuids(eb);
 	fflush(stdout);
+}
+
+void btrfs_print_leaf(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_item *item;
+	struct btrfs_disk_key disk_key;
+	u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
+	u32 i;
+	u32 nr;
 
+	print_header_info(eb);
+	nr = btrfs_header_nritems(eb);
 	for (i = 0; i < nr; i++) {
 		u32 item_size;
 		void *ptr;
@@ -1517,15 +1533,7 @@ void btrfs_print_tree(struct extent_buffer *eb, bool follow, int traverse)
 		warning(
 		"node nr_items corrupted, has %u limit %u, continue anyway",
 			nr, BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb));
-	printf("node %llu level %d items %u free %u generation %llu owner ",
-	       (unsigned long long)eb->start,
-	        btrfs_header_level(eb), nr,
-		(u32)BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb) - nr,
-		(unsigned long long)btrfs_header_generation(eb));
-	print_objectid(stdout, btrfs_header_owner(eb), 0);
-	printf("\n");
-	print_uuids(eb);
-	fflush(stdout);
+	print_header_info(eb);
 	ptr_num = BTRFS_NODEPTRS_PER_EXTENT_BUFFER(eb);
 	for (i = 0; i < nr && i < ptr_num; i++) {
 		u64 blocknr = btrfs_node_blockptr(eb, i);
-- 
2.26.2

