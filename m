Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9B3E24D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbhHFINK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41118 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbhHFINK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28F5120263
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHHkgjE68G0Zx/YORbwGdYKucdM8ZuJX+kLtttCTuXE=;
        b=g867m+GxJhbkSdbwxNlyhOsGMpUV9PUx6myorLmka6OBaFawCKDYizvRuJ2Od+sg8VF210
        i7q/NSaXY7vgvovo7LqaWwYAHvxGwnKmo4+McFE4YKlM70pydAoJQuH+r5VnjhiYf29Wqz
        ze5KNWg5fJZBxun2rMJCcPM/BAcgtSw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5EF1E1399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6Af5BwXvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 06/11] btrfs: defrag: introduce a helper to defrag a continuous prepared range
Date:   Fri,  6 Aug 2021 16:12:37 +0800
Message-Id: <20210806081242.257996-7-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new helper, defrag_one_locked_target(), introduced to do the real part
of defrag.

The caller needs to ensure both page and extents bits are locked, and no
ordered extent for the range, and all writeback is finished.

The core defrag part is pretty straight-forward:

- Reserve space
- Set extent bits to defrag
- Update involved pages to be dirty

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 043c44daa5ae..a21c4c09269a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -48,6 +48,7 @@
 #include "space-info.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "subpage.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
@@ -1547,6 +1548,61 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 	return ret;
 }
 
+#define CLUSTER_SIZE	(SZ_256K)
+
+/*
+ * Defrag one continuous target range.
+ *
+ * @inode:	Target inode
+ * @target:	Target range to defrag
+ * @pages:	Locked pages covering the defrag range
+ * @nr_pages:	Number of locked pages
+ *
+ * Caller should ensure:
+ *
+ * - Pages are prepared
+ *   Pages should be locked, no ordered extent in the pages range,
+ *   no writeback.
+ *
+ * - Extent bits are locked
+ */
+static int defrag_one_locked_target(struct btrfs_inode *inode,
+				    struct defrag_target_range *target,
+				    struct page **pages, int nr_pages,
+				    struct extent_state **cached_state)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_changeset *data_reserved = NULL;
+	const u64 start = target->start;
+	const u64 len = target->len;
+	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
+	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned long first_index = page_index(pages[0]);
+	int ret = 0;
+	int i;
+
+	ASSERT(last_index - first_index + 1 <= nr_pages);
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
+	if (ret < 0)
+		return ret;
+	clear_extent_bit(&inode->io_tree, start, start + len - 1,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			 EXTENT_DEFRAG, 0, 0, cached_state);
+	set_extent_defrag(&inode->io_tree, start, start + len - 1,
+			  cached_state);
+
+	/* Update the page status */
+	for (i = start_index - first_index; i <= last_index - first_index;
+	     i++) {
+		ClearPageChecked(pages[i]);
+		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+	}
+	btrfs_delalloc_release_extents(inode, len);
+	extent_changeset_free(data_reserved);
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.32.0

