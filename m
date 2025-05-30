Return-Path: <linux-btrfs+bounces-14322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E9AC934E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91FA20F4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6E1A8F6D;
	Fri, 30 May 2025 16:17:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BC2E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621848; cv=none; b=pLBaKHoTRwa2JJh1DB3gq87mhVRAZqqifcZWe6w30XvLWgVuF1Kj1hhKDCloVP+qTfX4UmLl0hgxv4C9psbO3emiykQAU+EUZTMQFRke2XUwwLzbNAltS/UCs1IbzZLkBtVAs3Aly+Yg6WzG+eR16enQabII+e1EkIOWnG0c3QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621848; c=relaxed/simple;
	bh=RacwDWWVNvJp6hfq9TBgwFcCWA0/6yqW38mCpKNTnj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taMSFbWW33z/G/c+UOvjNDS3z1J131xcl2ve21UDAS3LM6OPwe1WNYlPL7LvWHM5/z1tf6aSDQjm2jsx6Fx4O14btTL11WkonshPunD62TXJiDK+npWXiVO7AQ+TNM60E9nugR4vYYNVpMU5uLU2zHaJUVn4QPa28z6OroCQ360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E205421A84;
	Fri, 30 May 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB3A613889;
	Fri, 30 May 2025 16:17:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fBaDNRTaOWh7ZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/22] btrfs: rename err to ret2 in btrfs_search_slot()
Date: Fri, 30 May 2025 18:17:24 +0200
Message-ID: <2fe9ee332bb2daa83094d4a014af51d53e42a180.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E205421A84
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

Unify naming of return value to the preferred way, move the variable to
the closest scope.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0f0a69c8259d..ce4e9055153a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1992,7 +1992,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	struct extent_buffer *b;
 	int slot;
 	int ret;
-	int err;
 	int level;
 	int lowest_unlock = 1;
 	/* everything at write_lock_level or lower must be write locked */
@@ -2063,6 +2062,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	while (b) {
 		int dec = 0;
+		int ret2;
 
 		level = btrfs_header_level(b);
 
@@ -2091,16 +2091,15 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 
 			if (last_level)
-				err = btrfs_cow_block(trans, root, b, NULL, 0,
-						      &b,
-						      BTRFS_NESTING_COW);
+				ret2 = btrfs_cow_block(trans, root, b, NULL, 0,
+						       &b, BTRFS_NESTING_COW);
 			else
-				err = btrfs_cow_block(trans, root, b,
-						      p->nodes[level + 1],
-						      p->slots[level + 1], &b,
-						      BTRFS_NESTING_COW);
-			if (err) {
-				ret = err;
+				ret2 = btrfs_cow_block(trans, root, b,
+						       p->nodes[level + 1],
+						       p->slots[level + 1], &b,
+						       BTRFS_NESTING_COW);
+			if (ret2) {
+				ret = ret2;
 				goto done;
 			}
 		}
@@ -2148,12 +2147,12 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			slot--;
 		}
 		p->slots[level] = slot;
-		err = setup_nodes_for_search(trans, root, p, b, level, ins_len,
-					     &write_lock_level);
-		if (err == -EAGAIN)
+		ret2 = setup_nodes_for_search(trans, root, p, b, level, ins_len,
+					      &write_lock_level);
+		if (ret2 == -EAGAIN)
 			goto again;
-		if (err) {
-			ret = err;
+		if (ret2) {
+			ret = ret2;
 			goto done;
 		}
 		b = p->nodes[level];
@@ -2179,11 +2178,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			goto done;
 		}
 
-		err = read_block_for_search(root, p, &b, slot, key);
-		if (err == -EAGAIN && !p->nowait)
+		ret2 = read_block_for_search(root, p, &b, slot, key);
+		if (ret2 == -EAGAIN && !p->nowait)
 			goto again;
-		if (err) {
-			ret = err;
+		if (ret2) {
+			ret = ret2;
 			goto done;
 		}
 
-- 
2.47.1


