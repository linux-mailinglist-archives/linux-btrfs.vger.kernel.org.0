Return-Path: <linux-btrfs+bounces-1429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6D82CA8E
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736841F233B3
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B49185A;
	Sat, 13 Jan 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rrpCQV/B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rrpCQV/B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2A384
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D331D22300
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd8C5R+MoZXv/XRzZ7zT9HELV0cOVxC5Slc7NI+9UMY=;
	b=rrpCQV/BIqlJcxYO1iUuaXKia7eaHQMvIU+zndsxOwGyGYTvehm0/CSS9pA2yZDqppfLLK
	ZQpePP6VjvCua4lXHI1owPW9gXBcnzMdFQ/dvPFAlalntjQFhrsVItwmYz7XRDBoF0dXrE
	HesyzjV95zmqwk5WqeLNi3joB3baxKs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd8C5R+MoZXv/XRzZ7zT9HELV0cOVxC5Slc7NI+9UMY=;
	b=rrpCQV/BIqlJcxYO1iUuaXKia7eaHQMvIU+zndsxOwGyGYTvehm0/CSS9pA2yZDqppfLLK
	ZQpePP6VjvCua4lXHI1owPW9gXBcnzMdFQ/dvPFAlalntjQFhrsVItwmYz7XRDBoF0dXrE
	HesyzjV95zmqwk5WqeLNi3joB3baxKs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FB4713676
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPIoNcFNomVLeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: convert/ext2: new debug environment variable to finetune transaction size
Date: Sat, 13 Jan 2024 19:15:29 +1030
Message-ID: <4c2f12dc417a192f4acfd804831401aadeeb9c42.1705135055.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705135055.git.wqu@suse.com>
References: <cover.1705135055.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Since we got a recent bug report about tree-checker triggered for large
fs conversion, we need a properly way to trigger the problem for test
case purpose.

To trigger that bug, we need to meet several conditions:

- We need to read some tree blocks which has half-backed inodes
- We need a large enough enough fs to generate more tree blocks than
  our cache.

  For our existing test cases, firstly the fs is not that large, thus
  we may even go just one transaction to generate all the inodes.

  Secondly we have a global cache for tree blocks, which means a lot of
  written tree blocks are still in the cache, thus won't trigger
  tree-checker.

To make the problem much easier for our existing test case to expose,
this patch would introduce a debug environment variable:
BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD.

This would affects the threshold for the transaction size, setting it to
a much smaller value would make the bug much easier to trigger.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c        | 62 +++++++++++++++++++++++++++++++++++++++++++
 common/utils.h        |  1 +
 convert/source-ext2.c |  9 ++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/common/utils.c b/common/utils.c
index 62f0e3f48b39..e6070791f5cc 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -956,6 +956,68 @@ u8 rand_u8(void)
 	return (u8)(rand_u32());
 }
 
+/*
+ * Parse a u64 value from an environment variable.
+ *
+ * Supports unit suffixes "KMGTP", the suffix is always 2 ** 10 based.
+ * With proper overflow detection.
+ *
+ * The string must end with '\0', anything unexpected non-suffix string,
+ * including space, would lead to -EINVAL and no value updated.
+ */
+int get_env_u64(const char *env_name, u64 *value_ret)
+{
+	char *env_value_str;
+	char *retptr = NULL;
+	int shift = 0;
+	u64 value;
+
+	env_value_str = getenv(env_name);
+	if (!env_value_str)
+		return -ENOENT;
+	value = strtoull(env_value_str, &retptr, 0);
+	/* No numeric string found. */
+	if (retptr == env_value_str)
+		return -EINVAL;
+	if (value == ULLONG_MAX && errno == ERANGE)
+		return -ERANGE;
+	/* memparse_safe() like suffix detection. */
+	switch (*retptr) {
+		case 'K':
+		case 'k':
+			shift = 10;
+			break;
+		case 'M':
+		case 'm':
+			shift = 20;
+			break;
+		case 'G':
+		case 'g':
+			shift = 30;
+			break;
+		case 'T':
+		case 't':
+			shift = 40;
+			break;
+		case 'P':
+		case 'p':
+			shift = 50;
+			break;
+	}
+	if (shift) {
+		retptr++;
+		if (value >> (64 - shift))
+			return -ERANGE;
+		value <<= shift;
+	}
+	if (*retptr != '\0')
+		return -EINVAL;
+	pr_verbose(LOG_VERBOSE, "received env \"%s\" value %llu\n",
+		   env_name, value);
+	*value_ret = value;
+	return 0;
+}
+
 void btrfs_config_init(void)
 {
 	bconf.output_format = CMD_FORMAT_TEXT;
diff --git a/common/utils.h b/common/utils.h
index dcd817144f9c..30c75339b05b 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -132,6 +132,7 @@ u32 rand_u32(void);
 u64 rand_u64(void);
 unsigned int rand_range(unsigned int upper);
 void init_rand_seed(u64 seed);
+int get_env_u64(const char *env_name, u64 *value_ret);
 
 char *btrfs_test_for_multiple_profiles(int fd);
 int btrfs_warn_multiple_profiles(int fd);
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index f56d79734715..e5f85111a711 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -30,6 +30,7 @@
 #include "kernel-shared/file-item.h"
 #include "common/extent-cache.h"
 #include "common/messages.h"
+#include "common/utils.h"
 #include "convert/common.h"
 #include "convert/source-fs.h"
 #include "convert/source-ext2.h"
@@ -974,6 +975,11 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 	ext2_ino_t ext2_ino;
 	u64 objectid;
 	struct btrfs_trans_handle *trans;
+	/* The hint on when to commit the transaction. */
+	u64 blocks_used_threshold = SZ_2M;
+
+	get_env_u64("BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD",
+		    &blocks_used_threshold);
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
@@ -1014,7 +1020,8 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		 * large enough to contain over 300 inlined files or
 		 * around 26k file extents. Which should be good enough.
 		 */
-		if (trans->blocks_used >= SZ_2M / root->fs_info->nodesize) {
+		if (trans->blocks_used >=
+		    (blocks_used_threshold / root->fs_info->nodesize)) {
 			ret = btrfs_commit_transaction(trans, root);
 			if (ret < 0) {
 				errno = -ret;
-- 
2.43.0


