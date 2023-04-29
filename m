Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B576F265D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjD2UUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjD2UUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:32 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7FE79
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-559debdedb5so14158937b3.0
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799631; x=1685391631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNKI1mkk4Olz7aQqBRv928o21xDlQhzLeZwjDxJD1Vo=;
        b=gLQrIyf+GI3Ij1ziUTvWZF2pzY+KFMppnwezAw/FgdGhivrhzP6JU2Oc//3Ofywk6w
         ls6VBTiLI1gJ/0mX4QwAvaBbQLyGqJtX7PhwNSs5pzyVVUb5i5F/+8LWPEeMCzmtvZgU
         v9e8OhkrEswH7JiU7BA3hsOFHeLh7g6SPVEl/gfsMjPrDv43Ic+c9VCG5bfSf/40epFQ
         qQ+syOHU5ih2fIMO2DGtd3GgdSYy7uzmUdjsbBcrIWP4HGvcoMO70eAM43MFWY1VdF1G
         xeI+sBpgzTiC5m/cCFZZ04ou9tz+3KeazbHJJLMVHZIddRv0HoQegOE6KYinUmuEYmo0
         RExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799631; x=1685391631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNKI1mkk4Olz7aQqBRv928o21xDlQhzLeZwjDxJD1Vo=;
        b=LGbFU/agWFpyAkEbKP+XBHj0256YfqCh8yWHXQ+Tbj3TcbWsHS11X5nLwYOGxr2PmN
         wqsxV1cAuAp5IybhaZwkPrlU9dRnmGw/ZbQ537Vph1KCLXn/ufLttSWvacKOqhsZ/qJB
         ZZ5GXIy22/zAfzVhtF1OnDHivBWaJ9gjWpwtsjhZl+vKe8P/tsiE5KZiC+Pg43moaAvl
         LoBbIKc++hpMKrABGiICEwwf47crT5C0DFxFX/Hpw8FhLgKYuQ0q91qQtPE3xHXy67YJ
         PrCeRAx81+SoYgiiunyG2dvThr5goLCxN+LKL4SFxuMjRU+xD0S4MrixP0+dLs2TcjTV
         jS1w==
X-Gm-Message-State: AC+VfDzurKdISB5DanM7Qbrc7c8imp2yHxd/w+e6kFJ4UCFma5V9dUgZ
        97RhDqSjtSsQGWd7O399Brno8ndQbeQzo50jPRqHlQ==
X-Google-Smtp-Source: ACHHUZ6aanWFGrx0mDuGkKblELhM6ULYCqPTG4p0Ui7VjK6p7gWii5JyTOyPQc0Gpifg+CDEiuPqhQ==
X-Received: by 2002:a0d:d54f:0:b0:54f:c68f:dc40 with SMTP id x76-20020a0dd54f000000b0054fc68fdc40mr8217696ywd.39.1682799630713;
        Sat, 29 Apr 2023 13:20:30 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z66-20020a0df045000000b0054f56baf3f2sm6249686ywe.122.2023.04.29.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/26] btrfs-progs: use path->search_for_extension
Date:   Sat, 29 Apr 2023 16:19:54 -0400
Message-Id: <373d0890a6c4f320006c3600d223ad64a3597f69.1682799405.git.josef@toxicpanda.com>
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

This flag is used by the kernel btrfs_search_slot to make sure that leaf
splitting decision doesn't subtract the size of an item.  This is for
inline extent items and csum items where we know we're going to find the
item we want, and we're only going to want to extend it.  Currently this
flag doesn't do anything, but when we sync ctree.c we'll stop making the
right decision WRT the leaf space, so add the flag usage in the places
we need it so we can sync ctree.c easily.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c | 8 ++++++--
 kernel-shared/file-item.c   | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index a9f3eba6..e29a1cb4 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -882,10 +882,12 @@ static int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	key.offset = num_bytes;
 
 	want = extent_ref_type(parent, owner);
-	if (insert)
+	if (insert) {
 		extra_size = btrfs_extent_inline_ref_size(want);
-	else
+		path->search_for_extension = 1;
+	} else {
 		extra_size = -1;
+	}
 
 	if (owner < BTRFS_FIRST_FREE_OBJECTID && skinny_metadata) {
 		key.type = BTRFS_METADATA_ITEM_KEY;
@@ -1023,6 +1025,8 @@ again:
 	}
 	*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
 out:
+	if (insert)
+		path->search_for_extension = 0;
 	return err;
 }
 
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index fd6756e9..d6d01198 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -268,8 +268,10 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	 * enough yet to put our csum in.  Grow it
 	 */
 	btrfs_release_path(path);
+	path->search_for_extension = 1;
 	ret = btrfs_search_slot(trans, root, &file_key, path,
 				csum_size, 1);
+	path->search_for_extension = 0;
 	if (ret < 0)
 		goto fail;
 	if (ret == 0) {
-- 
2.40.0

