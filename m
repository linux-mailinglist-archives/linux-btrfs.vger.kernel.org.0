Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4675F1405
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiI3Upz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 16:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiI3Upb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 16:45:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFD74DF2A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:29 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y2so3401292qtv.5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Sep 2022 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=HM8qBHDv293xlO1nL6KybeWbj8PEc3jToHFbv7DaAFo=;
        b=O7oQGVsTiHLW+2gBwsHYCzJeGvCFz6Fmz0hzMhdHqgbFMWTBYyUruGK6YLP89EzaCf
         uQHzU+53e73izP641EADKtotle6YHGkml0zvfid41CMf64T4QPf49Do3cBaxca5J5Fcc
         b9b/UoVdbmOWAXetY7N+Yzfr8hTiP59Z0H+F7tzWXVOLy292fqsOUtIbaZgqBOaL081M
         JWYUh5nYwPWqF7ba0nIs7A16FcUUi+qh/UCAkKkaBrWXIhpPM5Bf4vfWu6SnRhQWQVy1
         KzhjCXUh/qT8cx/BHt6ncaOHshnZ4Eu64XDaSsje/FWINQg9o5N0KqYf5CcFj/5ltDIG
         J++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HM8qBHDv293xlO1nL6KybeWbj8PEc3jToHFbv7DaAFo=;
        b=1DlxVettwYyikUtdhnQSVehYpvUHSA2gYe/nNJ9rSXZtz3nTUtg7DT2cJV+YoQvrgh
         TTKAD4z9sSwwI/Va6eNKtbzaqauI8ZC+DK4xdfVyZ44jX3BfKFWQEMbsuexjgN4w1oCw
         PvjivkSzP54E1aR1zb8Fg3xSq7D8XTFQY4ZrwEdYiJ1nHpqLxZBugLA2UbOgRLn+Qtgj
         XaMPxkrroMXscnoNe4Jp5lgFxn05VuHdHl7XO8c4IZp4gM3gWkkwrbf2PiCteQoGGTYc
         /4eh2mzeZIPbWFW9lWqrDj9wWvkdEpv8M1aXOMmhDECA5kOjJPTftC1S2ujUwg33fu3W
         6zVw==
X-Gm-Message-State: ACrzQf1p0tzwKIHf1Hn74CX50XTQXNIZ3hjiqV8ecICauYAqXePdMGVq
        Cr5ccGaWXk/yFkOWVHqqs82U95eMc3vEwQ==
X-Google-Smtp-Source: AMsMyM7uWOLv9OQQ9nkBpcax73YqhpwJlteWi2B7QRkSauXYZB2i9169sNKIhYUozcjh8gDbQ1jOTA==
X-Received: by 2002:a05:622a:1484:b0:35b:b50e:a3ad with SMTP id t4-20020a05622a148400b0035bb50ea3admr8309376qtx.299.1664570728287;
        Fri, 30 Sep 2022 13:45:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a400e00b006ce3f1af120sm3729986qko.44.2022.09.30.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:45:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/6] btrfs: use cached_state for btrfs_check_nocow_lock
Date:   Fri, 30 Sep 2022 16:45:10 -0400
Message-Id: <3ad77e40f98f940c54564677ef18d6ba170b9c43.1664570261.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
References: <cover.1664570261.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that try_lock_extent() takes a cached_state, plumb the cached_state
through btrfs_try_lock_ordered_range() and then use a cached_state in
btrfs_check_nocow_lock everywhere to avoid extra tree searches on the
extent_io_tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c         | 9 ++++++---
 fs/btrfs/ordered-data.c | 7 ++++---
 fs/btrfs/ordered-data.h | 3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 64bf29848723..c390d5805917 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1373,6 +1373,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
+	struct extent_state *cached_state = NULL;
 	u64 lockstart, lockend;
 	u64 num_bytes;
 	int ret;
@@ -1389,12 +1390,14 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	num_bytes = lockend - lockstart + 1;
 
 	if (nowait) {
-		if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend)) {
+		if (!btrfs_try_lock_ordered_range(inode, lockstart, lockend,
+						  &cached_state)) {
 			btrfs_drew_write_unlock(&root->snapshot_lock);
 			return -EAGAIN;
 		}
 	} else {
-		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend, NULL);
+		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend,
+						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			NULL, NULL, NULL, nowait, false);
@@ -1403,7 +1406,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	else
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
-	unlock_extent(&inode->io_tree, lockstart, lockend, NULL);
+	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	return ret;
 }
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b648c9d4ea0f..de2b716d3e7b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1069,11 +1069,12 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
  * Return true if btrfs_lock_ordered_range does not return any extents,
  * otherwise false.
  */
-bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end)
+bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
+				  struct extent_state **cached_state)
 {
 	struct btrfs_ordered_extent *ordered;
 
-	if (!try_lock_extent(&inode->io_tree, start, end, NULL))
+	if (!try_lock_extent(&inode->io_tree, start, end, cached_state))
 		return false;
 
 	ordered = btrfs_lookup_ordered_range(inode, start, end - start + 1);
@@ -1081,7 +1082,7 @@ bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end)
 		return true;
 
 	btrfs_put_ordered_extent(ordered);
-	unlock_extent(&inode->io_tree, start, end, NULL);
+	unlock_extent(&inode->io_tree, start, end, cached_state);
 
 	return false;
 }
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index f59f2dbdb25e..89f82b78f590 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -206,7 +206,8 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
-bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end);
+bool btrfs_try_lock_ordered_range(struct btrfs_inode *inode, u64 start, u64 end,
+				  struct extent_state **cached_state);
 int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
 			       u64 post);
 int __init ordered_data_init(void);
-- 
2.26.3

