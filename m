Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FEF223927
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQKWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 06:22:54 -0400
Received: from mail.synology.com ([211.23.38.101]:39140 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgGQKWy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 06:22:54 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id EA944CE7802F;
        Fri, 17 Jul 2020 18:22:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594981373; bh=Z5PCLAoMJJWbeZBbwVGC1oTpve7cSiYCoUhWGR7eJOI=;
        h=From:To:Cc:Subject:Date;
        b=NjJhnV/4YMB4RWysh2HJ9QKqla9FOVeGB03BQCOk2j4NtMrzDmueUR27VRPpiAZZM
         VYhheMFA7S5bjnuVv2aO6cjGnhFVjxq+lR+Ut0DAp7y47CDrIXbjgxUyLqrd2sUoe0
         J8szpC8lAUkFa8j8ZL7INSe2m/p9Geby7aQoHvWI=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: fix memory leak for page count
Date:   Fri, 17 Jul 2020 18:22:40 +0800
Message-Id: <20200717102240.21742-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When lock_delalloc_page, we first lock the page and then
check that the page dirty, if the page is not dirty, we
will return -EAGAIN but all pages must be freed, otherwise
page leak.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent_io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 68c96057ad2d..34d55b1e2a88 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1951,7 +1951,7 @@ static int __process_pages_contig(struct address_space *mapping,
 	struct page *pages[16];
 	unsigned ret;
 	int err = 0;
-	int i;
+	int i, j;
 
 	if (page_ops & PAGE_LOCK) {
 		ASSERT(page_ops == PAGE_LOCK);
@@ -1999,7 +1999,8 @@ static int __process_pages_contig(struct address_space *mapping,
 				if (!PageDirty(pages[i]) ||
 				    pages[i]->mapping != mapping) {
 					unlock_page(pages[i]);
-					put_page(pages[i]);
+					for (j = i; j < ret; j++)
+						put_page(pages[j]);
 					err = -EAGAIN;
 					goto out;
 				}
-- 
2.17.1

