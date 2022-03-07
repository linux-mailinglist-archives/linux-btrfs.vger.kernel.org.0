Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28BF4D0A93
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245696AbiCGWMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiCGWMN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:13 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6828B6EA
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:18 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d194so3622934qkg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+xGRboLvOe19NHu5ckR8e+LbV55MUEWEYbuk6htAS5c=;
        b=7dpjTDK+XD1yRLILUWM2hGgQcf/bzOW9lRnmOB6SF3owW5+Xz2cYWIXwJ3eeVQc0aD
         siEFEGf+Wm4tfOfqcX6/r4jMWlc2xQiRQqxvVeoUt9Qxheh58oTkNErZo1UCC6S/Hjrw
         7/S4B8B0BfkZmr8g1PQSnKNq9iBZ+YM6GBy0YMGPIJflPSnwS4CBz6p6b8uzm5rqutwq
         f0f1I8Snq5/tTMJPpWWdTTdG+N+M3EWnrj/lnS9ewsbf3ETwb+iNddOoDbL/fbRRPdTW
         0pwV2i26zPbBzw6P5TAN5HSuP6NrxI1KwcGbLWwdXmt84CnW+vacs8cOG0E/FEe7p79V
         we6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xGRboLvOe19NHu5ckR8e+LbV55MUEWEYbuk6htAS5c=;
        b=2Lcni5PmC5BPfAxE+hU5jVSgPRA2trFq8i5sg00YSeYPGyaCXcVc+N5ha8X2yJtPdf
         2HjpLCD3zweO7rPjkA7rDB9GviLvNK8r3TOX9NPQoLLO5vkWYHVLtd6BT9qiq9GjZNTR
         HLOut9ouBooP/MBtRd9MCBWjqJXIb+8PBN77N0h9a0N0nufMt8Q8Pp09YAxArqkMY5g2
         bELSViRs35SLRvvRGZDtfaD1E2YvnOvgrD+jdonSkOdbQDXZoDaOYUSuGP1wOO8ON327
         Bv9pstHWmifeWj69RfQfA9zIh6gJBRtwKhD0oAQiatnNVVKW+uwYuWSV6MqrXYky/nLc
         YaWQ==
X-Gm-Message-State: AOAM532S+0NdbVVZmhRcT7Thur0iO+itgj5LAZ1DlTOwCfpit1v8J1v4
        Z5WdtwLIWud8+PsEAhlLof2e9B8D4Xn7nugL
X-Google-Smtp-Source: ABdhPJydlFV9Ad7XNmqJLukGjJRny8y3kFl3YWSW1N3ddkCGuu+EzG2pidK9rs6epA+QeH9Crb1/vw==
X-Received: by 2002:a37:e209:0:b0:648:b0eb:3bab with SMTP id g9-20020a37e209000000b00648b0eb3babmr8369791qki.229.1646691077308;
        Mon, 07 Mar 2022 14:11:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002de711a190bsm9310218qty.71.2022.03.07.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 08/19] btrfs-progs: qgroup-verify: scan extents based on block groups
Date:   Mon,  7 Mar 2022 17:10:53 -0500
Message-Id: <1b9cb137510a62d0af15663b82cc8a7386d14175.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

When we switch to per-block group extent roots we'll need to scan each
individual extent root.  To make this easier in the future go ahead and
use the range of the block groups to scan the extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 2c05f875..6e012c1f 100644
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

