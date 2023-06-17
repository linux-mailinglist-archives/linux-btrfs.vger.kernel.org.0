Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8F6733E2C
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjFQFJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFQFJ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:09:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B11FD5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A14E81FD63
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686978593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C8dmyIFdtB4lBYd1qFskFnsrJjKD2PdLK9Rku0SHREo=;
        b=Ry4+VHq/iU2FyofGai6LWm5FKPwATTWvsI+vXcimQQqkI1ZEIpZfxpZrXMtJuKHinKbXYC
        XhZsQgdrLogTdxvNIwWGSkD4NKzXvkqjLzVuoazD3IbWBE+7IatMietuQDij+F457cy+kN
        guQeyl72+XN6NjNeVdrRrc/beAiEodo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EED1013915
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IB0VLSBAjWRoEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 05:09:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: scrub: add basic support for SCRUB_LOGICAL
Date:   Sat, 17 Jun 2023 13:09:35 +0800
Message-ID: <20230617050935.138165-1-wqu@suse.com>
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

This patch is only for test purpose.

It addes a new option, "-l", to "scrub start" subcommand, and only
support foreground scrub and full report.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/scrub.c               | 33 +++++++++++++++++++++++++++++++--
 kernel-shared/uapi/btrfs.h |  3 ++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 96e3bb5c..82d69975 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -326,7 +326,8 @@ static void print_scrub_dev(struct btrfs_ioctl_dev_info_args *di,
 		if (raw)
 			print_scrub_full(p);
 		else
-			print_scrub_summary(p, ss, di->bytes_used);
+			print_scrub_summary(p, ss, p->tree_bytes_scrubbed +
+						   p->data_bytes_scrubbed);
 	}
 }
 
@@ -1146,6 +1147,24 @@ static int is_scrub_running_in_kernel(int fd,
 	return 0;
 }
 
+static int scrub_one_fs(int fd, bool readonly)
+{
+	struct btrfs_ioctl_scrub_args scrub_args = { 0 };
+	int ret;
+
+	scrub_args.flags = BTRFS_SCRUB_LOGICAL;
+	scrub_args.end = U64_MAX;
+	if (readonly)
+		scrub_args.flags |= BTRFS_SCRUB_READONLY;
+	ret = ioctl(fd, BTRFS_IOC_SCRUB, &scrub_args);
+	if (ret < 0) {
+		error("failed to do logical scrub: ret=%d errno=%d\n", ret, errno);
+		return ret;
+	}
+	print_scrub_full(&scrub_args.progress);
+	return 0;
+}
+
 static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		       bool resume)
 {
@@ -1164,6 +1183,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	bool do_background = true;
 	bool do_wait = false;
 	bool do_print = false;
+	bool do_logical_scrub = false;
 	int do_quiet = !bconf.verbose; /*Read the global quiet option if set*/
 	bool do_record = true;
 	bool readonly = false;
@@ -1195,7 +1215,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	bool force = false;
 	bool nothing_to_resume = false;
 
-	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
+	while ((c = getopt(argc, argv, "BdqrRc:n:fl")) != -1) {
 		switch (c) {
 		case 'B':
 			do_background = false;
@@ -1224,6 +1244,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		case 'f':
 			force = true;
 			break;
+		case 'l':
+			do_logical_scrub = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -1252,6 +1275,12 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	if (fdmnt < 0)
 		return 1;
 
+	if (do_logical_scrub) {
+		ret = scrub_one_fs(fdmnt, readonly);
+		if (ret < 0)
+			err = 1;
+		goto out;
+	}
 	ret = get_fs_info(path, &fi_args, &di_args);
 	if (ret) {
 		errno = -ret;
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 0859a7cc..6038ee4c 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -199,7 +199,8 @@ struct btrfs_scrub_progress {
 					 * Intermittent error. */
 };
 
-#define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_READONLY		(1ULL << 0)
+#define BTRFS_SCRUB_LOGICAL		(1ULL << 1)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
-- 
2.39.0

