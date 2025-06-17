Return-Path: <linux-btrfs+bounces-14704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5BADC181
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172C1176126
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628523D2B2;
	Tue, 17 Jun 2025 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sanp9+AB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Sanp9+AB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1D23B61A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137623; cv=none; b=AyqsYqPycbNFeUax4PtXDXTxyVrGj0XEte3F6hAIraD7W5Wqag0MeAdzFinC3FJqDvsbu/reMHTiMcgzQkk2d3vRbnDWczAirORAmZZ06V59+Bnt5rSgtBy7OBdJhID+y/cQAvDxGtahWwNEKpr4BVpOsB9YGwcBVs1w/75MlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137623; c=relaxed/simple;
	bh=caPoEhM4myAnKZH7e+2bAxCOQE1dY0EH3MSDlGk6yfk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9eEkDNTklDMO5uBiIaffFVTGJRTkA2nCYTRNuywUBpGIov9P1KwGUgAR3935A0IF/jHs7kO0lbVLkv2HhujMI0L8YjErWEZK3QXe5RlTH2BT9fdFOgwHr7loY/IpJtTub5F9EXj0oojzvSADZMiPqHcVX0jZKpEGBKoCS9MhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sanp9+AB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Sanp9+AB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B7DA1F38E
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h7iQ3a8kTqGSrT63NquHdqXpwXHgzQJTVGBTBBrbWo=;
	b=Sanp9+ABugSgMfoucGxtIhqc+JJqw6qyTZb7ZS4s/xhocveLTABam9zzXoHwo/2cWZUCIF
	G254zR8J9BiHHIBwUZ0gW9xCVOg2679fuYpWFjF4TMDD0Hal/E7e7C0PHcpA95tyckjKf5
	XDwK//ukqn8CltYUK3l09/mOncUkM3k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/h7iQ3a8kTqGSrT63NquHdqXpwXHgzQJTVGBTBBrbWo=;
	b=Sanp9+ABugSgMfoucGxtIhqc+JJqw6qyTZb7ZS4s/xhocveLTABam9zzXoHwo/2cWZUCIF
	G254zR8J9BiHHIBwUZ0gW9xCVOg2679fuYpWFjF4TMDD0Hal/E7e7C0PHcpA95tyckjKf5
	XDwK//ukqn8CltYUK3l09/mOncUkM3k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B4F139E2
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCqVBgj7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/6] btrfs: delay btrfs_open_devices() until super block is created
Date: Tue, 17 Jun 2025 14:49:38 +0930
Message-ID: <88057609cf37d6d46f6d1ece1108fb5b6832259c.1750137547.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750137547.git.wqu@suse.com>
References: <cover.1750137547.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Currently btrfs always call btrfs_open_devices() before creating the
super block.

It's fine for now because:

- No blk_holder_ops is provided
- btrfs_fs_type is used as a holder

This means no matter who wins the device opening race, the holder will be
the same thus not affecting the later sget_fc() race.

And since no blk_holder_ops is provided, no bdev operation is depending on
the holder.

But this will no longer be true if we want to (we indeed want) implement
a proper blk_holder_ops using fs_holder_ops.

This means we will need a proper super block as the bdev holder.

To prepare for such change, delay the btrfs_open_devices() call until we
got a super block.
This is done by extending uuid_mutex to cover sget_fc(), so that we can
call btrfs_open_devices() after sget_fc().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 41c824d216fc..36c9df82efdf 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1841,7 +1841,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct block_device *bdev;
 	struct btrfs_device *device;
 	struct super_block *sb;
 	blk_mode_t mode = btrfs_open_mode(fc);
@@ -1864,19 +1863,11 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
-	mutex_unlock(&uuid_mutex);
-	if (ret)
-		return ret;
-
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
-		return -EACCES;
-
-	bdev = fs_devices->latest_dev->bdev;
-
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		mutex_unlock(&uuid_mutex);
 		return PTR_ERR(sb);
+	}
 
 	set_device_specific_options(fs_info);
 
@@ -1888,12 +1879,16 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 *
 		 * fc->s_fs_info is not touched and will be later freed by
 		 * put_fs_context() through btrfs_free_fs_context().
-		 * 
-		 * And the fs_info->fs_devices will also be closed by
-		 * btrfs_free_fs_context().
 		 */
 		ASSERT(fc->s_fs_info == fs_info);
 
+		/*
+		 * But the fs_info->fs_devices is not opened, we should not let
+		 * btrfs_free_fs_context() to close them.
+		 */
+		fs_info->fs_devices = NULL;
+		mutex_unlock(&uuid_mutex);
+
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1901,6 +1896,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * needed.
 		 */
 	} else {
+		struct block_device *bdev;
+
 		/*
 		 * The first mount of the fs thus a new superblock, fc->s_fs_info
 		 * should be NULL, and the owner ship of our fs_info and fs_devices is
@@ -1908,6 +1905,17 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 */
 		ASSERT(fc->s_fs_info == NULL);
 
+		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		mutex_unlock(&uuid_mutex);
+		if (ret < 0) {
+			deactivate_locked_super(sb);
+			return ret;
+		}
+		if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+			deactivate_locked_super(sb);
+			return -EACCES;
+		}
+		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
-- 
2.49.0


