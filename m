Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1612EB4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgABV0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:55 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39423 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABV0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:55 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so15515641qvk.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MtLI26uKkR+KnPVywuu3DHK8aDekgZjDX7rcaBxOf1Q=;
        b=p5K6U5kepYinYYIOSirPl4N3AGtyAVVgsxrVQdPNHKJkQC1Tg/wj5nfqfdnModkAcI
         ueeed4BMhu9wucUl8LhhWAjplWbF7GTklptR3U4Yj4wOXW/+Qv7h/ODka3pSDzbT62c3
         hqFsNJY2OCDq7yExUgS4iOfnseFk9nRhUtSOsBc2Jh/iZfxjLUL5EM6BqMT9+cAWF3FG
         wm0TSrRGwF3FLtDwir53SP3EVtJyHn0HazXDNmraW+eoDrHolNieK2UkaxW3nvBDXmXT
         0QchaOaJZgIWe+M+FJrtAPq+S4aoLEvquMv3St8NSDUxH6T9rjP/ZvDD3sGyeb56uecv
         hPJw==
X-Gm-Message-State: APjAAAUaQgC3E+nCgK5qihA8CtyodhSnJWXXJa+5lFlUXslxkVw4ZT9s
        Tw2xHEEFy5LpAemriMa8Ui0=
X-Google-Smtp-Source: APXvYqzSvN+kulNUxO2u1UyUnlQ4QlwxPLAIc+PWxJN2OYUJZzXQj965eLGh+y5Z/6By12d606XR4w==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr65548308qvh.66.1578000414174;
        Thu, 02 Jan 2020 13:26:54 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:53 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 03/12] btrfs: limit max discard size for async discard
Date:   Thu,  2 Jan 2020 16:26:37 -0500
Message-Id: <b0dada84ff74a4c7246acad7fe78250550b89f7f.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
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
 fs/btrfs/discard.h          |  5 +++++
 fs/btrfs/free-space-cache.c | 41 +++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 5250fe178e49..562c60fab77a 100644
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
 
+/* Discard size limits */
+#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+
 /* Work operations */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 40fb918a82f4..34291c777998 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3466,16 +3466,36 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		extent_start = entry->offset;
 		extent_bytes = entry->bytes;
 		extent_trim_state = entry->trim_state;
-		start = max(start, extent_start);
-		bytes = min(extent_start + extent_bytes, end) - start;
-		if (bytes < minlen) {
-			spin_unlock(&ctl->tree_lock);
-			mutex_unlock(&ctl->cache_writeout_mutex);
-			goto next;
-		}
+		if (async) {
+			start = entry->offset;
+			bytes = entry->bytes;
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
@@ -3639,6 +3659,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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

