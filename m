Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9371A4B15FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbiBJTKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbiBJTKg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56019110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t36so1116442pfg.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpG212sjbwihiGa7491SZqW25yRnSlsMv9ZhY3K1bvI=;
        b=yRpg3qxzcgcDx8+HUn55FJ29A5w7Wdh+Ojk85u4fFspjObISXOlgjdVg6QYdNBRWjj
         QzzkSoTihOZh+EGDkwi2yr5rETPQFuTpGpjPyajiOVH9NhZZAV4CGQbOJNFptcEnuKgp
         ijOmsLg8rKqTI0wgj//YsVOM8pOXQoRPTDkgIwxi53QEm7NhMeO28zmEPBSrQbxX/FA7
         9LD0Jb3HHCiiAHI7xf0g66I4qB2joTeIJRQuhLWOTql8wPM+ybKABn4TinFTdgiGHCtz
         49PVqH1UpNhBLeiyMqtKEUMdf1nRg801lwl/uIcSj2TBgswRwm3Q5wqnnwgm7M+88mGe
         m0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpG212sjbwihiGa7491SZqW25yRnSlsMv9ZhY3K1bvI=;
        b=uG3WgF/bDDkRSKspHQp5cmY7tTo6lNcNNtfpRJrjUxnYFoLg9lhL4de35Up8U/XePX
         7NbDC2s4fdMrMIv6u11nL+3v1QR7aJV5bwOFWEdl5KkwHtlUZ2LU+JfU1nRJ70q7RQxd
         uSi8EsNYVmQPWAcygSMj3KbL+ENE7RIBOelu9Zmj88ls1YxdBdfr9KT+fhMrshVzGPof
         gpx3OWQkQdB4N/sj9BUQtCifQ3MLEhxpNDTjfSbZddVy2xU98lYy6e8X8SV8nm5Z3aPt
         NSqqWMJ6QveUlX5dP+f7JQvEUKC86DEYFPmKdZftn5KD8jl6rp4MkLCshilkxBwjk/Pa
         vyzg==
X-Gm-Message-State: AOAM532fl4YK7kJZMGZoQatZj40E4TRe21Zqh8kkJ/BMquTk2sRLKRRP
        In6v+MDfizyyGWjwCtIc7wBGCCFAs8dj2g==
X-Google-Smtp-Source: ABdhPJwGbLh3bzRnRsB0DgAgSdw89s/8TrSuMub71RbTVaE/5K3txu4Z3UwCU5Ek1ULsNxPGSon9Vg==
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr8863943pfg.75.1644520236567;
        Thu, 10 Feb 2022 11:10:36 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:36 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 07/17] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Thu, 10 Feb 2022 11:09:57 -0800
Message-Id: <ded5d061a11c3556805f6e82d6665bdde8ba58f6.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
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

From: Omar Sandoval <osandov@fb.com>

Currently, an inline extent is always created after i_size is extended
from btrfs_dirty_pages(). However, for encoded writes, we only want to
update i_size after we successfully created the inline extent. Add an
update_i_size parameter to cow_file_range_inline() and
insert_inline_extent() and pass in the size of the extent rather than
determining it from i_size.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bd6588c7f8eb..f77850e5a682 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -243,7 +243,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode, bool extent_inserted,
 				size_t size, size_t compressed_size,
 				int compress_type,
-				struct page **compressed_pages)
+				struct page **compressed_pages,
+				bool update_i_size)
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
@@ -253,6 +254,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -331,7 +333,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * before we unlock the pages.  Otherwise we
 	 * could end up racing with unlink.
 	 */
-	inode->disk_i_size = i_size_read(&inode->vfs_inode);
+	i_size = i_size_read(&inode->vfs_inode);
+	if (update_i_size && size > i_size) {
+		i_size_write(&inode->vfs_inode, size);
+		i_size = size;
+	}
+	inode->disk_i_size = i_size;
 
 fail:
 	return ret;
@@ -346,7 +353,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 					  size_t compressed_size,
 					  int compress_type,
-					  struct page **compressed_pages)
+					  struct page **compressed_pages,
+					  bool update_i_size)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
@@ -394,7 +402,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	ret = insert_inline_extent(trans, path, inode,
 				   drop_args.extent_inserted, size,
 				   compressed_size, compress_type,
-				   compressed_pages);
+				   compressed_pages, update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -726,12 +734,13 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			 */
 			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    0, BTRFS_COMPRESS_NONE,
-						    NULL);
+						    NULL, false);
 		} else {
 			/* try making a compressed inline extent */
 			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    total_compressed,
-						    compress_type, pages);
+						    compress_type, pages,
+						    false);
 		}
 		if (ret <= 0) {
 			unsigned long clear_flags = EXTENT_DELALLOC |
@@ -1149,7 +1158,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, actual_end, 0,
-					    BTRFS_COMPRESS_NONE, NULL);
+					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret == 0) {
 			/*
 			 * We use DO_ACCOUNTING here because we need the
-- 
2.35.1

