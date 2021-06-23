Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1143B138A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWF56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41970 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 264E721941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b9/ffBvCGCH0KNrBcWXtCVuUW7EAOgexVkTOruZaZyI=;
        b=uO6XFNjK5Rf1M1dq9b5v23t3O1uLLEDXlBBmv4vYCqz9cqeJK7eRX3MqlRtsPd8T1OkJ5Y
        Ff6C4DHFaTrNx0kZloI0VyJeGymeJZ5CMpxU6yqps4Q7MGHiMH4VGS9cOLla+Tvs7GhtYZ
        s9xetaMlgu7rKogkjaJOxumuL+5ZTlE=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 2AC2CA3B91
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 4/8] btrfs: make btrfs_submit_compressed_write() to be subpage compatible
Date:   Wed, 23 Jun 2021 13:55:25 +0800
Message-Id: <20210623055529.166678-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a WARN_ON() checking if @start is aligned to PAGE_SIZE, not
sectorsize, which will cause false alert for subpage.

Fix it to check against sectorsize.

Furthermore:

- Use ASSERT() to do the check
  So that in the future we may skip the check for production build

- Also check alignment for @len

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b5487c80d2b6..a49dbf166b15 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -498,7 +498,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	const bool use_append = btrfs_use_zone_append(inode, disk_start);
 	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
 
-	WARN_ON(!PAGE_ALIGNED(start));
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
 	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
 	if (!cb)
 		return BLK_STS_RESOURCE;
-- 
2.32.0

