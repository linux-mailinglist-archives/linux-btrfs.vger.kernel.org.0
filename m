Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198E93A58D9
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFMNnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:23 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 422F91FD32;
        Sun, 13 Jun 2021 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3SwlmhUCiFoc8JrUC/yOudxgsveSdq0yYwhSQ7MXDc=;
        b=IcK0C74f96KZTpPCFFTt35Q5U13Yxwf8Fzaac7y+4xzLMtMNpkm9GAKicp9FQnrRXoALit
        4oHYgrKSrIQZyzne5x2thb6g1vYBYXE7AIGpIU0szT50hJdT4ytgX5g4zg4gvSmGP+yRQo
        rMvXZgfAlk9oCJLcb1Um+btljpkkV9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3SwlmhUCiFoc8JrUC/yOudxgsveSdq0yYwhSQ7MXDc=;
        b=GFb34SC2Y52nq6uZjYixYClnYUvia0pj1S0wwSC/KIIX+09LTM4bUGp994EB26/jHCZU+d
        jkKnwoFjLTwI5YCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C16A0118DD;
        Sun, 13 Jun 2021 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3SwlmhUCiFoc8JrUC/yOudxgsveSdq0yYwhSQ7MXDc=;
        b=IcK0C74f96KZTpPCFFTt35Q5U13Yxwf8Fzaac7y+4xzLMtMNpkm9GAKicp9FQnrRXoALit
        4oHYgrKSrIQZyzne5x2thb6g1vYBYXE7AIGpIU0szT50hJdT4ytgX5g4zg4gvSmGP+yRQo
        rMvXZgfAlk9oCJLcb1Um+btljpkkV9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e3SwlmhUCiFoc8JrUC/yOudxgsveSdq0yYwhSQ7MXDc=;
        b=GFb34SC2Y52nq6uZjYixYClnYUvia0pj1S0wwSC/KIIX+09LTM4bUGp994EB26/jHCZU+d
        jkKnwoFjLTwI5YCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id afa+HQALxmC1JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:20 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 30/31] btrfs: Do not call btrfs_io_bio_free_csum() if BTRFS_INODE_NODATASUM is not set
Date:   Sun, 13 Jun 2021 08:39:58 -0500
Message-Id: <2a2dc9b5feedd92839f1f835f02235b2539bbcfd.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Q: Not sure why this patch is required. But there are cases when I received
a would fail at kfree(io_bio->csum). io_bio->csum_inline would be set
to some random value. What would cause this?

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 88a8fbf467b0..a9e8217c0935 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3013,6 +3013,7 @@ void btrfs_readpage_endio(struct bio *bio)
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
+	struct inode *inode;
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
@@ -3026,14 +3027,16 @@ void btrfs_readpage_endio(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
-		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		const u32 sectorsize = fs_info->sectorsize;
+		struct btrfs_fs_info *fs_info;
+		u32 sectorsize;
 		unsigned int error_bitmap = (unsigned int)-1;
 		u64 start;
 		u64 end;
 		u32 len;
 
+		inode = page->mapping->host;
+		fs_info = btrfs_sb(inode->i_sb);
+		sectorsize = fs_info->sectorsize;
 		btrfs_debug(fs_info,
 			"btrfs_readpage_endio: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
@@ -3140,7 +3143,8 @@ void btrfs_readpage_endio(struct bio *bio)
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-	btrfs_io_bio_free_csum(io_bio);
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM))
+		btrfs_io_bio_free_csum(io_bio);
 	bio_put(bio);
 }
 
-- 
2.31.1

