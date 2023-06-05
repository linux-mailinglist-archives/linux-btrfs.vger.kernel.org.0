Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E466721B3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 02:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjFEA37 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jun 2023 20:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjFEA36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jun 2023 20:29:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7681A7
        for <linux-btrfs@vger.kernel.org>; Sun,  4 Jun 2023 17:29:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D68DE21B00
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685924978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V110KFHBXghRG6mRtLTBytTEZ0wJewWijF1GyYUlar8=;
        b=LPoOU7bZxIQS45ZdDyWSyvqU3I4P9PpGEVzi8w4L6hS+m4ySncMRh0aSCQ4fhwZAFnzanR
        Ww21HoEQWteqawcaYa7q9SgKn+dkomAzrekgQQxNp5cOMABSi7w4tOHnuMFZTsUrxHakEm
        UHl0LilSw5u87ZSEOdINRJTzTO6svOU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A4B413519
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 00:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9fwiB3IsfWQjdwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 00:29:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: scrub: unify the output numbers for "Total to scrub"
Date:   Mon,  5 Jun 2023 08:29:21 +0800
Message-Id: <2e1ee8fb0a05dbb2f6a4327d5b1383c3f7635dea.1685924954.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
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

[BUG]
Command `btrfs scrub start -B` and `btrfs scrub status` are reporting
very different results for "Total to scrub":

  $ sudo btrfs scrub start -B /mnt/btrfs/
  scrub done for c107ef62-0a5d-4fd7-a119-b88f38b8e084
  Scrub started:    Mon Jun  5 07:54:07 2023
  Status:           finished
  Duration:         0:00:00
  Total to scrub:   1.52GiB
  Rate:             0.00B/s
  Error summary:    no errors found

  $ sudo btrfs scrub status /mnt/btrfs/
  UUID:             c107ef62-0a5d-4fd7-a119-b88f38b8e084
  Scrub started:    Mon Jun  5 07:54:07 2023
  Status:           finished
  Duration:         0:00:00
  Total to scrub:   12.00MiB
  Rate:             0.00B/s
  Error summary:    no errors found

This can be very confusing for end users.

[CAUSE]
It's the function print_fs_stat() handling the "Total to scrub" output.

For `btrfs scrub start` command, we use the used bytes (aka, the total
used dev exntents of a device) for output.

This is not really accurate, as the chunks may be mostly empty just like
the following:

  $ sudo btrfs fi df /mnt/btrfs/
  Data, single: total=1.01GiB, used=9.06MiB
  System, DUP: total=40.00MiB, used=64.00KiB
  Metadata, DUP: total=256.00MiB, used=1.38MiB
  GlobalReserve, single: total=22.00MiB, used=0.00B

Thus we're reporting 1.5GiB to scrub (1.01GiB + 40MiB * 2 + 256MiB * 2).
But in reality, we only scrubbed 12MiB
(9.06MiB + 64KiB * 2 + 1.38MiB * 2).

[FIX]
Instead of using the used dev-extent bytes of a device, go with proper
scrubbed bytes for each device.

This involves print_fs_stat() and print_scrub_dev() called inside
scrub_start().

Now the output should match each other.

Issue: #636
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/scrub.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 96e3bb5cfd65..2af4e429d9b0 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -326,7 +326,8 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 		if (raw)
 			print_scrub_full(p);
 		else
-			print_scrub_summary(p, ss, di->bytes_used);
+			print_scrub_summary(p, ss, p->data_bytes_scrubbed +
+						   p->tree_bytes_scrubbed);
 	}
 }
 
@@ -1540,28 +1541,32 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 
 	if (do_print) {
 		const char *append = "done";
-		u64 total_bytes_used = 0;
+		u64 total_bytes_scrubbed = 0;
 
 		if (!do_stats_per_dev)
 			init_fs_stat(&fs_stat);
 		for (i = 0; i < fi_args.num_devices; ++i) {
+			struct btrfs_scrub_progress *cur_progress =
+						&sp[i].scrub_args.progress;
+
 			if (do_stats_per_dev) {
 				print_scrub_dev(&di_args[i],
-						&sp[i].scrub_args.progress,
+						cur_progress,
 						print_raw,
 						sp[i].ret ? "canceled" : "done",
 						&sp[i].stats);
 			} else {
 				if (sp[i].ret)
 					append = "canceled";
-				add_to_fs_stat(&sp[i].scrub_args.progress,
-						&sp[i].stats, &fs_stat);
+				add_to_fs_stat(cur_progress, &sp[i].stats,
+						&fs_stat);
 			}
-			total_bytes_used += di_args[i].bytes_used;
+			total_bytes_scrubbed += cur_progress->data_bytes_scrubbed +
+						cur_progress->tree_bytes_scrubbed;
 		}
 		if (!do_stats_per_dev) {
 			pr_verbose(LOG_DEFAULT, "scrub %s for %s\n", append, fsid);
-			print_fs_stat(&fs_stat, print_raw, total_bytes_used);
+			print_fs_stat(&fs_stat, print_raw, total_bytes_scrubbed);
 		}
 	}
 
-- 
2.40.1

