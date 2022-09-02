Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D25AB948
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIBURX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiIBURQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:16 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E1AD3EEB
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j1so2260716qvv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=20Yhsr54XoS92CwX/KkffhTXptoTrMLHY/7ZUT2KoZo=;
        b=MUZhC6ZS1UN5NUOXLctr+Rr4PL3InaPRxXobMGjqAQU14/V4PJ8c916T3cmL4JQmYA
         fQ5Uxv/9xdHYpEvw2lJMedIrbziRt+GmACfhEM+fXNehrpgydHoliaJmKyaLBiKllEdi
         Asu7f96HMkitH2knsQBgHVlRDs9lmO1T/mbWtT3po7jOy28pV2vRqiXGdJK7HNsWetfX
         mJgzQEEjcx4UNey0o+FTcQExmzS+hREbpyZza3Jr85P9VZ84qEktWfzQgiBhulIN9YvO
         6iWumNLmPirSW/u2lgzFTCLrdhU0oAhh+3VfyNdVpSUlZu+pakGBfAgFbehKcJ2Kt/To
         ef0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=20Yhsr54XoS92CwX/KkffhTXptoTrMLHY/7ZUT2KoZo=;
        b=KxJ9IkHg8xzobAhU40JBS/J/axDDB+UrM4iizYKVsaweoZvOKr26y40rzGABVuxU/I
         LH9bV1Dd3BNZ5gKv6AfleRg21eb6186UMOcuAf0g9RYMO9F51M/X+tDhUdNmarjuUrMk
         FyOSpVUhD7Yvy9EHA4a4qr2ahL6FFapdMZlprOgjKVqas2iXVqmxmVfXV4/fEam5uinv
         1+IClym1qeIpCU8ZpF6AP4KVLFGU8ZNHXT/erbR4LWiwmsIfxoQZJpj1tO1uQOfdiO8N
         7cbGGq7+Sc7NZrDPmxKfaoKmQV+t9E7DsNQgycQN8ceJXs2sLzTMN6vCZ83jCzd6GGdD
         W/FA==
X-Gm-Message-State: ACgBeo3huhtOV7PZW5j/qN0N9HVmFt1u7aQjVIOJO0GfpawE5+3lP5Bv
        YDVAJ84sJZQQd4kv7ipsjfI2bl7I8wtVxg==
X-Google-Smtp-Source: AA6agR7QV+NqvlkNnKPQdXrnbBaW5uNi6DUVNQb8YQLCL3XZiFJ+jRQXv6vBOucq/S1WItX57Q3EGw==
X-Received: by 2002:ad4:5de7:0:b0:496:d0f8:7000 with SMTP id jn7-20020ad45de7000000b00496d0f87000mr30772453qvb.12.1662149833624;
        Fri, 02 Sep 2022 13:17:13 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85742000000b003434f7483a1sm1684712qtx.32.2022.09.02.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/31] btrfs: move irrelevant prototypes to their appropriate header
Date:   Fri,  2 Sep 2022 16:16:25 -0400
Message-Id: <9724af5ba38bba89c9c4abc71301119d60bf8135.1662149276.git.josef@toxicpanda.com>
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

