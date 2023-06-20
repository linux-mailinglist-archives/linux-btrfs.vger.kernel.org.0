Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860637363FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjFTHG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 03:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFTHG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 03:06:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B63CC
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 00:06:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84488218B2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687244783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7MCAVmSP7pCPal4FxFfiruKtmppTrNTYQwzcyQOup1A=;
        b=d5uuRAaFXLznKiQCutlzjmZOjnYWuf/VFdLmkrRqgXdvjGnFkSzVsbGn7UrWz1ql/aziwd
        /WgjBsYOTQSAwUHs7El/Z+Z3j23YPfVbykcnSVRtn8iNuzFRFzFBDL4+Ll3d0Gb8fGVhgk
        Y/9SrxbkP9C3ah68bxvkoOZECl2yEnA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D62DB133A9
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 07:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HwRzJ+5PkWT/cAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 07:06:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: simplify the trace events
Date:   Tue, 20 Jun 2023 15:06:05 +0800
Message-ID: <e4b532ed0249d996d86446f41fe7f6bce46462d6.1687244580.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After commit 6bfd0133bee2 ("btrfs: raid56: switch scrub path to use a
single function"), the raid56 implementation no longer uses different
endio functions for rmw/recover/scrub.

All read operations end in submit_read_wait_bio_list(), while all write
operations end in submit_write_bios().

This means quite some trace events are out-of-date and no longer
utilized.

This patch would unify the trace events into just two:

- trace_raid56_read()
  Replaces trace_raid56_read_partial(), trace_raid56_scrub_read() and
  trace_raid56_scrub_read_recover().

- trace_raid56_write()
  Replaces trace_raid56_write_stripe() and
  trace_raid56_scrub_write_stripe().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c            |  8 ++++----
 include/trace/events/btrfs.h | 29 ++---------------------------
 2 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f37b925d587f..c805ee48427b 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1517,11 +1517,11 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
 	while ((bio = bio_list_pop(bio_list))) {
 		bio->bi_end_io = raid_wait_read_end_io;
 
-		if (trace_raid56_scrub_read_recover_enabled()) {
+		if (trace_raid56_read_enabled()) {
 			struct raid56_bio_trace_info trace_info = { 0 };
 
 			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_scrub_read_recover(rbio, bio, &trace_info);
+			trace_raid56_read(rbio, bio, &trace_info);
 		}
 		submit_bio(bio);
 	}
@@ -2198,11 +2198,11 @@ static void submit_write_bios(struct btrfs_raid_bio *rbio,
 	while ((bio = bio_list_pop(bio_list))) {
 		bio->bi_end_io = raid_wait_write_end_io;
 
-		if (trace_raid56_write_stripe_enabled()) {
+		if (trace_raid56_write_enabled()) {
 			struct raid56_bio_trace_info trace_info = { 0 };
 
 			bio_get_trace_info(rbio, bio, &trace_info);
-			trace_raid56_write_stripe(rbio, bio, &trace_info);
+			trace_raid56_write(rbio, bio, &trace_info);
 		}
 		submit_bio(bio);
 	}
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a8206f5332e9..a76a279c5f0f 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2482,7 +2482,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
 		__entry->offset, __entry->opf, __entry->physical, __entry->len)
 );
 
-DEFINE_EVENT(btrfs_raid56_bio, raid56_read_partial,
+DEFINE_EVENT(btrfs_raid56_bio, raid56_read,
 	TP_PROTO(const struct btrfs_raid_bio *rbio,
 		 const struct bio *bio,
 		 const struct raid56_bio_trace_info *trace_info),
@@ -2490,32 +2490,7 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_read_partial,
 	TP_ARGS(rbio, bio, trace_info)
 );
 
-DEFINE_EVENT(btrfs_raid56_bio, raid56_write_stripe,
-	TP_PROTO(const struct btrfs_raid_bio *rbio,
-		 const struct bio *bio,
-		 const struct raid56_bio_trace_info *trace_info),
-
-	TP_ARGS(rbio, bio, trace_info)
-);
-
-
-DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_write_stripe,
-	TP_PROTO(const struct btrfs_raid_bio *rbio,
-		 const struct bio *bio,
-		 const struct raid56_bio_trace_info *trace_info),
-
-	TP_ARGS(rbio, bio, trace_info)
-);
-
-DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read,
-	TP_PROTO(const struct btrfs_raid_bio *rbio,
-		 const struct bio *bio,
-		 const struct raid56_bio_trace_info *trace_info),
-
-	TP_ARGS(rbio, bio, trace_info)
-);
-
-DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
+DEFINE_EVENT(btrfs_raid56_bio, raid56_write,
 	TP_PROTO(const struct btrfs_raid_bio *rbio,
 		 const struct bio *bio,
 		 const struct raid56_bio_trace_info *trace_info),
-- 
2.41.0

