Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57542CDD93
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502105AbgLCSZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502049AbgLCSZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:30 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA92C061A56
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:31 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id es6so1430353qvb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSljPGaRsLpHWZg50kR8ip0EVFRfwHp7Vr2Iqo122ys=;
        b=M6LfSKPWWtr1N2QIxVFWJgIjjlOgt3kVCWXy9KLPWWVxIjGZAz1hsAeH8J4Lw8HBoX
         jsvctu3BiuE2AifUOIGGIveVpDbiL8FibDR5E8XRi8BHFVP1VHhWqZbIiaWDySmsDML7
         gZF1Wn3iE6zGMUBlnBBrLV8p65eAdV2NhEsDPunvwI00GQAwTi56hAVsPAQepuO14/BX
         yOr5nBA6kw8HSyv94RMn/jRz8gWs1caNe6v7TgjPuiGtevEzBQY78+i7TmfLXylWZzo7
         DWYGKtCqWYuPzM1b1TBtE11jzGUqgo8px26KHpKiCvQ+V6GQcLz/bFOOkt7tkl6xEGvp
         DS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSljPGaRsLpHWZg50kR8ip0EVFRfwHp7Vr2Iqo122ys=;
        b=O3hJbqJ0cdZV678BHiHpvmTbJjg3A4bJvnJFBLMk49Q4HTx7OaIDCXjcK9d4qfeVLQ
         LUxVE6sXsMlJ27lPDA/6i2Mon8i5bMNuS1vHLceal28n7Q0YLxC6sG55a4BiqXdNkNYj
         +1LtwGKPu2u5Sfb76qCVVOfZdtE7DFkzKZkFFjFLYvKPUs5QE19DhjGQ04j6aFJUnaUn
         xQ5iNn/01Ms36b+t0M4dE0N+/H9M43NYRUfxceXOYD5jyXNLGn4h06Nll+5UqYrctrFd
         4zhyMx+IDUoJCbcZW8Vu+VZIS2av4s+RwEb8y0CCIczDp0ppMAnwYWMfNeYxrKAVKodi
         VJ2Q==
X-Gm-Message-State: AOAM532jVJztS1CmvIn6yrXjhJ7DJlIDlQjEZmW6/AcZyT+wSqzZrF89
        d/TetJ9hEYHfGMtU8k9exhVtOBAX5ybthytn
X-Google-Smtp-Source: ABdhPJzkT3VlLQwsdtQrsC16W19q8hXv7luYqEc60jL6PfoNhrH1PrNQaSFaynEjDRuDlhM5yefQUw==
X-Received: by 2002:a0c:f4d0:: with SMTP id o16mr143082qvm.43.1607019870133;
        Thu, 03 Dec 2020 10:24:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r125sm2058579qke.129.2020.12.03.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 51/53] btrfs: print the actual offset in btrfs_root_name
Date:   Thu,  3 Dec 2020 13:22:57 -0500
Message-Id: <2c63bd688f02e642f566626a652bdab93b8fc7f4.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index 46dd9e0b077e..c73d172aa1f7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1458,7 +1458,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
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

