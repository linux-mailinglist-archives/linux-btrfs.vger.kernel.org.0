Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA36A5B41D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiIIVyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIIVyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91171F913B
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c9so2212484qkk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ygj/Ssd7esiZwgLTADlJlAelouUW01J649zBXS25LX4=;
        b=Sg/OQoLLNqA1KRbDFfqTpwOknTN1uAjqGBw657TrOjxbiQCXyi+9rIjGAS7YaIVDz3
         QpIKK7g2w0e+k69HOeRWHWPK0BnVsdwAzDZVFFcmwhNQIIVzMHW46pXxwhYmJITIW9+S
         5Z47tx0ek2aQEEguJc0xCUndgEHqBEN31LaXGTmp6ac50dYSA5UsNNN692pp0oGjm6Gp
         0SvBfpTEt3OpoLIG7EzLMyAPvccutIqJVLPmGQeGzw8l3pLZN/rDW/w6yy/mUu8M/7s6
         QIWaaBplzX8rFP0oZUPaUWYOYgHE+ubpLl+6ZqaKBHbi4WImooG6shalEKF7wWlqiRc+
         0R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ygj/Ssd7esiZwgLTADlJlAelouUW01J649zBXS25LX4=;
        b=Yr50bsNeC46KnHABqxK4YpUixhpGDjVJTPOdtDAYIIf326KnQeV47yJ4hBoQ9fHKhB
         waEJyNTkTDBTD9B3aF/f6fElC9RKr6ABWlQWxFkBwZ9VWapvFst3fOgjmKkCI0xbKE+M
         R5wRC9f5rZariDTQdlCIyy+dXbzQ2LL480NHfFa9qB86GboJGzFQ42cQg8CH8BNSkZaZ
         hGC8ylN6/FRQ4M++iPH6ZSUS6XTnslae3AbW3mzMQ6eBhTb/m2oo9jh8NKer8wcVoEY+
         eEgQMPHeU5h41mpqlrkvKf16d2T2WEFMgCooT5PGYpAifR/0hVBX2nU5TsSqVufOcSzT
         nO5g==
X-Gm-Message-State: ACgBeo3G5fZzYmH6boWLia2LGeY/D7kxqtjLhJheY1f54469kTb5G+Qi
        +xUigRbIPJxsa3do1t9EqJOVjxixlXmCaA==
X-Google-Smtp-Source: AA6agR4lLrqbnDzQbZXbJZ3d6Ige+pg3dzwcXT+9QsD+8JrFNkkg57HziWkmU8H3BztF30xQefV8ug==
X-Received: by 2002:a37:9d7:0:b0:6cd:6ccb:a8fc with SMTP id 206-20020a3709d7000000b006cd6ccba8fcmr3491132qkj.92.1662760448380;
        Fri, 09 Sep 2022 14:54:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21-20020a05620a295500b006bb49cfe147sm1751865qkp.84.2022.09.09.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/36] btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c
Date:   Fri,  9 Sep 2022 17:53:25 -0400
Message-Id: <6d50ac3c839be3f77c14eede420352c99f1095bb.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This helper is used by a lot of the core extent_io_tree helpers, so
temporarily export it and move it into extent-io-tree.c in order to make
it straightforward to migrate the helpers in batches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 19 +++++++++++++++++++
 fs/btrfs/extent-io-tree.h | 10 ++++++++++
 fs/btrfs/extent_io.c      | 20 --------------------
 3 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 7b8ac9b3bc55..b38aa46c86a1 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -4,6 +4,7 @@
 #include <trace/events/btrfs.h>
 #include "ctree.h"
 #include "extent-io-tree.h"
+#include "btrfs_inode.h"
 
 static struct kmem_cache *extent_state_cache;
 
@@ -43,6 +44,24 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 		kmem_cache_free(extent_state_cache, state);
 	}
 }
+
+void __btrfs_debug_check_extent_io_range(const char *caller,
+					 struct extent_io_tree *tree, u64 start,
+					 u64 end)
+{
+	struct inode *inode = tree->private_data;
+	u64 isize;
+
+	if (!inode || !is_data_inode(inode))
+		return;
+
+	isize = i_size_read(inode);
+	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
+		btrfs_debug_rl(BTRFS_I(inode)->root->fs_info,
+		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
+			caller, btrfs_ino(BTRFS_I(inode)), isize, start, end);
+	}
+}
 #else
 #define btrfs_leak_debug_add_state(state)		do {} while (0)
 #define btrfs_leak_debug_del_state(state)		do {} while (0)
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 3b63aeca941a..d9c1bb70d76b 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -269,4 +269,14 @@ static inline bool extent_state_in_tree(const struct extent_state *state)
 	return !RB_EMPTY_NODE(&state->rb_node);
 }
 
+#ifdef CONFIG_BTRFS_DEBUG
+void __btrfs_debug_check_extent_io_range(const char *caller,
+					 struct extent_io_tree *tree, u64 start,
+					 u64 end);
+#define btrfs_debug_check_extent_io_range(tree, start, end)		\
+	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
+#else
+#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
+#endif
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ebe36ad40add..8d8a2cf177ac 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -80,29 +80,9 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
-
-#define btrfs_debug_check_extent_io_range(tree, start, end)		\
-	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
-static inline void __btrfs_debug_check_extent_io_range(const char *caller,
-		struct extent_io_tree *tree, u64 start, u64 end)
-{
-	struct inode *inode = tree->private_data;
-	u64 isize;
-
-	if (!inode || !is_data_inode(inode))
-		return;
-
-	isize = i_size_read(inode);
-	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
-		btrfs_debug_rl(BTRFS_I(inode)->root->fs_info,
-		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
-			caller, btrfs_ino(BTRFS_I(inode)), isize, start, end);
-	}
-}
 #else
 #define btrfs_leak_debug_add_eb(eb)			do {} while (0)
 #define btrfs_leak_debug_del_eb(eb)			do {} while (0)
-#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
 struct tree_entry {
-- 
2.26.3

