Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3472F87E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 22:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAOVto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 16:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhAOVtn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 16:49:43 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09888C061793
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:49:03 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id p14so13198902qke.6
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIo9gsV4o/pU2yL2SFr4I3B545GgyGEE/EEGibTzCk0=;
        b=UZCMek7wPncSoC2wK9S43BCgQWvSEAm24E/+9aBVrlM6IAj8FWuEWVO6eleeP5oF5K
         Wl8CqeEklAf1xfZGZnDv7+dS88iRWmHQ+qVzl/5U5EqFI36PXMrBbi872qumSP31kWvv
         7594F09Ojj4INqncYER8PlDqK7FZcZcvUFK3ILPuCAfqV4Ng6MYrD6uBzE3RzH65XYV4
         nopc1aYJsJNwmVbvRZCZOP4XSuGq/ZLHS76u+8OcTZ3k0oHI/G/xG/HlI8CwiexH5wCx
         Ia21ol5cvUFVa3/D8yL1j5b8qv6gPvr3PNYBT+9tfRAHMQugiHkQFipOLP+Un/tkZugh
         qudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIo9gsV4o/pU2yL2SFr4I3B545GgyGEE/EEGibTzCk0=;
        b=kvzGDE+bQBoofaPHUYdKqjCn212MXemFkrbG3h+moSU7NGWBhY91CWlF34ibyMCqZQ
         l6S0cGWAi+0Z9qTBYCdyJVXpLY8kfOLmjqwc+kJ4X63r0HwotM417aVepyBXrds8ybNC
         O5C/CWB8002+rGV74AAWC1f4WlMwkK7yXnzhhKnvEyCv1q2RLOL0Tzezzk/qnL+zI5lx
         oXr+7UfGmnk65iqL6v0SeYdBrhIflGu8o/HKGf5+mxYGcbknw2/lE6kyOYvyk4QdSohA
         ARyQKACL49wlEGzfmURNrpYl8Y5EGhYpIX7OZO/g9l71yps77CNmp8z/VtuX0TielUxx
         G1Hw==
X-Gm-Message-State: AOAM531rpNBbJdI+CVf5VMIJIo16GslGNdcuAct4bAxpWtf+is78hufw
        QCy60T0UvElMT+NsYOW6JShpuXMw27LCnVOz
X-Google-Smtp-Source: ABdhPJzI7GmMha62Y3P8Jf3/DryG3Yig9xAItBnSISkhx/jwXx7jBGSaJHkrYv/Hm4FrDaXY1JK8ZA==
X-Received: by 2002:a37:ae44:: with SMTP id x65mr14763862qke.347.1610747341891;
        Fri, 15 Jan 2021 13:49:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o29sm5576467qtl.7.2021.01.15.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:49:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 2/2] btrfs: account for new extents being deleted in total_bytes_pinned
Date:   Fri, 15 Jan 2021 16:48:56 -0500
Message-Id: <9a73d5fe6572858e859f739183c8a94f05d22bf0.1610747242.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610747242.git.josef@toxicpanda.com>
References: <cover.1610747242.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My recent patch set "A variety of lock contention fixes", found here

https://github.com/btrfs/linux/issues/86

that reduce lock contention on the extent root by running delayed refs
less often resulted in a regression in generic/371.  This test
fallocate()'s the fs until it's full, deletes all the files, and then
tries to fallocate() until full again.

Before these patches we would run all of the delayed refs during
flushing, and then would commit the transaction because we had plenty of
pinned space to recover in order to allocate.  However my patches made
it so we weren't running the delayed refs as aggressively, which meant
that we appeared to have less pinned space when we were deciding to
commit the transaction.

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

It's important to note that this problem exists without the referenced
patches, it just was uncovered by them.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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
index 290d957f4603..65a88f9333e6 100644
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

