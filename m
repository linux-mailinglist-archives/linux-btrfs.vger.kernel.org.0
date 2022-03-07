Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630DC4D0B23
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343762AbiCGWeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiCGWee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:34:34 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90306C7
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:33:39 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s16so5065607qks.4
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6FrJsiIycg0c+/TWUMi/HIEIx/54aNx8f7s/4BCKhqE=;
        b=FECml+psMiIQjvoJSL/OrjBqSi+DfJDNe2BT06QWrYQLKpDuzG+mdoZILVlXn1nzAL
         DA4B+BueKzYMbSbyQfeiQ83BoFucLah3Aq0ASEa3u9bIkpKkinBB/Ro9HXR/wW3dXrQO
         DXdn0aAeyCsCLtFlvY8RQk6cWN9P68sShESkN+iEkCH95h7sNSZTTgG7rWFF3TfpyfQx
         uXPWSL+BUzD4VKtk29lG/N3jdRz/OUXXsTFY6Njc1hw6zWghOvatO1SlLfecmJuV+z4b
         jq+Wj0Zv0qLc/bfSvuAfupkII28bkygGNTr7Yz7YqwsBVjnlqjptHJ0ApT+wdtLwtSjh
         kY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FrJsiIycg0c+/TWUMi/HIEIx/54aNx8f7s/4BCKhqE=;
        b=jxN4j8edg2sAvz1EMfJAUBzlejSfGbgue/rURSd/VjMokhXm6fYH3MeHXPRSB/N/JX
         dD+SWGa+tgx5c/AQnlKS1A3abWxzizi9C+/Hu2rUvi10n63HR5+W2/5NDans9fg2vDwW
         kDHM5JLRjqJdIOWrD1cP4Wo01zeTMRZL79utsnzZPF1AfFgUWe9Kb/AcXNUSsHe2U0TU
         OGIbu8ZTKz03f7Y3iVD+GZ7NT6oB35o5rRlHJS0GrXUzDq04hZCR/Ee/NGZQfYUJIZdd
         9NtTRjtoRtsvOtEL4AaUVg9ayAYCl1X49J81hN1V8I6y7xsSiawB9AHXgWn75sMgmav1
         vKZQ==
X-Gm-Message-State: AOAM5310c7f+0OVNvapLLT+8RI6Z7AzTuub/rJFzCEko13o8Im9qVzqc
        P7utWpcZWuYHjXqFO8y2oSUE2n2K75211Tmk
X-Google-Smtp-Source: ABdhPJyr8lTNfpi3FziuOsR0xqu4KFFgnQM+5yjQWWrdGgQvFOooTkWcQXBp3zLRQMXPzYvFqhj3NA==
X-Received: by 2002:a37:4649:0:b0:47e:cf47:48af with SMTP id t70-20020a374649000000b0047ecf4748afmr8613006qka.605.1646692418428;
        Mon, 07 Mar 2022 14:33:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m75-20020a37a34e000000b0067d14e5c418sm370440qke.129.2022.03.07.14.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:33:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/12] btrfs: make BTRFS_LEAF_DATA_OFFSET take an eb arg
Date:   Mon,  7 Mar 2022 17:33:23 -0500
Message-Id: <aee46e656c4fe034edb72ef632d9807dc2a82651.1646692306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692306.git.josef@toxicpanda.com>
References: <cover.1646692306.git.josef@toxicpanda.com>
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

When I expand the size of the btrfs_header we're going to need to
conditionally return a different offset.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c     | 8 ++++----
 fs/btrfs/ctree.h     | 9 ++++++---
 fs/btrfs/extent_io.c | 2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8a35db9d7319..2e270f8d995e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -53,8 +53,8 @@ static inline void memmove_leaf_data(const struct extent_buffer *dst,
 				     unsigned long src_offset,
 				     unsigned long len)
 {
-	dst_offset += BTRFS_LEAF_DATA_OFFSET;
-	src_offset += BTRFS_LEAF_DATA_OFFSET;
+	dst_offset += BTRFS_LEAF_DATA_OFFSET(dst);
+	src_offset += BTRFS_LEAF_DATA_OFFSET(dst);
 	memmove_extent_buffer(dst, dst_offset, src_offset, len);
 }
 
@@ -63,8 +63,8 @@ static inline void copy_leaf_data(const struct extent_buffer *dst,
 				  unsigned long dst_offset,
 				  unsigned long src_offset, unsigned long len)
 {
-	dst_offset += BTRFS_LEAF_DATA_OFFSET;
-	src_offset += BTRFS_LEAF_DATA_OFFSET;
+	dst_offset += BTRFS_LEAF_DATA_OFFSET(dst);
+	src_offset += BTRFS_LEAF_DATA_OFFSET(dst);
 	copy_extent_buffer(dst, src, dst_offset, src_offset, len);
 }
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d5d52b907143..f4f3d41775e6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1422,7 +1422,10 @@ static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
 	return info->nodesize - sizeof(struct btrfs_header);
 }
 
-#define BTRFS_LEAF_DATA_OFFSET		offsetof(struct btrfs_leaf, items)
+static inline unsigned long BTRFS_LEAF_DATA_OFFSET(const struct extent_buffer *leaf)
+{
+	return offsetof(struct btrfs_leaf, items);
+}
 
 static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
 {
@@ -2692,11 +2695,11 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
 
 /* helper function to cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type) \
-	((type *)(BTRFS_LEAF_DATA_OFFSET + \
+	((type *)(BTRFS_LEAF_DATA_OFFSET(leaf) + \
 	btrfs_item_offset(leaf, slot)))
 
 #define btrfs_item_ptr_offset(leaf, slot) \
-	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
+	((unsigned long)(BTRFS_LEAF_DATA_OFFSET(leaf) + \
 	btrfs_item_offset(leaf, slot)))
 
 static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78486bbd1ac9..c5334af2fae5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4508,7 +4508,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
 		 * header 0 1 2 .. N ... data_N .. data_2 data_1 data_0
 		 */
 		start = btrfs_item_nr_offset(nritems);
-		end = BTRFS_LEAF_DATA_OFFSET + leaf_data_end(eb);
+		end = BTRFS_LEAF_DATA_OFFSET(eb) + leaf_data_end(eb);
 		memzero_extent_buffer(eb, start, end - start);
 	}
 }
-- 
2.26.3

