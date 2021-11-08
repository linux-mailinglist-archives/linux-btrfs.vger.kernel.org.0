Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B886C449C6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhKHT3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:43 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1618EC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:26:59 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c12so10124482qtd.5
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HderzC9/RDk4CTSGRJpYRgZavYuPrv2WC7zC5JM8ZhQ=;
        b=VHFehRb8pfiVY+s4YzlpF4G9Dz+R4htgY7jc7YvS5XucbIQwkW4qHpld2vy8DEPze6
         7rZwbj1J+2xQKLnoin4Bh0bnk8AepLaUCHoxbzaUHRAoJPnjr9qrZ3mI0f6lpNfT49Y0
         P3JaFbP8aJ3pmasfztNDVYIn4Ls57DDXyjmj7enK//WxwOTudf4FnPvummumKKAN3rDz
         2OvW8bwSg07JAh0Ik+tSUS1WWdDBJXg/VSsbS57mzeN18XIWKuz1xA9ymg5ESifTSfYo
         HgBJ02uUyQ800q3lrAiFTxAl0qgUEcnlpGA7Q7GCJmBaIV0VLcDB2l9N80QftHeRY8TA
         6JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HderzC9/RDk4CTSGRJpYRgZavYuPrv2WC7zC5JM8ZhQ=;
        b=LvVcc7Cz0P2h4unVq20Hsi7qcBUCr5FtH/zfHiMkunER9y7Bct85RRblh4ZssD8e1C
         kxCDIZHsVm7znURZSTNI3sEIG6V5SP9QqziIlWXZjB2nepQNq1//CuiOKO111+NcuMYI
         Ys1suZNQukPgV/kqgauN2MbOG2PBCzKQH/jPJDuMdkeQxqHqc/2HA+ZMjaN7pmXLsQOM
         Zwj88trFnF7BQeTYuyCFcuLBNRDnlH/HZ1IqZSbq6SGedi79QNX5tSI1Y6veHwPLrXed
         zK7qvg76scKmpkatIpbWvfiL9LTow95zf7aGSXqZP4T3nUEEijhKyQm1S9Uk/SjH0/7N
         ZzUw==
X-Gm-Message-State: AOAM531thmq1uxWVBhWbWjZNcZeCEMohLmMov/rCYW8JfxLaE5bS+Zx+
        zVz0VX65rxjwcxAgGM27nKL4L4Go5fP02g==
X-Google-Smtp-Source: ABdhPJx6G0FtZ0gvLN4/WK5LBdm4H2IodXv/QmqQFUTsrtQ19So3ppUoAyQwTpBMYFwPELLjB8ac7w==
X-Received: by 2002:a05:622a:204:: with SMTP id b4mr2063589qtx.89.1636399618058;
        Mon, 08 Nov 2021 11:26:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j8sm1521738qko.85.2021.11.08.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:26:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 06/20] btrfs-progs: check: stop passing csum root around
Date:   Mon,  8 Nov 2021 14:26:34 -0500
Message-Id: <c8abd3ba407db5983e8bd7c5012b893691083833.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We pass the csum root from way high in the call chain in check down to
where we actually need it.  However we can just get it from the fs_info
in these places, so clean up the functions to skip passing around the
csum root needlessly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
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

