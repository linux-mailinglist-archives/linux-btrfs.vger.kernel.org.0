Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0494A44CA25
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhKJULI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:07 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C1C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id bl12so3626750qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HderzC9/RDk4CTSGRJpYRgZavYuPrv2WC7zC5JM8ZhQ=;
        b=24qMO1lJDJlHMQpqFCyRrX+CGU2EacKGEwUBAdBSWZ/NMC80w9hcsIV5hlhdef1gLJ
         qfl3fnbIKM5CyB+2G0dKHBMtSJfxPeHa2eVTPuUAmEto6kWPIG49D0D3RPi+zqI03uLE
         pbGTRRSr8EoGk42Op/VAbyR0uxh6JlGRxmcryH2Vhp2kc8pIGgB8+2mA/TdY1Xw/dUpu
         ui0qG6kd5HBs69HnaDqIfXBBWt2escRB5SQ/xcR+5lLZimrOSKReXqIfjg+bIpfTJYFi
         82Zr4YoBjwFZrv+goR9i+P4t/qPuLH/i4dFheRTMWjP1xgtH3/wv1EIfBXJFPM0pLL+i
         xELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HderzC9/RDk4CTSGRJpYRgZavYuPrv2WC7zC5JM8ZhQ=;
        b=rv3MfK9UspgCyJDZmubX2a9DipiG4KlaOA1l1GAbSMxgM77D1hrnJMh9I+Hk5kM8Uo
         W0Qrs43jmv4MyQenk8Ga5XNDwLlYLJHye5/8NupKVEad+7EvKiKML4TxhZ/+hkgiswAs
         nCAA+taOylyQ1RjAyJiOKslYGrus/YPo7bAovSRNL/W4GHNKvmO9e7U4fbHeeNgPwYqu
         YBS0j5HRM0Wcs45mVXAyr2bOm/3GSJMXK5WQ+v4ydIYo3Qfr91lD12xplkIROYkZ6Ump
         G2W0TVuNaAB5r5Y7HFxqnWVwLWZzxdXGxHK5htXvSUu/ZQ0CTd4obB/lsMOn+Ld1StUx
         cCxw==
X-Gm-Message-State: AOAM533dvwLhGklGS7w4Yfp1tepw85wYGmrdBSoqz8EeikkI/oywUos6
        ocb7JUIbEPz7q4XoDNtsaoKT2CSVoVFeyQ==
X-Google-Smtp-Source: ABdhPJybNCTX0TaAz+vhgJIQFTdL6lIbEt17Kz+CvJnohw49VXvy5wUqTwLkqbgDF1b68s2BSnkp7A==
X-Received: by 2002:a37:2e81:: with SMTP id u123mr1739959qkh.156.1636574898549;
        Wed, 10 Nov 2021 12:08:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x188sm378779qkd.31.2021.11.10.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 07/13] btrfs-progs: check: stop passing csum root around
Date:   Wed, 10 Nov 2021 15:07:58 -0500
Message-Id: <d5953c50a35bb60c0d8bbf3610847300f068d63b.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
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

