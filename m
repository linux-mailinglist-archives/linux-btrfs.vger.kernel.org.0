Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5410E4E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 04:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfLBDoe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 22:44:34 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40980 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfLBDod (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 22:44:33 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id 9FE28505D68;
        Sun,  1 Dec 2019 22:44:32 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1ibcdU-0006vF-E7; Sun, 01 Dec 2019 22:44:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: scrub: add start/end position for scrub
Date:   Sun,  1 Dec 2019 22:44:20 -0500
Message-Id: <20191202034420.4634-2-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202034420.4634-1-ce3g8jdj@umail.furryterror.org>
References: <20191202034420.4634-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow user to specify start (-s) and end (-e) position directly during
btrfs scrub start, by giving device offsets on the command line.
This allows scrubs to be targeted toward specific areas of disk.

These options may be used with either device names or mounted filesystem
paths, though it is probably more useful with the former.

The intended use case is to verify that data areas identified in previous
scrubs as being unreadable or containing uncorrectable errors have since
been remapped or removed, without having to rescan entire disks.

Note that some of the printed statistics (ETA, totals) will be
significantly inaccurate if these options are used.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 Documentation/btrfs-scrub.asciidoc |  6 +++++-
 cmds/scrub.c                       | 18 ++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/btrfs-scrub.asciidoc b/Documentation/btrfs-scrub.asciidoc
index 03f7f008..69ac96ff 100644
--- a/Documentation/btrfs-scrub.asciidoc
+++ b/Documentation/btrfs-scrub.asciidoc
@@ -51,7 +51,7 @@ Does not start a new scrub if the last scrub finished successfully.
 +
 see *scrub start*.
 
-*start* [-BdqrRf] [-c <ioprio_class> -n <ioprio_classdata>] <path>|<device>::
+*start* [-BdqrRf] [-c <ioprio_class> -n <ioprio_classdata> -s <start_pos> -e <end_pos>] <path>|<device>::
 Start a scrub on all devices of the filesystem identified by 'path' or on
 a single 'device'. If a scrub is already running, the new one fails.
 +
@@ -77,6 +77,10 @@ raw print mode, print full data instead of summary
 set IO priority class (see `ionice`(1) manpage)
 -n <ioprio_classdata>::::
 set IO priority classdata (see `ionice`(1) manpage)
+-s <start_pos>::::
+set start position by logical address (btrfs extent bytenr, default 0)
+-e <end_pos>::::
+set end position by logical address (btrfs extent bytenr, default end of filesystem)
 -f::::
 force starting new scrub even if a scrub is already running,
 this can useful when scrub status file is damaged and reports a running
diff --git a/cmds/scrub.c b/cmds/scrub.c
index 9fe59822..e60505e0 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1172,8 +1172,10 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	DIR *dirstream = NULL;
 	int force = 0;
 	int nothing_to_resume = 0;
+	u64 start_pos = 0;
+	u64 end_pos = -1ULL;
 
-	while ((c = getopt(argc, argv, "BdqrRc:n:f")) != -1) {
+	while ((c = getopt(argc, argv, "BdqrRc:n:fs:e:")) != -1) {
 		switch (c) {
 		case 'B':
 			do_background = 0;
@@ -1198,6 +1200,12 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		case 'n':
 			ioprio_classdata = (int)strtol(optarg, NULL, 10);
 			break;
+		case 's':
+			start_pos = strtoull(optarg, NULL, 0);
+			break;
+		case 'e':
+			end_pos = strtoull(optarg, NULL, 0);
+			break;
 		case 'f':
 			force = 1;
 			break;
@@ -1319,11 +1327,11 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 			continue;
 		} else {
 			++n_start;
-			sp[i].scrub_args.start = 0ll;
+			sp[i].scrub_args.start = start_pos;
 			sp[i].resumed = NULL;
 		}
 		sp[i].skip = 0;
-		sp[i].scrub_args.end = (u64)-1ll;
+		sp[i].scrub_args.end = end_pos;
 		sp[i].scrub_args.flags = readonly ? BTRFS_SCRUB_READONLY : 0;
 		sp[i].ioprio_class = ioprio_class;
 		sp[i].ioprio_classdata = ioprio_classdata;
@@ -1599,7 +1607,7 @@ out:
 }
 
 static const char * const cmd_scrub_start_usage[] = {
-	"btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>",
+	"btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata -s start_pos -e end_pos] <path>|<device>",
 	"Start a new scrub. If a scrub is already running, the new one fails.",
 	"",
 	"-B     do not background",
@@ -1609,6 +1617,8 @@ static const char * const cmd_scrub_start_usage[] = {
 	"-R     raw print mode, print full data instead of summary",
 	"-c     set ioprio class (see ionice(1) manpage)",
 	"-n     set ioprio classdata (see ionice(1) manpage)",
+	"-s     start scrub at position (default 0)",
+	"-e     end scrub at position (default end of device)",
 	"-f     force starting new scrub even if a scrub is already running",
 	"       this is useful when scrub stats record file is damaged",
 	NULL
-- 
2.20.1

