Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7144D2D2F86
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgLHQZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgLHQZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:59 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C6C0619DF
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:24 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id p12so12288521qtp.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEzLYaBG29Bs0WZipCBmBLrRirwLPPLrrLuktteeRZE=;
        b=bP8nr53bw/xQ6Uk0k1aaayS1CAU/vkdvQhgTWdtxUaZ5YDCgDkxpWnx10yUlmAdcdi
         2XmuA1uTH4PZCCK4Lft46LcIb99A01R5lu56rt9lvdRm5ivEB7tQnxhq8amcnQfBjAL6
         ieThDEbR4BfCgfcY+y1E7rpNnxueRPyKFNzxoutrQJjzISKOaZ5/tahHemeoZtaUbIH5
         nYPa9aN+YB3BL37Kpa2VLL3CD3l16vlKuWzgbPYlzXcqF0Z/pnEJuz3BGvW77SRFkdJQ
         EQER8mc/HHQnGHtpEYiSnXOx90SkVBf2BrC07vrPnd8tDENraymxkGhe1GGb2ujdfylB
         SROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEzLYaBG29Bs0WZipCBmBLrRirwLPPLrrLuktteeRZE=;
        b=KxTXBFPnvnX//Cr0n9gaerPWg/AkxNQlWRJDNa36aCAApvDUNbJD9Lbv26aHThK14F
         2+3OKW4pGXCdrAj4rPoW0cuxK4Ddx1mLGzhSAXMD2eNBiAc0xjQGitdaXD48v9Kvy5YK
         S7gWl3gSPdvhYhIfM4NVHJ+a/8hrLKhl3Nj76ehIFvxvBuwJAiInmP6x7BZwyEqqcdqZ
         MeIlLSsVmtR+bBFhVgLiCMl4PepK1lMQ+2dgKuc2wSDEeynTc2Cn8Y47sqsE8pZvplPp
         mWWVxMt0vBX4JuRd5cPtavF9lZ2i2GyAxv7kaSkKvZ7roscyoloHjRJLu6e4JQ4PNQlM
         +sAA==
X-Gm-Message-State: AOAM533TVvEbEB2iqXFyaHnUJ/s81bM1W3z1g735FKD2q4C0RsL0HSuw
        mShSAos5yGUaFtNRtMXNmpkNbs7V68UsWpsM
X-Google-Smtp-Source: ABdhPJwPFtk3kHGbmDrGcGQbHXhgoI88JNik4W97DMhwEkcAcIKwo/gy349/ZL0kC6TAL2ZCD+TAAA==
X-Received: by 2002:ac8:5bd5:: with SMTP id b21mr17417487qtb.392.1607444722981;
        Tue, 08 Dec 2020 08:25:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p62sm14220521qkf.50.2020.12.08.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 37/52] btrfs: handle btrfs_cow_block errors in replace_path
Date:   Tue,  8 Dec 2020 11:23:44 -0500
Message-Id: <22f2fcf516321dee8d3543e295756505784c43a4.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1f1dfa9c74be..8d683056fd9e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1222,7 +1222,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	if (cow) {
 		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
 				      BTRFS_NESTING_COW);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_tree_unlock(eb);
+			free_extent_buffer(eb);
+			return ret;
+		}
 	}
 
 	if (next_key) {
@@ -1282,7 +1286,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

