Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED254B379B
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 20:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiBLTSG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Feb 2022 14:18:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBLTSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Feb 2022 14:18:05 -0500
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 11:18:01 PST
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F7606C4;
        Sat, 12 Feb 2022 11:18:01 -0800 (PST)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E8C5280382;
        Sat, 12 Feb 2022 14:10:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1644693052; bh=txZS8eXu8kt+0fauTv33PdZYC897WdlzL1mtCypvBWI=;
        h=From:To:Cc:Subject:Date:From;
        b=LtNiPXqy/7xFiJe4+PEeaVZL1S1V2Alsu9Q4eheH57UWChPSvxGqEmTr8EA3hhwe4
         uAHOAKv9Iq0v7ZF9T/qYq4tBIJ6qKakL2yEZmGCuMgdKNgcsUwq328ZeY23NljbqO8
         B2/ha+6sflm0AP5TKDS+cY0wi+/TDaDOdr9n2UKscQaNmz1jaXFj1zHgK4Ng/BasEz
         ZBjgMJwZMlvORiT3qhN2ZcZLjUczKpIY/45cDqZS1uJBLl3iYQb7BXHx1gbpQrnAmG
         qmEXe9a4fYKv6SUE/TGfOZwfy2hA7I9tdtraYdKMcBcIpTh31ohkvk6HIT5o/xHdjN
         Lq6U7yEcKpsAg==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] btrfs: add fs state details to error messages.
Date:   Sat, 12 Feb 2022 14:10:42 -0500
Message-Id: <20220212191042.94954-1-sweettea-kernel@dorminy.me>
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
 fs/btrfs/super.c | 49 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 33cfc9e27451..d0e81eb48eac 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -66,6 +66,31 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
+#define STATE_STRING_PREFACE ": state "
+#define MAX_STATE_CHARS 2
+
+static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
+{
+	unsigned long state = info->fs_state;
+	char *curr = buf;
+
+	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
+	curr += sizeof(STATE_STRING_PREFACE) - 1;
+
+	/* If more states are reported, update MAX_STATE_CHARS also */
+	if (test_and_clear_bit(BTRFS_FS_STATE_ERROR, &state))
+		*curr++ = 'E';
+
+	if (test_and_clear_bit(BTRFS_FS_STATE_TRANS_ABORTED, &state))
+		*curr++ = 'X';
+
+	/* If no states were printed, reset the buffer */
+	if (state == info->fs_state)
+		curr = buf;
+
+	*curr++ = '\0';
+}
+
 /*
  * Generally the error codes correspond to their respective errors, but there
  * are a few special cases.
@@ -128,6 +153,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 {
 	struct super_block *sb = fs_info->sb;
 #ifdef CONFIG_PRINTK
+	char statestr[sizeof(STATE_STRING_PREFACE) + MAX_STATE_CHARS];
 	const char *errstr;
 #endif
 
@@ -136,10 +162,11 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * under SB_RDONLY, then it is safe here.
 	 */
 	if (errno == -EROFS && sb_rdonly(sb))
-  		return;
+		return;
 
 #ifdef CONFIG_PRINTK
 	errstr = btrfs_decode_error(errno);
+	btrfs_state_to_string(fs_info, statestr);
 	if (fmt) {
 		struct va_format vaf;
 		va_list args;
@@ -148,12 +175,12 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
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
 
@@ -240,11 +267,15 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
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
2.30.2

