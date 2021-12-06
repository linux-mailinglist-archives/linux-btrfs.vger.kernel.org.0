Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4B468F29
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhLFCdj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhLFCdj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83D272190C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWbllxqA0p40YAuwzUYnjHSoOkwp7My1ysAjiCYQxWs=;
        b=H2amgclrzfZmFYgy+dIWvNx8+Mixsm84s+1Qbmv9ckoMsJJzXNgV1J1c27YiDgJtx5o/id
        5nMzrTHqyN2mVdvN4vjVIrpE/2Eyp9l1FfAArvLzJKXxmnRlIZdZ94L4C2KVyrL0ua3C3G
        7FJ5iMZ6M7W80OltinIN94PulOZ4WNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1A8913451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AGUJrF1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/17] btrfs: make dec_and_test_compressed_bio() to be split bio compatible
Date:   Mon,  6 Dec 2021 10:29:31 +0800
Message-Id: <20211206022937.26465-12-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For compression read write endio functions, they all rely on
dec_and_test_compressed_bio() to determine if they are the last bio.

So here we only need to convert the bio_for_each_segment_all() call into
__bio_for_each_segment() so that compression read/write endio functions
will handle both split and unsplit bios well.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8668c5190805..8b4b84b59b0c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -205,18 +205,14 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 static bool dec_and_test_compressed_bio(struct compressed_bio *cb, struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
+	struct bio_vec bvec;
+	struct bvec_iter iter;
 	unsigned int bi_size = 0;
 	bool last_io = false;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
 
-	/*
-	 * At endio time, bi_iter.bi_size doesn't represent the real bio size.
-	 * Thus here we have to iterate through all segments to grab correct
-	 * bio size.
-	 */
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		bi_size += bvec->bv_len;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter)
+		bi_size += bvec.bv_len;
 
 	if (bio->bi_status)
 		cb->errors = 1;
-- 
2.34.1

