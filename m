Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464C92D2FA4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgLHQ01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgLHQ00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:26 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B480DC0611CC
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:54 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so16427723qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=HBY2eiOUxu8XZk3IBqldMAM9+Wc6IWRchVeK8PL7UhcxSbDFLSpezVi7Lh0yjyHGkz
         RQ07c/uCcdbhXD71TsLwzPSDvh3ORj3HqTvzIUi1f5p7HgvI+fOpns0bMJAoMdVY8EQy
         gbLZqVF3bbMp1l/vVunmnFl8qt8qIEFU8oHRGgOisVzkgPdiECcAe3hWC5zug2GzP84B
         kNtCmzPKhgApdjX1tFxAGwmJmAw1w2pkCqlIG7OZ8FWugjuKj3QcTDNA9odA+KthzwwN
         ziO97qmwgfH30WWkUacIb/YjVWdqUiIo6jGayzRr2ytvXHm0BreQRoMCZf5wkSF7V2Bc
         y3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=C1QFZE0wHITb21MFGjP+hkRnbf1zWbUP4QbNKEm+uUuwovKANj87L2+p+COcdoDG0o
         LPmYTD0dUW8AL7lLMVoS70mN9M20d2jHYmr8NTfaA0HyOeeoG0VvmTmhUpQ2GCFJi2bd
         qiYUswZawPZOqNGgAN21tGQYssMGJnimh3eYDj1rfjmxmUSX9ofUkcwCafEDw1/s6jrC
         P3fMxFRULdPhv9yDj3eOStVs836HaMCouWTPIORMr7IYbCCYd7OIwaLXkGZMhcija7bA
         /YOlVzXTr2mx0t5aW7fE98Uz9I5rSmxGjmyMQmAh1DGpQybwbUhxS/DPm1ZYdcGkB4nj
         4wdA==
X-Gm-Message-State: AOAM530okfpVkcVqaRTskVeRlmDoE1lLxgtJv6jIcUmXMK2tAxGxz5JX
        nVh3ECOtCgQYPFxpRcrCd9lA5y/ErA852ts+
X-Google-Smtp-Source: ABdhPJzLTqXapQp9oM8zI7LkGBfFG+X8TOEg6xs7Pvp3tkfngVJJF4l9O2m34efgAJuQYmoxKl95WQ==
X-Received: by 2002:a37:9b04:: with SMTP id d4mr6160625qke.408.1607444753631;
        Tue, 08 Dec 2020 08:25:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h1sm12809019qtr.1.2020.12.08.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 50/52] btrfs: print the actual offset in btrfs_root_name
Date:   Tue,  8 Dec 2020 11:23:57 -0500
Message-Id: <d4b4a28432ac9c6db1b91db529a7bbd25a72bfdb.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're supposed to print the root_key.offset in btrfs_root_name in the
case of a reloc root, not the objectid.  Fix this helper to take the key
so we have access to the offset when we need it.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c    |  2 +-
 fs/btrfs/print-tree.c | 10 +++++-----
 fs/btrfs/print-tree.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..0eeadf624dfb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1457,7 +1457,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 		root = list_first_entry(&fs_info->allocated_roots,
 					struct btrfs_root, leak_list);
 		btrfs_err(fs_info, "leaked root %s refcount %d",
-			  btrfs_root_name(root->root_key.objectid, buf),
+			  btrfs_root_name(&root->root_key, buf),
 			  refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
 			btrfs_put_root(root);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index fe5e0026129d..b8137dbf6a3a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -26,22 +26,22 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 };
 
-const char *btrfs_root_name(u64 objectid, char *buf)
+const char *btrfs_root_name(struct btrfs_key *key, char *buf)
 {
 	int i;
 
-	if (objectid == BTRFS_TREE_RELOC_OBJECTID) {
+	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
-			 "TREE_RELOC offset=%llu", objectid);
+			 "TREE_RELOC offset=%llu", key->offset);
 		return buf;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(root_map); i++) {
-		if (root_map[i].id == objectid)
+		if (root_map[i].id == key->objectid)
 			return root_map[i].name;
 	}
 
-	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", objectid);
+	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", key->objectid);
 	return buf;
 }
 
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index 78b99385a503..802628dd1a6e 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -11,6 +11,6 @@
 
 void btrfs_print_leaf(struct extent_buffer *l);
 void btrfs_print_tree(struct extent_buffer *c, bool follow);
-const char *btrfs_root_name(u64 objectid, char *buf);
+const char *btrfs_root_name(struct btrfs_key *key, char *buf);
 
 #endif
-- 
2.26.2

