Return-Path: <linux-btrfs+bounces-14887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C561AE589E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE384C2143
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58C157E99;
	Tue, 24 Jun 2025 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A52AbqSC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A52AbqSC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B235948
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725211; cv=none; b=ZwaMNOE2ZBEtxQMUaDACa5Y6XVKAoNK41vLDI3i+qw0MDXvurKqimjrK3VkAm4RC31Zl8d/DJ+szibSvZJu7wNMbaiWqIZ6mRNft/P6y3RELuJ63bGivQ4BdDVurHsDwBfmHV8yDAK/sV6JVqEDmzsWxF0PFxA/jiEt7WCxNs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725211; c=relaxed/simple;
	bh=xaUriAZqTVWBGiM3l3Xu7vnUc1aoHRIsQv3TISK6amk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCY8ybAKUcdp1Vc2vU8cggqb5Yar9enmaXTNbBBe+Dx0N3I5syjeS+iKfNElXc7Pat/+gN8JfWuXT5h9Q08d1eP+elJn83JhQ8A37nZPzbj0ahExGfk11f/SRQJ8VtDMDVS83AvU/2n9IrUDiEqovGPBHknzgShiXbjbkggOM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A52AbqSC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A52AbqSC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14DA01F444
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNLdR0GCp9teqFKyi9jOI50/dJLX5zxrSdlt6GHRp2k=;
	b=A52AbqSChb1/4bwDbv5NkKPRmhyR9+ipNFCeP77aR5uUUcetWnkf9vyttklxZRLdL/xxhE
	QHAV8laaXyDymRRLTYfWEkmvFNsU7Ui3OMplIeutsUj5US0hKBLQyylHvsH9EohAddoiEw
	aRV29j2LHCIsMBU2XltOt0binqYQOM8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=A52AbqSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNLdR0GCp9teqFKyi9jOI50/dJLX5zxrSdlt6GHRp2k=;
	b=A52AbqSChb1/4bwDbv5NkKPRmhyR9+ipNFCeP77aR5uUUcetWnkf9vyttklxZRLdL/xxhE
	QHAV8laaXyDymRRLTYfWEkmvFNsU7Ui3OMplIeutsUj5US0hKBLQyylHvsH9EohAddoiEw
	aRV29j2LHCIsMBU2XltOt0binqYQOM8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51D6313485
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yMxvBVLyWWiCCAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 3/8] btrfs: add comments to make super block creation more clear
Date: Tue, 24 Jun 2025 10:02:40 +0930
Message-ID: <4ab0179de95d71e4d1ae5e65d213e89a6ec574c5.1750724841.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750724841.git.wqu@suse.com>
References: <cover.1750724841.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 14DA01F444
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

When calling sget_fc(), there are 3 different situations:

a) Critical error
   No super block created.

b) A new super block is created
   The fc->s_fs_info is transferred to the super block, and fc->s_fs_info
   is reset to NULL.

   In this case sb->s_root should still be NULL, and needs to be properly
   initialized later by btrfs_fill_super().

c) An existing super block is returned
   The fc->s_fs_info is untouched, and anything related to that fs_info
   should be properly cleaned up.

This is not obvious even with the extra comments at sget_fc().

Enhance the situation by:

- Add comments for case b) and c)
  Especially for case c), the fs_info and fs_devices cleanup happens at
  different timing, thus needs extra explanation.

- Move the comments closer to case b) and case c)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d977d2da985e..b6bc262acf71 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1876,15 +1876,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	bdev = fs_devices->latest_dev->bdev;
 
-	/*
-	 * From now on the error handling is not straightforward.
-	 *
-	 * If successful, this will transfer the fs_info into the super block,
-	 * and fc->s_fs_info will be NULL.  However if there's an existing
-	 * super, we'll still have fc->s_fs_info populated.  If we error
-	 * completely out it'll be cleaned up when we drop the fs_context,
-	 * otherwise it's tied to the lifetime of the super_block.
-	 */
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
@@ -1894,6 +1885,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	set_device_specific_options(fs_info);
 
 	if (sb->s_root) {
+		/*
+		 * Not the first mount of the fs thus got an existing super block.
+		 *
+		 * Will reuse the returned super block, fs_info and fs_devices.
+		 */
+		ASSERT(fc->s_fs_info == fs_info);
+
+		/*
+		 * fc->s_fs_info is not touched and will be later freed by
+		 * put_fs_context() through btrfs_free_fs_context().
+		 *
+		 * But we have opened fs_devices at the beginning of the
+		 * function, thus still need to close them manually.
+		 */
 		btrfs_close_devices(fs_devices);
 		/*
 		 * At this stage we may have RO flag mismatch between
@@ -1902,6 +1907,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * needed.
 		 */
 	} else {
+		/*
+		 * The first mount of the fs thus a new superblock, fc->s_fs_info
+		 * should be NULL, and the owner ship of our fs_info and fs_devices is
+		 * transferred to the super block.
+		 */
+		ASSERT(fc->s_fs_info == NULL);
+
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
-- 
2.49.0


