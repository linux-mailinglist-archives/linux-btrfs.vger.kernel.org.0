Return-Path: <linux-btrfs+bounces-7780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF99969570
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F391C23212
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173BC1D6DB6;
	Tue,  3 Sep 2024 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WGr5FNji";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WGr5FNji"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC761D6DBA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348570; cv=none; b=GZcg6TZVib9eaYdnb8zF+s4feQj3QKTciVrbVEhAX2O1V+0M9GhU6ZF5FNoKpHdFRjWCTQK6++79Cnm7/7n2teqNPnbWUlRwHkfpF5HVrt++T0ZtJmi+zsMULiyGCa4Z3/6jBLbEtO1SPlrUBe70GEE0Eu9IMQcEnLxug1aIEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348570; c=relaxed/simple;
	bh=0g4lMkQBFrv4bXsndjTgh5Bo5C4a1pwOcPhhkH5ovvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/o/Biku4jLujpqUTW94FpzoxMg2+hcEWCvppQVhkwUaYXVtj3UuLBAYHDqJRJusyhnZfCyRSg7BrZGpVPX+56bhT96GhVwbEILdIQH1iDKWcnRjDTBhb4wte3zDMbS7mCG4ySIoTyqXzzeBTaswHjIY8EQ+K+lzM3H9RW7IUs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WGr5FNji; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WGr5FNji; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76EBE21A79
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3Yxigyi1LYdEAywnUWC/5LsywGBwXbC7kGFyVkwqpI=;
	b=WGr5FNjim1tq4v7Z6EwdiIel6gmvJQ2xioBaRttWB+dMJv7RHwUih4punClqtiI6zNMsuN
	kfb79D+O3I3eqj0a0mLUkL+Wq4WVzn5PAt6ZntFFkSMNlJyD2ub1A+I78MEctAmXB5epAD
	K1wkVgMBOQB0D2ydunvzVURnagjAGZs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WGr5FNji
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3Yxigyi1LYdEAywnUWC/5LsywGBwXbC7kGFyVkwqpI=;
	b=WGr5FNjim1tq4v7Z6EwdiIel6gmvJQ2xioBaRttWB+dMJv7RHwUih4punClqtiI6zNMsuN
	kfb79D+O3I3eqj0a0mLUkL+Wq4WVzn5PAt6ZntFFkSMNlJyD2ub1A+I78MEctAmXB5epAD
	K1wkVgMBOQB0D2ydunvzVURnagjAGZs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B510F13A52
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGTCHdW61mY2TwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 07:29:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: convert: fix inline extent size for symbol link
Date: Tue,  3 Sep 2024 16:58:59 +0930
Message-ID: <aaaca1f01a1ff0bcd9afc71e7eae700d34904343.1725348299.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725348299.git.wqu@suse.com>
References: <cover.1725348299.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76EBE21A79
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Sometimes test case btrfs/012 fails randomly, with the failure to read a
softlink:

     QA output created by 012
     Checking converted btrfs against the original one:
    -OK
    +readlink: Structure needs cleaning
     Checking saved ext2 image against the original one:
     OK

Furthermore, this will trigger a kernel error message:

 BTRFS critical (device dm-2): regular/prealloc extent found for non-regular inode 133081

[CAUSE]
For that specific inode 133081, the tree dump looks like this:

        item 127 key (133081 INODE_ITEM 0) itemoff 40984 itemsize 160
                generation 1 transid 1 size 4095 nbytes 4096
                block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
                sequence 0 flags 0x0(none)
        item 128 key (133081 INODE_REF 133080) itemoff 40972 itemsize 12
                index 2 namelen 2 name: l3
        item 129 key (133081 EXTENT_DATA 0) itemoff 40919 itemsize 53
                generation 4 type 1 (regular)
                extent data disk byte 2147483648 nr 38080512
                extent data offset 37974016 nr 4096 ram 38080512
                extent compression 0 (none)

Note that, the soft link inode size is 4095, just one by smaller than
the sector size, but its nbytes is 4096, larger than the upper limit of
inline extent.

Thus it results the creation of a regular extent, but for btrfs we do
not accept a soft link with a regular/preallocated extent, thus kernel
rejects such read and failed the readlink call.

The root cause is in the convert code, where for soft links we always
create a data extent with its size + 1, causing the above problem.

I guess the original code is to handle the terminating NUL, but in btrfs
we never need to bother terminating NUL for inline extents.

Thus this pitfall in btrfs-convert leads to the above invalid data
extent and fail the test case.

[FIX]
Fix the corner case by removing the terminating NUL when inserting an
inline extent.

Furthermore, to prevent such problem from happening again, do extra
UASSERT() for btrfs_insert_inline_extent() to detect such problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c     | 12 +++++++++---
 convert/source-reiserfs.c |  4 ++--
 kernel-shared/file-item.c |  3 +++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index acba5db7ee81..dfad64a6d226 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -476,8 +476,14 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 	int ret;
 	char *pathname;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
+
 	if (ext2fs_inode_data_blocks2(ext2_fs, ext2_inode)) {
-		btrfs_set_stack_inode_size(btrfs_inode, inode_size + 1);
+		if (inode_size >= trans->fs_info->sectorsize) {
+			error("inode size too large for symbol link, has %llu expect [1, %u]",
+				inode_size,  trans->fs_info->sectorsize - 1);
+			return -EUCLEAN;
+		}
+		btrfs_set_stack_inode_size(btrfs_inode, inode_size);
 		ret = ext2_create_file_extents(trans, root, objectid,
 				btrfs_inode, ext2_fs, ext2_ino,
 				CONVERT_FLAG_DATACSUM |
@@ -489,8 +495,8 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 	pathname = (char *)&(ext2_inode->i_block[0]);
 	BUG_ON(pathname[inode_size] != 0);
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 pathname, inode_size + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size + 1);
+					 pathname, inode_size);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size);
 	return ret;
 }
 
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3edc72ed08a5..e2f07bfda188 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -538,8 +538,8 @@ static int reiserfs_copy_symlink(struct btrfs_trans_handle *trans,
 	len = get_ih_item_len(tp_item_head(&path));
 
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 symlink, len + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, len + 1);
+					 symlink, len);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, len);
 fail:
 	pathrelse(&path);
 	return ret;
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index d2da56e1f523..22fa1b03bed7 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -26,6 +26,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "common/internal.h"
+#include "common/messages.h"
 
 #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
 			       sizeof(struct btrfs_item) * 2) / \
@@ -97,6 +98,8 @@ int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 	int err = 0;
 	int ret;
 
+	UASSERT(size < trans->fs_info->sectorsize);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-- 
2.46.0


