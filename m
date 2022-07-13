Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C313C573438
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiGMKar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiGMKaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:46 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA38E6837
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:44 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C687680025;
        Wed, 13 Jul 2022 06:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708244; bh=UUsWW2H74bRM8CltDA3VrKMB1e9TXdqubzY/rNa+OWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO0udH1CEpk1Jt0j0Ebc+0XGAkOAblmDqZBZW/kpPS4C8myYyX3WqMR0V4M8iluk2
         D0gHSUfI9hmEtyeXF+RdbjWPeReEAVHMMPATp52n/iY1mQ5HpLU5B5Ib1M5vgStkE7
         Mqtqcb6URWgrgM6qhNfDdSuAx0GrZX0FpBW/VituL3xHNR+XCAqxkG6imU0hqWEbpW
         wJZX23Uj9btC7QVpWeOSwL9fnm0Ue3i5y6tYw61uCxnnnCmRlN5JaAYLEdd/fT3r1M
         bpPSH+mTg+PdD7IE+BjQsi3FogY6OcF8dL0quLzWwhsf9e/Ud51n9xUnbUWm261Xnp
         5ATZXfMrdC4wA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 05/23] btrfs: factor out a memcmp for two extent_buffers.
Date:   Wed, 13 Jul 2022 06:29:38 -0400
Message-Id: <1597152cf099a878c604106d3db0200f0aceed09.1657707686.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

Tree log has its own implementation of comparing two extent_buffer's
contents; pull it out and generalize it into extent_io.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |  4 ++++
 fs/btrfs/tree-log.c  | 33 +++++++++++------------------
 3 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 54ed383e7400..754db5fa262b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6853,6 +6853,55 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	return ret;
 }
 
+int memcmp_2_extent_buffers(const struct extent_buffer *eb1,
+			    unsigned long start1,
+			    const struct extent_buffer *eb2,
+			    unsigned long start2, unsigned long len)
+{
+	unsigned long i1, i2;
+	size_t offset1, offset2;
+	char *kaddr1, *kaddr2;
+	int ret = 0;
+
+	if (check_eb_range(eb1, start1, len) ||
+	    check_eb_range(eb2, start2, len))
+		return -EINVAL;
+
+	if (len == 0)
+		return ret;
+
+	i1 = get_eb_page_index(start1);
+	offset1 = get_eb_offset_in_page(eb1, start1);
+	kaddr1 = page_address(eb1->pages[i1]);
+
+	i2 = get_eb_page_index(start2);
+	offset2 = get_eb_offset_in_page(eb2, start2);
+	kaddr2 = page_address(eb2->pages[i2]);
+
+	while (true) {
+		size_t cur;
+
+		cur = min3(len, PAGE_SIZE - offset1, PAGE_SIZE - offset2);
+		ret = memcmp(kaddr1 + offset1, kaddr2 + offset2, cur);
+		if (ret || cur == len)
+			break;
+		len -= cur;
+		offset1 += cur;
+		if (offset1 == PAGE_SIZE) {
+			offset1 = 0;
+			i1++;
+			kaddr1 = page_address(eb1->pages[i1]);
+		}
+		offset2 += cur;
+		if (offset2 == PAGE_SIZE) {
+			offset2 = 0;
+			i2++;
+			kaddr2 = page_address(eb2->pages[i2]);
+		}
+	}
+	return ret;
+}
+
 /*
  * Check that the extent buffer is uptodate.
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a76c6ef74cd3..df0ff1c78998 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -197,6 +197,10 @@ static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
 
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
+int memcmp_2_extent_buffers(const struct extent_buffer *eb1,
+			    unsigned long start1,
+			    const struct extent_buffer *eb2,
+			    unsigned long start2, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start,
 			unsigned long len);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 87a4438b90da..dc4bc6b384d5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -635,11 +635,13 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	u64 start = key->offset;
 	u64 nbytes = 0;
 	struct btrfs_file_extent_item *item;
+	u32 item_size;
 	struct inode *inode = NULL;
 	unsigned long size;
 	int ret = 0;
 
 	item = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
+	item_size = btrfs_item_size(eb, slot);
 	found_type = btrfs_file_extent_type(eb, item);
 
 	if (found_type == BTRFS_FILE_EXTENT_REG ||
@@ -679,29 +681,18 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 	if (ret == 0 &&
 	    (found_type == BTRFS_FILE_EXTENT_REG ||
-	     found_type == BTRFS_FILE_EXTENT_PREALLOC)) {
-		struct btrfs_file_extent_item cmp1;
-		struct btrfs_file_extent_item cmp2;
-		struct btrfs_file_extent_item *existing;
-		struct extent_buffer *leaf;
-
-		leaf = path->nodes[0];
-		existing = btrfs_item_ptr(leaf, path->slots[0],
-					  struct btrfs_file_extent_item);
-
-		read_extent_buffer(eb, &cmp1, (unsigned long)item,
-				   sizeof(cmp1));
-		read_extent_buffer(leaf, &cmp2, (unsigned long)existing,
-				   sizeof(cmp2));
-
+	     found_type == BTRFS_FILE_EXTENT_PREALLOC) &&
+	    btrfs_item_size(path->nodes[0], path->slots[0]) == item_size &&
+	    memcmp_2_extent_buffers(eb, (unsigned long)item, path->nodes[0],
+				    btrfs_item_ptr_offset(path->nodes[0],
+							  path->slots[0]),
+				    item_size) == 0) {
 		/*
 		 * we already have a pointer to this exact extent,
 		 * we don't have to do anything
 		 */
-		if (memcmp(&cmp1, &cmp2, sizeof(cmp1)) == 0) {
-			btrfs_release_path(path);
-			goto out;
-		}
+		btrfs_release_path(path);
+		goto out;
 	}
 	btrfs_release_path(path);
 
@@ -724,13 +715,13 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto update_inode;
 
 		ret = btrfs_insert_empty_item(trans, root, path, key,
-					      sizeof(*item));
+					      item_size);
 		if (ret)
 			goto out;
 		dest_offset = btrfs_item_ptr_offset(path->nodes[0],
 						    path->slots[0]);
 		copy_extent_buffer(path->nodes[0], eb, dest_offset,
-				(unsigned long)item,  sizeof(*item));
+				   (unsigned long)item, item_size);
 
 		ins.objectid = btrfs_file_extent_disk_bytenr(eb, item);
 		ins.offset = btrfs_file_extent_disk_num_bytes(eb, item);
-- 
2.35.1

