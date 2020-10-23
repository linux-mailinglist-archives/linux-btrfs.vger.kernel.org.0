Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29C029730A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464727AbgJWP76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374469AbgJWP76 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 11:59:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D679C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 08:59:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m65so1283969qte.11
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcuCmQtMQvf2XCZINiqcJn50gvH/ga0O8NjtGW/Try4=;
        b=Yo5ydq2l+4fBV2loax/54QNsaAnO9uNLng21iSkdG0kAGbTbKGQqX0MavvjmhcujVp
         3LwyxfnoG9NYUb+EaVfaWkKN4IQazWAMirpqcSNlsuA45aiEQl5+gbuTx9yLY04KikMa
         QmU1i5wjtP31KQZavcfPToM0GA2ZvaxZKWpzjiLH/68b53wE1MX9BOHPwA3GC4yl865+
         LqRyaXN9frObkY9GJXg4872PCVnlJkKGaWLbK5VeJKQXTBB+cpOzOtudy1eCvWraZpv1
         COfRiy6tk1cGsPyfsQgS/stDkyp1SKSyNW6J0UMXFbqwVibU3inK+fRlYL/yEZayM0C6
         XpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GcuCmQtMQvf2XCZINiqcJn50gvH/ga0O8NjtGW/Try4=;
        b=mMvjc4N1PoF01Dj7EHoSTxYLsMEyREwtfkIUJ3YY/NUgt5wWu4tlShATNg2zRjDY85
         G205uwTVsOF8WdYXKkR/D+1d/iof9+vYHP2LDK0u45u9miIeBclyQXcvs/XiRLGuA6S/
         snA0ekP/XXj9JuIs2HwmeQNL2gv4lHgtQR6lVfu7e4AZz050aqu9tvadyOom2DROsFGR
         nz0mL4ZezeikV2tzdVJR3sB8nJ7HNbfiWaLswLaggkg7jpnRhv3vw472Tmemvh8hm6Nd
         LqNDs7BOYd0Z3ApHEdtPzeDZ7Kx7U+JaILOJ2WnW8n9Wgh6L4RkQNnzUp0FFJvR1TwlS
         QRkg==
X-Gm-Message-State: AOAM533sfYnIBscbpbCG2bDdJo5ztdTnbrxfSwlIyM5N3uqLqFG+3YR5
        FYGKjN+Ke2m9RIIzQYpxfZkRo3OOyzrdKFFz
X-Google-Smtp-Source: ABdhPJzLkE6lZZxdNTNZaO58Fj7PF4DM5dtdWcjb6e4mSOg10PZPPhe5XkbJSUHTEU/TjKi76+IP5A==
X-Received: by 2002:a05:622a:242:: with SMTP id c2mr2949509qtx.230.1603468795247;
        Fri, 23 Oct 2020 08:59:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e39sm1112574qtk.32.2020.10.23.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:59:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: lookup global roots with our backref commit root helper
Date:   Fri, 23 Oct 2020 11:59:53 -0400
Message-Id: <d9fc7a26e9424237f3174bacc3e728f966c7562f.1603468749.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I messed up with my backref commit root helper, I assumed we would only
ever want to look up fs roots, but the relocation code now uses the
backref code, and we can find data extents in the tree_root because of
space cache v1.  Fix this by looking up the global root first, so we
make sure to always find the root that we're looking for.

Fixes: f4f9794a5aa1 ("btrfs: add a helper to read the tree_root commit root for backref lookup")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Dave, I assume you'll want to just fold this into the fixes, I just added the
fixes so you knew what patch to roll this into.

 fs/btrfs/disk-io.c | 57 ++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f44e74815dd0..319c22d14f14 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1423,6 +1423,31 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 	return root;
 }
 
+static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
+						u64 objectid)
+{
+	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->tree_root);
+	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->extent_root);
+	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->chunk_root);
+	if (objectid == BTRFS_DEV_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->dev_root);
+	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->csum_root);
+	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->quota_root) ?
+			fs_info->quota_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_UUID_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->uuid_root) ?
+			fs_info->uuid_root : ERR_PTR(-ENOENT);
+	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
+		return btrfs_grab_root(fs_info->free_space_root) ?
+			fs_info->free_space_root : ERR_PTR(-ENOENT);
+	return NULL;
+}
+
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root)
 {
@@ -1522,25 +1547,9 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key;
 	int ret;
 
-	if (objectid == BTRFS_ROOT_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->tree_root);
-	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->extent_root);
-	if (objectid == BTRFS_CHUNK_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->chunk_root);
-	if (objectid == BTRFS_DEV_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->dev_root);
-	if (objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->csum_root);
-	if (objectid == BTRFS_QUOTA_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->quota_root) ?
-			fs_info->quota_root : ERR_PTR(-ENOENT);
-	if (objectid == BTRFS_UUID_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->uuid_root) ?
-			fs_info->uuid_root : ERR_PTR(-ENOENT);
-	if (objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return btrfs_grab_root(fs_info->free_space_root) ?
-			fs_info->free_space_root : ERR_PTR(-ENOENT);
+	root = btrfs_get_global_root(fs_info, objectid);
+	if (root)
+		return root;
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
@@ -1648,6 +1657,16 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(struct btrfs_fs_info *fs_info,
 
 	ASSERT(path->search_commit_root && path->skip_locking);
 
+	/*
+	 * This can return -ENOENT if we ask for a root that doesn't exist, but
+	 * since this is called via the backref walking code we won't be looking
+	 * up a root that doesn't exist, unless there's corruption.  So if root
+	 * != NULL just return it.
+	 */
+	root = btrfs_get_global_root(fs_info, objectid);
+	if (root)
+		return root;
+
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root)
 		return root;
-- 
2.26.2

