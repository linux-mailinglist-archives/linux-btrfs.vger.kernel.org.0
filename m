Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9225B90CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiINXFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiINXFH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7A52474
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:06 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s18so9388380qtx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=N0Y2NjGVx1M5k9ysaQXO1ixQEq994ktrFFEEMHup4HY=;
        b=dNlAnzdXurizh/YxdfBEQDpNuhUBsTxxcyoeSZwUyom/m+TWGCAw5xc7NxKn7xaZit
         qewAEew9bO7qJDBLETxa+Q3zuDBTv3lMj6UXxl2Xp9oFqUWtdB5UUkmJn3czVbpOMs83
         pHaJ7W68YhNMDi2B62lAQkdN/t+jFYs+4QNnB/i7rF5ooxWg166kuFrQ14O9HLAuqnmy
         m4pRHPpSwJKqsXN2vwYXitEuGe8MiRX5tPNplF75I1Qy72QAiUHwUgOz/h/f6AnC4q1v
         fEQU1iPb9X5UqTtnCpQ1I/BSUuRVM5f+mzaM6L7tKQVJE7uHw1Yioc2HtwlTiY6wKY/R
         d/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N0Y2NjGVx1M5k9ysaQXO1ixQEq994ktrFFEEMHup4HY=;
        b=RBJ+qg2grcInsi/9KAhHyrDPPjvcFn9CXvOuCsCWhkcOz4oyRloNcgEGeaPT79Lai+
         AgunaFYBVlLNb6sBB9tLoiTgdntWIhZ6TG1S8NrGlfn3xhOyiIgZVNW2XDRmbwDyikDG
         Ks9vPuU8Dt2voIynLHHjJlnJEWIX+S5X6IEBzW4XfhpOG4tOwYuIB2So68MRi5I93jPZ
         C8ozR7Tl11YVRavZ5uCMG8V9IxixfP1BZnjVEBvmv39P+eM03bhc4/nIyPOHFl9a8dqM
         gjau0bCO9mme+VtVXpFJLBJX/nWeB7IAA1qbRsA3+R+buUR7ulQw5j8pytExyLjIQzRD
         FCmw==
X-Gm-Message-State: ACgBeo0MM7nmeufjBzsI0nlCPxF9UHDeCPT6jU4Rq8aEduG2vXBXrA0c
        qg6ZUglr08V8raCGYCivyzgwivQK8JwMHw==
X-Google-Smtp-Source: AA6agR4tIPj02HzUKQwURbFbRuIGml4wzY6tKaTlgXfdqA9PXYKtQ9Bt3KZkQetxxqq5K6gwoojNKA==
X-Received: by 2002:a05:622a:13cc:b0:342:fa43:95ac with SMTP id p12-20020a05622a13cc00b00342fa4395acmr34917691qtk.508.1663196705594;
        Wed, 14 Sep 2022 16:05:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m5-20020a05620a24c500b006bb366779a4sm3298840qkn.6.2022.09.14.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/15] btrfs: move btrfs_csum_ptr to inode.c
Date:   Wed, 14 Sep 2022 19:04:45 -0400
Message-Id: <c3cc874650f6266c390ff3d3631b7220001e21ae.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

This helper is only used in inode.c, move it locally to that file
instead of defining it in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 8 --------
 fs/btrfs/inode.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 05eb0e994e68..0da52e8b78e9 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1173,14 +1173,6 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
-static inline u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums,
-				 u64 offset)
-{
-	u64 offset_in_sectors = offset >> fs_info->sectorsize_bits;
-
-	return csums + offset_in_sectors * fs_info->csum_size;
-}
-
 /*
  * Take the number of bytes to be checksummed and figure out how many leaves
  * it would require to store the csums for that many bytes.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ca6fa9b01785..62dc3dcf835b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3459,6 +3459,14 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 	return 0;
 }
 
+static inline u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums,
+				 u64 offset)
+{
+	u64 offset_in_sectors = offset >> fs_info->sectorsize_bits;
+
+	return csums + offset_in_sectors * fs_info->csum_size;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
-- 
2.26.3

