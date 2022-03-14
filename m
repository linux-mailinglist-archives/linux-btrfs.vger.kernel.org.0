Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F854D7E27
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiCNJJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiCNJJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603FC13F27
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DCFEB1F391
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysFRSTgZeunQpGJMJMLzn47VZyt2wqZCBvF0o1re9S4=;
        b=PUyb6l27UsWXTKjE2zg8wsYJJG0VeLZdyg95Y9Koo8pBWP1ohXB64HHxJwrHl5LcX/BJSh
        zCrU/Kj6ZVB2/cQfZmNsqeozxNtnSiLHm38CSfrZVZM+AMF8BXAVM8mYARjJNABBxs6NNF
        erD39z+IIFjjVlzuweC2BpjV6PZdQVQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ADB813ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cMzBAfEFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 11/18] btrfs: make dec_and_test_compressed_bio() to be split bio compatible
Date:   Mon, 14 Mar 2022 17:07:24 +0800
Message-Id: <7e820b1356ac76ae3acb0de31bbdb2dd065142ae.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 5c9b28f2f034..e9b0887c03a9 100644
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
 		cb->status = bio->bi_status;
-- 
2.35.1

