Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911A92DC445
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgLPQ3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLPQ3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:29:01 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BEC0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:42 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so23034906qke.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fUKDCc8CueRAdMqhIUwECuXtti47UXT5Jx1635pIaU=;
        b=mbCJP+OkepipsqXPPn9kzVJ5yxCPI/rIrddIl+UETYPTJ2V3aOiIz/09NIPGItdHsC
         sFjbjltYGH1qR5OiwMl/XCJMXHIiTjFVt45j/R2zgkToClWUrov+5MqC5k2f597WHvHK
         Tx6Z9I8WtMcO6dt/2hAaos7INQG+DqRy2qIP6kYuzRsNvGJ0pE3oYzFyHBLWy+H4ysLN
         n9xTIRRruNC0Uh7uxIUc26YxQme8gNcI4/OUdQh8easjXNNIOaj0ftWe16rEJPfmPSZc
         K6mfyzefxoW+1vwCSCPly2GoTmfthfiIJBRYuv/+mXtfBCJxkcZYS5q9wYL37X0a21T0
         dmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fUKDCc8CueRAdMqhIUwECuXtti47UXT5Jx1635pIaU=;
        b=TaRYtmguRYHFHqpiZcReIG8PWAEoYORlpbm+2um/Xq4KYKVxFCgQpPjAF+q8ctA5Wd
         dP0c9DVGEtFKwo0R0NTnuer1j8r/eH2/iJdIVkV0jVXtEoj1DCsXDZ9fdau6A7SfX9Iq
         z23KTbCqhmFL1x1epURXoifWtabsgxb0QrNUnx4+wPAhOlCS8PrZdqVOSiHNQqY49u/9
         EzMDR9NXn6NpUnTVMVHZ0/FDZ7Bo4LZJDj3ko1Uz9+Qz3F5FHgtSEjedvQnK2nOX8+64
         2jVe//lrDoRPHYYyzhnMck5KpL2BDItkdwRrv5EU1etpP79BlSP/PccY2+iuoekRKpkC
         neCg==
X-Gm-Message-State: AOAM532InHSWbk8DmP/CT1TSfCYXb8bxaLll6ivSN4NcXFtMwe8kZCEo
        n7RT46C5myjvryjg/rlMG/1y57pYzwhmDwZ1
X-Google-Smtp-Source: ABdhPJxj6ZdEStcu0v9iL0s0kjf0gxQlAZjT2Yvnp/vHUXLq0wi3F21ijTy88GO+2idEQ+ASabjzzg==
X-Received: by 2002:a37:a651:: with SMTP id p78mr44014709qke.293.1608136061698;
        Wed, 16 Dec 2020 08:27:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y187sm1393511qkc.120.2020.12.16.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 26/38] btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
Date:   Wed, 16 Dec 2020 11:26:42 -0500
Message-Id: <fa22f7dfa61351f07722e13b93e7a17cc896725b.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few BUG_ON()'s in replace_path are purely to keep us from making
logical mistakes, so replace them with ASSERT()'s.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 73c8cc502b07..574ae3f43e33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1212,8 +1212,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	int ret;
 	int slot;
 
-	BUG_ON(src->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
-	BUG_ON(dest->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(src->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID);
+	ASSERT(dest->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
 
 	last_snapshot = btrfs_root_last_snapshot(&src->root_item);
 again:
@@ -1244,7 +1244,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	parent = eb;
 	while (1) {
 		level = btrfs_header_level(parent);
-		BUG_ON(level < lowest_level);
+		ASSERT(level >= lowest_level);
 
 		ret = btrfs_bin_search(parent, &key, &slot);
 		if (ret < 0)
-- 
2.26.2

