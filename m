Return-Path: <linux-btrfs+bounces-549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676E802BC2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 07:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB676280D18
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84AE944B;
	Mon,  4 Dec 2023 06:56:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B393F2
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 22:56:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1C661FE4F
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B07E213588
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kIW+FzF4bWXABwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 06:56:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check: remove inode cache clearing functionality
Date: Mon,  4 Dec 2023 17:26:27 +1030
Message-ID: <9ded4d71f4ab77ee4ed8d3ff31df839e85756def.1701672971.git.wqu@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: B1C661FE4F
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

Since we're already directing the end user to use "btrfs rescue
clear-ino-cache" command, there is not much need to support it in
btrfs-check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                                        |  12 ++----------
 .../060-ino-cache-clean}/ino-cache-enabled.raw.xz   | Bin
 .../060-ino-cache-clean}/test.sh                    |   2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)
 rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/ino-cache-enabled.raw.xz (100%)
 rename tests/{fsck-tests/046-ino-cache-clean => misc-tests/060-ino-cache-clean}/test.sh (97%)

diff --git a/check/main.c b/check/main.c
index 901a7ef5ebcb..30967fd426ca 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9994,7 +9994,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int init_csum_tree = 0;
 	int readonly = 0;
 	int clear_space_cache = 0;
-	int clear_ino_cache = 0;
 	int qgroup_report = 0;
 	int qgroups_repaired = 0;
 	int qgroup_verify_ret;
@@ -10118,8 +10117,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				ctree_flags |= OPEN_CTREE_WRITES;
 				break;
 			case GETOPT_VAL_CLEAR_INO_CACHE:
-				clear_ino_cache = 1;
-				ctree_flags |= OPEN_CTREE_WRITES;
+				error("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead");
+				exit(1);
 				break;
 			case GETOPT_VAL_FORCE:
 				force = 1;
@@ -10240,13 +10239,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		goto close_out;
 	}
 
-	if (clear_ino_cache) {
-		warning("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead");
-		ret = clear_ino_cache_items(gfs_info);
-		err = ret;
-		goto close_out;
-	}
-
 	/*
 	 * repair mode will force us to commit transaction which
 	 * will make us fail to load log tree when mounting.
diff --git a/tests/fsck-tests/046-ino-cache-clean/ino-cache-enabled.raw.xz b/tests/misc-tests/060-ino-cache-clean/ino-cache-enabled.raw.xz
similarity index 100%
rename from tests/fsck-tests/046-ino-cache-clean/ino-cache-enabled.raw.xz
rename to tests/misc-tests/060-ino-cache-clean/ino-cache-enabled.raw.xz
diff --git a/tests/fsck-tests/046-ino-cache-clean/test.sh b/tests/misc-tests/060-ino-cache-clean/test.sh
similarity index 97%
rename from tests/fsck-tests/046-ino-cache-clean/test.sh
rename to tests/misc-tests/060-ino-cache-clean/test.sh
index cfbadf251d30..10b75cc5f5b0 100755
--- a/tests/fsck-tests/046-ino-cache-clean/test.sh
+++ b/tests/misc-tests/060-ino-cache-clean/test.sh
@@ -9,7 +9,7 @@ setup_root_helper
 
 image=$(extract_image "./ino-cache-enabled.raw.xz")
 
-run_check "$TOP/btrfs" check --clear-ino-cache "$image"
+run_check "$TOP/btrfs" rescue clear-ino-cache "$image"
 run_check "$TOP/btrfs" check "$image"
 
 # Check for FREE_INO items for toplevel subvol
-- 
2.43.0


