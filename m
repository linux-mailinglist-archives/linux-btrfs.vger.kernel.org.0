Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD2811EF2A
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfLNAW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34671 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLNAW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so417997pjs.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EZWLYFvOu5bkp8WfSicicLL9EpWL+yOHxU20GbXIJwE=;
        b=IM9IO9Ih27KzlELqfm1ES6au3jCorrNc3bBRON25CElO2YHEiGbQghqEywTdRMwk/e
         AjMaFwvMlfF1gGpyfSNZbvhn1Ul/OfqNCDq6XPMr7e430t+WbvB8KErCRAWDajcQeaAL
         n/7jx+J4QVSFS/B205zKSjvOCgFTGNYlS2IYBSOIddKyLvTZVESVcx4MFBq847qUn9Gk
         2qopHNIi34Kb/imucdNev4nJBFEFGYJzRA5uoH1cKdqUkEwg9DL4rO8YnA0QiP5hhIeh
         hrP3kvW1qVpN63zCZPY6A0QV/9i3oXlKdM2UoM+qYQzw1Zb2J5+Bmc8fzXcSYOYbqM/z
         ZrEw==
X-Gm-Message-State: APjAAAUnwUF5OZyz2mIZm8zvt6WiMGzGkusHmbHkUAfBMIiCsbu/fylk
        xpfgWcRFEyYLasmrcG+dLEY=
X-Google-Smtp-Source: APXvYqzHGjU6ZBDTM1wEoHmgIOPcL+4wtaahVV0dltt+l8JOqKrRQt8rZhx8gMCkuTdpJO6Du/uzVA==
X-Received: by 2002:a17:902:67:: with SMTP id 94mr2459834pla.241.1576282975357;
        Fri, 13 Dec 2019 16:22:55 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:54 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 15/22] btrfs: limit max discard size for async discard
Date:   Fri, 13 Dec 2019 16:22:24 -0800
Message-Id: <396e2d043068b620574892ebfc4b9f5c77b41618.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index 3ed6855e24da..cb6ef0ab879d 100644
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
 /* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 57df34480b93..0dbcea6c59f9 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3466,19 +3466,40 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3643,6 +3664,9 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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

