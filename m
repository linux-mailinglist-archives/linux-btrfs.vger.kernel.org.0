Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA54C02D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfFSRrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:36 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41258 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSRrf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so15996943qtj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=WzYbVk3GqaP2esYjYqzRzg9RpxKz0wwjWDR1en8iAw4=;
        b=Q05ZYF0lFT4zk62+5BnBYyMFl64mAJY6cMNcOTrHE8kUwoehjkLMF4JkLTCH8ZtgUF
         5aww6xqNNHriQm5E8vUVnB4RjgMrZw6eyGOnBYfpNOe2PCs4IBXo3Nu9fzRt3d6jkckQ
         gH3wk2zQnXnkCGWrXqBeHCGQ9KAvlbV90L9rm5wD7vVOxAIztQQFgpzC2HD4FbdVZESa
         5smQKpMBp45D0FfoSR3xLr9r/q3MrepdL/wzifYyRbmjT025JjxtoG6h6NXs6qRxGLXm
         Jzzwhtn/9GgOcrkvyA/iNu6UJstwIIreaOtDA9nXJYpuDAQahyza2knflLGKszCZ+Pks
         tRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=WzYbVk3GqaP2esYjYqzRzg9RpxKz0wwjWDR1en8iAw4=;
        b=SAcDYl0X3ZhZFM1h6/umFFp2/nxL5gp/rWj69ybDYDKxdjKPmRXdJBaRjwAfajkw/u
         DXy9zWKoUWq+Ds585eNUrNOP90RFYlRcPbRC5zBerUpJ6BzXOSsfRZNzpS7sARCkfeN7
         KWUUiBk/61g76gTzKgstgIPoAfoxZamy812hYasKnfXsh4aYq1XXsjKE3SCja4R6d3Bl
         9+tOQFBd/77F2gFba/dPOaOXZlEp3UTTmssjKwt91Zvl5BXETivafgP1Vf+DVKyC/2x2
         G5H+xvNg/kb4J5xssMp+OkgWr/YM8ZFAtjma2989Jt4xL1la+qUDQAtPT+3EQGgr1Kvn
         e7SQ==
X-Gm-Message-State: APjAAAUwjfcMYSbxa776ATphJbzalWTihoQrCB1AJ2c0MaVkKlAwTEXq
        I2nATe7+ltSwG+H9s72X1cCmi0DcHp73Zg==
X-Google-Smtp-Source: APXvYqw7gu1WMGdGCsRf96HKMicg+Vo7x289w82fjVT16b6u8tiEnyMu91DrB0DDsvqO6gfBetK+Lw==
X-Received: by 2002:ac8:381d:: with SMTP id q29mr106352996qtb.347.1560966454409;
        Wed, 19 Jun 2019 10:47:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n10sm11228425qke.72.2019.06.19.10.47.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: cleanup the target logic in __btrfs_block_rsv_release
Date:   Wed, 19 Jun 2019 13:47:20 -0400
Message-Id: <20190619174724.1675-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This works for all callers already, but if we wanted to use the helper
for the global_block_rsv it would end up trying to refill itself.  Fix
the logic to be able to be used no matter which block rsv is passed in
to this helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d6aff56337aa..6995edf887e1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4684,12 +4684,20 @@ u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
-	struct btrfs_block_rsv *target = delayed_rsv;
+	struct btrfs_block_rsv *target = NULL;
 
-	if (target->full || target == block_rsv)
+	/*
+	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
+	 * into the delayed rsv if it is not full.
+	 */
+	if (block_rsv == delayed_rsv) {
 		target = global_rsv;
+	} else if (block_rsv != global_rsv) {
+		if (!delayed_rsv->full)
+			target = delayed_rsv;
+	}
 
-	if (block_rsv->space_info != target->space_info)
+	if (target && block_rsv->space_info != target->space_info)
 		target = NULL;
 
 	return block_rsv_release_bytes(fs_info, block_rsv, target, num_bytes,
-- 
2.14.3

