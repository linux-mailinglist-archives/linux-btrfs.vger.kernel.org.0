Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9E5B41C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiIIVyJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIVyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DD9CEB26
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a3so808544qto.10
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=swOTGocfH0e7AV6mvXQoxorMuqm1m/bwAmQIkZhRl34=;
        b=oroqkaioo/nwHnYGfsFBy0KLvMLY7ICU2ZyocvhAgAcCAlennkyR9/T9QTSDMClUvV
         OFTFQBEvKaghyuCRBYfJh1Zrl0tuJ/HgdK4Ug164YioDypjoTJ4F7UU9TeN+P2KSX55a
         agqmTLQFMeMHX7050LJwjpIVzYWPW9EL1KUM1wNnu+9aDv0hD6apnnBGiKUpYNcbGen9
         OzoVyXVCtHC1MZ4x1vQxPDDqCtRvoK7KGnacAAgCOdxFzsv3RisFU6d8tsk9a98igQAl
         qb4DdRnin3njz5w1Y4qfeU5UIJc7YYlwKbnsWycbFriM4J48DPgisiXqSNm3QCNh0DQF
         Bcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=swOTGocfH0e7AV6mvXQoxorMuqm1m/bwAmQIkZhRl34=;
        b=ynIAg/H5eNYa8QSOpW0AEgHVrtjB3YeeMV1LDw1E52cCFSSbSwrdFhrXY8vuk6aiaN
         6Uhn/dSj8RRqdatT+sBG1SLQoOfAV+x0KTNbzuFlTY+Uu7GgcAeMOyGuzhg0R6KX2+3r
         OHagrm1J9wPzOedRB79KV3zb9RriiFb8Rq86tlJqANprINlqh9/mEd/telLPKjGrT+Cv
         se60mqOOj/8AIXsFuXN+dlgaXzWgrClEYU+CRzKNuNwh8fDlVPLfzGrM3rYUzynoOI7l
         FPXoKO2+UwnIxcF+1w8dLgjcOiy1zkOGazMGgjeYHWt5PJwXjzk8eZ0BnB5HrH0BXixD
         dPgQ==
X-Gm-Message-State: ACgBeo20Dm64wYK3O5lxExD8TUh+gF6kysGNHs69xDpnX1ese4CUcNJP
        jiA425V5zAuw+7GFeFKENSprLXWnT8qXLw==
X-Google-Smtp-Source: AA6agR4MIpJKH7nOfroq5li/yXyRHsLc2/td28cXyS1k/BsfnwD4/Bdbb5wK4oWRqIS6+btM0O4EIQ==
X-Received: by 2002:ac8:5c89:0:b0:343:4e44:3dbe with SMTP id r9-20020ac85c89000000b003434e443dbemr13908135qta.531.1662760445623;
        Fri, 09 Sep 2022 14:54:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y25-20020a37f619000000b006cdd0939ffbsm1256204qkj.86.2022.09.09.14.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/36] btrfs: move simple extent bit helpers out of extent_io.c
Date:   Fri,  9 Sep 2022 17:53:23 -0400
Message-Id: <4814804ab1d42e492f1c181259004b91f7129e85.1662760286.git.josef@toxicpanda.com>
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
index 5ad22bc27951..eb4abca913f4 100644
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

