Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73140686C8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Feb 2023 18:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBAROR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Feb 2023 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBAROJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Feb 2023 12:14:09 -0500
X-Greylist: delayed 468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 09:14:06 PST
Received: from mx3.rus.uni-stuttgart.de (mx3.rus.uni-stuttgart.de [IPv6:2001:7c0:2041:25::a:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902835BD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 09:14:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mx3.rus.uni-stuttgart.de (Postfix) with ESMTP id A85AF200D3
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 18:06:13 +0100 (CET)
X-Virus-Scanned: USTUTT mailrelay AV services at mx3.rus.uni-stuttgart.de
Received: from mx3.rus.uni-stuttgart.de ([127.0.0.1])
        by localhost (mx3.rus.uni-stuttgart.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Is8XgLSWjC1E for <linux-btrfs@vger.kernel.org>;
        Wed,  1 Feb 2023 18:06:07 +0100 (CET)
Received: from dsimail.dsi.uni-stuttgart.de (dsimail.irs.uni-stuttgart.de [129.69.71.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mx3.rus.uni-stuttgart.de (Postfix) with ESMTPS
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 18:06:07 +0100 (CET)
Received: from daof.dsi.uni-stuttgart.de (unknown [130.134.188.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: daofadmin)
        by dsimail.dsi.uni-stuttgart.de (Postfix) with ESMTPSA id D486B12023B;
        Wed,  1 Feb 2023 18:06:06 +0100 (CET)
Received: by daof.dsi.uni-stuttgart.de (Postfix, from userid 1000)
        id 087E837AF46; Wed,  1 Feb 2023 09:06:04 -0800 (PST)
Date:   Wed, 01 Feb 2023 09:06:04 -0800
From:   Holger Jakob <jakob@dsi.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org, jakob@dsi.uni-stuttgart.de
Subject: [PATCH] btrfs-progs: restore of xattrs fixed
Message-ID: <63da9bfc./KHue3enEPkwBabd%jakob@dsi.uni-stuttgart.de>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

    Fixed issue with metadata getting modified in dry run mode
    Fixed issue with restore of xattrs not working on directories


diff --git a/cmds/restore.c b/cmds/restore.c
index 19df6be2..c643f956 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -621,6 +621,26 @@ out:
 	return ret;
 }
 
+static int copy_xattrs(struct btrfs_root *root, int fd,
+		struct btrfs_key *key, const char *path_name)
+{
+	struct btrfs_path path;
+	int ret;
+
+	btrfs_init_path(&path);
+	ret = btrfs_lookup_inode(NULL, root, &path, key, 0);
+	if (ret == 0) {
+		ret = set_file_xattrs(root, key->objectid, fd, path_name);
+		if (ret) {
+			error("failed to set xattrs: %m");
+			goto out;
+		}
+	}
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int copy_file(struct btrfs_root *root, int fd, struct btrfs_key *key,
 		     const char *file)
 {
@@ -1117,11 +1137,11 @@ next:
 		path.slots[0]++;
 	}
 
-	if (restore_metadata) {
+	if ((restore_metadata || get_xattrs) && !dry_run) {
 		snprintf(path_name, PATH_MAX, "%s%s", output_rootdir, in_dir);
 		fd = open(path_name, O_RDONLY);
 		if (fd < 0) {
-			error("failed to access '%s' to restore metadata: %m",
+			error("failed to access '%s' to restore metadata/xattrs: %m",
 					path_name);
 			if (!ignore_errors) {
 				ret = -1;
@@ -1132,7 +1152,20 @@ next:
 			 * Set owner/mode/time on the directory as well
 			 */
 			key->type = BTRFS_INODE_ITEM_KEY;
-			ret = copy_metadata(root, fd, key);
+			if (restore_metadata) {
+				ret = copy_metadata(root, fd, key);
+			}
+			if (ret && !ignore_errors) {
+				close(fd);
+				goto out;
+			}
+
+			/*
+			 * Set xattrs on the directory
+			 */
+			if (get_xattrs) {
+				ret = copy_xattrs(root, fd, key, path_name);
+			}
 			close(fd);
 			if (ret && !ignore_errors)
 				goto out;
