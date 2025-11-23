Return-Path: <linux-btrfs+bounces-19276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375DC7E9BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 00:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81D6A344D3B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Nov 2025 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E721D5AA;
	Sun, 23 Nov 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aBcRm4PC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aBcRm4PC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594DA15E8B
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940791; cv=none; b=Q7DyzjP3ZWY67SHz0jaCXM+d3wPF5GxtYZc+Hi6EyaaQTl4buQDjjZi0RJhLJBRoueW1fcdCPAsPvIdwTMkivOIMw3QTPVdcb1mqo47Nyxnx+t4s9oCR1sLbGgdHEVKvBdtDtezANjPNQMV9DF599TKnzAflIs1w0GYDLWt81So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940791; c=relaxed/simple;
	bh=nJPMm7yVW1zQYTEyJtOKymC4Jn7F3FrBWzUd9CYjdog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDoU84W5bL0KVdqb0Rdi059Yk9CkMCWGEAD4RWuQqoxi1/qASKKO31WVTAhF7kYyp01wdYFAGHZ4yb2GV8nzA/PRrHw44oQ8SGWn92hwC3j3/+OTgC292vI5NmF1LofAVk4l/JZw1pgXpYciqApdhJNAfTw9TILwhhnCTT33Dxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aBcRm4PC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aBcRm4PC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93C2A21D9A
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKCYwyB5GmbkHkLK//fZbKbjHa0jrJjhLsObEZ4MPZ4=;
	b=aBcRm4PCMp5+X6Dp0Pcv6pnZasjT+vsqRDGe0waKuF2FTCnDo2j5mx3iMJyKBU6cg7lpFq
	ykimfFdomOVwlEpMI+9Y47NBPmxIKq/L+TY6q0OpT0XrlTLVU5f9Qt2fTdBLsEBHyKB6P9
	f11aK6WJAAJ2k0PgvhrQI3RuBS98dlU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aBcRm4PC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763940768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKCYwyB5GmbkHkLK//fZbKbjHa0jrJjhLsObEZ4MPZ4=;
	b=aBcRm4PCMp5+X6Dp0Pcv6pnZasjT+vsqRDGe0waKuF2FTCnDo2j5mx3iMJyKBU6cg7lpFq
	ykimfFdomOVwlEpMI+9Y47NBPmxIKq/L+TY6q0OpT0XrlTLVU5f9Qt2fTdBLsEBHyKB6P9
	f11aK6WJAAJ2k0PgvhrQI3RuBS98dlU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C992C3EA62
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iI7VIp+ZI2kGRQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 23:32:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: return the largest possible hole for EOF cases
Date: Mon, 24 Nov 2025 10:02:26 +1030
Message-ID: <0f36f7e65f93fbda63a13bd57af02b439f05a4ff.1763939785.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763939785.git.wqu@suse.com>
References: <cover.1763939785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 93C2A21D9A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

If @start is beyonf EOF of the inode, btrfs_get_extent() will only
return a hole extent map that is exactly the size of @len passed in.

This will make all callers of btrfs_get_extent() map happy, as normally
they will finish the lookup.

But if btrfs_get_extent() is called again and again on ranges beyond EOF
with different ranges, we will do the same tree search again and again,
returning a hole with different ranges, without really benefiting from
the cached extent maps.

Change the EOF handling by always returning a hole for the range
[@start, @btrfs_max_file_end), so future lookup will hit the cache
without searching the tree again.

The special value btrfs_max_file_end is calcuculating by rounding up
MAX_LFS_FILESIZE to fs block size.

Currently MAX_LFS_FILESIZE is at most LLONG_MAX, but btrfs handles
internal size using u64, thus we should never hit a range that will
overflow u64.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e0dc82c4f17..39e22b8141e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7052,6 +7052,20 @@ static void set_hole_em(struct extent_map *em, u64 start, u64 len)
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 }
 
+static u64 btrfs_max_file_end(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * MAX_LFS_FILESIZE is either LLONG_MAX or LONG_MAX << PAGE_SHIFT.
+	 * LLONG_MAX is not blocksize aligned, so here we have to round it
+	 * up to the fs block size.
+	 */
+	u64 result = round_up(MAX_LFS_FILESIZE, fs_info->sectorsize);
+
+	/* Make sure rounding up MAX_LFS_FILESIZE won't overflow. */
+	ASSERT(result > 0);
+	return result;
+}
+
 /*
  * Lookup the first extent overlapping a range in a file.
  *
@@ -7077,6 +7091,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	u64 extent_start = 0;
 	u64 extent_end = 0;
 	u64 objectid = btrfs_ino(inode);
+	const u64 max_file_end = btrfs_max_file_end(fs_info);
 	int extent_type = -1;
 	struct btrfs_path *path = NULL;
 	struct btrfs_root *root = inode->root;
@@ -7137,7 +7152,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 			 * This means even no inode item for the inode.
 			 * Thus the whole range should be a hole.
 			 */
-			set_hole_em(em, start, len);
+			set_hole_em(em, start, max_file_end - start);
 			goto insert;
 		}
 		path->slots[0]--;
@@ -7189,7 +7204,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				goto out;
 			if (ret > 0) {
 				/* EOF, thus a hole. */
-				set_hole_em(em, start, len);
+				set_hole_em(em, start, max_file_end - start);
 				goto insert;
 			}
 
@@ -7199,7 +7214,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		if (found_key.objectid != objectid ||
 		    found_key.type != BTRFS_EXTENT_DATA_KEY) {
 			/* EOF, thus a hole. */
-			set_hole_em(em, start, len);
+			set_hole_em(em, start, max_file_end - start);
 			goto insert;
 		}
 		if (start > found_key.offset)
-- 
2.52.0


