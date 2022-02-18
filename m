Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FE4BC010
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 20:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiBRTE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 14:04:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiBRTEy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 14:04:54 -0500
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5791037AB3;
        Fri, 18 Feb 2022 11:04:37 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C19A9806DD;
        Fri, 18 Feb 2022 14:04:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1645211077; bh=u0cW/t46oqvr7C5YPhOZwXIF+FLYG2zLHP9c1V6LIvA=;
        h=From:To:Cc:Subject:Date:From;
        b=BkLr3K8dcJVzBJ2PFqWDzlyWOtSTAp1TofLhf1s0OIY/F/yvPYR6++zGNKiKruu4H
         T5UAwahvps8MWEJgprOBNYw+rUbphPIFDGmbcJN6iJPR99wmXE2vqjH4UkmvlO7RNA
         5ZmI6TG0OA3xjUF8J3pIHkl1rV+bBw+GxwkvIRbP/g3gZi9elgygjioCLC5FNMkQ6d
         0b6AbiKIVNypCaqt7leQ2OHDwwGaGmXIgdCWYHB/RN4EaxF5ghzDufNPqEgqISC2yq
         GuIxGoLFqRb+rYnyFve4WJTZv0XQ4+QFsxz4dHZI6uKwBiMkcNOB6BePuZMbMH4fe0
         wsDRtVox8iDDg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2] btrfs: add fs state details to error messages.
Date:   Fri, 18 Feb 2022 14:04:29 -0500
Message-Id: <084c136c6bb2d20ca0e91af7ded48306d52bb910.1645210326.git.sweettea-kernel@dorminy.me>
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
to be reported, some of which are knock-on failures. Logging some
fs_states, if any, in btrfs_handle_fs_error() and btrfs_printk()
helps distinguish the first error from subsequent messages which may
only exist due to an error state.

Under the new format, most initial errors will look like:
`BTRFS: error (device loop0) in ...`
while subsequent errors will begin with:
`error (device loop0: state E) in ...`

An initial transaction abort error will look like
`error (device loop0: state X) in ...`
and subsequent messages will contain
`(device loop0: state EX) in ...`

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
v2:
  - Changed btrfs_state_to_string() for clarity
  - Removed superfluous whitespace change

v1:
  - https://lore.kernel.org/linux-btrfs/20220212191042.94954-1-sweettea-kernel@dorminy.me/

 fs/btrfs/super.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4d947ba32da9..42429d68950d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -66,6 +66,37 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
+#define STATE_STRING_PREFACE ": state "
+#define MAX_STATE_CHARS 2
+
+static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
+{
+	unsigned int states_printed = 0;
+	char *curr = buf;
+
+	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
+	curr += sizeof(STATE_STRING_PREFACE) - 1;
+
+	/* If more states are reported, update MAX_STATE_CHARS also */
+	if (test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
+		*curr++ = 'E';
+		states_printed++;
+	}
+
+	if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &info->fs_state)) {
+		*curr++ = 'X';
+		states_printed++;
+	}
+
+	/* If no states were printed, reset the buffer */
+	if (!states_printed)
+		curr = buf;
+
+	WARN_ON_ONCE(states_printed > MAX_STATE_CHARS);
+
+	*curr++ = '\0';
+}
+
 /*
  * Generally the error codes correspond to their respective errors, but there
  * are a few special cases.
@@ -128,6 +159,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 {
 	struct super_block *sb = fs_info->sb;
 #ifdef CONFIG_PRINTK
+	char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
 	const char *errstr;
 #endif
 
@@ -140,6 +172,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 
 #ifdef CONFIG_PRINTK
 	errstr = btrfs_decode_error(errno);
+	btrfs_state_to_string(fs_info, statestr);
 	if (fmt) {
 		struct va_format vaf;
 		va_list args;
@@ -148,12 +181,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
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
 
@@ -240,11 +273,15 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
 	vaf.va = &args;
 
 	if (__ratelimit(ratelimit)) {
-		if (fs_info)
-			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
-				fs_info->sb->s_id, &vaf);
-		else
+		if (fs_info) {
+			char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
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

