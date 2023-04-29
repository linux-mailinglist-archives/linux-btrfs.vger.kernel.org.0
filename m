Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541116F265E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjD2UUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjD2UUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E130A210A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:32 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe25c2765so20193527b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799632; x=1685391632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1KxpMDL2OEA6fseh0uFJ5Ba9UtMnXLtg1UDeo+UDpA=;
        b=yPxpRp+WmFFelZK3+Y3iadUBJ3InceOEepBfJxGxHkfGUteGaa40HNu5VRBFkC6C7N
         qQGOkZdrXv+nn/RnTSjbAoXIZPf8/jwFoBI113yfrNbi/WnHdOEQ4/cyQkO3J9ZhYEyD
         bbzy/QCEAuphh1yrG6JAOPyZxoEU0gvOQJxznDs6Pa9v56MQETN78PzoXJNdtTvyauTs
         QJ98e2ndi9mztm6arV+x8JLpGFjLXKldAGDmXlJQmNLhEh4VRFWW1wvNJXe1u4TVcziF
         w0fv7bl0RTCgo4jCw1rxLA4JZ2kFyZxUMCudL6ikFvmQa4k87ynLLasw/oWYYBchmnVY
         Z1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799632; x=1685391632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1KxpMDL2OEA6fseh0uFJ5Ba9UtMnXLtg1UDeo+UDpA=;
        b=WNlcVwrYU6ovgX20xXd4zYpjOreZNIfB19OD06Fp54AJIlD/U8PNADQ1/E0DtkFPYJ
         7qBoV94/ICTSrUNOnhz1Uyij0WPVx+/+VcDsbW3SZyqyweqohhh2+DnAvjg8Mulc8jUw
         sEfuDQEiSNDs6cPhR9JPLR0NSK9tl71HNwLmLmxVzzZ9cK2uyThD0grApg73DF+rV10C
         gvtIo1nKX+c5pG1sLhLm9BVDROCmtNNKOkHFDnYc6PVRijfufaoy87nVfiuQFxGpyGB/
         DC8VvIuGECTKzgGjWtBfsEFhW2Edw1v39cnjeu0AtE9O7IWioNJYUyIv/WUiC+m0ISod
         uB3w==
X-Gm-Message-State: AC+VfDwT0VkpIrVUQxobN/Wte8TGgdHjTELSuGtwlsbEzZ6duSGN6+60
        OAWdbc4hDiCDFfEkWfB4WhTQCR6PYgM87EAJoncVoQ==
X-Google-Smtp-Source: ACHHUZ5HdiN9N04HkXO7omGiT4iePbJrUHj630KUMIrCit1jhgQcm55iR69Y6w/ooNxP1muOn5nvnA==
X-Received: by 2002:a0d:d606:0:b0:559:e5d1:a4c2 with SMTP id y6-20020a0dd606000000b00559e5d1a4c2mr2730712ywd.49.1682799631818;
        Sat, 29 Apr 2023 13:20:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c134-20020a814e8c000000b00555abba6ff7sm6310829ywb.113.2023.04.29.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/26] btrfs-progs: add write_extent_buffer_chunk_tree_uuid helper
Date:   Sat, 29 Apr 2023 16:19:55 -0400
Message-Id: <046464e2ca6e3ba086cbf82bdc7c8c143a17251c.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

This exists in the kernel to update the chunk tree uuid on the
btrfs_header.  Add the helper to btrfs-progs to make future kernel sync
changes easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h     | 2 +-
 kernel-shared/extent_io.c | 7 +++++++
 kernel-shared/extent_io.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b68a8080..376b8eca 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -731,7 +731,7 @@ static inline unsigned long btrfs_header_fsid(void)
 	return offsetof(struct btrfs_header, fsid);
 }
 
-static inline unsigned long btrfs_header_chunk_tree_uuid(struct extent_buffer *eb)
+static inline unsigned long btrfs_header_chunk_tree_uuid(const struct extent_buffer *eb)
 {
 	return offsetof(struct btrfs_header, chunk_tree_uuid);
 }
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index fbf45e9d..e942a7b4 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -659,6 +659,13 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 	write_extent_buffer(eb, srcv, btrfs_header_fsid(), BTRFS_FSID_SIZE);
 }
 
+void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
+		const void *srcv)
+{
+	write_extent_buffer(eb, srcv, btrfs_header_chunk_tree_uuid(eb),
+			    BTRFS_FSID_SIZE);
+}
+
 /*
  * btrfs_readahead_node_child - readahead a node's child block
  * @node:	parent node we're reading from
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 544d5710..aa56c115 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -143,5 +143,7 @@ void extent_buffer_init_cache(struct btrfs_fs_info *fs_info);
 void extent_buffer_free_cache(struct btrfs_fs_info *fs_info);
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
+void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
+		const void *src);
 
 #endif
-- 
2.40.0

