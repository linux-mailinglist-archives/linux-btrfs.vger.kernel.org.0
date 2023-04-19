Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57756E83A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjDSVZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjDSVZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:00 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6E76B0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z1so655962qti.5
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939469; x=1684531469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XEL8Jvl2jhMW5AIP7diIZfQqZmWxcPA/o01KuBDKjfc=;
        b=l04eIrnUlaymQ63HD2M9IiM6SuI3QveXnijYi/tvaHgx9qjeJldxPGeNWTe9w5hppc
         KhU0dHUXaeyOLZ5Ig5BpyVdD2Qlyf8j50YACzfl0gcHYPf4Koq0pbgw8DNBDqBcaY2HV
         uw8qWwO867+Q4zcIUTgoTfjsPLPtEL9wJ+/q+xHAEYY9jcU8PBnOlA+G1FegbaM0adCY
         L4IR07mVwtAumAW4S+d/dhqY42Qp8S/iLSi8kRVwZueNtb4kq4TF7NJKVIwlpFFyE3jD
         9DTjfwN3feJtE+0cTJn/RrQ6njWesQ0dtZDH6pncFFRaOoLCHR0jYQtCIZSpaUoyjodL
         xmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939469; x=1684531469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEL8Jvl2jhMW5AIP7diIZfQqZmWxcPA/o01KuBDKjfc=;
        b=B0JuTOC3Ru7CZXy7aNWxQokG3XfgQ4zF+WZXVgCaGOOOc3fqgpcXRGm46K7g71qyUL
         Ucya8scW5SwlXwEnnyikzs7vVlzHd6M4i821oq863WiZCM0EA/Sc9ixqy47GhkmDpyDe
         fyPwS7+K0dW3hLqjFfqeU42kiVJCtcGlTvuz/aLFeePxrUWPBRLTnwEmm2cBdflaTMTD
         eLwXRcsOo+eMkFgCJ8vCL/rlqDkSZ7pxEotbJcdGqLnWStxeliqf6CxaAJrQalEtg/B3
         JPuDaywNCm8nf3OrqA50OYCJTMDXYMsQIKHKgjXTh9/IwPW1nFBZ4o40pT1aIX9KAHbe
         yn7g==
X-Gm-Message-State: AAQBX9esZRkmoDinQBYUKJVIe4AjLZTHWDKAFxJYM45jY0jV5hZJQ8nA
        wDgQpg9kwfofqSCz6hQG8wV6K+Gq4VGI0ZPz3ruabg==
X-Google-Smtp-Source: AKy350Z3clPhl2J43pQfDy957YtdMbaqkcM2/6TaD75pGCCKgMrLkHGTSnK24J0JmIijJh7HqSOu2Q==
X-Received: by 2002:ac8:5a96:0:b0:3ef:379c:71b9 with SMTP id c22-20020ac85a96000000b003ef379c71b9mr6634282qtc.30.1681939468865;
        Wed, 19 Apr 2023 14:24:28 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id he31-20020a05622a601f00b003e635f80e72sm38977qtb.48.2023.04.19.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/18] btrfs-progs: add btrfs_readahead_node_child helper
Date:   Wed, 19 Apr 2023 17:24:03 -0400
Message-Id: <6bbffaa00e20aac133463f344979e73283c4f404.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

This exists in the kernel as a wrapper for readahead_tree_block, and is
used extensively in ctree.c in the kernel.  Sync this helper so that we
can easily sync ctree.c

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 14 ++++++++++++++
 kernel-shared/extent_io.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index d6705e37..105b5ec8 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -651,3 +651,17 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 {
 	write_extent_buffer(eb, srcv, btrfs_header_fsid(), BTRFS_FSID_SIZE);
 }
+
+/*
+ * btrfs_readahead_node_child - readahead a node's child block
+ * @node:	parent node we're reading from
+ * @slot:	slot in the parent node for the child we want to read
+ *
+ * A helper for readahead_tree_block, we simply read the bytenr pointed at the
+ * slot in the node provided.
+ */
+void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
+{
+	readahead_tree_block(node->fs_info, btrfs_node_blockptr(node, slot),
+			     btrfs_node_ptr_generation(node, slot));
+}
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index b4c2ac97..a1cda3a5 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -137,5 +137,6 @@ void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
 void extent_buffer_init_cache(struct btrfs_fs_info *fs_info);
 void extent_buffer_free_cache(struct btrfs_fs_info *fs_info);
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv);
+void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
 
 #endif
-- 
2.40.0

