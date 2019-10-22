Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789E9DFED6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfJVH6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 03:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387999AbfJVH6R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 03:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C014B86C;
        Tue, 22 Oct 2019 07:58:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] fstests: log-writes: Add new discard check point
Date:   Tue, 22 Oct 2019 15:58:05 +0800
Message-Id: <20191022075806.16616-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022075806.16616-1-wqu@suse.com>
References: <20191022075806.16616-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Despite the existing <number>|fua|flush checkpoint, add a new discard
check point to make sure discard is not screwing up things.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 src/log-writes/replay-log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
index 829b18e2..968c82ab 100644
--- a/src/log-writes/replay-log.c
+++ b/src/log-writes/replay-log.c
@@ -64,8 +64,8 @@ static void usage(void)
 	fprintf(stderr, "\t--no-discard - don't process discard entries\n");
 	fprintf(stderr, "\t--fsck - the fsck command to run, must specify "
 		"--check\n");
-	fprintf(stderr, "\t--check [<number>|flush|fua] when to check the "
-		"file system, mush specify --fsck\n");
+	fprintf(stderr, "\t--check [<number>|flush|fua|discard] when to check "
+		"the file system, mush specify --fsck\n");
 	fprintf(stderr, "\t--start-sector <sector> - replay ops on region "
 		"from <sector> onto <device>\n");
 	fprintf(stderr, "\t--end-sector <sector> - replay ops on region "
@@ -115,6 +115,7 @@ enum log_replay_check_mode {
 	CHECK_NUMBER = 1,
 	CHECK_FUA = 2,
 	CHECK_FLUSH = 3,
+	CHECK_DISCARD = 4,
 };
 
 static int seek_to_mark(struct log *log, struct log_write_entry *entry,
@@ -253,6 +254,8 @@ int main(int argc, char **argv)
 				check_mode = CHECK_FLUSH;
 			} else if (!strcmp(optarg, "fua")) {
 				check_mode = CHECK_FUA;
+			} else if (!strcmp(optarg, "discard")) {
+				check_mode = CHECK_DISCARD;
 			} else {
 				check_mode = CHECK_NUMBER;
 				check_number = strtoull(optarg, &tmp, 0);
@@ -369,6 +372,9 @@ int main(int argc, char **argv)
 			else if ((check_mode == CHECK_FLUSH) &&
 				 should_stop(entry, LOG_FLUSH_FLAG, NULL))
 				ret = run_fsck(log, fsck_command);
+			else if ((check_mode == CHECK_DISCARD) &&
+				 should_stop(entry, LOG_DISCARD_FLAG, NULL))
+				ret = run_fsck(log, fsck_command);
 			else
 				ret = 0;
 			if (ret) {
-- 
2.23.0

