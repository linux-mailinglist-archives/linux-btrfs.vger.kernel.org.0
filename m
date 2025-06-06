Return-Path: <linux-btrfs+bounces-14535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ECBAD07BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016C51897C41
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CB2147FB;
	Fri,  6 Jun 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sxRXkw8R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sxRXkw8R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DFBA38
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232220; cv=none; b=Y0jcG0Dp6DLvkznVq61olVBONc8E7kt8z61LB8n3km6If7q7psHJcpVP+dj9yVmyyvZt6iCVpCG8fUoeiwLhkl2N5cttZBix+MtNxoaNIMyunJeFxheNyyPSJQysMCrNSpedQ9RGGxJBZGhdZFSXn6w0D8IRwAFi10HBIIh5gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232220; c=relaxed/simple;
	bh=WC9Y/Pps0mSwgL/Q/j1rX3Qp5qSN+kS2Q1OZlGV4ffU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYG6JrZgOdyuvlNbW9z10tN50+ql9p1dDJlH4cKYq7YrMor5pnejhZGvveM61GMzuYUtgCWNrENemYfQUvBrNb5oyUHPbuiiXdhXge1okTmEnrpXmqXzllFZ3DyL8vYXY9aQSVmt3F9r9srEGBU8jkEsUwdHyECtY3SOsxwCE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sxRXkw8R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sxRXkw8R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E12641F74A;
	Fri,  6 Jun 2025 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749232215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxKW4Vh/dEFKonuC/H6mbZiL3ZMj9ChONGn0Oty3OTI=;
	b=sxRXkw8RuPv+5csTM+AFMmnbyFqOxUOJZ5x9kR2xtoN35xOSNzZN/zqjWMJxgB2iZQCe9t
	LhqGYSisDUj1lnyQERVqNfCqqfsJvOcE7Rf7jA0rXUoQv5I3s8ypk1TDfmW05cMK3BR+aJ
	qhu8Y3jeYhPkaXUCqR/O/z3JJkEfyko=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749232215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GxKW4Vh/dEFKonuC/H6mbZiL3ZMj9ChONGn0Oty3OTI=;
	b=sxRXkw8RuPv+5csTM+AFMmnbyFqOxUOJZ5x9kR2xtoN35xOSNzZN/zqjWMJxgB2iZQCe9t
	LhqGYSisDUj1lnyQERVqNfCqqfsJvOcE7Rf7jA0rXUoQv5I3s8ypk1TDfmW05cMK3BR+aJ
	qhu8Y3jeYhPkaXUCqR/O/z3JJkEfyko=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA29B1336F;
	Fri,  6 Jun 2025 17:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EKBBNVcqQ2iAVgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 06 Jun 2025 17:50:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use btrfs_root_id() where not done yet
Date: Fri,  6 Jun 2025 19:50:14 +0200
Message-ID: <20250606175014.3564308-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

A few more remaining cases where we can use the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 fs/btrfs/inode.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1c3bfb9ff025ef..b0d65a8719e6ad 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5583,7 +5583,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 		goto again;
 	}
 
-	exists = btrfs_find_delayed_tree_ref(head, root->root_key.objectid, parent);
+	exists = btrfs_find_delayed_tree_ref(head, btrfs_root_id(root), parent);
 	mutex_unlock(&head->mutex);
 out:
 	spin_unlock(&delayed_refs->lock);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 36ce8130127032..e9ba80a56172dd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1704,7 +1704,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 		btrfs_err_rl(fs_info,
 	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
-			     inode->root->root_key.objectid,
+			     btrfs_root_id(inode->root),
 			     btrfs_ino(inode), folio_pos(folio));
 		ret = -EUCLEAN;
 		goto done;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 28c162174fac6f..e3c9580b9b1aef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2881,7 +2881,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 		DEBUG_WARN();
 		btrfs_err_rl(fs_info,
 	"root %lld ino %llu folio %llu is marked dirty without notifying the fs",
-			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_root_id(BTRFS_I(inode)->root),
 			     btrfs_ino(BTRFS_I(inode)),
 			     folio_pos(folio));
 		return -EUCLEAN;
@@ -8026,7 +8026,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	generic_fillattr(idmap, request_mask, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
-	stat->subvol = BTRFS_I(inode)->root->root_key.objectid;
+	stat->subvol = btrfs_root_id(BTRFS_I(inode)->root);
 	stat->result_mask |= STATX_SUBVOL;
 
 	spin_lock(&BTRFS_I(inode)->lock);
-- 
2.49.0


