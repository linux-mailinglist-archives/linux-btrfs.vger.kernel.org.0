Return-Path: <linux-btrfs+bounces-11853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021EA45AB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0471895396
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344626F466;
	Wed, 26 Feb 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QY0Fp5X1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QY0Fp5X1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CC2459C3
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563497; cv=none; b=aVXGZtaoEADVDU+xWUMu6mOxbLouqCrpD29sSHuxJIz3ju8B265RP9PukayD1u6lPY8HfB9JxDv9oOCN5FM86yq5kCZf3bElW6lHqBEMI8fVdaSRzaU+LL/PjRaSVe7JqsPWpZH/oRagopODEcdcoNSSWL8x+sFdG6cKwJdUeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563497; c=relaxed/simple;
	bh=o/06yCFDg9j1pSkJ3R+EghDOeSdSvKyJJTJE9pStoDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO42gkZClKqiDZdwsMDpTdSG8Ra2t6DJOIlwvzGlMAzIZAqqtQ0Yl+b9swOSxWWsfcGY4WO6i+WKY3gpMNHJ1lsNUHoL/uoyHydHmDQga2pkyXTAifp8bmKmNdQv29vlNtRpzrIWJKFfGCJmz08eNfgn332QXKVaJ75bm1KRSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QY0Fp5X1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QY0Fp5X1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3489B21163;
	Wed, 26 Feb 2025 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rssPZAHP+4bW7W49NRJzUysIvS6YWH6NtyxgagIdPHc=;
	b=QY0Fp5X1pr1fxF+/3gNmQ98iB/mGldv/9EwFZ3nz4tZ0SnFZs7L96zs7m+b5+IfuGj0FaA
	FE4jPhVDpLpprK2E/UYd2bUaTlO4wno+JW42ZDeuqee7G470IgWjvFjUwhmSiyx49MRYK4
	ReHV0k5phXQ+kBbSXcy5878Roqsu1lI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rssPZAHP+4bW7W49NRJzUysIvS6YWH6NtyxgagIdPHc=;
	b=QY0Fp5X1pr1fxF+/3gNmQ98iB/mGldv/9EwFZ3nz4tZ0SnFZs7L96zs7m+b5+IfuGj0FaA
	FE4jPhVDpLpprK2E/UYd2bUaTlO4wno+JW42ZDeuqee7G470IgWjvFjUwhmSiyx49MRYK4
	ReHV0k5phXQ+kBbSXcy5878Roqsu1lI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2307713A53;
	Wed, 26 Feb 2025 09:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DdSLCCDkvmdHYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/27] btrfs: use BTRFS_PATH_AUTO_FREE in run_delayed_extent_op()
Date: Wed, 26 Feb 2025 10:51:27 +0100
Message-ID: <0839c94456a4caaceeca12742477f390b78fbeac.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
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

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9c1bd8831e83..f4ddef135851 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1626,7 +1626,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root;
 	struct btrfs_key key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_extent_item *ei;
 	struct extent_buffer *leaf;
 	u32 item_size;
@@ -1657,7 +1657,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 again:
 	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
 	if (ret < 0) {
-		goto out;
+		return ret;
 	} else if (ret > 0) {
 		if (metadata) {
 			if (path->slots[0] > 0) {
@@ -1683,7 +1683,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 			btrfs_err(fs_info,
 		  "missing extent item for extent %llu num_bytes %llu level %d",
 				  head->bytenr, head->num_bytes, head->level);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -1696,13 +1696,12 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 			  "unexpected extent item size, has %u expect >= %zu",
 			  item_size, sizeof(*ei));
 		btrfs_abort_transaction(trans, ret);
-		goto out;
+		return ret;
 	}
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	__run_delayed_extent_op(extent_op, leaf, ei);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


