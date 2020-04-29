Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24571BD91B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD2KKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 06:10:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgD2KKU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 06:10:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1BEAABD1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 10:10:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: check: Don't do early exit if maybe_repair_root_item() can't find needed root extent
Date:   Wed, 29 Apr 2020 18:10:15 +0800
Message-Id: <20200429101015.78658-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The whole maybe_repair_root_item() and repair_root_items() functions are
introduced to handle an ancient bug in v3.17.

However in certain extent tree corruption case, such early exit would
only exit the whole check process early on, preventing user to know
what's really wrong about the fs.

So this patch will allow the check to continue, since the ancient bug is
no long that common.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index be980c152274..ac11a35125b8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10306,20 +10306,28 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			err = !!ret;
 			errno = -ret;
 			error("failed to repair root items: %m");
-			goto close_out;
-		}
-		if (repair) {
-			fprintf(stderr, "Fixed %d roots.\n", ret);
-			ret = 0;
-		} else if (ret > 0) {
-			fprintf(stderr,
+			/*
+			 * For repair, if we can't repair root items, it's
+			 * fatal.
+			 * But for non-repair, it's pretty rare to hit such
+			 * v3.17 era bug, we want to continue check.
+			 */
+			if (repair)
+				goto close_out;
+			err |= 1;
+		} else {
+			if (repair) {
+				fprintf(stderr, "Fixed %d roots.\n", ret);
+				ret = 0;
+			} else if (ret > 0) {
+				fprintf(stderr,
 				"Found %d roots with an outdated root item.\n",
-				ret);
-			fprintf(stderr,
+					ret);
+				fprintf(stderr,
 	"Please run a filesystem check with the option --repair to fix them.\n");
-			ret = 1;
-			err |= ret;
-			goto close_out;
+				ret = 1;
+				err |= ret;
+			}
 		}
 	} else {
 		fprintf(stderr, "[1/7] checking root items... skipped\n");
-- 
2.26.2

