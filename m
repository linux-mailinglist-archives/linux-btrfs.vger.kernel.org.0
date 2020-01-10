Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0713728C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 17:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAJQLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 11:11:38 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40172 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgAJQLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 11:11:37 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so958378qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 08:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2f68zqTmYSRwCmOrISRNQhMftSyhWxB/r1mre++6c1Q=;
        b=0im/Sie1xzdAcpLZpzcqalX7hBeRwXdRzyDFDlx/fiAC2CRbKaCH4cM/w4LlH3F2IF
         dsiPiX8ww5EMZVFaSXnBhyKDWA0U9UhxKL563K1yI8T+FTmuB2zOvTFGuq11UoSZpuaT
         GKWKbMhTAX7NlIvPQngsRD8xv4/1WWGPERLmw4383NpfHcHf4xlZ6LC+q5S9VTK+gtsk
         TLeQdBpnQRwedOM0jDkui5gLMVc/xrrd5KVS3rQWxViWHe37mcYzP90AI023OF9U5Z4i
         IeylxNACbHUuPeYNL5lfqDTWLtkjl7sUt27S8bzn27PGACuLYZhUN+XHIRahyqB7DpmU
         qAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2f68zqTmYSRwCmOrISRNQhMftSyhWxB/r1mre++6c1Q=;
        b=MXXGwJVh9MIXzm2UlDu4/M1W4FrJj6OYxjCDAlr/8B+IHtaoPWLbxb2hd+tMQC5sZp
         rLswJUUosgRzb40hcg+4JRVQ3zcGBUz02u9n4PIJhJ7bVl0vY1th8+4V+DNeqXsvpIEU
         FS26bYupJ/2IgzxWkYataveBl2bKkUkNPEWpYObjg2/TwfnOPPUVOGVWeqZ7/gnDOfxw
         vgvgZ9llGFjFX0gPnrmCehdt5OOWAu6MlxJ2LzwaU6VITech1WK/APHEHoC2KFpaiMEE
         VrysPjzwr32gzXMZ79P/WHu/1sT66zd0YPssxuH8U5sWYI4KXq2LcuYHmpTnVhxvp8RR
         ynaQ==
X-Gm-Message-State: APjAAAXJkAyO+o7U8hCnNIWHyr63XMyadO3f/USxLhCjedLzXKFG7dKW
        hnePA6H66L746QC8w8WkXlKK6Y3AAsU69A==
X-Google-Smtp-Source: APXvYqwCo+MukWrAK72YDMOq6OaTRyZLwZZt3tGwiZ8p+7wZ48b2Lcon3IFJJaBB+kjMQAim9cgDVA==
X-Received: by 2002:a0c:e4c1:: with SMTP id g1mr3506054qvm.45.1578672696626;
        Fri, 10 Jan 2020 08:11:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l184sm1048178qkc.107.2020.01.10.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:11:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 3/5] btrfs: kill min_allocable_bytes in inc_block_group_ro
Date:   Fri, 10 Jan 2020 11:11:26 -0500
Message-Id: <20200110161128.21710-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110161128.21710-1-josef@toxicpanda.com>
References: <20200110161128.21710-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a relic from a time before we had a proper reservation mechanism
and you could end up with really full chunks at chunk allocation time.
This doesn't make sense anymore, so just kill it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d96561d1ce90..6f564e390153 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1185,21 +1185,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
 	u64 sinfo_used;
-	u64 min_allocable_bytes;
 	int ret = -ENOSPC;
 
-	/*
-	 * We need some metadata space and system metadata space for
-	 * allocating chunks in some corner cases until we force to set
-	 * it to be readonly.
-	 */
-	if ((sinfo->flags &
-	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
-	    !force)
-		min_allocable_bytes = SZ_1M;
-	else
-		min_allocable_bytes = 0;
-
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 
@@ -1217,10 +1204,9 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
 	 *
 	 * Here we make sure if we mark this bg RO, we still have enough
-	 * free space as buffer (if min_allocable_bytes is not 0).
+	 * free space as buffer.
 	 */
-	if (sinfo_used + num_bytes + min_allocable_bytes <=
-	    sinfo->total_bytes) {
+	if (sinfo_used + num_bytes <= sinfo->total_bytes) {
 		sinfo->bytes_readonly += num_bytes;
 		cache->ro++;
 		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
@@ -1233,8 +1219,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		btrfs_info(cache->fs_info,
 			"unable to make block group %llu ro", cache->start);
 		btrfs_info(cache->fs_info,
-			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
-			sinfo_used, num_bytes, min_allocable_bytes);
+			"sinfo_used=%llu bg_num_bytes=%llu",
+			sinfo_used, num_bytes);
 		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
 	}
 	return ret;
-- 
2.24.1

