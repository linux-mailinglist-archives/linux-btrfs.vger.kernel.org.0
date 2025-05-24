Return-Path: <linux-btrfs+bounces-14205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBADAC2D09
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EA54E1F8C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B301991CF;
	Sat, 24 May 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p836m6eg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p836m6eg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83516A956
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052545; cv=none; b=IiYAdFqG2SkCD18Jt2QfiDPFy+iBuWUcaBFSLAZjq3p39kEPqNu6a4lE9W8VI0G4HDytACUsCyn4awhsMXcZLxpZ+fU8LHM8FszhjiEG6mTsgyxJxzFNYBh2uVVSslcMgR9TcajehSCgREZqbaiVx5RbtF04Af4PyQxURnL0oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052545; c=relaxed/simple;
	bh=VkkxUpp7LQkKme6lg0P4lVFBEiepJd5o/unzI/AL3cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srmN5YMXeIuHpYvIsTNxKQm4peT+ZwK9J1SEmPuo3jX2NtdWHLY1pysSpsYd/kX4viKUSRkWAzjEmePuHKZetIYB4jvKyzbLKiZV5TmbrS1A/UnfScgZeqrgKMh+py1KpW9b91KLwvj4jv5jZ62CNAd0pF3zlaXdV4nBujjOook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p836m6eg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p836m6eg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE36E211A1
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+297L+TNXjxU0/VtfqN2YoYUi8PUpb8Ngg9GQbfGuQ=;
	b=p836m6eg7zKdnszLz/UolWpjyeIgUBeDGgNI2TtNrylz+XZ/ewLze49wYCNLnSieuvSZiY
	mdigLDASQ/1p2z78wy2E3tZL6LpHHfdXPyKP7eJCYa9sr7b0zJmM0s6d4ctwGeZ3PqzV3f
	RLsThzN3z0BuvalnrclTKlHHr+jaKT8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+297L+TNXjxU0/VtfqN2YoYUi8PUpb8Ngg9GQbfGuQ=;
	b=p836m6eg7zKdnszLz/UolWpjyeIgUBeDGgNI2TtNrylz+XZ/ewLze49wYCNLnSieuvSZiY
	mdigLDASQ/1p2z78wy2E3tZL6LpHHfdXPyKP7eJCYa9sr7b0zJmM0s6d4ctwGeZ3PqzV3f
	RLsThzN3z0BuvalnrclTKlHHr+jaKT8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BCD11373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJ9DNCwqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs-progs: convert-tests: add a test case for bgt feature
Date: Sat, 24 May 2025 11:38:15 +0930
Message-ID: <3998a6cb74eb0d578ab19690fa4bf6e8a380acb3.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Previously "btrfs-convert -O bgt" will not cause any error, but the
results fs has no block-group-tree feature at all, making it no
different than "btrfs-convert -O ^bgt".

This is a big bug that never caught by our existing convert runs.
001-ext2-basic and 003-ext4-basic all tested bgt feature, but doesn't
really check if the resulted fs really have bgt flags set.

To patch the hole, add a new test case, which will do the regular bgt
convert, but at the end also do a super block dump and verify the
BLOCK_GROUP_TREE flag is properly set.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../028-block-group-tree/test.sh              | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 tests/convert-tests/028-block-group-tree/test.sh

diff --git a/tests/convert-tests/028-block-group-tree/test.sh b/tests/convert-tests/028-block-group-tree/test.sh
new file mode 100755
index 000000000000..7b30ac7de7ae
--- /dev/null
+++ b/tests/convert-tests/028-block-group-tree/test.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# Make sure btrfs-convert can create a fs with bgt feature.
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+setup_root_helper
+prepare_test_dev
+
+check_global_prereq mkfs.ext4
+check_prereq btrfs-convert
+check_prereq btrfs
+
+convert_test_prep_fs ext4 mke2fs -t ext4 -b 4096
+run_check_umount_test_dev
+convert_test_do_convert bgt 16384
+
+# Manually check the super block to make sure it has BGT flag.
+run_check_stdout "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV" |\
+	grep -q "BLOCK_GROUP_TREE" || _fail "No block-group-tree feature enabled"
-- 
2.49.0


