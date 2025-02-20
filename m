Return-Path: <linux-btrfs+bounces-11619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C5A3D5CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79A5174A54
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2981F2C34;
	Thu, 20 Feb 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OUfazwpB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OUfazwpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FCF1EB188
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045676; cv=none; b=njHURg7BOgcR45EAPnMwj6dks24dh4StwQjUl1cw3asIVDZ3FgaGlXvMoK9+s1u7VHpz9d8rb2D1OsD00kUDZzfrbZJ1WPs4zrYWFBolzcFIQ7gHUEUqHsKCeeZgIygZ0XsakIVkskCIFYCusIRzCMLsEjjR1Bcsl49bXmibFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045676; c=relaxed/simple;
	bh=vs0bcV4daURmBUVzMO5VbbGAgRGmVDrkD6f13MqaV/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SG+Crp4knx2ROCagYbz62oAvGXqUFjThXjQ/zbA+ZJmB1lq38t3greZserXrzGpDYaHNIz2u7/6skXclgh4W+QlZI86uNmgI3k1e5Oqqiu3/9ioBU7rkV0J1yvN9xN7GyrqxIvgDM5iuB2cL8083ZopPQvCSZxSUMEQ/kQ4ZQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OUfazwpB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OUfazwpB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5BD41F388;
	Thu, 20 Feb 2025 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3n201ObzTxmQoV8VmSVVqFMB8Wp3xp8dh2XhFgSoJg=;
	b=OUfazwpBp2dSNGSAtbAcTmy/dXoNbk5TxqLK3aj2SQgEwyUkjMsGTGGvNLSzc1d++RaUCV
	tXNqlcCMQycOzGyJUrJXKCD+G7Gnn1QO81r3MBNOymqWwhyAr7HF1TdQEeNJX5gj9vTqGS
	OzbPNh6/xgqgTYVJLqOwfLNQ1GZsRrc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3n201ObzTxmQoV8VmSVVqFMB8Wp3xp8dh2XhFgSoJg=;
	b=OUfazwpBp2dSNGSAtbAcTmy/dXoNbk5TxqLK3aj2SQgEwyUkjMsGTGGvNLSzc1d++RaUCV
	tXNqlcCMQycOzGyJUrJXKCD+G7Gnn1QO81r3MBNOymqWwhyAr7HF1TdQEeNJX5gj9vTqGS
	OzbPNh6/xgqgTYVJLqOwfLNQ1GZsRrc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF48113301;
	Thu, 20 Feb 2025 10:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 04CxLmT9tmdqfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/22] btrfs: pass struct btrfs_inode to btrfs_defrag_file()
Date: Thu, 20 Feb 2025 11:01:08 +0100
Message-ID: <489506c72f8e00332c8d6e75f4a2b1499f3981c6.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_defrag_file() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 44 ++++++++++++++++++++++----------------------
 fs/btrfs/defrag.h |  4 ++--
 fs/btrfs/ioctl.c  |  2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index d1330c138054..4b89094da3de 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -264,8 +264,8 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	file_ra_state_init(ra, inode->i_mapping);
 
 	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
-				       BTRFS_DEFRAG_BATCH);
+	ret = btrfs_defrag_file(BTRFS_I(inode), ra, &range, defrag->transid,
+				BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
 	iput(inode);
 
@@ -1352,13 +1352,13 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
  * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
  *  defragging all the range).
  */
-int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
+int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long sectors_defragged = 0;
-	u64 isize = i_size_read(inode);
+	u64 isize = i_size_read(&inode->vfs_inode);
 	u64 cur;
 	u64 last_byte;
 	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
@@ -1402,8 +1402,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	 * defrag range can be written sequentially.
 	 */
 	start_index = cur >> PAGE_SHIFT;
-	if (start_index < inode->i_mapping->writeback_index)
-		inode->i_mapping->writeback_index = start_index;
+	if (start_index < inode->vfs_inode.i_mapping->writeback_index)
+		inode->vfs_inode.i_mapping->writeback_index = start_index;
 
 	while (cur < last_byte) {
 		const unsigned long prev_sectors_defragged = sectors_defragged;
@@ -1420,27 +1420,27 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
 		cluster_end = min(cluster_end, last_byte);
 
-		btrfs_inode_lock(BTRFS_I(inode), 0);
-		if (IS_SWAPFILE(inode)) {
+		btrfs_inode_lock(inode, 0);
+		if (IS_SWAPFILE(&inode->vfs_inode)) {
 			ret = -ETXTBSY;
-			btrfs_inode_unlock(BTRFS_I(inode), 0);
+			btrfs_inode_unlock(inode, 0);
 			break;
 		}
-		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
-			btrfs_inode_unlock(BTRFS_I(inode), 0);
+		if (!(inode->vfs_inode.i_sb->s_flags & SB_ACTIVE)) {
+			btrfs_inode_unlock(inode, 0);
 			break;
 		}
 		if (do_compress)
-			BTRFS_I(inode)->defrag_compress = compress_type;
-		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
+			inode->defrag_compress = compress_type;
+		ret = defrag_one_cluster(inode, ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
 				newer_than, do_compress, &sectors_defragged,
 				max_to_defrag, &last_scanned);
 
 		if (sectors_defragged > prev_sectors_defragged)
-			balance_dirty_pages_ratelimited(inode->i_mapping);
+			balance_dirty_pages_ratelimited(inode->vfs_inode.i_mapping);
 
-		btrfs_inode_unlock(BTRFS_I(inode), 0);
+		btrfs_inode_unlock(inode, 0);
 		if (ret < 0)
 			break;
 		cur = max(cluster_end + 1, last_scanned);
@@ -1462,10 +1462,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		 * need to be written back immediately.
 		 */
 		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
-			filemap_flush(inode->i_mapping);
+			filemap_flush(inode->vfs_inode.i_mapping);
 			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-				     &BTRFS_I(inode)->runtime_flags))
-				filemap_flush(inode->i_mapping);
+				     &inode->runtime_flags))
+				filemap_flush(inode->vfs_inode.i_mapping);
 		}
 		if (range->compress_type == BTRFS_COMPRESS_LZO)
 			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
@@ -1474,9 +1474,9 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		ret = sectors_defragged;
 	}
 	if (do_compress) {
-		btrfs_inode_lock(BTRFS_I(inode), 0);
-		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
-		btrfs_inode_unlock(BTRFS_I(inode), 0);
+		btrfs_inode_lock(inode, 0);
+		inode->defrag_compress = BTRFS_COMPRESS_NONE;
+		btrfs_inode_unlock(inode, 0);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 6b7596c4f0dc..a7f917a38dbf 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -6,14 +6,14 @@
 #include <linux/types.h>
 #include <linux/compiler_types.h>
 
-struct inode;
 struct file_ra_state;
+struct btrfs_inode;
 struct btrfs_fs_info;
 struct btrfs_root;
 struct btrfs_trans_handle;
 struct btrfs_ioctl_defrag_range_args;
 
-int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
+int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag);
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 45b087011324..f3ce82d113be 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2572,7 +2572,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			/* the rest are all set to zero by kzalloc */
 			range.len = (u64)-1;
 		}
-		ret = btrfs_defrag_file(file_inode(file), &file->f_ra,
+		ret = btrfs_defrag_file(BTRFS_I(file_inode(file)), &file->f_ra,
 					&range, BTRFS_OLDEST_GENERATION, 0);
 		if (ret > 0)
 			ret = 0;
-- 
2.47.1


