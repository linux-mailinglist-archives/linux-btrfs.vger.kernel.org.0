Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1134CED4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfJGUSI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfJGUSH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so13898729qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p5f1fR6uqshj2e3AeHo2v6JCgHrjUmX0NwZ1sL8nb/w=;
        b=D/VHKxyb1JVLWdHepr929HzBwspAtMsLAqw7DJsEe8a0TYgqYjvdhZ9N2bqQe6DISJ
         yg2aTfek3jSTGH2sI42vpcns5JgP3V6ZQywb+5Cshna34+8/pQaKZfZLCXrEF5v/wR4j
         E5RbkBTB83rCHCJUybXbDtR2tTYVeUx/i0Sthg8KFE0JnMuU8MBf71uF6m8LU8ne3rBX
         obXBwhMe2/rJamxWa9DRIpkuuwbH53Jl0dVDx8MOBo8NE1K6W/x0uq6IESBRUE4Kc6qQ
         dslJBv4/N6sCmMrsosbfIC6+TtmnIDN37shO59YDolow5rFwMe2LD/KINOO129mVdpnp
         Yvow==
X-Gm-Message-State: APjAAAVioj1ROwW4rdxlQRjSW5Tr7qE3ParQBQI/KnECVuwbiSpB2aBp
        PZCzYZ6jaKZmVRI3Q0HFqSk=
X-Google-Smtp-Source: APXvYqzNXgFQ2DXnJExJLG/lQfvB+VBMhs1EF72u02hdYNmMFtH4MlHRnDSPOb3aB2jYkqgLbyH+Hw==
X-Received: by 2002:a37:e58:: with SMTP id 85mr25242403qko.403.1570479487060;
        Mon, 07 Oct 2019 13:18:07 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:06 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/19] btrfs: limit max discard size for async discard
Date:   Mon,  7 Oct 2019 16:17:43 -0400
Message-Id: <7eed2e0ebdc4cc4a7e31c6fa7a180f10158fba0f.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
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
---
 fs/btrfs/discard.h          |  4 ++++
 fs/btrfs/free-space-cache.c | 47 +++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index acaf56f63b1c..898dd92dbf8f 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/jiffies.h>
+#include <linux/sizes.h>
 #include <linux/time.h>
 #include <linux/workqueue.h>
 
@@ -15,6 +16,9 @@
 #include "block-group.h"
 #include "free-space-cache.h"
 
+/* discard size limits */
+#define BTRFS_DISCARD_MAX_SIZE		(SZ_64M)
+
 /* discard flags */
 #define BTRFS_DISCARD_RESET_CURSOR	(1UL << 0)
 #define BTRFS_DISCARD_BITMAPS           (1UL << 1)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 54f3c8325858..ce33803a45b2 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3399,19 +3399,39 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 		if (entry->offset >= end)
 			goto out_unlock;
 
-		extent_start = entry->offset;
-		extent_bytes = entry->bytes;
-		extent_flags = entry->flags;
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
+			extent_flags = entry->flags;
+			if (bytes < minlen) {
+				spin_unlock(&ctl->tree_lock);
+				mutex_unlock(&ctl->cache_writeout_mutex);
+				goto next;
+			}
+			unlink_free_space(ctl, entry);
+			if (bytes > BTRFS_DISCARD_MAX_SIZE) {
+				bytes = extent_bytes = BTRFS_DISCARD_MAX_SIZE;
+				entry->offset += BTRFS_DISCARD_MAX_SIZE;
+				entry->bytes -= BTRFS_DISCARD_MAX_SIZE;
+				link_free_space(ctl, entry);
+			} else {
+				kmem_cache_free(btrfs_free_space_cachep, entry);
+			}
+		} else {
+			extent_start = entry->offset;
+			extent_bytes = entry->bytes;
+			extent_flags = entry->flags;
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
@@ -3567,6 +3587,9 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			goto next;
 		}
 
+		if (async && bytes > BTRFS_DISCARD_MAX_SIZE)
+			bytes = BTRFS_DISCARD_MAX_SIZE;
+
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
 			free_bitmap(ctl, entry);
-- 
2.17.1

