Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123D2A827F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbgKEPpc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731373AbgKEPpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:31 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18553C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:30 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k9so1546952qki.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aNDjdxE7G+9BDv1OZ/753M75ofpHfMCEu17Uw/ofHDQ=;
        b=odvpIbZSB4dtPhBlX8ZoxaxP2DW472S6D0T2s/bVKtbH9ZEdKKdrHTu+GEZbv6eu3Z
         qMs3BcAj4uXSDOhcq8A6In+mBs7jfnoQoitMDnMqQqSWlMFMHSrM2r+tMgs3bhy56oIg
         MbzvnUXtcOeCaHNKxjgQTAA99F60n05LdK4KsVUInCyMf9q/Z7o3bkGVQLE2RoGAkRoH
         i52MRkxSSfY1I6/0YsuBq7yqVbtqnv6k1TBnTOL1z0l+L2wATWkdwzhge7zZzD1W2gh4
         yBSNeNx1OpJ2r1AyqpQGqx5tuHeKdlVTOphyYDLnxJVVUmFPOGbiuWKoM2TthkIj8s0t
         slZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNDjdxE7G+9BDv1OZ/753M75ofpHfMCEu17Uw/ofHDQ=;
        b=hxYYZA2nLHr3btqDwU0EAegzP75WcFAVjF/HN+sLjy4w7rnjUm+YiKa9asFkc1k5iP
         nTVBoXY6xdYClZzZV7ydxcAJ0sKvQMlwHvCOg6bc86OzhnXvBeNIt2uok3q66B+vgT5S
         VVYtSTZRCVWNa97dmmTyox7Di7eWYuvxhrUzm1nVKwA/CWQOZ3I5MsOpEDNPMCdfGzm/
         ec7+hEL2w0wAXmdGr2VteRT/C2tO4AYRMtaVVXXrhfApyf2IBcGVbM782vnEYJjcvMqQ
         7CI99BbAU1WAGjZIAzQPrFmsf+e6H+YrlaVNC2Vrde/0H20PW3ouzhXyGRAaDZwOz7Mb
         EL2A==
X-Gm-Message-State: AOAM530dYsT+YsiHQ8NEBRkQUe3kr/IIiMuSqKzE0Vc7Xb1I0JTSpeGw
        lnxrA86zzGnPotKsn7hSEJVONS/4/WX1L1TC
X-Google-Smtp-Source: ABdhPJz3EviKAQI6V84s6t1ScUGs5Z0CoCH5f3YlYgmGQSfxJB1hbUzLgAG2xgR8yGAioD7pbnHVCw==
X-Received: by 2002:a37:a68b:: with SMTP id p133mr2468506qke.272.1604591128980;
        Thu, 05 Nov 2020 07:45:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h82sm1214805qke.109.2020.11.05.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/14] btrfs: use btrfs_read_node_slot in btrfs_realloc_node
Date:   Thu,  5 Nov 2020 10:45:10 -0500
Message-Id: <3a6461bd56f7f175fe4050b0c78747bf065242c4.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this giant open-coded nightmare in btrfs_realloc_node that does
the same thing that the normal read path does, which is to see if we
have the eb in memory already, and if not read it, and verify the eb is
uptodate.  Delete this open coding and simply use btrfs_read_node_slot.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0ff866328a4f..5ec778e01222 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1570,7 +1570,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *cur;
 	u64 blocknr;
-	u64 gen;
 	u64 search_start = *last_ret;
 	u64 last_block = 0;
 	u64 other;
@@ -1579,7 +1578,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int i;
 	int err = 0;
 	int parent_level;
-	int uptodate;
 	u32 blocksize;
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
@@ -1597,7 +1595,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 		return 0;
 
 	for (i = start_slot; i <= end_slot; i++) {
-		struct btrfs_key first_key;
 		int close = 1;
 
 		btrfs_node_key(parent, &disk_key, i);
@@ -1606,8 +1603,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 
 		progress_passed = 1;
 		blocknr = btrfs_node_blockptr(parent, i);
-		gen = btrfs_node_ptr_generation(parent, i);
-		btrfs_node_key_to_cpu(parent, &first_key, i);
 		if (last_block == 0)
 			last_block = blocknr;
 
@@ -1624,31 +1619,9 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			continue;
 		}
 
-		cur = find_extent_buffer(fs_info, blocknr);
-		if (cur)
-			uptodate = btrfs_buffer_uptodate(cur, gen, 0);
-		else
-			uptodate = 0;
-		if (!cur || !uptodate) {
-			if (!cur) {
-				cur = read_tree_block(fs_info, blocknr, gen,
-						      parent_level - 1,
-						      &first_key);
-				if (IS_ERR(cur)) {
-					return PTR_ERR(cur);
-				} else if (!extent_buffer_uptodate(cur)) {
-					free_extent_buffer(cur);
-					return -EIO;
-				}
-			} else if (!uptodate) {
-				err = btrfs_read_buffer(cur, gen,
-						parent_level - 1,&first_key);
-				if (err) {
-					free_extent_buffer(cur);
-					return err;
-				}
-			}
-		}
+		cur = btrfs_read_node_slot(parent, i);
+		if (IS_ERR(cur))
+			return PTR_ERR(cur);
 		if (search_start == 0)
 			search_start = last_block;
 
-- 
2.26.2

