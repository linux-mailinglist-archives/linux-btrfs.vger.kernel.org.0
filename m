Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8996E47639D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhLOUn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7012C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:57 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so21389790qkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rWLAtjizEnheBFycFFLYahPAgWeIZaHLmkDO7UBlmv8=;
        b=2aiJuaGFvK2A4EFCDrBSk+pO53efiyADmffszvUqFYcbjyp7Ly0VBW5IkRHliWuVp0
         20Z2QWzlrSlzZtlo/uGcI+zDvgS+pInAyD8T9dlyCyJSXWs1pbrDZRuVQIgr6GzKUOvq
         NBY9BvBkf37LobijqsjJCmVjOf0fJjfsry2qYSxVQaSbBdLFFicSKlNDQ8WLeRVVmYhT
         lKsWbWefxw6EtQm56KaDqjAycPRwH8dGCjSl2hRzHSwPp7jTwalgZzV5xqHJIZ8/HgRw
         glpu/GqZZH1HlH97NhNdkDLMmj7QOgNCRx0TS9txrkar40bXq1FokMsrJHKLdH7dRqSP
         4f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWLAtjizEnheBFycFFLYahPAgWeIZaHLmkDO7UBlmv8=;
        b=X8id+CoB2wJu8fWCUDJbn8oaICYgQI18zSVzCzgoeiwLk9s8EEcUlYnEiNVO1Ujl+L
         S7WrCLGPt4xWXshANj4J38NFJntxt1TJZd93RdBeGpx9xrxGnNKhn4AdtHYdPWnkkReR
         h52d0mCoMWWgXOFHnDsWJkgO/TgYk5aR+OrBtwDcgxnQhJgFjVX1maSQlTVcWPnIVhKl
         LYqMujn1KW1QnIGMV1yndom/TXg4k+jK9ZNfu3IYr9q7eK5/NZZVdCgCJVIcmHzdNlsr
         f/RLXWV9K33X6eRH3FWQP6CWPsUHeoQ0aGhnS5FXcUZmZWTB8bVQSlyaqXl9J1pVS3UO
         M/jQ==
X-Gm-Message-State: AOAM530ZhAcI5lsrg5Qo2Csct9icrhJ9LYtXqNchCA3gLjbdnQvmNKMW
        S47EsiI5J1kZDzKrvAwsPI4314kEJuGqXw==
X-Google-Smtp-Source: ABdhPJwxnn3gFKPuZKiWobf+tEIHQOx7Mw8oe/BOUqacYe1HPriQMtFph/K2qAn+N2Y/k1GzZB17Kw==
X-Received: by 2002:a37:c94:: with SMTP id 142mr10231299qkm.470.1639601036569;
        Wed, 15 Dec 2021 12:43:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o10sm2325606qtx.33.2021.12.15.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: add a btrfs_first_item helper
Date:   Wed, 15 Dec 2021 15:43:43 -0500
Message-Id: <42fa95e1cdbd30457dcec8c2b0a3f55966b133af.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The GC tree stuff is going to use this helper and it'll make the code a
bit cleaner to abstract this into a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 23 +++++++++++++++++++++++
 fs/btrfs/ctree.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 781537692a4a..efb413a6db0c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4775,3 +4775,26 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 	}
 	return 1;
 }
+
+/**
+ * btrfs_first_item - search the given root for the first item.
+ * @root: the root to search.
+ * @path: the path to use for the search.
+ * @return: 0 if it found something, 1 if nothing was found and < on error.
+ *
+ * Search down and find the first item in a tree.  If the root is empty return
+ * 1, otherwise we'll return 0 or < 0 if there was an error.
+ */
+int btrfs_first_item(struct btrfs_root *root, struct btrfs_path *path)
+{
+	struct btrfs_key key = {};
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret > 0) {
+		if (btrfs_header_nritems(path->nodes[0]) == 0)
+			return 1;
+		ret = 0;
+	}
+	return ret;
+}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2a5ed393eb21..6bcf112f9872 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2892,6 +2892,7 @@ void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
+int btrfs_first_item(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type);
-- 
2.26.3

