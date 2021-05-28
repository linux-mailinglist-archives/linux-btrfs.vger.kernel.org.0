Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF3393B66
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 04:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhE1CaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 22:30:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:60774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236126AbhE1CaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 22:30:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622168913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFHcwxsCoFvolKvW6wDTsvJv1V8HtpaSC5f8JrCKot4=;
        b=CMjwA+HBon/XsmD76ymQI6XRoIbnWpCMLHY8XCl/8APmu9jt8fh0+Skzf26PUdFJXJHLXm
        CaAeE6Z283NTGlLE4U8eO5TWnR0e11ycWuOKNCWOs5Smdw2AsXq/HRji7W9KA/48shqwz6
        h0sqWYINFsu34lFBE04yjlh5DVjc0h4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B54F4ABD9
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:28:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: defrag: introduce a new helper to defrag one cluster
Date:   Fri, 28 May 2021 10:28:19 +0800
Message-Id: <20210528022821.81386-6-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528022821.81386-1-wqu@suse.com>
References: <20210528022821.81386-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new helper, defrag_one_cluster(), will defrag one cluster (at most
256K) by:

- Collect all targets
- Call defrag_one_target() on each target
  With some extra range clamping.
- Update @sectors_defraged parameter

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cd7650bcc70c..911db470aad6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1562,6 +1562,48 @@ static int defrag_one_target(struct btrfs_inode *inode,
 	return ret;
 }
 
+static int defrag_one_cluster(struct btrfs_inode *inode,
+			      struct file_ra_state *ra,
+			      u64 start, u32 len, u32 extent_thresh,
+			      u64 newer_than, bool do_compress,
+			      unsigned long *sectors_defraged,
+			      unsigned long max_sectors)
+{
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
+	int ret;
+
+	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, &target_list);
+	if (ret < 0)
+		goto out;
+
+	list_for_each_entry(entry, &target_list, list) {
+		u32 range_len = entry->len;
+
+		/* Reached the limit */
+		if (max_sectors && max_sectors == *sectors_defraged)
+			break;
+
+		if (max_sectors)
+			range_len = min_t(u32, range_len,
+				(max_sectors - *sectors_defraged) * sectorsize);
+		ret = defrag_one_target(inode, ra, entry->start, range_len);
+		if (ret < 0)
+			break;
+		*sectors_defraged += range_len;
+	}
+out:
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.31.1

