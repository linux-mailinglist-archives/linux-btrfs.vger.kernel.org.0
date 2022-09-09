Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE25B41CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiIIVyj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiIIVya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B45F6D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l5so2350503qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=20Yhsr54XoS92CwX/KkffhTXptoTrMLHY/7ZUT2KoZo=;
        b=4hiZMK3KbNO2BLeo8BI3cRIiI9ISzLHrgg+Ez+mu77N36UahPwS3JkfvWEHZTpiA9H
         UwBiqD0JoePw6hj80XF2e2PHpHFa7tasWwD34yznPF9szt3r+wd2dQn/Hz8k5dCaja7P
         s/DjJ8QmVfdrxzFwDNMOWh0PPy1THgn9tP+cRZvgzuSGz7dJvG0QdYky/Oq06kYxO8Xx
         66I+i2l+i23c9qcGNCcFJMoHnI5AG2s9EBMgC7cNxE9LOxNg8/HZrM3hC6fTRTHEElSy
         B2e1NunriSisFW0Jvxk4coGYPBiY+E4tMxhedn+++62KWvme1RiavHwkOHjJ3FIpf3l5
         jRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=20Yhsr54XoS92CwX/KkffhTXptoTrMLHY/7ZUT2KoZo=;
        b=QPqh84sTCeuSfIZuFcG6uvSmFwSxP4wjMFvRObozPN4QwL97iD+J44BM5D19oiSOkK
         WjVWxyZ29RrSBdOaftkbh99kQXO/+sPe2EJc2M0wM2outbX+FXPQ+SaEnKeUESmEhp2Q
         6aNOFVvmX1AAKiz1Ol4bvkPuOHgqP0XdL/bZ+Jezl4XjIMKt2eNaseqfs6pqU4vKpf/m
         G4lsVrKTltUon0X42hZPC3zUEINduazq6I95DcqSqejivq/oVVH+9/RV4IzbtEDrtqhV
         66PZFuDmHr9zd0t85AZjG9UNJdEfTFD9/6RQ8eGmq6sCWIN8Qdj0oFfvtQmIjO5Ney4b
         KYEg==
X-Gm-Message-State: ACgBeo0zmJZWXto4mpwRpQgMDF3ENkycqwRcRq4BcW1yI2+jPGYU17/c
        zrGmbRpNIMV/GQz3fMuVsgVqG4Nj1FPFtQ==
X-Google-Smtp-Source: AA6agR6b8WMfBrO8oGMOVBRq9Tlb7+/gEYiDCxEndf68Y4qlySrNJ9ZwY2KPieQ213v32W+zF7Zgow==
X-Received: by 2002:a05:622a:1654:b0:35b:a47b:4935 with SMTP id y20-20020a05622a165400b0035ba47b4935mr2801571qtj.288.1662760467312;
        Fri, 09 Sep 2022 14:54:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85151000000b0033b30e8e7a5sm1140422qtn.58.2022.09.09.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 25/36] btrfs: move irrelevant prototypes to their appropriate header
Date:   Fri,  9 Sep 2022 17:53:38 -0400
Message-Id: <2d1d4e0926ec5547df8b8d8387c4d49521f2a6a6.1662760286.git.josef@toxicpanda.com>
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

These prototypes have nothing to do with the extent_io_tree helpers,
move them to their appropriate header.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 8 --------
 fs/btrfs/extent_io.h      | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 3b17cc33bcec..85acdd13d2c4 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -248,16 +248,8 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 			       u64 *start_ret, u64 *end_ret, u32 bits);
-int extent_invalidate_folio(struct extent_io_tree *tree,
-			  struct folio *folio, size_t offset);
 bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
 void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits);
-
-/* This should be reworked in the future and put elsewhere. */
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
-		u64 end);
-int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
-			   struct page *page, unsigned int pg_offset);
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 52e4dfea2164..ba331bced460 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -242,6 +242,8 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
+int extent_invalidate_folio(struct extent_io_tree *tree,
+			  struct folio *folio, size_t offset);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
@@ -272,6 +274,10 @@ struct io_failure_record {
 int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 			    u32 bio_offset, struct page *page, unsigned int pgoff,
 			    submit_bio_hook_t *submit_bio_hook);
+void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
+		u64 end);
+int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
+			   struct page *page, unsigned int pg_offset);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.26.3

