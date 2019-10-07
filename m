Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF27CED50
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfJGUSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46194 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfJGUSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so21068615qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MFZA9vN24hbN2jx0uX3I3mAZyMymXf5B4Rd1zz5SUG4=;
        b=hrcDbWqmPsPXWJCDtLatUWIDNoikVRK7/j0A3ziI9Db33ih516ma7QuoH9P2GUuT1G
         hVi4eNSKFuRqbHYC5x0etYgPEbYACRKhmcTtM3LEmowjOxXnjl0y2WhU81riMRB9FroI
         ouavuhCvjkCItCpiZQxSL+hqRqmy84i6KepHhi5DkSRbfcIXhAmVNdUD4nbyUeGnI2zf
         BO8y+blZa6Hq6JOpfo6iBaFI8vnK250QojCLpisKlEPlOwYwroRH8mBzDhhhvtJ0o0w0
         IaE0fM1qu2lVCS/SRzvA4jk5KgegcUDUnoq5shOhnrXGo4TXQ06samGtAplEyhGZPcmq
         j4TQ==
X-Gm-Message-State: APjAAAXtPYicLKgnG0CQ9G2Cffy1IrHFfFl8I9sqdH5oOFX4dgDIATVy
        MZNXooUm5xk+yoqtvPdNPEA=
X-Google-Smtp-Source: APXvYqy0ia8XazbWUzZiqErEo/VEi7+kD0l7u93enSc10WzWsUQEAgAsPpbxrBqb4WMGjDcJ+EOIKQ==
X-Received: by 2002:a0c:ef85:: with SMTP id w5mr29307392qvr.159.1570479489336;
        Mon, 07 Oct 2019 13:18:09 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:08 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/19] btrfs: only keep track of data extents for async discard
Date:   Mon,  7 Oct 2019 16:17:45 -0400
Message-Id: <679c631d04f50a54f011c6317b99d96798a3ca4d.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As mentioned earlier, discarding data can be done either by issuing an
explicit discard or implicitly by reusing the LBA. Metadata chunks see
much more frequent reuse due to well it being metadata. So instead of
explicitly discarding metadata blocks, just leave them be and let the
latter implicit discarding be done for them.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/block-group.h | 6 ++++++
 fs/btrfs/discard.c     | 8 +++++++-
 fs/btrfs/discard.h     | 3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b59e6a8ed73d..7739099e974a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -169,6 +169,12 @@ u64 btrfs_block_group_end(struct btrfs_block_group_cache *cache)
 	return (cache->key.objectid + cache->key.offset);
 }
 
+static inline
+bool btrfs_is_block_group_data(struct btrfs_block_group_cache *cache)
+{
+	return (cache->flags & BTRFS_BLOCK_GROUP_DATA);
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline int btrfs_should_fragment_free_space(
 		struct btrfs_block_group_cache *block_group)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 296cbffc5957..0e4d5a22c661 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -50,6 +50,9 @@ static void __btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache)
 {
+	if (!btrfs_is_block_group_data(cache))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 
 	__btrfs_add_to_discard_list(discard_ctl, cache);
@@ -139,7 +142,10 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl, int *discard_index)
 		*discard_index = cache->discard_index;
 		if (cache->discard_index == 0 &&
 		    cache->free_space_ctl->free_space != cache->key.offset) {
-			__btrfs_add_to_discard_list(discard_ctl, cache);
+			if (btrfs_is_block_group_data(cache))
+				__btrfs_add_to_discard_list(discard_ctl, cache);
+			else
+				list_del_init(&cache->discard_list);
 			goto again;
 		}
 		if (btrfs_discard_reset_cursor(cache)) {
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 1daa8da4a1b5..552daa7251df 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -90,7 +90,8 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 	s32 extents_delta;
 	s64 bytes_delta;
 
-	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
+	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC) ||
+	    !btrfs_is_block_group_data(cache))
 		return;
 
 	discard_ctl = &cache->fs_info->discard_ctl;
-- 
2.17.1

