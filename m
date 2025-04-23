Return-Path: <linux-btrfs+bounces-13341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD9A995D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04212188DC80
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE2289359;
	Wed, 23 Apr 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F9Cefw7V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F9Cefw7V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D25EEAB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427268; cv=none; b=FrB7LGUkdNXBdvqo+3n5EV7r2FJQXtiD1NpMiaKtLUglCDYVpqk/C/m1WOgehRDKQoktPSVYXVtddZMzifTWsiv1/B2VKqPIIERxQCxv5X67zvr/0XmB6ZK+as0F+KQzVbHp3AqEBg2HiiLHL+ZSrDc8F4bBiZmiZWYnuAyptW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427268; c=relaxed/simple;
	bh=3or1X7h0nR3tqEbK1CDDmUyjB+e2Vu3fgtN+YZd/Y/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVnp2RVuaOQjSKgIcu0v073b0Fgdj3A3NW00ii5W7MH1SixvGlNnIPj34Lc9YLl7CFN/8W2foHI/HedqIoGAZ1xtVezcafAvj7PYwJDccYhoB2JCJ1ALmaw7CpAxu9InPJYZDDoxD/fxMEYCNFDyKx0DxxYDPbidXbnPDzk+rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F9Cefw7V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F9Cefw7V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBD2821188;
	Wed, 23 Apr 2025 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBYJcASoe9y0oeS1gTncDxWkIRGpcs7jvkEK7qqbgyw=;
	b=F9Cefw7V18Wi+RoQ/DCXoedICvcDP8aXLk4yhgwUjG8cueQ2eoLAh9FO3PJPBX2QpZiAIP
	elXbLhut2hKrbk3WEMxwoiF7IWVEuCeHfLSWJy6DWg2dSq9BHpBu+p02qHzFifGXFhbIaX
	KLtCPj5CBeli8M/2w1AFN+XsIVE8FM8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745427259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBYJcASoe9y0oeS1gTncDxWkIRGpcs7jvkEK7qqbgyw=;
	b=F9Cefw7V18Wi+RoQ/DCXoedICvcDP8aXLk4yhgwUjG8cueQ2eoLAh9FO3PJPBX2QpZiAIP
	elXbLhut2hKrbk3WEMxwoiF7IWVEuCeHfLSWJy6DWg2dSq9BHpBu+p02qHzFifGXFhbIaX
	KLtCPj5CBeli8M/2w1AFN+XsIVE8FM8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3A2313A3D;
	Wed, 23 Apr 2025 16:54:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NpvYKzsbCWhSGQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 16:54:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: reformat comments in acls_after_inode_item()
Date: Wed, 23 Apr 2025 18:53:59 +0200
Message-ID: <8f6470c838cb98fd83136e3285af6afd8b8f293b.1745426584.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745426584.git.dsterba@suse.com>
References: <cover.1745426584.git.dsterba@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3bbe348ac91e2..e18967a14d6419 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3721,10 +3721,14 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 }
 
 /*
- * very simple check to peek ahead in the leaf looking for xattrs.  If we
- * don't find any xattrs, we know there can't be any acls.
+ * Look ahead in the leaf for xattrs. If we don't find any then we know there
+ * can be any ACLs.
  *
- * slot is the slot the inode is in, objectid is the objectid of the inode
+ * @leaf:       the eb leaf where to search
+ * @slot:       the slot the inode is in
+ * @objectid:   the objectid of the inode
+ *
+ * Retrun true if there is a xattr, false otherwise.
  */
 static noinline bool acls_after_inode_item(struct extent_buffer *leaf,
 					   int slot, u64 objectid,
@@ -3748,11 +3752,11 @@ static noinline bool acls_after_inode_item(struct extent_buffer *leaf,
 	while (slot < nritems) {
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
-		/* we found a different objectid, there must not be acls */
+		/* We found a different objectid, there must be no ACLs. */
 		if (found_key.objectid != objectid)
 			return false;
 
-		/* we found an xattr, assume we've got an acl */
+		/* We found an xattr, assume we've got an ACL. */
 		if (found_key.type == BTRFS_XATTR_ITEM_KEY) {
 			if (*first_xattr_slot == -1)
 				*first_xattr_slot = slot;
@@ -3762,8 +3766,8 @@ static noinline bool acls_after_inode_item(struct extent_buffer *leaf,
 		}
 
 		/*
-		 * we found a key greater than an xattr key, there can't
-		 * be any acls later on
+		 * We found a key greater than an xattr key, there can't be any
+		 * ACLs later on.
 		 */
 		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
 			return false;
@@ -3772,17 +3776,22 @@ static noinline bool acls_after_inode_item(struct extent_buffer *leaf,
 		scanned++;
 
 		/*
-		 * it goes inode, inode backrefs, xattrs, extents,
-		 * so if there are a ton of hard links to an inode there can
-		 * be a lot of backrefs.  Don't waste time searching too hard,
-		 * this is just an optimization
+		 * The item order goes like:
+		 * - inode
+		 * - inode backrefs
+		 * - xattrs
+		 * - extents,
+		 *
+		 * so if there are lots of hard links to an inode there can be
+		 * a lot of backrefs.  Don't waste time searching too hard,
+		 * this is just an optimization.
 		 */
 		if (scanned >= 8)
 			break;
 	}
-	/* we hit the end of the leaf before we found an xattr or
-	 * something larger than an xattr.  We have to assume the inode
-	 * has acls
+	/*
+	 * We hit the end of the leaf before we found an xattr or something
+	 * larger than an xattr.  We have to assume the inode has ACLs.
 	 */
 	if (*first_xattr_slot == -1)
 		*first_xattr_slot = slot;
-- 
2.49.0


