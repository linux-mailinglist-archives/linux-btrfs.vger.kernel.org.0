Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8311310946D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKYTrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41436 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfKYTrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so13908860qkd.8
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Dpd4Cd5m9pvtg3P5mp+Mk1iq11FHL2d3SGUrkureO7E=;
        b=aAFtZFJi0BZ1bpsUnA/iyzF/1/fQ7tivbPa/NQlCDdQJKAcuQIBHsDALR0aVNyHVK/
         d2tQThZJZoXnFlK2MaZPnSiW79w73BOy4GPZCXGw/DHFaTeSnik19JozcyqzmhdWcHun
         6hRtf60w4ZVqapmPop3XT9AdPmri5p7yXh5BvpAJJAlHZAeb/M3A4vT5Jt/EUkFxEus2
         JXeCRbxOb2U5nzaefaspiN/1PJChs6GrBvWhvSxGNpAYH+DpTOOUbnS43vEGfNo8QB2b
         X6V+ws4DEEZeyihtBtUE0YNu151YQJ35+VH9mJMqksoEKb+jKdf8T8TR0iM7pilBxdO6
         e2dw==
X-Gm-Message-State: APjAAAUZyWjeiBtU79ujjikATpOpIhy1+aTWiqJ+8U3JmSo3rCXtKM7n
        3Zqf7QqqIr/JdR16g/QkLZI=
X-Google-Smtp-Source: APXvYqzEc8c93Q8WdI0JtTo7a58BfiKWqg1gsGf1bwbEx1dZkRYzw6K7h+9fAFf3rwubwjj6pJGzHw==
X-Received: by 2002:a37:414:: with SMTP id 20mr18188829qke.402.1574711244271;
        Mon, 25 Nov 2019 11:47:24 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:23 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 15/22] btrfs: limit max discard size for async discard
Date:   Mon, 25 Nov 2019 14:46:55 -0500
Message-Id: <513d7057bfcae4e486c2c62275c1873f6ab256b1.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Throttle the maximum size of a discard so that we can provide an upper
bound for the rate of async discard. While the block layer is able to
split discards into the appropriate sized discards, we want to be able
to account more accurately the rate at which we are consuming ncq slots
as well as limit the upper bound of work for a discard.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/discard.h          |  5 ++++
 fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 88f1363aa4e4..e1819f319901 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -3,10 +3,15 @@
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
 
+#include <linux/sizes.h>
+
 struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group;
 
+/* Discard size limits. */
+#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+
 /* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5655416f0ae7..452afd616623 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3442,19 +3442,40 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (entry->offset >= end)
 			goto out_unlock;
 
-		extent_start = entry->offset;
-		extent_bytes = entry->bytes;
-		extent_trim_state = entry->trim_state;
-		start = max(start, extent_start);
-		bytes = min(extent_start + extent_bytes, end) - start;
-		if (bytes < minlen) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			goto next;
-		}
+		if (async) {
+			start = extent_start = entry->offset;
+			bytes = extent_bytes = entry->bytes;
+			extent_trim_state = entry->trim_state;
+			if (bytes < minlen) {
+				spin_unlock(&ctl->tree_lock);
+				mutex_unlock(&ctl->cache_writeout_mutex);
+				goto next;
+			}
+			unlink_free_space(ctl, entry);
+			if (bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE) {
+				bytes = extent_bytes =
+					BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				entry->offset += BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				entry->bytes -= BTRFS_ASYNC_DISCARD_MAX_SIZE;
+				link_free_space(ctl, entry);
+			} else {
+				kmem_cache_free(btrfs_free_space_cachep, entry);
+			}
+		} else {
+			extent_start = entry->offset;
+			extent_bytes = entry->bytes;
+			extent_trim_state = entry->trim_state;
+			start = max(start, extent_start);
+			bytes = min(extent_start + extent_bytes, end) - start;
+			if (bytes < minlen) {
+				spin_unlock(&ctl->tree_lock);
+				mutex_unlock(&ctl->cache_writeout_mutex);
+				goto next;
+			}
 
-		unlink_free_space(ctl, entry);
-		kmem_cache_free(btrfs_free_space_cachep, entry);
+			unlink_free_space(ctl, entry);
+			kmem_cache_free(btrfs_free_space_cachep, entry);
+		}
 
 		spin_unlock(&ctl->tree_lock);
 		trim_entry.start = extent_start;
@@ -3619,6 +3640,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			goto next;
 		}
 
+		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
+			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
 			free_bitmap(ctl, entry);
-- 
2.17.1

