Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838213F5135
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhHWTYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhHWTYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:24:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B0C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ew6so2545837qvb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JHt8FMUPHDpMNDa+NYtL2FTxurVi8MwpJbnYJJLwias=;
        b=vcA0lNZ5ppRCfSZKu8xzV3wQqGfTRugiO5lSvBWLyFee9OUmqTOmRWM//FZqjAcBqy
         dD2/NSNRSZNXfpeYRBQRoFGeuRU0zaPBiKdr/biD26rjewWeD5+StTpe1fiZ4YLG+d6K
         yX8WGrwdkUZzO/brOPWCnFJZdlDkMMZZeNbJfqeo7J1LCFFZe6+GrOsjgL1CE3rzf+eS
         6wYWucYqfX5ey5/U07LCN/JFwmW2fQr0gx+nwyx1XsffKLBJKHuTH38Y+QAIAC3V9xlE
         VhgRVWBl/JkqdFHIfXZ/iWZ7YaxeoaXxaWDR+NIoO8CaKJisWvZQJkcfTZQq1C9tEPLA
         2KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHt8FMUPHDpMNDa+NYtL2FTxurVi8MwpJbnYJJLwias=;
        b=uYHfwD3BNsXiCGqxwvlYlxH6jFsSaBFvtNNSlBg+6val87wpwIpBnASrHWmNMa++YL
         CsmP39O5bM1uyur6NxQ0suiLTu46YukQajkciLb5P4YaYzBngX9gtZmw0B9mnLXUMVWI
         z9hfYgIbGtJd2Wyw6m8QQB5BYo/HhET2Xsgcwu45FmNfc9kW3gWgNQWWvuYq/FezDhND
         HDUv9P0CnkeGNn9HBJNSPNVRyKnff0PgKkE8wwhO3nNDFEJ4trQcZhNrwHYi17XJ4b0g
         8Flfa8+TzJbWwC+wcKZvePjbknG/DPa0Asc1sCQe/YdXEWjPPWEVO3y9iR4vBEnmAe6F
         MwkQ==
X-Gm-Message-State: AOAM532P7IByxFQZNeGprQcatktFBgZ9CmY/2UN3fZoYR89NlKr/Mx94
        PdGa+4CHA5Uotf724tjwI1Z0VtYWjy5BxA==
X-Google-Smtp-Source: ABdhPJySj30yuGhZAS/+lFKB280Pi2jqR7OoMP02lNLGEzBcXIoL12Is5eBzK4VcTwbnclpxAEtjEQ==
X-Received: by 2002:a05:6214:b69:: with SMTP id ey9mr22028830qvb.16.1629746598063;
        Mon, 23 Aug 2021 12:23:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m19sm6768327qtx.84.2021.08.23.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 12:23:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/9] btrfs-progs: check blocks in btrfs_next_sibling_block
Date:   Mon, 23 Aug 2021 15:23:06 -0400
Message-Id: <0bd15dc74561eba6fd6dc095848e3ba28539d6d3.1629746415.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629746415.git.josef@toxicpanda.com>
References: <cover.1629746415.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By enabling the lowmem checks properly I uncovered the case where test
007 will infinite loop at the detection stage.  This is because when
checking the inode item we will just btrfs_next_item(), and because we
ignore check tree block failures at read time we don't get an -EIO from
btrfs_next_leaf.

This occurs because we allow fsck to raw-read blocks even if they fail
basic sanity checks, because we want the opportunity to repair the
blocks.  However this means corrupt blocks are sitting in cache marked
as uptodate.  btrfs_search_slot() handles this by doing a check_block()
on every block we add to the path, so that anything that is doing a
search gets a proper -EIO.

btrfs_next_sibling_block() needs a similar check.  With this fix we now
return -EIO on btrfs_next_leaf() properly and we no longer infinite loop
on 007 with lowmem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 518718de..0845cc60 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -3125,6 +3125,13 @@ int btrfs_next_sibling_tree_block(struct btrfs_fs_info *fs_info,
 		free_extent_buffer(c);
 		path->nodes[level] = next;
 		path->slots[level] = 0;
+		/*
+		 * Fsck will happily load corrupt blocks in order to fix them,
+		 * so we need an extra check just to make sure this block isn't
+		 * marked uptodate but invalid.
+		 */
+		if (check_block(fs_info, path, level))
+			return -EIO;
 		if (level == path->lowest_level)
 			break;
 		if (path->reada)
-- 
2.26.3

