Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49D62A0EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKOSBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC4C6F
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AB3F1F8E9;
        Tue, 15 Nov 2022 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnbTSvjoJjWsQJbvP3aYbA704ygvLB72HpnbdDRNaTA=;
        b=0f27JIUbUIyB6cxl7vWiE28lsxoVu3za20b9igIQLX3FtfHoUUB++fSMbKrjGwOhDD59U/
        FvtpFfdKw1LtT47hFnNHIQ1NQmmiql6IGOhSMxYk1n2hakinw9bpJRdnm2baf7/mwL5+U6
        OjwZKPvNedWolCHks0I4Pp+hw0GZeTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnbTSvjoJjWsQJbvP3aYbA704ygvLB72HpnbdDRNaTA=;
        b=oX6B81YycHFADHMfX+OqBkg+6yFw2WxmyAjV9Qlv7n2jG0wCurhwR7aWCIesVmdohrbpeJ
        2pE1BIZ54pRpSlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5326813A91;
        Tue, 15 Nov 2022 18:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ekZMC9nTc2OrZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:57 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/16] btrfs: lock/unlock extents while creation/end of async_chunk
Date:   Tue, 15 Nov 2022 12:00:27 -0600
Message-Id: <bb12e8c269c6dd67496aa868cef2a7c4bc75d292.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

writepages() writebacks the unwritten pages the synchronously. So we
know that once writepages returns, the pages are "done" and can be
safely unlocked. However, with async writes, this is done over a thread.
So, for async writeback, perform this within the async thread.

Locking is performed at origin of async_chunk and unlocked when
async_chunk completes.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 92726831dd5d..aa393219019b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -528,6 +528,7 @@ struct async_chunk {
 	struct list_head extents;
 	struct cgroup_subsys_state *blkcg_css;
 	struct btrfs_work work;
+	struct extent_state *cached_state;
 	struct async_cow *async_cow;
 };
 
@@ -1491,6 +1492,9 @@ static noinline void async_cow_start(struct btrfs_work *work)
 
 	compressed_extents = compress_file_range(async_chunk);
 	if (compressed_extents == 0) {
+		unlock_extent(&async_chunk->inode->io_tree,
+				async_chunk->start, async_chunk->end,
+				&async_chunk->cached_state);
 		btrfs_add_delayed_iput(async_chunk->inode);
 		async_chunk->inode = NULL;
 	}
@@ -1530,11 +1534,16 @@ static noinline void async_cow_free(struct btrfs_work *work)
 	struct async_cow *async_cow;
 
 	async_chunk = container_of(work, struct async_chunk, work);
-	if (async_chunk->inode)
+	if (async_chunk->inode) {
+		unlock_extent(&async_chunk->inode->io_tree,
+				async_chunk->start, async_chunk->end,
+				&async_chunk->cached_state);
 		btrfs_add_delayed_iput(async_chunk->inode);
+	}
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
 
+
 	async_cow = async_chunk->async_cow;
 	if (atomic_dec_and_test(&async_cow->num_chunks))
 		kvfree(async_cow);
@@ -1558,7 +1567,6 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	unsigned nofs_flag;
 	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
 
-	unlock_extent(&inode->io_tree, start, end, NULL);
 
 	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
 	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
@@ -1600,6 +1608,9 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		ihold(&inode->vfs_inode);
 		async_chunk[i].async_cow = ctx;
 		async_chunk[i].inode = inode;
+		async_chunk[i].cached_state = NULL;
+		btrfs_lock_and_flush_ordered_range(inode, start, cur_end,
+				&async_chunk[i].cached_state);
 		async_chunk[i].start = start;
 		async_chunk[i].end = cur_end;
 		async_chunk[i].write_flags = write_flags;
@@ -8222,10 +8233,11 @@ static int btrfs_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
 	u64 start, end;
-	struct inode *inode = mapping->host;
+	struct btrfs_inode *inode = BTRFS_I(mapping->host);
 	struct extent_state *cached = NULL;
+	bool async_wb;
 	int ret;
-	u64 isize = round_up(i_size_read(inode), PAGE_SIZE) - 1;
+	u64 isize = round_up(i_size_read(&inode->vfs_inode), PAGE_SIZE) - 1;
 
 	if (wbc->range_cyclic) {
 		start = mapping->writeback_index << PAGE_SHIFT;
@@ -8239,9 +8251,18 @@ static int btrfs_writepages(struct address_space *mapping,
 	if (start >= end)
 		return 0;
 
-	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	/*
+	 * For async I/O, locking and unlocking is performed with the
+	 * allocation and completion of async_chunk.
+	 */
+	async_wb = btrfs_inode_can_compress(inode) &&
+		   inode_need_compress(inode, start, end);
+	if (!async_wb)
+		lock_extent(&inode->io_tree, start, end, &cached);
 	ret = extent_writepages(mapping, wbc);
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	if (!async_wb)
+		unlock_extent(&inode->io_tree, start, end, &cached);
+
 	return ret;
 }
 
-- 
2.35.3

