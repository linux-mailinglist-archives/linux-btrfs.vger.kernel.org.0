Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15B46551E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352253AbhLASU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352221AbhLASUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:48 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52AC061748
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:27 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i13so22537550qvm.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M5UJeG4Uv5lgjGhkC7NOs0vewswjeS1CW8LEfH64gL0=;
        b=AbtjkBCJ4ZqA2q4Me4nr7e70S6gFsPFC/wIj9BBtwbrLG4aTdTSsD5iAijYmHtn4Ee
         vNqBRoTKwMam1xg3+xyD9on7bf5zFIzgxqaFuo7XaGjQZ0VHoWhvLhdk7yasuGtwJuLR
         8iSYei8R4ZqwWQ0MC2BrpBL5ARGjAHA9PiLjHuzl8opo+Jb570lQGgeM8CQJ/PCl/mVL
         7zIBmrv09g0y7FmRwfs7mTLxQ216tY+cVheg0v1zEMnut4u5TsQ+MS4QPcUs91G5xqGx
         1Ji4udpOJbSvRFPyqfCCO0V52/sO64+BjjgQV10XDIqvVIBDcVTQwiSFAfm2288P/9nd
         7Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5UJeG4Uv5lgjGhkC7NOs0vewswjeS1CW8LEfH64gL0=;
        b=gpYrzGeWOoed6rtNqt9EpO36xHhznEA/U7F9fIlNzqQvWxlWEd0ws8ySX6rtU5get8
         VNf4PZe4MgCsUd3DbZEN4eVt5cM+ds9glvWM7MCVCgOLtCSO1Mx3zGJe4bY7tEwUZ/sj
         TOxhLAtLP1fOzqfQsJSWxBGvNZACcMtWXYlhkQF4gtyWy+5hfyLhvWPJWqVAVkJJ2hn5
         fnqfvrSJxH2QitVsUsu1NQbzdHDs20sOAEv3z3dLracLClTVvoHkVw/ghES88dvwUsm9
         FkrIq47Ji2oT4S2qgm9O1a+cSKTkuZbdgOKLJLzcE8BQAVjnC+EaLN3djjkktWC6iAhS
         BP2w==
X-Gm-Message-State: AOAM531DaWDAmhPfvFQXGtLDUqEjklK1DvoLyV241B7U/X3hVChMsNBC
        DoBSA/XVKlxmplOd2HQulcix+/cxs1IDBA==
X-Google-Smtp-Source: ABdhPJxgTL8gyzXHo18UC+JFG3+5I8pd6M11Io2c6apjrO+kfIdaVJfBcESMP6LBZ3voAfY5rirDnA==
X-Received: by 2002:a05:6214:246f:: with SMTP id im15mr8472080qvb.21.1638382646072;
        Wed, 01 Dec 2021 10:17:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a15sm292760qtb.5.2021.12.01.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/22] btrfs-progs: mkfs: use the btrfs_block_group_root helper
Date:   Wed,  1 Dec 2021 13:17:00 -0500
Message-Id: <792e8cb51282e6dcaa0160c6ca469fc9225089a2.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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
index 5d1eed52..b3563ee1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9400,6 +9400,7 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
+	struct btrfs_root *bg_root = btrfs_block_group_root(trans->fs_info);
 	u64 start = 0;
 	int ret;
 
@@ -9473,7 +9474,6 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
-		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9487,7 +9487,7 @@ again:
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

