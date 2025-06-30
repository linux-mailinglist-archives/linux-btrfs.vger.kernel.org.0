Return-Path: <linux-btrfs+bounces-15078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1502AED3D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1458188CDCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4AC1DB125;
	Mon, 30 Jun 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jw5h25pU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Jw5h25pU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B20A1DA60D
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261398; cv=none; b=iiVvJMl5LWa77GiqApgXWwod/AsOhkFwIklJjMALxXcT6/C+Sr2ZeorCimlMWJeMalKBr8o0SyUfvySAXHurSpdEen9gT3fcN2OPehBuqfOWdIXgWQ8fWJEve8+yx3GPTqgZAXBsESey10UGL85Wifh8WfOQLPpV9bSLGoSFD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261398; c=relaxed/simple;
	bh=poJNBfWP/9euweV4SEPhfLf/3RzRFtQ9BqUL+i1JJVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5nroBgRGcVPxlolqmmzxljLcVBl8Ki6t0l6Uk+ahweXqkAD8CiCVXpSwdQ9w9kE/dUcfp4NmqtZRUH+IV5Dxyb1DqagIEvoNmADedCEKDj/oIBhvrzhwzrKZRDY2LwCYd2Vid6pDJEtRIYJCtvY53mRIEr7ZjPIFeq43lRqJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jw5h25pU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Jw5h25pU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A14D921163
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZzI7qdI8jsDOVMNNd3+uZ4/Lh8hhR7UmFqPDKZ4aAU=;
	b=Jw5h25pUTVyLJVx0HwQ3xtmCGRhR1D338r48m8kb7OzFSJPbowjr6uh3aL/H3OumS4uYjN
	tBI5mf3b8UgZVnp5EbiEcmzaqytDIy1hL6+iIhj1uCK/U/gOMFzrZWpUc1iIJ86rL0wD90
	qvGmI4VldP1wtZUZqU9GnCjsas5gTuo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZzI7qdI8jsDOVMNNd3+uZ4/Lh8hhR7UmFqPDKZ4aAU=;
	b=Jw5h25pUTVyLJVx0HwQ3xtmCGRhR1D338r48m8kb7OzFSJPbowjr6uh3aL/H3OumS4uYjN
	tBI5mf3b8UgZVnp5EbiEcmzaqytDIy1hL6+iIhj1uCK/U/gOMFzrZWpUc1iIJ86rL0wD90
	qvGmI4VldP1wtZUZqU9GnCjsas5gTuo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D49FB139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEn/I78gYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 3/8] btrfs: add comments to make super block creation more clear
Date: Mon, 30 Jun 2025 14:59:07 +0930
Message-ID: <72d7332d49187d545779fcb53b2efacab6c5bad0.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.79

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
2.50.0


