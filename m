Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A4225589
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 03:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGTBmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 21:42:22 -0400
Received: from mail.synology.com ([211.23.38.101]:39960 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTBmW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 21:42:22 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 5A2BBCE780B4;
        Mon, 20 Jul 2020 09:42:21 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1595209341; bh=SLrfF4eR3nptiWrY3e3mx75vcKFlO2Zr9wLKDegyPfs=;
        h=From:To:Cc:Subject:Date;
        b=NB1LqVv0xHe1DatBWnA0TUVLgTxaOATgspUEwKcdBmOsmO3wWxquYhQMInQeqafwr
         hX/p5HAtiZPvNscEnmbdsbOQQb7T1Rg96aFt6Ogqxsp36Bct+XUV4bvL43stHRyj8Z
         RGdlYNIhCOOG1QM/X1Pi16rrwyLPCKN7daKKDzLM=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: fix page leaks after failure to lock page for delalloc
Date:   Mon, 20 Jul 2020 09:42:09 +0800
Message-Id: <20200720014209.11485-1-robbieko@synology.com>
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

When locking pages for delalloc, we check if it's dirty and mapping still
matches, if it does not match, we will return -EAGAIN and release all
pages.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 68c96057ad2d..22fc47f9c900 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1999,7 +1999,8 @@ static int __process_pages_contig(struct address_space *mapping,
 				if (!PageDirty(pages[i]) ||
 				    pages[i]->mapping != mapping) {
 					unlock_page(pages[i]);
-					put_page(pages[i]);
+					for (; i < ret; i++)
+						put_page(pages[i]);
 					err = -EAGAIN;
 					goto out;
 				}
-- 
2.17.1

