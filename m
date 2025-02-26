Return-Path: <linux-btrfs+bounces-11832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9081A45451
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DDF3A9FB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E68267399;
	Wed, 26 Feb 2025 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GUTmSd+2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GUTmSd+2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AB20AF8E
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543053; cv=none; b=ApH8r4pJTVHHxEEbb2XUTeZ0ecl6BJsML6Wq+RiO3IN/3S1jKToDXkNNaPgvPBJg5SUyN1fN9znu36GvUMCmkgRy5naiFCsuz5+TVOwIpKZOh1jtPzzVSSLIOULi2agwzTvMJ0ortQrMy3QFL2EGA+MkMv1/Z1tSdukyjQj0RGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543053; c=relaxed/simple;
	bh=M0SYU0Kqvy65ZZJ9hm65kUIimvw4ImW+7kunbV4PefU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efddhAJdzkW6l0WofkHthpxUIfrHERuDOPRzZuCy8C2YygBG3Rw2pdNqcLvkKljlPC0zCwoE8UUKyxfY3TVWvcUNrrsIrNej+cMGkBbHx7oKR/dsbYs24l1WxcMh0AGH1d9uKph4ht1uI6XywXoDO7uI3ZNRQQOFo/maPUlPU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GUTmSd+2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GUTmSd+2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C1081F388
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc0010MY4CpdL3BwixsiB/JtMmdfmNGIO2wfUUSSEZo=;
	b=GUTmSd+23CjJJExzIScc8CSoJnsUrezEdpMCdWzq/7icnB8w5RYFr3Zi2ALBDbG2ABrUwU
	IfeoCQtfEBvZPlSWpkU/G9/zQ1eDFJdpHa4/DEIYEw0LRFVAm/SkOC6lyHCJpvRr4B8wzA
	fHVIk6iv2i7LkQjgXbyHZJ7lsKoVEp0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc0010MY4CpdL3BwixsiB/JtMmdfmNGIO2wfUUSSEZo=;
	b=GUTmSd+23CjJJExzIScc8CSoJnsUrezEdpMCdWzq/7icnB8w5RYFr3Zi2ALBDbG2ABrUwU
	IfeoCQtfEBvZPlSWpkU/G9/zQ1eDFJdpHa4/DEIYEw0LRFVAm/SkOC6lyHCJpvRr4B8wzA
	fHVIk6iv2i7LkQjgXbyHZJ7lsKoVEp0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6281377F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHnjD0OUvmcgfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: properly limit inline data extent according to block size
Date: Wed, 26 Feb 2025 14:40:21 +1030
Message-ID: <0d96520065cd566b81804bf972adf69767bd4528.1740542375.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542375.git.wqu@suse.com>
References: <cover.1740542375.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Btrfs utilizes inline data extent for the following cases:

- Regular small files
- Symlink files

And "btrfs check" detects any file extents that are too large as an
error.

It's not a problem for 4K block size, but for the incoming smaller
block sizes (2K), it can cause problems due to bad limits:

- Non-compressed inline data extents
  We do not allow a non-compressed inline data extent to be as large as
  block size.

- Symblinks
  Currently the only real limit on symblinks are 4K, which can be larger
  than 2K block size.

These will result btrfs-check to report too large file extents.

Fix it by adding proper size checks for the above cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4629706485dc..386e700515ca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -570,6 +570,13 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (size > fs_info->sectorsize)
 		return false;
 
+	/*
+	 * We do not allow a non-compressed extent to be as large
+	 * as block size.
+	 */
+	if (data_len >= fs_info->sectorsize)
+		return false;
+
 	/* We cannot exceed the maximum inline data size. */
 	if (data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
 		return false;
@@ -8673,7 +8680,12 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct extent_buffer *leaf;
 
 	name_len = strlen(symname);
-	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
+	/*
+	 * Symlink utilize uncompressed inline extent data, which should
+	 * not reach block size.
+	 */
+	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
+	    name_len >= fs_info->sectorsize)
 		return -ENAMETOOLONG;
 
 	inode = new_inode(dir->i_sb);
-- 
2.48.1


