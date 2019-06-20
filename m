Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86754DA54
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfFTTiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46082 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfFTTiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so4359655qtn.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0kv2k3uWdiHcJyJPRRiM+FKBO3POWu2EUdvjQnunniY=;
        b=HKRsQTLbj19CKy4DU1khp/uobrjGDaQg+4jPVNdGdx/jvA9PWdVAakCmiiMkxi6iMQ
         1EDSxullMDChsoxtpME526m81kUFIlaFxSk8jai4tXxA/7FHgBmVQZ1fY08sow7zGJl3
         NRiT9mZ5kfyLtIgCWx1cr2IyAuwFZUAxF4R3bD1VKzh5Cxf5uQxDS7RLfKMc/QZ0DTPD
         XeJjgwEaPFG0XB52l0EmUrvUQXXeb/55QJQ0KkCR9/VV2rRFxGQtnrHtwkfJ0EOwz4U/
         m1gVqOgPN6WLTdXQnyg04iyb6K6ZyNx8c8aq4gaollxv82sa/oYOkC2pk20yNSmVEa+/
         i85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0kv2k3uWdiHcJyJPRRiM+FKBO3POWu2EUdvjQnunniY=;
        b=nmSJyzZIC6HIe7Ybj3WvohWZpp5uwhqPkZLz3MxZJOYJrGODkyM211KVL1GFeQ6/Lb
         DI9Grt2OpQXHDnptwII85Saf8QD0mMwa5eWY0NM1x+/QlM99LOCqn7brCxT8Rssw6C0H
         AkPdC1GOzrCH3YeIJsP/dGe9YkEe7busPwn4N0HK/PH6C8T+URs1+jcc9cPxH6uRfGV5
         +J7OOT0dPWIZDAgJN1XNzMGj2vvVlmyMMpKKoTUdhHPI3iZoMYAe7sesDOhjk/ERdmLM
         5I99dW484uM9oc4i/o4VUbIzWr2G0VE+qBL7vWBZEB7NDdTlnsTofjQjhdUzl1sFcIjD
         Hnyw==
X-Gm-Message-State: APjAAAXsgzYVHChvfTRM1VWuK6I8nBdvxaWPOGVSEK+dkWDya3q3vNwe
        wp6nuUXdfJSvOJc7Xi9SfaOeFXSPiQlFEA==
X-Google-Smtp-Source: APXvYqy38Tikfbsj/Tei7d4z4kIhMU7rCu6RbAgD4ExvtbdTJhLM1fzD4wbU60IFrxvgjVtLYKZVCQ==
X-Received: by 2002:ac8:18d2:: with SMTP id o18mr64594813qtk.243.1561059502518;
        Thu, 20 Jun 2019 12:38:22 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r40sm330629qtr.57.2019.06.20.12.38.21
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/25] btrfs: export the caching control helpers
Date:   Thu, 20 Jun 2019 15:37:50 -0400
Message-Id: <20190620193807.29311-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Man a lot of people use this stuff.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  3 +++
 fs/btrfs/extent-tree.c | 36 ++++++++++++++++++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c8a63ccd6b58..8cac9c5f1711 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -173,6 +173,9 @@ btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
 int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache);
 int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 			    int load_cache_only);
+void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
+struct btrfs_caching_control *
+btrfs_get_caching_control(struct btrfs_block_group_cache *cache);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index eea5a15802f1..9b5853e5dd14 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -181,8 +181,8 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 	return 0;
 }
 
-static struct btrfs_caching_control *
-get_caching_control(struct btrfs_block_group_cache *cache)
+struct btrfs_caching_control *
+btrfs_get_caching_control(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_caching_control *ctl;
 
@@ -198,7 +198,7 @@ get_caching_control(struct btrfs_block_group_cache *cache)
 	return ctl;
 }
 
-static void put_caching_control(struct btrfs_caching_control *ctl)
+void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
 {
 	if (refcount_dec_and_test(&ctl->count))
 		kfree(ctl);
@@ -454,7 +454,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 	wake_up(&caching_ctl->wait);
 
-	put_caching_control(caching_ctl);
+	btrfs_put_caching_control(caching_ctl);
 	btrfs_put_block_group(block_group);
 }
 
@@ -503,7 +503,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 		schedule();
 
 		finish_wait(&ctl->wait, &wait);
-		put_caching_control(ctl);
+		btrfs_put_caching_control(ctl);
 		spin_lock(&cache->lock);
 	}
 
@@ -556,7 +556,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 
 		wake_up(&caching_ctl->wait);
 		if (ret == 1) {
-			put_caching_control(caching_ctl);
+			btrfs_put_caching_control(caching_ctl);
 			btrfs_free_excluded_extents(cache);
 			return 0;
 		}
@@ -578,7 +578,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 	}
 
 	if (load_cache_only) {
-		put_caching_control(caching_ctl);
+		btrfs_put_caching_control(caching_ctl);
 		return 0;
 	}
 
@@ -4155,7 +4155,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 
 	btrfs_cache_block_group(block_group, 0);
-	caching_ctl = get_caching_control(block_group);
+	caching_ctl = btrfs_get_caching_control(block_group);
 
 	if (!caching_ctl) {
 		/* Logic error */
@@ -4185,7 +4185,7 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 		}
 out_lock:
 		mutex_unlock(&caching_ctl->mutex);
-		put_caching_control(caching_ctl);
+		btrfs_put_caching_control(caching_ctl);
 	}
 	btrfs_put_block_group(block_group);
 	return ret;
@@ -4308,7 +4308,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 		if (btrfs_block_group_cache_done(cache)) {
 			cache->last_byte_to_unpin = (u64)-1;
 			list_del_init(&caching_ctl->list);
-			put_caching_control(caching_ctl);
+			btrfs_put_caching_control(caching_ctl);
 		} else {
 			cache->last_byte_to_unpin = caching_ctl->progress;
 		}
@@ -4943,14 +4943,14 @@ btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cache *cache,
 {
 	struct btrfs_caching_control *caching_ctl;
 
-	caching_ctl = get_caching_control(cache);
+	caching_ctl = btrfs_get_caching_control(cache);
 	if (!caching_ctl)
 		return;
 
 	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache) ||
 		   (cache->free_space_ctl->free_space >= num_bytes));
 
-	put_caching_control(caching_ctl);
+	btrfs_put_caching_control(caching_ctl);
 }
 
 int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
@@ -4958,14 +4958,14 @@ int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *cache)
 	struct btrfs_caching_control *caching_ctl;
 	int ret = 0;
 
-	caching_ctl = get_caching_control(cache);
+	caching_ctl = btrfs_get_caching_control(cache);
 	if (!caching_ctl)
 		return (cache->cached == BTRFS_CACHE_ERROR) ? -EIO : 0;
 
 	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache));
 	if (cache->cached == BTRFS_CACHE_ERROR)
 		ret = -EIO;
-	put_caching_control(caching_ctl);
+	btrfs_put_caching_control(caching_ctl);
 	return ret;
 }
 
@@ -7606,7 +7606,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		caching_ctl = list_entry(info->caching_block_groups.next,
 					 struct btrfs_caching_control, list);
 		list_del(&caching_ctl->list);
-		put_caching_control(caching_ctl);
+		btrfs_put_caching_control(caching_ctl);
 	}
 	up_write(&info->commit_root_sem);
 
@@ -8307,7 +8307,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 
 	if (block_group->has_caching_ctl)
-		caching_ctl = get_caching_control(block_group);
+		caching_ctl = btrfs_get_caching_control(block_group);
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
 	if (block_group->has_caching_ctl) {
@@ -8328,8 +8328,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		up_write(&fs_info->commit_root_sem);
 		if (caching_ctl) {
 			/* Once for the caching bgs list and once for us. */
-			put_caching_control(caching_ctl);
-			put_caching_control(caching_ctl);
+			btrfs_put_caching_control(caching_ctl);
+			btrfs_put_caching_control(caching_ctl);
 		}
 	}
 
-- 
2.14.3

