Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9023726E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFFLG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:06:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbfFFLG0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:06:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C2E2CAE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:06:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs-progs: image: Use SZ_* to replace intermediate size
Date:   Thu,  6 Jun 2019 19:06:03 +0800
Message-Id: <20190606110611.27176-2-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/metadump.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/image/metadump.h b/image/metadump.h
index 8ace60f5..f85c9bcf 100644
--- a/image/metadump.h
+++ b/image/metadump.h
@@ -23,8 +23,8 @@
 #include "ctree.h"
 
 #define HEADER_MAGIC		0xbd5c25e27295668bULL
-#define MAX_PENDING_SIZE	(256 * 1024)
-#define BLOCK_SIZE		1024
+#define MAX_PENDING_SIZE	SZ_256K
+#define BLOCK_SIZE		SZ_1K
 #define BLOCK_MASK		(BLOCK_SIZE - 1)
 
 #define ITEMS_PER_CLUSTER ((BLOCK_SIZE - sizeof(struct meta_cluster)) / \
-- 
2.21.0

