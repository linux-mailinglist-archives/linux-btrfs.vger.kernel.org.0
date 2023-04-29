Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3E6F263B
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjD2UHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjD2UHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B513A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-559e2051d05so10841427b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798855; x=1685390855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e797+hOoZ44p0ltOywYResV5qPx6dkIgMp8/Q0Strag=;
        b=jqilcQXVrz1lLNtDXuCsF8dhQX23aP6Mg08a7cuRLVxzzXQZQSbW5vjf0qSmySDVEe
         R3KqizyiYGkzFIa9lck3c5By9C+BGMbHqqyqk5bSfsdkJd+GvfsBEMzbSNZMNf4yND4+
         8JZ+p2gtOlTjWTnoV6WruRpC2g2IBWFnYJOYJ9qWHU4wUlkw3n6zTYvQw+4LJFylfkOT
         /Id/nQUyjnSQYJpfqJM0M4pblCJZABMJP+L+/nD0EEXzVqLVo421VEg04PpDv+Hpb6iq
         X1TLTLxLt2cJn4VBPneBvqoHOJH18lTVKNVYERSyjg4Yuq7x03U6Wn83blzRe7Hj2+NQ
         kNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798855; x=1685390855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e797+hOoZ44p0ltOywYResV5qPx6dkIgMp8/Q0Strag=;
        b=OxhawgzLjEbwdH547Fv/oNtKpUwmZXlzFX9IH8flBc6Dqqn9/3qf+/pgAhDwqPp92x
         Wb9JPKocDsIsUYFqOAP+SytXYoccomifc7TbpACP905OFYVq5zczvHvYYD4t85FME6lU
         k74fNAFx8QdhCIrPWMHtl72afc/j79YQhoVJ5eBx2MuLviR9efJFxmwDj5G+80+J6Nl1
         EDxNm2cEQDpa/0sTQyjzOq3R2Ns1naC7aEclqtCAA7s4R1R6vRbhUHkTKndlyxTOcAs2
         kpnwl92cBUjx+CJXPKgvx+gbs3RkR5esXnC2CO9VuhKbyLA6K6mhvJbfAT1vyl7RKWlX
         UqCQ==
X-Gm-Message-State: AC+VfDylwq3H4+sHO/nuXHTyZrFT320DiPz4kyqjWU59IS9zhlzbq58s
        oigm+OItOFhcE/Dcr38kp3yc7UaKZfHE15n/XVjF7w==
X-Google-Smtp-Source: ACHHUZ738KNUfzLanyW7f6LORHrjxjNsNppIx6L4eqs41593y4ERiPqwJ6VvZ+VBm8SGqYuNjZfUcA==
X-Received: by 2002:a81:c30d:0:b0:55a:7c7:7be1 with SMTP id r13-20020a81c30d000000b0055a07c77be1mr905762ywk.22.1682798855166;
        Sat, 29 Apr 2023 13:07:35 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m66-20020a0de345000000b0054bfc94a10dsm6295708ywe.47.2023.04.29.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/12] btrfs: use btrfs_tree_block_status for leaf item errors
Date:   Sat, 29 Apr 2023 16:07:14 -0400
Message-Id: <6536e8136f3da8b002f00151c0a12822792e7d48.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

We have a variety of item specific errors that can occur.  For now
simply put these under the umbrella of BTRFS_TREE_BLOCK_INVALID_ITEM,
this can be fleshed out as we need in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index f153ddc60ba1..bfc1f65726f6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1620,9 +1620,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 /*
  * Common point to switch the item-specific validation.
  */
-static int check_leaf_item(struct extent_buffer *leaf,
-			   struct btrfs_key *key, int slot,
-			   struct btrfs_key *prev_key)
+static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
+						    struct btrfs_key *key,
+						    int slot,
+						    struct btrfs_key *prev_key)
 {
 	int ret = 0;
 	struct btrfs_chunk *chunk;
@@ -1671,7 +1672,10 @@ static int check_leaf_item(struct extent_buffer *leaf,
 		ret = check_extent_data_ref(leaf, key, slot);
 		break;
 	}
-	return ret;
+
+	if (ret)
+		return BTRFS_TREE_BLOCK_INVALID_ITEM;
+	return BTRFS_TREE_BLOCK_CLEAN;
 }
 
 int btrfs_check_leaf(struct extent_buffer *leaf)
@@ -1752,7 +1756,6 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 	for (slot = 0; slot < nritems; slot++) {
 		u32 item_end_expected;
 		u64 item_data_end;
-		int ret;
 
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 
@@ -1813,13 +1816,15 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 		 * may be in some intermediate state and won't appear valid.
 		 */
 		if (check_item_data) {
+			enum btrfs_tree_block_status ret;
+
 			/*
 			 * Check if the item size and content meet other
 			 * criteria
 			 */
 			ret = check_leaf_item(leaf, &key, slot, &prev_key);
-			if (unlikely(ret < 0))
-				return ret;
+			if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+				return -EUCLEAN;
 		}
 
 		prev_key.objectid = key.objectid;
-- 
2.40.0

