Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F91F4469B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhKEUbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhKEUbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57875C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:28:57 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u7so8294708qtc.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2BeCkkhFN5j+8LBsWbF9ujUHhrFgTG5V3qbkQhyx8vQ=;
        b=R3aIQG9kzHQXWcbPzWqZrj0TQ4Wo76QPS31Bmf+IsyTNcrt7q1uTdiVO1PZY4t1hYp
         vFyohmPnAJxbZ09eEi7+WyYoNSkdyxpj46q1PrHOlTZQnc1S3OupjC3bGzF7kxgtiAJ+
         eg0Z7lI5wV3s84VJephup0ML2Z1QqRsvWdr+YfsNRaLNGrXJ7N4KM82Is3VthAvou7Rc
         qewMb5B3MxxIo2FM+9KFAFmc0AbnGCl/riic6c9Ud2o7tX/NbaEQQVMJeZ21Q3PY7nDl
         ZnY4hORSuugKp0H4ADw2yv90NArobMda4X8H1NdQsRvqlXWmuMTTsYYK7LorzQ/rEeNt
         yo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BeCkkhFN5j+8LBsWbF9ujUHhrFgTG5V3qbkQhyx8vQ=;
        b=35f4yqq9AsrfiKaTOiqhQXoBlIYalZtSyV1iYUzOICMsvfDOCPSFQHEsc8ia6/Koi2
         +IG1gcVrZZdgkehQYByQXy8RnNVZ1pH2MXKYt3nma6KULIixEdbpbGB2VhUhEouYJQw9
         BnTyzNiCwmE02zcdMu5Jm4IxmuYIseEZFFK46/cJx15gVX9tYwgZg/Q5P0nYoLmcRF48
         EdJ0ouEkKNLYhjGEyYCmNyo+OBPE6+uxRZxZyFO3QWhxVXjJrgYrWK2w1fqR/jkqBCl2
         2rKFzl9wVuTx6ZQ68btgo0PkvPbmUa+L4uGyzvE394TYRo8Fv4IMPSFLuAH1U26x6auM
         VdBw==
X-Gm-Message-State: AOAM530ktHi9sAO3Mx5oIYnY0px076JwttJxtGmEFeI662EWgfyCpNfo
        ecvweIjiqmOEiA5mS4UKEzTpcSf5ncAtcQ==
X-Google-Smtp-Source: ABdhPJzhW1u8aFF/1pUIr/a+d3CdTXVa8hlrgVu4w5m97tGveiHp5u4c0jo2nAG6udJcQmyqkPqmgw==
X-Received: by 2002:ac8:610b:: with SMTP id a11mr63282050qtm.182.1636144136091;
        Fri, 05 Nov 2021 13:28:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j8sm6754244qta.79.2021.11.05.13.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:28:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/20] btrfs-progs: check: stop passing csum root around
Date:   Fri,  5 Nov 2021 16:28:31 -0400
Message-Id: <d3f2065cdfc56e6fe96e7cf1b736899ef7699111.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We pass the csum root from way high in the call chain in check down to
where we actually need it.  However we can just get it from the fs_info
in these places, so clean up the functions to skip passing around the
csum root needlessly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/check/main.c b/check/main.c
index 08810c5f..22306cf4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9494,9 +9494,9 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 }
 
 static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *csum_root,
-				      struct btrfs_root *cur_root)
+					   struct btrfs_root *cur_root)
 {
+	struct btrfs_root *csum_root = gfs_info->csum_root;
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct extent_buffer *node;
@@ -9557,8 +9557,7 @@ out:
 	return ret;
 }
 
-static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans,
-				  struct btrfs_root *csum_root)
+static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_path path;
 	struct btrfs_root *tree_root = gfs_info->tree_root;
@@ -9598,8 +9597,7 @@ static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans,
 				key.objectid);
 			goto out;
 		}
-		ret = fill_csum_tree_from_one_fs_root(trans, csum_root,
-				cur_root);
+		ret = fill_csum_tree_from_one_fs_root(trans, cur_root);
 		if (ret < 0)
 			goto out;
 next:
@@ -9617,10 +9615,10 @@ out:
 	return ret;
 }
 
-static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *csum_root)
+static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_root *extent_root = gfs_info->extent_root;
+	struct btrfs_root *csum_root = gfs_info->csum_root;
 	struct btrfs_path path;
 	struct btrfs_extent_item *ei;
 	struct extent_buffer *leaf;
@@ -9690,13 +9688,12 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
  * will use fs/subvol trees to init the csum tree.
  */
 static int fill_csum_tree(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *csum_root,
 			  int search_fs_tree)
 {
 	if (search_fs_tree)
-		return fill_csum_tree_from_fs(trans, csum_root);
+		return fill_csum_tree_from_fs(trans);
 	else
-		return fill_csum_tree_from_extent(trans, csum_root);
+		return fill_csum_tree_from_extent(trans);
 }
 
 static void free_roots_info_cache(void)
@@ -10700,8 +10697,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				goto close_out;
 			}
 
-			ret = fill_csum_tree(trans, gfs_info->csum_root,
-					     init_extent_tree);
+			ret = fill_csum_tree(trans, init_extent_tree);
 			err |= !!ret;
 			if (ret) {
 				error("checksum tree refilling failed: %d", ret);
-- 
2.26.3

