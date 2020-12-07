Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E932D12F4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLGOAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgLGOAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:16 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A50C061A55
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:23 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 1so12543645qka.0
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=wukBpBxgqUmmkEZEc07IeVoUOAaWbYQDsisEXYA+VQnT4A1gc3ACB/w+qeUdlKKpUX
         0LWmKK9ougk6w2Ub9aUNbirvApEJLHTPR7mrcWEjMQPfBdZtxP1JbPfCpW0tlWaIL89Z
         5qgzINyQKDyAYSnWtG94Qo2RB4v916tvCU8KTAJTcKplYP7UTHUgIqxis+6rpEGdZckJ
         tmAVh/INJ/ZCmXqHgEYm3d78lS59sqhpEz6BwIjDgzRBvaQaRdzBl/HW5dHd0gJ7r8Ej
         fg/GnalzEXGTqtrp9fmvXKIKvg24zPKcUFcvOGyeUdot5BjszRhHqrSjh1dUFlz4zg5D
         5Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfzjWbCJlAt1M6Gp5Xa+5CFjYIiFZggMzPSt43v5UTI=;
        b=XBB6UpoujFE/G5Q4f2vV0T9HHc+kwl3J7xWJ8HS1R7dzyz7IH2vEYDHcyAGLfwCtZo
         k5hMOS0RrNVUqpSwd5kOabirqG0drPIUy6A9RtuLB2epIY7v+Ph08QSRDLqJYoY8+7sS
         eXURvDPpSqaQ7gRNfXvVCd7TGoajMo0x3QWs45Gip41y8s7RLxWCBLTt0Vn0EhjLNSZs
         kA9HwlyXNPP2o8iLU6cqBB4iwHGormAUZ6LtYs+8UYJrz46zKCSdOIJ6h30asdq4haMs
         ETUIKSX+4gev4QKW7hNwmakBtkFgYT/Mle4kXe+npkN7JGCCFnLz0l6kDJWviBlBC546
         stDA==
X-Gm-Message-State: AOAM532cT5s9JUPRLAheJNygMw7Bq3stUevUfm3Ju6+Z3VOaMvKaePV6
        SSUP27UArhwqbK3R5cUCBJOODdhm1Jd0sara
X-Google-Smtp-Source: ABdhPJxLj+2mp7HRwNCtF8A++uShH/7K5A3tyOvsP7j49XrVGraWZ0v+L7lxCq3BQNeCt5qC3amZvA==
X-Received: by 2002:a37:6403:: with SMTP id y3mr24330078qkb.204.1607349562540;
        Mon, 07 Dec 2020 05:59:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w192sm12308753qka.68.2020.12.07.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 50/52] btrfs: print the actual offset in btrfs_root_name
Date:   Mon,  7 Dec 2020 08:57:42 -0500
Message-Id: <29591a28d71d71a9d06b11988ebdebf6de83c92c.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

