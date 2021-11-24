Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A245CB30
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbhKXRkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 12:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242705AbhKXRkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:35 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57AC06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:25 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t6so3674725qkg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eV76BhMaV7ICxpaf3Rg687QKyoeuV9qyzdY3LRAyKLw=;
        b=OgxN/dt+15IPMasEYFUqQer621xTq2zsBuzlvhCX4dJiBsPdAiM0+2IQ+qJL2iKx9J
         5NR4Zwk07bBtiCA/OPUs43cpII14F7Jo7w5rYYWjxyruJnw8fPMec6IEYP6ld2DMYpLc
         N2WNeLSv4vjNQeXUd1qTdqDBoFK/sheayshWRsmUYISc38gQU2CmUx7PdD+8zbeZFNmS
         CB2vIYxnrEyCuzvRiKQvfAuDBRkYtbwA/xisqNOcA36OrsvgNz0BXTRxbDUkK2lwRaz3
         UtRhVZZW1yE3f6sCUZyNEQQlsXR5Es3P7PJ7oYUDtVHf4npDOoTqEX0YnJ8SJxFZMmwv
         MMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eV76BhMaV7ICxpaf3Rg687QKyoeuV9qyzdY3LRAyKLw=;
        b=ylbEnEbG6XHtUZv3zGFND5FQmnBOKdCJuYdA2CLUo8/pVDgBxO3YGzteVHEekE+koN
         KNiQa1+VCRcJyrKSYdm0OQ8M2+hKuNWofODcfgkphgwp3MeZF0wji81zR8UcWHWuurLc
         SG6NmtEa+QbI4ZPxeyG87/KsYr9I7AC9fCBltPgyPHBehOt7x/TR8Ile8DwIyT2fmC+V
         STOwjva7BaVgB876/WSvURhbAwhIw26klIvIy2nwi5UvWL4FfBABGPL8dfy97qDkvUPJ
         A2Bo8Gur5/cDm7exzpn/U1OKlP/if3+LOjPySsvBHQ8YLoKaoBkExB1GgWoKIqOSTXIx
         X9og==
X-Gm-Message-State: AOAM530LKNYJl5xOqge2+dhPMIqQzT8NzkQ4U6AQcG4rMjJCfQHoiS28
        lJjWn1lXcemXSeeGz3mEL1wDvx9P9DhJsQ==
X-Google-Smtp-Source: ABdhPJzkW8Jki0nvbZbCxvMZL7wKDkrwShpjTyllG1GgnwYEtUGiPsBIwXhRbrcrFnh5xu2dNjRocA==
X-Received: by 2002:a05:620a:20d6:: with SMTP id f22mr7936863qka.342.1637775443596;
        Wed, 24 Nov 2021 09:37:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m19sm180011qkn.129.2021.11.24.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:37:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: check the root node for uptodate before returning it
Date:   Wed, 24 Nov 2021 12:37:18 -0500
Message-Id: <1d95650cf7f6c184b112c41801620b5faf43a520.1637775291.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637775291.git.josef@toxicpanda.com>
References: <cover.1637775291.git.josef@toxicpanda.com>
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

