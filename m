Return-Path: <linux-btrfs+bounces-550-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4B8802BC3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 07:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808941C209C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80D947A;
	Mon,  4 Dec 2023 06:56:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284ED3
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 22:56:55 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5377D21F76
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:54 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5325C13588
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IB/tADV4bWXABwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 06:56:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: tune: add fsck runs before and after a full conversion
Date: Mon,  4 Dec 2023 17:26:29 +1030
Message-ID: <f919ead47c266bbb4c24ba873e565e4c36b9377a.1701672971.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701672971.git.wqu@suse.com>
References: <cover.1701672971.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.50
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=fail (smtp-out1.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 5377D21F76
X-Spamd-Result: default: False [21.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

We have two bug reports in the mailing list around block group tree
conversion.

Although currently there is still no strong evidence showing btrfstune
is the culprit yet, I still want to be extra cautious.

This patch would add an extra safenet for the end users, that a full
readonly btrfs check would be executed on the filesystem before doing
any full fs conversion (including bg/extent tree and csum conversion).

This can catch any existing health problem of the filesystem.

Furthermore, after the conversion is done, there would also be a "btrfs
check" run, to make sure the conversion itself is fine, to make sure we
have done everything to make sure the problem is not from our side.

One thing to note is, the initial check would only happen on a source
filesystem which is not under any existing conversion.
As a fs already under conversion can easily trigger btrfs check false
alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile    |  3 ++-
 tune/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 374f59b99150..47c6421781f3 100644
--- a/Makefile
+++ b/Makefile
@@ -267,7 +267,8 @@ mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
 image_objects = image/main.o image/sanitize.o image/image-create.o image/common.o \
 		image/image-restore.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
-	       tune/convert-bgt.o tune/change-csum.o common/clear-cache.o tune/quota.o
+	       tune/convert-bgt.o tune/change-csum.o common/clear-cache.o tune/quota.o \
+	       check/main.o check/mode-common.o check/mode-lowmem.o mkfs/common.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
diff --git a/tune/main.c b/tune/main.c
index 9dcb55952b59..f05ab7c3b36e 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -29,6 +29,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/free-space-tree.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "common/open-utils.h"
 #include "common/device-scan.h"
@@ -367,6 +368,47 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (change_metadata_uuid || random_fsid || new_fsid_str)
 		ctree_flags |= OPEN_CTREE_USE_LATEST_BDEV;
 
+	/*
+	 * For fs rewrites operations, we need to verify the initial
+	 * filesystem to make sure they are healthy.
+	 * Otherwise the transaction protection is not going to save us.
+	 */
+	if (to_bg_tree || to_extent_tree || csum_type != -1) {
+		struct btrfs_super_block sb = { 0 };
+		u64 sb_flags;
+
+		/*
+		 * Here we just read out the superblock without any extra check,
+		 * as later btrfs_check() would do more comprehensive check on
+		 * it.
+		 */
+		ret = sbread(fd, &sb, 0);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to read super block from \"%s\"", device);
+			goto free_out;
+		}
+		sb_flags = btrfs_super_flags(&sb);
+		/*
+		 * If we're not resuming the conversion, we should check the fs
+		 * first.
+		 */
+		if (!(sb_flags & (BTRFS_SUPER_FLAG_CHANGING_BG_TREE |
+				  BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+				  BTRFS_SUPER_FLAG_CHANGING_META_CSUM))) {
+			bool check_ret;
+			struct btrfs_check_options options =
+				btrfs_default_check_options;
+
+			check_ret = btrfs_check(device, &options);
+			if (check_ret) {
+				error(
+		"\"btrfs check\" found some errors, will not touch the filesystem");
+				ret = -EUCLEAN;
+				goto free_out;
+			}
+		}
+	}
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
@@ -535,6 +577,19 @@ out:
 	}
 	close_ctree(root);
 	btrfs_close_all_devices();
+	/* A sucessful run finished, let's verify the fs again. */
+	if (!ret && (to_bg_tree || to_extent_tree || csum_type)) {
+		bool check_ret;
+		struct btrfs_check_options options = btrfs_default_check_options;
+
+		check_ret = btrfs_check(device, &options);
+		if (check_ret) {
+			error(
+	"\"btrfs check\" found some errors after the conversion, please contact the developers");
+			ret = -EUCLEAN;
+		}
+
+	}
 
 free_out:
 	return ret;
-- 
2.43.0


