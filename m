Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A405AB94A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIBURW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIBURO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E0CE303
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j17so2334011qtp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=NMpI4eQ6mi5IeRB8vcvK1+ytWBB9Hanr4llvJzPUIQs=;
        b=Dn6HLZQ2TxZaBKRYv0dO+2eICxhzrEfywbqofPozvNlNjdAGpwtTfXqaoc1mS9lWk2
         oeKOJ7BCJvMS3UcbiyrsocM9Up0w+xl4dgo5yyA1T0sLJoS3yy7PU1GxonQ//mHcAmyn
         DbLnDwt10OyWraXAA5ary3q8Jux0TWEmVmTBjDps99+bjso3GxwkLgl7wLVTH14LD1Ih
         7lnj9EPXxOY7vIpXbn2lc3IRN4LZy3JBxo74i/zVzrlCpt8Kwmfs8GMzux84evP/ooPN
         0yB2MH9V4GOANjj3EmGrCg/9AP5IHvaLn5O2rRWr9GJwEoraC4aB0NWXodHHf9rUn6Fx
         V1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NMpI4eQ6mi5IeRB8vcvK1+ytWBB9Hanr4llvJzPUIQs=;
        b=6ELMSiKgE5hVzt7eNh9wijL0Bsz6272/01nn8mGrOxgyYw2lPxP/8J9yWWIweFaVjN
         LvWTUFuDAF6Z5zlS0MbFNpYW7O+6T776WHF+XSTVFenbC+zCbiDKZqSYi7OD+rsNqqMX
         5Y0LdlgnuDZ0MF1c8RIX2vFwm3Cyj5Zrq/6eGsZzpBuOCW8fT/gwA4SUnf8AwiiPTlkX
         pRVZsoyIaSLOwppwDiHK+mqetvYDd4zOuUETubK6OZJZnn9c9qTsBcHKEdDruAIxN+9R
         bKvMx6y4JmWs278kE1JKRndVjck/6c08Lgqs3B3Ze9bxBpZS9df7M4T7FPOJz5K1Apiw
         2ACQ==
X-Gm-Message-State: ACgBeo1HpwQbo8iwsd9UfvZUhOOanIQT4tNbSSzZGcekNc9JY7EdXpw9
        +eyrAEfQVv6zWgVscr0CGjh/M2X8Lv39zg==
X-Google-Smtp-Source: AA6agR4WzYxdVGdfwpRPARSSiwnkunHE6vO7UjcigOzIgP3eOUV4usl1FkXg2jAnetAITiQoQ6pAyg==
X-Received: by 2002:a05:622a:650:b0:343:67f3:1b41 with SMTP id a16-20020a05622a065000b0034367f31b41mr29605964qtb.452.1662149832034;
        Fri, 02 Sep 2022 13:17:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c4-20020ac84e04000000b00344f936bfc0sm1537637qtw.33.2022.09.02.13.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/31] btrfs: remove temporary exports for extent_state movement
Date:   Fri,  2 Sep 2022 16:16:24 -0400
Message-Id: <381be399ffd33a24732cd1d76788646ea9f4752b.1662149276.git.josef@toxicpanda.com>
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

Now that the code has been moved we can remove these temporary exports.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 9 +++++++--
 fs/btrfs/extent-io-tree.h | 9 ---------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index bd015f304142..5f0a00c6aa96 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -9,6 +9,11 @@
 
 static struct kmem_cache *extent_state_cache;
 
+static inline bool extent_state_in_tree(const struct extent_state *state)
+{
+	return !RB_EMPTY_NODE(&state->rb_node);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static LIST_HEAD(states);
 static DEFINE_SPINLOCK(leak_lock);
@@ -123,7 +128,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 	spin_unlock(&tree->lock);
 }
 
-struct extent_state *alloc_extent_state(gfp_t mask)
+static struct extent_state *alloc_extent_state(gfp_t mask)
 {
 	struct extent_state *state;
 
@@ -144,7 +149,7 @@ struct extent_state *alloc_extent_state(gfp_t mask)
 	return state;
 }
 
-struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
+static struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
 {
 	if (!prealloc)
 		prealloc = alloc_extent_state(GFP_ATOMIC);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 3b63aeca941a..3b17cc33bcec 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -260,13 +260,4 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 		u64 end);
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
-
-struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc);
-struct extent_state *alloc_extent_state(gfp_t mask);
-
-static inline bool extent_state_in_tree(const struct extent_state *state)
-{
-	return !RB_EMPTY_NODE(&state->rb_node);
-}
-
 #endif /* BTRFS_EXTENT_IO_TREE_H */
-- 
2.26.3

