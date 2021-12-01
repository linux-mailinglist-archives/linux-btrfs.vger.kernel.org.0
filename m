Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A133D464663
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346716AbhLAFVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbhLAFVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 909DF212BA;
        Wed,  1 Dec 2021 05:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3+CDf5Cu2CsN2hVI61SSdp7uQFj+vAjRoqJFHdCsOI=;
        b=Na4uAiEc7Pkhm15oYDK9ms+6ALpluDfv5gBYcxEMh9+58WrjH/41yY14JU0o5f/5my4ZyW
        KRWpgXe/P37B/hjd5eq4je75K/K12+FNTg1+wfEbLL/5oBqCD9beUZbiY8wmfmtOVnvcFp
        LIf7nllL7uBIx0hI2KgUkQcjXMyQGZk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94D1913425;
        Wed,  1 Dec 2021 05:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mL3mGKMFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 10/17] btrfs: make metadata write endio functions to be split bio compatible
Date:   Wed,  1 Dec 2021 13:17:49 +0800
Message-Id: <20211201051756.53742-11-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Only need to convert the bio_for_each_segment_all() call into
__bio_for_each_segment() call and using btrfs_bio::iter as the initial
iterator.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 524a00ba0ca0..8f5a1059a296 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4495,20 +4495,20 @@ static struct extent_buffer *find_extent_buffer_nolock(
 static void end_bio_subpage_eb_writepage(struct bio *bio)
 {
 	struct btrfs_fs_info *fs_info;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 
 	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		u64 bvec_start = page_offset(page) + bvec->bv_offset;
-		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
+		u64 bvec_start = page_offset(page) + bvec.bv_offset;
+		u64 bvec_end = bvec_start + bvec.bv_len - 1;
 		u64 cur_bytenr = bvec_start;
 
-		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+		ASSERT(IS_ALIGNED(bvec.bv_len, fs_info->nodesize));
 
 		/* Iterate through all extent buffers in the range */
 		while (cur_bytenr <= bvec_end) {
@@ -4551,14 +4551,14 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
-	struct bio_vec *bvec;
 	struct extent_buffer *eb;
+	struct bvec_iter iter;
+	struct bio_vec bvec;
 	int done;
-	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
+	ASSERT(btrfs_bio(bio)->iter.bi_size);
+	__bio_for_each_segment(bvec, bio, iter, btrfs_bio(bio)->iter) {
+		struct page *page = bvec.bv_page;
 
 		eb = (struct extent_buffer *)page->private;
 		BUG_ON(!eb);
-- 
2.34.1

