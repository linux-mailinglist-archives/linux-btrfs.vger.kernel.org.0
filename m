Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF905F9CD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJJKgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiJJKge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 06:36:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1B357BE2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 03:36:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFE4C1F8D6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665398191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUlxSLm+UVCp2Uwn8y8I1ku4Gnt7kLLRHrlml2HpfOA=;
        b=rghqiVxEv0EXmlKEkGg4PyIDMDRPOxKe4RtqNOVhDwRDz3p7SQbAZ6etSzCJeWvxp0jCVz
        S0FP4aPX5eTvo85BGEYEOyqwTUHS+3CDT7EHNQqEHzrp9T3PnUF2LYE8NJxRX9vXwmjMAu
        Zvum/CS9IVvKVz10ieb1FAmmE+5bb1U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D2AC13ACA
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +JLmOK71Q2M9LgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 10:36:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: raid56: cleanup for function __free_raid_bio()
Date:   Mon, 10 Oct 2022 18:36:08 +0800
Message-Id: <beb87d7493ac4900387cbffc9a5df75ab04ba9a5.1665397731.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665397731.git.wqu@suse.com>
References: <cover.1665397731.git.wqu@suse.com>
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

The cleanup involves two things:

- Remove the "__" prefix
  There is no naming confliction.

- Remove the forward declaration
  There is no special function call involved.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 61 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 82c8e991300e..371b2a182544 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -69,7 +69,6 @@ static void rmw_work(struct work_struct *work);
 static void read_rebuild_work(struct work_struct *work);
 static int fail_bio_stripe(struct btrfs_raid_bio *rbio, struct bio *bio);
 static int fail_rbio_index(struct btrfs_raid_bio *rbio, int failed);
-static void __free_raid_bio(struct btrfs_raid_bio *rbio);
 static void index_rbio_pages(struct btrfs_raid_bio *rbio);
 static int alloc_rbio_pages(struct btrfs_raid_bio *rbio);
 
@@ -77,6 +76,28 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 					 int need_check);
 static void scrub_parity_work(struct work_struct *work);
 
+static void free_raid_bio(struct btrfs_raid_bio *rbio)
+{
+	int i;
+
+	if (!refcount_dec_and_test(&rbio->refs))
+		return;
+
+	WARN_ON(!list_empty(&rbio->stripe_cache));
+	WARN_ON(!list_empty(&rbio->hash_list));
+	WARN_ON(!bio_list_empty(&rbio->bio_list));
+
+	for (i = 0; i < rbio->nr_pages; i++) {
+		if (rbio->stripe_pages[i]) {
+			__free_page(rbio->stripe_pages[i]);
+			rbio->stripe_pages[i] = NULL;
+		}
+	}
+
+	btrfs_put_bioc(rbio->bioc);
+	kfree(rbio);
+}
+
 static void start_async_work(struct btrfs_raid_bio *rbio, work_func_t work_func)
 {
 	INIT_WORK(&rbio->work, work_func);
@@ -336,7 +357,7 @@ static void __remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
 	spin_unlock(&h->lock);
 
 	if (freeit)
-		__free_raid_bio(rbio);
+		free_raid_bio(rbio);
 }
 
 /*
@@ -684,7 +705,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
 	if (cache_drop)
 		remove_rbio_from_cache(cache_drop);
 	if (freeit)
-		__free_raid_bio(freeit);
+		free_raid_bio(freeit);
 	return ret;
 }
 
@@ -769,28 +790,6 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
 		remove_rbio_from_cache(rbio);
 }
 
-static void __free_raid_bio(struct btrfs_raid_bio *rbio)
-{
-	int i;
-
-	if (!refcount_dec_and_test(&rbio->refs))
-		return;
-
-	WARN_ON(!list_empty(&rbio->stripe_cache));
-	WARN_ON(!list_empty(&rbio->hash_list));
-	WARN_ON(!bio_list_empty(&rbio->bio_list));
-
-	for (i = 0; i < rbio->nr_pages; i++) {
-		if (rbio->stripe_pages[i]) {
-			__free_page(rbio->stripe_pages[i]);
-			rbio->stripe_pages[i] = NULL;
-		}
-	}
-
-	btrfs_put_bioc(rbio->bioc);
-	kfree(rbio);
-}
-
 static void rbio_endio_bio_list(struct bio *cur, blk_status_t err)
 {
 	struct bio *next;
@@ -830,7 +829,7 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	 */
 	unlock_stripe(rbio);
 	extra = bio_list_get(&rbio->bio_list);
-	__free_raid_bio(rbio);
+	free_raid_bio(rbio);
 
 	rbio_endio_bio_list(cur, err);
 	if (extra)
@@ -1731,7 +1730,7 @@ static void run_plug(struct btrfs_plug_cb *plug)
 		if (last) {
 			if (rbio_can_merge(last, cur)) {
 				merge_rbio(last, cur);
-				__free_raid_bio(cur);
+				free_raid_bio(cur);
 				continue;
 
 			}
@@ -1822,7 +1821,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	if (rbio_is_full(rbio)) {
 		ret = full_stripe_write(rbio);
 		if (ret) {
-			__free_raid_bio(rbio);
+			free_raid_bio(rbio);
 			goto fail;
 		}
 		return;
@@ -1839,7 +1838,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	} else {
 		ret = __raid56_parity_write(rbio);
 		if (ret) {
-			__free_raid_bio(rbio);
+			free_raid_bio(rbio);
 			goto fail;
 		}
 	}
@@ -2214,7 +2213,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 "%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bioc has map_type %llu)",
 			   __func__, bio->bi_iter.bi_sector << 9,
 			   (u64)bio->bi_iter.bi_size, bioc->map_type);
-		__free_raid_bio(rbio);
+		free_raid_bio(rbio);
 		bio->bi_status = BLK_STS_IOERR;
 		goto out_end_bio;
 	}
@@ -2747,7 +2746,7 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 		btrfs_warn_rl(fs_info,
 	"can not determine the failed stripe number for full stripe %llu",
 			      bioc->raid_map[0]);
-		__free_raid_bio(rbio);
+		free_raid_bio(rbio);
 		return NULL;
 	}
 
-- 
2.37.3

