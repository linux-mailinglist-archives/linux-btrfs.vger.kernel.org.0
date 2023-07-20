Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188675B890
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGTUMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGTUM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 16:12:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD38A270A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76754b9eac0so119375185a.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689883944; x=1690488744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+QjukrGisyobc4vKTijT+HclY5nUeKZgdUPoX3ROt4=;
        b=Jytwu/VTULNS2C6mUPpsJBuQA1ZyJyK5Baqewx9tm94K7xAZrQcgVBalZ8Un1UCXN/
         IB2s5ttCfPozGjrMd8xlsqkpXti0B3vowytSKF732MmU4s1HsdocbyE6vUEs7e04rGBW
         wLV7KUzAouAFzyymBioEKBb8CnwgVDnpjSAuodAvSwyxCh/TjwZrf8fzF4Rt1FGjCARH
         cwrR7jxK4gJQD+bb/UcYFsckmYdIRqJlOdsJryRuJQ8EXdS/5gA+TbG+bXvs0xuV0E9o
         8gmSoIlJyyxf/ULtdCoGcriIc013N5JyrKA27Ha1SqrJMohbc7M1Ro1W1ocXIubxFtFx
         uaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883944; x=1690488744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+QjukrGisyobc4vKTijT+HclY5nUeKZgdUPoX3ROt4=;
        b=fVt+0zx5EJSRdUojGEG8uFbEz8RV//3nMIANPSCh5zDuI12mHT5Pu24cWv9uT0PYCh
         PXTyh3aCYrl1PDYhdp8LYWXwA6hKZSNNk8txYwlGvA3eHAm0OfC2QQ0JhowPnuFskPO8
         1rfKVJjtG8JQBjnKh0PeHR/lB7Jq2l78zVN2XlEkznkYQJgQqtXdDrEhw5cmFxh5K5ZP
         ePtSrLanR/x2g5MxKxGOtadISNQOJ2W+jHpTvhxfN/upiL8Lepr8PFuM0d+qzgrhtimc
         ByaCt0tvBwglZIX4ujUxyfTq6a/RqLC/D/Kdu4xVuPEzoc9bSXRaVnKNxpecKtoACWU1
         +tnw==
X-Gm-Message-State: ABy/qLYTX5vhVhuGiUh74LePN03fOEL8g5p35Ke2Yju+GH8v0FQLC9eN
        VLp3YYK+2vnQEpbD5Jp75g6xylAn7cPV4dRjTfT4rQ==
X-Google-Smtp-Source: APBJJlEvcj1p3XERhtzzgyd1JZypEC/KcA0+6fjz2tmiQDteZ9Py7JaS5Fg56WNzNGCatczXzV/LMQ==
X-Received: by 2002:a05:620a:430e:b0:768:61e2:89a1 with SMTP id u14-20020a05620a430e00b0076861e289a1mr5183911qko.11.1689883944559;
        Thu, 20 Jul 2023 13:12:24 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a20-20020a05620a16d400b00767dafbf282sm594901qkn.12.2023.07.20.13.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:12:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: move comments to btrfs_loop_type definition
Date:   Thu, 20 Jul 2023 16:12:15 -0400
Message-ID: <6abfcd8c6763baf92199be9532db3bd9e9e0e418.1689883754.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689883754.git.josef@toxicpanda.com>
References: <cover.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some of these loop types aren't described, and they should be with the
definitions to make it easier to tell what each of them do.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2850bd411a0e..8db2673948c9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3329,12 +3329,44 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 }
 
 enum btrfs_loop_type {
+	/*
+	 * Start caching block groups but do not wait for progress or for them
+	 * to be done.
+	 */
 	LOOP_CACHING_NOWAIT,
+
+	/*
+	 * Wait for the block group free_space >= the space we're waiting for if
+	 * the block group isn't cached.
+	 */
 	LOOP_CACHING_WAIT,
+
+	/*
+	 * Wait for the block group to be completely cached before attempting to
+	 * make an allocation.
+	 */
 	LOOP_CACHING_DONE,
+
+	/*
+	 * Allow allocations to happen from block groups that do not yet have a
+	 * size classification.
+	 */
 	LOOP_UNSET_SIZE_CLASS,
+
+	/*
+	 * Allocate a chunk and then retry the allocation.
+	 */
 	LOOP_ALLOC_CHUNK,
+
+	/*
+	 * Ignore the size class restrictions for this allocation.
+	 */
 	LOOP_WRONG_SIZE_CLASS,
+
+	/*
+	 * Ignore the empty size, only try to allocate the number of bytes
+	 * needed for this allocation.
+	 */
 	LOOP_NO_EMPTY_SIZE,
 };
 
@@ -3926,15 +3958,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 1;
 
 	/*
-	 * LOOP_CACHING_NOWAIT, search partially cached block groups, kicking
-	 *			caching kthreads as we move along
-	 * LOOP_CACHING_WAIT, search everything, and wait if our bg is caching
-	 * LOOP_CACHING_DONE, search everything, wait for the caching to
-	 *			completely finish
-	 * LOOP_UNSET_SIZE_CLASS, allow unset size class
-	 * LOOP_ALLOC_CHUNK, force a chunk allocation and try again
-	 * LOOP_NO_EMPTY_SIZE, set empty_size and empty_cluster to 0 and try
-	 *		       again
+	 * See the comment for btrfs_loop_type for an explanation of the phases.
 	 */
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
 		ffe_ctl->index = 0;
-- 
2.41.0

