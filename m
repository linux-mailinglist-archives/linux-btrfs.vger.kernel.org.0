Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF086DCDB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442946AbfJRSQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 14:16:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442935AbfJRSQA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 14:16:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 281DBB31B;
        Fri, 18 Oct 2019 18:15:59 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] btrfs: Do not check for writeback in btrfs_releasepage()
Date:   Fri, 18 Oct 2019 13:15:44 -0500
Message-Id: <20191018181544.26515-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018181544.26515-1-rgoldwyn@suse.de>
References: <20191018181544.26515-1-rgoldwyn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

We check for PageWriteback in try_to_release_page(), the
sole caller of address_space->releasepage(). We don't need
to check it again in btrfs_releasepage()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f2754eaa05b..10303c2379a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8793,7 +8793,7 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 
 static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
-	if (PageWriteback(page) || PageDirty(page))
+	if (PageDirty(page))
 		return 0;
 	return __btrfs_releasepage(page, gfp_flags);
 }
-- 
2.16.4

