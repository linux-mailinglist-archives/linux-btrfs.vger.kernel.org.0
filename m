Return-Path: <linux-btrfs+bounces-7332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11D957BFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 05:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EAF1C23E9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAF44DA14;
	Tue, 20 Aug 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IOBsot69";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IOBsot69"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C21798C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125570; cv=none; b=e4c6cdhbyJUlRiyQN6M2mYomUhaSd2m4As3s3gADQpgd74OLKND/P9bglqcqHFSyM1f+v5pKBZrS0XqmdyvGuLydt622IBUsgCQTnYBweXBu2n1Odx8uLIlkv3CuVudtbTnXRbqX7V9hcCM6mUIBpAgzTWMfpV8IXiYOvbp9EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125570; c=relaxed/simple;
	bh=XUN/reqA87i5infzaM5anU0TAs51SWbtWNzb+xu+/HM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd5jG/SE2Zz5uVhtN0DmJY4rfaArmwHs3iU9TNSX5Pfwmi5mNKkAloB9gHzDugXQsowTk3tm39zJOSwihl77137yXJnHASXSOlrpywLzTk1Vdo2kawp8akZiDy48I1rQfMC39xLE9IyKFUsCS1oMHnOWp4oY8IWceTfTNGZ5x54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IOBsot69; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IOBsot69; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 733391FF6D
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOGuPqjpZEZVxzaIC/Dp9Db6hfgj0wGonKD1wWd3BkQ=;
	b=IOBsot69CabgOPJmTHnBiCbeleRMAm6Ma7kg6CqawVbIER4Jub/hCzEpmq6j9etK96hDYh
	af3rfaBCVIqElavPPZK22ZlRl60bAmqaV/ycLioXtOwW0BwKPhFM6npdm+5jttATxpFPAI
	Pay86HACN+2/zIKdjApBIZdlQ1kM4aU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IOBsot69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOGuPqjpZEZVxzaIC/Dp9Db6hfgj0wGonKD1wWd3BkQ=;
	b=IOBsot69CabgOPJmTHnBiCbeleRMAm6Ma7kg6CqawVbIER4Jub/hCzEpmq6j9etK96hDYh
	af3rfaBCVIqElavPPZK22ZlRl60bAmqaV/ycLioXtOwW0BwKPhFM6npdm+5jttATxpFPAI
	Pay86HACN+2/zIKdjApBIZdlQ1kM4aU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24F713AFE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEtPHXsRxGYbYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: mkfs-tests: add hardlink related tests for --subvol
Date: Tue, 20 Aug 2024 13:15:43 +0930
Message-ID: <0349bf78a0029b7596f3ba47e6defef1e949852f.1724125282.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724125282.git.wqu@suse.com>
References: <cover.1724125282.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 733391FF6D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_FAIL(0.00)[2a07:de40:b281:106:10:150:64:167:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This introduces two new cases:

- 3 hardlinks without any subvolume
  This should results 3 hard links inside the btrfs.

- 3 hardlinks, but a subvolume will split 2 of them
  Then the 2 inside the same subvolume should still report 2 nlinks,
  but the lone one inside the new subvolume can only report 1 nlink.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c                              |  8 +--
 tests/mkfs-tests/036-rootdir-subvol/test.sh | 78 +++++++++++++++++----
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index e1ca00f57e60..a24afe0715bb 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -721,7 +721,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	parent = rootdir_path_last(&current_path);
 	root = parent->root;
 
-	/* For non-directory inode, check if there is already any hard link. */
+	/* Check if there is already a hard link record for this. */
 	if (have_hard_links) {
 		struct hardlink_entry *found;
 
@@ -767,6 +767,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		error("failed to insert inode item %llu for '%s': %m", ino, full_path);
 		return ret;
 	}
+
 	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -778,10 +779,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		return ret;
 	}
 
-	/*
-	 * Found a possible hard link, add it into the hard link rb tree for
-	 * future detection.
-	 */
+	/* Record this new hard link. */
 	if (have_hard_links) {
 		ret = add_hard_link(root, ino, st);
 		if (ret < 0) {
diff --git a/tests/mkfs-tests/036-rootdir-subvol/test.sh b/tests/mkfs-tests/036-rootdir-subvol/test.sh
index 63ba928f348a..38491332170d 100755
--- a/tests/mkfs-tests/036-rootdir-subvol/test.sh
+++ b/tests/mkfs-tests/036-rootdir-subvol/test.sh
@@ -11,23 +11,75 @@ prepare_test_dev
 
 tmp=$(_mktemp_dir mkfs-rootdir)
 
-run_check touch "$tmp/foo"
-run_check mkdir "$tmp/dir"
-run_check mkdir "$tmp/dir/subvol"
-run_check touch "$tmp/dir/subvol/bar"
+basic()
+{
+	run_check touch "$tmp/foo"
+	run_check mkdir "$tmp/dir"
+	run_check mkdir "$tmp/dir/subvol"
+	run_check touch "$tmp/dir/subvol/bar"
 
-run_check_mkfs_test_dev --rootdir "$tmp" --subvol dir/subvol
-run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+	run_check_mkfs_test_dev --rootdir "$tmp" --subvol dir/subvol
+	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
 
-run_check_mount_test_dev
-run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" | \
+	run_check_mount_test_dev
+	run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list "$TEST_MNT" | \
 	cut -d\  -f9 > "$tmp/output"
-run_check_umount_test_dev
+	run_check_umount_test_dev
 
-result=$(cat "$tmp/output")
+	result=$(cat "$tmp/output")
 
-if [ "$result" != "dir/subvol" ]; then
-	_fail "dir/subvol not in subvolume list"
-fi
+	if [ "$result" != "dir/subvol" ]; then
+		_fail "dir/subvol not in subvolume list"
+	fi
+	rm -rf -- "$tmp/foo" "$tmp/dir"
+}
 
+basic_hardlinks()
+{
+	run_check touch "$tmp/hl1"
+	run_check ln "$tmp/hl1" "$tmp/hl2"
+	run_check mkdir "$tmp/dir"
+	run_check ln "$tmp/hl1" "$tmp/dir/hl3"
+
+	run_check_mkfs_test_dev --rootdir "$tmp"
+	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+	run_check_mount_test_dev
+	nr_hardlink=$(run_check_stdout $SUDO_HELPER stat -c "%h" "$TEST_MNT/hl1")
+
+	if [ "$nr_hardlink" -ne 3 ]; then
+		_fail "hard link number incorrect, has ${nr_hardlink} expect 3"
+	fi
+	run_check_umount_test_dev
+	rm -rf -- "$tmp/hl1" "$tmp/hl2" "$tmp/dir"
+}
+
+split_by_subvolume_hardlinks()
+{
+	run_check touch "$tmp/hl1"
+	run_check ln "$tmp/hl1" "$tmp/hl2"
+	run_check mkdir "$tmp/subv"
+	run_check ln "$tmp/hl1" "$tmp/subv/hl3"
+
+	run_check_mkfs_test_dev --rootdir "$tmp" --subvol subv
+	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+	run_check_mount_test_dev
+	nr_hardlink=$(run_check_stdout $SUDO_HELPER stat -c "%h" "$TEST_MNT/hl1")
+
+	if [ $nr_hardlink -ne 2 ]; then
+		_fail "hard link number incorrect for hl1, has ${nr_hardlink} expect 2"
+	fi
+
+	nr_hardlink=$(run_check_stdout $SUDO_HELPER stat -c "%h" "$TEST_MNT/subv/hl3")
+	if [ $nr_hardlink -ne 1 ]; then
+		_fail "hard link number incorrect for subv/hl3, has ${nr_hardlink} expect 1"
+	fi
+	run_check_umount_test_dev
+	rm -rf -- "$tmp/hl1" "$tmp/hl2" "$tmp/dir"
+}
+
+basic
+basic_hardlinks
+split_by_subvolume_hardlinks
 rm -rf -- "$tmp"
-- 
2.46.0


