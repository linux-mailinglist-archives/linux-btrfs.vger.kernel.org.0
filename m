Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE22DC3E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgLPQUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgLPQTe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:34 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229EC0617A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:54 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p12so11566582qvj.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=sNBdyy+qzrsaQtJkXIEx3GzMRIvvb67EeiLbgC17Suu3ZEJx1CUngASEI4b8C0UHJa
         rdaz1iTsWVo5y7sA0eFH0m1lZyM9wSsS0yfm3jTLtlOEG8YONS2HhCHOJwklTcnfiztv
         O5fayV8fK4JXHUhGrXgbCUIs0rkgxr48hXpfuK9YboEzJiNZ0Gcc++mMEj1Bsn2jSFUG
         z7GipRcfWgp6FcAFDfgs1CtxMELfCTyrDLvx9uum4V5g3pdlPmQUdfqwbtyaeA1royTL
         LSjAjKEvEAA7lOOhdc1Wk3RyosuMzhTOhapbnMJWLKKBwohJcXtEZsHnI/dfXz63tWqD
         ma0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=UuJvxPk9JCHyivkv4vDs/8Nck5EiZDwRc9GcZuHFjBK9AFK4y8RI0QSb2xSL3VL019
         j+aTPT4tACN08xpzWXZtVAMXtVA8om3opDCLdxL+xh28ah7NdLwx2gLiFrmQ4VdCqW4I
         PI8kNkIfdWdlGE2UaVn5pOv0NkV5+BdXjXl3/pqoFK6PQ5Zfa4soBvPksHB5z5jK5zit
         c9D1pu5u69CeyhQI86qqJoPW9LDOtre+bCMlb3dLIXXH+ova5K+eJaw60IUnkrVDJWwC
         YSHK4aMK5QeIzFfdVG1S1PPjLineKV/ji1WqS1dC1DncsA9490wzQr8b6d3fkbGnmy29
         YB0w==
X-Gm-Message-State: AOAM532UzhgmJ25udkF6bf4kD2DMH/kFQ+C3UNDoQaA065iWpqE6yUSa
        kZXjUHZRBR3xyOq+RDqacVB21/aaeQZIGgnl
X-Google-Smtp-Source: ABdhPJzw0hsgMoDxbxkhzaceEQD4sC+KnZG28aXZ742mYU36RAQozJoLhw/4LlID7K8ZAyaIloC5bQ==
X-Received: by 2002:ad4:4643:: with SMTP id y3mr43891581qvv.3.1608135533074;
        Wed, 16 Dec 2020 08:18:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x6sm1277413qtm.4.2020.12.16.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 2/5] btrfs: print the actual offset in btrfs_root_name
Date:   Wed, 16 Dec 2020 11:18:44 -0500
Message-Id: <563f04c9be75df4f70a2b060802454f13af13cf5.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
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

