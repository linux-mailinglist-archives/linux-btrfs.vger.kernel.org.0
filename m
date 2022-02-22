Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462E34C0340
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 21:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiBVUqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 15:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBVUqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 15:46:47 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEEA2F09;
        Tue, 22 Feb 2022 12:46:19 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 1FD08805FB;
        Tue, 22 Feb 2022 15:46:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1645562779; bh=exGi9sfLEpUdeDCaCpnxyACq8VLY6wHANq4eBPZRm2A=;
        h=From:To:Cc:Subject:Date:From;
        b=g6rkG2WZYpJJqbTRLCoVPwDStFmTw+ZWy6aHR0WCwHtvTRrFsBKGuxamTQSE0tLOn
         Nq64Snr129PRK/TJBuiumQZqS6sx+AQePU5MpoeR4uq/ViTwn7v8q1vDezOTjtczTo
         ZZqUOczwoy8oBEtebeQig5XhMFRapZ4Sj/dtK/iXHorQbFQWp/MPnWMM3rc3jFok5+
         ZzIuiSGmgMcVo2m9o45ZvvcHv9IL0THRCq8LmnhceZ4ZUa29eSCHbW3QbQX1050/D5
         f0ymfS77sRmAgw+QaQReo9Hx+zRv8KbDxXu6xwc6l1JGE3FitepTt1n3P+QjgqVEQf
         KOdeAHmrtjrug==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v3] btrfs: add fs state details to error messages.
Date:   Tue, 22 Feb 2022 15:42:28 -0500
Message-Id: <8a2a73ab4b48a4e73d24cf7f10cc0fe245d50a84.1645562216.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When a filesystem goes read-only due to an error, multiple errors tend
to be reported, some of which are knock-on failures. Logging fs_states,
in btrfs_handle_fs_error() and btrfs_printk() helps distinguish the
first error from subsequent messages which may only exist due to an
error state.

Under the new format, most initial errors will look like:
`BTRFS: error (device loop0) in ...`
while subsequent errors will begin with:
`error (device loop0: state E) in ...`

An initial transaction abort error will look like
`error (device loop0: state A) in ...`
and subsequent messages will contain
`(device loop0: state EA) in ...`

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
v3:
  - Reworked btrfs_state_to_string to use an array mapping all states
    to various error chars, or nothing, explicitly. Added error logging
    for more states, as requested.
  - Consolidated buffer length definition

v2: 
  - Changed btrfs_state_to_string() for clarity
  - Removed superfluous whitespace change
  - https://lore.kernel.org/linux-btrfs/084c136c6bb2d20ca0e91af7ded48306d52bb910.1645210326.git.sweettea-kernel@dorminy.me/

v1:
  - https://lore.kernel.org/linux-btrfs/20220212191042.94954-1-sweettea-kernel@dorminy.me/

 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/super.c | 62 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8992e0096163..3db337cd015a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -148,6 +148,8 @@ enum {
 
 	/* Indicates there was an error cleaning up a log tree. */
 	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
+
+	BTRFS_FS_STATE_COUNT,
 };
 
 #define BTRFS_BACKREF_REV_MAX		256
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4d947ba32da9..3fab9e46e80c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -66,6 +66,46 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
+#define STATE_STRING_PREFACE ": state "
+#define STATE_STRING_BUF_LEN \
+	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
+
+/* Characters to print to indicate error conditions. RO is not an error. */
+static const char * const fs_state_strings[] = {
+	[BTRFS_FS_STATE_ERROR]			= "E",
+	[BTRFS_FS_STATE_REMOUNTING]		= "M",
+	[BTRFS_FS_STATE_RO]			= NULL,
+	[BTRFS_FS_STATE_TRANS_ABORTED]		= "A",
+	[BTRFS_FS_STATE_DEV_REPLACING]		= "P",
+	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= NULL,
+	[BTRFS_FS_STATE_NO_CSUMS]		= NULL,
+	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= "L",
+};
+
+static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
+{
+	unsigned int bit;
+	unsigned int states_printed = 0;
+	char *curr = buf;
+
+	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
+	curr += sizeof(STATE_STRING_PREFACE) - 1;
+
+	for_each_set_bit(bit, &info->fs_state, sizeof(info->fs_state)) {
+		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
+		if ((bit < BTRFS_FS_STATE_COUNT) && (fs_state_strings[bit] != NULL)) {
+			*curr++ = fs_state_strings[bit][0];
+			states_printed++;
+		}
+	}
+
+	/* If no states were printed, reset the buffer */
+	if (!states_printed)
+		curr = buf;
+
+	*curr++ = '\0';
+}
+
 /*
  * Generally the error codes correspond to their respective errors, but there
  * are a few special cases.
@@ -128,6 +168,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 {
 	struct super_block *sb = fs_info->sb;
 #ifdef CONFIG_PRINTK
+	char statestr[STATE_STRING_BUF_LEN];
 	const char *errstr;
 #endif
 
@@ -140,6 +181,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 
 #ifdef CONFIG_PRINTK
 	errstr = btrfs_decode_error(errno);
+	btrfs_state_to_string(fs_info, statestr);
 	if (fmt) {
 		struct va_format vaf;
 		va_list args;
@@ -148,12 +190,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 		vaf.fmt = fmt;
 		vaf.va = &args;
 
-		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s (%pV)\n",
-			sb->s_id, function, line, errno, errstr, &vaf);
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
+			sb->s_id, statestr, function, line, errno, errstr, &vaf);
 		va_end(args);
 	} else {
-		pr_crit("BTRFS: error (device %s) in %s:%d: errno=%d %s\n",
-			sb->s_id, function, line, errno, errstr);
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
+			sb->s_id, statestr, function, line, errno, errstr);
 	}
 #endif
 
@@ -240,11 +282,15 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 	vaf.va = &args;
 
 	if (__ratelimit(ratelimit)) {
-		if (fs_info)
-			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
-				fs_info->sb->s_id, &vaf);
-		else
+		if (fs_info) {
+			char statestr[STATE_STRING_BUF_LEN];
+
+			btrfs_state_to_string(fs_info, statestr);
+			printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
+				fs_info->sb->s_id, statestr, &vaf);
+		} else {
 			printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+		}
 	}
 
 	va_end(args);
-- 
2.35.1

