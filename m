Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B225C8B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgICSaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgICS37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 14:29:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507D1C061245
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 11:29:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 60so2663748qtc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5DI9ksRlYe7oshTLSbphjFSK3c3tqKX4djgAWzzRtOU=;
        b=HkEKVyjKpmb2sdoyZ6czpBs/N41JFqUE91F0yKpuGaH3Q+OJ4cK055KIoCw0A891Q7
         8pGjVA3xZN80jcBg4sqAfwkw2+T37ZyszBHzOnd/4tITR7F+lNwfRZVOIN8iXznH2D1u
         1cRRvxIKNf4fsUx5r5vk8dm7JEEn40Kpw/whdVw6CrGKc7llFgG+3A9CBZvYvOMN/bBy
         Zg7lPPh9qnZbNPrlE2mcxRNsZHJOyOCpSwd3bYmbT/VdeLCd8yBdeeqTl7XDZbebv2Nu
         gJGgX5NDXQch+fMz8emJwWE/Rm3d1Gq7oswm5jq6BtuYn4OLhRi2+ca/LtAsuvJ7zEzz
         ZTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DI9ksRlYe7oshTLSbphjFSK3c3tqKX4djgAWzzRtOU=;
        b=Lo4qQHqgvT7dQXSCvREx7Fi9GjeODsM49W+S+DjIu/SXe1cfvkzV8YUpcqodHNEEgb
         2YQXGTbzIeioPFCmRiVTw48A12nuavWhyp2jQYgeASYsh+9u6LVtMpJfsuHG+5LIrrjs
         LVwlrLK9Ttgr+0lfsLFUx7VPNxcI+75z/4cu1/rcSUywaxhNl4t8ZCcOTziC6S0noZkD
         XrNoOzjVKa4rxKf6c0qLRl5ilLf+xwKKsVgOOoB9f/U84NdkS6NhSXWHl4KDPg5PBuQB
         q09tokRNG/tc1jUEn/60w9HvHlRbUfws5oTCzE6XWM4t59qWSKLUSXmKzlgUe736GJvH
         qOPQ==
X-Gm-Message-State: AOAM532skOj/4T6l9pD/U5Frx8fr++n6A/cVLKWr3z2/yccrVdEsfkjc
        0QKKDM2xwaz7a3cdmXhuDaatoHmOug/JJvFb
X-Google-Smtp-Source: ABdhPJzxAHylTzbZ59VoaBd2CZo2uBcqbhnJLBN3Oxel3T7si9+90tbS6KsAZwSXdGtEJ3cJr+mMoQ==
X-Received: by 2002:aed:310e:: with SMTP id 14mr4965647qtg.122.1599157798249;
        Thu, 03 Sep 2020 11:29:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 64sm2820714qko.117.2020.09.03.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 11:29:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: pretty print leaked root name
Date:   Thu,  3 Sep 2020 14:29:51 -0400
Message-Id: <d749b9482370c5c32d32fb9e8e2a6d4671b19732.1599157686.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1599157686.git.josef@toxicpanda.com>
References: <cover.1599157686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm a actual human being so am incapable of converting u64 to s64 in my
head, so add a helper to get the pretty name of a root objectid and use
that helper to spit out the name for any special roots for leaked roots,
so I don't have to scratch my head and figure out which root I messed up
the refs for.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c    |  6 ++++--
 fs/btrfs/print-tree.c | 39 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/print-tree.h |  3 +++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7147237d9bf0..71beb9493ab4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1504,10 +1504,12 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *root;
 
 	while (!list_empty(&fs_info->allocated_roots)) {
+		char buf[BTRFS_ROOT_NAME_BUF_LEN];
+
 		root = list_first_entry(&fs_info->allocated_roots,
 					struct btrfs_root, leak_list);
-		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
-			  root->root_key.objectid, root->root_key.offset,
+		btrfs_err(fs_info, "leaked root %s refcount %d",
+			  btrfs_root_name(root->root_key.objectid, buf),
 			  refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
 			btrfs_put_root(root);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 80567c11ec12..d0370075a719 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -7,6 +7,45 @@
 #include "disk-io.h"
 #include "print-tree.h"
 
+struct name_map {
+	u64 id;
+	char *name;
+};
+
+static const struct name_map root_map[] = {
+	{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
+	{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
+	{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
+	{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
+	{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
+	{ BTRFS_ROOT_TREE_DIR_OBJECTID,		"ROOT_TREE_DIR"		},
+	{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
+	{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
+	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
+	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
+	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
+	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
+};
+
+char *btrfs_root_name(u64 objectid, char *buf)
+{
+	int i;
+
+	if (objectid == BTRFS_TREE_RELOC_OBJECTID) {
+		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
+			 "TREE_RELOC offset=%llu", objectid);
+		return buf;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(root_map); i++) {
+		if (root_map[i].id == objectid)
+			return root_map[i].name;
+	}
+
+	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", objectid);
+	return buf;
+}
+
 static void print_chunk(struct extent_buffer *eb, struct btrfs_chunk *chunk)
 {
 	int num_stripes = btrfs_chunk_num_stripes(eb, chunk);
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index e6bb38fd75ad..8d07f80cead4 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -6,7 +6,10 @@
 #ifndef BTRFS_PRINT_TREE_H
 #define BTRFS_PRINT_TREE_H
 
+#define BTRFS_ROOT_NAME_BUF_LEN 48
+
 void btrfs_print_leaf(struct extent_buffer *l);
 void btrfs_print_tree(struct extent_buffer *c, bool follow);
+char *btrfs_root_name(u64 objectid, char *buf);
 
 #endif
-- 
2.24.1

