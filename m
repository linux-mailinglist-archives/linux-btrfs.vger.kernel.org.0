Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D272DC491
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgLPQrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLPQrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:47:42 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1572BC0617B0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:47:02 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 7so17719556qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EV7OBYbvQyRpgk1rKTEHPMQpfOQ0GHhQeRq58LCw6h0=;
        b=Qocqjk9X98+I+uco1EQmMZlWnXflJEt5X+8EsFyYEzV9lzkpOyfaugSbZhPnPp5GCI
         MStlPUV8vsPaC/TYgBzgYhrGOwSLft+0Bl8ZbilNcUoIhIqYXH3kbBRI5qX+DC0u6WRd
         hmzFpmO+GLbsppKaoPbLplrALojo3CBObt+E+kPux4tnnEhIyQidbGWn/lA6LfLxBCPw
         jkc3QhMVsZ4YhH0iwIl7ZsJM4fJ3yaQ3sQ9wyiAv85WYqRSpN7CgTMaB8vIeIuyuBxtO
         dP8JxHUg71TtIGdbgMZNrNveuR9ABYkzm0LL6NmvlWW2iHc3Aigo/MrNZuG9j+/kPViU
         +Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EV7OBYbvQyRpgk1rKTEHPMQpfOQ0GHhQeRq58LCw6h0=;
        b=pjImbm53rR2uKgv+vQbgnsmQyfJfkPj019BTdQzlP4ggXq6EoU5NXvIkM3ZpC5a/5x
         0WiOhur8dE7mwyjRYMn4kiOhjRCBirraXrlteOcUIbkS2ULPoOtcS9RaSeiYcwDxKVE9
         /hL19rgLz4lIzkZrScfk9zwGGXO4Jnrksx721ivAntn6ERV+5I7kx6EOPUQb992ghxj5
         JeV6RQCuZCED7jXHprGiXLRI0FQqMj6HZnEqgVs0a1YHdhMFQFWs4S6jkpcAjwfVdlrl
         LDqeBZLWF96ba7wc4OB8MkAjsMunbT6UhPDUK06v/1DTXcLtAXtYwqxKBtmp1YFdGFeJ
         aauQ==
X-Gm-Message-State: AOAM531VqJI1G6qVxbGeJ+pmerV7LBTMyEp47OHCaVyRTBJYo3+Ln6tr
        lmwRHlcHSaPp5YXS4750slHgOFUZS8q/aD7q
X-Google-Smtp-Source: ABdhPJysqZn4YhVGc07A6f99nxIajh9pG+lCjJJkmHZfgKiqbowVPoygtfbuk+7LSY0oPhNi/hQC6g==
X-Received: by 2002:aed:2084:: with SMTP id 4mr42761504qtb.81.1608137220872;
        Wed, 16 Dec 2020 08:47:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x185sm1409288qkb.87.2020.12.16.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:47:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: account for new extents being deleted in total_bytes_pinned
Date:   Wed, 16 Dec 2020 11:46:54 -0500
Message-Id: <0826b647d5dd12f8134614e05519156d9351f2c1.1608137123.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137123.git.josef@toxicpanda.com>
References: <cover.1608137123.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My recent set of patches to reduce lock contention on the extent root by
running delayed refs resulted in a regression in generic/371.  This test
fallocate()'s the fs until it's full, deletes all the files, and then
tries to fallocate() until full again.

Before my delayed refs patches we would run all of the delayed refs
during flushing, and then would commit the transaction because we had
plenty of pinned space to recover in order to allocate.  However my
patches made it so we weren't running the delayed refs as aggressively,
which meant that we appeared to have less pinned space when we were
deciding to commit the transaction.

We use the space_info->total_bytes_pinned to approximate how much space
we have pinned.  It's approximate because if we remove a reference to an
extent we may free it, but there may be more references to it than we
know of at that point, but we account it as pinned at the creation time,
and then it's properly accounted when the delayed ref runs.

The way we account for pinned space is if the
delayed_ref_head->total_ref_mod is < 0, because that is clearly a
free'ing option.  However there is another case, and that is where
->total_ref_mod == 0 && ->must_insert_reserved == 1.

When we allocate a new extent, we have ->total_ref_mod == 1 and we have
->must_insert_reserved == 1.  This is used to indicate that it is a
brand new extent and will need to have its extent entry added before we
modify any references on the delayed ref head.  But if we subsequently
remove that extent reference, our ->total_ref_mod will be 0, and that
space will be pinned and freed.  Accounting for this case properly
allows for generic/371 to pass with my delayed refs patches applied.

It's important to note that this problem exists without my delayed refs
patches, it just was uncovered by them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c |  7 +++++++
 fs/btrfs/extent-tree.c | 34 ++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1edb0095f08d..33247f2d0c27 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -732,6 +732,9 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	 * 2. We were negative and went to 0 or positive, so no longer can say
 	 *    that the space would be pinned, decrement our counter from the
 	 *    total_bytes_pinned counter.
+	 * 3. We are now at 0 and have ->must_insert_reserved set, which means
+	 *    this was a new allocation and then we dropped it, and thus must
+	 *    add our space to the total_bytes_pinned counter.
 	 */
 	if (existing->total_ref_mod < 0 && old_ref_mod >= 0)
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
@@ -739,6 +742,10 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	else if (existing->total_ref_mod >= 0 && old_ref_mod < 0)
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
 					     -existing->num_bytes);
+	else if (existing->total_ref_mod == 0 &&
+		 existing->must_insert_reserved)
+		btrfs_mod_total_bytes_pinned(fs_info, flags,
+					     existing->num_bytes);
 
 	spin_unlock(&existing->lock);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 076b4f66049e..7af7700dc039 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1754,23 +1754,29 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 {
 	int nr_items = 1;	/* Dropping this ref head update. */
 
-	if (head->total_ref_mod < 0) {
+	/*
+	 * We had csum deletions accounted for in our delayed refs rsv, we need
+	 * to drop the csum leaves for this update from our delayed_refs_rsv.
+	 */
+	if (head->total_ref_mod < 0 && head->is_data) {
+		spin_lock(&delayed_refs->lock);
+		delayed_refs->pending_csums -= head->num_bytes;
+		spin_unlock(&delayed_refs->lock);
+		nr_items += btrfs_csum_bytes_to_leaves(fs_info,
+						       head->num_bytes);
+	}
+
+	/*
+	 * We were dropping refs, or had a new ref and dropped it, and thus must
+	 * adjust down our total_bytes_pinned, the space may or may not have
+	 * been pinned and so is accounted for properly in the pinned space by
+	 * now.
+	 */
+	if (head->total_ref_mod < 0 ||
+	    (head->total_ref_mod == 0 && head->must_insert_reserved)) {
 		u64 flags = btrfs_ref_head_to_space_flags(head);
 		btrfs_mod_total_bytes_pinned(fs_info, flags,
 					     -head->num_bytes);
-
-		/*
-		 * We had csum deletions accounted for in our delayed refs rsv,
-		 * we need to drop the csum leaves for this update from our
-		 * delayed_refs_rsv.
-		 */
-		if (head->is_data) {
-			spin_lock(&delayed_refs->lock);
-			delayed_refs->pending_csums -= head->num_bytes;
-			spin_unlock(&delayed_refs->lock);
-			nr_items += btrfs_csum_bytes_to_leaves(fs_info,
-				head->num_bytes);
-		}
 	}
 
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
-- 
2.26.2

