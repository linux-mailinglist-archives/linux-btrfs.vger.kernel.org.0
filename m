Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3045CD08
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbhKXTTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245163AbhKXTSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 14:18:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F795C0613F9
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:31 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 132so3945200qkj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 11:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eV76BhMaV7ICxpaf3Rg687QKyoeuV9qyzdY3LRAyKLw=;
        b=YGsMmSWI5k0feZlQnhV29vVAzpdbNBQmF5m0Ed6PVX/aLw55zEuOYI/y3TOt8JPaRS
         2wPkXL2LvhCZ6crJIttnFXbhR+fK4gYAfkEoKHB20JRkimK2bWiTXiXB+k0TjucuARmd
         P1DAbnzYBOZDAk1Bnq2lBu4PyFIa47H375mwvx0t630mv/JbUurALdVD7xpdbBO+paH8
         aMXzVLHzFFxRQS4y0sKJkF0fiBbeIbg8Ic9GdCGt+/g9rU2wautTnA+0cigIym2/Wxj2
         Jtla5mVDRGqZVZr+/32OJbNbda2TLVfns1oed3ti97GBdjkvJU3hGx6T2dp4ll0Tg8Gw
         nPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eV76BhMaV7ICxpaf3Rg687QKyoeuV9qyzdY3LRAyKLw=;
        b=l43yiRTuFiqW6gjIRbd14TroPyDBcUGpe8HdRve7F3lillPlHN5MbZEsLJRoNIcfid
         8F359l61ofnxXtsvEcJlBnTPESg1lIV6BQDp9jtR/TIAnYOatkHmUvrsnR1bPjfJ6tAb
         giMeTOIJ0UZRbI0wgve1B/ePnq71WYM55udMhV2A93Zq3yGghlRkFv2CUi6ajXAgmN/Y
         kJm13aJKL8MSXgXF1V+3wrkXebTRVl0ZzbP3b54ZmY7kK4EkV1oUh7nRgsm7dFC6EKpo
         v+18286IRFwyYxMC+irO9RHRfIkugQLxgVMor0zlA6317JYR2HbgNN/uUJlEntglKpgL
         EcKg==
X-Gm-Message-State: AOAM533mwsQoiPAvojixCDfKwutegRZrpPzeVkLXTOi3bcphX5/5H3MM
        IbOf9r2Aj+g67dX3Qj8uHW0h6LBQkyOLTA==
X-Google-Smtp-Source: ABdhPJxI/ew+VB9Ze71YNnwaoxkPa0PFIAq+GeEc1W1uvaMckYvS06pz3UXsN6C+3Fqdb0mfwgNDvQ==
X-Received: by 2002:a37:68ce:: with SMTP id d197mr672891qkc.693.1637781269937;
        Wed, 24 Nov 2021 11:14:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j24sm265776qkg.133.2021.11.24.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:14:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: check the root node for uptodate before returning it
Date:   Wed, 24 Nov 2021 14:14:24 -0500
Message-Id: <1d95650cf7f6c184b112c41801620b5faf43a520.1637781110.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637781110.git.josef@toxicpanda.com>
References: <cover.1637781110.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we clear the extent buffer uptodate if we fail to write it out
we need to check to see if our root node is uptodate before we search
down it.  Otherwise we could return stale data (or potentially corrupt
data that was caught by the write verification step) and think that the
path is OK to search down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 216bf35f6caf..d2297e449072 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1568,12 +1568,9 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 							int write_lock_level)
 {
 	struct extent_buffer *b;
-	int root_lock;
+	int root_lock = 0;
 	int level = 0;
 
-	/* We try very hard to do read locks on the root */
-	root_lock = BTRFS_READ_LOCK;
-
 	if (p->search_commit_root) {
 		b = root->commit_root;
 		atomic_inc(&b->refs);
@@ -1593,6 +1590,9 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 		goto out;
 	}
 
+	/* We try very hard to do read locks on the root */
+	root_lock = BTRFS_READ_LOCK;
+
 	/*
 	 * If the level is set to maximum, we can skip trying to get the read
 	 * lock.
@@ -1619,6 +1619,17 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 	level = btrfs_header_level(b);
 
 out:
+	/*
+	 * The root may have failed to write out at some point, and thus is no
+	 * longer valid, return an error in this case.
+	 */
+	if (!extent_buffer_uptodate(b)) {
+		if (root_lock)
+			btrfs_tree_unlock_rw(b, root_lock);
+		free_extent_buffer(b);
+		return ERR_PTR(-EIO);
+	}
+
 	p->nodes[level] = b;
 	if (!p->skip_locking)
 		p->locks[level] = root_lock;
-- 
2.26.3

