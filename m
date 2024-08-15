Return-Path: <linux-btrfs+bounces-7209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B402B952892
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 06:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01893B22E1B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 04:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA940862;
	Thu, 15 Aug 2024 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G5j/G7EM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dRjExN6f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FA39AE3
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723696734; cv=none; b=VZsLTB9SPAHrAodleDplYI6pKImB5FJJ/qMpd2/g8hduAyh/mTy+3xzp468iB2vMuqZuEsI4fPLr0KyfiB7R/zY+WR/wLwtPK6Y4RJlLE5u5+3sxINbwJYz7eUxPjoSUpzTA/lSmcowvKm5l2AFVBYcD/ecJ3pMquhrqArh0foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723696734; c=relaxed/simple;
	bh=gOcEdDdhCtMlf7bYeDfggDHJCySmcceqdIN1c8+f30Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwYeIMhA98QXw+rP9kMFcim7N26ROvW3jLjYWkWl3fDTDU554sEwROx+pb2uIN9c5jp6dCgh3QW8f0UOxnOm49imfoJJdX4ZpPuC8ee3EAJWLQrdB8wUt1qgWJUT66gNbR/PtjX3WlnGMU2sG7MLxsynAACht47EThsEVnLgRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G5j/G7EM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dRjExN6f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 442511FFAA
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSTrqZsyQhVGfpm87DlK6QCELa9pvck6rvkTTvDCGbY=;
	b=G5j/G7EMpkMmll4H5Fk9ayoZSR07xiJiapJ7I9VIl0Jg97PGZjy9QZksSIGmeXUHXhPooF
	vpRJx4vl+vLZ92dHfNlyKwpvZ74F+NeeGikt5TatvLQm02Zy0Egnb/Z3A/hnr6UbUH3Suu
	+qdJlCH4XygzrX9/eFzEil1v+XEKZsY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723696728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSTrqZsyQhVGfpm87DlK6QCELa9pvck6rvkTTvDCGbY=;
	b=dRjExN6fMWh3W2NP5JOTPEhiuHtlWLk5hrhPUHXAm+grjSCsrJlU82YR9pMicPU0bDM4Ci
	7WhhV0tGRKxeQNSFHsCYHziv/oYgLCdqIweZ323j4fJ9mFDL4FmRIMQBUNWmo+LhH8s2Qb
	Uw9hPmAMYimvlzCx5io1Bir2ugLWvLw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 685C013983
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CDcNCVeGvWaoPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 04:38:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: mkfs-tests: add hardlink related tests for --subvol
Date: Thu, 15 Aug 2024 14:08:18 +0930
Message-ID: <e2971b89126a16a0aa2831901cbe3a8ea5865f8d.1723696468.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723696468.git.wqu@suse.com>
References: <cover.1723696468.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
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
index 3da3c8247d08..0cb524b8040a 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -719,7 +719,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	parent = rootdir_path_last(&current_path);
 	root = parent->root;
 
-	/* For non-directory inode, check if there is already any hard link. */
+	/* Check if there is already a hard link record for this. */
 	if (have_hard_links) {
 		struct hardlink_entry *found;
 		found = find_hard_link(root, st);
@@ -764,6 +764,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 		error("failed to insert inode item %llu for '%s': %m", ino, full_path);
 		return ret;
 	}
+
 	ret = btrfs_add_link(g_trans, root, ino, parent->ino,
 			     full_path + ftwbuf->base,
 			     strlen(full_path) - ftwbuf->base,
@@ -775,10 +776,7 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
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
index 63ba928f348a..088004b1c227 100755
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
+	if [ $nr_hardlink -ne 3 ]; then
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


