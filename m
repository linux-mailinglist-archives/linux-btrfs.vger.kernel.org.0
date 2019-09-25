Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F325BDDDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405483AbfIYMOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 08:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405475AbfIYMOF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 08:14:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 699BAAD4B
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:14:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 03/10] btrfs-progs: image: Don't waste memory when we're just extracting super block
Date:   Wed, 25 Sep 2019 20:13:49 +0800
Message-Id: <20190925121356.118038-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925121356.118038-1-wqu@suse.com>
References: <20190925121356.118038-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no need to allocate 2 * max_pending_size (which can be 256M) if
we're just extracting super block.

We only need to prepare BTRFS_SUPER_INFO_SIZE as buffer size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/image/main.c b/image/main.c
index 7c499c0853d0..162a578a3ff8 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1522,9 +1522,14 @@ static int fill_mdres_info(struct mdrestore_struct *mdres,
 		return 0;
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		/*
+		 * We know this item is superblock, its should only be 4K.
+		 * Don't need to waste memory following max_pending_size as it
+		 * can be as large as 256M.
+		 */
+		size_t size = BTRFS_SUPER_INFO_SIZE;
 
-		buffer = malloc(MAX_PENDING_SIZE * 2);
+		buffer = malloc(size);
 		if (!buffer)
 			return -ENOMEM;
 		ret = uncompress(buffer, (unsigned long *)&size,
@@ -1963,10 +1968,10 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	}
 
 	if (mdres->compress_method == COMPRESS_ZLIB) {
-		size_t size = MAX_PENDING_SIZE * 2;
+		size_t size = BTRFS_SUPER_INFO_SIZE;
 		u8 *tmp;
 
-		tmp = malloc(MAX_PENDING_SIZE * 2);
+		tmp = malloc(size);
 		if (!tmp) {
 			free(buffer);
 			return -ENOMEM;
-- 
2.23.0

