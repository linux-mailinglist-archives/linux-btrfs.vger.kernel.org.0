Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613E3A58BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhFMNmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34508 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4398921972;
        Sun, 13 Jun 2021 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9iQJIqAvP3oBb21ZwYbBOg6Zz8z0z73yHx102nYx7c=;
        b=jLcJcjEEZoo9WE6/hGBR4tCmvRVXFEiSoUrzlthLxWSKjLKQ9D8jVyNGmQMGLVl24gVj/K
        liUB+Z9G9/Bc4lmbyNL0EIwMfTe69tGfBMw3J1AOImlGf+OhtZYmHMmLwHbeT0WUt7URpl
        fNn+vr+2fz0wp3rZdOQeTyzuwX1faNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9iQJIqAvP3oBb21ZwYbBOg6Zz8z0z73yHx102nYx7c=;
        b=3KS8/47n58RZNbPKnwzwQXWKjv8UYga9mSknb0vl3LUO9WAxXo2NB3zRN5IRxNfv4iunew
        5O69l/qrtFwxaMBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CEB1D118DD;
        Sun, 13 Jun 2021 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9iQJIqAvP3oBb21ZwYbBOg6Zz8z0z73yHx102nYx7c=;
        b=jLcJcjEEZoo9WE6/hGBR4tCmvRVXFEiSoUrzlthLxWSKjLKQ9D8jVyNGmQMGLVl24gVj/K
        liUB+Z9G9/Bc4lmbyNL0EIwMfTe69tGfBMw3J1AOImlGf+OhtZYmHMmLwHbeT0WUt7URpl
        fNn+vr+2fz0wp3rZdOQeTyzuwX1faNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9iQJIqAvP3oBb21ZwYbBOg6Zz8z0z73yHx102nYx7c=;
        b=3KS8/47n58RZNbPKnwzwQXWKjv8UYga9mSknb0vl3LUO9WAxXo2NB3zRN5IRxNfv4iunew
        5O69l/qrtFwxaMBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id a+pdKsAKxmA3JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:16 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 03/31] iomap: Export iomap_writepage_end_bio()
Date:   Sun, 13 Jun 2021 08:39:31 -0500
Message-Id: <5c4a9997996d39e80e647278a546c28e0ce124ed.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

BTRFS marks ordered extents as uptodate clearing bits such as delalloc
after the bio is deemed complete. After marking the extents, btrfs needs
to call iomap_writepage_end_bio() to perform housekeeping on the pages:
end of writeback.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 3 ++-
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b6fd6d6118a6..f88f058cdefb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1173,12 +1173,13 @@ iomap_sort_ioends(struct list_head *ioend_list)
 }
 EXPORT_SYMBOL_GPL(iomap_sort_ioends);
 
-static void iomap_writepage_end_bio(struct bio *bio)
+void iomap_writepage_end_bio(struct bio *bio)
 {
 	struct iomap_ioend *ioend = bio->bi_private;
 
 	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
 }
+EXPORT_SYMBOL_GPL(iomap_writepage_end_bio);
 
 /*
  * Submit the final bio for an ioend.
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 689d799b1915..8944711aa92e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -238,6 +238,7 @@ struct iomap_writepage_ctx {
 };
 
 void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
+void iomap_writepage_end_bio(struct bio *bio);
 void iomap_ioend_try_merge(struct iomap_ioend *ioend,
 		struct list_head *more_ioends);
 void iomap_sort_ioends(struct list_head *ioend_list);
-- 
2.31.1

