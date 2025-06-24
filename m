Return-Path: <linux-btrfs+bounces-14888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E5AE589F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 02:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6877D4C25E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322756F06B;
	Tue, 24 Jun 2025 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EO11IgFr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EO11IgFr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD035948
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725216; cv=none; b=eFpEgEBLKmxUA7EsJQ643avoAi6MfUUQWxc2jBLMQNO2II9OlJsP5f0vtsf+tSqfgfCSXcVPQSL+mR4EgDFEk70arGXzfKA6vNBFX0BlhKxCWdAUM0iTf/h4U/KU34/mOgr9z9HItacoaFfN7fOVr6Ykgw2/uyK9vkKFaUfFNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725216; c=relaxed/simple;
	bh=V7qcQghtBLCFW4Zspya6+LnWTqXX7lawgDIN/wrRO78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBwG42teH/LjF6huSpHdScOtzl9bXgfmaPxolN+p/QG20TSTCN8a3G0SMaNCvqlGdkHBBwlJuLgwfKSEJZcIvOsl/dfi5uTu7LXNR1wa8agqcqEIma1RaOWTBPLAntqZt+DYfGD+H3Sr+jjzkncNxl0RLP6wf2SqoISe16vihik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EO11IgFr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EO11IgFr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD6482116D;
	Tue, 24 Jun 2025 00:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKYw0ms2YBG3x2sLRcdNWsof68GDvO79eDAPb+Sk5OQ=;
	b=EO11IgFr/FPAffbvLUfgW54W8wrMp2TSN5AkXNpvAVSvLzsyKlncbc7Aj+RE0YLsvsITlS
	PvUyPgnJmQOg7t9k51wqEs+Q/TyrJi91OfmLg9Ii/FKHj4UZ8gsuH0COQ9Kn3m8mgNGEXm
	gNO9UCmaIIEkbcDAb5sZlwH30BU+IRU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EO11IgFr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750725204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKYw0ms2YBG3x2sLRcdNWsof68GDvO79eDAPb+Sk5OQ=;
	b=EO11IgFr/FPAffbvLUfgW54W8wrMp2TSN5AkXNpvAVSvLzsyKlncbc7Aj+RE0YLsvsITlS
	PvUyPgnJmQOg7t9k51wqEs+Q/TyrJi91OfmLg9Ii/FKHj4UZ8gsuH0COQ9Kn3m8mgNGEXm
	gNO9UCmaIIEkbcDAb5sZlwH30BU+IRU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 881DC13485;
	Tue, 24 Jun 2025 00:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGCjElPyWWiCCAAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 24 Jun 2025 00:33:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 4/8] btrfs: call btrfs_close_devices from ->kill_sb
Date: Tue, 24 Jun 2025 10:02:41 +0930
Message-ID: <88dece9aea92d85b317bd3a6e52e2b2cc638afaf.1750724841.git.wqu@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CD6482116D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

Although btrfs is not yet implementing blk_holder_ops yet, there is a
requirement for a proper blk_holder_ops:

- blkdev_put() must not be called under sb->s_umount
  The blkdev_put()/bdev_fput() must not be called under sb->s_umount to
  avoid lock order reversal with disk->open_mutex.
  This is for the proper blk_holder_ops callbacks.

  Currently we're fine because we call regular fput() which defers the
  blk holder reclaiming.

To prepare for the future of blk_holder_ops, move the
btrfs_close_devices() calls into btrfs_free_fs_info().

That will be called from kill_sb() callbacks, which is also called for
error handing during mount failures, or there is already an existing
super block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0d6ad7512f21..a9689cb98a90 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1246,6 +1246,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
 
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->stats_read_blocks);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
@@ -3681,7 +3683,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4428,7 +4429,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(fs_info);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b6bc262acf71..cc15939080e6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1869,18 +1869,14 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		ret = -EACCES;
-		goto error;
-	}
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
+		return -EACCES;
 
 	bdev = fs_devices->latest_dev->bdev;
 
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto error;
-	}
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
 
 	set_device_specific_options(fs_info);
 
@@ -1889,17 +1885,15 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * Not the first mount of the fs thus got an existing super block.
 		 *
 		 * Will reuse the returned super block, fs_info and fs_devices.
-		 */
-		ASSERT(fc->s_fs_info == fs_info);
-
-		/*
+		 *
 		 * fc->s_fs_info is not touched and will be later freed by
 		 * put_fs_context() through btrfs_free_fs_context().
 		 *
-		 * But we have opened fs_devices at the beginning of the
-		 * function, thus still need to close them manually.
+		 * And the fs_info->fs_devices will also be closed by
+		 * btrfs_free_fs_context().
 		 */
-		btrfs_close_devices(fs_devices);
+		ASSERT(fc->s_fs_info == fs_info);
+
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1928,10 +1922,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	fc->root = dget(sb->s_root);
 	return 0;
-
-error:
-	btrfs_close_devices(fs_devices);
-	return ret;
 }
 
 /*
-- 
2.49.0


