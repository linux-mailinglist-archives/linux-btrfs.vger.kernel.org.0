Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872EC476271
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhLOUAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:08 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C4C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:08 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id f20so23075136qtb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=mzYzF79ArM/gJ2n/uBtdA7txrPARLtkbHuQykyevPiHBkmwjaepWP8WJKEz7ImqXT3
         wnS+cv2GIhJVOO0xz8u7bePIzgLrJ7GfYfY1oo2uLaaz0Ze6cogfCmXJyYfKuL0crQkN
         n/oXmzKyIbHkBQjHY1CSBRVDDQHoCRf/YFfGRj0W44h0EPLl7J4O6qzSBaZrc5im1Ua5
         7qb2GZhlzrWwf9mpyyrvj7lnpflTpjJBNDOc5ggtmj5gAoW6DqR05WAFnNKE9kCvWAHw
         IIJmJJImSjSPCc3qehMhfyTMn2pXCge0x1twjgxM+ga+GN3PosyevtGz0YcEvFNfYLDj
         eM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=Xkz0CvmbHBnT9y+jpEx0eHvneEfcrN0ls945YR1QuqWoqfBqJCTGb8laSTDkUPjyuM
         R5ey3qrPnh2TXUcwQjRoiro4rDaYfFAltTNux/q0SXuuYXTwHTB7os6pxzNuATIj1TXd
         K4bCNhRnyi+5e/TUcdZrlNTm6/Acnz3sUnmQ9Ps26yK+3DG5oxmNZB0qgY1GTgVGnDom
         osUY0IcejRCAPkBbGxGZjGj1BHJUcnEuc5YeSnoGOfMorl0nyJLJE1/4jIrkn1CZg5cR
         W0oLgfY8d5QAUkdot7wEsSXcdV6qZDQnt7Ogg9rn1dFReRA6GfsovEmiJ4PwME/mQ6Z8
         +SUg==
X-Gm-Message-State: AOAM533rblmGa2WRC+yiqKQxcBwB3KBEiO9ZUy1cBI9k/60/Tiun+ADy
        SUpvLHF2pRvfTmzyYbltgDmEg2VPLkuDlw==
X-Google-Smtp-Source: ABdhPJwxEsuuzFq18cJWCmVqI5XEbO1chY2Oxq26lLWRx9fXo1EBGzgGBF9+/CdWuKs01JNobL373w==
X-Received: by 2002:a05:622a:14c9:: with SMTP id u9mr14118644qtx.164.1639598407568;
        Wed, 15 Dec 2021 12:00:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t6sm1641966qkj.33.2021.12.15.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 11/22] btrfs-progs: qgroup-verify: scan extents based on block groups
Date:   Wed, 15 Dec 2021 14:59:37 -0500
Message-Id: <87e23f37583d349f4827cb30cd9667d7c31aaada.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we switch to per-block group extent roots we'll need to scan each
individual extent root.  To make this easier in the future go ahead and
use the range of the block groups to scan the extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0813b841..45007d8c 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1400,6 +1400,7 @@ static bool is_bad_qgroup(struct qgroup_count *count)
  */
 int qgroup_verify_all(struct btrfs_fs_info *info)
 {
+	struct rb_node *n;
 	int ret;
 	bool found_err = false;
 	bool skip_err = false;
@@ -1430,10 +1431,17 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 	/*
 	 * Put all extent refs into our rbtree
 	 */
-	ret = scan_extents(info, 0, ~0ULL);
-	if (ret) {
-		fprintf(stderr, "ERROR: while scanning extent tree: %d\n", ret);
-		goto out;
+	for (n = rb_first(&info->block_group_cache_tree); n; n = rb_next(n)) {
+		struct btrfs_block_group *bg;
+
+		bg = rb_entry(n, struct btrfs_block_group, cache_node);
+		ret = scan_extents(info, bg->start,
+				   bg->start + bg->length - 1);
+		if (ret) {
+			fprintf(stderr, "ERROR: while scanning extent tree: %d\n",
+				ret);
+			goto out;
+		}
 	}
 
 	ret = map_implied_refs(info);
@@ -1507,6 +1515,7 @@ static void print_subvol_info(u64 subvolid, u64 bytenr, u64 num_bytes,
 
 int print_extent_state(struct btrfs_fs_info *info, u64 subvol)
 {
+	struct rb_node *n;
 	int ret;
 
 	tree_blocks = ulist_alloc(0);
@@ -1519,10 +1528,17 @@ int print_extent_state(struct btrfs_fs_info *info, u64 subvol)
 	/*
 	 * Put all extent refs into our rbtree
 	 */
-	ret = scan_extents(info, 0, ~0ULL);
-	if (ret) {
-		fprintf(stderr, "ERROR: while scanning extent tree: %d\n", ret);
-		goto out;
+	for (n = rb_first(&info->block_group_cache_tree); n; n = rb_next(n)) {
+		struct btrfs_block_group *bg;
+
+		bg = rb_entry(n, struct btrfs_block_group, cache_node);
+		ret = scan_extents(info, bg->start,
+				   bg->start + bg->length - 1);
+		if (ret) {
+			fprintf(stderr, "ERROR: while scanning extent tree: %d\n",
+				ret);
+			goto out;
+		}
 	}
 
 	ret = map_implied_refs(info);
-- 
2.26.3

