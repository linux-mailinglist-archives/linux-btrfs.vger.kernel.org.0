Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964465ABDCF
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiICIVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiICIVj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:21:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954ED5071C
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:21:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A2811F9F0
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QNtEqvuOnb6VDjhRZPY/DLdc0AuUjI5pUW97tLhEXM=;
        b=MH9Kkl7Nv+BGDIPQQSc9/92u7EOKY6mZR1E5HpUDHZmHneW0w6fMtRr43ONM3Pd5HZUgrR
        QDxCvy1gNcoMnpve4jqlVQ0P9iGazYsCZp+TLrImH4lw+RWRp9Qk/t1cXQrbSLmnXP4XXE
        B8mWJYrFtyilYsKxdNjDhwMWnCanvl4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F9B6139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cLaCGpAOE2NHawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:21:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH POC 2/2] btrfs-progs: scrub: add an experimental entrance for scrub_fs
Date:   Sat,  3 Sep 2022 16:21:15 +0800
Message-Id: <1741d641ff2c7320aa502a8cebcdb7ab20d4dbac.1662193185.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662193185.git.wqu@suse.com>
References: <cover.1662193185.git.wqu@suse.com>
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

The new entrance is really experimental and only provides very basic
functionality:

- Foreground only scrub
  It's always running in foreground for now.

- No support for scrub status file

- No simple report
  Only full scrub_fs_progress report.

- No cancel/progress report
  Not yet implemented in the kernel.

So it's really for evaluation on the new scrub_fs interface.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/scrub.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 7c2d9b79c275..1c1e8c71d451 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1139,6 +1139,75 @@ static int is_scrub_running_in_kernel(int fd,
 	return 0;
 }
 
+/*
+ * The entrance for the new scrub_fs experimental ioctl.
+ * It doesn't support the following scrub start options:
+ *
+ * - Background scrub
+ *   It's always running in foreground for now.
+ *
+ * - No support for scrub status file
+ *
+ * - No simple report
+ *   Only full scrub_fs_progress report.
+ *
+ * And this is hidden behind the experimental flags.
+ */
+static int scrub_fs_start(int fd)
+{
+#if EXPERIMENTAL
+	struct btrfs_ioctl_scrub_fs_args sfsa = { 0 };
+	struct btrfs_scrub_fs_progress *progress = &sfsa.progress;
+	int ret;
+
+	sfsa.start = 0;
+	sfsa.end = (u64)-1;
+
+	ret = ioctl(fd, BTRFS_IOC_SCRUB_FS, &sfsa);
+	if (ret < 0) {
+		ret = -errno;
+		if (ret != -ENOTTY && ret != -EOPNOTSUPP)
+			error("failed to call scrub_fs ioctl: %m");
+		return ret;
+	}
+
+	printf("nr_fatal_errors:       %u\n", progress->nr_fatal_errors);
+	printf("\n");
+	printf("Super accountings: (in number of superblocks)\n");
+	printf("  nr_super_scrubbed:   %u\n", progress->nr_super_scrubbed);
+	printf("  nr_super_repaired:   %u\n", progress->nr_super_repaired);
+	printf("  nr_super_errors:     %u\n", progress->nr_super_errors);
+	printf("\n");
+	printf("Metadata accountings: (in bytes)\n");
+	printf("  meta_scrubbed:       %llu\n", progress->meta_scrubbed);
+	printf("  meta_recoverable:    %llu\n", progress->meta_recoverable);
+	printf("\n");
+	printf("  meta_io_fail:        %llu\n", progress->meta_io_fail);
+	printf("  meta_invalid:        %llu\n", progress->meta_invalid);
+	printf("  meta_bad_csum:       %llu\n", progress->meta_bad_csum);
+	printf("  meta_bad_transid:    %llu\n", progress->meta_bad_transid);
+	printf("\n");
+	printf("Data accountings: (in bytes)\n");
+	printf("  data_scrubbed:       %llu\n", progress->data_scrubbed);
+	printf("  data_recoverable:    %llu\n", progress->data_recoverable);
+	printf("  data_uncertain:      %llu\n", progress->data_nocsum_uncertain);
+	printf("\n");
+	printf("  data_io_fail:        %llu\n", progress->data_io_fail);
+	printf("  data_csum_mismatch:  %llu\n", progress->data_csum_mismatch);
+	printf("Parity accountings: (in bytes)\n");
+	printf("  parity_scrubbed:     %llu\n", progress->parity_scrubbed);
+	printf("  parity_recoverable:  %llu\n", progress->parity_recoverable);
+	printf("  parity_uncertain:    %llu\n", progress->parity_uncertain);
+	printf("\n");
+	printf("  parity_io_fail:      %llu\n", progress->parity_io_fail);
+	printf("  parity_mismatch:     %llu\n", progress->parity_mismatch);
+
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		       bool resume)
 {
@@ -1246,6 +1315,16 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	if (fdmnt < 0)
 		return 1;
 
+	ret = scrub_fs_start(fdmnt);
+	/* The new interface has handled everything, can return directly. */
+	if (ret == 0)
+		return 0;
+	/* For kernels don't support the new interface, reset @ret to 0. */
+	if (ret == -EOPNOTSUPP || ret == -ENOTTY)
+		ret = 0;
+	if (ret < 0)
+		return 1;
+
 	ret = get_fs_info(path, &fi_args, &di_args);
 	if (ret) {
 		errno = -ret;
-- 
2.37.3

