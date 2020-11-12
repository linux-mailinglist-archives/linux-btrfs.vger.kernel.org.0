Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0202B03C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgKLLYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 06:24:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKLLYG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 06:24:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605180244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+/20je/Atk4ofGQjNYhzZeu/gbrYu2nbwSb8kATsNA=;
        b=KxMsV52SGuCP/w0s8QyjJqV3h75nFQ6j2LOVh6Qe6EbQwzComCN52ZHPWbVmadw2LnVTWc
        U4H1446oNdCcaRYKHYLlwlbbL8v4dye50AxPF/sPi8kEDsZC/dOuO/jDgQ/rSOGHsNN0bd
        9btOzMwNAdVKDGeK3LZmuVkgeD18fKA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FEF6AE95;
        Thu, 12 Nov 2020 11:24:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove useless statement in split_node
Date:   Thu, 12 Nov 2020 13:24:02 +0200
Message-Id: <20201112112402.784923-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the point when we set 'ret = 0' it's guaranteed that the function is
going to return 0 so directly return 0. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6c309dfee3f5..04cff286dcc4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3449,7 +3449,6 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 			   (c_nritems - mid) * sizeof(struct btrfs_key_ptr));
 	btrfs_set_header_nritems(split, c_nritems - mid);
 	btrfs_set_header_nritems(c, mid);
-	ret = 0;
 
 	btrfs_mark_buffer_dirty(c);
 	btrfs_mark_buffer_dirty(split);
@@ -3467,7 +3466,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 		btrfs_tree_unlock(split);
 		free_extent_buffer(split);
 	}
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.25.1

