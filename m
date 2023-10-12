Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1417C643E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 06:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbjJLE4I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjJLE4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 00:56:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18990
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 21:55:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E63FD21875
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697086554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=78V4M+vxwN31J2vyaf36PFyZsWuPIToVcUsvSgK/Npk=;
        b=ROIqU3WBwwUPwHYNQ4BWQ2uPMbH72TclJM6i+LBDhq0XTV8LoKpYQB4OFsZOOgkqvufSNR
        W84n2g/XcgWCtcwad6Twz6hlOxXHGKh1ac7ZX/jr+tk+BklTV9dUfNEW7HlKXhD7vWjl4a
        AARbvAkYcaW2bFsiXjj953aJQfE6tjE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AF3A139ED
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K26ULFl8J2X8YwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 04:55:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmds/scrub: using device's used_bytes to print summary for running scrubs
Date:   Thu, 12 Oct 2023 15:25:35 +1030
Message-ID: <be6f1470add5193fcb435e7bbba875dc60a2a2ba.1697086519.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.72
X-Spamd-Result: default: False [0.72 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.18)[70.30%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For running scrubs, with v6.3 and newer btrfs-progs, it can report
incorrect "Total to scrub":

  Scrub resumed:    Mon Oct  9 11:28:33 2023
  Status:           running
  Duration:         0:44:36
  Time left:        0:00:00
  ETA:              Mon Oct  9 11:51:38 2023
  Total to scrub:   625.49GiB
  Bytes scrubbed:   625.49GiB  (100.00%)
  Rate:             239.35MiB/s
  Error summary:    no errors found

[CAUSE]
Commit c88ac0170b35 ("btrfs-progs: scrub: unify the output numbers for
"Total to scrub"") changed the output method for "Total to scrub", but
that value is only suitable for finished scrubs.

For running scrubs, if we use the currently scrubbed values, it would
lead to the above problem.

The real scrubbed bytes is only reliable for finished scrubs, not for
running/canceled/interrupted ones.

[FIX]
Change print_scrub_dev() to do extra checks, and only for finished
scrubs to use the scrubbed bytes.
Otherwise fall back to the device's bytes_used.

Issue: #690
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/scrub.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index c45ab3dd2a31..247e056ac70d 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -323,9 +323,22 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 	if (p) {
 		if (raw)
 			print_scrub_full(p);
-		else
+		else if (ss->finished)
+			/*
+			 * For finished scrub, we can use the total scrubbed
+			 * bytes to report "Total to scrub", which is more
+			 * accurate (e.g. mostly empty block groups).
+			 */
 			print_scrub_summary(p, ss, p->data_bytes_scrubbed +
 						   p->tree_bytes_scrubbed);
+		else
+			/*
+			 * For any canceled/interrupted/running scrub,
+			 * we're not sure how many bytes we're really
+			 * going to scrub, thus we use device's used
+			 * bytes instead.
+			 */
+			print_scrub_summary(p, ss, di->bytes_used);
 	}
 }
 
-- 
2.42.0

