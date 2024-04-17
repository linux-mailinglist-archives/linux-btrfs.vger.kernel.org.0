Return-Path: <linux-btrfs+bounces-4386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025F8A8F59
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E21F21A19
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9885C79;
	Wed, 17 Apr 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OcwCEOoM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OcwCEOoM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDC8563E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396747; cv=none; b=N26glpqOJFUm6bpRUX8GReeNTPMAoAEhcgtaIRZgEFLx3v5t024c5vogUSBJrzfziWNuZ2Kv2mw+VVvNzJQ8+lPMf9HVPb4cFOZUZ8lRDyQWrtX8ohdpxBSUy2p+R7luyMg7RbLa7bQxGhF5T3JV5GwnH7rFyE886EkbV1cuiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396747; c=relaxed/simple;
	bh=4n3t2GlMHVQraIyPu+MXOBf68xY1LJ6jLp3qJW8x5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5PiUIfyIgs8LvhVURRlsrSLVwOzPkhPyEyfMV6Vbyzv+K5ZlCqo3fBwBw1uyZLhoPFX3F+HKooVv56iVULHneUOsbcGat0xU5daNCKUKkr8LP+ttg7a6wgZMVE8v1zr7jt6h875BbdXdnK0pAASNNDEOaYlQq6zbvhUg+yfnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OcwCEOoM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OcwCEOoM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3E3D219D6;
	Wed, 17 Apr 2024 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713396743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2eoRoFyPdtY18y/12j9j4UKcyziQujtyeLvgGp2I+Gg=;
	b=OcwCEOoMA93Zydu3zq7VlWV1QzNWdedx+wcbQAMTsv/d99PitMvxIBhOakIJ5bawMBk/hn
	nl5AbGUdNZ+bg/ZUh9TNpVxyiOhZxPyiGTitXAydsjPvzcJ3PBI0vrh/DI02w9uJ3w1O8G
	+p3gNhArkLgFubgjI10e9l7rbQqDx8Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OcwCEOoM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713396743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2eoRoFyPdtY18y/12j9j4UKcyziQujtyeLvgGp2I+Gg=;
	b=OcwCEOoMA93Zydu3zq7VlWV1QzNWdedx+wcbQAMTsv/d99PitMvxIBhOakIJ5bawMBk/hn
	nl5AbGUdNZ+bg/ZUh9TNpVxyiOhZxPyiGTitXAydsjPvzcJ3PBI0vrh/DI02w9uJ3w1O8G
	+p3gNhArkLgFubgjI10e9l7rbQqDx8Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A25811384C;
	Wed, 17 Apr 2024 23:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PBSYJwdcIGbxfQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Apr 2024 23:32:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use btrfs_is_testing() everywhere
Date: Thu, 18 Apr 2024 01:24:52 +0200
Message-ID: <20240417232452.20839-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B3E3D219D6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

There are open coded tests of BTRFS_FS_STATE_DUMMY_FS_INFO and we have a
wrapper for that that's a compile-time constant when self-tests are not
built in. As this is only for development we can save some bytes and
conditions on release configs by using the helper in the remaining
cases.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c           | 4 ++--
 fs/btrfs/sysfs.c             | 8 ++++----
 fs/btrfs/tests/btrfs-tests.c | 3 +--
 fs/btrfs/tree-checker.c      | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2dc88f909b0..53e41e4871ce 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -646,7 +646,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
-	bool dummy = test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+	bool dummy = btrfs_is_testing(fs_info);
 
 	memset(&root->root_key, 0, sizeof(root->root_key));
 	memset(&root->root_item, 0, sizeof(root->root_item));
@@ -1076,7 +1076,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
 	 * For real fs, and not log/reloc trees, root owner must
 	 * match its root node owner
 	 */
-	if (!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state) &&
+	if (!btrfs_is_testing(fs_info) &&
 	    btrfs_root_id(root) != BTRFS_TREE_LOG_OBJECTID &&
 	    btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
 	    btrfs_root_id(root) != btrfs_header_owner(root->node)) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c6387a8ddb94..af545b6b1190 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2339,7 +2339,7 @@ int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
 	struct kobject *qgroups_kobj = fs_info->qgroups_kobj;
 	int ret;
 
-	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+	if (btrfs_is_testing(fs_info))
 		return 0;
 	if (qgroup->kobj.state_initialized)
 		return 0;
@@ -2360,7 +2360,7 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup *next;
 
-	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+	if (btrfs_is_testing(fs_info))
 		return;
 
 	rbtree_postorder_for_each_entry_safe(qgroup, next,
@@ -2381,7 +2381,7 @@ int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
 	struct btrfs_qgroup *next;
 	int ret = 0;
 
-	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+	if (btrfs_is_testing(fs_info))
 		return 0;
 
 	ASSERT(fsid_kobj);
@@ -2413,7 +2413,7 @@ int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
 void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
 				struct btrfs_qgroup *qgroup)
 {
-	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+	if (btrfs_is_testing(fs_info))
 		return;
 
 	if (qgroup->kobj.state_initialized) {
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 709c6cc9706a..dce0387ef155 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -160,8 +160,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	if (!fs_info)
 		return;
 
-	if (WARN_ON(!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO,
-			      &fs_info->fs_state)))
+	if (WARN_ON(!btrfs_is_testing(fs_info)))
 		return;
 
 	test_mnt->mnt_sb->s_fs_info = NULL;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c8fbcae4e88e..a127abbc09c3 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2021,7 +2021,7 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
 	 * Skip dummy fs, as selftests don't create unique ebs for each dummy
 	 * root.
 	 */
-	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_state))
+	if (btrfs_is_testing(eb->fs_info))
 		return 0;
 	/*
 	 * There are several call sites (backref walking, qgroup, and data
-- 
2.44.0


