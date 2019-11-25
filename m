Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1665B109037
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 15:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfKYOkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 09:40:20 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42563 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOkT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 09:40:19 -0500
Received: by mail-qv1-f67.google.com with SMTP id n4so5770734qvq.9
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5lRDWEt6RstVRpGoq3X83Gj9t9eqsjUNE3kAbj6Umeg=;
        b=aoiAI4suIbESgn+w8ewjAqEP3Dcw359ZlIw3h0TuOkF0WGtjqg5WXQaXWyd+UjvNus
         LVAc6wOq9YIFOeT4ONk8SiMdk1EYrWjCkT/q/aEGVPNck+w6TVUFb1veho//yCeBwEWQ
         /Jz1ON6lCSliPBurDJgvlay0afK5b7ke6w0V3+SU4zoSPRo2jEgwq9DWW4FkXBVkTfpB
         pqppWgPigrxPHsw85WdonNE/nNCD1U+2hsbxXAZSSCUE5cFwQAYJOwrZg4Ji8t3bqbmk
         lrCEwAy9YEXNUM2dVBa1YOwW3ZhXcLQ+XqckNMVwbNU9KyyTI8nR0BwTxPXLA2etAmuH
         lwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lRDWEt6RstVRpGoq3X83Gj9t9eqsjUNE3kAbj6Umeg=;
        b=NHWNGcysSbXKE5k38DHyfX/r1ZyH47oEbQzPaRayt0osuQgTKLSg1eJvkq7SEp7X8G
         blLh3X2IVQWvgSEBRc25bAM8Iq5u7R9ruOMAbVyUMJIOdXHJQnP3yB+0RtcJ/REP8mf3
         idYlV16irGzeJJxRNNwO1p0+o2kN+wgHLKPf/+wUm1qyq6tlo0QRmwUcNyP3JRMHBlNI
         jrbb6SO3bg1f+DQ729ZUeabY/4IAbeHV33A9tanywxsyPWkM2K1u9T8T0i+BO5fXwPEU
         DgGIwiCKRKXuDwf3+xVDl9m99s5eTGMWPFMCF0MRBrw9lTNkCPLRtChqBTBr46yJv3Tq
         zRDQ==
X-Gm-Message-State: APjAAAVwsAXJ6c1IyZ7MVXzyn0NBWz0xrMPkGyiEuGeH1qT5MHvv41i5
        UldWkLja5KtMJiHhHfxhZrvmd2HF41Atmw==
X-Google-Smtp-Source: APXvYqwVjlo+MWzNz0OEoL2dtQTGfS8UI7Xmt7j58li++rFMI+B5q8mOfwX7QQpgPM2twp3DZ520jg==
X-Received: by 2002:a05:6214:6e3:: with SMTP id bk3mr13113292qvb.20.1574692818236;
        Mon, 25 Nov 2019 06:40:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s34sm4028944qtb.73.2019.11.25.06.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:40:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: [PATCH 2/4] btrfs: kill min_allocable_bytes in inc_block_group_ro
Date:   Mon, 25 Nov 2019 09:40:09 -0500
Message-Id: <20191125144011.146722-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125144011.146722-1-josef@toxicpanda.com>
References: <20191125144011.146722-1-josef@toxicpanda.com>
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
---
 fs/btrfs/block-group.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6934a5b8708f..db539bfc5a52 100644
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
+	if (sinfo_used + num_bytes + sinfo->total_bytes) {
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
2.23.0

