Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA3123ECC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLRFTI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:08 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54442 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so317742pjb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRe3/RYY3bdTs7wHuyYNDQi7diBg5D8S6FClciXCReg=;
        b=ZRS/cYWsDmsLlR4FVnhcEKIdroo8WPL501fSh9QwtNI6tNHv31O4PksjLUb9ejocQV
         McblabD0wzQrA46nkahi5eEDmQSE2DeIaH9vRIWh9cgOHSXD2kkRQcajltLbNOhFlEwO
         3R+F0lY/MquYfj8om5XbwxyYUPVAI0VIhTxBVCu8ZPKYdVQdqmCm4v/AdVPsTUmPXNv/
         TI1n+nzkUJm4I2ZasOyMIaw7rIvjBNOb00ZTekyW07zNUHObRT+7/SPNVEYH1t+TBisj
         TRfGPA0Ixtbk4KJ9rdnuIedPEwgfGLVsNLesbO3aZ+2YwSUNzMmrnBYQ2yHiMhwUdZV7
         O1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRe3/RYY3bdTs7wHuyYNDQi7diBg5D8S6FClciXCReg=;
        b=OBPFciNwph2XrvLu9sOrL6cZ74QBzJQQHSic4LDxqzTkMwiAYczbQFNc99eB/QDF+a
         oQASHbuhs/2TZfboU/VuBpvo8llnaRaIzoIlsTCfWpcOTzpsFBEOEjOUTJar1rZAEzem
         J8PKX7SnJJ1aacVq1qMJFG67ykYMTtEJkp8Nhioi6yNfuLJNtUik7tsg02jDYiraJREP
         WqYBrynDb4clRX6bEMUCY/2mSMIAC0m5gpkim/bOtbvekcfHraw3xJPV7x68Pr844nAQ
         I2dMmPWDX/Rc0h9m1vo3h1nqdV8qhUSXgbekPbgiJKp5ce9/PCFe+78yns7IRkkn0Q80
         g8KQ==
X-Gm-Message-State: APjAAAVGEgMla/wLOoDqRvX2MWJed3aRZwaRYCVX+ImkbEZ/xGMZJCcd
        Qr3nW5l0N/OExqr/9oIXIFXURy32cfg=
X-Google-Smtp-Source: APXvYqzfLGq80FFyhtlGZ6HFLqcLjqMTGdojYSsZDSK1hraRjyWTxgrxbS7gA3PashsOSq/18TVeUg==
X-Received: by 2002:a17:90a:28a1:: with SMTP id f30mr539899pjd.77.1576646346915;
        Tue, 17 Dec 2019 21:19:06 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:06 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 06/10] btrfs-progs: abstract function btrfs_add_block_group_cache()
Date:   Wed, 18 Dec 2019 13:18:45 +0800
Message-Id: <20191218051849.2587-7-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The new function btrfs_add_block_group_cache() abstracts the old
set_extent_bits and set_state_private operations.

Rename the rb tree version to btrfs_add_block_group_cache_kernel().

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 3f7b82dc88a2..9e681273d4b8 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -164,10 +164,31 @@ err:
 	return 0;
 }
 
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+				       struct btrfs_block_group_cache *cache,
+				       int bits)
+{
+	int ret;
+
+	ret = set_extent_bits(&info->block_group_cache, cache->key.objectid,
+			      cache->key.objectid + cache->key.offset - 1,
+			      bits);
+	if (ret)
+		return ret;
+
+	ret = set_state_private(&info->block_group_cache, cache->key.objectid,
+				(unsigned long)cache);
+	if (ret)
+		clear_extent_bits(&info->block_group_cache, cache->key.objectid,
+				  cache->key.objectid + cache->key.offset - 1,
+				  bits);
+	return ret;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+static int btrfs_add_block_group_cache_kernel(struct btrfs_fs_info *info,
 				struct btrfs_block_group_cache *block_group)
 {
 	struct rb_node **p;
@@ -2764,7 +2785,6 @@ error:
 static int read_one_block_group(struct btrfs_fs_info *fs_info,
 				 struct btrfs_path *path)
 {
-	struct extent_io_tree *block_group_cache = &fs_info->block_group_cache;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_space_info *space_info;
 	struct btrfs_block_group_cache *cache;
@@ -2814,11 +2834,7 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	}
 	cache->space_info = space_info;
 
-	set_extent_bits(block_group_cache, cache->key.objectid,
-			cache->key.objectid + cache->key.offset - 1,
-			bit | EXTENT_LOCKED);
-	set_state_private(block_group_cache, cache->key.objectid,
-			  (unsigned long)cache);
+	btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
 	return 0;
 }
 
@@ -2870,9 +2886,6 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	int ret;
 	int bit = 0;
 	struct btrfs_block_group_cache *cache;
-	struct extent_io_tree *block_group_cache;
-
-	block_group_cache = &fs_info->block_group_cache;
 
 	cache = kzalloc(sizeof(*cache), GFP_NOFS);
 	BUG_ON(!cache);
@@ -2889,13 +2902,8 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	BUG_ON(ret);
 
 	bit = block_group_state_bits(type);
-	ret = set_extent_bits(block_group_cache, chunk_offset,
-			      chunk_offset + size - 1,
-			      bit | EXTENT_LOCKED);
-	BUG_ON(ret);
 
-	ret = set_state_private(block_group_cache, chunk_offset,
-				(unsigned long)cache);
+	ret = btrfs_add_block_group_cache(fs_info, cache, bit | EXTENT_LOCKED);
 	BUG_ON(ret);
 	set_avail_alloc_bits(fs_info, type);
 
@@ -2945,9 +2953,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	int bit;
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	struct btrfs_block_group_cache *cache;
-	struct extent_io_tree *block_group_cache;
 
-	block_group_cache = &fs_info->block_group_cache;
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	group_align = 64 * fs_info->sectorsize;
 
@@ -2991,12 +2997,8 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 					0, &cache->space_info);
 		BUG_ON(ret);
 		set_avail_alloc_bits(fs_info, group_type);
-
-		set_extent_bits(block_group_cache, cur_start,
-				cur_start + group_size - 1,
-				bit | EXTENT_LOCKED);
-		set_state_private(block_group_cache, cur_start,
-				  (unsigned long)cache);
+		btrfs_add_block_group_cache(fs_info, cache,
+					    bit | EXTENT_LOCKED);
 		cur_start += group_size;
 	}
 	/* then insert all the items */
-- 
2.21.0 (Apple Git-122.2)

