Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B16764671
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjG0GIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 02:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjG0GIj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75C10F9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 23:08:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CD2021B85
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690438117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gM8XwYBCjyzoGlGGOmbfF2+i0P0vhoyS8DqrjiC9feY=;
        b=kQQp/VJni1bO3Tq0o9K28LI4ea/pTXSiUymhzgH4HGsXhznRWWKt5eH4R/xwChnMJYgJzN
        0OEJBMM292aKSufDUfSax0kf9965KD/RCK953xeJV4cvc1fPhMsv8iCOgxvO2KC02NL/3e
        g4ouP+zmQv7/e16yu97+5RinVFj1Af4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6FDE13902
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x8zoHeQJwmRJDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 06:08:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmd-device: add options to sync the fs after adding all devices
Date:   Thu, 27 Jul 2023 14:08:18 +0800
Message-ID: <a8c4c892258c28ddf763ba4386449665d2705c08.1690435989.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

Although kernels would commit transaction after adding each device, the
behavior itself would change to allow emergency device add (aka, without
extra devices the fs can not commit a transaction).

Unfortunately btrfs device add ioctl has no extra space for new flags,
so here we add extra flags --sync and --nosync to "btrfs device add"
subcommand.

This would allowing users to choose if the target filesystem needs to be
synced after all devices added.

The default behavior is --sync, to keep the behavior the same no matter
kernel versions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-device.rst |  8 ++++++++
 cmds/device.c                  | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-device.rst b/Documentation/btrfs-device.rst
index 0459e93681e1..30c3afca8e3b 100644
--- a/Documentation/btrfs-device.rst
+++ b/Documentation/btrfs-device.rst
@@ -41,6 +41,14 @@ add [-Kf] <device> [<device>...] <path>
         --enqueue
                 wait if there's another exclusive operation running, otherwise continue
 
+        --sync
+                sync the filesystem after all devices added
+
+        --nosync
+                do not sync the filesystem after all devices added.
+                This may not work as older kernels would commit transaction after
+                adding each device.
+
 remove [options] <device>|<devid> [<device>|<devid>...] <path>
         Remove device(s) from a filesystem identified by <path>
 
diff --git a/cmds/device.c b/cmds/device.c
index 94418d43d6d4..e4458d668ebc 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -42,6 +42,7 @@
 #include "cmds/commands.h"
 #include "cmds/filesystem-usage.h"
 #include "mkfs/common.h"
+#include "libbtrfsutil/btrfsutil.h"
 
 static const char * const device_cmd_group_usage[] = {
 	"btrfs device <command> [<args>]",
@@ -55,6 +56,8 @@ static const char * const cmd_device_add_usage[] = {
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM on devices that report such capability"),
 	OPTLINE("-f|--force", "force overwrite existing filesystem on the disk"),
 	OPTLINE("--enqueue", "wait if there's another exclusive operation running, otherwise continue"),
+	OPTLINE("--sync", "sync the fs after all devices added"),
+	OPTLINE("--nosync", "do not sync the fs after all devices added"),
 	NULL
 };
 
@@ -68,17 +71,21 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	bool force = false;
 	int last_dev;
 	bool enqueue = false;
+	bool do_sync = true;
 	int zoned;
 	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_ENQUEUE = GETOPT_VAL_FIRST };
+		enum { GETOPT_VAL_ENQUEUE = GETOPT_VAL_FIRST,
+		       GETOPT_VAL_SYNC, GETOPT_VAL_NOSYNC };
 		static const struct option long_options[] = {
 			{ "nodiscard", optional_argument, NULL, 'K'},
 			{ "force", no_argument, NULL, 'f'},
 			{ "enqueue", no_argument, NULL, GETOPT_VAL_ENQUEUE},
+			{ "sync", no_argument, NULL, GETOPT_VAL_SYNC},
+			{ "nosync", no_argument, NULL, GETOPT_VAL_NOSYNC},
 			{ NULL, 0, NULL, 0}
 		};
 
@@ -95,6 +102,12 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 		case GETOPT_VAL_ENQUEUE:
 			enqueue = true;
 			break;
+		case GETOPT_VAL_SYNC:
+			do_sync = true;
+			break;
+		case GETOPT_VAL_NOSYNC:
+			do_sync = false;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -181,6 +194,13 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	}
 
 error_out:
+	if (!ret && do_sync) {
+		ret = btrfs_util_sync_fd(fdmnt);
+		if (ret < 0) {
+			errno = -ret;
+			error("error syncing the fs: %m");
+		}
+	}
 	btrfs_warn_multiple_profiles(fdmnt);
 	close_file_or_dir(fdmnt, dirstream);
 	return !!ret;
-- 
2.41.0

