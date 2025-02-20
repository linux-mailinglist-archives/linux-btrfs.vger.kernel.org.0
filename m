Return-Path: <linux-btrfs+bounces-11631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B0CA3D5F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487527AC84E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD61F4E3B;
	Thu, 20 Feb 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="od13hxuM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="od13hxuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696F1EC016
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045719; cv=none; b=VDYVYUJOi7LWXqtcOmukEyccDzqGs93G4zwcfNghVqs7iCB87it+YA7/DsplpzZJOi8MnX6LDdyERiSrJSmWszq+Ww0xfwED15++WdWlV/06TdhqiVTpKm8ef3WYL9EkjTaP95F22UxaeeDlhS5SmKglmMLsuo6Z3vtHGQLwxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045719; c=relaxed/simple;
	bh=kha56TYQ2MQn7UWa88c2/V1VKAMdurh5rPG5fICkdzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWz4M0jtaUCAtOoZQNUe6xW0e8QPZsmkkbjTiWU3WCXP1WBWpY/2LvEUgHuXwkdB2jkHRG2VLtsh+xUourPifBBwF3zrSJuyJjczU0T8v5x5PlLnyVYeH4uI7JYBIIq3BGyJys2YKqxn1zhFTH+X0Ojv2k2kWV17OlCyNRUqQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=od13hxuM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=od13hxuM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C11F72117C;
	Thu, 20 Feb 2025 10:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGOKkkaFLRx5ms1zmf5thw50uJpnrYFUtGC8UMLwH0M=;
	b=od13hxuMPsLd3X25cvfk3YrKRcsEK0qCU5nQoQEKIvPNAlP8W7TyIBoZ9d6IFqFR/PzUSi
	cUyYkRYZQeJVmxrGPPp0vIsm8fB8NIOo2bGD/f97bxJToeXqbQe2UZXQ6oRe2coNckMEI8
	x9b/nSJaw7e2TRCkQXgPq6mvQ0A8MUY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGOKkkaFLRx5ms1zmf5thw50uJpnrYFUtGC8UMLwH0M=;
	b=od13hxuMPsLd3X25cvfk3YrKRcsEK0qCU5nQoQEKIvPNAlP8W7TyIBoZ9d6IFqFR/PzUSi
	cUyYkRYZQeJVmxrGPPp0vIsm8fB8NIOo2bGD/f97bxJToeXqbQe2UZXQ6oRe2coNckMEI8
	x9b/nSJaw7e2TRCkQXgPq6mvQ0A8MUY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB45013301;
	Thu, 20 Feb 2025 10:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ha2LZP9tmfCfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 20/22] btrfs: use struct btrfs_inode inside btrfs_remap_file_range_prep()
Date: Thu, 20 Feb 2025 11:01:55 +0100
Message-ID: <6265dcbb7ae31382c6c2c3b043f53f1c4dee35ac.1740045551.git.dsterba@suse.com>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Use a struct btrfs_inode in btrfs_remap_file_range_prep() as it's an
internal helper, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f63f92e176c8..15c296cb4dac 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -777,24 +777,24 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       loff_t *len, unsigned int remap_flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
-	u64 bs = BTRFS_I(inode_out)->root->fs_info->sectorsize;
+	struct btrfs_inode *inode_in = BTRFS_I(file_inode(file_in));
+	struct btrfs_inode *inode_out = BTRFS_I(file_inode(file_out));
+	u64 bs = inode_out->root->fs_info->sectorsize;
 	u64 wb_len;
 	int ret;
 
 	if (!(remap_flags & REMAP_FILE_DEDUP)) {
-		struct btrfs_root *root_out = BTRFS_I(inode_out)->root;
+		struct btrfs_root *root_out = inode_out->root;
 
 		if (btrfs_root_readonly(root_out))
 			return -EROFS;
 
-		ASSERT(inode_in->i_sb == inode_out->i_sb);
+		ASSERT(inode_in->vfs_inode.i_sb == inode_out->vfs_inode.i_sb);
 	}
 
 	/* Don't make the dst file partly checksummed */
-	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
-	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
+	if ((inode_in->flags & BTRFS_INODE_NODATASUM) !=
+	    (inode_out->flags & BTRFS_INODE_NODATASUM)) {
 		return -EINVAL;
 	}
 
@@ -813,7 +813,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 *    to complete so that new file extent items are in the fs tree.
 	 */
 	if (*len == 0 && !(remap_flags & REMAP_FILE_DEDUP))
-		wb_len = ALIGN(inode_in->i_size, bs) - ALIGN_DOWN(pos_in, bs);
+		wb_len = ALIGN(inode_in->vfs_inode.i_size, bs) - ALIGN_DOWN(pos_in, bs);
 	else
 		wb_len = ALIGN(*len, bs);
 
@@ -834,16 +834,14 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 * Also we don't need to check ASYNC_EXTENT, as async extent will be
 	 * CoWed anyway, not affecting nocow part.
 	 */
-	ret = filemap_flush(inode_in->i_mapping);
+	ret = filemap_flush(inode_in->vfs_inode.i_mapping);
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_wait_ordered_range(BTRFS_I(inode_in), ALIGN_DOWN(pos_in, bs),
-				       wb_len);
+	ret = btrfs_wait_ordered_range(inode_in, ALIGN_DOWN(pos_in, bs), wb_len);
 	if (ret < 0)
 		return ret;
-	ret = btrfs_wait_ordered_range(BTRFS_I(inode_out), ALIGN_DOWN(pos_out, bs),
-				       wb_len);
+	ret = btrfs_wait_ordered_range(inode_out, ALIGN_DOWN(pos_out, bs), wb_len);
 	if (ret < 0)
 		return ret;
 
-- 
2.47.1


