Return-Path: <linux-btrfs+bounces-20119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2FCF6842
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 03:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14FDF302082C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 02:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D592253EB;
	Tue,  6 Jan 2026 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J5K5nDGb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J5K5nDGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F30F4F1
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667853; cv=none; b=duOTD+9ahtp9V4WLG/KJoNKV+YvbUuWnczbjQyO8iiLaoM/HLPIDYxlVe+Gzi1OarsXwg9ytA2AzgihJqu7E4jckGBUcHo1a1CfQPbEsUtEbEl0NVEiBTo31uog64oK9XzOZ9g8Vnzl2w2KLNwFzOLwvveBLBhc8Q6OHqdbBySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667853; c=relaxed/simple;
	bh=oPF3dDnScj6iz8jB85u/gog2JxpReIzjG0Ez8vzEEbk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p2Q/DTdJSU7z8UsEoymIqJzUSlMXEZXyFbNSavW4HP2dK+czbYta9CnjjC4NluevjzMX2q9W7XIhAQjmmaJ7AtJ5XEWa2tMF3KxUHHTjwndEM9mX4/1U6+sIu9WvuksCQO5KuapvnhYnXkmX2hgM5o1TNTpHsIDSsSlv9qLNnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J5K5nDGb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J5K5nDGb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20D6033838
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767667849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mgH5vUkHD2IPg02iL2FwOknSiWcx3ffR1A/YDOY3Ak=;
	b=J5K5nDGbNR7/PoFE93mUPFIvJ47KQDx12xHocRfl/mT+4APt0ycgUbLOKWZLxb+oA85ny+
	VZ02po5lPPPf+1rMpVnmE1LYDtSs7Hrhh7mtjH/hg+8G80T+NJ/kke6Ljd6gFwUCeSggva
	lfVjk3TSk4jw3+UTA6abv1GgJYiW97A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=J5K5nDGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767667849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mgH5vUkHD2IPg02iL2FwOknSiWcx3ffR1A/YDOY3Ak=;
	b=J5K5nDGbNR7/PoFE93mUPFIvJ47KQDx12xHocRfl/mT+4APt0ycgUbLOKWZLxb+oA85ny+
	VZ02po5lPPPf+1rMpVnmE1LYDtSs7Hrhh7mtjH/hg+8G80T+NJ/kke6Ljd6gFwUCeSggva
	lfVjk3TSk4jw3+UTA6abv1GgJYiW97A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4113EA63
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 02:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RunCB4h4XGnYBAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 02:50:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: reject single block sized compression early
Date: Tue,  6 Jan 2026 13:20:30 +1030
Message-ID: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 20D6033838
X-Spam-Flag: NO
X-Spam-Score: -3.01

Currently for an inode that needs compression, even if there is a delalloc
range that is single fs block sized and can not be inlined, we will
still go through the compression path.

Then inside compress_file_range(), we have one extra check to reject
single block sized range, and fall back to regular uncompressed write.

This rejection is in fact a little too late, we have already allocated
memory to async_chunk, delayed the submission, just to fallback to the
same uncompressed write.

Change the behavior to reject such cases earlier at
inode_need_compress(), so for such single block sized range we won't
even bother trying to go through compress path.

And since the inline small block check is inside inode_need_compress()
and compress_file_range() also calls that function, we no longer need a
dedicate check inside compress_file_range().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the duplicated check inside compress_file_range() now
  As the same check is done inside inode_need_compress() and
  compress_file_range() also call that function to do the check.
---
 fs/btrfs/inode.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cf452eaf0672..fbb8ad55b589 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 		return 0;
 	}
 
+	/*
+	 * If the delalloc range is only one fs block and can not be inlined,
+	 * do not even bother try compression, as there will be no space saving
+	 * and will always fallback to regular write later.
+	 */
+	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
+		return 0;
 	/* Defrag ioctl takes precedence over mount options and properties. */
 	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
 		return 0;
@@ -953,18 +960,8 @@ static void compress_file_range(struct btrfs_work *work)
 	if (actual_end <= start)
 		goto cleanup_and_bail_uncompressed;
 
-	total_compressed = actual_end - start;
-
-	/*
-	 * Skip compression for a small file range(<=blocksize) that
-	 * isn't an inline extent, since it doesn't save disk space at all.
-	 */
-	if (total_compressed <= blocksize &&
-	   (start > 0 || end + 1 < inode->disk_i_size))
-		goto cleanup_and_bail_uncompressed;
-
-	total_compressed = min_t(unsigned long, total_compressed,
-			BTRFS_MAX_UNCOMPRESSED);
+	total_compressed = min_t(unsigned long, actual_end - start,
+				 BTRFS_MAX_UNCOMPRESSED);
 	total_in = 0;
 	ret = 0;
 
-- 
2.52.0


