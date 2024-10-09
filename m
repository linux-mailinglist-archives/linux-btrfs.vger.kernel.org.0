Return-Path: <linux-btrfs+bounces-8713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE9D996DF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF692835ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66401A303E;
	Wed,  9 Oct 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QISR8BRW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QISR8BRW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DE1A263F
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484320; cv=none; b=jqL39h1VahEabReAGFzXnZXGONvQJrsNxxXKLGE4AD6ZCCeqP2a6dp+faoULL1v3QWfovhqADGrEAJDCgVjFjGXneKOzJG3g1bkP1QTCKFxNXfv2bmcbXZIyWFDZAPkyKSVrfS28bFKeyY+SZPCuCgQk/oJuRbzI0zaHi2Xs6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484320; c=relaxed/simple;
	bh=I5Z03UKj/NcQmXDNQNLAvBmmh3AG6p8XVAR9dBByZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6y6D1+kXvUs5ZeRgZxH84wLm5sxlFSR7MaAekGxXL+DZM0PldBFZjGfd2RXk00oWiS3n3kl55XB92gNNku/eLTV4h00BqWmPCRt8iWUiFwwSnqCdH0E0c8PrfHBbuvQEcEtt8ibHTLU3mu8Jnmdf3kj+r2lweIFFGa212PK+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QISR8BRW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QISR8BRW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 832C91F7C8;
	Wed,  9 Oct 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9obhORMzhzfNHpqpF8YZ+T1N6eDSEjgJgoAnxio9GA=;
	b=QISR8BRWj2B/IT3fWiemzt+a1YlCdzumE9kHZvo8NyZYuDOwXbB6C9KF7JIjwC+6y8alFW
	tpA4jcYLpioSPsafoUo3RBL7PyLFZcQf7lamGlONhed05nGrBbwrBHllbbe2S160M/DxyJ
	gvByG2yd+Gl/CwKgsUbUSZHtfFUBZnI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9obhORMzhzfNHpqpF8YZ+T1N6eDSEjgJgoAnxio9GA=;
	b=QISR8BRWj2B/IT3fWiemzt+a1YlCdzumE9kHZvo8NyZYuDOwXbB6C9KF7JIjwC+6y8alFW
	tpA4jcYLpioSPsafoUo3RBL7PyLFZcQf7lamGlONhed05nGrBbwrBHllbbe2S160M/DxyJ
	gvByG2yd+Gl/CwKgsUbUSZHtfFUBZnI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CA10136BA;
	Wed,  9 Oct 2024 14:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uAlqHtyTBmdlRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/25] btrfs: drop unused parameter refs from visit_node_for_delete()
Date: Wed,  9 Oct 2024 16:31:56 +0200
Message-ID: <5e1469e3a3e591b1e7e5563d20d730e8a46844a7.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The parameter duplicates what can be effectively obtained from
wc->refs[level - 1] and this is what's actually used inside. Added in
commit 2b73c7e761c4 ("btrfs: unify logic to decide if we need to walk
down into a node during snapshot delete").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 79373f0ab6ce..e29024c66edb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5270,7 +5270,7 @@ struct walk_control {
  * corrupted file systems must have been caught before calling this function.
  */
 static bool visit_node_for_delete(struct btrfs_root *root, struct walk_control *wc,
-				  struct extent_buffer *eb, u64 refs, u64 flags, int slot)
+				  struct extent_buffer *eb, u64 flags, int slot)
 {
 	struct btrfs_key key;
 	u64 generation;
@@ -5384,7 +5384,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 			continue;
 
 		/* If we don't need to visit this node don't reada. */
-		if (!visit_node_for_delete(root, wc, eb, refs, flags, slot))
+		if (!visit_node_for_delete(root, wc, eb, flags, slot))
 			continue;
 reada:
 		btrfs_readahead_node_child(eb, slot);
@@ -5737,8 +5737,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	/* If we don't have to walk into this node skip it. */
 	if (!visit_node_for_delete(root, wc, path->nodes[level],
-				   wc->refs[level - 1], wc->flags[level - 1],
-				   path->slots[level]))
+				   wc->flags[level - 1], path->slots[level]))
 		goto skip;
 
 	/*
-- 
2.45.0


