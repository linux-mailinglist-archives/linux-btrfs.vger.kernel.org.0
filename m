Return-Path: <linux-btrfs+bounces-13558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CAAA5208
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAED3AC5B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB22641E2;
	Wed, 30 Apr 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jE8f+OSp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jE8f+OSp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFE1DD0C7
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031810; cv=none; b=fbnCAPVQNSph/v3u5DIykPK7vxjiBXTuIUSvRUr758HXT2g+7CNRBruVmkvILlPSsd/9w3FT5XpJQC1egmR/8Z8hH3b7582it+WWqPvV1JloxEeS1t2i5nuECp7TSfOXndtUxtekti2g3ivu3yKK0RXfeVVIhRc5a3nCzPbmPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031810; c=relaxed/simple;
	bh=6uCdJfvfXwiG6wnwGnmc1dlLaLER9yEc55FzRWn5xM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhB156NIeN4Z1SVTFHIA8EoidYoF7pgbj9r9IneFI68jaqLUSQ1pXYQSxuYAPgNQz8NZ+copzzvoRiYPQ8/jQu+gerWAFR037dfdalnzEbih4p5V8XdawYO57r7CNqpI1DiTd5YMIjKCjiXYX1Okpv7gwv5BMLWLX/PCF868TvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jE8f+OSp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jE8f+OSp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD465211CB;
	Wed, 30 Apr 2025 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhJKh3Q/8Ty7q0Hznb9VbqrAxq4Bbhf9caoRD+Mjhg4=;
	b=jE8f+OSpBoxSpct0jiMuiiQoMWfM0vBAJm6ypOuolv6BSvsl2Q7vbNJn0dTpmrkIpmeiom
	8FTDAR4OH4G9LWGtA/oslZ+PpTuuGonXqb6oOgC35mo+Lfo2OUE8L/5ywr5oX/eG8+5u5L
	kKe8qy/54XfVOlrWFj6i8zIQZ9LEiHg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jE8f+OSp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746031805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhJKh3Q/8Ty7q0Hznb9VbqrAxq4Bbhf9caoRD+Mjhg4=;
	b=jE8f+OSpBoxSpct0jiMuiiQoMWfM0vBAJm6ypOuolv6BSvsl2Q7vbNJn0dTpmrkIpmeiom
	8FTDAR4OH4G9LWGtA/oslZ+PpTuuGonXqb6oOgC35mo+Lfo2OUE8L/5ywr5oX/eG8+5u5L
	kKe8qy/54XfVOlrWFj6i8zIQZ9LEiHg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5C55139E7;
	Wed, 30 Apr 2025 16:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nUR0KL1UEmj9MwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 30 Apr 2025 16:50:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: move transaction aborts to the error site in convert_free_space_to_bitmaps()
Date: Wed, 30 Apr 2025 18:45:18 +0200
Message-ID: <b3e2d29dd82f7e895f80d48ac77c44377d235ac8.1746031378.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746031378.git.dsterba@suse.com>
References: <cover.1746031378.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD465211CB
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Transaction aborts should be done next to the place the error happens,
which was not done in convert_free_space_to_bitmaps(). The DEBUG_WARN()
is removed because we get the abort message.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index ef62f3a69267f3..b5458a71f0b3e8 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -223,6 +223,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -235,8 +236,10 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 
 	while (!done) {
 		ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 
 		leaf = path->nodes[0];
 		nr = 0;
@@ -271,14 +274,17 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		}
 
 		ret = btrfs_del_items(trans, root, path, path->slots[0], nr);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 		btrfs_release_path(path);
 	}
 
 	info = search_free_space_info(trans, block_group, path, 1);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 	leaf = path->nodes[0];
@@ -293,8 +299,8 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 			  "incorrect extent count for %llu; counted %u, expected %u",
 			  block_group->start, extent_count,
 			  expected_extent_count);
-		DEBUG_WARN();
 		ret = -EIO;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
@@ -315,8 +321,10 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key,
 					      data_size);
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto out;
+		}
 
 		leaf = path->nodes[0];
 		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
@@ -331,8 +339,6 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	ret = 0;
 out:
 	kvfree(bitmap);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.49.0


