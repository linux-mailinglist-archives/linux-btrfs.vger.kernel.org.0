Return-Path: <linux-btrfs+bounces-22275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM1KMmvsq2lYiAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22275-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030E22AD63
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 264A93025E78
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Mar 2026 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740F389443;
	Sat,  7 Mar 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VGHhjo3+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VGHhjo3+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D323876B1
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874851; cv=none; b=fUv1UzEcDTSyTAjUV/xl7n2JMS6ZMmzvwT9jwT46yUGm70+4eUKp/DoRE9iTbyzncd23+oVhSqXOpe3Y8QJ4TqMNjp+FvwDfvBkjIlHeHAsIuWv63bErj/M+CWZglN3oFqwdD6SJ7tPN5tu/B9RjrmK9xwe+7iDBRQfumo3nQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874851; c=relaxed/simple;
	bh=k2KRxaXzEss1TEwlPiaybFIhxIY0TT32vF4DU9Uaipw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXAcMlItDoBBr1gkBJe1u92qiYdU0Wf6+bBjBDsmtWHNmHBDYkTNnKGiZUGyIltwe/QqHTq/2peAF9UUStCSBFm5HjGulebVrPYVJzb9K3AWkdK8ViHiiptV58Pi2q4/tnwy5gv8TlX1dwDWcgh3WqhkDe4sO4UNVD053esHSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VGHhjo3+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VGHhjo3+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C3003FCF9
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H03fczRNnDH0gQZRkj4yi9zOW30CG8yW905/cem5Cyk=;
	b=VGHhjo3+yMfYRddJaC1bmSw8+MjX+GJTr0ELuAwdM4XkUwI2VX6T4sTkhZ80AwcoWcU2cZ
	FSEHeXboflgOEnLFCWwWvSystRyb33FY9ATnm2J7HucbklTJ3UPsjENQmFDPhkGgVZzQ9N
	2nTBgXLCaQT5dNaFEqOUBUNLRgy7gOQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H03fczRNnDH0gQZRkj4yi9zOW30CG8yW905/cem5Cyk=;
	b=VGHhjo3+yMfYRddJaC1bmSw8+MjX+GJTr0ELuAwdM4XkUwI2VX6T4sTkhZ80AwcoWcU2cZ
	FSEHeXboflgOEnLFCWwWvSystRyb33FY9ATnm2J7HucbklTJ3UPsjENQmFDPhkGgVZzQ9N
	2nTBgXLCaQT5dNaFEqOUBUNLRgy7gOQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A37143EA61
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +E1zGVXsq2kkLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Mar 2026 09:13:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: output more info when duplicated ordered extent is found
Date: Sat,  7 Mar 2026 19:43:37 +1030
Message-ID: <9568c0c9f72806be005a8ab7c35201229518af2b.1772874800.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772874800.git.wqu@suse.com>
References: <cover.1772874800.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4030E22AD63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22275-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

During development of a new feature, I triggered that btrfs_panic()
inside insert_ordered_extent() and spent quite some unnecessary before
noticing I'm passing incorrect flags when creating a new ordered extent.

Unfortunately the existing error message is not providing much help.

Enhance the output to provide file offset, num bytes and flags of both
existing and new ordered extents.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b34a0df282f3..bc88b904d024 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -253,10 +253,15 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
 	spin_lock(&inode->ordered_tree_lock);
 	node = tree_insert(&inode->ordered_tree, entry->file_offset,
 			   &entry->rb_node);
-	if (unlikely(node))
+	if (unlikely(node)) {
+		struct btrfs_ordered_extent *exist =
+			rb_entry(node, struct btrfs_ordered_extent, rb_node);
+
 		btrfs_panic(fs_info, -EEXIST,
-				"inconsistency in ordered tree at offset %llu",
-				entry->file_offset);
+"existing oe file_offset=%llu num_bytes=%llu flags=0x%lx new oe file_offset=%llu num_bytes=%llu flags=0x%lx",
+			    exist->file_offset, exist->num_bytes, exist->flags,
+			    entry->file_offset, entry->num_bytes, entry->flags);
+	}
 	spin_unlock(&inode->ordered_tree_lock);
 
 	spin_lock(&root->ordered_extent_lock);
-- 
2.53.0


