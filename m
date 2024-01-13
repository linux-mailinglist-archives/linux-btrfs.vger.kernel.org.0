Return-Path: <linux-btrfs+bounces-1431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198082CA8F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325881C224E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C363B7;
	Sat, 13 Jan 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iktPLysm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iktPLysm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939D17EB
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C8DE22302
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQOLUmK4HcgSZNrAI1BQsy9N2LDLCDtgmOG0RMf2X/E=;
	b=iktPLysm/9/8gxzwuiDizgug0p4lpQIQbNy/u9awokW+0rZmPzqvRUzjZmRyWRTWmCa8to
	0/CyaXNh23Id1BR2jWMvsVy8REPmheIILYZtxtqMgJBZn4qb74cqu1CQkP3dmBgPKXK5It
	N8CPxSDhte85bH6wFawvLzG+jEAy8eY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705135557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQOLUmK4HcgSZNrAI1BQsy9N2LDLCDtgmOG0RMf2X/E=;
	b=iktPLysm/9/8gxzwuiDizgug0p4lpQIQbNy/u9awokW+0rZmPzqvRUzjZmRyWRTWmCa8to
	0/CyaXNh23Id1BR2jWMvsVy8REPmheIILYZtxtqMgJBZn4qb74cqu1CQkP3dmBgPKXK5It
	N8CPxSDhte85bH6wFawvLzG+jEAy8eY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BC3E13676
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CCIlEMRNomVLeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:45:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: convert-tests: trigger tree-checker more frequently
Date: Sat, 13 Jan 2024 19:15:31 +1030
Message-ID: <ab0d1243994c242fb321f775ed515670a71f7767.1705135055.git.wqu@suse.com>
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
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iktPLysm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
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
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 3C8DE22302
X-Spam-Flag: NO

Inspired by a recent bug report where a large ext4 fs can lead to
tree-checker warning on bad previous key objectid, we need a way to
trigger tree-checker more frequently to shake out hidden bugs.

This patch would set blocks_used threshold of btrfs-convert to 16K, and
global metadata cache size to 16K (instead of 1/4 of total memory) for
convert-tests/001 and convert-tests/003.

With those two small values, it's already enough to trigger the bad
previous key objectid bugs (without the proper fixes):

    [TEST/conv]   001-ext2-basic
    [TEST/conv]     ext2 4k nodesize, btrfs defaults
failed: /home/adam/btrfs-progs/btrfs-convert -N 4096 /home/adam/btrfs-progs/tests/test.img
test failed for case 001-ext2-basic

And the failure is exactly the reported one:

 Create ext2 image file
 Create btrfs metadata
 Copy inodes [o] [         0/       529]
 corrupt leaf: root=5 block=147079168 slot=25 ino=267, invalid previous key objectid, have 266 expect 267

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/convert-tests/001-ext2-basic/test.sh | 7 +++++++
 tests/convert-tests/003-ext4-basic/test.sh | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/convert-tests/001-ext2-basic/test.sh b/tests/convert-tests/001-ext2-basic/test.sh
index 6dc105b55e27..35bc39cee243 100755
--- a/tests/convert-tests/001-ext2-basic/test.sh
+++ b/tests/convert-tests/001-ext2-basic/test.sh
@@ -10,6 +10,13 @@ setup_root_helper
 prepare_test_dev
 check_kernel_support_acl
 
+# Extra finetunes to make btrfs-convert to commit transaction for each copied
+# inode, and keep cached tree blocks to minimal.
+# This is to ensure tree-checker is triggered for as many tree blocks as
+# possible, and expose any bad convert metadata behavior.
+export BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD=16K
+export BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE=16K
+
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
 for feature in '' 'block-group-tree' ; do
diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index 8ae5264cb340..64041d91fcb8 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -10,6 +10,13 @@ setup_root_helper
 prepare_test_dev
 check_kernel_support_acl
 
+# Extra finetunes to make btrfs-convert to commit transaction for each copied
+# inode, and keep cached tree blocks to minimal.
+# This is to ensure tree-checker is triggered for as many tree blocks as
+# possible, and expose any bad convert metadata behavior.
+export BTRFS_PROGS_DEBUG_BLOCKS_USED_THRESHOLD=16K
+export BTRFS_PROGS_DEBUG_METADATA_CACHE_SIZE=16K
+
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
 for feature in '' 'block-group-tree' ; do
-- 
2.43.0


