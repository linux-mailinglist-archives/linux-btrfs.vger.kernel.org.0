Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD04447626C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhLOUAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhLOUAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:01 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB85C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:01 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t6so21254102qkg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/0LUlN7r84Vmvh4QSmuPyKyiYeMOSOiqHsQFIIyRp6s=;
        b=Pi7xd+UY/l03rx8M1Xe+ldZZJlgkp8ur/yQEe4n2WGb05IhjwD6T2D4rOgIhWUAwhG
         TBeBczASCsU4ewolpTbXCCHDURrdJha/JiDfMZ97EPtkrtOagUoEWb95Kg2HHOt6y4zV
         Ri1bpat3Vq31uQ+JyrUTjhKHmDHRblrrukbGcpGB47HlwQ2xe35JBUy0fqbepGCQfHpG
         gISYWiNlWN3VHw7w4L8v2EM6LCXqUUBrWWPA1K/qOmAzK9IbtUZF/KHlEPPXOuZMhV1r
         yGSsW+ool1m+/pzn2sc7u9Qve+4rmePhvUp3ZPs58Qr6HCgrHpZd+G1eLm/NJk5k+I0o
         5Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0LUlN7r84Vmvh4QSmuPyKyiYeMOSOiqHsQFIIyRp6s=;
        b=I6cdwODcf8rolDOssw/rz0S9eswSAK/NBverjkkfLijOlbEIbJ2ZbApVIeN2PjCLCx
         vp+GbpIi1nGRXdlL4T5YCvS63fVmgYj5Ns+/XI8DArVYU8IKKhnICwNLXiaPhPtkVMuY
         8lExfJ/0LtWaW0zUSifHVnMnuXGLp4HK99AStMeOYIc2SX+fQn2wkIRYugwJXrIRM/pE
         6y8zkmqnaKgxvFf+OZZfMaVchRuJZVKpiX8pjrBh/76+orn/mgLEeomxZgGpbaerOsTq
         8QNHbm0c3HIzeZZ12Sgj+SyyLa8Btx80V6oJQVHibMNsb4mX8mw7iu3ojvc2ZALG7vZX
         gbew==
X-Gm-Message-State: AOAM533XS/waxx4SUvqNp+Aq6W2flMag2m2b5CG7GIilu3oq1kYxgMEu
        y7oF3EF5650cIsKO4hEZAVgachVmLzRO6Q==
X-Google-Smtp-Source: ABdhPJxLFCt5lWZVZjkKDTdUhDtSBKUZmHZ8DkrIh85zBLw4MiRdimT68MTnnvS5ACWDJPFJtY4TvQ==
X-Received: by 2002:a05:620a:4082:: with SMTP id f2mr9978124qko.590.1639598400037;
        Wed, 15 Dec 2021 12:00:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i23sm1584562qkl.101.2021.12.15.11.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 06/22] btrfs-progs: mkfs: use the btrfs_block_group_root helper
Date:   Wed, 15 Dec 2021 14:59:32 -0500
Message-Id: <e0c01e11d09b2a351921d634db5359c9f0948135.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of accessing the extent root directory for modifying block
groups, use the helper which will do the correct thing based on the
flags of the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 4 ++--
 mkfs/main.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index a4d89636..d0d52f69 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9413,6 +9413,7 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
+	struct btrfs_root *bg_root = btrfs_block_group_root(trans->fs_info);
 	u64 start = 0;
 	int ret;
 
@@ -9486,7 +9487,6 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
-		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9500,7 +9500,7 @@ again:
 		key.objectid = cache->start;
 		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
+		ret = btrfs_insert_item(trans, bg_root, &key, &bgi,
 					sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
diff --git a/mkfs/main.c b/mkfs/main.c
index 2c4b7b00..9a57cef8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -596,7 +596,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_group_item *bgi;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_path path;
-- 
2.26.3

