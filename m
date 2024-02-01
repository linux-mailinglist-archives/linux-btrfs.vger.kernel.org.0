Return-Path: <linux-btrfs+bounces-2029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A7845F50
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531BC1C26F3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2C84037;
	Thu,  1 Feb 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OId2ipZZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OId2ipZZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4E12FB29
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810573; cv=none; b=kp9U2TpajSFHmLbN3k+Sx/h+vy+HN7dAonC+6rlF2gvW61tEeocYJ7GTeFCuelOFzDobuJ5QFyTuIJtz4yfz4aQaAZBp0pnpLwLoHvFKDy8uLXZ+0Dyg3WD7kcj3Czsfr1beLBzYeGkQo/p3pMGJJlPL/SaV+Lp81AlVKIjBBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810573; c=relaxed/simple;
	bh=pjAErizqu19BQNcYPTxh/Y3Fzs0fSK1pILF1rpY2dxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxvrDDaYHzjL/0nvVTZFtBLxxMLzHSa6fZa0JWrQOWYFLWEBlf/k0d8RPJFNZGuMiqEgeEOzOi9rN68YRtu0innh9EQ81Y0QbZQ4vXQ3wbEyctjh7uABYfQ4h4akAQuLKUTwa30KzVWu2aBtL4p7gsxk9R5/RCG2N1lTA8FWyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OId2ipZZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OId2ipZZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43A4121F47;
	Thu,  1 Feb 2024 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DL5yGIkRDAapo1WEbyzViaB5xZEhiaPei0rw6UXGEI4=;
	b=OId2ipZZ8doN+QFMfWSwUqrZakGOCK7WMSVdM+QR36lMuRD8tgv4TI+Osyclu1VNzsLwfb
	peeg0Glz5wNqLRGNDRj++Ax2ttMWvRCwfdJNpv5gXfsLauXTzHl1JsDatJSUxw/8xiSlQm
	G7oO/mBTUlyvEkU7kjEf0fM5ICqSe2E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706810569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DL5yGIkRDAapo1WEbyzViaB5xZEhiaPei0rw6UXGEI4=;
	b=OId2ipZZ8doN+QFMfWSwUqrZakGOCK7WMSVdM+QR36lMuRD8tgv4TI+Osyclu1VNzsLwfb
	peeg0Glz5wNqLRGNDRj++Ax2ttMWvRCwfdJNpv5gXfsLauXTzHl1JsDatJSUxw/8xiSlQm
	G7oO/mBTUlyvEkU7kjEf0fM5ICqSe2E=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D0DF13594;
	Thu,  1 Feb 2024 18:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ASLlDsncu2WkTwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 01 Feb 2024 18:02:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
Date: Thu,  1 Feb 2024 19:02:23 +0100
Message-ID: <f5a83f81ac4e3c87062714cb4e67eb1acf0724d3.1706810422.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706810422.git.dsterba@suse.com>
References: <cover.1706810422.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.58%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Allocate fs_info and root to have a valid fs_info pointer in case it's
dereferenced by a helper outside of tests, like find_lock_delalloc_range().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 25b3349595e0..865d4af4b303 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -11,6 +11,7 @@
 #include "btrfs-tests.h"
 #include "../ctree.h"
 #include "../extent_io.h"
+#include "../disk-io.h"
 #include "../btrfs_inode.h"
 
 #define PROCESS_UNLOCK		(1 << 0)
@@ -105,9 +106,11 @@ static void dump_extent_io_tree(const struct extent_io_tree *tree)
 	}
 }
 
-static int test_find_delalloc(u32 sectorsize)
+static int test_find_delalloc(u32 sectorsize, u32 nodesize)
 {
-	struct inode *inode;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root = NULL;
+	struct inode *inode = NULL;
 	struct extent_io_tree *tmp;
 	struct page *page;
 	struct page *locked_page = NULL;
@@ -121,12 +124,27 @@ static int test_find_delalloc(u32 sectorsize)
 
 	test_msg("running find delalloc tests");
 
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	root = btrfs_alloc_dummy_root(fs_info);
+	if (IS_ERR(root)) {
+		test_std_err(TEST_ALLOC_ROOT);
+		ret = PTR_ERR(root);
+		goto out;
+	}
+
 	inode = btrfs_new_test_inode();
 	if (!inode) {
 		test_std_err(TEST_ALLOC_INODE);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	tmp = &BTRFS_I(inode)->io_tree;
+	BTRFS_I(inode)->root = root;
 
 	/*
 	 * Passing NULL as we don't have fs_info but tracepoints are not used
@@ -316,6 +334,8 @@ static int test_find_delalloc(u32 sectorsize)
 	process_page_range(inode, 0, total_dirty - 1,
 			   PROCESS_UNLOCK | PROCESS_RELEASE);
 	iput(inode);
+	btrfs_free_dummy_root(root);
+	btrfs_free_dummy_fs_info(fs_info);
 	return ret;
 }
 
@@ -794,7 +814,7 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 
 	test_msg("running extent I/O tests");
 
-	ret = test_find_delalloc(sectorsize);
+	ret = test_find_delalloc(sectorsize, nodesize);
 	if (ret)
 		goto out;
 
-- 
2.42.1


