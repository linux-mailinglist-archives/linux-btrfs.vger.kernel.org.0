Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478227D4BEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJXJYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJXJYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 05:24:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE7C2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 02:24:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F211A1FD71
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698139458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Y3+2M+OF6IuCoEAhYCXhg0Br5AlSI8XKvID2TZyrECU=;
        b=dcCnWVaADWxaLRMn/ruVjFA32pqH+tWXkY0Tdp+PHkmQkwPD3F/9TszUs9bKOFE/DQ0pZj
        hBgNyXGAXfmaqv7WhpPegzWwBXQ+3Krqxf2JSQBFagNtBFOV8RL6I8GpRrE6E5Qidb7d7o
        PNLUCTl9nGMfivgznOLgXgj0gIJ2YIM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDA71391C
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 09:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zi6aN0CNN2XhAwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 09:24:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: move space cache removal to rescue group
Date:   Tue, 24 Oct 2023 19:53:57 +1030
Message-ID: <b64e4bc22f58a826d65aae73c2eed9ca029f1dca.1698139433.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The option "--clear-space-cache" is not really that suitable for "btrfs
check" group, as there are some concerns:

- Allowing transid mismatch
- No leaf item checks

  Those behaviors are inherited from the default open ctree flags for
  "btrfs check", which can be unsafe if the end user just wants to clear
  the cache.

- Unclear if the the cache clearing would happen along with repair

  Thankfully the clearing of space cache is done without any repair

Thus there is a proposal to move space cache removal to rescue group,
and this patch would do that exactly.

However this would lead to some behavior changes:

- Transid mismatch would be treated as error
- Leaf items size/offset would still be checked

  If we hit any above error, we should just abort without doing any
  write.

These change would increase the safety of the space cache removal, thus
I believe it's worthy to introduce such behavior change.

Since we're here, also add a small explanation on why we need this
dedicated tool to clear space cache (especially for v1 cache).

Issue: #698
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-check.rst  |  4 +++
 Documentation/btrfs-rescue.rst |  7 ++++
 btrfs-completion               |  2 +-
 check/main.c                   |  1 +
 cmds/rescue.c                  | 63 ++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index 3c5f96f1951f..046aec52923a 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -83,6 +83,10 @@ SAFE OR ADVISORY OPTIONS
 
         See also the *clear_cache* mount option.
 
+	.. warning::
+		This option is deprecated, please use `btrfs rescue clear-space-cache`
+		instead, this option would be removed in the future eventually.
+
 --clear-ino-cache
         remove leftover items pertaining to the deprecated `inode cache` feature
 
diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index 3c58f1dad10e..b6f43933323d 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -56,6 +56,13 @@ clear-ino-cache <device>
 	The `inode cache` feature (enabled by mount option "inode_cache") has been
 	completely removed in 5.11 kernel.
 
+clear-space-cache (v1|v2) <device>
+	Completely remove the on-disk data of specified free space cache.
+
+	Especially for v1 free space cache, `clear_cache` mount option would only
+	remove the cache for updated block groups, the remaining would not be removed.
+	Thus this tool is provided to manually clear the free space cache.
+
 clear-uuid-tree <device>
         Clear UUID tree, so that kernel can re-generate it at next read-write
         mount.
diff --git a/btrfs-completion b/btrfs-completion
index 48456694b1de..1d224087f95d 100644
--- a/btrfs-completion
+++ b/btrfs-completion
@@ -28,7 +28,7 @@ _btrfs()
 	commands_balance='start pause cancel resume status'
 	commands_device='scan add delete remove ready stats usage'
 	commands_scrub='start cancel resume status'
-	commands_rescue='chunk-recover super-recover zero-log fix-device-size create-control-device clear-uuid-tree clear-ino-cache'
+	commands_rescue='chunk-recover super-recover zero-log fix-device-size create-control-device clear-uuid-tree clear-ino-cache clear-space-cache'
 	commands_inspect_internal='inode-resolve logical-resolve subvolid-resolve rootid min-dev-size dump-tree dump-super tree-stats map-swapfile'
 	commands_property='get set list'
 	commands_quota='enable disable rescan'
diff --git a/check/main.c b/check/main.c
index 87a4835e1b90..1e6b9004493b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10232,6 +10232,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (clear_space_cache) {
+		warning("--clear-space-cache option is deprecated, please use \"btrfs rescue clear-space-cache\" instead");
 		ret = do_clear_free_space_cache(gfs_info, clear_space_cache);
 		err |= !!ret;
 		goto close_out;
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 7ef980762378..763c8bbb627e 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -456,6 +456,68 @@ out:
 }
 static DEFINE_SIMPLE_COMMAND(rescue_clear_ino_cache, "clear-ino-cache");
 
+static const char * const cmd_rescue_clear_space_cache_usage[] = {
+	"btrfs rescue clear-space-cache (v1|v2) <device>",
+	"completely remove the v1 or v2 free space cache",
+	NULL
+};
+
+static int cmd_rescue_clear_space_cache(const struct cmd_struct *cmd,
+					int argc, char **argv)
+{
+	struct open_ctree_args oca = { 0 };
+	struct btrfs_fs_info *fs_info;
+	char *devname;
+	char *version_string;
+	int clear_version;
+	int ret;
+
+	clean_args_no_options(cmd, argc, argv);
+
+	if (check_argc_exact(argc, 3))
+		return 1;
+
+
+	version_string = argv[optind];
+	devname = argv[optind + 1];
+	oca.filename = devname;
+	oca.flags = OPEN_CTREE_WRITES | OPEN_CTREE_EXCLUSIVE;
+
+	if (strncasecmp(version_string, "v1", strlen("v1")) == 0) {
+		clear_version = 1;
+	} else if (strncasecmp(version_string, "v2", strlen("v2")) == 0) {
+		clear_version = 2;
+		oca.flags |= OPEN_CTREE_INVALIDATE_FST;
+	} else {
+		error("invalid version string, has \"%s\" expect \"v1\" or \"v2\"",
+		      version_string);
+		return 1;
+	}
+	ret = check_mounted(devname);
+	if (ret < 0) {
+		errno = -ret;
+		error("could not check mount status: %m");
+		return 1;
+	}
+	if (ret > 0) {
+		error("%s is currently mounted", devname);
+		return 1;
+	}
+	fs_info = open_ctree_fs_info(&oca);
+	if (!fs_info) {
+		error("cannot open file system");
+		return 1;
+	}
+	ret = do_clear_free_space_cache(fs_info, clear_version);
+	close_ctree(fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to clear free space cache: %m");
+	}
+	return !!ret;
+}
+static DEFINE_SIMPLE_COMMAND(rescue_clear_space_cache, "clear-space-cache");
+
 static const char rescue_cmd_group_info[] =
 "toolbox for specific rescue operations";
 
@@ -467,6 +529,7 @@ static const struct cmd_group rescue_cmd_group = {
 		&cmd_struct_rescue_fix_device_size,
 		&cmd_struct_rescue_create_control_device,
 		&cmd_struct_rescue_clear_ino_cache,
+		&cmd_struct_rescue_clear_space_cache,
 		&cmd_struct_rescue_clear_uuid_tree,
 		NULL
 	}
-- 
2.42.0

