Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC215B000
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgBLSif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 13:38:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41271 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLSie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 13:38:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so3035447qko.8
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPfgGSMQGxLenU2D9jlEhm3/SLpAcMQoRpHLz2F4+io=;
        b=nh0G5/yK/DO80MtEDqPuCNAgIZJHdNMaIWWkxaApB0atXHxyKmPm7YlV2DBOnJ0zAh
         sztk/6wB4BS/x2Uf8+NiQpgbXzHFbtYgznEyEpsgbKrdb9E/rVUjaJkk1jLnf2oVS881
         1NsC1XZpFyp1RNnwSJE99fR8ikVmkynq9wCRfPc01jNIFAegixSWXkK3qJCDuQdcJUrT
         ClhoKcJhpW/nNTUnP7kdEzxo/3HYXDEwR8uGsRvo9Yb+vDULCsk2T80oaUxF7p2VL1jw
         pPoGG5CGPWYsQSWR9y19CG4ORN9iNZnf5pCUj9Fi97wWDSyQU08upKffwMG7jx6Xf9om
         nVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPfgGSMQGxLenU2D9jlEhm3/SLpAcMQoRpHLz2F4+io=;
        b=HmDG4sk8CykjQvii3g7/942vH78UjSlspbjlA4usLTm7/QYubPhenKNaofsEq3KZyD
         i7mfyfNFazz4aKNTfuUogvPkj/773d+d1k75t3RnCaXc+Z4Nt2Y8Ypyx+kJR7FdlNgUy
         sApao1QkqlYDn3ChnYHFEeCub/f7v7ZiwuAUPxfHqJ6dz/vSeJ29NUTsBIWlEZvYBSlz
         7RI/e6rxRdw2KPnZ8G2EZLVdJJ/GURKOxY7mNIjqQPmcMgDygMToyFkbrtqWiWGjmuJL
         0+At4SPjooQWSDYbi6Uuwb0WI3wWY7XkOPWZkeegk2Jxoqq9koNxfbr+WO+3unyMKW8y
         ofjg==
X-Gm-Message-State: APjAAAXEhxc0w+Rw1I5rgEt/rX8h3qS1Rw4FfwOkhs/qILkXv/LWm5Qy
        Jp379xqIrULgeFfBr686Zq6ti2i7sIY=
X-Google-Smtp-Source: APXvYqxgEoFAuTpzAUGLO65Sia1Dt0yP1lWWcSrxQcYJ/ZW51npZuX0TVAzVE/qMoD//XY3oljdZEQ==
X-Received: by 2002:a05:620a:15f2:: with SMTP id p18mr11055847qkm.181.1581532712934;
        Wed, 12 Feb 2020 10:38:32 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u4sm650786qkh.59.2020.02.12.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 10:38:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use it for safe isize
Date:   Wed, 12 Feb 2020 13:38:31 -0500
Message-Id: <20200212183831.78293-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe noticed a race where we would sometimes get the wrong answer for
the i_disk_size for !NO_HOLES with my patch.  That is because I expected
that find_first_extent_bit() would find the contiguous range, since I'm
only ever setting EXTENT_DIRTY.  However the way set_extent_bit() works
is it'll temporarily split the range, loop around and set our bits, and
then merge the state.  When it loops it drops the tree->lock, so there
is a window where we can have two adjacent states instead of one large
state.  Fix this by walking forward until we find a non-contiguous
state, and set our end_ret to the end of our logically contiguous area.
This fixes the problem without relying on specific behavior from
set_extent_bit().

Fixes: 79ceff7f6e5d ("btrfs: introduce per-inode file extent tree")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Dave, I assume you'll want to fold this in to the referenced patch, if not let
me know and I'll rework the series to include this as a different patch.

 fs/btrfs/extent-io-tree.h |  2 ++
 fs/btrfs/extent_io.c      | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/file-item.c      |  4 ++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 16fd403447eb..cc3037f9765e 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -223,6 +223,8 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  struct extent_state **cached_state);
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
+int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+			       u64 *start_ret, u64 *end_ret, unsigned bits);
 int extent_invalidatepage(struct extent_io_tree *tree,
 			  struct page *page, unsigned long offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d91a48d73e8f..50bbaf1c7cf0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1578,6 +1578,42 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
+/**
+ * find_contiguous_extent_bit: find a contiguous area of bits
+ * @tree - io tree to check
+ * @start - offset to start the search from
+ * @start_ret - the first offset we found with the bits set
+ * @end_ret - the final contiguous range of the bits that were set
+ *
+ * set_extent_bit anc clear_extent_bit can temporarily split contiguous ranges
+ * to set bits appropriately, and then merge them again.  During this time it
+ * will drop the tree->lock, so use this helper if you want to find the actual
+ * contiguous area for given bits.  We will search to the first bit we find, and
+ * then walk down the tree until we find a non-contiguous area.  The area
+ * returned will be the full contiguous area with the bits set.
+ */
+int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+			       u64 *start_ret, u64 *end_ret, unsigned bits)
+{
+	struct extent_state *state;
+	int ret = 1;
+
+	spin_lock(&tree->lock);
+	state = find_first_extent_bit_state(tree, start, bits);
+	if (state) {
+		*start_ret = state->start;
+		*end_ret = state->end;
+		while ((state = next_state(state)) != NULL) {
+			if (state->start > (*end_ret + 1))
+				break;
+			*end_ret = state->end;
+		}
+		ret = 0;
+	}
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
 /**
  * find_first_clear_extent_bit - find the first range that has @bits not set.
  * This range could start before @start.
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a73878051761..6c849e8fd5a1 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -51,8 +51,8 @@ void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_i_size)
 	}
 
 	spin_lock(&BTRFS_I(inode)->lock);
-	ret = find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, 0,
-				    &start, &end, EXTENT_DIRTY, NULL);
+	ret = find_contiguous_extent_bit(&BTRFS_I(inode)->file_extent_tree, 0,
+					 &start, &end, EXTENT_DIRTY);
 	if (!ret && start == 0)
 		i_size = min(i_size, end + 1);
 	else
-- 
2.24.1

