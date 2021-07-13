Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A373C6A47
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhGMGSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59700 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhGMGSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 04A0D20057
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17i8PvG6PWBC829RAxQOTfVtU0XJvWRUBXfGa+CU6IE=;
        b=YRf8idEOblF6Q0BTtVd24MmpXwcih+hKQMrfww37rdNykAdC/y+Y/pOd4Fj/MLEXnt/yYj
        rfAo8CscjhmjHSeeHkDlsXPjFO9yqKTvmSIbS7b9gjD1H9FsXCt3JfQoN2Qfq0/UC/YqMg
        48PTuI4lP5lAkcDo4J9S398VOYRAhpU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4362D139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ePwaAnsv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/27] btrfs: use async_chunk::async_cow to replace the confusing pending pointer
Date:   Tue, 13 Jul 2021 14:14:52 +0800
Message-Id: <20210713061516.163318-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For structure async_chunk, we use a very strange member layout to grab
structure async_cow who owns this async_chunk.

At initialization, it goes like this:

		async_chunk[i].pending = &ctx->num_chunks;

Then at async_cow_free() we do a super weird freeing:

	/*
	 * Since the pointer to 'pending' is at the beginning of the array of
	 * async_chunk's, freeing it ensures the whole array has been freed.
	 */
	if (atomic_dec_and_test(async_chunk->pending))
		kvfree(async_chunk->pending);

This is absolutely an abuse of kvfree().

Replace async_chunk::pending with async_chunk::async_cow, so that we can
grab the async_cow structure directly, without this strange dancing.

And with this change, there is no requirement for any specific member
location.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c8f4d1f8cc82..e5703160718c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -454,11 +454,10 @@ struct async_chunk {
 	struct list_head extents;
 	struct cgroup_subsys_state *blkcg_css;
 	struct btrfs_work work;
-	atomic_t *pending;
+	struct async_cow *async_cow;
 };
 
 struct async_cow {
-	/* Number of chunks in flight; must be first in the structure */
 	atomic_t num_chunks;
 	struct async_chunk chunks[];
 };
@@ -1324,18 +1323,17 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 static noinline void async_cow_free(struct btrfs_work *work)
 {
 	struct async_chunk *async_chunk;
+	struct async_cow *async_cow;
 
 	async_chunk = container_of(work, struct async_chunk, work);
 	if (async_chunk->inode)
 		btrfs_add_delayed_iput(async_chunk->inode);
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
-	/*
-	 * Since the pointer to 'pending' is at the beginning of the array of
-	 * async_chunk's, freeing it ensures the whole array has been freed.
-	 */
-	if (atomic_dec_and_test(async_chunk->pending))
-		kvfree(async_chunk->pending);
+
+	async_cow = async_chunk->async_cow;
+	if (atomic_dec_and_test(&async_cow->num_chunks))
+		kvfree(async_cow);
 }
 
 static int cow_file_range_async(struct btrfs_inode *inode,
@@ -1396,7 +1394,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		 * lightweight reference for the callback lifetime
 		 */
 		ihold(&inode->vfs_inode);
-		async_chunk[i].pending = &ctx->num_chunks;
+		async_chunk[i].async_cow = ctx;
 		async_chunk[i].inode = &inode->vfs_inode;
 		async_chunk[i].start = start;
 		async_chunk[i].end = cur_end;
-- 
2.32.0

