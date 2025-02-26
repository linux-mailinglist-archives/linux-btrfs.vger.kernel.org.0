Return-Path: <linux-btrfs+bounces-11862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A360A45AC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F027A930C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002892459D5;
	Wed, 26 Feb 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oqEmIZa5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oqEmIZa5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A524DFF6
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563524; cv=none; b=m1xB1KULLmHT+vQNr86y+b/6M9g8+2z74iufmGbo2KndYGSZr/RHc9pL39Ws8ixciGgqmH2U+ccrHsX+YtMcXT2s/Grils2VlpgYmGgfhV2YG2AQ0pqRHUtlIGzoj7Q92cdyOd+4Q1EWd0aH7Om8V6AI3EgBtMyL//x3rxrYhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563524; c=relaxed/simple;
	bh=T0i4OQEjNpNvyUFjc055Ta1+r/N/Hi3AbcJV11eqGg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDeD+8mFXcYqw2rPH+7iws7A4mK4KQxVyXHaFdZ48OBlGLWVCTOAEhA4XDiDsfS19d98BiqHil//5zsJLoslhm7ogEPsU2I5CO0ocxl8LKsd8lYCBaKHGC7bQ6u0KNq0Kcs1gGfRv3lpOM+4p3ISgxbSO91ZPwjSRWyg8n9r8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oqEmIZa5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oqEmIZa5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 628811F394;
	Wed, 26 Feb 2025 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKUVnOJnMTYCRxJGO1l8gs9ZREpk7spPvY9nYjNbUqY=;
	b=oqEmIZa5BQWxx5MYsAgwzfe8iK03aeF7SqeX28KOzJlq5Wnsny+JJmOwQp9WjeZVPZuuHO
	VPhX7S67PoDeEDPlnrnZElg+zStqKSroVJGg+EkWjW3Oa9LlFTmx+8fDqjQ0o0lckYmShe
	jmP9UR1okyZouagLKkUi5moGXuff4ps=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKUVnOJnMTYCRxJGO1l8gs9ZREpk7spPvY9nYjNbUqY=;
	b=oqEmIZa5BQWxx5MYsAgwzfe8iK03aeF7SqeX28KOzJlq5Wnsny+JJmOwQp9WjeZVPZuuHO
	VPhX7S67PoDeEDPlnrnZElg+zStqKSroVJGg+EkWjW3Oa9LlFTmx+8fDqjQ0o0lckYmShe
	jmP9UR1okyZouagLKkUi5moGXuff4ps=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59BBF13A53;
	Wed, 26 Feb 2025 09:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vefoFRvkvmdAYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_extent_info()
Date: Wed, 26 Feb 2025 10:51:23 +0100
Message-ID: <92905c7710b87afbfae3a1f9dbe3582b23d8ff7e.1740562070.git.dsterba@suse.com>
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e62ab4eaa6ff..f0dbb96651d6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -100,7 +100,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root;
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	u64 num_refs;
 	u64 extent_flags;
@@ -131,7 +131,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 	extent_root = btrfs_extent_root(fs_info, bytenr);
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out_free;
+		return ret;
 
 	if (ret > 0 && key.type == BTRFS_METADATA_ITEM_KEY) {
 		if (path->slots[0]) {
@@ -156,7 +156,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			"unexpected extent item size, has %u expect >= %zu",
 				  item_size, sizeof(*ei));
 			btrfs_abort_transaction(trans, ret);
-			goto out_free;
+			return ret;
 		}
 
 		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
@@ -167,7 +167,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		"unexpected zero reference count for extent item (%llu %u %llu)",
 				  key.objectid, key.type, key.offset);
 			btrfs_abort_transaction(trans, ret);
-			goto out_free;
+			return ret;
 		}
 		extent_flags = btrfs_extent_flags(leaf, ei);
 		owner = btrfs_get_extent_owner_root(fs_info, leaf, path->slots[0]);
@@ -213,8 +213,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 		*flags = extent_flags;
 	if (owning_root)
 		*owning_root = owner;
-out_free:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.47.1


