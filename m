Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3712C4469DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhKEUnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhKEUnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:45 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30953C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bi29so9876066qkb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=aR5jQS8Zx11ayiXlANVEXg+iDYGpzC/9eM7qEUbwprRf1zi6zfYPJxQeyHRhgTsVpM
         ydX2dUmZXy0qUeW2E/oovN/nyWArHKMo0jr5UVsVBRHnJOst/cQajDBQlrT8+Rmja1NI
         OFet/wGUYVVajo6d6YXntT4L9ZXYDchoOOGSzfWRuoBytkRDM43PG0+KJ0wM8U6MgGpu
         9ivS6ZAmMVjH5mj9NZiYrvJ8ZrAUPug/EaP+P/XGjrpAIRzXb3h0q9TE2IIjqKd4qBko
         x+1xOYOmATSLzDIGkzMM3k6UHJI/Lv1suhIJeKYN03c3gNaXPBSDr647nNXDQUvkacih
         Ek8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsHd+omzg3fLiFS+pOt2YWV8wr0jRWzNLntxMRqjGoU=;
        b=pf7hoRhd4aXZ7aGW3u9VOLxzwjKVQ1M9cPicCLvIwB1tuXY5Fcm9I6gMPqPGUXIfS4
         KBJfRlp1vfFp852qYNWMK8NMmpsFh9xeD/Mn+K43F5QiWHuzoWWoJEiQ+m7SA5YcWvdC
         gDRCsYWhleD1w9f8j7iFrJg0jL/M4k1T6AAjJH84972yT9OjXnvKbqeu9yH0ImPAQrc4
         lGcAfIjBv/ByjZb2MYb1Qjw0BEyKDiRVHsEz/H4It12oDnZJyf0v55swKVsBosI+47Ag
         VEL5M3KlhIug77nmfYCuSao8w6eLjTitYpHEuTUHzKjdXXUan/73Q0ZFJt0AjwPIm6is
         YJHA==
X-Gm-Message-State: AOAM532SEbPaPs9EuNQWxeZRaQVjgqkVSNTCabUuerMxO252w7VmcVW3
        eswtjheAByrRkNU7XI2Raf7PgeQYnrBEEw==
X-Google-Smtp-Source: ABdhPJyG9qzwr9DsCpDDIC1ge8MCckBDT0xVjZr0s68/0zsV2lEky9B16LW3PNcfBHk96grxoNGcJA==
X-Received: by 2002:a05:620a:430a:: with SMTP id u10mr50087260qko.53.1636144864096;
        Fri, 05 Nov 2021 13:41:04 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 76sm5007609qkn.77.2021.11.05.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/22] btrfs-progs: qgroup-verify: scan extents based on block groups
Date:   Fri,  5 Nov 2021 16:40:37 -0400
Message-Id: <a8ff11acbbff843d7cfb4f4846c0ba8a57ce058e.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

