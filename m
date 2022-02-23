Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FF4C1B66
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiBWTHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 14:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbiBWTHY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 14:07:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F139132ECD
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:55 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t21so5229164qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9gq+UaKOqGXi8IJZ4BiCXybhej9h4jUKvAC5mlr+miw=;
        b=SGcMGz7j+rhepYC/i6MLLjXq0tr65zgNqef4TCJ0xLtR17emDqpOSH8vg+scTGJjOF
         lXYdg5VFnvZUz6kV2Apa5yyjWm8Mmc6LlkQreBf+eCjBUM+ERou+V0qGpdni8oqLA2AL
         UKBa8az20XIPUBBP4GJJ9+9cNKgsdsyggIxb9O8GyP1OJHIPif9oeUbLf0nrQZBOju7/
         7g2m5dSgBx1UzVmamdit8YrpLufhRaRVFh3nhxNMR1iVhmbI6BqHLST+vrP0g21JIkTe
         xzpgBRlDzJReZzyD+BKpW0s+bdnRajyt6tTF7Ja4FOknUjAxY/bP8BEB0Rub5Lv8YJEs
         oGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gq+UaKOqGXi8IJZ4BiCXybhej9h4jUKvAC5mlr+miw=;
        b=aL7L3dD7cVIkLlFelf/ySfbsgjzo1GFmPEy7l8VZoboJqEFHMZYLJ9UAm8aN95zh8P
         gRSikE2Sm0FqGD4dcKWnEyT7lKg9YRH+Xh0Ig2gY7cjDf1L5fwjyIFoFKpZV6u+zB2Tm
         HwJZrC7uh/A9WHaxlFHZrhgNw9ebhyzRJvJuQCOw+x9vLy0PaIO2rC8Q7JsiFmDT3lz8
         /tPrprMkYrWAYq1EhilFdxBGNb7GUBTHicRTCObXD1qbzNb598/YAMmwbQPS8GaDuVaq
         gorC24eRGG53I+BwkrFteJ6jCLNlWG/9kwoU1c79cW+zt6eDJEu18gCNfLTiEgcxSugW
         ZADw==
X-Gm-Message-State: AOAM531KkQjxWrA/gyxvxlrR6hcbesmtd3LQfuLCIvtDaQxYG5BiQ0Ie
        jZg1YjZF4y/46gZbQMfOTQ2q7sbWeonMtvbM
X-Google-Smtp-Source: ABdhPJx1p62WctTVIAtvyTKmG3xoHvpAq0S5t4lOoiyBm7M8hNjRElO0prc6KBdNcU4lI6kvRu/cqg==
X-Received: by 2002:a37:909:0:b0:62c:e1df:905d with SMTP id 9-20020a370909000000b0062ce1df905dmr791769qkj.748.1645643214195;
        Wed, 23 Feb 2022 11:06:54 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e7sm324999qtx.77.2022.02.23.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:06:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: add a do_free_extent_accounting helper
Date:   Wed, 23 Feb 2022 14:06:46 -0500
Message-Id: <d4400ec6d73bb7b4e3668635fffc67fd7c7f67a7.1645643109.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645643109.git.josef@toxicpanda.com>
References: <cover.1645643109.git.josef@toxicpanda.com>
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

__btrfs_free_extent() does all of the hard work of updating the extent
ref items, and then at the end if we dropped the extent completely it
does the cleanup accounting work.  We're going to only want to do that
work for metadata with extent tree v2, so extract this bit into its own
helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4ec03d004040..7e162d2dfd33 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2854,6 +2854,35 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
+static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
+				     u64 bytenr, u64 num_bytes, bool is_data)
+{
+	int ret;
+
+	if (is_data) {
+		struct btrfs_root *csum_root;
+		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
+		ret = btrfs_del_csums(trans, csum_root, bytenr,
+				      num_bytes);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+	}
+
+	ret = add_to_free_space_tree(trans, bytenr, num_bytes);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	return ret;
+}
+
 /*
  * Drop one or more refs of @node.
  *
@@ -3179,28 +3208,8 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 
-		if (is_data) {
-			struct btrfs_root *csum_root;
-			csum_root = btrfs_csum_root(info, bytenr);
-			ret = btrfs_del_csums(trans, csum_root, bytenr,
-					      num_bytes);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
-		}
-
-		ret = add_to_free_space_tree(trans, bytenr, num_bytes);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
-
-		ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
+		ret = do_free_extent_accounting(trans, bytenr, num_bytes,
+						is_data);
 	}
 	btrfs_release_path(path);
 
-- 
2.26.3

