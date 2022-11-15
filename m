Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155C629EA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiKOQQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiKOQQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:16:34 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2656B2B1A3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ml12so10130936qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpQbmkn/wCCyPf9qWFkNtTqxqr24ENXVU2K01bgzEQk=;
        b=e3BqAEGvcIa2S6eU2cmM8xsF6MNKgqMLi8Nq951GbXYZBOajT93SLL10Lav+OQcn/z
         hN/l3raK9t4ZFsl+vR792hgOduVZPnQB4J6hp/ItLPhiyb3vvZO3cvFRZ+O0riX5tH7i
         gnfhbpMObTXFhnDm+Nopl/UEwZvtsevKYvMEGzU6m1MfdGMRj30R++T9+Y/wMiusTFlC
         9l8tay0XAVjLMezVPp7fJBmWTng5FIP19+XBYUunmv7WXTFQdTMSqY92ul/8t+k3GikC
         eNDmb9MnrvzAVRO1muW+RdhEGct7IItJJqcCDPD4gHrA4Bho0M48cUaIK9+rYSob6zBK
         km/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpQbmkn/wCCyPf9qWFkNtTqxqr24ENXVU2K01bgzEQk=;
        b=o7p1v9R2Ib309q4CuMGFGELtll0eB2ompXSPPkVWDB3ejOfZwCVZKv/cvA7X54wdUt
         doa0Q3NyCOsuLDOMi1ticdwIUfQE3lMp682aZt5ZrWz6OtkWll6XBRc14zW4tI/+UJJj
         /m35ueaBZM1XUTD89iqhNOMgK0eSUspEjozXtowKjLteRxZp0N952/psEQx/xzjW/gRz
         I7B/x/p0H0RWlZBXjqyor5s6/1vwe0SkAjv30D+olBY2h8IW7XxL5j53ztkaxSokhcva
         mo5HjhO93+iEZElRRKTs7IAAMXrEYiBd7beAudut/bPrSwawOhYt+y9NtuDq3QO4QeM5
         EFDg==
X-Gm-Message-State: ANoB5pneS8h4VzX83wH2/o5mCDgLYkJ/RBMAxxegZ+kybLA0q/CMJu/6
        tNiTEuPlRg69y+AmJ4+c/lVscxVi3n8b7A==
X-Google-Smtp-Source: AA0mqf4pfzc18QS3DUdhBAXAdk07rI7++P1T2bzkYrqNH9mBMxf5dNGkqS0pEy/BYMVgiB4tTB2DQQ==
X-Received: by 2002:a05:6214:1194:b0:4bb:60ef:4acd with SMTP id t20-20020a056214119400b004bb60ef4acdmr17026228qvv.11.1668528988795;
        Tue, 15 Nov 2022 08:16:28 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i1-20020ac860c1000000b00399edda03dfsm7163345qtm.67.2022.11.15.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:16:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/11] btrfs: move eb offset helpers into extent_io.h
Date:   Tue, 15 Nov 2022 11:16:13 -0500
Message-Id: <676fe32c016806b851863320910008146e53ea75.1668526429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526429.git.josef@toxicpanda.com>
References: <cover.1668526429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are very specific to how the extent buffer is defined, so this
differs between btrfs-progs and the kernel.  Make things easier by
moving these helpers into extent_io.h so we don't have to worry about
this when syncing ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h     | 33 ---------------------------------
 fs/btrfs/extent_io.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3870a556f421..c1e9da49ef9b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -685,39 +685,6 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 }
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
 
-/*
- * Get the correct offset inside the page of extent buffer.
- *
- * @eb:		target extent buffer
- * @start:	offset inside the extent buffer
- *
- * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
- */
-static inline size_t get_eb_offset_in_page(const struct extent_buffer *eb,
-					   unsigned long offset)
-{
-	/*
-	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
-	 * to PAGE_SIZE, thus adding it won't cause any difference.
-	 *
-	 * For sectorsize < PAGE_SIZE, we must only read the data that belongs
-	 * to the eb, thus we have to take the eb->start into consideration.
-	 */
-	return offset_in_page(offset + eb->start);
-}
-
-static inline unsigned long get_eb_page_index(unsigned long offset)
-{
-	/*
-	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
-	 *
-	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
-	 * and have ensured that all tree blocks are contained in one page,
-	 * thus we always get index == 0.
-	 */
-	return offset >> PAGE_SHIFT;
-}
-
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 805e262811b4..a024655d4237 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,6 +94,39 @@ struct extent_buffer {
 #endif
 };
 
+/*
+ * Get the correct offset inside the page of extent buffer.
+ *
+ * @eb:		target extent buffer
+ * @start:	offset inside the extent buffer
+ *
+ * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
+ */
+static inline size_t get_eb_offset_in_page(const struct extent_buffer *eb,
+					   unsigned long offset)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
+	 * to PAGE_SIZE, thus adding it won't cause any difference.
+	 *
+	 * For sectorsize < PAGE_SIZE, we must only read the data that belongs
+	 * to the eb, thus we have to take the eb->start into consideration.
+	 */
+	return offset_in_page(offset + eb->start);
+}
+
+static inline unsigned long get_eb_page_index(unsigned long offset)
+{
+	/*
+	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
+	 * and have ensured that all tree blocks are contained in one page,
+	 * thus we always get index == 0.
+	 */
+	return offset >> PAGE_SHIFT;
+}
+
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
-- 
2.26.3

