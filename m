Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABEB220B8
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEQXQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 19:16:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38696 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfEQXQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 19:16:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id a64so5488530qkg.5;
        Fri, 17 May 2019 16:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k1tap1xvwvAf6PxZjyNNMBvxJSWSIQcr4opnzIKbxTo=;
        b=Z7zO4BRgtDJP6DzJfFylR0TjdLEc3ze4+p4jhS7cJhRXFXBTH27rbE4wYnNTobSWUq
         9vZXrkcuU3xBZALyJxmnNiGPrpdHY0hK7HRWdFpZtdZ+/Q4uuDDMjjQR6dx4iUbSSV0+
         U700GJuw5DwKzTBgcBT9kG+QvlkWeq4A1BMnPH1muhjwoe/XRaFYHwudiSyFq+/UaFwk
         QWedmAFB7oiTJTJtlem12owsRCibp8jFr5XX1rzW4KU98W6Jg2uEtVReMUFgeyNJXCTV
         mPotYRnI3MGpFifgFeSt8msqpNRlfvP6aGn1YS1Yu6aCcjLGUzBjKVlSkv/HDzMaCKSp
         IwNA==
X-Gm-Message-State: APjAAAWPSrrPgD9hscUuO/QPTlWtsYQ1cNDdZwKtWDEqKKZYzOnkDDS5
        4uRSaAL5aOrW4MFmvWrXyME=
X-Google-Smtp-Source: APXvYqxPQO0F5bS8iL88kYTdTs+oxKhpzBjD0oVidZkh/eNSOqMCfGM2TXHxgYpdbZA65fBH8ShP8A==
X-Received: by 2002:a37:7984:: with SMTP id u126mr47466102qkc.204.1558134990129;
        Fri, 17 May 2019 16:16:30 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id y12sm5469464qtk.51.2019.05.17.16.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 May 2019 16:16:29 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "Erhard F ." <erhard_f@mailbox.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] btrfs: correct zstd workspace manager lock to use spin_lock_bh()
Date:   Fri, 17 May 2019 19:16:26 -0400
Message-Id: <20190517231626.85614-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs zstd workspace manager uses a background timer to reclaim
not recently used workspaces. I dumbly call spin_lock() from this
context which I should have caught with lockdep but.. This deadlock was
reported in [1]. The fix is to switch the zstd wsm lock to use
spin_lock_bh().

[1] https://bugzilla.kernel.org/show_bug.cgi?id=203517

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/zstd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index a6ff07cf11d5..3837ca180d52 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -105,10 +105,10 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
-	spin_lock(&wsm.lock);
+	spin_lock_bh(&wsm.lock);
 
 	if (list_empty(&wsm.lru_list)) {
-		spin_unlock(&wsm.lock);
+		spin_unlock_bh(&wsm.lock);
 		return;
 	}
 
@@ -137,7 +137,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	if (!list_empty(&wsm.lru_list))
 		mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
 
-	spin_unlock(&wsm.lock);
+	spin_unlock_bh(&wsm.lock);
 }
 
 /*
@@ -198,7 +198,7 @@ static void zstd_cleanup_workspace_manager(void)
 	struct workspace *workspace;
 	int i;
 
-	spin_lock(&wsm.lock);
+	spin_lock_bh(&wsm.lock);
 	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
 		while (!list_empty(&wsm.idle_ws[i])) {
 			workspace = container_of(wsm.idle_ws[i].next,
@@ -208,7 +208,7 @@ static void zstd_cleanup_workspace_manager(void)
 			zstd_free_workspace(&workspace->list);
 		}
 	}
-	spin_unlock(&wsm.lock);
+	spin_unlock_bh(&wsm.lock);
 
 	del_timer_sync(&wsm.timer);
 }
@@ -230,7 +230,7 @@ static struct list_head *zstd_find_workspace(unsigned int level)
 	struct workspace *workspace;
 	int i = level - 1;
 
-	spin_lock(&wsm.lock);
+	spin_lock_bh(&wsm.lock);
 	for_each_set_bit_from(i, &wsm.active_map, ZSTD_BTRFS_MAX_LEVEL) {
 		if (!list_empty(&wsm.idle_ws[i])) {
 			ws = wsm.idle_ws[i].next;
@@ -242,11 +242,11 @@ static struct list_head *zstd_find_workspace(unsigned int level)
 				list_del(&workspace->lru_list);
 			if (list_empty(&wsm.idle_ws[i]))
 				clear_bit(i, &wsm.active_map);
-			spin_unlock(&wsm.lock);
+			spin_unlock_bh(&wsm.lock);
 			return ws;
 		}
 	}
-	spin_unlock(&wsm.lock);
+	spin_unlock_bh(&wsm.lock);
 
 	return NULL;
 }
@@ -305,7 +305,7 @@ static void zstd_put_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_to_workspace(ws);
 
-	spin_lock(&wsm.lock);
+	spin_lock_bh(&wsm.lock);
 
 	/* A node is only taken off the lru if we are the corresponding level */
 	if (workspace->req_level == workspace->level) {
@@ -325,7 +325,7 @@ static void zstd_put_workspace(struct list_head *ws)
 	list_add(&workspace->list, &wsm.idle_ws[workspace->level - 1]);
 	workspace->req_level = 0;
 
-	spin_unlock(&wsm.lock);
+	spin_unlock_bh(&wsm.lock);
 
 	if (workspace->level == ZSTD_BTRFS_MAX_LEVEL)
 		cond_wake_up(&wsm.wait);
-- 
2.17.1

