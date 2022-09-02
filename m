Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B25AB959
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiIBUQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIBUQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:54 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA55E726D
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:43 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q8so2251451qvr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=AZWeJJht4H1nFpESENBH2bZCBoti+8IGiJNZGGKaiwg=;
        b=itOmWbLASEcag6UjBlKsIpxx7Jt2qiEkXldsyNJFk4UVvTG6ny6nsbZAfS8C2HsQyC
         aBOmDR8nOjBDdpwT6GwhAFHHtmDUPYk9A/XEPj9Cfx5Suc2qQ030vgawthf0n0VKAUiI
         kBMChEM++IxOM/8pScA45IPTXDwiMTJMsL35L/ETPZiOQnZXrZrvNtBd7nAYmPd84qM2
         tzCnJba+tZnxP58HIhJi4Pm1KDeZKi9uq3aMmidM8h4eiqjF09D6IP1rJNhssQHBRAJ8
         y0qU87n/lNgFBF4+kytMhUFxN8TbFRlf7AMKAwxQ31pMTbOi9Uhbx+DSObK6XH65cfzr
         /9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AZWeJJht4H1nFpESENBH2bZCBoti+8IGiJNZGGKaiwg=;
        b=zSnXyDM7LLkJRuZaCsStHwLb+71LAAk6GTDo3sUz1q0uW8a2UsFeBxiTc+2liUlEI8
         GmlpcclPvVr3ygqz31Hl0PHimLGQsALCclhK2M6lbRRFYy3dtgAyqadvdDJCYpZDqybL
         zbFyMkBISdQ8skSvJIaLIh/uhGK2qQK76HoV82pu2c3koth9/sv/HSAJl2WLXk7r1VwV
         +LlEYd4Tiod+rtA4w+zA3irnlWRAbgSdFNV7fqAoCn/UQ6UH8AGfWo3GweuIWdsWfxir
         jTmuoiO+lja9qYXjTHlw3tO2417NxzXW0VWAiK3kzwwZ+zXrPnTjDVyXgAQp90c8m70K
         P9Ng==
X-Gm-Message-State: ACgBeo3ckRosBaRHOAa6o56dsZqzNKb3nLCcM79xztkwwB+/++kuH89Z
        F6bgC1gyZdTDgMRF1zJQ8VqhKyqcqbD4+A==
X-Google-Smtp-Source: AA6agR5oiyNemsh9GDErRvAKvZdzZH+0t23K+9dzlylObmTxlrMuUBIg09BIAAHp0zWMRZHFTmPhbA==
X-Received: by 2002:a05:6214:19ee:b0:499:1129:d34b with SMTP id q14-20020a05621419ee00b004991129d34bmr18160051qvc.39.1662149802434;
        Fri, 02 Sep 2022 13:16:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 73-20020a370b4c000000b006bb619a6a85sm1916991qkl.48.2022.09.02.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/31] btrfs: unexport internal failrec functions
Date:   Fri,  2 Sep 2022 16:16:07 -0400
Message-Id: <f226507261b26521ae8406aade858286b8b59744.1662149276.git.josef@toxicpanda.com>
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

These are internally used functions and are not used outside of
extent_io.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h |  6 ------
 fs/btrfs/extent_io.c      | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index bb71b4a69022..5584968643eb 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -248,14 +248,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       struct extent_state **cached_state);
 
 /* This should be reworked in the future and put elsewhere. */
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start);
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 		u64 end);
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec);
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index acfbf029c18e..be14c15cfafa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2163,8 +2163,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
  * set the private field for a given byte offset in the tree.  If there isn't
  * an extent_state there already, this does nothing.
  */
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec)
+static int set_state_failrec(struct extent_io_tree *tree, u64 start,
+			     struct io_failure_record *failrec)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2191,7 +2191,8 @@ int set_state_failrec(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start)
+static struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
+						   u64 start)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2275,9 +2276,9 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec)
+static int free_io_failure(struct extent_io_tree *failure_tree,
+			   struct extent_io_tree *io_tree,
+			   struct io_failure_record *rec)
 {
 	int ret;
 	int err = 0;
-- 
2.26.3

