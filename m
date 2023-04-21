Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5274E6EA4D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjDUHcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 03:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDUHcF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 03:32:05 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24893E2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 00:31:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51b661097bfso1496844a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1682062299; x=1684654299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eA5TIkTB3l1lA9exdZYKr9gLIDUuEaCwFLyUS9Qhkrs=;
        b=MQcjR7ifbUIgh4OpctVFpfGvhoDzzXYW25+4HT3yjAqCoeS+0QHHRgfA21w+IyYwoh
         RFMNCWkNpzjtGAC/LsU7Jcv4CZbD5Nlhv3atKhEjmDxN8dybVwO1TZQ/g2sgTCAnBcLn
         TTuv9dyxBSgMN6VPvo3lLiLSMxegnnNcv/k1KkbyUFqUphytpyLQ4akeMQ4C0VOkJ3zZ
         0iT+2h8anWvmbKcfweX9t1Zs14Dd5SxsYO+jFhhJx7146kRjPzTw+mkIBGMSAQ9p8GTp
         WU/2+YLUE7q5BoT5oDfgYrlezU+hBNWPepPMp0Bh16Wk9yOQgz6oodfwMNmrCvmTjcOm
         UiPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1682062299; x=1684654299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eA5TIkTB3l1lA9exdZYKr9gLIDUuEaCwFLyUS9Qhkrs=;
        b=GVm1lL9yYlzlcUG5udzT2rJEMr5GMNYyX7PwCH9jVz8QAjL5xbvXQYww4aR2nMBygv
         bxjWrBFJ/TLn4+Bghc9AD9uPkc65RHvY38XwS5FnuYDgWkxzRRe7eT9LyzxeNtsC9wVK
         euujGLBJ8b3QoZj1kh/3JQ+KpfYSHA/InU9GJpU3goiwDPyVgH/M1DLJB8IiC/ew7Al5
         5aGgnkdPUGwjoj1TuhiGFBKkgC8GNApNQqSuI1bxXHi/bgPrg+Rk3bQtjKut687UU6we
         m0GKSgIG8E+VUJdaXvkYNEG7MPL4dWqv59MwBOq4ukw9Eh7fz6RurRKy6ATF7Ecgskon
         zAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062299; x=1684654299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA5TIkTB3l1lA9exdZYKr9gLIDUuEaCwFLyUS9Qhkrs=;
        b=cNiEb6iAR+lFHB0F8XQLuUOwW1s8xl6MnTy9aWVQ3CRmEpDJmlI/7aq5+l5pXtiEBW
         LJ87FgVP95Pgaas7H8jlkk6Cld7XsNh5VNk2pLDycxzQhjQDqqpQNkSFMCUeUuy/slUD
         mTokbiyFj7hR3cY4dNrBYYVDwbhkl3itktP4wTukXaUrvZjA25w+nbAOcqFQJpHqJIgC
         l3212iiqW9ktxpo7hbEZZUk/hW882a1TknrtbU2Gyk51ogABbp0fGCC1S/m9FlcW41he
         mHGaFJzHb2ZlbZq9QL+IEe732ghdNBQ2WmQy3EjYYjXgA9YROXjAKlrJItsrg6e2jerF
         DMxA==
X-Gm-Message-State: AAQBX9dpHTyfuuXqEuQJZpjb2C0Fz6/mI97xzBlfN1KZnxuk9V4wTWon
        W5sIxBKe1irwmwT6wplmH90jZjvsA9pkzvybA/gMNz2r6RC/0WqbQMF4IvFbK7U5lcxlyvtxr8z
        lVtaKwMWFINngxY4VSG70LTCa6PFyEBllqpL8rcbgLoSiimsBeMKsaZWC8Oz/rGEq2uFqBdAbe7
        DEy8EVI7Gnv3NR
X-Google-Smtp-Source: AKy350YOwyw24y18OTu/4JF6ltm3zu5I597118z56ZJkUb1tSOXRECHetAFuYDnxZVGHO4KbEQ2HzQ==
X-Received: by 2002:a17:903:1309:b0:1a6:eab0:98c2 with SMTP id iy9-20020a170903130900b001a6eab098c2mr3940861plb.21.1682062299473;
        Fri, 21 Apr 2023 00:31:39 -0700 (PDT)
Received: from naota-xeon.. (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id z12-20020a63c04c000000b0050f74d435e6sm2063598pgi.18.2023.04.21.00.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:31:38 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: export bitmap_test_range_all_{set,zero}
Date:   Fri, 21 Apr 2023 16:31:34 +0900
Message-Id: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Naohiro Aota <naohiro.aota@wdc.com>

bitmap_test_range_all_{set,zero} defined in subpage.c are useful for other
components. Move them to misc.h and use them in zoned.c. Also, as
find_next{,_zero}_bit take/return "unsigned long" instead of "unsigned
int", convert the type to "unsigned long".

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/misc.h    | 22 ++++++++++++++++++++++
 fs/btrfs/subpage.c | 22 ----------------------
 fs/btrfs/zoned.c   | 12 ++++++------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 768583a440e1..6f574c291342 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -143,4 +143,26 @@ static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
 	return NULL;
 }
 
+static inline bool bitmap_test_range_all_set(unsigned long *addr, unsigned long start,
+					     unsigned long nbits)
+{
+	unsigned long found_zero;
+
+	found_zero = find_next_zero_bit(addr, start + nbits, start);
+	if (found_zero == start + nbits)
+		return true;
+	return false;
+}
+
+static inline bool bitmap_test_range_all_zero(unsigned long *addr, unsigned long start,
+					      unsigned long nbits)
+{
+	unsigned long found_set;
+
+	found_set = find_next_bit(addr, start + nbits, start);
+	if (found_set == start + nbits)
+		return true;
+	return false;
+}
+
 #endif
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index dd46b978ac2c..045117ca0ddc 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -367,28 +367,6 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		unlock_page(page);
 }
 
-static bool bitmap_test_range_all_set(unsigned long *addr, unsigned int start,
-				      unsigned int nbits)
-{
-	unsigned int found_zero;
-
-	found_zero = find_next_zero_bit(addr, start + nbits, start);
-	if (found_zero == start + nbits)
-		return true;
-	return false;
-}
-
-static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned int start,
-				       unsigned int nbits)
-{
-	unsigned int found_set;
-
-	found_set = find_next_bit(addr, start + nbits, start);
-	if (found_set == start + nbits)
-		return true;
-	return false;
-}
-
 #define subpage_calc_start_bit(fs_info, page, name, start, len)		\
 ({									\
 	unsigned int start_bit;						\
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d51057608fc3..858a59d39b38 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1058,7 +1058,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 
 		/* Check if zones in the region are all empty */
 		if (btrfs_dev_is_sequential(device, pos) &&
-		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
+		    bitmap_test_range_all_set(zinfo->empty_zones, begin, nzones)) {
 			pos += zinfo->zone_size;
 			continue;
 		}
@@ -1157,23 +1157,23 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	const u8 shift = zinfo->zone_size_shift;
 	unsigned long begin = start >> shift;
-	unsigned long end = (start + size) >> shift;
+	unsigned long nbits = size >> shift;
 	u64 pos;
 	int ret;
 
 	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
 	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
 
-	if (end > zinfo->nr_zones)
+	if (begin + nbits > zinfo->nr_zones)
 		return -ERANGE;
 
 	/* All the zones are conventional */
-	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
+	if (bitmap_test_range_all_zero(zinfo->seq_zones, begin, nbits))
 		return 0;
 
 	/* All the zones are sequential and empty */
-	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
-	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
+	if (bitmap_test_range_all_set(zinfo->seq_zones, begin, nbits) &&
+	    bitmap_test_range_all_set(zinfo->seq_zones, begin, nbits))
 		return 0;
 
 	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
-- 
2.40.0

