Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581446E83A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjDSVZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjDSVY5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:57 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496738A53
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id js7so1059119qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939466; x=1684531466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPi05GrOmULFBxsbJn21zlh/LOMtzj7Z7v+BilayxhY=;
        b=odBH9J1qrlYDTGvGhFNcaYtJFS8yUfH02LCQE6IuOHqCTH9V2CWyUOwc329GJtKznQ
         lazkULHdgnhI+2om1o55pHd4p/HlTW9sAE6HXK+ILiMtvHOmJLHnD5c4kbpr4yJ6/Din
         5SqcedZdaw48MLQOy8Jdj/LXpkcKk7vd2nnVMNf2DIt7UlelNxKw2vA4ooXoSClgG70W
         wGhXVDLtaspX0SsJH/u277FGIAjvzg/A/bx0tWbLp1dZ9QvNp6YiibYBiw+JhGQzky3v
         AailR4IaQrvJdFd7u2QWDr6M2e7D39HgGlvaZX5JYUTdaV7QMVqCXnskms2FwBBZw/th
         znQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939466; x=1684531466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPi05GrOmULFBxsbJn21zlh/LOMtzj7Z7v+BilayxhY=;
        b=CxZQIqWo/qPN3Pco++7sCRA9j6/g90aPOMWuhZjlqOCTmfWQRpo9myanP064rUX47g
         wEG9LEY1yucHQNhZ8mKMEo7VH7Oh7TLtCaIuZRtR1QyKUc8M3WmrV+TTe26hKQDFAm1c
         iAqBFd83gq7aU7vVV49x4jNv/2qYifzWtoAvn3oyvzyBkrFRLRGMHRBxHoJ5dN0l+yjg
         f5Zc/Z5vCjmKbbMiOAbKcvln66YwDWCh2E+Lm8UYqcPZiuaABdoJ0ri6gDJjcxVpYW0S
         X1j25AF+G3s4gJ4NApCkihMdrxvh2gmnY1PT/qrtTCMuhELgYgWV0WoYCDoQtu51WAus
         XLjA==
X-Gm-Message-State: AAQBX9fHmKxv/HPYNIEDu+61O8LfGbSAZaDWimSweaRxpQjTqCUUIvFL
        gwu4UrDu0yeaeANUMHl5Qp/3M/Q/UtyTTMQphbVqbQ==
X-Google-Smtp-Source: AKy350ZlJmKjYw75kKwblNYIr3t9+7ZM+bHQ3YrVoN/5S1T55pY++RlibK+F+C5KSXa7wtARyCOCxQ==
X-Received: by 2002:a05:6214:e4f:b0:5ef:8159:b9a9 with SMTP id o15-20020a0562140e4f00b005ef8159b9a9mr16084665qvc.21.1681939466429;
        Wed, 19 Apr 2023 14:24:26 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cab4a000000b005e5afa59f3dsm5933qvb.39.2023.04.19.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/18] btrfs-progs: sync btrfs_path fields with the kernel
Date:   Wed, 19 Apr 2023 17:24:01 -0400
Message-Id: <e3a21fad11226e447e9d3301d7e9518c826a2d36.1681939316.git.josef@toxicpanda.com>
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

When we sync ctree.c into btrfs-progs we're going to need to have a
bunch of flags and definitions that exist in btrfs_path in the kernel
that do not exist in btrfs_progs.  Sync these changes into btrfs-progs
to enable us to sync ctree.c into btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 2237f3ef..20c9edc6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -129,14 +129,32 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
  * The slots array records the index of the item or block pointer
  * used while walking the tree.
  */
-enum { READA_NONE = 0, READA_BACK, READA_FORWARD };
+enum {
+	READA_NONE,
+	READA_BACK,
+	READA_FORWARD,
+	/*
+	 * Similar to READA_FORWARD but unlike it:
+	 *
+	 * 1) It will trigger readahead even for leaves that are not close to
+	 *    each other on disk;
+	 * 2) It also triggers readahead for nodes;
+	 * 3) During a search, even when a node or leaf is already in memory, it
+	 *    will still trigger readahead for other nodes and leaves that follow
+	 *    it.
+	 *
+	 * This is meant to be used only when we know we are iterating over the
+	 * entire tree or a very large part of it.
+	 */
+	READA_FORWARD_ALWAYS,
+};
+
 struct btrfs_path {
 	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
 	int slots[BTRFS_MAX_LEVEL];
-#if 0
 	/* The kernel locking scheme is not done in userspace. */
 	int locks[BTRFS_MAX_LEVEL];
-#endif
+
 	signed char reada;
 	/* keep some upper locks as we walk down */
 	u8 lowest_level;
@@ -145,8 +163,21 @@ struct btrfs_path {
 	 * set by btrfs_split_item, tells search_slot to keep all locks
 	 * and to force calls to keep space in the nodes
 	 */
-	u8 search_for_split;
-	u8 skip_check_block;
+	unsigned int search_for_split:1;
+	unsigned int keep_locks:1;
+	unsigned int skip_locking:1;
+	unsigned int search_commit_root:1;
+	unsigned int need_commit_sem:1;
+	unsigned int skip_release_on_error:1;
+	/*
+	 * Indicate that new item (btrfs_search_slot) is extending already
+	 * existing item and ins_len contains only the data size and not item
+	 * header (ie. sizeof(struct btrfs_item) is not included).
+	 */
+	unsigned int search_for_extension:1;
+	/* Stop search if any locks need to be taken (for read) */
+	unsigned int nowait:1;
+	unsigned int skip_check_block:1;
 };
 
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) \
-- 
2.40.0

