Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71A4464666
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbhLAFVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbhLAFVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E34641FD2F;
        Wed,  1 Dec 2021 05:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWbllxqA0p40YAuwzUYnjHSoOkwp7My1ysAjiCYQxWs=;
        b=kLLxiaH5YXlp47M+bx0d4mfu6E6m2uRXyr2JAKHmaW6xNCC44cuwVB1xTmT5fyNA9UEZoK
        ZnYG+8AVX8Uy7hQBZKRVFMZDmfLN+aoFG+vF2Efdy+bOBc4k4pmC5oBSXNpH4rERACrW0X
        EEe4+vYwyDaUMXEFyCM3NpDZCeZ11ig=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8D0F13425;
        Wed,  1 Dec 2021 05:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJNvLaQFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 11/17] btrfs: make dec_and_test_compressed_bio() to be split bio compatible
Date:   Wed,  1 Dec 2021 13:17:50 +0800
Message-Id: <20211201051756.53742-12-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
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

