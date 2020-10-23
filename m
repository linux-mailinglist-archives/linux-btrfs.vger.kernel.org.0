Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC692970FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373839AbgJWN61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373787AbgJWN61 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F53C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:26 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c15so971118qtc.2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CeWKkm/6MXM0WI2GvWCxR0wARE9mo8N0h07K2TRqGFw=;
        b=c3cZMsWaPScyjlIOchNQZBRXieSIxBBXZHKG79MBuOiMhAq0mbC4RKnnCcqi4cVCqE
         6AuVNmZb1aK34ST9St5CyACBufIwlFuOXnMFrJpcNWzLQ28nzmpSyOuXp0Og14VQ8x63
         70dLFgxTMAHTcwS+TzA1lXJNND8muOZ/6swpmpBN0TU3TVXHkUYCS9JF0cC6R5RiuRae
         JEASGWMLFqJYUamDhBP0Tgo+na/evraqmfdbA/HfJxmO1IqZYGU391HNGAsedcK0X+K6
         G10nsNL2J+4tsOFjtYjMe4/yxpfsdP0+GioWf9bv/R9GY8o0v1QHKaqVIWhWkG3n0nG2
         okBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeWKkm/6MXM0WI2GvWCxR0wARE9mo8N0h07K2TRqGFw=;
        b=gOPTZc6VsIxOz4Y9d3VMgWLzbajRN3uZmW0F9lPSv6CHSgOlwjmraaFQZQM8vLO0I7
         Bg0z36sZUpoxM2ypi6rwor2XoTS0nUvsaU6rjWMgOIwJbEViFNF3gC0rTIVNRbuOwCKP
         465MJo1VtEXRKfYnDesN116zL+hCuk+VaV2XkIdYU5HeAU90zOwo6pPCO1ejwAiq3lLB
         HaQWUVmSCtNkl9T7YBv+E2+J+pWU8DW68aOffeoAvg53y0WKLeIS3uKhPQCFXF7bzsle
         wPSgI+Wl2JAmKUu4PCpcMVHISFmY1ebGKNLRUcKktsCg9TCHoY6PCfGjG8KB8ZAbX1ex
         Rkdg==
X-Gm-Message-State: AOAM532Yu2F7+39dj8PlndGQyeiY06xrzNipDwQf0KwwyuFA+FzxOIUj
        yt3+F5BrsCdM/Mmd5hUgE2n/9AUU/LPsVRwL
X-Google-Smtp-Source: ABdhPJwLyTdv2TViCoqnnvJVzssT75apOwqmY4mEpgCoqNJgX9GyM53z7MW/z3sOP+nRZLYUS6XtQw==
X-Received: by 2002:ac8:1089:: with SMTP id a9mr2362297qtj.111.1603461505122;
        Fri, 23 Oct 2020 06:58:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e1sm751270qkm.35.2020.10.23.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: async load free space cache
Date:   Fri, 23 Oct 2020 09:58:10 -0400
Message-Id: <e18fae96f7718557e766edf282a6d8f4dfe7f139.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While documenting the usage of the commit_root_sem, I noticed that we do
not actually take the commit_root_sem in the case of the free space
cache.  This is problematic because we're supposed to hold that sem
while we're reading the commit roots, which is what we do for the free
space cache.

The reason I did it inline when I originally wrote the code was because
there's the case of unpinning where we need to make sure that the free
space cache is loaded if we're going to use the free space cache.  But
we can accomplish the same thing by simply waiting for the cache to be
loaded.

Rework this code to load the free space cache asynchronously.  This
allows us to greatly cleanup the caching code because now it's all
shared by the various caching methods.  We also are now in a position to
have the commit_root semaphore held while we're loading the free space
cache.  And finally our modification of ->last_byte_to_unpin is removed
because it can be handled in the proper way on commit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 123 ++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index adbd18dc08a1..ba6564f67d9a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -424,6 +424,23 @@ int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
 	return ret;
 }
 
+static bool space_cache_v1_done(struct btrfs_block_group *cache)
+{
+	bool ret;
+
+	spin_lock(&cache->lock);
+	ret = cache->cached != BTRFS_CACHE_FAST;
+	spin_unlock(&cache->lock);
+
+	return ret;
+}
+
+static void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
+				struct btrfs_caching_control *caching_ctl)
+{
+	wait_event(caching_ctl->wait, space_cache_v1_done(cache));
+}
+
 #ifdef CONFIG_BTRFS_DEBUG
 static void fragment_free_space(struct btrfs_block_group *block_group)
 {
@@ -639,11 +656,28 @@ static noinline void caching_thread(struct btrfs_work *work)
 	mutex_lock(&caching_ctl->mutex);
 	down_read(&fs_info->commit_root_sem);
 
+	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		ret = load_free_space_cache(block_group);
+		if (ret == 1) {
+			ret = 0;
+			goto done;
+		}
+
+		/*
+		 * We failed to load the space cache, set ourselves to
+		 * CACHE_STARTED and carry on.
+		 */
+		spin_lock(&block_group->lock);
+		block_group->cached = BTRFS_CACHE_STARTED;
+		spin_unlock(&block_group->lock);
+		wake_up(&caching_ctl->wait);
+	}
+
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		ret = load_free_space_tree(caching_ctl);
 	else
 		ret = load_extent_tree_free(caching_ctl);
-
+done:
 	spin_lock(&block_group->lock);
 	block_group->caching_ctl = NULL;
 	block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
@@ -679,7 +713,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 {
 	DEFINE_WAIT(wait);
 	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_caching_control *caching_ctl;
+	struct btrfs_caching_control *caching_ctl = NULL;
 	int ret = 0;
 
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
@@ -691,84 +725,28 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	init_waitqueue_head(&caching_ctl->wait);
 	caching_ctl->block_group = cache;
 	caching_ctl->progress = cache->start;
-	refcount_set(&caching_ctl->count, 1);
+	refcount_set(&caching_ctl->count, 2);
 	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
 	if (cache->cached != BTRFS_CACHE_NO) {
-		spin_unlock(&cache->lock);
 		kfree(caching_ctl);
-		return 0;
+
+		caching_ctl = cache->caching_ctl;
+		if (caching_ctl)
+			refcount_inc(&caching_ctl->count);
+		spin_unlock(&cache->lock);
+		goto out;
 	}
 	WARN_ON(cache->caching_ctl);
 	cache->caching_ctl = caching_ctl;
-	cache->cached = BTRFS_CACHE_FAST;
+	if (btrfs_test_opt(fs_info, SPACE_CACHE))
+		cache->cached = BTRFS_CACHE_FAST;
+	else
+		cache->cached = BTRFS_CACHE_STARTED;
+	cache->has_caching_ctl = 1;
 	spin_unlock(&cache->lock);
 
-	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
-		mutex_lock(&caching_ctl->mutex);
-		ret = load_free_space_cache(cache);
-
-		spin_lock(&cache->lock);
-		if (ret == 1) {
-			cache->caching_ctl = NULL;
-			cache->cached = BTRFS_CACHE_FINISHED;
-			cache->last_byte_to_unpin = (u64)-1;
-			caching_ctl->progress = (u64)-1;
-		} else {
-			if (load_cache_only) {
-				cache->caching_ctl = NULL;
-				cache->cached = BTRFS_CACHE_NO;
-			} else {
-				cache->cached = BTRFS_CACHE_STARTED;
-				cache->has_caching_ctl = 1;
-			}
-		}
-		spin_unlock(&cache->lock);
-#ifdef CONFIG_BTRFS_DEBUG
-		if (ret == 1 &&
-		    btrfs_should_fragment_free_space(cache)) {
-			u64 bytes_used;
-
-			spin_lock(&cache->space_info->lock);
-			spin_lock(&cache->lock);
-			bytes_used = cache->length - cache->used;
-			cache->space_info->bytes_used += bytes_used >> 1;
-			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
-			fragment_free_space(cache);
-		}
-#endif
-		mutex_unlock(&caching_ctl->mutex);
-
-		wake_up(&caching_ctl->wait);
-		if (ret == 1) {
-			btrfs_put_caching_control(caching_ctl);
-			btrfs_free_excluded_extents(cache);
-			return 0;
-		}
-	} else {
-		/*
-		 * We're either using the free space tree or no caching at all.
-		 * Set cached to the appropriate value and wakeup any waiters.
-		 */
-		spin_lock(&cache->lock);
-		if (load_cache_only) {
-			cache->caching_ctl = NULL;
-			cache->cached = BTRFS_CACHE_NO;
-		} else {
-			cache->cached = BTRFS_CACHE_STARTED;
-			cache->has_caching_ctl = 1;
-		}
-		spin_unlock(&cache->lock);
-		wake_up(&caching_ctl->wait);
-	}
-
-	if (load_cache_only) {
-		btrfs_put_caching_control(caching_ctl);
-		return 0;
-	}
-
 	down_write(&fs_info->commit_root_sem);
 	refcount_inc(&caching_ctl->count);
 	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
@@ -777,6 +755,11 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 	btrfs_get_block_group(cache);
 
 	btrfs_queue_work(fs_info->caching_workers, &caching_ctl->work);
+out:
+	if (load_cache_only && caching_ctl)
+		btrfs_wait_space_cache_v1_finished(cache, caching_ctl);
+	if (caching_ctl)
+		btrfs_put_caching_control(caching_ctl);
 
 	return ret;
 }
-- 
2.26.2

