Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787202CDD7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502028AbgLCSZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502021AbgLCSZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:11 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C34C08E85E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:17 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so1443076qvb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOdTaGLj82z5oYT5RFXY3u1vGDFWSx78SY5hlvg+0k0=;
        b=ndB3eegJkfZOZ1c6g6D6WcLhEDlbIbCWP/4CSYCxIKF5pRfke7wNz+84fHf7HJDSXx
         QCNxQUwnF3QMRCSsLDZGKPcgCXM62vhVU/bG6FMcHE4ktemZuXO0JkkIvBLWBtJxTuWG
         AR2zKHvrzdaMogCUqk8+18kLonVRXs9zwxbYoR+qakXNBMQkYh0gOSVMkRI6J7nm8N4W
         /4re+UK1UQxDCnmkuZPGoG9a+Qg8DqcxG/qjbwSuAorRQJ81jz95oIapESQMe99iHzEU
         L0e2ZyKNhUF86FJRE6XYPrTm+Zt7GDPJd+b2ya08G63fIN1R6K2XncFQonsq6mWFkaoU
         wa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOdTaGLj82z5oYT5RFXY3u1vGDFWSx78SY5hlvg+0k0=;
        b=VfyX0MugFmAziXYmyFagXuD73MFk0jxm1CO/A/NFHox0NfqM6i7uUPTizGZOG55aX1
         rxp0IG21qGt6p1rTFg/awK4d44BQEX018U/J0B2rQD1sHwwHznRIamwvmKOP/h9NjYRU
         QzI4PeWY42td6fEqjvD0GIcjefZ9GtSQRkntb0vkDn0MT/SfVwp/qU2/cuQQlzKMx59e
         UQ4CigVbld41PvAlkSA+vR24GaM15nDwJtqOF8evecfLUmG6cQemLwqMBkbwheKLX07a
         85nhiuzyAwJ6bosd91YG9mU3jtbGBto8Y/FPItIQSIWJHKvko2hch+woDZx5j2jMOEiz
         hPHQ==
X-Gm-Message-State: AOAM5318SdCOuo9rnekuI/0nQuT4thI80/EZ1O5OptLIfaEk3yjwJ8DJ
        yvNcPuhrdsgA1bqqBRNbjC2DfkGBDMD38kJE
X-Google-Smtp-Source: ABdhPJzOQmIqkQKvouCECMfxvN3UZExouTRKl1MtofU+ORebJVpVVaxuLutGvfwRhhWCqrkmMAi9MA==
X-Received: by 2002:ad4:4e13:: with SMTP id dl19mr276239qvb.53.1607019856307;
        Thu, 03 Dec 2020 10:24:16 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm2041444qti.45.2020.12.03.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 43/53] btrfs: remove the extent item sanity checks in relocate_block_group
Date:   Thu,  3 Dec 2020 13:22:49 -0500
Message-Id: <07befea169b06441a736021da2b5ba4d8e295d6d.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These checks are all taken care of for us by the tree checker code.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bff7e99f3654..5227b4f7d115 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3363,20 +3363,6 @@ static void unset_reloc_control(struct reloc_control *rc)
 	mutex_unlock(&fs_info->reloc_mutex);
 }
 
-static int check_extent_flags(u64 flags)
-{
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if (!(flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    !(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK))
-		return 1;
-	if ((flags & BTRFS_EXTENT_FLAG_DATA) &&
-	    (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))
-		return 1;
-	return 0;
-}
-
 static noinline_for_stack
 int prepare_to_relocate(struct reloc_control *rc)
 {
@@ -3428,7 +3414,6 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
 	u64 flags;
-	u32 item_size;
 	int ret;
 	int err = 0;
 	int progress = 0;
@@ -3477,19 +3462,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_extent_item);
-		item_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
-		if (item_size >= sizeof(*ei)) {
-			flags = btrfs_extent_flags(path->nodes[0], ei);
-			ret = check_extent_flags(flags);
-			BUG_ON(ret);
-		} else if (unlikely(item_size == sizeof(struct btrfs_extent_item_v0))) {
-			err = -EINVAL;
-			btrfs_print_v0_err(trans->fs_info);
-			btrfs_abort_transaction(trans, err);
-			break;
-		} else {
-			BUG();
-		}
+		flags = btrfs_extent_flags(path->nodes[0], ei);
 
 		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			ret = add_tree_block(rc, &key, path, &blocks);
-- 
2.26.2

