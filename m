Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342FE77FF65
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355091AbjHQU6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355087AbjHQU55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:57 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775F3589
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58d31f142eeso2725997b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692305875; x=1692910675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFsoj2bGHuawzfa+zUhKvIIj9PfIvsu28Gen0/mSx70=;
        b=U2tR5hn/LI1Xhws11RPv2sVVDeidRq12ZbaXBEsx2t0mayNOt41LzHC0IjF5YbOkyo
         pNUVC+ZEGaoIG3CgsCxUZphc93mX+iW8idZnyuNjV+MblXr3yFrWhZ/+1O1Izza9cvUK
         2JlXP4NKIj0xh81sE8G9iOGwLd4bLsryPMN5XjsQdIebuP6gv+Agy7GjJeNZR70leqxy
         tmkeXHtZgA+SzgP1JztQo5wQjTTOo2OR5bTEjvuYOpwEErVE/vuWZv2+4IVT7jUcZeEW
         3yjA0x+UCguKqir7XKofPEKDnUqNYWnOJRggqEuvzOGmuZ7t+quq2AZFSj48m205f2w0
         lhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305875; x=1692910675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFsoj2bGHuawzfa+zUhKvIIj9PfIvsu28Gen0/mSx70=;
        b=V2nOw+cT+5d750pIyAoVu/NH+GGSvj0Q+kIc5nZItSn1ClyL2dVvkIjE/t0rMZ/wuB
         QohjbytA5815d07QASsMZ0W6/SzUiKrra8rfLZwn5pzAvZ+D8J+2IkpzlRcsYiM+YLuC
         dvA7xCnBtMj7u84UOZKAvpD1hEt+rMbGQPBPsYzEf7IBgfSdVuZekX0cY2+rFbpBvUX2
         YPh46Cetnt6h4zdNg25gevczq7sxWXQyC8Eo37swA0jrwDr53nt84/U8yGojH5Up3GLU
         nWKD9SlMYrGs4azslXZ+S9MMs3ETxw3Zg2v/jZ7MWuWW7HztthelbQpmWSM4kMGVdtHZ
         MJJA==
X-Gm-Message-State: AOJu0YwUytFYxn7zyhbdzN2qb2PQDYxi3/wBcjiQeIWByET/N0WeLWnv
        gmtMFBIDfnm0gB9vDNvm8kD+pinz9KIOldyubIQUpA==
X-Google-Smtp-Source: AGHT+IGfeCFW8V6DfqAFPxL1xzAuz77MY1iJS3ET+uNl6DvD93rYAeAdjYko6ViH9qqiKLiAYBH+FA==
X-Received: by 2002:a0d:ca82:0:b0:577:4387:197c with SMTP id m124-20020a0dca82000000b005774387197cmr508502ywd.16.1692305875073;
        Thu, 17 Aug 2023 13:57:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j195-20020a8192cc000000b00576c727498dsm99318ywg.92.2023.08.17.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:57:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: add a self test for btrfs_add_extent_mapping
Date:   Thu, 17 Aug 2023 16:57:32 -0400
Message-Id: <cc5a97b95855d170aecb76ae358c6dfc08e47559.1692305624.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1692305624.git.josef@toxicpanda.com>
References: <cover.1692305624.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This helper is different from the normal add_extent_mapping in that it
will stuff an em into a gap that exists between overlapping em's in the
tree.  It appeared there was a bug so I wrote a self test to validate it
did the correct thing when it worked with two side by side ems.
Thankfully it is correct, but more testing is better.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/extent-map-tests.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index d5f5e48ab55c..18ab03f0d029 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -656,6 +656,60 @@ static int test_case_5(void)
 	return ret;
 }
 
+/*
+ * Test the btrfs_add_extent_mapping helper which will attempt to create an em
+ * for areas between two existing ems.  Validate it doesn't do this when there
+ * are two unmerged em's side by side.
+ */
+static int test_case_6(struct btrfs_fs_info *fs_info,
+		       struct extent_map_tree *em_tree)
+{
+	struct extent_map *em = NULL;
+	int ret;
+
+	ret = add_compressed_extent(em_tree, 0, SZ_4K, 0);
+	if (ret)
+		goto out;
+
+	ret = add_compressed_extent(em_tree, SZ_4K, SZ_4K, 0);
+	if (ret)
+		goto out;
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	em->start = SZ_4K;
+	em->len = SZ_4K;
+	em->block_start = SZ_16K;
+	em->block_len = SZ_16K;
+	write_lock(&em_tree->lock);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, 0, SZ_8K);
+	write_unlock(&em_tree->lock);
+
+	if (ret != 0) {
+		test_err("got an error when adding our em: %d", ret);
+		goto out;
+	}
+
+	ret = -EINVAL;
+	if (em->start != 0) {
+		test_err("unexpected em->start at %llu, wanted 0", em->start);
+		goto out;
+	}
+	if (em->len != SZ_4K) {
+		test_err("unexpected em->len %llu, expected 4K", em->len);
+		goto out;
+	}
+	ret = 0;
+out:
+	free_extent_map(em);
+	free_extent_map_tree(em_tree);
+	return ret;
+}
+
 struct rmap_test_vector {
 	u64 raid_type;
 	u64 physical_start;
@@ -836,6 +890,9 @@ int btrfs_test_extent_map(void)
 	if (ret)
 		goto out;
 	ret = test_case_5();
+	if (ret)
+		goto out;
+	ret = test_case_6(fs_info, em_tree);
 	if (ret)
 		goto out;
 
-- 
2.26.3

