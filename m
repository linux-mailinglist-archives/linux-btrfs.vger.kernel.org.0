Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAB68746F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 05:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBBEd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Feb 2023 23:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBBEd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Feb 2023 23:33:58 -0500
Received: from mx3.rus.uni-stuttgart.de (mx3.rus.uni-stuttgart.de [IPv6:2001:7c0:2041:25::a:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998B53577
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 20:33:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mx3.rus.uni-stuttgart.de (Postfix) with ESMTP id 87A4F200C9
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 05:33:50 +0100 (CET)
X-Virus-Scanned: USTUTT mailrelay AV services at mx3.rus.uni-stuttgart.de
Received: from mx3.rus.uni-stuttgart.de ([127.0.0.1])
        by localhost (mx3.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gsQvh2EdGd6K for <linux-btrfs@vger.kernel.org>;
        Thu,  2 Feb 2023 05:33:48 +0100 (CET)
Received: from dsimail.dsi.uni-stuttgart.de (dsimail.irs.uni-stuttgart.de [129.69.71.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx3.rus.uni-stuttgart.de (Postfix) with ESMTPS
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 05:33:48 +0100 (CET)
Received: from daof.dsi.uni-stuttgart.de (unknown [130.134.188.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daofadmin)
        by dsimail.dsi.uni-stuttgart.de (Postfix) with ESMTPSA id 5D5951200A3;
        Thu,  2 Feb 2023 05:33:48 +0100 (CET)
Received: by daof.dsi.uni-stuttgart.de (Postfix, from userid 1000)
        id 7238F37AF8C; Wed,  1 Feb 2023 20:33:46 -0800 (PST)
From:   Holger Jakob <jakob@dsi.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Holger Jakob <jakob@dsi.uni-stuttgart.de>
Subject: [PATCH v2 1/2] Fixed issue with restore of xattrs not working on directories
Date:   Wed,  1 Feb 2023 20:33:44 -0800
Message-Id: <20230202043345.14010-1-jakob@dsi.uni-stuttgart.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <7b2b7360-9008-7d88-02db-1ca4f07a6df6@oracle.com>
References: <7b2b7360-9008-7d88-02db-1ca4f07a6df6@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Restore was only setting xattrs on files but ignored directories.
The patch adds a missing set_file_xattrs

Signed-off-by: Holger Jakob <jakob@dsi.uni-stuttgart.de>
---
 cmds/restore.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 19df6be2..18edc8ca 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1117,11 +1117,11 @@ next:
 		path.slots[0]++;
 	}
 
-	if (restore_metadata) {
+	if (restore_metadata || get_xattrs) {
 		snprintf(path_name, PATH_MAX, "%s%s", output_rootdir, in_dir);
 		fd = open(path_name, O_RDONLY);
 		if (fd < 0) {
-			error("failed to access '%s' to restore metadata: %m",
+			error("failed to access '%s' to restore metadata/xattrs: %m",
 					path_name);
 			if (!ignore_errors) {
 				ret = -1;
@@ -1132,7 +1132,23 @@ next:
 			 * Set owner/mode/time on the directory as well
 			 */
 			key->type = BTRFS_INODE_ITEM_KEY;
-			ret = copy_metadata(root, fd, key);
+			if (restore_metadata) {
+				ret = copy_metadata(root, fd, key);
+				if (ret && !ignore_errors) {
+					close(fd);
+					goto out;
+				}
+			}
+
+			/*
+			 * Also set xattrs on the directory
+			 */
+			if (get_xattrs) {
+				ret = set_file_xattrs(root, key->objectid, fd, path_name);
+				if (ret) {
+					error("failed to set xattrs: %m");
+				}
+			}
 			close(fd);
 			if (ret && !ignore_errors)
 				goto out;
-- 
2.35.3

