Return-Path: <linux-btrfs+bounces-16841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA835B587FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679E72075E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 23:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4C2C0F87;
	Mon, 15 Sep 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="htUh9oVX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="htUh9oVX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997F18DF9D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977468; cv=none; b=b7RgG82Ng55J+pjt9mN8WMFk+jarTtdR5rUlU6jFCGmq6iKJBD00iUx0Bm5K7q9N2M/R2cJ1j4/JiqqBdNGYU0qYD+baDVswNKLSUo+OMFgR4ZCD986KqxIzlJ+NZZ+9I8BGRuHHzt/6ISt3rmBdkJaXrc/GTclX4c+037bpYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977468; c=relaxed/simple;
	bh=xbPAjtAK2XA1xkpg8/9/wi9FTXhMvfsG+znT+e86HBM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dERMOhz1JHiBaeoD2Fw6HtaHeNRrWU8n8Fw3CgA+0lbW7bOLDaU+LlPNsvVqa1zMer1vlO6xTKyMJPT+zKOivLV1TkwnIrRLe5w8SjlzFbSjLOYGJKSB4+dfocB8cqK+Zj/cSMs2DwPX2QmbWeOo/ugtLnTT/PljeBUFS8RrKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=htUh9oVX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=htUh9oVX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5048E2235C
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757977464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tCngDwR6hPLjdtqUQaiTSGDNFfTOHoOfx7Ery0aUAmY=;
	b=htUh9oVXHmmlSlGX78xTW10OpM+uzSuXgZcZYpGz11pc9uygFaeRa19BfiHJuoe12IdU5k
	u1FoGsa6tFqWBARcPmrY00Q04c8BUN9RTFjJZpw1dA3Z36lPKdscD+JoRRL1TUlNqJaeLr
	jaVfz38mscdzoNF15PVq1lIk5w881l0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=htUh9oVX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757977464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tCngDwR6hPLjdtqUQaiTSGDNFfTOHoOfx7Ery0aUAmY=;
	b=htUh9oVXHmmlSlGX78xTW10OpM+uzSuXgZcZYpGz11pc9uygFaeRa19BfiHJuoe12IdU5k
	u1FoGsa6tFqWBARcPmrY00Q04c8BUN9RTFjJZpw1dA3Z36lPKdscD+JoRRL1TUlNqJaeLr
	jaVfz38mscdzoNF15PVq1lIk5w881l0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8779E1368D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HX0EXebyGhSAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:04:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: add inode extref checks
Date: Tue, 16 Sep 2025 08:34:05 +0930
Message-ID: <bce5bcbbb1f0bb0b6b10700714ef7169f7d57082.1757977422.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5048E2235C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Like inode refs, inode extrefs have a variable length name, which means
we have to do a proper check to make sure no header nor name can exceed
the item limits.

The check itself is very similar to check_inode_ref(), just a different
structure (btrfs_inode_extref vs btrfs_inode_ref).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c2aac08055fb..ca30b15ea452 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -183,6 +183,7 @@ static bool check_prev_ino(struct extent_buffer *leaf,
 	/* Only these key->types needs to be checked */
 	ASSERT(key->type == BTRFS_XATTR_ITEM_KEY ||
 	       key->type == BTRFS_INODE_REF_KEY ||
+	       key->type == BTRFS_INODE_EXTREF_KEY ||
 	       key->type == BTRFS_DIR_INDEX_KEY ||
 	       key->type == BTRFS_DIR_ITEM_KEY ||
 	       key->type == BTRFS_EXTENT_DATA_KEY);
@@ -1782,6 +1783,39 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_inode_extref(struct extent_buffer *leaf,
+			      struct btrfs_key *key, struct btrfs_key *prev_key,
+			      int slot)
+{
+	unsigned long ptr = btrfs_item_ptr_offset(leaf, slot);
+	unsigned long end = ptr + btrfs_item_size(leaf, slot);
+
+	if (unlikely(!check_prev_ino(leaf, key, slot, prev_key)))
+		return -EUCLEAN;
+
+	while (ptr < end) {
+		struct btrfs_inode_extref *extref = (struct btrfs_inode_extref *)ptr;
+		u16 namelen;
+
+		if (unlikely(ptr + sizeof(*extref)) > end) {
+			inode_ref_err(leaf, slot,
+			"inode extref overflow, ptr %lu end %lu inode_extref size %zu",
+				      ptr, end, sizeof(*extref));
+			return -EUCLEAN;
+		}
+
+		namelen = btrfs_inode_extref_name_len(leaf, extref);
+		if (unlikely(ptr + sizeof(*extref) + namelen > end)) {
+			inode_ref_err(leaf, slot,
+				"inode extref overflow, ptr %lu end %lu namelen %u",
+				ptr, end, namelen);
+			return -EUCLEAN;
+		}
+		ptr += sizeof(*extref) + namelen;
+	}
+	return 0;
+}
+
 static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 				    const struct btrfs_key *key, int slot)
 {
@@ -1893,6 +1927,9 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_INODE_REF_KEY:
 		ret = check_inode_ref(leaf, key, prev_key, slot);
 		break;
+	case BTRFS_INODE_EXTREF_KEY:
+		ret = check_inode_extref(leaf, key, prev_key, slot);
+		break;
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(leaf, key, slot);
 		break;
-- 
2.50.1


