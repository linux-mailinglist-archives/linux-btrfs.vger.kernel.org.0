Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403853A7E07
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFOMUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:20:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38328 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFOMUr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02B6E21999;
        Tue, 15 Jun 2021 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623759522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGvvMlqm/wJTQ5T307nwHOvP4DfaAqkVOVBdx+bn2V4=;
        b=GKrpjDQQjYJJpf4ZZGrw6HToKF60jGerKqqInusXtdihv+1d9hGQt2YqDgU6XcLMUmmHSw
        LUMjs14K68aikOlNFRf+AVoyRj7EwhqrV6JwqmZah9fGRsaUZVBgmzlW+IUkBJWkEMPD9u
        EhX+bQyJCw7CorHVs4JKMv/6nLuoxjM=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id A4E78A3B99;
        Tue, 15 Jun 2021 12:18:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 1/9] btrfs: remove a dead comment for btrfs_decompress_bio()
Date:   Tue, 15 Jun 2021 20:18:28 +0800
Message-Id: <20210615121836.365105-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615121836.365105-1-wqu@suse.com>
References: <20210615121836.365105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 8140dc30a432 ("btrfs: btrfs_decompress_bio() could accept
compressed_bio instead"), btrfs_decompress_bio() accepts
"struct compressed_bio" other than open-coded parameter list.

Thus the comments for the parameter list is no longer needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 35ca49893803..9a023ae0f98b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1212,20 +1212,6 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 	return ret;
 }
 
-/*
- * pages_in is an array of pages with compressed data.
- *
- * disk_start is the starting logical offset of this array in the file
- *
- * orig_bio contains the pages from the file that we want to decompress into
- *
- * srclen is the number of bytes in pages_in
- *
- * The basic idea is that we have a bio that was created by readpages.
- * The pages in the bio are for the uncompressed data, and they may not
- * be contiguous.  They all correspond to the range of bytes covered by
- * the compressed extent.
- */
 static int btrfs_decompress_bio(struct compressed_bio *cb)
 {
 	struct list_head *workspace;
-- 
2.32.0

