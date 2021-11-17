Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AB454E66
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbhKQUXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240649AbhKQUXH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:07 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7EC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:08 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a2so3847807qtx.11
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSkrOXEvpNqF1zdxEsTNF4ZMegNRF+/ApMheM38Qvv4=;
        b=C9gUjDfR45vu1fWiZGITidNEWSS2HOZVxKBU02EQ9im61hWOBlLCR8BmAfgY1aKcJ7
         TTJOl/g7YBiu0Kay9xXaBOP5riXKBZqy174xW/F4UZ4d+tdOBc5/fN5W99ARIWANGDoc
         Qbo8+6QYSFjqdg8ouinCKsnCqxc+EHQiE7z8CE2AB7sMSRudsINtfPdAg9aDvvR4nrO9
         iWPrvdfMo/upixmONgU+CktEyC0H8OOzDp30TwEGi6M0oYP8PiuoyHosI+yDPV6e89iq
         IGjQl0SR22F8muP1r0mkycxfJ0VdqvwpFekXPxHNIfLeeBzwk3b15pf1ZLfdjYpUdPdq
         iz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSkrOXEvpNqF1zdxEsTNF4ZMegNRF+/ApMheM38Qvv4=;
        b=BX1LvVOr0G0lAwxAZ9IfZUpAIJHZg+Gf9LPj6uoFVduAd2enACrgfWcwBkziwXEy6G
         WxyQ5CIsbITtfSQR7ezy4kATHB1zu8MdV0+t75Q7RisK4hr28jOljKWsUI6pwQU8KWqH
         G06mmSbWUikuCB4vxsa/F6kAcmtYfslCnRTKit19Q2bsH5OKVoMe3Vzi51xdOMttgSCl
         2SNg6yBglS0YhCQHmBGIRle6JWPjFZuJ/PoMStqufPtiD5BMjW+y1FH/qlLg+BwCru9K
         Uy1hXyCJWT/haWldcPM4aIJLCU0qVIsdzZbP6WBtuz2XCxb6vB6IygDBPCmL2HinlnOB
         rS3Q==
X-Gm-Message-State: AOAM532nEb41rST+bLdoYQVhYUFtr6D+Svv/kMOHT5j5+C6OK2Y5WKks
        /8lkeI2L7USANmCYWVVrGJbRABnXFlr+uQ==
X-Google-Smtp-Source: ABdhPJwpejxhmI3wyyNYgaXjECbStLwcMOaltcGBNl5IYXr7aeBoDSkNUxzvcWJL/0jseaX08iPDrQ==
X-Received: by 2002:a05:622a:2c9:: with SMTP id a9mr19589878qtx.28.1637180407408;
        Wed, 17 Nov 2021 12:20:07 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:07 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 07/17] btrfs: optionally extend i_size in cow_file_range_inline()
Date:   Wed, 17 Nov 2021 12:19:17 -0800
Message-Id: <1040f2fba5861130283b16aa915a9ce42f234d9e.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index a5cae0c6d992..c2efea101f61 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -237,7 +237,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_inode *inode, bool extent_inserted,
 				size_t size, size_t compressed_size,
 				int compress_type,
-				struct page **compressed_pages)
+				struct page **compressed_pages,
+				bool update_i_size)
 {
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
@@ -247,6 +248,7 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
+	u64 i_size;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -325,7 +327,12 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -340,7 +347,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 					  size_t compressed_size,
 					  int compress_type,
-					  struct page **compressed_pages)
+					  struct page **compressed_pages,
+					  bool update_i_size)
 {
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_root *root = inode->root;
@@ -388,7 +396,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	ret = insert_inline_extent(trans, path, inode,
 				   drop_args.extent_inserted, size,
 				   compressed_size, compress_type,
-				   compressed_pages);
+				   compressed_pages, update_i_size);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -721,12 +729,13 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
@@ -1144,7 +1153,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, actual_end, 0,
-					    BTRFS_COMPRESS_NONE, NULL);
+					    BTRFS_COMPRESS_NONE, NULL, false);
 		if (ret == 0) {
 			/*
 			 * We use DO_ACCOUNTING here because we need the
-- 
2.34.0

