Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83D3D87A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhG1GFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:05:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35660 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhG1GFM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:05:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEB141FF4A
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627452308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wlKoDi9IyaVDNSd/xoY9C9hhvOmh+NothoEXw2ZNDWY=;
        b=uY3bgvdyFj4cHTem2nx4hEuioJMm5bGW3aZV4DKvjpXhZk1WIq2QNKZY/7s2y/xDO1OouX
        11c7WP/0pSTjywns5b5gZRSibhgcbxzCxT1VOXWfm+jcR1LHToMUimaFvDc6xk0ecOvJ6Y
        kufouqOZBGLxXennM/QA/QXDfGy+UBQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 19AEF13D29
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /1g8MpPzAGFKXgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:05:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the dead comment in writepage_delalloc()
Date:   Wed, 28 Jul 2021 14:05:05 +0800
Message-Id: <20210728060505.105119-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs_run_delalloc_range() failed, we will error out.

But there is a strange comment mentioning that
btrfs_run_delalloc_range() could have return value >0 to indicate the IO
has already started.

Commit 40f765805f08 ("Btrfs: split up __extent_writepage to lower stack
usage") introduced the comment, but unfortunately at that time, we are
already using @page_started to indicate that case, and still return 0.

Furthermore, even if that comment is right (which is not), we would
return -EIO if the IO is already started.

By all means the comment is incorrect, just remove the comment along
with the dead check.

Just to be extra safe, add an ASSERT() in btrfs_run_delalloc_range() to
make sure we either return 0 or error, no positive return value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 +-------
 fs/btrfs/inode.c     | 1 +
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f6723a7aab37..da9aca720047 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3824,13 +3824,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		if (ret) {
 			btrfs_page_set_error(inode->root->fs_info, page,
 					     page_offset(page), PAGE_SIZE);
-			/*
-			 * btrfs_run_delalloc_range should return < 0 for error
-			 * but just in case, we use > 0 here meaning the IO is
-			 * started, so we don't want to return > 0 unless
-			 * things are going well.
-			 */
-			return ret < 0 ? ret : -EIO;
+			return ret;
 		}
 		/*
 		 * delalloc_end is already one less than the total length, so
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4c758ec8b8fd..becdd5fb330c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2019,6 +2019,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
 					   page_started, nr_written);
 	}
+	ASSERT(ret <= 0);
 	if (ret)
 		btrfs_cleanup_ordered_extents(inode, locked_page, start,
 					      end - start + 1);
-- 
2.32.0

