Return-Path: <linux-btrfs+bounces-5690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C5B905FAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7728A1C2101A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F51A79DF;
	Thu, 13 Jun 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cd22YuAF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cd22YuAF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE44C6B
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238234; cv=none; b=oTQysP7PI1Qh4AZuD8XpItGEo81pApLvI4a6OK4lGFdC7/9ctIj0wqlQF457OgmzzFWbggsqXHQ/axg22XdtgA2DIjvEQFT7gxcWJMnv6d7Y7rZk59otZO/1yAagY/NFHSU/wgeumi45GHhhBWYte82crm372U8AT0Fzrlh7g80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238234; c=relaxed/simple;
	bh=buF6jFoxf+MlSdtGbdonIrR9tbjgDK5vIgjiIFQptgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt7jV7EBSeMCTPu2YYOab/DPyS4xy8esg6wCW20GhPjCGkuvXxMoCfQxc+LVlDbODcsoTJiP3h2fGyboybuFiLeK2kgOdlXBvSi7bp+3dxULL4r0DLM1HOKISqJtZOkwh2+p6+uXycPrjS3cig7jtxx7gy9uxHccYwwSIcTR4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cd22YuAF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cd22YuAF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82CC734B7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCT5E8awkjyh4X+jBIyuiArcOsYyb0Z5JPh6puWXozk=;
	b=cd22YuAFsQwfGZHoihTiLQqc+qPMipTVX8knoCEybwL64afTM3MlB1s+tQw2PZI4CCjAtN
	GzXkN38wyBbGu5W1H2mH2ksI83SNdQEfIXmjM9raqlLlHWgo5UcGMK1IZIWasqmjJYFlzM
	OUgGPmYVDpQffZdEF4Xcquzv7FdxyO4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cd22YuAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718238230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCT5E8awkjyh4X+jBIyuiArcOsYyb0Z5JPh6puWXozk=;
	b=cd22YuAFsQwfGZHoihTiLQqc+qPMipTVX8knoCEybwL64afTM3MlB1s+tQw2PZI4CCjAtN
	GzXkN38wyBbGu5W1H2mH2ksI83SNdQEfIXmjM9raqlLlHWgo5UcGMK1IZIWasqmjJYFlzM
	OUgGPmYVDpQffZdEF4Xcquzv7FdxyO4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90CDC13A7F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2NUsERU8amY9YQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:23:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: convert: remove raid-stripe-tree support
Date: Thu, 13 Jun 2024 09:53:22 +0930
Message-ID: <10ba4a99e2530189415822f088cee6c8de95e17b.1718238120.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718238120.git.wqu@suse.com>
References: <cover.1718238120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82CC734B7F
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

The raid-stripe-tree (RST) feature is for zoned devices to support extra
data profiles, and is not yet a stable feature (still requires
CONFIG_BTRFS_DEBUG enabled kernel to support it).

Furthermore the supported filesystems (ext*, reiserfs and ntfs) doesn't
even support zoned devices, and even we force RST support for
btrfs-convert, we would only create an empty tree for RST, as btrfs
convert would only result SINGLE data profile with SINGLE/DUP metadata
profile, neither needs RST at all.

Meanwhile enabling RST for btrfs-convert would only cause problems for
false test failures as we incorrectly allow RST feature for
btrfs-convert.

This patch fixes the problem by remove raid-stripe-tree support from
btrfs-convert and remove the test cases support for RST.

This patch is mostly reverting commit 346a3819237b ("btrfs-progs:
convert: add raid-stripe-tree to allowed features"), but keeps the test
infrastructure to support bgt features for convert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.h                                          | 3 +--
 tests/convert-tests/001-ext2-basic/test.sh                   | 2 +-
 tests/convert-tests/003-ext4-basic/test.sh                   | 2 +-
 tests/convert-tests/005-delete-all-rollback/test.sh          | 2 +-
 tests/convert-tests/010-reiserfs-basic/test.sh               | 2 +-
 tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh | 2 +-
 tests/convert-tests/024-ntfs-basic/test.sh                   | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

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
 
diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 461ff4a5f1a9..d905ed4aeecb 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -12,7 +12,7 @@ check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree'; do
 	convert_test ext2 "$feature" "ext2 4k nodesize" 4096 mke2fs -b 4096
 	convert_test ext2 "$feature" "ext2 16k nodesize" 16384 mke2fs -b 4096
 	convert_test ext2 "$feature" "ext2 64k nodesize" 65536 mke2fs -b 4096
diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index 14637fc852db..83a2cf12425c 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -12,7 +12,7 @@ check_kernel_support_acl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree' ; do
+for feature in '' 'block-group-tree'; do
 	convert_test ext4 "$feature" "ext4 4k nodesize" 4096 mke2fs -t ext4 -b 4096
 	convert_test ext4 "$feature" "ext4 16k nodesize" 16384 mke2fs -t ext4 -b 4096
 	convert_test ext4 "$feature" "ext4 64k nodesize" 65536 mke2fs -t ext4 -b 4096
diff --git a/tests/convert-tests/005-delete-all-rollback/test.sh b/tests/convert-tests/005-delete-all-rollback/test.sh
index 5603d3078bc8..536d0313ffdc 100755
--- a/tests/convert-tests/005-delete-all-rollback/test.sh
+++ b/tests/convert-tests/005-delete-all-rollback/test.sh
@@ -68,7 +68,7 @@ do_test() {
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree' ; do
+for feature in '' 'block-group-tree'; do
 	do_test "$feature" "ext4 4k nodesize" 4096 mke2fs -t ext4 -b 4096
 	do_test "$feature" "ext4 16k nodesize" 16384 mke2fs -t ext4 -b 4096
 	do_test "$feature" "ext4 64k nodesize" 65536 mke2fs -t ext4 -b 4096
diff --git a/tests/convert-tests/010-reiserfs-basic/test.sh b/tests/convert-tests/010-reiserfs-basic/test.sh
index 6ab02b31d176..67e818b9827d 100755
--- a/tests/convert-tests/010-reiserfs-basic/test.sh
+++ b/tests/convert-tests/010-reiserfs-basic/test.sh
@@ -15,7 +15,7 @@ prepare_test_dev
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree'; do
 	convert_test reiserfs "$feature" "reiserfs 4k nodesize" 4096 mkreiserfs -b 4096
 	convert_test reiserfs "$feature" "reiserfs 16k nodesize" 16384 mkreiserfs -b 4096
 	convert_test reiserfs "$feature" "reiserfs 64k nodesize" 65536 mkreiserfs -b 4096
diff --git a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
index 688613c2c6ad..d874422659a6 100755
--- a/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
+++ b/tests/convert-tests/011-reiserfs-delete-all-rollback/test.sh
@@ -70,7 +70,7 @@ do_test() {
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree'; do
 	do_test "$feature" "reiserfs 4k nodesize" 4096 mkreiserfs -b 4096
 	do_test "$feature" "reiserfs 16k nodesize" 16384 mkreiserfs -b 4096
 	do_test "$feature" "reiserfs 64k nodesize" 65536 mkreiserfs -b 4096
diff --git a/tests/convert-tests/024-ntfs-basic/test.sh b/tests/convert-tests/024-ntfs-basic/test.sh
index a93f60070674..b88dbe29c356 100755
--- a/tests/convert-tests/024-ntfs-basic/test.sh
+++ b/tests/convert-tests/024-ntfs-basic/test.sh
@@ -17,6 +17,6 @@ prepare_test_dev
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices. Test only 4K block size as minimum.
-for feature in '' 'block-group-tree' 'raid-stripe-tree'; do
+for feature in '' 'block-group-tree'; do
 	convert_test ntfs "$feature" "ntfs 4k nodesize" 4096 mkfs.ntfs -s 4096
 done
-- 
2.45.2


