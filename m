Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82773787CD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 03:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjHYBMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 21:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjHYBMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 21:12:14 -0400
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193319BB
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 18:12:09 -0700 (PDT)
Received: from [163.114.132.5] (helo=localhost)
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qZLMu-0006Nf-Ht; Fri, 25 Aug 2023 01:12:08 +0000
From:   Lee Trager <lee@trager.us>
To:     linux-btrfs@vger.kernel.org
Cc:     Lee Trager <lee@trager.us>
Subject: [PATCH] btrfs-progs: Allow specifying "min" when resizing filesystem
Date:   Thu, 24 Aug 2023 18:11:56 -0700
Message-Id: <20230825011156.4185571-1-lee@trager.us>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This simply allows the btrfs filesystem resize command to accept "min" as an
option. Processing is done in kernel.
Signed-off-by: Lee Trager <lee@trager.us>
---
 cmds/filesystem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 79f3e799..c05054d3 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1144,10 +1144,11 @@ next:
 static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
 
 static const char * const cmd_filesystem_resize_usage[] = {
-	"btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>",
+	"btrfs filesystem resize [options] [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max|min <path>",
 	"Resize a filesystem",
 	"If 'max' is passed, the filesystem will occupy all available space",
 	"on the device 'devid'.",
+	"If 'min' is passed, the filesystem will reduce size to allocated space.",
 	"[kK] means KiB, which denotes 1KiB = 1024B, 1MiB = 1024KiB, etc.",
 	"",
 	OPTLINE("--enqueue", "wait if there's another exclusive operation running, otherwise continue"),
@@ -1218,6 +1219,8 @@ static int check_resize_args(const char *amount, const char *path) {
 
 	if (strcmp(sizestr, "max") == 0) {
 		res_str = "max";
+	} else if (strcmp(sizestr, "min") == 0) {
+		res_str = "min";
 	} else if (strcmp(sizestr, "cancel") == 0) {
 		/* Different format, print and exit */
 		pr_verbose(LOG_DEFAULT, "Request to cancel resize\n");
-- 
2.34.1

