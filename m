Return-Path: <linux-btrfs+bounces-16580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C3B3F990
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8024E1D39
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEB2EB844;
	Tue,  2 Sep 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jmRAz1VY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jmRAz1VY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86052EA484
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803777; cv=none; b=ip+SyKym/QVfKA/Lwk7x3ZcGUZ7B0r5ZN2ewa2eE/pVnHoXYXp6sMPbmOxxjJHzBTk/3EkOvzBlOK2Zbnf4Y85oXYONGNVk8AX9+N/+OdKSeLQTehBP8lZ4MuZK03uKgVGYj+zeaGZc/u3H7E8mKrmnZedRNHW8xbujG1oBg9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803777; c=relaxed/simple;
	bh=HDaXSq/BShHSd+2LvrmRFrzF/pFPIJYXi5rifb50n9k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUveV3xkWperqMDEI7aQ79dPwoxw2rcF+PA110zqrBEqTCnEtrjGV8Q4TwwkRcz2vcXo4Tn29GCr3g1Tj0YmftbebUum1DpW3V5XfVFQY5fNlsQ/p1d65uoYEaCLo7heJAO8Ae2ajSPm/2TzEKMvQwvHjczyc9VDVeCB2b3EyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jmRAz1VY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jmRAz1VY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E715C1F44F
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opXvK5qELnte6ANoSlZ/iIUTiSQ824tp5zabYuaExc8=;
	b=jmRAz1VYLm8ojB+nPutYYjNgL1COP9qmBtlSEl3P4I7sxW+8xglfxcMmN2xLbFMqKhhyj0
	LbYm5YBvuyUCWkokSIuefiBrJcUvlM6PTIeXb9AbU8xdqmudZX14H8QFW+IDPUcwQM5Fq3
	ujy9/ftx3A/9DtVqXGKOx9zEPoF0ZzA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756803760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opXvK5qELnte6ANoSlZ/iIUTiSQ824tp5zabYuaExc8=;
	b=jmRAz1VYLm8ojB+nPutYYjNgL1COP9qmBtlSEl3P4I7sxW+8xglfxcMmN2xLbFMqKhhyj0
	LbYm5YBvuyUCWkokSIuefiBrJcUvlM6PTIeXb9AbU8xdqmudZX14H8QFW+IDPUcwQM5Fq3
	ujy9/ftx3A/9DtVqXGKOx9zEPoF0ZzA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2912213A54
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AioNq+ytmgMBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 09:02:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: cache max and min order inside btrfs_fs_info
Date: Tue,  2 Sep 2025 18:32:16 +0930
Message-ID: <f81aa24950cbf8329f846d8b42f23710c07a95b7.1756803640.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756803640.git.wqu@suse.com>
References: <cover.1756803640.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Inside btrfs_fs_info we cache several bits shift like sectorsize_bits.

Apply this to max and min folio orders so that every time mapping order
needs to be applied we can skip the calculation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 6 +++---
 fs/btrfs/disk-io.c     | 2 ++
 fs/btrfs/fs.h          | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c40e99ec13bf..f45dcdde0efc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -532,9 +532,9 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 
 	/* We only allow BITS_PER_LONGS blocks for each bitmap. */
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-	mapping_set_folio_order_range(inode->vfs_inode.i_mapping, 0,
-			ilog2(((BITS_PER_LONG << inode->root->fs_info->sectorsize_bits)
-				>> PAGE_SHIFT)));
+	mapping_set_folio_order_range(inode->vfs_inode.i_mapping,
+				      inode->root->fs_info->block_min_order,
+				      inode->root->fs_info->block_max_order);
 #endif
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc40898..a2eba8bc4336 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3383,6 +3383,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->nodesize_bits = ilog2(nodesize);
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
+	fs_info->block_min_order = ilog2(round_up(sectorsize, PAGE_SIZE) >> PAGE_SHIFT);
+	fs_info->block_max_order = ilog2((BITS_PER_LONG << fs_info->sectorsize_bits) >> PAGE_SHIFT);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 	fs_info->fs_devices->fs_info = fs_info;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5f0b185a7f21..bf4a1b75b0cf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -825,6 +825,8 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	/* ilog2 of sectorsize, use to avoid 64bit division */
 	u32 sectorsize_bits;
+	u32 block_min_order;
+	u32 block_max_order;
 	u32 csum_size;
 	u32 csums_per_leaf;
 	u32 stripesize;
-- 
2.50.1


