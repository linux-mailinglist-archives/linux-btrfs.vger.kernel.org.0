Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBC95AB944
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIBURM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIBURA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2331CE303
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:57 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y15so2281496qvn.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=ZzcvWi/eDe71X+0jhazlHVz7b/oAGDfCILaIoMWD+vE=;
        b=p7j6NPf6zJerjIM4WJhldVcy1TSJ6x88yl+mKubfx8kO5n3WHL37ZfJjpgVL7mGmv1
         Jmm7jw29hr0ZExwtTcwbgKpfA5s+wBCckUmE3FmZ4u40Mi33O6U8fYq2kQERt+WJBJfc
         AUhtrKOgmwEnAN08u2zDIQQvzz9b61Izsb6i0z8DdfQrAwE8WkJ6Lq7yLQ2uGEGuCZ7S
         tHPB3bOP5hesw3LU3JZ5uIyBgaFP+nPKUH7vuPKIA/C7V1tVC41dFkMPKtI17PE74X/5
         XkENdyuPXBXpaUzp7WxaxmNy7VJ9vm5HIIRc57+8oFQvLb92Dn82wVVFoW7nIao9zboR
         aM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZzcvWi/eDe71X+0jhazlHVz7b/oAGDfCILaIoMWD+vE=;
        b=yS66F7jKRpsTRDsyM5tSwzLrFiHQmH2sEdewpAFRKM1hhEdO0Lo6NV4tAlAuTbR+Gc
         1MIwmme7+M0cCJC0Gaj1BdvH3dqTK5RNHlHmukGOHZKIGbrczZ0zFiZPor+aF5L6Aoc3
         0MWYntyO1sOKRH7mVqEOq2Hkfv8jNYe4pPiT2Y62YVMTU317kChTgwj5fEnUTgwvmaPM
         JcP+hHb2GLnnq2RyJS3KCEoEKSvok8JiUWGtDW38IjNqBp+NMbHAnPIbJUW98S7FKbJS
         smVbktk3RQEgBZAngRXcTkcHN6VSuVMahpk8InE9Ct2mp4tRctGCC1tnuUhyMFHQLN1x
         5rnQ==
X-Gm-Message-State: ACgBeo2NPOXM7AgacL5BYAU8QAcS0nSHE0JcmsqkpmKCubbVdnpFOgAZ
        +5qH+Sc79mXGqm/FyB87h6POA8PxR2Ss8w==
X-Google-Smtp-Source: AA6agR4wmGVh9XfzRWhW+87xisVzbGCSLGmyW7GgQKBLm6pNwJcC+kjLIcrPiqjpSmAlyRXS9RCtIw==
X-Received: by 2002:ad4:5bc7:0:b0:48b:e9ed:47a8 with SMTP id t7-20020ad45bc7000000b0048be9ed47a8mr30616715qvt.108.1662149816453;
        Fri, 02 Sep 2022 13:16:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl28-20020a05620a1a9c00b006bc5cdc890bsm1866755qkb.77.2022.09.02.13.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/31] btrfs: move simple extent bit helpers out of extent_io.c
Date:   Fri,  2 Sep 2022 16:16:15 -0400
Message-Id: <066177b3509944b0af49e1900358b7e9d6b14139.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

These are just variants and wrappers around the actual work horses of
the extent state.  Extract these out of extent_io.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 45 +++++++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h | 20 +++++++++----
 fs/btrfs/extent_io.c      | 60 ---------------------------------------
 3 files changed, 60 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 2aedac452636..7b8ac9b3bc55 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -142,6 +142,51 @@ void free_extent_state(struct extent_state *state)
 	}
 }
 
+/* wrappers around set/clear extent bit */
+int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			   u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * We don't support EXTENT_LOCKED yet, as current changeset will
+	 * record any bits changed, so for EXTENT_LOCKED case, it will
+	 * either fail with -EEXIST or changeset will record the whole
+	 * range.
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
+			      changeset);
+}
+
+int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+		u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * Don't support EXTENT_LOCKED case, same reason as
+	 * set_record_extent_bits().
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
+				  changeset);
+}
+
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
+{
+	int err;
+	u64 failed_start;
+
+	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
+			     &failed_start, NULL, GFP_NOFS, NULL);
+	if (err == -EEXIST) {
+		if (failed_start > start)
+			clear_extent_bit(tree, start, failed_start - 1,
+					 EXTENT_LOCKED, 1, 0, NULL);
+		return 0;
+	}
+	return 1;
+}
+
 void __cold extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 56266e75b4fe..16a9da4149f3 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -120,14 +120,19 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, int filled, struct extent_state *cached_state);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
-int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     u32 bits, int wake, int delete,
-		     struct extent_state **cached);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		     u32 bits, int wake, int delete,
 		     struct extent_state **cached, gfp_t mask,
 		     struct extent_changeset *changeset);
 
+static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				   u64 end, u32 bits, int wake, int delete,
+				   struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, bits, wake, delete,
+				  cached, GFP_NOFS, NULL);
+}
+
 static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 {
 	return clear_extent_bit(tree, start, end, EXTENT_LOCKED, 1, 0, NULL);
@@ -164,8 +169,13 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, unsigned exclusive_bits, u64 *failed_start,
 		   struct extent_state **cached_state, gfp_t mask,
 		   struct extent_changeset *changeset);
-int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits);
+
+static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
+					 u64 end, u32 bits)
+{
+	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
+			      GFP_NOWAIT, NULL);
+}
 
 static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
 		u64 end, u32 bits)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 028dc72d8b6a..b8fdd4aa7583 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1283,50 +1283,6 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return err;
 }
 
-/* wrappers around set/clear extent bit */
-int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits, struct extent_changeset *changeset)
-{
-	/*
-	 * We don't support EXTENT_LOCKED yet, as current changeset will
-	 * record any bits changed, so for EXTENT_LOCKED case, it will
-	 * either fail with -EEXIST or changeset will record the whole
-	 * range.
-	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
-
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
-			      changeset);
-}
-
-int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start, u64 end,
-			   u32 bits)
-{
-	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL,
-			      GFP_NOWAIT, NULL);
-}
-
-int clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		     u32 bits, int wake, int delete,
-		     struct extent_state **cached)
-{
-	return __clear_extent_bit(tree, start, end, bits, wake, delete,
-				  cached, GFP_NOFS, NULL);
-}
-
-int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
-		u32 bits, struct extent_changeset *changeset)
-{
-	/*
-	 * Don't support EXTENT_LOCKED case, same reason as
-	 * set_record_extent_bits().
-	 */
-	ASSERT(!(bits & EXTENT_LOCKED));
-
-	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
-				  changeset);
-}
-
 /*
  * either insert or lock state struct between start and end use mask to tell
  * us if waiting is desired.
@@ -1351,22 +1307,6 @@ int lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	return err;
 }
 
-int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	int err;
-	u64 failed_start;
-
-	err = set_extent_bit(tree, start, end, EXTENT_LOCKED, EXTENT_LOCKED,
-			     &failed_start, NULL, GFP_NOFS, NULL);
-	if (err == -EEXIST) {
-		if (failed_start > start)
-			clear_extent_bit(tree, start, failed_start - 1,
-					 EXTENT_LOCKED, 1, 0, NULL);
-		return 0;
-	}
-	return 1;
-}
-
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	unsigned long index = start >> PAGE_SHIFT;
-- 
2.26.3

