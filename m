Return-Path: <linux-btrfs+bounces-19105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C7C6A846
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 98E5D2BCA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8636B056;
	Tue, 18 Nov 2025 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XDR1rTrw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tbtVxzrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5836B04E
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482150; cv=none; b=KPj5weenthDNSFqagWJD7HdkFt2m0bSbwn9AnvNIq+mm7T/Y1LAXL1bm/Da6m8DlHxOvy1rYVGyqqUM+ED9+/0YTObA+gA6gpaROJfF8Jyvp1Y4b0YY6C7dolgeB+1seWpO+5SmPAqitDXPjNqiYI8fzV3/LNTtfzht5PJRdsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482150; c=relaxed/simple;
	bh=EqBXRxLaT5bXn9isFY1BGIkHkrg2gtWCsErmndXmkfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb9lcOb4DMrt2RZmGmJypfgJNq+GErM1SZVvh6HEkXo0VO4ZgBcGEVOPUWnAqVYqYw/fMfB6CX8KkuLI6p7X5vqEIZEgKlu63dP2s4G40E0xAspDglaNG5QasOa+oOKO/EXhOy46ZfoPRaP7Rfq5uBA1Is2ue0S2JEWxqYFwAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XDR1rTrw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tbtVxzrG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E64052126E;
	Tue, 18 Nov 2025 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGiyHM236mKp4HMdnwwzVRNs3LJ5NzSkeXvprHlui7E=;
	b=XDR1rTrw9UICaG8Gyc/NWxVpJ2akZ7338YXWmJgyiwb+yrNeDIdnBOLP0uMxvBIw+TK8+6
	OBNrNIP9WOEV0ol6FQHcZk65EQ6OQtIRmPBPElsKp1uvKqOFP1Ro9P7G8GYppd5ukgj2cQ
	W+kIsnJ0aED8wwmt1bOJiaE0IOVZ3eM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763482134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGiyHM236mKp4HMdnwwzVRNs3LJ5NzSkeXvprHlui7E=;
	b=tbtVxzrGcvbSvS+Jp/kA0lL1MmQUjWCxMxJahubj7//pS3zITOaA08MVEGes00iRlxuTLT
	Y8kjdkQj5IbrAS9n1RPt8fTWtA5W9jdFVykY1te8+Ytosi+cWmXSO2ginZh6BdxKjAac7D
	RgTnxrVK72Q7MBN0V0gtOwFmm6yqiLs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2BD83EA61;
	Tue, 18 Nov 2025 16:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qNjJMhaaHGlnYQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Nov 2025 16:08:54 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] btrfs: don't search back for dir inode item in INO_LOOKUP_USER
Date: Tue, 18 Nov 2025 17:08:43 +0100
Message-ID: <20251118160845.3006733-7-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118160845.3006733-1-neelx@suse.com>
References: <20251118160845.3006733-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

From: Josef Bacik <josef@toxicpanda.com>

We don't need to search back to the inode item, the directory inode
number is in key.offset, so simply use that.  If we can't find the
directory we'll get an ENOENT at the iget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c2d992f5ce7d..69df5765acfa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1822,7 +1822,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_root_ref *rref;
 	struct btrfs_root *root = NULL;
 	struct btrfs_path *path;
-	struct btrfs_key key, key2;
+	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	char *ptr;
 	int slot;
@@ -1877,24 +1877,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			read_extent_buffer(leaf, ptr,
 					(unsigned long)(iref + 1), len);
 
-			/* Check the read+exec permission of this directory */
-			ret = btrfs_previous_item(root, path, dirid,
-						  BTRFS_INODE_ITEM_KEY);
-			if (ret < 0) {
-				goto out_put;
-			} else if (ret > 0) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
-			leaf = path->nodes[0];
-			slot = path->slots[0];
-			btrfs_item_key_to_cpu(leaf, &key2, slot);
-			if (key2.objectid != dirid) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
 			/*
 			 * We don't need the path anymore, so release it and
 			 * avoid deadlocks and lockdep warnings in case
@@ -1902,11 +1884,12 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			 * btree and lock the same leaf.
 			 */
 			btrfs_release_path(path);
-			temp_inode = btrfs_iget(key2.objectid, root);
+			temp_inode = btrfs_iget(key.offset, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
+			/* Check the read+exec permission of this directory */
 			ret = inode_permission(idmap, &temp_inode->vfs_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(&temp_inode->vfs_inode);
-- 
2.51.0


