Return-Path: <linux-btrfs+bounces-4792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC08BD9AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 05:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADCE284A39
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 03:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B404C618;
	Tue,  7 May 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMI8fHfs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMI8fHfs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02978821
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052200; cv=none; b=PlDcDnISNBMAbLhvcISTvB47+3TuiEizsCJtfeMyofKV477tJA43x4Q7in3WQjrwVNvmT0SennGbtSN1cyhT68jg+TUV6L8Z3hKn1fB5dMOlJFi4n2PfFykllXGsHneaTIU3musSSwmYzx2dgfZ87BJMqZ8uleoxMo7R6k+zm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052200; c=relaxed/simple;
	bh=RIxTV7mBvhwf/3gcxCxgYpg9WhniAqMHrcnYBlPi6VI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ6ZwO0fm1lH4TcO44qYzrV+ieCxxlvnOVd7iLzfiC1BPt/Rw2ibz2LKgfVVLGssdis8tIGe2ApmkVnCHxBahXtA9ydMvCI3rAqPvpkVeZuG5WY34/bCZ0DF13TdzBXUjU6q3wPPzH8zdX0MCKjAYrKIxolbsUWoRKMP60LY86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMI8fHfs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oMI8fHfs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9044633846
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joVqXMBOrfXjDMM60D6a2mctyQCU98Fi2QuJwv3Hc+8=;
	b=oMI8fHfs4Fw3Zai3hbWjIB6mhro6oX+bYDa8ANUzB8UCKQ5qW74cN25un3E1OX/aGLpMqM
	kKCIbEu0zwgpOS8XAp8OEdbUHeBcQCc6TuL7NJYS6UP8ZlHCl66FXzTKKQFb4RasBkeYbp
	OOiYbruGeJqhp99a98xCs0iGs3z4nfo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oMI8fHfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715052196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joVqXMBOrfXjDMM60D6a2mctyQCU98Fi2QuJwv3Hc+8=;
	b=oMI8fHfs4Fw3Zai3hbWjIB6mhro6oX+bYDa8ANUzB8UCKQ5qW74cN25un3E1OX/aGLpMqM
	kKCIbEu0zwgpOS8XAp8OEdbUHeBcQCc6TuL7NJYS6UP8ZlHCl66FXzTKKQFb4RasBkeYbp
	OOiYbruGeJqhp99a98xCs0iGs3z4nfo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B28FE13A2D
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 03:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yJnHF6OeOWa9WgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 03:23:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] Revert "btrfs-progs: convert: add raid-stripe-tree to allowed features"
Date: Tue,  7 May 2024 12:52:53 +0930
Message-ID: <1557b1ea70084d913d33daa883325cce5b45172b.1715051693.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715051693.git.wqu@suse.com>
References: <cover.1715051693.git.wqu@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9044633846
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

This reverts commit 346a3819237b319985ad6042d6302f67b040a803.

The RST feature (at least for now) is mostly for zoned devices to
support extra data profiles.

Thus btrfs-convert is never designed to handle RST, because there is no
way an ext4/reiserfs can even be created on a zoned device, or it would
create the correct RST tree root at all

Revert this unsupported feature to prevent false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.h                           |  3 +-
 tests/common.convert                          | 44 ++++---------------
 tests/convert-tests/001-ext2-basic/test.sh    |  2 +-
 tests/convert-tests/003-ext4-basic/test.sh    |  2 +-
 .../005-delete-all-rollback/test.sh           |  6 +--
 .../convert-tests/010-reiserfs-basic/test.sh  |  2 +-
 .../011-reiserfs-delete-all-rollback/test.sh  |  6 +--
 tests/convert-tests/024-ntfs-basic/test.sh    |  2 +-
 8 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 5b241bdf9122..f636171f6bd9 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -68,8 +68,7 @@ static const struct btrfs_mkfs_features btrfs_convert_allowed_features = {
 			   BTRFS_FEATURE_INCOMPAT_BIG_METADATA |
 			   BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |
 			   BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |
-			   BTRFS_FEATURE_INCOMPAT_NO_HOLES |
-			   BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE,
+			   BTRFS_FEATURE_INCOMPAT_NO_HOLES,
 	.runtime_flags   = BTRFS_FEATURE_RUNTIME_QUOTA,
 };
 
diff --git a/tests/common.convert b/tests/common.convert
index 06eec9b2a853..50d49a0d32da 100644
--- a/tests/common.convert
+++ b/tests/common.convert
@@ -214,47 +214,19 @@ convert_test_post_check_checksums() {
 		grep -q 'FAILED' && _fail "file validation failed"
 }
 
-# Check if convert can mount the image based on features
-# $1: name of the feature
-convert_can_mount() {
-	local features="$1"
-
-	if [ "$features" = 'block-group-tree' ]; then
-		if ! [ -f "/sys/fs/btrfs/features/block_group_tree" ]; then
-			_log "Skip mount checks due to missing support of block-group-tree"
-			return 1
-		fi
-	fi
-	if [ "$features" = 'raid-stripe-tree' ]; then
-		if ! [ -f "/sys/fs/btrfs/features/raid_stripe_tree" ]; then
-			_log "Skip mount checks due to missing support of raid-stripe-tree"
-			return 1
-		fi
-	fi
-
-	return 0
-}
-
 # post conversion checks, all three in one call, on an unmounted image
-# $1: features for mount compatibility checks
-# $2: file with checksums
-# $3: file with permissions.
-# $4: file with acl entries.
+# $1: file with checksums
+# $2: file with permissions.
+# $3: file with acl entries.
 convert_test_post_checks_all() {
-	local features="$1"
-
+	_assert_path "$1"
 	_assert_path "$2"
 	_assert_path "$3"
-	_assert_path "$4"
-
-	if ! convert_can_mount "$features"; then
-		return 0
-	fi
 
 	run_check_mount_test_dev
-	convert_test_post_check_checksums "$2"
-	convert_test_post_check_permissions "$3"
-	convert_test_post_check_acl "$4"
+	convert_test_post_check_checksums "$1"
+	convert_test_post_check_permissions "$2"
+	convert_test_post_check_acl "$3"
 
 	# Create a large file to trigger data chunk allocation
 	generate_dataset "large"
@@ -313,7 +285,7 @@ convert_test() {
 	run_check_umount_test_dev
 
 	convert_test_do_convert "$features" "$nodesize" "$fstype"
-	convert_test_post_checks_all "$features" "$CHECKSUMTMP" "$EXT_PERMTMP" "$EXT_ACLTMP"
+	convert_test_post_checks_all "$CHECKSUMTMP" "$EXT_PERMTMP" "$EXT_ACLTMP"
 	rm -- "$CHECKSUMTMP"
 	rm -- "$EXT_PERMTMP"
 	rm -- "$EXT_ACLTMP"
diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 461ff4a5f1a9..6dc105b55e27 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -12,7 +12,7 @@ check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree' ; do
 	convert_test ext2 "$feature" "ext2 4k nodesize" 4096 mke2fs -b 4096
 	convert_test ext2 "$feature" "ext2 16k nodesize" 16384 mke2fs -b 4096
 	convert_test ext2 "$feature" "ext2 64k nodesize" 65536 mke2fs -b 4096
diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index 14637fc852db..8ae5264cb340 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -12,7 +12,7 @@ check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree' ; do
+for feature in '' 'block-group-tree' ; do
 	convert_test ext4 "$feature" "ext4 4k nodesize" 4096 mke2fs -t ext4 -b 4096
 	convert_test ext4 "$feature" "ext4 16k nodesize" 16384 mke2fs -t ext4 -b 4096
 	convert_test ext4 "$feature" "ext4 64k nodesize" 65536 mke2fs -t ext4 -b 4096
diff --git a/tests/convert-tests/005-delete-all-rollback/test.sh b/tests/convert-tests/005-delete-all-rollback/test.sh
index 5603d3078bc8..fa56ca292bfc 100755
--- a/tests/convert-tests/005-delete-all-rollback/test.sh
+++ b/tests/convert-tests/005-delete-all-rollback/test.sh
@@ -38,10 +38,6 @@ do_test() {
 
 	convert_test_do_convert "$features" "$nodesize"
 
-	if ! convert_can_mount "$features"; then
-		return 0
-	fi
-
 	run_check_mount_test_dev
 	convert_test_post_check_checksums "$CHECKSUMTMP"
 
@@ -68,7 +64,7 @@ do_test() {
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree' ; do
+for feature in '' 'block-group-tree' ; do
 	do_test "$feature" "ext4 4k nodesize" 4096 mke2fs -t ext4 -b 4096
 	do_test "$feature" "ext4 16k nodesize" 16384 mke2fs -t ext4 -b 4096
 	do_test "$feature" "ext4 64k nodesize" 65536 mke2fs -t ext4 -b 4096
diff --git a/tests/convert-tests/010-reiserfs-basic/test.sh b/tests/convert-tests/010-reiserfs-basic/test.sh
index 6ab02b31d176..86b1826783b3 100755
--- a/tests/convert-tests/010-reiserfs-basic/test.sh
+++ b/tests/convert-tests/010-reiserfs-basic/test.sh
@@ -15,7 +15,7 @@ prepare_test_dev
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree' ; do
 	convert_test reiserfs "$feature" "reiserfs 4k nodesize" 4096 mkreiserfs -b 4096
 	convert_test reiserfs "$feature" "reiserfs 16k nodesize" 16384 mkreiserfs -b 4096
 	convert_test reiserfs "$feature" "reiserfs 64k nodesize" 65536 mkreiserfs -b 4096
diff --git a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
index 688613c2c6ad..e1c3e02eb7a0 100755
--- a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
+++ b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
@@ -40,10 +40,6 @@ do_test() {
 
 	convert_test_do_convert "$features" "$nodesize"
 
-	if ! convert_can_mount "$features"; then
-		return 0
-	fi
-
 	run_check_mount_test_dev
 	convert_test_post_check_checksums "$CHECKSUMTMP"
 
@@ -70,7 +66,7 @@ do_test() {
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree' ; do
 	do_test "$feature" "reiserfs 4k nodesize" 4096 mkreiserfs -b 4096
 	do_test "$feature" "reiserfs 16k nodesize" 16384 mkreiserfs -b 4096
 	do_test "$feature" "reiserfs 64k nodesize" 65536 mkreiserfs -b 4096
diff --git a/tests/convert-tests/024-ntfs-basic/test.sh b/tests/convert-tests/024-ntfs-basic/test.sh
index a93f60070674..d2e1be79ef6b 100755
--- a/tests/convert-tests/024-ntfs-basic/test.sh
+++ b/tests/convert-tests/024-ntfs-basic/test.sh
@@ -17,6 +17,6 @@ prepare_test_dev
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices. Test only 4K block size as minimum.
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree' ; do
 	convert_test ntfs "$feature" "ntfs 4k nodesize" 4096 mkfs.ntfs -s 4096
 done
-- 
2.45.0


