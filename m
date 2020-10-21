Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85829484F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440840AbgJUG1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:44512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvPHj1HR6QDL6G35iS2CD16teJ9ajGyv+jbBB1iGOKA=;
        b=IK3OzQMELEzCkRrK1iTdnMV+wyDkODwedjVYbULMr/ogCcQ9FwwsO7YNp2ry3B9g2gkly+
        4YS/vAXuxcuWSyh6WSRqptW9Nfe/OduRjrpE/UX7UjL3HbxMfGxdFLmSfcMc6p3iNcfjEb
        lpceQKCU/1pABnx7w0OJ744Fvop0duY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 519A9AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 51/68] btrfs: extent_io: introduce submit_btree_subpage() to submit a page for subpage metadata write
Date:   Wed, 21 Oct 2020 14:25:37 +0800
Message-Id: <20201021062554.68132-52-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, submit_btree_subpage(), will submit all the dirty extent
buffers in the page.

The major difference between submit_btree_page() is:
- Page locking sequence
  Now we lock page first then lock extent buffers, thus we don't need to
  unlock the page just after writting one extent buffer.
  The page get unlocked after we have submitted all extent buffers.

- Bio submission
  Since one extent buffer is ensured to be contained into one page, we
  call submit_extent_page() directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d07972f94c40..3a2bb2656067 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4324,6 +4324,67 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	return ret;
 }
 
+/*
+ * A helper to submit one subpage btree page.
+ *
+ * The main difference between submit_btree_page() is:
+ * - Page locking sequence
+ *   Page are locked first, then lock extent buffers
+ *
+ * - Flush write bio
+ *   We only flush bio if we may be unable to fit current extent buffers into
+ *   current bio.
+ *
+ * Return >=0 for the number of submitted extent buffers.
+ * Return <0 for fatal error.
+ */
+static int submit_btree_subpage(struct page *page,
+				struct writeback_control *wbc,
+				struct extent_page_data *epd)
+{
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	int submitted = 0;
+	u64 page_start = page_offset(page);
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 cur = page_start;
+	int ret;
+
+	/* Lock and write each extent buffers in the range */
+	while (cur <= page_end) {
+		struct extent_buffer *eb;
+
+		ret = btrfs_find_first_subpage_eb(fs_info, &eb, cur, page_end,
+						  EXTENT_DIRTY);
+		if (ret > 0)
+			break;
+		ret = atomic_inc_not_zero(&eb->refs);
+		if (!ret)
+			continue;
+
+		cur = eb->start + eb->len;
+		ret = lock_extent_buffer_for_io(eb, epd);
+		if (ret == 0) {
+			free_extent_buffer(eb);
+			continue;
+		}
+		if (ret < 0) {
+			free_extent_buffer(eb);
+			goto cleanup;
+		}
+		ret = write_one_eb(eb, wbc, epd);
+		free_extent_buffer(eb);
+		if (ret < 0)
+			goto cleanup;
+		submitted++;
+	}
+	return submitted;
+
+cleanup:
+	/* We hit error, end bio for the submitted extent buffers */
+	end_write_bio(epd, ret);
+	return ret;
+}
+
 /*
  * A helper to submit a btree page.
  *
@@ -4349,6 +4410,9 @@ static int submit_btree_page(struct page *page, struct writeback_control *wbc,
 	if (!PagePrivate(page))
 		return 0;
 
+	if (btrfs_is_subpage(page_to_fs_info(page)))
+		return submit_btree_subpage(page, wbc, epd);
+
 	spin_lock(&mapping->private_lock);
 	if (!PagePrivate(page)) {
 		spin_unlock(&mapping->private_lock);
-- 
2.28.0

